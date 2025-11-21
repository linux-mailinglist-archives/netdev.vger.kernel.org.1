Return-Path: <netdev+bounces-240820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44898C7AE6B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 941AA3683D9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC612F066D;
	Fri, 21 Nov 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa91ntzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41B2EDD69
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743250; cv=none; b=kO4C8LOXaVmmu7oZD/CCe6FHgTEqOCh+QwJIoDr1QTQ/aatA67ytsRSrbE36S185hkJw2v5QTFoAe5bz27C3QBOStmjCiCXk5AHyWcNXcxVM1Cp+OMNnuWQbwMPXeHwLno9ZgWjwK0mrshl8aZDvCrr0mI/lB8HPhp3OD7I1Orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743250; c=relaxed/simple;
	bh=C0xLBiNLJUTrJMCT32qbxks1XZMM0ZWdUIds/IwFADA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lN3Uwtvwu8/efYsSCeGJOieln9LFPuXtKrarSf1w1kQ/IA1fHEdVjUC3iR78I06VnsjDiR2nM20gkVqNyssIoJ+vPWVF+ovhtk6DzECm/Bnj4Nr9IDc0DvKaK678QhcT69UrUVZ+13b8bwaYrX56ZpeHNxve3yFwQ+YKQ0DBDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa91ntzs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so2711684b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743248; x=1764348048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AtIHDnDoiyTxCzgFblmgiPhJP/EP2CiuVtkqn+dbM10=;
        b=Oa91ntzsdQhcT3rDBivR/kUNiIy+uBXrV4KvArxy3tVVlAZlPSWyiYfiLkbc13p6An
         XcOBi7GX2posPLRAA1w+Zb2o3jHLkN6iP3jbhMWUc8XNu7F6tHmB3h10PPuWLmPBtPE/
         +6njxuDzSyuEKeyWtcTPM3emL1rwrhnrBp5MXmlRvQliovE1XA6bU3szuukEYfAUZ2/5
         HkccMoVaRRF8N58/7UFhZqusRAsvTO1bCOFhl0kN87lFyIbXMLJM05j4EJ2tStDYe25C
         uRPPoC5+NyFFowvkoZv/pkVI+D7I3Xj5kEGNyvRAg1s+5b0cAbXKZpVp00YTiqOcVcyd
         3BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743248; x=1764348048;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtIHDnDoiyTxCzgFblmgiPhJP/EP2CiuVtkqn+dbM10=;
        b=pEGe7vCiUl27cob+nmMEWidp6uK1unj84d3Trrk8K6S7NQVlXlx43efmkKcNdsBeNe
         lQUUrBxIUZ+hKcNa/zpLXfK2PiDlnYzWuEc7Ql3k4Cs0uJQL2ySbxAHindsadLkBPuMp
         UsYOo1JcHrtXT982ymJQY0xSuLCrZcGQtSmb2gmppVxrB/vh9Vcd+SnGaQS8Q7rgEWrf
         8Y9j/itTyc6uul8D0dNcGLrEzrthvIrYHjEHcNsWv1cx5SO3IbJHKebhRDMYKUIaIY3Z
         19+jp1uTXIE9lbW4rz+tt0QJSTcqgUNx8O3DinwZgt86ExU/Q6UwbZ2fyN5/bdKyJU7S
         jvUA==
X-Gm-Message-State: AOJu0YxC9O07lSJVlIKIlo7eLXxreGNYVFmbXip5vMkLgSgx8IHF1UOg
	XEIJYuP4CZefzp4fPZv+eZwkZku0iRmLXELyzTxqGKgtsB32pB8R6iaHslEEoA==
X-Gm-Gg: ASbGncs2G1kx1A4U2DMVIggg1LmSf8dWBnB8bynBAFdfwY0+x/Wpqk4gQLkDJhkXyxJ
	y+HlCR6ZE8HQyEneNfmqfw5sjI3N5RMTi55XNA6XFkFuowN0qW9SGgJEnsDf0IInRbBPoV6gzzg
	i5bIGE8tOoBpR1zphwVZKqAfPMo2Q8F/479m5UmDR7HY9kH1GcC9n9ENpm4LN8LSiP5SFxdeNOA
	DMPrNUy4B5T7XQm6pQjpCLLCNoRKu5on+nYvg7UxME5TrONx35VRiliZInSQjRmRkMsul1rZK3h
	GTC3pH/TuoVPFlSyj87Bov7VgWFMFZyio/r5AimqppamQeOp7FsCl4XBR7VyWvxiTFS7L5IJIGa
	Chq4GvD1UnL8a3hxHzEg/haGy2Z1R6O2t53w8gzdKTxKUxH1RHEXaWLYaZO5R7PAV2gIdMIYvke
	UsdjTftz340JeEvkcAm97kJZI2mXKsOFldT5lnR2e41BQO
X-Google-Smtp-Source: AGHT+IG8ssA8rZRgHPBrOKwtlkPuXwpU+JmQW/fbO4nNO491ktizKWklr3ER7whLo94ChGGdPI0dhA==
X-Received: by 2002:a05:6a00:181d:b0:7ab:21ca:a3be with SMTP id d2e1a72fcca58-7c58c2b1ebbmr3315665b3a.12.1763743247705;
        Fri, 21 Nov 2025 08:40:47 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed471f80sm6639797b3a.24.2025.11.21.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:47 -0800 (PST)
Subject: [net-next PATCH v5 8/9] fbnic: Add SW shim for MDIO interface to PMD
 and PCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:45 -0800
Message-ID: 
 <176374324532.959489.15389723111560978054.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
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

In order for us to support a PCS device we need to add an MDIO bus to allow
the drivers to have access to the registers for the device.  This change
adds such an interface.

The interface will consist of 2 PHY addrs, the first one consisting of a
PMD and PCS, and the second just being a PCS. There is a need for 2 PHYs
addrs due to the fact that in order to support the 50GBase-CR2 mode we will
need to access and configure the PCS vendor registers and RSFEC registers
from the second lane identical to the first.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile     |    1 
 drivers/net/ethernet/meta/fbnic/fbnic.h      |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h  |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c |  195 ++++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c  |    3 
 5 files changed, 205 insertions(+)
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
index fac1283d0ade..779a083b9215 100644
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
index 9b4fb0586dff..f08fe8b7c497 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -56,6 +56,7 @@ enum {
 	FBNIC_AUI_50GAUI1	= 2,	/* 53.125GBd	53.125   * 1 */
 	FBNIC_AUI_100GAUI2	= 3,	/* 106.25GBd	53.125   * 2 */
 	FBNIC_AUI_UNKNOWN	= 4,
+	__FBNIC_AUI_MAX__
 };
 
 #define FBNIC_AUI_MODE_R2	(FBNIC_AUI_LAUI2)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
new file mode 100644
index 000000000000..709041f7fc43
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -0,0 +1,195 @@
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
+fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	u8 aui = FBNIC_AUI_UNKNOWN;
+	struct fbnic_net *fbn;
+	int ret = 0;
+
+	/* We don't need a second PMD, just one can handle both lanes */
+	if (addr)
+		return 0;
+
+	if (fbd->netdev) {
+		fbn = netdev_priv(fbd->netdev);
+		if (fbn->aui < FBNIC_AUI_UNKNOWN)
+			aui = fbn->aui;
+	}
+
+	switch (regnum) {
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
+	case MDIO_PMA_RXDET:
+		/* If training isn't complete default to 0 */
+		if (fbd->pmd_state != FBNIC_PMD_SEND_DATA)
+			break;
+		/* Report either 1 or 2 lanes detected depending on config */
+		ret = (MDIO_PMD_RXDET_GLOBAL | MDIO_PMD_RXDET_0) |
+		      ((aui & FBNIC_AUI_MODE_R2) *
+		       (MDIO_PMD_RXDET_1 / FBNIC_AUI_MODE_R2));
+		break;
+	default:
+		break;
+	}
+
+	dev_dbg(fbd->dev,
+		"SWMII PMD Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, ret);
+
+	return ret;
+}
+
+static int
+fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	int ret, offset = 0;
+
+	/* We will need access to both PCS instances to get config info */
+	if (addr >= 2)
+		return 0;
+
+	/* Report 0 for reserved registers */
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
+		offset ^= DW_VENDOR | FBNIC_PCS_VENDOR;
+
+	ret = fbnic_rd32(fbd, FBNIC_PCS_PAGE(addr) + (regnum ^ offset));
+
+	dev_dbg(fbd->dev,
+		"SWMII PCS Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
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
+	if (devnum == MDIO_MMD_PMAPMD)
+		return fbnic_mdio_read_pmd(fbd, addr, regnum);
+
+	if (devnum == MDIO_MMD_PCS)
+		return fbnic_mdio_read_pcs(fbd, addr, regnum);
+
+	return 0;
+}
+
+static void
+fbnic_mdio_write_pmd(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	dev_dbg(fbd->dev,
+		"SWMII PMD Wr: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, val);
+}
+
+static void
+fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	dev_dbg(fbd->dev,
+		"SWMII PCS Wr: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, val);
+
+	/* Allow access to both halves of PCS for 50R2 config */
+	if (addr > 2)
+		return;
+
+	/* Skip write for reserved registers */
+	if (regnum & FBNIC_PCS_ZERO_MASK)
+		return;
+
+	/* Swap vendor page bit for FBNIC PCS vendor page bit */
+	if (regnum & DW_VENDOR)
+		regnum ^= DW_VENDOR | FBNIC_PCS_VENDOR;
+
+	fbnic_wr32(fbd, FBNIC_PCS_PAGE(addr) + regnum, val);
+}
+
+static int
+fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
+		     int regnum, u16 val)
+{
+	struct fbnic_dev *fbd = bus->priv;
+
+	if (devnum == MDIO_MMD_PMAPMD)
+		fbnic_mdio_write_pmd(fbd, addr, regnum, val);
+
+	if (devnum == MDIO_MMD_PCS)
+		fbnic_mdio_write_pcs(fbd, addr, regnum, val);
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
+
+	/* Disable PHY auto probing. We will add PCS manually */
+	bus->phy_mask = ~0;
+
+	bus->parent = fbd->dev;
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
index dea5367d2190..861d98099c44 100644
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



