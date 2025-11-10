Return-Path: <netdev+bounces-237263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0CC47D16
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC6754F1A0B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA0277C9A;
	Mon, 10 Nov 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ9iZFiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1797279DB1
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790535; cv=none; b=VQS/5/4xozDZW/SozXuMum+jnhnj/Jc2o3/RAh/nNtAs7QzDRWh1VRaQsTsessDcejSR1+SMWCEijcGmbP2jWNrOtqoIWYOeRyQ3GUepQKqy0638+X+8k7kcwDuGOm/pOoCxZm2LpcT/l/vS8N4rrn4bZ5580BB8BMBvucofjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790535; c=relaxed/simple;
	bh=sHhrzAfLMB9xUtBdjScQshjit/fi3WqZTotpnb7tg0A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATA6SByC53i1kWLsV6qzDsgOceN7TafL/2zZSsC+/tsEQqjgpURBl8eK8dlLN/gpOEZ3mR2nS/dY5wsELpPYMAyZ/hyUSUia5YjpOyqOI1Gn1SPJP4Khz0/i2KPzZcQPhmGZ7/aejXNZ7n5uiolc45Kd9iX2XypVMhM65gumTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ9iZFiJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b550eff972eso1873163a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790532; x=1763395332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=378CvQzORWXRuJZwkSj1ctKhT3bdYrfd/uZ3cPX6Z58=;
        b=IQ9iZFiJxbSXYnSWG6YSEnDDhmWPmQWA7ML1WeO9mP2D2PnfMwK65Wu7Q4Geq2qlMD
         D0RGr8sxvdjz1a6YnSM+tSRAc3mReoByr68At/tFO/dZYxXNzMuCdejHyhr+ykCPmW/C
         M5X6M4R73SoycVurVkAU8WXPvnw2Bu5Og53+s0IYwoW0zkgoARKf9xInwfTEZlBFEXR5
         gvWuRsaoocwfsSqDIhY0RvxllcZgs7bur5vCq3+VIri0gNCvfoz7DU+YRDzO5EbkHEwi
         /BJ06rHMwN2onntXqdA8k5IUxII7ytMBK7x2CzcHcR4DSZdoD4OuOM/xZSVnlNmPX2vL
         q62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790532; x=1763395332;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=378CvQzORWXRuJZwkSj1ctKhT3bdYrfd/uZ3cPX6Z58=;
        b=P8pMcBz0HgXxWt85biTnkt20jSNrCCvOo89O/XdhK85k1p2Erzh3AeBuBOTDd6Gi4n
         urdhWFTRZutbjnKRLPJJL+2ysjOXatPEQAHp2HyN1i8vdmBJYsHtWbl8fHCtwYjCvujf
         1hswjGRSMzfRUt/xAONVEnQHvJflJZdi/ofnoPtXnOOfA+hLAwinJibpGKEZAU7e6Nsb
         1qdcRXmpTq7CQrM7mTefil6DfKImHbTG7vQyRWLJZoHDah+FQPhP8icioMgRMi/C4GBo
         UJzheyyro9pVuO8AiYUP0PHsbssjECIBWiuh6KH46k9mvg8vJ1eE34XFMID9Yb6Cq40i
         6kNw==
X-Gm-Message-State: AOJu0Yw+D6LfAKrtA9FSTXfQIMK/KeaZiUhSJMMJP1DV7eNKZTmsThA7
	iFStkHOL+kIU8RoUTveJXclmKsjoBe4qZfp8ocoXjtHF6MbIIoi0ViIlw1/3Tw==
X-Gm-Gg: ASbGncu6CKb71EdJa8cc38T8hfn1ByNVNdAex6Am7bhdjOxZqHIpVYf7z50V86dBKdr
	4SPXGloOj4UEm1/vf2HMlGEQSfSD3VIcwiNJQcbd/hyBJ2dvt9nY9jRfbwQ6BA3fKMpPHkMcM76
	JsgXlJ/80YVKaDCln3ysTs5V5bVG/QvZUjK8v8lQDdQcA8Pveygmmw+v9T63ghK385kC55a+TH+
	SjB3xedHV4zikK4KLLiE6x8fXVgdmoMiKOhZbLPj+N/B8oUymUcsok23wFtrCcsZpdmBTC9fEsh
	chogbc/51tKRVl+ZCuqbOIgGwF9YzsZ2MCUHqKwUWFNJ1pSOo9J2maNBfR9zCz8tCGP100lqnbq
	5s0LMHS71fNuWktowkrdXJh0emCIRZhwa8MuHFUBSldOe0FMGYmEfXEudtHyV1OReR8fnI8FwIc
	UUNqRvKWS6blAJVDVfGqJAM5Zb93TkIVPFqB4406bUtY2n
X-Google-Smtp-Source: AGHT+IFFS7qoc+sKO7s7yJlr+M3siXx5VrfCN8e2hHTgUwuYG3tX31+dlCV0pmy1xqOX33zQfVrG5w==
X-Received: by 2002:a17:902:ea10:b0:290:91d2:9304 with SMTP id d9443c01a7336-297e5411b0emr102012345ad.4.1762790531718;
        Mon, 10 Nov 2025 08:02:11 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297ed6808ddsm76806025ad.17.2025.11.10.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:02:10 -0800 (PST)
Subject: [net-next PATCH v3 10/10] fbnic: Replace use of internal PCS w/
 Designware XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:02:09 -0800
Message-ID: 
 <176279052948.2130772.667088346078043043.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    7 --
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  104 +++++++++++------------
 5 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index dff51f23d295..ca5c7ac2a5bc 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -26,6 +26,7 @@ config FBNIC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DEVLINK
 	select PAGE_POOL
+	select PCS_XPCS
 	select PHYLINK
 	select PLDMFW
 	help
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 73dd10b7a1a8..f2ccb33fa67a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -143,7 +143,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 		 */
 		if (netif_carrier_ok(fbd->netdev))
 			fbn->link_down_events += link_down_event;
-		phylink_pcs_change(&fbn->phylink_pcs, false);
+		phylink_pcs_change(fbn->pcs, false);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 65318a5b466e..81c9d5c9a4b2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -697,10 +697,7 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
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
@@ -802,7 +799,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netif_tx_stop_all_queues(netdev);
 
-	if (fbnic_phylink_init(netdev)) {
+	if (fbnic_phylink_create(netdev)) {
 		fbnic_netdev_free(fbd);
 		return NULL;
 	}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index c2e45ff64e34..54a8bf172fa6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -44,7 +44,7 @@ struct fbnic_net {
 
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
-	struct phylink_pcs phylink_pcs;
+	struct phylink_pcs *pcs;
 
 	u8 aui;
 	u8 fec;
@@ -106,6 +106,8 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 					struct ethtool_link_ksettings *cmd);
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
+int fbnic_phylink_create(struct net_device *netdev);
+void fbnic_phylink_destroy(struct net_device *netdev);
 int fbnic_phylink_init(struct net_device *netdev);
 void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 592e9642a418..188155f43416 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 
@@ -101,56 +102,6 @@ int fbnic_phylink_get_fecparam(struct net_device *netdev,
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
-	state->link = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) &&
-		      (rd32(fbd, FBNIC_PCS(MDIO_STAT1, 0)) &
-		       MDIO_STAT1_LSTATUS);
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
@@ -158,7 +109,7 @@ fbnic_phylink_mac_select_pcs(struct phylink_config *config,
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
-	return &fbn->phylink_pcs;
+	return fbn->pcs;
 }
 
 static int
@@ -227,13 +178,33 @@ static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
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
+
+	pcs = xpcs_create_pcs_mdiodev(fbd->mdio_bus, 0);
+	if (IS_ERR(pcs)) {
+		err = PTR_ERR(pcs);
+		dev_err(fbd->dev, "Failed to create PCS device: %d\n", err);
+		return err;
+	}
 
-	fbn->phylink_pcs.ops = &fbnic_phylink_pcs_ops;
+	fbn->pcs = pcs;
 
 	fbn->phylink_config.dev = &netdev->dev;
 	fbn->phylink_config.type = PHYLINK_NETDEV;
@@ -256,14 +227,35 @@ int fbnic_phylink_init(struct net_device *netdev)
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
 
 	return 0;
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
  * @netdev: Netdev struct phylink device attached to
@@ -287,5 +279,5 @@ void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev)
 
 	fbd->pmd_state = FBNIC_PMD_SEND_DATA;
 
-	phylink_pcs_change(&fbn->phylink_pcs, false);
+	phylink_pcs_change(fbn->pcs, false);
 }



