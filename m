Return-Path: <netdev+bounces-235200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B8C2D636
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6013A84CD
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671F31A562;
	Mon,  3 Nov 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6GOp6LO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4E31815E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189270; cv=none; b=h9UEy1T/5ajDqvdRNt4xrIFSayYQ/mfrbwk564pc3Esycx5R85Eh7frcz4WOOLUwRY9rZDqW9NrQOf28Is1kzOhnX1qMOxe7KoLsKy+Ir2a12QBY2NBDCTkc2xLw/KmB98T837qhnbwUfOzSFBj/b/FuRprOfWvbhXk2/+nE2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189270; c=relaxed/simple;
	bh=LRlL/ZFgbw+bmbneha5D79/53vhLnk9HGi8W2iP1M+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6MqE5S779rUPDBzCe2Fhj8Xbp/9NFSQFwiP/oxhObNC0ICxuD4aAemzLyBcv3wmAX/sz1ho4R0QSVumI/a0vNjp9Pda+v3KE/fzWZnwXMoxwDPL+dmWevWMAHMjwkXTgBPURYRUrvqe8CXh2cmEtBNV85L8HCgKTtINhnwBcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6GOp6LO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so57299815ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189265; x=1762794065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CXsiElMu2IwtzgoxsKhf8wQ0QIUJBvd8ARc/F5CyKUQ=;
        b=e6GOp6LOWI6Q/kRa/J9dcZOnYdzTIM+9Uf88jDJNf7KEFuaeXxL2Dx3qzhQLZ+0SmZ
         mShGRSFzbQKVneGJthnz15LTIFaVNT/ThZg4zvZF392ahtFZ9RGUtiBSNFZ/wzHXMSyc
         Jo+wTMfm++wetrWsDBGqhWBfNFY9pxPf4io8LHwbRRQ0zPxWL06eJZRXZDYRL1WhBO3w
         sGvtUkRviTYlKABJiisEKg0iWTwufNSXNdwmrASaQD6VH4jGNJQS/mZZP672K+lA7Hpv
         ECa11cWk5KFbC09lCfYrm0btm1birFs6HOAGD2Ar3UpC0cYOeF4BtOosD+wL1FyyYEOa
         51/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189265; x=1762794065;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXsiElMu2IwtzgoxsKhf8wQ0QIUJBvd8ARc/F5CyKUQ=;
        b=XBTIzTB6LzSaif+754tu9G1dviyiwUKvYQdkzVlR08YnZF4IfGLye4enjT9dBuafz5
         qrpVFmgWKcVav9SsdYZV+b3dTUZjR4Ep42NqEA3UQEq8Ap51d6EY9nkTV7Yv2Gf55GjK
         qh1hJ5Mvz/+f8jEsZlJUuhLGJHpKKI0OvRM249Ea5955E9NXWksrBmLTWydCdZeLzagR
         kAukSLGLfJUH6oBH9HHoaja9qSC7nk9D44i1eKpw3A/OIjgYLQ4Z19n/1f+IlDsVIF6/
         FupcmIbSfVxOWqNma0lLp7yDnNxVhcpVSmgFPS8JcGVRouZXc4GPINuIF3MTNsEJK2Eg
         5H3w==
X-Gm-Message-State: AOJu0YznKtaAJJ3v9fuGjIwMDI0cFmOJTovv6IHKOHdSmj0xYP5FpalV
	P6WIB0RacWLu1B7L0N7dX/szkRKQ36m2h3TpT1xbKIDSJh1A94N7cetMmLve/Q==
X-Gm-Gg: ASbGncvTiopDXrtj+i6XKFdhX9fOp/chwyS8JU4H5X8qp8eg7GBGo8fzamCfuqU+H4t
	jKJn/jOM/OMDjatPU6kkcAsuT2a2wgylJgE3eZPHsP/SIgMQCAfjeoLDY11gQoDX+fdgAiqpDFJ
	EV8BzY79eHZvj5MAebfwFvLLvcBbm3pHGZioYaNJGfIiyi2Hb0m/H+3t/hJ9cbKdl4rLe8k5Kp0
	kcsbecr9vreMlqUqVmKdVTEbfImrjMT42lkpQjbdjN742VTIZPrlD9gy70/UvEIBMXULC8GNHOq
	xJ4iJTevkWEJj3Xqz3xr1UOkMrPK6wzxOHTuopOPkBam9VMdJGTLnLHSnL0xWZRr/6DOjyPGMVS
	Z1rWXHPv4tpit4Qlb9t7+AM6wcbH2czCk8o+3SR5B21vvTOylMf842eKRiiRZFhKbBZ0AnF80mt
	pfegjE/kT4pUXROU4u91pSG9KmGS2J0/ywSUNPqNUFJSBa
X-Google-Smtp-Source: AGHT+IEi6pGAGINqkd2/Y3GGf+UzghSkOG9Iukky48SVZLwCwq4wqjh5t7LhHDZnVcs7gtFsJe5JDg==
X-Received: by 2002:a17:902:db0d:b0:271:45c0:9ec8 with SMTP id d9443c01a7336-2951a496af4mr179299465ad.37.1762189262597;
        Mon, 03 Nov 2025 09:01:02 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf44dea1sm10942059a12.38.2025.11.03.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:01:02 -0800 (PST)
Subject: [net-next PATCH v2 09/11] fbnic: Add SW shim for MDIO interface to
 PMA/PMD and PCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:01:01 -0800
Message-ID: 
 <176218926115.2759873.9672365918256502904.stgit@ahduyck-xeon-server.home.arpa>
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

In order for us to support a phydev and PCS device we need to add an MDIO
bus to allow the drivers to have access to the registers for the device.
This change adds such an interface.

The interface will consist of 2 PHYs each consisting of a PMA/PMD and a PCS
located at addresses 0 and 1. There is a need for 2 PHYs due to the fact
that in order to support the 2 lane modes we will needed to access and
configure the PCS vendor registers and RSFEC registers from the second lane
identical to the first.

One side effect of this is that we have to report config values for both
lanes of the PHY as those registers can be poked and technically they would
be valid. For now I am going to have the second lane report speeds
equivalent to the given config for 2 lanes as we should be configuring both
lanes identical for the 2 lane modes.

The plan is in the future to extend out this interface adding RSFEC support
to the PMA through a remapping our CSRs which will essentially convert the
standard c45 offsets to ones matching the setup within our device.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile     |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h      |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h  |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c |  190 ++++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c  |    3 
 5 files changed, 200 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 15e8ff649615..72c41af65364 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -21,6 +21,7 @@ fbnic-y := fbnic_csr.o \
 	   fbnic_pci.o \
 	   fbnic_phylink.o \
 	   fbnic_rpc.o \
+	   fbnic_mdio.o \
 	   fbnic_time.o \
 	   fbnic_tlv.o \
 	   fbnic_txrx.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 783a1a91dd25..4ed677f3232d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -95,6 +95,9 @@ struct fbnic_dev {
 	u64 prev_firmware_time;
 
 	struct fbnic_fw_log fw_log;
+
+	/* MDIO bus for PHYs */
+	struct mii_bus *mdio_bus;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
@@ -204,6 +207,8 @@ void fbnic_dbg_exit(void);
 
 void fbnic_rpc_reset_valid_entries(struct fbnic_dev *fbd);
 
+int fbnic_mdiobus_create(struct fbnic_dev *fbd);
+
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 2b08046645f2..2a9440df5e1d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -55,6 +55,7 @@ enum {
 	FBNIC_AUI_50GAUI1	= 2,	/* 53.125GBd	53.125   * 1 */
 	FBNIC_AUI_100GAUI2	= 3,	/* 106.25GBd	53.125   * 2 */
 	FBNIC_AUI_UNKNOWN	= 4,
+	__FBNIC_AUI_MAX__
 };
 
 #define FBNIC_AUI_MODE_R2	(FBNIC_AUI_LAUI2)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
new file mode 100644
index 000000000000..80f2e8d2dca4
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/mdio.h>
+#include <linux/pcs/pcs-xpcs.h>
+
+#include "fbnic.h"
+#include "fbnic_netdev.h"
+
+#define DW_VENDOR		BIT(15)
+#define FBNIC_PCS_VENDOR	BIT(9)
+#define FBNIC_PCS_ZERO_MASK	(DW_VENDOR - FBNIC_PCS_VENDOR)
+
+static int
+fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	int ret;
+
+	/* Report 0 for unsupported registers */
+	if (regnum & FBNIC_PCS_ZERO_MASK)
+		return 0;
+
+	/* Intercept and return correct ID for PCS */
+	if (regnum == MDIO_DEVID1)
+		return DW_XPCS_ID >> 16;
+	if (regnum == MDIO_DEVID2)
+		return DW_XPCS_ID & 0xffff;
+	if (regnum == MDIO_DEVS1)
+		return MDIO_DEVS_PMAPMD | MDIO_DEVS_PCS;
+
+	/* Swap vendor page bit for FBNIC PCS vendor page bit */
+	if (regnum & DW_VENDOR)
+		regnum ^= DW_VENDOR | FBNIC_PCS_VENDOR;
+
+	ret = fbnic_rd32(fbd, FBNIC_PCS_PAGE(addr) + regnum);
+
+	dev_dbg(fbd->dev,
+		"SWMII PCS Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, ret);
+
+	return ret;
+}
+
+static int
+fbnic_mdio_read_pmapmd(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	u16 ctrl1[__FBNIC_AUI_MAX__][2] = {
+		{ MDIO_CTRL1_SPEED25G, MDIO_CTRL1_SPEED50G },
+		{ MDIO_CTRL1_SPEED50G, MDIO_CTRL1_SPEED50G },
+		{ MDIO_CTRL1_SPEED50G, MDIO_CTRL1_SPEED100G },
+		{ MDIO_CTRL1_SPEED100G, MDIO_CTRL1_SPEED100G },
+		{ 0, 0 }};
+	u8 aui = FBNIC_AUI_UNKNOWN;
+	struct fbnic_net *fbn;
+	int ret = 0;
+
+	if (fbd->netdev) {
+		fbn = netdev_priv(fbd->netdev);
+		if (fbn->aui < FBNIC_AUI_UNKNOWN)
+			aui = fbn->aui;
+	}
+
+	switch (regnum) {
+	case MDIO_CTRL1:
+		ret = ctrl1[aui][addr & 1];
+		break;
+	case MDIO_STAT1:
+		ret = fbd->pmd_state == FBNIC_PMD_SEND_DATA ?
+		      MDIO_STAT1_LSTATUS : 0;
+		break;
+	case MDIO_DEVID1:
+		ret = MP_FBNIC_XPCS_PMA_100G_ID >> 16;
+		break;
+	case MDIO_DEVID2:
+		ret = MP_FBNIC_XPCS_PMA_100G_ID & 0xffff;
+		break;
+	case MDIO_DEVS1:
+		ret = MDIO_DEVS_PMAPMD | MDIO_DEVS_PCS;
+		break;
+	case MDIO_STAT2:
+		ret = MDIO_STAT2_DEVPRST_VAL;
+		break;
+	default:
+		break;
+	}
+
+	dev_dbg(fbd->dev,
+		"SWMII PMAPMD Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, ret);
+
+	return ret;
+}
+
+static int
+fbnic_mdio_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
+{
+	struct fbnic_dev *fbd = bus->priv;
+
+	if (addr & ~1)
+		return 0xffff;
+
+	if (devnum == MDIO_MMD_PCS)
+		return fbnic_mdio_read_pcs(fbd, addr, regnum);
+
+	if (devnum == MDIO_MMD_PMAPMD)
+		return fbnic_mdio_read_pmapmd(fbd, addr, regnum);
+
+	return 0xffff;
+}
+
+static void
+fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	/* Report 0 for unsupported registers */
+	if (regnum & FBNIC_PCS_ZERO_MASK)
+		return;
+
+	/* Swap vendor page bit for FBNIC PCS vendor page bit */
+	if (regnum & DW_VENDOR)
+		regnum ^= DW_VENDOR | FBNIC_PCS_VENDOR;
+
+	fbnic_wr32(fbd, FBNIC_PCS_PAGE(addr) + regnum, val);
+
+	dev_dbg(fbd->dev,
+		"SWMII PCS Wr: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, val);
+}
+
+static void
+fbnic_mdio_write_pmapmd(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	dev_dbg(fbd->dev,
+		"SWMII PMAPMD Wr: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, val);
+}
+
+static int
+fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
+		     int regnum, u16 val)
+{
+	struct fbnic_dev *fbd = bus->priv;
+
+	if (addr & ~1)
+		return 0;
+
+	if (devnum == MDIO_MMD_PCS)
+		fbnic_mdio_write_pcs(fbd, addr, regnum, val);
+
+	if (devnum == MDIO_MMD_PMAPMD)
+		fbnic_mdio_write_pmapmd(fbd, addr, regnum, val);
+
+	return 0;
+}
+
+/**
+ * fbnic_mdiobus_create - Create an MDIO bus to allow interfacing w/ PHYs
+ * @fbd: Pointer to FBNIC device structure to populate bus on
+ *
+ * Initialize an MDIO bus and place a pointer to it on the fbd struct. This bus
+ * will be used to interface with the PMA/PMD and PCS.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int fbnic_mdiobus_create(struct fbnic_dev *fbd)
+{
+	struct mii_bus *bus;
+	int err;
+
+	bus = devm_mdiobus_alloc(fbd->dev);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "fbnic_mii_bus";
+	bus->read_c45 = &fbnic_mdio_read_c45;
+	bus->write_c45 = &fbnic_mdio_write_c45;
+	bus->parent = fbd->dev;
+	bus->phy_mask = GENMASK(31, 2);
+	bus->priv = fbd;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(fbd->dev));
+
+	err = devm_mdiobus_register(fbd->dev, bus);
+	if (err) {
+		dev_err(fbd->dev, "Failed to create MDIO bus: %d\n", err);
+		return err;
+	}
+
+	fbd->mdio_bus = bus;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 428fc861deff..b3f05bdb4f52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -339,6 +339,9 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_failure_mode;
 	}
 
+	if (fbnic_mdiobus_create(fbd))
+		goto init_failure_mode;
+
 	netdev = fbnic_netdev_alloc(fbd);
 	if (!netdev) {
 		dev_err(&pdev->dev, "Netdev allocation failed\n");



