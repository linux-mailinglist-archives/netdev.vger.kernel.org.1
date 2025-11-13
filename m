Return-Path: <netdev+bounces-238448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45900C58DCA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56729423985
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61335CB6B;
	Thu, 13 Nov 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl2/e4Mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE83587CE
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051639; cv=none; b=ec5peDN9Hd01Vlokct845fWdag1FoxBOw08r7C+yDpeWrcH1+1ZsS8Y3QCdhX5BcxmAEqsH4EAtM+WdZS2pjb/8TulL0ARmG0boM26bUpirVN1iFWfvHmy3wE5IoTiOVj92QgCOB/tmcvCGhnX82qbzmFu7w6QHU0Ty9kLj//ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051639; c=relaxed/simple;
	bh=q5RMojH2VGCMQgKvaa3A29T7772dtNaR6Hftgw18aBI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHID0zTokV61BxlI08zdjJVeTiOfr84bISYJJDB1NYujHEUNKYXANG8PFBbeJE4iyvDtfhbVNAmJz9mrggbqx7WRrOHnZ0y1eV+wg8deoU0Fwyf7VSOfBfrHWZcly/VTUT8fdPBExcmIwtXUbkfSPc6bhwkGVkQS09SC0aQGF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl2/e4Mu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343d73d08faso1076748a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051637; x=1763656437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1U5yhLdj+7VJtH+5tOxQav9/Er3K3aeP9EDV8YY8c4=;
        b=Nl2/e4MuyE1wgDo0xWaakeQpyVZxaMrOa+1FZd8JisQWoQzzpeLWRHhd0B5UP0X4PH
         UOvd73vwmipusoJDGajggTEHFt2TCc5ckhcbn0ptMvwzqVTaSka9xuiu5zvt6JZRCHEx
         IyXIjd+BgMof/gomDJeYS88S8ZmBsC/BCgx5tVx/qBkRxZPXvNwtIBiB4w0qonXr3T2Z
         ebA+UQnr96NTPZEH6JNdu6ScsSTfPjo/7ZVVh1n14Tw2kHV31WtplTZGlDSudVVd+tkh
         pKiX6POu55qJBydplXIlbmDGDCticIVjBlL8tUScITUQdHyQ0UiVAG5hhHvK5E5REht2
         LYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051637; x=1763656437;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1U5yhLdj+7VJtH+5tOxQav9/Er3K3aeP9EDV8YY8c4=;
        b=HWOQPYgdLIVIJPGJmauH7T1IeLSwHbteR7ADg0mLA8QHKiUsoK5QkRmmEO9aFJMWq+
         enajYdWFu0Pu8+i/5lir2boOsV91PDrCy4swad/TQPrwHPfssy0BPMOEnewy16C0k+hz
         7Awi2GoFKbh5Q/LQWRgmhZEPDPVLJh/cTpOgqyRfKO+EszbDT1gI5kPHQkhDxbzT56EC
         Yjs13s6h8k4v1SKNa49eErOkc+rjmTrmZvoIay/0LF9yQE6b+8nDYdxP8S5FhucUSnJm
         68SmHoffK6S38bYyFkxQMcYXVOm1hmny5C07zOJETKetiLYttXlAdIsr9wUM74y4ftQR
         4cVg==
X-Gm-Message-State: AOJu0Yx4ddFZ2NYcg49uZY70JJeB8tA4lMLIZ/EYTl30YNe/Ka+RUnTj
	Do/fZ8+eh/kcLObhescSm2+mXYkc+D9xYlcRRg5zd8tLsbPSqlsTv1yA
X-Gm-Gg: ASbGncuAG+U6bO0IZsRqoiPnAj4FhhwxNJYoCfyCxZJsZhTQpkLhExYVkXZb/4L6ut/
	qbVymIrxYuD3kHwg6x9aqjpIdeeGBofkUNrsTF+cExh8W6s8zmkUmfXyWmC5phR7OfSuleN1h4h
	9DebhA81oeXz5WGDjvCFWmViFvn3Gj1Hpm138BPyRzz/buxwOAj5XUJArnso59IuURkHi+yTEWo
	GnCSOC7iY8QmIEju8Qr1XFAXLRD8LnCQ8AOvolg7kiF4D1060zdZ3pJ/X6LTw3aeS2tOE4dLl0y
	oqxwEtowLnWVu02OLOEy1z2h7kOIUayrN+1WiLb1pV+63rbblaSTOf3G0nViQ/ZKOayh39nATX9
	RbJAmak4kzMOzuao3mJMyew10kWA10Peo4WM8INIOdxYYbVRvzuAxfDl536X+kVV+EGioONw8CL
	1Zp5eqvHVvoq7YEFVBbflqwf+AUqV1K1t9mMU8FJPkMCZm
X-Google-Smtp-Source: AGHT+IF2leQdhVGegL/Sk3+fc//SXScZOdmUgXqXrNevqyhcFpRi5XRzKdOJYl6+QHeP+8PK3WxClA==
X-Received: by 2002:a17:90b:5241:b0:340:767a:221f with SMTP id 98e67ed59e1d1-343eab08214mr3964716a91.4.1763051637178;
        Thu, 13 Nov 2025 08:33:57 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed5331e3sm3054020a91.11.2025.11.13.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:56 -0800 (PST)
Subject: [net-next PATCH v4 09/10] fbnic: Add SW shim for MDIO interface to
 PMA/PMD and PCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:55 -0800
Message-ID: 
 <176305163578.3573217.12146311945675271827.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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
index 000000000000..7eeaeb03529b
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
+fbnic_mdio_read_pmapmd(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	u16 ctrl1[__FBNIC_AUI_MAX__][2] = {
+		{ MDIO_PMA_CTRL1_SPEED25G, MDIO_PMA_CTRL1_SPEED50G },
+		{ MDIO_PMA_CTRL1_SPEED50G, MDIO_PMA_CTRL1_SPEED50G },
+		{ MDIO_PMA_CTRL1_SPEED50G, MDIO_PMA_CTRL1_SPEED100G },
+		{ MDIO_PMA_CTRL1_SPEED100G, MDIO_PMA_CTRL1_SPEED100G },
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
+		ret = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) ?
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
+fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	int ret;
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
+fbnic_mdio_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
+{
+	struct fbnic_dev *fbd = bus->priv;
+
+	if (addr & ~1)
+		return 0;
+
+	if (devnum == MDIO_MMD_PMAPMD)
+		return fbnic_mdio_read_pmapmd(fbd, addr, regnum);
+
+	if (devnum == MDIO_MMD_PCS)
+		return fbnic_mdio_read_pcs(fbd, addr, regnum);
+
+	return 0;
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
+static void
+fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	/* Skip write for reserved registers */
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
+static int
+fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
+		     int regnum, u16 val)
+{
+	struct fbnic_dev *fbd = bus->priv;
+
+	if (addr & ~1)
+		return 0;
+
+	if (devnum == MDIO_MMD_PMAPMD)
+		fbnic_mdio_write_pmapmd(fbd, addr, regnum, val);
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
index 040bd520b160..7991e2870081 100644
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



