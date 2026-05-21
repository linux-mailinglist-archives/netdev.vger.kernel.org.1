Return-Path: <netdev+bounces-290566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFJADEJBD2qcIQYAu9opvQ
	(envelope-from <netdev+bounces-290566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A05AA47F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8533033F94
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1D3C871E;
	Thu, 21 May 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6r1l/l/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9B30E821
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382969; cv=none; b=atobDCL7FOqKgqUs/ddfdslqJ+/JVCkD2//g0uUhwfCgMCu2Rv5Ic+QCE/NAxz+A5PAtutW1+ZYIULF6sB/3mX+lLCa1l2hHxUmjX5EAxVpSYPRHg9UkfZ0m7XMq6xq3TD0GosaFnKcOOXv0BZtO9E2ULi9elBv8A60QpceLhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382969; c=relaxed/simple;
	bh=zx9iqLN9zmh++r23XiPtByTx7CLtzJ7HqXlS3Lo3u7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B1kZT2qnu8GKZKQ2Y6jyLN2SCNjFIKqMcF8AzyIBWh/RlWm10mA1CBwLQFxUK9Zyi8duUZJmH7tlvwpVIiOHiEXtyH9qlS/5T3InBcrgsDxUEmmTY7UhWZHxXUdsJyLdocqyubtAWjE03HLQNy1BQRg6h/mINxbHVTA0Qvlckkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6r1l/l/; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c6a2158d3so4650658d50.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779382967; x=1779987767; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0B8qDAE2Hi4K54lFJwvYiq6K8A1ngqWVMdmiVrD5B7k=;
        b=U6r1l/l/pgu0L3g+Isqnd1Wati3cftc6RKz2p2YiVi/e06muplMRMg/8/Wgvh4CF8b
         5A5pBOs6awqO01v2bIg2pTL1nVFIuw5oC9tPPuKwPHsj2MGINawcbFvuXJuDGJds09Zl
         J3VAmGPK/ywgAxq8448ZArgh0YSPVoMCtijk8RFJtSfSqTqqFWvp+Cfs35V/ALRWBivr
         hp/H8TC33s40sBlG7KmmxMqjJXTAUtHNSfaQGRNkEzsg8xW7UhtV3wXRk3CtNBVz3XUZ
         JkiBGdzIqUZj8J+l2dDNxrK8B8wJuMDDljZBRO/rB6oCXhSXTGvJGN0OIFsESHP+wAyp
         lQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382967; x=1779987767;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B8qDAE2Hi4K54lFJwvYiq6K8A1ngqWVMdmiVrD5B7k=;
        b=raNTcM4dZhlWiOsO+plnwd76cSYPGTzzdwbnnXGdRHvBx8ReyujWdWo+0f2iRh7a+4
         932tt5PWjL6DqYpjvZdETeN7n95cj5eVw6vxtVmy2kOJUNXVyRjTxUaKRFlk+ExlE+gu
         gKeiCdKm46Dsh1B+6qLtMxsmyJK4KtnKaMvS9Bn2a3rssW3gKh55RYyzVQovUDU3wwjH
         jO5xqCWsZLSxJq75UzfAdby53+H2dq9pwjtr4OleH4Q/pj0jrCP80FRdyHMahckRm79L
         hjYpdOILrkfSqbThm2OHl3S5escb1rNFTnaGbnuecl7MlpbBHQZBOz2LbXg/T9jjRLOz
         slyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+l8RhN7ViIBCdoiKw3a8aYC3H4S8CsN3+Pq1JdRJKPKavJ8b1w6/EI29bruzZAKPsPEpkJjl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3l2UxMoijt1uEtuHulWLHY3aC0Q7Rq9Zi0fFrMIqHVu+4uRJ
	71L5gcrk9+oB+lcR+Mqj0/KZYR9rgFcIaXZUnmP7EW2SNdKV4/jSWRIE
X-Gm-Gg: Acq92OEZb/y9Aw0zg+putNOa/LY2q4rAFmof/HL8fUQP2Uw7UH0VSFOboQLV7nxdPYq
	uk52+zVOuOUTsG8U5fOzqD5aTxyYocJmXrz0UXaSYw3nOzyrUTzB3foRkHxVp/BHwlyLyq1WM3y
	uLsOGr8h+uhwhnfJCU6eWRRsfq/t0WbXGD1swETFMdJpLX73SWn2MBz3mQGKKrC8yy/pHGKdSUk
	YtOfEeGyp799QsH5M3E3SIAX2GXEhU9voxQDhYs0h1EmwnvErxlaG5TCMyXZU8oVnsqm3s5IrEl
	RUUr0j9sZ7cyO4sDULtx/LtDyY2k2bYs4QT+3u38qAtCGRncfCInMUY0YtibQwppwc4feNrhymC
	xXC05kibyGmHaosX+AAgF3BBOpEskzhV4Uy3bajRrgjCGh9f4U84eUreknB4tq6o/iMXFT7ydUN
	zh7tEnS9wJT0/+JurMOQSL0xKUc1WNFA==
X-Received: by 2002:a05:690e:440b:b0:65e:41a4:54ca with SMTP id 956f58d0204a3-65eae2b3fb9mr2406856d50.62.1779382966868;
        Thu, 21 May 2026 10:02:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ec1eea6d3sm430363d50.13.2026.05.21.10.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:02:46 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 21 May 2026 09:51:33 -0700
Subject: [PATCH net] eth: fbnic: move aui and fec from fbnic_net to
 fbnic_dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fbnic-aui-change-v1-1-fc0c46e8e682@meta.com>
X-B4-Tracking: v=1; b=H4sIABU4D2oC/y3MTQqAIBAG0KsM3zqh7I+8SrQwnWo2FloRRHcPo
 vWDdyNxFE4wdCPyKUnWAENFRnCLDTMr8TAEnesmr4tSTWMQp+wh6vdKW9dpb0vfVsgIW+RJrq/
 sEXjH8DwvgxbgZWcAAAA=
X-Change-ID: 20260513-fbnic-aui-change-42ac92da3d74
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: Mohsin Bashir <hmohsin@meta.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290566-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 838A05AA47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

fbnic_mdio_read_pmd() reaches through fbd->netdev to netdev_priv() in
order to read fbn->aui:

	if (fbd->netdev) {
		fbn = netdev_priv(fbd->netdev);
		if (fbn->aui < FBNIC_AUI_UNKNOWN)
			aui = fbn->aui;
	}

This can lead to a TOCTOU bug where fbd->netdev is checked after being
freed but before being cleared.

Both aui and fec describe the link configuration of the NIC, so move
them to fbnic_dev together. The MDIO layer (and other fbd-level code)
can read them directly without bouncing through fbd->netdev. The
hazardous accesses through fbd->netdev are dropped.

Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h         |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |  3 +--
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c    |  9 ++-------
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |  3 ---
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c | 18 ++++++++++--------
 6 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index d0715695c43e..76cfaf77b5ef 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -88,6 +88,9 @@ struct fbnic_dev {
 	unsigned long end_of_pmd_training;
 	u8 pmd_state;
 
+	u8 aui;
+	u8 fec;
+
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 5e383d40abc7..03dbb53b33d9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -132,7 +132,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 	fbn = netdev_priv(fbd->netdev);
 
 	/* Record link down events */
-	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
+	if (!fbd->mac->get_link(fbd, fbd->aui, fbd->fec))
 		phylink_pcs_change(fbn->pcs, false);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 53b7a938b4c2..e911dbf41b46 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -515,7 +515,6 @@ static u32 __fbnic_mac_cmd_config_asic(struct fbnic_dev *fbd,
 	/* Enable MAC Promiscuous mode and Tx padding */
 	u32 command_config = FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN |
 			     FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
 
 	/* Disable pause frames if not enabled */
 	if (!tx_pause)
@@ -524,7 +523,7 @@ static u32 __fbnic_mac_cmd_config_asic(struct fbnic_dev *fbd,
 		command_config |= FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS;
 
 	/* Disable fault handling if no FEC is requested */
-	if (fbn->fec == FBNIC_FEC_OFF)
+	if (fbd->fec == FBNIC_FEC_OFF)
 		command_config |= FBNIC_MAC_COMMAND_CONFIG_FLT_HDL_DIS;
 
 	return command_config;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index fe3a4ce88413..b571d4e3f36d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -5,7 +5,6 @@
 #include <linux/pcs/pcs-xpcs.h>
 
 #include "fbnic.h"
-#include "fbnic_netdev.h"
 
 /* fbnic MDIO Interface Layout
  *
@@ -54,18 +53,14 @@ static int
 fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
 {
 	u8 aui = FBNIC_AUI_UNKNOWN;
-	struct fbnic_net *fbn;
 	int ret = 0;
 
 	/* We don't need a second PMD, just one can handle both lanes */
 	if (addr)
 		return 0;
 
-	if (fbd->netdev) {
-		fbn = netdev_priv(fbd->netdev);
-		if (fbn->aui < FBNIC_AUI_UNKNOWN)
-			aui = fbn->aui;
-	}
+	if (fbd->aui < FBNIC_AUI_UNKNOWN)
+		aui = fbd->aui;
 
 	switch (regnum) {
 	case MDIO_PMA_RXDET:
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index eded20b0e9e4..213253a818bb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -46,9 +46,6 @@ struct fbnic_net {
 	struct phylink_config phylink_config;
 	struct phylink_pcs *pcs;
 
-	u8 aui;
-	u8 fec;
-
 	/* Cached top bits of the HW time counter for 40b -> 64b conversion */
 	u32 time_high;
 	/* Protect readers of @time_offset, writers take @time_lock. */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 09c5225111be..61463bcb6431 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -65,6 +65,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 					struct ethtool_link_ksettings *cmd)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
 	int err;
 
 	err = phylink_ethtool_ksettings_get(fbn->phylink, cmd);
@@ -72,7 +73,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 		unsigned long *supp = cmd->link_modes.supported;
 
 		cmd->base.port = PORT_DA;
-		cmd->lanes = (fbn->aui & FBNIC_AUI_MODE_R2) ? 2 : 1;
+		cmd->lanes = (fbd->aui & FBNIC_AUI_MODE_R2) ? 2 : 1;
 
 		fbnic_phylink_get_supported_fec_modes(supp);
 	}
@@ -84,11 +85,12 @@ int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
 
-	if (fbn->fec & FBNIC_FEC_RS) {
+	if (fbd->fec & FBNIC_FEC_RS) {
 		fecparam->active_fec = ETHTOOL_FEC_RS;
 		fecparam->fec = ETHTOOL_FEC_RS;
-	} else if (fbn->fec & FBNIC_FEC_BASER) {
+	} else if (fbd->fec & FBNIC_FEC_BASER) {
 		fecparam->active_fec = ETHTOOL_FEC_BASER;
 		fecparam->fec = ETHTOOL_FEC_BASER;
 	} else {
@@ -96,7 +98,7 @@ int fbnic_phylink_get_fecparam(struct net_device *netdev,
 		fecparam->fec = ETHTOOL_FEC_OFF;
 	}
 
-	if (fbn->aui & FBNIC_AUI_MODE_PAM4)
+	if (fbd->aui & FBNIC_AUI_MODE_PAM4)
 		fecparam->fec |= ETHTOOL_FEC_AUTO;
 
 	return 0;
@@ -120,7 +122,7 @@ fbnic_phylink_mac_prepare(struct phylink_config *config, unsigned int mode,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
 
-	fbd->mac->prepare(fbd, fbn->aui, fbn->fec);
+	fbd->mac->prepare(fbd, fbd->aui, fbd->fec);
 
 	return 0;
 }
@@ -140,7 +142,7 @@ fbnic_phylink_mac_finish(struct phylink_config *config, unsigned int mode,
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	/* Retest the link state and restart interrupts */
-	fbd->mac->get_link(fbd, fbn->aui, fbn->fec);
+	fbd->mac->get_link(fbd, fbd->aui, fbd->fec);
 
 	return 0;
 }
@@ -227,10 +229,10 @@ int fbnic_phylink_create(struct net_device *netdev)
 	__set_bit(PHY_INTERFACE_MODE_25GBASER,
 		  fbn->phylink_config.supported_interfaces);
 
-	fbnic_mac_get_fw_settings(fbd, &fbn->aui, &fbn->fec);
+	fbnic_mac_get_fw_settings(fbd, &fbd->aui, &fbd->fec);
 
 	phylink = phylink_create(&fbn->phylink_config, NULL,
-				 fbnic_phylink_select_interface(fbn->aui),
+				 fbnic_phylink_select_interface(fbd->aui),
 				 &fbnic_phylink_mac_ops);
 	if (IS_ERR(phylink)) {
 		err = PTR_ERR(phylink);

---
base-commit: 8ebd24a7822cbae25beeafba49b2159d6a68a5f2
change-id: 20260513-fbnic-aui-change-42ac92da3d74

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


