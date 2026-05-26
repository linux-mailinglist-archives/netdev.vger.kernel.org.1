Return-Path: <netdev+bounces-291862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMglLiTZFWpYdAcAu9opvQ
	(envelope-from <netdev+bounces-291862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71C5DAB6D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D663830215AE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCEA421F17;
	Tue, 26 May 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp3aTO4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECC40C5AE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816099; cv=none; b=nS9s1w1Kfe0WpFM6V7Lb2qjsmCcebfZCC9DL2wHy2kwwFh8YQS0O0sM91E1fvMgr/K+xOR6WxSqueyVap09NpGg8ku/uVuQHvf5NWAZY+rcDk7+n3/1P1FMsYucBC/UvTzN/buFDDUjuEmIuCyDE3mglutgAfiv93hzC8RDu4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816099; c=relaxed/simple;
	bh=Gf5hju9X0zI7HaXMkAM9MGwv7IDWKHi3wvMpeMbYx1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JgzjSE6FSOeRpvLZOC57RN8EcvAuMagd2pEUnPqkcndAe6pOfb/159TUK5bmPlt3x3H/YxxnBp2K2ZyMZ1mFxhjMk6ahF9K92UCNMTNnU93GdkgztlbfyDVcO+gRgjvKF8P9Q2hS9JSMm3666+BS6XTlcLFQfQxVCr7VJXdxOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp3aTO4w; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69de16f5e80so51260eaf.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779816091; x=1780420891; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlryjWKduSUmbI5pIFwgJTa+Vts/T4ipj/ODH9sgEbU=;
        b=Bp3aTO4wUkaJpe9pFICVUiRgmU56jLVSRP//GEURNRwJBWa+tWt2icEQn5ALKB0B4Y
         f7EHZnrmMM4sRseAa6noIhuZKinHcJwF629t+KAr3gAX76PJFLmo7Rp/8hEuSwqYegFQ
         vaQrJLEMqJ7rnYTODXz6wEEL5d8VrMeMdrfxeN0jOgW2cHVnMlZUxmnRTfjTESGGIz6P
         3tkR+O4U10g0wbFzC/3+TCfwNXWdeBIecxBahK8zg3LF2WVZedMhRAlKiD4EedGJSrNm
         RqlcOsRhHpq5cAPtTfKUkk0PJ/6JrfpaxS1Oo37uu8c/6ii9y0Z3sxxn7HOa34DyCuSY
         F/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779816091; x=1780420891;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlryjWKduSUmbI5pIFwgJTa+Vts/T4ipj/ODH9sgEbU=;
        b=mLbusOef94mGATGkUKXnObFpaWNOaMeALlebfadI7WooL3iAkKlj0xta3ENTV9hrqc
         d7niOyWONf0TvczUz+ty/2mkvTLrt8a3iwqYK7Etj7QicRcjgoZjraqbe/NFIOT7K6Rs
         ZwSoTI1sNsKy+zhVmLZg1/lMfJMcpi4Pp3BbuibnSX29//wXFFnTn3GX8QR1suL5rJpC
         zeeslp/WjDjkvVD7TG4G3zrlxIuSi3AMPe4prYmYKvABcWzW1TWksv3YDedArhfgyY1W
         D1EL+6eWwiJd6u4IRWOGlQMcYv2NvtjIjrlLmx68fyxuO+k3/pObKO6sWvH4Snsr/1F5
         TlXg==
X-Forwarded-Encrypted: i=1; AFNElJ+hB4kQmxAKA3ek/MUaR5DHPDSejWty7M4mCWdA+ytCiEnIIjG26CFS3EGINoRQITseEoaGghg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0Tl5kyL99UK/mYIAFW/p5ul1iZzIUEgkja722bxh0lGxiduM
	ZkZKR+bohC5c7Z6ambQSy3IHo5qfzO39By08ddXa9W6RiLsssF8UU/yT
X-Gm-Gg: Acq92OH9otx6Gwok2d7Kvq8Qb8VBhMWgtLr+oQlFNwjzni7dsqWCZEctJuM0jEVbCTb
	/Gxq93/dVXfJoVcdnWG4YmjPP5IqTf6m+uaoHSALz0nqDwSF3JYydyiZDX1++7kVZOz0WunoTio
	1Z++FsLKdEmfhmzXFae9OaR3V20vjgQXkcrGLyolCH8blz9IqnneAiAnM4oN666VmvbrBjCNBSu
	yropb4WsyHs6WdMxexS2/xqGbQmaF8TfibZ9AX///0Ql1hwsjyLZluYwKy//hLAM7VikOSJbqhq
	sedmQwTc0o7XVhh1094052qPrY43GWcMwTwMAj+THQH9L0r7FEYp0pp4ryfXeD/8wwg9ZlbqicI
	ta+p2p7pemBxnfyf9ILfBBy3HIEDLegMQXPxHF8JlwbHk/yasIIemasbFszbEenDeY90B4ofmqk
	/kW1NUqHQioNi9CAIZVuA=
X-Received: by 2002:a05:6820:f033:b0:69c:5d2b:407c with SMTP id 006d021491bc7-69d7ed3d5fcmr10217118eaf.58.1779816091590;
        Tue, 26 May 2026 10:21:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d8c3284c0sm6211061eaf.12.2026.05.26.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:21:31 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 26 May 2026 10:21:08 -0700
Subject: [PATCH net v2] eth: fbnic: move aui and fec from fbnic_net to
 fbnic_dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-fbnic-aui-change-v2-1-7c74cd48074f@meta.com>
X-B4-Tracking: v=1; b=H4sIAIPWFWoC/2XNQQ6CMBBG4as0/5oaOiAiK+9hWNR2kFlQTItEQ
 7i7SXXn+iXf25A4Cid0akPkVZLMAZ2iQsGNNtxZi0enQCU15dFUergFcdo+Rf96TdadydvKn2o
 UCo/Ig7wyeUXgBX2hMEpa5vjOm9Xk9BXJ/Iur0UYPrnR1wy03LV0mXuzBzRP6fd8/CK9hAbQAA
 AA=
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291862-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 5E71C5DAB6D
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
Changes in v2:
- rebase over net/main
- Link to v1: https://lore.kernel.org/r/20260521-fbnic-aui-change-v1-1-fc0c46e8e682@meta.com
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
index 709041f7fc43..49895430c97d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -5,7 +5,6 @@
 #include <linux/pcs/pcs-xpcs.h>
 
 #include "fbnic.h"
-#include "fbnic_netdev.h"
 
 #define DW_VENDOR		BIT(15)
 #define FBNIC_PCS_VENDOR	BIT(9)
@@ -15,18 +14,14 @@ static int
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
 	case MDIO_DEVID1:
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
base-commit: c66d7c3c1f173cf73a2a2f8302666d86beafff22
change-id: 20260513-fbnic-aui-change-42ac92da3d74

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


