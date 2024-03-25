Return-Path: <netdev+bounces-81674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC288AB31
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9601C3BF94
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B861534EA;
	Mon, 25 Mar 2024 15:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D4152E16
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382220; cv=none; b=pzeBbn8Uq5D9qxtDSFpofkES3GQD5PbDMvoLwFNZKevjeIM8ZEIi3fceiuAeXUyZCV4xlYON08dFpuC3avhGuT4cyJHs5lbzvguhRneidlxqFsi5ipUuuRrvv9hkVumoNeKXPfYIyawkuyBxPbIViTS8PGhDY4I4rVUzHF4it6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382220; c=relaxed/simple;
	bh=hBi2mR5fFUopUORGHBqnfiL4BtAwLkQXsixSqsThaMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX46BO02LaZMVDvzuKmOsLgXs92kon1KUkSEjO6XO0+76kYg/RSu8Sm4DGcNqYFI5xzY8wvUDgVUE//7F/3OPcozLcyO/HBIM943nr0n44UhfdQnoGcaX0Hr5tHcqHhAWpKTKY1evWpY6BAZKSqKHcDP23o891FFkaFZFNMqjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09B4920004;
	Mon, 25 Mar 2024 15:56:55 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 4/4] tls: get psock ref after taking rxlock to avoid leak
Date: Mon, 25 Mar 2024 16:56:48 +0100
Message-ID: <fe2ade22d030051ce4c3638704ed58b67d0df643.1711120964.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711120964.git.sd@queasysnail.net>
References: <cover.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

At the start of tls_sw_recvmsg, we take a reference on the psock, and
then call tls_rx_reader_lock. If that fails, we return directly
without releasing the reference.

Instead of adding a new label, just take the reference after locking
has succeeded, since we don't need it before.

Fixes: 4cbc325ed6b4 ("tls: rx: allow only one reader at a time")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 14faf6189eb1..b783231668c6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1976,10 +1976,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);
 
-	psock = sk_psock_get(sk);
 	err = tls_rx_reader_lock(sk, ctx, flags & MSG_DONTWAIT);
 	if (err < 0)
 		return err;
+	psock = sk_psock_get(sk);
 	bpf_strp_enabled = sk_psock_strp_enabled(psock);
 
 	/* If crypto failed the connection is broken */
-- 
2.43.0


