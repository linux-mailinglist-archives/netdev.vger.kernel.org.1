Return-Path: <netdev+bounces-293935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP9THPIlHmo9hgkAu9opvQ
	(envelope-from <netdev+bounces-293935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:38:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5B6269F4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC2883007A6B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04896306766;
	Tue,  2 Jun 2026 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/EgSLMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68A2F6577
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360683; cv=none; b=EM8PiVmRRVa87m+OqKj2kj1fNlIm7eePpvrPoEd6S9+1AESeNLNkM5KwnoPkY97gW75Uzuc16Rhemsx2k0lZ39hlHfmys9jqUJEg20vMPPm/qND4bDpcwSkuFFJih8lbjVupJLVy2ULPT6ophfZa1QUrd9lYIbXlR50L2zpXl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360683; c=relaxed/simple;
	bh=SZ8VPfd2O/v8lQLI/cN1Tu5FnkN+1bcGIw+6vAqVOko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmtMO/ZUAUZOwai9dDaLireXi2lPIcDPs87opppsJI2YKlafgdQXroQNp9T9ikHnaXeLKOeRHXNz2Ssypgxr26tDwrXwib12Jrxz5zW2pumpQsaa3rwN+9rFQrT8J57aVQ3ef/9524a1jSMv9HufBr9E4nlG1einQ+mB1/0CyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/EgSLMF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6961F00893;
	Tue,  2 Jun 2026 00:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780360682;
	bh=spAri23FwgkZVeIT5yc3X0RdiYc5FsiHbMEwAFS9JDU=;
	h=From:To:Cc:Subject:Date;
	b=C/EgSLMF34lTcp1Dsc405t2Jai+ACswJNUCsNVMbd4uVEaIYjoS5VB0WrWXlOo+TG
	 SPXsjSpfUH8NAJMJxsEY2ybDCiuFK+cyUn+jNbFBVQaaplBFRVOsYEKDDTclCrXpTF
	 luoxtkCdJMz0lJeQL55KKIKajdty6tg0qio3qWnacbVwkUNOmbK3E/3IYn2lPTFRc2
	 Ym12WhWnX33WlE4KlDOXomZmIE1R8J07v6iuBu7galN/DhO7q7DaCUlrDGbQKAO8+6
	 GwNvW/YyPbOXi7VYCbi0GUkdZFIjMMppMlH+qHJjrJsfxkPPNV8I7fCKq9xYJTZC+m
	 omTZeGoOPtdsA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2] eth: bnxt: disable rx-copybreak by default
Date: Mon,  1 Jun 2026 17:37:59 -0700
Message-ID: <20260602003759.1545645-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293935-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: 71A5B6269F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rx-copybreak requires an extra slab allocation. Since bnxt uses
page pool frags and HDS by default, the rx-copybreak doesn't
buy us anything. The extra pressure on slab causes overload
on pre-sheaves kernels on modern AMD platforms.

In synthetic testing on net-next this patch shows little difference
but I think copybreak is "obvious waste" at this point.

Default rx-copybreak threshold to 0 / disabled.

The "copybreak" defines are really the size bounds for the Rx header
buffer. Rename them.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - rename the defines instead of changing the DEFAULT to 0,
   we only want the default setting to change, but the define
   is also used as min rx buffer bound in the code
v1: https://lore.kernel.org/20260529205553.999672-1-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 6 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 61c847b36b9f..1920a161841e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -36,8 +36,8 @@
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
 
-#define BNXT_DEFAULT_RX_COPYBREAK 256
-#define BNXT_MAX_RX_COPYBREAK 1024
+#define BNXT_MIN_RX_HDR_BUF	256
+#define BNXT_MAX_RX_HDR_BUF	1024
 
 extern struct list_head bnxt_block_cb_list;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d4f93e62f583..3587f39202d2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4846,11 +4846,11 @@ static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	unsigned int rx_size;
 
-	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->rx_copybreak = 0; /* rx-copybreak disabled by default */
 	/* Try to fit 4 chunks into a 4k page */
 	rx_size = SZ_1K -
 		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	bp->dev->cfg->hds_thresh = max(BNXT_DEFAULT_RX_COPYBREAK, rx_size);
+	bp->dev->cfg->hds_thresh = max(BNXT_MIN_RX_HDR_BUF, rx_size);
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -4911,7 +4911,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
 				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		} else {
-			rx_size = max3(BNXT_DEFAULT_RX_COPYBREAK,
+			rx_size = max3(BNXT_MIN_RX_HDR_BUF,
 				       bp->rx_copybreak,
 				       bp->dev->cfg_pending->hds_thresh);
 			rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9b14134d62d2..edafa79f636c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4594,7 +4594,7 @@ static int bnxt_set_tunable(struct net_device *dev,
 	switch (tuna->id) {
 	case ETHTOOL_RX_COPYBREAK:
 		rx_copybreak = *(u32 *)data;
-		if (rx_copybreak > BNXT_MAX_RX_COPYBREAK)
+		if (rx_copybreak > BNXT_MAX_RX_HDR_BUF)
 			return -ERANGE;
 		if (rx_copybreak != bp->rx_copybreak) {
 			if (netif_running(dev))
@@ -5172,7 +5172,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
 	cpr = &rxr->bnapi->cp_ring;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		cpr = rxr->rx_cpr;
-	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_DEFAULT_RX_COPYBREAK,
+	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_MIN_RX_HDR_BUF,
 						    bp->rx_copybreak));
 	skb = netdev_alloc_skb(bp->dev, pkt_size);
 	if (!skb)
-- 
2.54.0


