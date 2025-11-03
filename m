Return-Path: <netdev+bounces-235202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A36C2D5AB
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E018189D568
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E131AF2E;
	Mon,  3 Nov 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt29xTQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A631A7FF
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189280; cv=none; b=XH+l4I8MGHemNj3G2QzTxg/1vRZ9bqUPJonj/b8WJ+HpSowzFsXD11hqhQfe2IXyAfQGBbthTMz+vsNLngcDVoCGNwrekQgr2Ygk9kdpQfQsCaYIjUHdxvF0r/k1HduLHdpFUKCMs7PaAteEGHgEN8st4Oa3Nygf07nciqIvEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189280; c=relaxed/simple;
	bh=guPjdmCGXhPUKlg9Vu9NZFHsa5yb4XApcuZtThu19YA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kY0JS8SphlGl8/sCVKloaSHK5tLQC/1cMmb7ABJR73GfvMAqIh+xOkMELnRjZkC172hLicaguhHUfpdJfz/p6Rn6/o16CxlWy+55/rQbPRUgvK5gFT2Q9zctlZ7X9z5x/+uayzl4UtXy5yfHRnrmwsclesveTSyzLQMvz6ZmnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt29xTQ7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso1295626b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189277; x=1762794077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QcRc4djTGXtDuYMTYB2U7oRTf8eZPtHUt1m6xxGkuJM=;
        b=Mt29xTQ7dO/pX8k91Kf2gUMVtPPqWStn3cROvC68jP2Gja0QvcZd05PhdXUAJVZ5Bo
         GK53o52S6q8IO+r4o7v73QZ84C+sIQ9NkmCefW3rTm6XiE995ozzoUBBZoleBOuAEcvX
         5KoXiLp3/l29CDIgXdK35QFf+8cwmL6zEli5RfemTlbbZ3O3yNosOfka5DrRcyf7IZR8
         Fc1TU4ZAGGobdIZHaOSMssLWRAoXoqYs5HpLzSpgLme7PdXuJMx+IJUf/ZMwHrnWjhbw
         JEa9XLfcqiReIMgj880n7Bd+x/LMoYozcNuGk0b1+bB/bglm2/Lay4NydRHDBA6EKWCh
         Htvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189277; x=1762794077;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcRc4djTGXtDuYMTYB2U7oRTf8eZPtHUt1m6xxGkuJM=;
        b=p/rS7pbExD1o4CRibDDKGvIev0Hq0IELkZpNA4XXjGkmP92kS/lw53w0QYP+2F7/r4
         SUQ5oa9nYvKoMYdwo82eXFw3eMCikf6DDEg+jUppXGKiUYDCaO2YXULKvkLNOOpEBsBq
         MNaRzpiJLzH9K0Gz234nU83WHV6vmho8FFTJA2dB20N1FWi/7+SP2r2daV0DK6aeH5W8
         C9k52++extYrROR86jpTixS8NN6DzA+p+74v1hHxwHQ0iXTCbUT7vOz/PsTeQNeBBKXW
         OuK/WVRUP+PKSyX2XIF95dAtUrDJaxY5dMH0uvvg7PjJBgb73uebC4FPNZkNdSOsX/Fj
         9Gjw==
X-Gm-Message-State: AOJu0YwNb/BK2AeS0314kqml5OH/O76wMsBOSD+3azxAwVfON4q2ecO1
	9N2TmxdhSGwKdghS40YF45eEujbcP4TT0FEP6MOIi+F88p/ExFMoGaWRDJ5jYg==
X-Gm-Gg: ASbGncudNazsjSa5iU/Dfd7fdGEaIOd+3Egsviy3KA8kgHlj6NeOnSLi3rsIzEXOgZH
	If6n+UfkvLMLEa/CvPhAo+Xa6DjFqcfzGsanFSkknYs35Q5XCn1kZz25uZsCrWMYb344zft2GBE
	KiegxIYG6L8Kfjpx2SmrsbyI7yKmTKHEGWRyLpOhmbn5FTBGkheOPrPpnXpT3KtvEIVQCBkUkd+
	bDFRxFvOmpBWLP4m9/rbASibRLUkB0PU+crjsRS+FM7wkruqh6g+q8XKJM1aVpB4+nbb9SgYQ88
	RpFqBZQLnIuu26udS+i7xKghrY7cnxLZ/E2lVqEH+KUKblwk4H5zfOftdEY1v7p6VXSDzyXUZO6
	F/JxW/9XHvLbnfCqeF90gPgiEb/4TTAWzZTdaZz0fp/F8ar0SE1efyu8ihDNy8NGxMnTagASgP2
	ddI82ufR998MYv9t+XncxYS29zndunr/RARA==
X-Google-Smtp-Source: AGHT+IFdRQs7bHLh1E5GT7QAnWszys0fTMB9CbEufcgQwcyAxVmKIEujggJxTUyflBXBdYRKNA2OIg==
X-Received: by 2002:a05:6a20:3d07:b0:334:a9ff:ca32 with SMTP id adf61e73a8af0-348c9f671cemr16753279637.2.1762189275979;
        Mon, 03 Nov 2025 09:01:15 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4f8d1esm10879177a12.26.2025.11.03.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:01:15 -0800 (PST)
Subject: [net-next PATCH v2 11/11] fbnic: Replace use of internal PCS w/
 Designware XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:01:14 -0800
Message-ID: 
 <176218927450.2759873.3311899705462681552.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

As we have exposed the PCS registers via the SWMII we can now start looking
at connecting the XPCS driver to those registers and let it mange the PCS
instead of us doing it directly from the fbnic driver.

For now this just gets us the ability to detect link. The hop is in the
future to add some of the vendor specific registers to being enabling XPCS
configuration of the interface.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/Kconfig               |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    7 --
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  101 +++++++++++------------
 4 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index 23676b530a83..adb8ae29167a 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -27,6 +27,7 @@ config FBNIC
 	select FBNIC_PHY
 	select NET_DEVLINK
 	select PAGE_POOL
+	select PCS_XPCS
 	select PHYLINK
 	select PLDMFW
 	help
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 51cf88b62927..949901f51638 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -713,10 +713,7 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
  **/
 void fbnic_netdev_free(struct fbnic_dev *fbd)
 {
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
-
-	if (fbn->phylink)
-		phylink_destroy(fbn->phylink);
+	fbnic_phylink_destroy(fbd->netdev);
 
 	free_netdev(fbd->netdev);
 	fbd->netdev = NULL;
@@ -818,7 +815,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netif_tx_stop_all_queues(netdev);
 
-	if (fbnic_phylink_init(netdev)) {
+	if (fbnic_phylink_create(netdev)) {
 		fbnic_netdev_free(fbd);
 		return NULL;
 	}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index f8807f6e443d..8ac0e0c8ddf5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -44,7 +44,7 @@ struct fbnic_net {
 
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
-	struct phylink_pcs phylink_pcs;
+	struct phylink_pcs *pcs;
 
 	u8 aui;
 	u8 fec;
@@ -106,7 +106,8 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 					struct ethtool_link_ksettings *cmd);
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
-int fbnic_phylink_init(struct net_device *netdev);
+int fbnic_phylink_create(struct net_device *netdev);
+void fbnic_phylink_destroy(struct net_device *netdev);
 int fbnic_phylink_connect(struct fbnic_net *fbn);
 void fbnic_phylink_pmd_training_complete_notify(struct fbnic_net *fbn);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 59ee2fb32f91..28cd11e111e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 
@@ -101,55 +102,6 @@ int fbnic_phylink_get_fecparam(struct net_device *netdev,
 	return 0;
 }
 
-static struct fbnic_net *
-fbnic_pcs_to_net(struct phylink_pcs *pcs)
-{
-	return container_of(pcs, struct fbnic_net, phylink_pcs);
-}
-
-static void
-fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
-			    struct phylink_link_state *state)
-{
-	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
-	struct fbnic_dev *fbd = fbn->fbd;
-
-	switch (fbn->aui) {
-	case FBNIC_AUI_25GAUI:
-		state->speed = SPEED_25000;
-		break;
-	case FBNIC_AUI_LAUI2:
-	case FBNIC_AUI_50GAUI1:
-		state->speed = SPEED_50000;
-		break;
-	case FBNIC_AUI_100GAUI2:
-		state->speed = SPEED_100000;
-		break;
-	default:
-		state->link = 0;
-		return;
-	}
-
-	state->duplex = DUPLEX_FULL;
-
-	state->link = !!(rd32(fbd, FBNIC_PCS(MDIO_STAT1, 0)) &
-			 MDIO_STAT1_LSTATUS);
-}
-
-static int
-fbnic_phylink_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
-			 phy_interface_t interface,
-			 const unsigned long *advertising,
-			 bool permit_pause_to_mac)
-{
-	return 0;
-}
-
-static const struct phylink_pcs_ops fbnic_phylink_pcs_ops = {
-	.pcs_config = fbnic_phylink_pcs_config,
-	.pcs_get_state = fbnic_phylink_pcs_get_state,
-};
-
 static struct phylink_pcs *
 fbnic_phylink_mac_select_pcs(struct phylink_config *config,
 			     phy_interface_t interface)
@@ -157,7 +109,7 @@ fbnic_phylink_mac_select_pcs(struct phylink_config *config,
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
-	return &fbn->phylink_pcs;
+	return fbn->pcs;
 }
 
 static int
@@ -226,16 +178,35 @@ static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
 	.mac_link_up = fbnic_phylink_mac_link_up,
 };
 
-int fbnic_phylink_init(struct net_device *netdev)
+/**
+ * fbnic_phylink_create - Phylink device creation
+ * @netdev: Network Device struct to attach phylink device
+ *
+ * Initialize and attach a phylink instance to the device. The phylink
+ * device will make use of the netdev struct to track carrier and will
+ * eventually be used to expose the current state of the MAC and PCS
+ * setup.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int fbnic_phylink_create(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
+	struct phylink_pcs *pcs;
 	struct phylink *phylink;
+	int err;
 
-	fbn->phylink_pcs.ops = &fbnic_phylink_pcs_ops;
+	pcs = xpcs_create_pcs_mdiodev(fbd->mdio_bus, 0);
+	if (IS_ERR(pcs)) {
+		err = PTR_ERR(pcs);
+		dev_err(fbd->dev, "Failed to create PCS device: %d\n", err);
+		return err;
+	}
 
 	fbn->phylink_config.dev = &netdev->dev;
 	fbn->phylink_config.type = PHYLINK_NETDEV;
+
 	fbn->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 					       MAC_25000FD | MAC_50000FD |
 					       MAC_100000FD;
@@ -255,10 +226,16 @@ int fbnic_phylink_init(struct net_device *netdev)
 	phylink = phylink_create(&fbn->phylink_config, NULL,
 				 fbnic_phylink_select_interface(fbn->aui),
 				 &fbnic_phylink_mac_ops);
-	if (IS_ERR(phylink))
-		return PTR_ERR(phylink);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		dev_err(netdev->dev.parent,
+			"Failed to create Phylink interface, err: %d\n", err);
+		xpcs_destroy_pcs(pcs);
+		return err;
+	}
 
 	fbn->phylink = phylink;
+	fbn->pcs = pcs;
 
 	return 0;
 }
@@ -296,6 +273,22 @@ int fbnic_phylink_connect(struct fbnic_net *fbn)
 	return err;
 }
 
+/**
+ * fbnic_phylink_destroy - Teardown phylink related interfaces
+ * @netdev: Network Device struct containing phylink device
+ *
+ * Detach and free resources related to phylink interface.
+ **/
+void fbnic_phylink_destroy(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (fbn->phylink)
+		phylink_destroy(fbn->phylink);
+	if (fbn->pcs)
+		xpcs_destroy_pcs(fbn->pcs);
+}
+
 /**
  * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
  * @fbn: FBNIC Netdev private data struct phylink device attached to



