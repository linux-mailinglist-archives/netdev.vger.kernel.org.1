Return-Path: <netdev+bounces-251810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GZJFbSRcGkaYgAAu9opvQ
	(envelope-from <netdev+bounces-251810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44353C47
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 260734E2B75
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31D43CEF2;
	Wed, 21 Jan 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clemensgruber.at header.i=@clemensgruber.at header.b="AUcFTWCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.gruber-software.com (mail.gruber-software.com [3.120.200.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647A478853
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.120.200.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984744; cv=none; b=DWLsZxznch6rqmI2Vz0gF2bfr8Wy2VweeAWFfXjKgkdmsuMD/ZcUWvmrtkhohd94DCG3EQguvpr6bcvW3G7ANqV0EEq7DC7uh6rB/JwF6C/aax8wqNPNsjcXdquUpYs7+ptpbTNuWyPIiuOQnwQ5++09tyfKlJvnMgRNY2in9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984744; c=relaxed/simple;
	bh=lSJq/VUxHsPHf3f1N1Yp14yQ41kvQxFXuqrR4PO5dyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI6EO8mHTFDQDIO7XbMAXMl/3cILYVdvI5aP67/e9ScYAN15MNf7LaE6oLXhg/NDw90+frlrYR0s3xhpYzZAGR5c3ndsYpey8FFbV1zbSdGfv2qlVGX6PpVW4s0UmTuZ3LvkNXuQXJCBBld8hjVW3ZZY2wuCuDijPJ3s2yXuJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=clemensgruber.at; spf=pass smtp.mailfrom=clemensgruber.at; dkim=pass (2048-bit key) header.d=clemensgruber.at header.i=@clemensgruber.at header.b=AUcFTWCh; arc=none smtp.client-ip=3.120.200.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=clemensgruber.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clemensgruber.at
Received: from workstation.tuxnet (213-47-81-100.cable.dynamic.surfer.at [213.47.81.100])
	by mail.gruber-software.com (Postfix) with ESMTPSA id 8BFC98062F5;
	Wed, 21 Jan 2026 09:38:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clemensgruber.at;
	s=default; t=1768984738;
	bh=S1SyByoHsJZ0J10acxvnqKxQRVHbknAEHOMpHY+l+GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUcFTWChCcv7R5osislcD8KOp1ARMAoJxu1zLSjEgpo4mF9DoVxrX144vLfhNifl9
	 +TYQecqWx5mC+KyC/7N9yEBHnuQM94eP1faKyOoKnMxRsdPwOWIBEU+p0m/nKTWOg7
	 zOa0JfLtYzcRpgPkP4LKMWVHVmu0/gE65na0Qz2TUHM3QEFZxtA4Wny9jbKZ7nyFMi
	 8+dCiMKPqemrq1VjMBkUAqUIpRbJOgT5pmC4xW1YPSIBXkjB+576CpKk1WBH77zDCb
	 xvQkLpEfh/1E7es6lMY+L8F/65BtQlJacquGZTdkFUREVXhg/p5F21PcYuWMtQm7zV
	 OPLzX7SLy92MQ==
From: Clemens Gruber <mail@clemensgruber.at>
To: wei.fang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	Clemens Gruber <mail@clemensgruber.at>,
	stable@kernel.org
Subject: [PATCH v2] net: fec: account for VLAN header in frame length calculations
Date: Wed, 21 Jan 2026 09:37:51 +0100
Message-ID: <20260121083751.66997-1-mail@clemensgruber.at>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120160407.101273-1-mail@clemensgruber.at>
References: <20260120160407.101273-1-mail@clemensgruber.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[clemensgruber.at:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-251810-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[clemensgruber.at,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@clemensgruber.at,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[clemensgruber.at:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AD44353C47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MAX_FL (maximum frame length) and related calculations used ETH_HLEN,
which does not account for the 4-byte VLAN tag in tagged frames. This
caused the hardware to reject valid VLAN frames as oversized, resulting
in RX errors and dropped packets.

Use VLAN_ETH_HLEN instead of ETH_HLEN in the MAX_FL register setup,
cut-through mode threshold, buffer allocation, and max_mtu calculation.

Cc: stable@kernel.org # v6.18+
Fixes: 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")
Fixes: d466c16026e9 ("net: fec: enable the Jumbo frame support for i.MX8QM")
Fixes: 59e9bf037d75 ("net: fec: add change_mtu to support dynamic buffer allocation")
Fixes: ec2a1681ed4f ("net: fec: use a member variable for maximum buffer size")
Signed-off-by: Clemens Gruber <mail@clemensgruber.at>
---
Changes in v2:
- Fix the other frame length calculations too
- Improved title and commit message

One line in fec_restart (after the FEC_QUIRK_JUMBO_FRAME check) has now
82 characters but I think folding it would make it less readable.
Let me know if this should be changed.
---
 drivers/net/ethernet/freescale/fec_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a753265961af..797ef6899657 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1150,7 +1150,7 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = FEC_RCR_MII;
 
 	if (OPT_ARCH_HAS_MAX_FL)
-		rcntl |= (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16;
+		rcntl |= (fep->netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN) << 16;
 
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
@@ -1285,12 +1285,13 @@ fec_restart(struct net_device *ndev)
 
 		/* When Jumbo Frame is enabled, the FIFO may not be large enough
 		 * to hold an entire frame. In such cases, if the MTU exceeds
-		 * (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), configure the interface
-		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * (PKT_MAXBUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN), configure
+		 * the interface to operate in cut-through mode, triggered by
+		 * the FIFO threshold.
 		 * Otherwise, enable the ENET store-and-forward mode.
 		 */
 		if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
-		    (ndev->mtu > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)))
+		    (ndev->mtu > (PKT_MAXBUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN)))
 			writel(0xF, fep->hwp + FEC_X_WMRK);
 		else
 			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
@@ -4037,7 +4038,7 @@ static int fec_change_mtu(struct net_device *ndev, int new_mtu)
 	if (netif_running(ndev))
 		return -EBUSY;
 
-	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN
+	order = get_order(new_mtu + VLAN_ETH_HLEN + ETH_FCS_LEN
 			  + FEC_DRV_RESERVE_SPACE);
 	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
 	fep->pagepool_order = order;
@@ -4588,7 +4589,7 @@ fec_probe(struct platform_device *pdev)
 	else
 		fep->max_buf_size = PKT_MAXBUF_SIZE;
 
-	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
+	ndev->max_mtu = fep->max_buf_size - VLAN_ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
 	if (ret)
-- 
2.52.0


