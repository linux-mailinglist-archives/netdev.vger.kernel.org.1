Return-Path: <netdev+bounces-237262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB332C47CF5
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B00189770B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1002749CF;
	Mon, 10 Nov 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ersaASPu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8F25A340
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790528; cv=none; b=J4vHvlSfz2f1i+uRNz47pBCej9tOQz9+v7hNC3iBr8ESqp2ztYk7ml8L/KDaWCwsQ9ePHWWaK5XL+fs2isKYJUoLMtdMwBUvrXe5uUegyM2e42zcznETQqhW3xKYb2Iqenb5qE5EXWl2Q8QrlUwy6Lx26zCGbNSBEAGd8cNW3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790528; c=relaxed/simple;
	bh=q5RMojH2VGCMQgKvaa3A29T7772dtNaR6Hftgw18aBI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GF84Cs6D+nbALe96AuoEocDEAPN621dD8b7DPASfkgHRenQv9WwViGjECDABtd9rguKBFlSBih0iMiK19qk4h7Db+fYhb0thU3TJOMyNfhQezJGl4qJKHbwMWa/97kQEuiqiO26rChlx/14fNHoskgIVH6dulS/KehoKXjvh3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ersaASPu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aace33b75bso3308138b3a.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790524; x=1763395324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1U5yhLdj+7VJtH+5tOxQav9/Er3K3aeP9EDV8YY8c4=;
        b=ersaASPuNdI1jx32fT81fbBlNVB0Gm3b9HOUmNEk9S7H1lthkZKyK8IMRzMbmMV2kz
         0dtEm0m/sMb4Ga3MZOhZFJabk4oyVwbZalLKIbiTPqZopo2ccd6plCfWEF+h6rQ6lnxX
         T63JO3iKSTd2TQrbNNn0zcNnt4lV/crSDnjvMTXZn6eueZNcXg1elRr1Ilu3kN99UmB+
         2Ndr/iF71jogLzx1ifAornOqgYRPfbGoS5NdNN4+iB6icNh+8CiOJcJO5r/dzEWlORbA
         Y33JK+q2xlQgRd8Ew0p0zJTydwjGc1V7SaAKrG7ti32PkVMW3oaYDyyWr/gcf4sinGNb
         d07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790524; x=1763395324;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1U5yhLdj+7VJtH+5tOxQav9/Er3K3aeP9EDV8YY8c4=;
        b=BqiP4bf9kwUVgDk6Hpo6qgfyaSO6bs6VoHTOI46Ld/pWhJHj0/4tp9HoBREfqkK0pG
         JR5vxpEtI1zCCdP656NJNKUFEbCZX4np/vK+jxYgxHCWQiMKvf45GsJxCQIchX5AcuiL
         oDX/HR82lFHTYGQ3flzYxDCp389oDhrBxnUA8psvd+SpuoP0+rr0vlUwYcgAORWfXtdh
         4ILyQPCJYR+0vAhrdJ8olWrUNaT9FZiZ4lq+QhFn/IBg4fm8U5er+S3JzIuVDy+7gn9J
         EAz6rIxmZ3LO4y9GxpezQtI6UPrrfER75JzVSkKdIBE4ELQkQ5R0BQbWIiHm9JUTI4WZ
         3XCg==
X-Gm-Message-State: AOJu0YwOOvi/x2zJ+xDJTd0HO9juK0Vp5ue0DbrS6zhQd72LLoVG/zoa
	X895cLocUh/REW7roe6pM2dqXlOnsjyoxRa5+oOk5AlIrq1qELsj+EzAjKnDvA==
X-Gm-Gg: ASbGncu50LyJjW1/CXDdV8uMwDzYaFUyAoaQJE45496gO/3dsk1kd3g4mnqqWKBlRrr
	WIWpbLLAl7HMW2rmp4Y8pbK+pN33QXB0fyQKNBCLShDFN7ZaB7eZCYWWDMc9YlfqH9d8XV5D9qe
	pIbvPgznkiD3Fl5mee0YvABHYI4o5yJwCDwVLEGdQn/4K8ZZC8qqh/Pxpi+NIjpXDboR8zOCzqx
	E/hbgJY9wkZVoBdFqLCP0jGdDj7K+NwzXzrJ6iCALrJ12BtPC5bP2fCbVFZYNHKczqV17+gREVc
	XZEbPjLDJgIlAsnTnwxMaEkpLUf5SnbMOSZ9ErtqiGoCTJwJWqHVfNf21KoaH2V+eLqwdfcOk1Q
	PWKirAQtHYZQVnNUl8wIgV3SZp7mayvginjkZDAE5kqWvWkXr26HkJ3kYCUh2YYb8GWAXkWapv7
	M5+/9YGPqvnw4MCq8XfhFZJ/rBqIgj4Kz3SB8C2TzIBxkY
X-Google-Smtp-Source: AGHT+IG/YTDsfiuL6hYK8rzL4mtV2uED8fldGvj2RAAPT1DehpLBagjSCDxDjfYb9w8mq3ffzauFjA==
X-Received: by 2002:a05:6a21:1506:b0:353:ec70:30dd with SMTP id adf61e73a8af0-353ec7031e0mr10888604637.51.1762790524296;
        Mon, 10 Nov 2025 08:02:04 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe36bbasm12956438a12.18.2025.11.10.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:02:03 -0800 (PST)
Subject: [net-next PATCH v3 09/10] fbnic: Add SW shim for MDIO interface to
 PMA/PMD and PCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:02:02 -0800
Message-ID: 
 <176279052268.2130772.13356059815114333743.stgit@ahduyck-xeon-server.home.arpa>
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



