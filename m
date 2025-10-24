Return-Path: <netdev+bounces-232687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2877C08182
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0633F3AC693
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5262F7AC4;
	Fri, 24 Oct 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1rGpsVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6942F691B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338485; cv=none; b=OyfzbfUAXPYOC7hjI2tNb4yfzsG0X/xf0vG2g80LivQSKi+Vu3d541VnWRKfoxIGZFMCHTiFzAOJjhCXd9mJ72jPGV8zNdlIYxUy1AxNSUivuXoFeHAG4C6rqHM1xwDhMWXjTNRMPXE2nNtiDTGT3MWHMpUTEiVGS0MLR8loGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338485; c=relaxed/simple;
	bh=MHkTq5w5KkGwSDSAK9GI+tCltijD2oUbMlAt5W+MZN8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcoTElrSUiy0rB0960EvUVXuWrZNpjcCdvpIeMpUtaROnGKPaBDFU7ntZgVEm2HVhfQRkA4iLoKJmiKx7ydAliYaiYkh35rIGPm94FCKDZSFs78Ae1VFIkxpj/MZJeEARnvX61DMkkJAiV9b937Mbdgq2XNYaIXhNjnNF8cM0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1rGpsVY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so3239435b3a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338484; x=1761943284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pr3psjHOUj4NN/Za1ITJFF7u8OMQ3sd1Kzql1cQsm+E=;
        b=k1rGpsVYQwu9ox/FMXeVaqRbEqxMSuFihaQE5YI9Y6cvW/u0h8mt2RewHAXtvmJW1j
         56nJaNvphPrcd4j19P9zeRoeJLEaa8v5DoBHqa4lsy7WhBlOGHIdrvJTHDHyRBMvbvGz
         yQCCwXxMrY3igQQ9C2zibEZlBSWfS+WGruXbq4PA0h+VG3ePxzICXYwUMN8PP1843ohO
         kVoV5spanSsfRJXWUcwqX2EmiJBm6/vZAIQ2UD7zuGQ7rXLtj9Z1vtJAk6cpPwZ+5OFv
         VmFQpXDP727KkRya78wvw6DouoYj1bqYHbbgu9e7AO26Ub0frh4r4InsvBv0fv6f6vZ9
         RISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338484; x=1761943284;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr3psjHOUj4NN/Za1ITJFF7u8OMQ3sd1Kzql1cQsm+E=;
        b=GtQGsb/TWXgap8fWsXJnUdihj92uI2oymHt2/UFsfHZIVuX8QOixk9bP7VBtXiGlFK
         BAsrJSSHEfEr0TFhoEXkBx06c3QvkE8Oh3T7gQF9Ab/HoxE9W0XDq15WbgiEf6NshtLA
         92xQ/xTeN3XTCUbXMkhxlFHe5h0UGfHf4RxGexTqAIqG7R5gIXjaALZ2ywyT1T72U4Oc
         URjRsgmJ93dPwxmDqP6vFAOhXHqfMvx9IdK+SQeidEhy3cylIl1zAMU3RQAEGnKK7viM
         5cKLylLBkpZGqEBfVhzlK3VPvhXYslcnGQj+EBdJmGFSl7I2v+K3duYJY/KqHfp5tikC
         VbVQ==
X-Gm-Message-State: AOJu0Yw7gX2jx7tLCWFoT/AU8EbSTfzWVV+JwLWxR/xK+5AXWatvDNj6
	zdOGyEqgW+Bafl9dcOeq/yA/DIWpBoqkqN6PTaK8+SjvQz41Y9pDEfp4
X-Gm-Gg: ASbGnctO4nWUl0+Q6CF3Zbd4UB4j9yZ+OWp+mB4M6Nyj7QwtbFrWqAiRt26C+IQevFx
	t/GAmrTuFBwlAVhIH++bAPsH5iQl1T58e7ZutlYuJYHmS01SNWPGphV002GMYxw4V1lyn8s9B7e
	HeZW0XkLMbxl0yB0FFta0/wPvfOtFxsYKCYPVI7cqkFuk/OF5ob0tZX+8px/6vGghSFDRdUjZ2h
	qMA/6SZnfml7ms9bXhCYap20QBD3UeCgkcdCiJizLHacP/7U54EXFkpPS8LIssm8Ub5mvXBOKUZ
	PnOPqNqJcWRkE/gM6Uym6URaPAWy4OPzMevn0YBL1RqCzKe/Zg43ct/65+AZnmfX1xFI28+aq33
	EMREzpuM2aR5s/u9jXMnIFdFpm+Ciy72VaZXO/2zbzXlBprgX7ym/QhR5HLLX9rDf7UbsDQrymO
	1Vj3KTbYUSCv1DqgJ1tmNVJa97epGpjtJ3KjsnqHKrxR1m
X-Google-Smtp-Source: AGHT+IFrwCqV5NjE1CGTDMTyETtCFUAufcwsIzMpi+MCIDZVcViMxLOWoFs4IQz7grhlO6c8rP5gBg==
X-Received: by 2002:a05:6a20:7285:b0:341:ea4:b999 with SMTP id adf61e73a8af0-3410ea5e90fmr328085637.60.1761338483538;
        Fri, 24 Oct 2025 13:41:23 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm132307b3a.8.2025.10.24.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:23 -0700 (PDT)
Subject: [net-next PATCH 7/8] fbnic: Add SW shim for MII interface to PMA/PMD
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:41:21 -0700
Message-ID: 
 <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
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

In order for us to support a phydev device we need to add an MII bus to
allow the phydev driver to have access to the registers for the device.
This change adds such an interface, currently as a read only interface for
a single PHY.

The plan is in the future to extend out this interface adding RSFEC support
to the PMA, and eventually adding PCS register access through a remapping
of our CSRs which will essentialy convert the standard c45 offsets to ones
matching the setup within our device.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h       |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |    3 +
 drivers/net/ethernet/meta/fbnic/fbnic_swmii.c |  145 +++++++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_swmii.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 15e8ff649615..b15616c3523c 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -21,6 +21,7 @@ fbnic-y := fbnic_csr.o \
 	   fbnic_pci.o \
 	   fbnic_phylink.o \
 	   fbnic_rpc.o \
+	   fbnic_swmii.o \
 	   fbnic_time.o \
 	   fbnic_tlv.o \
 	   fbnic_txrx.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 783a1a91dd25..4a77ea12ddec 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -95,6 +95,9 @@ struct fbnic_dev {
 	u64 prev_firmware_time;
 
 	struct fbnic_fw_log fw_log;
+
+	/* SW MII bus for FW PHY */
+	struct mii_bus *mii_bus;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
@@ -204,6 +207,8 @@ void fbnic_dbg_exit(void);
 
 void fbnic_rpc_reset_valid_entries(struct fbnic_dev *fbd);
 
+int fbnic_swmii_create(struct fbnic_dev *fbd);
+
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 428fc861deff..a5390996393c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -339,6 +339,9 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_failure_mode;
 	}
 
+	if (fbnic_swmii_create(fbd))
+		goto init_failure_mode;
+
 	netdev = fbnic_netdev_alloc(fbd);
 	if (!netdev) {
 		dev_err(&pdev->dev, "Netdev allocation failed\n");
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_swmii.c b/drivers/net/ethernet/meta/fbnic/fbnic_swmii.c
new file mode 100644
index 000000000000..7698fb60f660
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_swmii.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/mdio.h>
+
+#include "fbnic.h"
+#include "fbnic_netdev.h"
+
+static int
+fbnic_swmii_read_pmapmd(struct fbnic_dev *fbd, int regnum)
+{
+	u16 ctrl1 = 0, ctrl2 = 0;
+	struct fbnic_net *fbn;
+	int ret = 0;
+	u8 aui;
+
+	if (fbd->netdev) {
+		fbn = netdev_priv(fbd->netdev);
+		aui = fbn->aui;
+	}
+
+	switch (aui) {
+	case FBNIC_AUI_25GAUI:
+		ctrl1 = MDIO_CTRL1_SPEED25G;
+		ctrl2 = MDIO_PMA_CTRL2_25GBCR;
+		break;
+	case FBNIC_AUI_LAUI2:
+		ctrl1 = MDIO_CTRL1_SPEED50G;
+		ctrl2 = MDIO_PMA_CTRL2_50GBCR2;
+		break;
+	case FBNIC_AUI_50GAUI1:
+		ctrl1 = MDIO_CTRL1_SPEED50G;
+		ctrl2 = MDIO_PMA_CTRL2_50GBCR;
+		break;
+	case FBNIC_AUI_100GAUI2:
+		ctrl1 = MDIO_CTRL1_SPEED100G;
+		ctrl2 = MDIO_PMA_CTRL2_100GBCR2;
+		break;
+	default:
+		break;
+	}
+
+	switch (regnum) {
+	case MDIO_CTRL1:
+		ret = ctrl1;
+		break;
+	case MDIO_STAT1:
+		ret = fbd->pmd_state == FBNIC_PMD_SEND_DATA ?
+		      MDIO_STAT1_LSTATUS : 0;
+		break;
+	case MDIO_DEVS1:
+		ret = MDIO_DEVS_PMAPMD;
+		break;
+	case MDIO_CTRL2:
+		ret = ctrl2;
+		break;
+	case MDIO_STAT2:
+		ret = MDIO_STAT2_DEVPRST_VAL |
+		      MDIO_PMA_STAT2_EXTABLE;
+		break;
+	case MDIO_PMA_EXTABLE:
+		ret = MDIO_PMA_EXTABLE_40_100G |
+		      MDIO_PMA_EXTABLE_25G;
+		break;
+	case MDIO_PMA_40G_EXTABLE:
+		ret = MDIO_PMA_40G_EXTABLE_50GBCR2;
+		break;
+	case MDIO_PMA_25G_EXTABLE:
+		ret = MDIO_PMA_25G_EXTABLE_25GBCR;
+		break;
+	case MDIO_PMA_50G_EXTABLE:
+		ret = MDIO_PMA_50G_EXTABLE_50GBCR;
+		break;
+	case MDIO_PMA_EXTABLE2:
+		ret = MDIO_PMA_EXTABLE2_50G;
+		break;
+	case MDIO_PMA_100G_EXTABLE:
+		ret = MDIO_PMA_100G_EXTABLE_100GBCR2;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int
+fbnic_swmii_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
+{
+	struct fbnic_dev *fbd = bus->priv;
+
+	if (addr != 0)
+		return 0xffff;
+
+	if (devnum == MDIO_MMD_PMAPMD)
+		return fbnic_swmii_read_pmapmd(fbd, regnum);
+
+	return 0xffff;
+}
+
+static int
+fbnic_swmii_write_c45(struct mii_bus *bus, int addr, int devnum,
+		      int regnum, u16 val)
+{
+	/* Currently PHY setup is meant to be read-only */
+	return 0;
+}
+
+/**
+ * fbnic_swmii_create - Create a swmii to allow interfacing phydev w/ FW PHY
+ * @fbd: Pointer to FBNIC device structure to populate bus on
+ *
+ * Initialize an MII bus and place a pointer to it on the fbd struct. This bus
+ * will be used to interface with the PMA/PMD for now, and may add support for
+ * the PCS in the future.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int fbnic_swmii_create(struct fbnic_dev *fbd)
+{
+	struct mii_bus *bus;
+	int err;
+
+	bus = devm_mdiobus_alloc(fbd->dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "fbnic_mii_bus";
+	bus->read_c45 = &fbnic_swmii_read_c45;
+	bus->write_c45 = &fbnic_swmii_write_c45;
+	bus->parent = fbd->dev;
+	bus->phy_mask = GENMASK(31, 1);
+	bus->priv = fbd;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(fbd->dev));
+
+	err = devm_mdiobus_register(fbd->dev, bus);
+	if (err) {
+		dev_err(fbd->dev, "Failed to create MDIO bus: %d\n", err);
+		return err;
+	}
+
+	fbd->mii_bus = bus;
+
+	return 0;
+}



