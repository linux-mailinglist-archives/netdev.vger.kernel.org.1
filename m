Return-Path: <netdev+bounces-276841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lvFON7k012mPLggAu9opvQ
	(envelope-from <netdev+bounces-276841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 07:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 088DF3C63F8
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 07:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95B93006941
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F92741B5;
	Thu,  9 Apr 2026 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="tNRFGn2n"
X-Original-To: netdev@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F322D781
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775711351; cv=none; b=fdQ8GcCtFc4DTsVfSQcULbkrc8z2YPeHSNSPGAZnPRHnRWBQMy51ouKiHmlSCvU1SPA9rp8O7gkTG90RELVFbylHTBBcpTNWj7dRc6fY1XWeN4fQglo50tlKByYPWvD+nmDkmpxtY5m2qgKixI54LxNbpIlfYjf2RDfab25pdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775711351; c=relaxed/simple;
	bh=UwEHBhDe90eJlsfgAymh+d6KqEQKQcSx/xKfUx/6ahI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ptXbV1xhVzebzv/S3I/YqAIFQFkH10vkhIotMfN8Kj7xY77AT7ip8WvQV/T/jYnjGVDsECNE5CCmHuutuQzpkM6T+CBvBqm6N7hiFd43te+b1WVO8aXBcdjqAtOzun6GS9XcTeP+f9OVPXDtaZyN+twjK+gNrcMEBZJIDXvyHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=tNRFGn2n; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1775711312;x=1776920912;bh=UwEHBhDe90eJlsfgAymh+d6KqEQKQcSx/xKfUx/6ahI=;b=tNR
	FGn2nwaUkbvETG3fhFt+f2OUW9EDihVqsaPvmIAsDxkAONO/zDh5c2He+PEiHtG/U1sBds8e3D3qa
	4Q/DcuYBTqvpBR4C1Zo0Pc3vwdBQyYXYv1IsUttNqNHjx2bkUR0EKjPhnWzihW3GvpYyKs1CZK4ew
	R23asDhDmfWG/QduMZFfAgC5vGTYeHQUQ3C8yde9DI9G9r3abntKDesTTMkL0EvX5I1uBBS1pYmTr
	6sdQMcoWKHJPSnTNxbteH6Tl36ei10oiDMkhv7MVRpEE4zHiJ2l1DlpfBxc0XXu8GKtRThcAATS70
	8oIjmUcEtlNw4cfliLYg2C9JaEH4mHQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 63958WOm728952; Thu, 9 Apr 2026 14:08:32 +0900
X-Iguazu-Qid: 2rWhra8uK9tl9pGJG9
X-Iguazu-QSIG: v=2; s=0; t=1775711311; q=2rWhra8uK9tl9pGJG9; m=lFBCrxmdzSjl8WAEwUTSB7eyIbMfF5j4D0/HCpaCTgI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4frnyR1SFXz4vyq; Thu,  9 Apr 2026 14:08:29 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: vburru@marvell.com, sedara@marvell.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: netdev@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH] octeon_ep: Remove unnecessary semicolons in octep_oq_drop_rx()
Date: Thu,  9 Apr 2026 14:08:11 +0900
X-TSB-HOP2: ON
Message-Id: <1775711291-13938-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mail.toshiba,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mail.toshiba:s=key2.smx];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[nobuhiro.iwamatsu.x90@mail.toshiba,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276841-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mail.toshiba:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 088DF3C63F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove unnecessary semicolons in octep_oq_drop_rx().

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 74de19166488f..e6ebc7e44a00c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -392,7 +392,7 @@ static void octep_oq_drop_rx(struct octep_oq *oq,
 	while (data_len > 0) {
 		octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
 		data_len -= oq->buffer_size;
-	};
+	}
 }
 
 /**
-- 
2.53.0



