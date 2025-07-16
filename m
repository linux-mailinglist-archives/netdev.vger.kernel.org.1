Return-Path: <netdev+bounces-207482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03EB07849
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EAA7B842D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC225C810;
	Wed, 16 Jul 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q94mj1Pi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634126057A
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676733; cv=none; b=JMUU4HXsfxqeIfedr/hoj6bx9j926AGHVSOmCJGz/n5ZL1SaFTr6+JjQh84O9IbWn+U1zgy5gV4vz/MqO2Zv8C20nWo89kJ4VPmwwGse961NddfoiYA/fCH6ekKqaKnR9aNdsoKrMOFpU76CnbvlC4Cd9HiQLKoUdlexraSFy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676733; c=relaxed/simple;
	bh=IMJWkGnLWAoHHACStORaqYMu+6knT/PMv1odls4h4Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTGR02H1RZ5UhxpxJF4xpqm8ZkOK84zf3oXkRQvaB4ZtDypj1YS7NCxbplIX1Pq7+Qnwok64O8VSnMuqlJh0Q0Bn+PhSmI3C97XfcytX7Kywv8IJHgVB1/mUApfi3+3O9W2gle21a9ovSSpVB/Y33QtynOqEVAo1YQikSgpOp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q94mj1Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC2C4CEE7;
	Wed, 16 Jul 2025 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676733;
	bh=IMJWkGnLWAoHHACStORaqYMu+6knT/PMv1odls4h4Dc=;
	h=From:To:Cc:Subject:Date:From;
	b=Q94mj1PiokQuzRCKtKf3tPwdIgdAtyPBoSp0rAZl5ruIlJ9Gd2aRMJqYLwQmLWCDO
	 UDLf40qEml6isXcGRPDiUxgqNtfbDifw/3wJsgx5jV9yEK6J3Yons0a9KknO4WchoR
	 tSUuz83e/r7SzjWyvi71PjAqervRicXJ+v9UdIwoxayFeh4xSzKbzDiIF4batHfX9y
	 uOQ0yx9UhATJoWuTbiOtjMLynh60fVKycuQzMIct1KcQVEIoi9iEpgvY//Kf6oiqLJ
	 cb4WwGDejOhRkcmAKcsPJPM4PV15SXWLuQmNYYTuuFcq88HsVIMqDoQyikOR8T01ov
	 vF6lC816nLFHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: [PATCH net] tls: always refresh the queue when reading sock
Date: Wed, 16 Jul 2025 07:38:50 -0700
Message-ID: <20250716143850.1520292-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After recent changes in net-next TCP compacts skbs much more
aggressively. This unearthed a bug in TLS where we may try
to operate on an old skb when checking if all skbs in the
queue have matching decrypt state and geometry.

    BUG: KASAN: slab-use-after-free in tls_strp_check_rcv+0x898/0x9a0 [tls]
    (net/tls/tls_strp.c:436 net/tls/tls_strp.c:530 net/tls/tls_strp.c:544)
    Read of size 4 at addr ffff888013085750 by task tls/13529

    CPU: 2 UID: 0 PID: 13529 Comm: tls Not tainted 6.16.0-rc5-virtme
    Call Trace:
     kasan_report+0xca/0x100
     tls_strp_check_rcv+0x898/0x9a0 [tls]
     tls_rx_rec_wait+0x2c9/0x8d0 [tls]
     tls_sw_recvmsg+0x40f/0x1aa0 [tls]
     inet_recvmsg+0x1c3/0x1f0

Always reload the queue, fast path is to have the record in the queue
when we wake, anyway (IOW the path going down "if !strp->stm.full_len").

Fixes: 0d87bbd39d7f ("tls: strp: make sure the TCP skbs do not have overlapping data")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
---
 net/tls/tls_strp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 65b0da6fdf6a..095cf31bae0b 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -512,9 +512,8 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 	if (inq < strp->stm.full_len)
 		return tls_strp_read_copy(strp, true);
 
+	tls_strp_load_anchor_with_queue(strp, inq);
 	if (!strp->stm.full_len) {
-		tls_strp_load_anchor_with_queue(strp, inq);
-
 		sz = tls_rx_msg_size(strp, strp->anchor);
 		if (sz < 0) {
 			tls_strp_abort_strp(strp, sz);
-- 
2.50.1


