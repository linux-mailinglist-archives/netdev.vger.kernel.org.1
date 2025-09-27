Return-Path: <netdev+bounces-226854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4271BA5A70
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDEE54E1762
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A722D239F;
	Sat, 27 Sep 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="mEu2VINw"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0402D24A9
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959364; cv=none; b=tdkDw1C2P5BdHw6ZCDivJxGEMU1NSjv5ohp931sDpWqsJc5NOJPhnNz3EdUx4expgHE5XDE6j6r6jiPXsB3KZgDhPpTHXxFsZTCCqzzM23KJV9Vk9WxPHLH9KbB+z7f3A4FFRqXqc4w/yi+NB1WFBDLoqoD3xkBgLsjpU0+m5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959364; c=relaxed/simple;
	bh=GM1G4btfy7MTYOCB0Q2+OOJjflTOB6oah7Se7KQITCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLwdAtLFCswHGAokGH4v2uPu3PM6NwOKlqrWwPVPO4ehYRVRAuR8p78TF1pk0d+Llvx+KxknNKQEQcbVrAJ5ohA+rEeDYYyHopSF7N4K5NYES3T0S0A0ru7iGf4Cua2rAiK7mNEHA9jyKwsKnEijey8FXsVGjI/6bYoT6N0MiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mEu2VINw; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58R77w8B026773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 08:08:18 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58R77w8B026773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758956901; bh=KOke4G6gQcjPyABbf0PWtaB2RkfIcJ/J/pLKDVykVvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEu2VINwFhUtNLACpk1gu3gSp2OyB9tdW19k2/TUoHGSpxtBv5i7txcrfk5N+Ceww
	 fhqYI9merjTfE0vJP6I/zHN6eniJjxHuJ/jl6eVaiGWgcRZGSB/C7D8XOo/vKawUDo
	 Bx6rXyXwGEfYXfpwQw303oz582uM1WK0lkbkH8h0Lui0VLRhobt6KUi4vhxvFjKgta
	 lk4exTCzNixejy9zyOhBEljxkvOfC55FsU6SshZ3eYaxuKeAleezWzdLJWWXezPQ4J
	 RWqmP8NReE32d2VIczMyi2W8qmek8xgtrHHAeY+5ajoMgP3nmHqseLReQ5FKn69vGH
	 cu68LuVJpqOKw==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, max@huntershome.org,
        Luke Howard <lukeh@padl.com>
Subject: [RFC net-next 3/5] net: dsa: mv88e6xxx: MQPRIO support
Date: Sat, 27 Sep 2025 17:07:06 +1000
Message-ID: <20250927070724.734933-4-lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927070724.734933-1-lukeh@padl.com>
References: <20250927070724.734933-1-lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for MQPRIO TC for the Marvell 6352 and 6390 families of
switches. Three traffic classes are supported: legacy (TC0), low (TC1)
and high (TC2), corresponding to non-AVB, AVB Class B and Class A.

A single Ethernet frame priority can be mapped to either AVB class.
"Legacy" (non-AVB) Ethernet frame priorities are distributed amongst the
remaining queues, per the MQPRIO policy.

Owing to hardware limitations, queue and frame priority policy is
per-switch, not per-port; HW offload can only be enabled across multiple
ports if the policy on each enabled port is the same.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/Makefile      |   3 +-
 drivers/net/dsa/mv88e6xxx/avb.c         | 550 ++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/avb.h         | 211 +++++++++
 drivers/net/dsa/mv88e6xxx/chip.c        | 266 +++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        |  76 ++++
 drivers/net/dsa/mv88e6xxx/global1.c     |   9 +-
 drivers/net/dsa/mv88e6xxx/global1.h     |  45 +-
 drivers/net/dsa/mv88e6xxx/global2.h     |  14 +-
 drivers/net/dsa/mv88e6xxx/global2_avb.c | 205 ++++++++-
 drivers/net/dsa/mv88e6xxx/port.c        |   9 +
 drivers/net/dsa/mv88e6xxx/port.h        |   2 +
 include/linux/platform_data/mv88e6xxx.h |   1 +
 12 files changed, 1370 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.h

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index dd961081d6313..5271bdebe171d 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_MV88E6XXX) += mv88e6xxx.o
-mv88e6xxx-objs := chip.o
+mv88e6xxx-objs := avb.o
+mv88e6xxx-objs += chip.o
 mv88e6xxx-objs += devlink.o
 mv88e6xxx-objs += global1.o
 mv88e6xxx-objs += global1_atu.o
diff --git a/drivers/net/dsa/mv88e6xxx/avb.c b/drivers/net/dsa/mv88e6xxx/avb.c
new file mode 100644
index 0000000000000..361e7ff821567
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Marvell 88E6xxx Switch AVB support
+ *
+ * Copyright (c) 2008 Marvell Semiconductor
+ *
+ * Copyright (c) 2024 PADL Software Pty Ltd
+ */
+
+#include <linux/dcbnl.h> /* for IEEE_8021Q_MAX_PRIORITIES */
+
+#include "avb.h"
+#include "chip.h"
+#include "global1.h"
+#include "global2.h"
+#include "port.h"
+
+/* AVB operation wrappers */
+
+static int mv88e6xxx_port_avb_read(struct mv88e6xxx_chip *chip, int port,
+				   int addr, u16 *data, int len)
+{
+	if (!chip->info->ops->avb_ops->port_avb_read)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->port_avb_read(chip, port, addr,
+						       data, len);
+}
+
+static int mv88e6xxx_port_avb_write(struct mv88e6xxx_chip *chip, int port,
+				    int addr, u16 data)
+{
+	if (!chip->info->ops->avb_ops->port_avb_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->port_avb_write(chip, port, addr, data);
+}
+
+static int mv88e6xxx_avb_read(struct mv88e6xxx_chip *chip, int addr,
+			      u16 *data, int len)
+{
+	if (!chip->info->ops->avb_ops->avb_read)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->avb_read(chip, addr, data, len);
+}
+
+static int mv88e6xxx_avb_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
+{
+	if (!chip->info->ops->avb_ops->avb_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->avb_write(chip, addr, data);
+}
+
+/* 802.1Qav operation wrappers */
+
+static int mv88e6xxx_qav_read(struct mv88e6xxx_chip *chip, int addr,
+			      u16 *data, int len)
+{
+	if (!chip->info->ops->avb_ops->qav_read)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->qav_read(chip, addr, data, len);
+}
+
+static int mv88e6xxx_qav_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
+{
+	if (!chip->info->ops->avb_ops->qav_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->qav_write(chip, addr, data);
+}
+
+static int mv88e6xxx_port_qav_read(struct mv88e6xxx_chip *chip, int port,
+				   int addr, u16 *data, int len)
+{
+	if (!chip->info->ops->avb_ops->port_qav_read)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->port_qav_read(chip, port, addr, data, len);
+}
+
+static int mv88e6xxx_port_qav_write(struct mv88e6xxx_chip *chip, int port,
+				    int addr, u16 data)
+{
+	if (!chip->info->ops->avb_ops->port_qav_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->port_qav_write(chip, port, addr, data);
+}
+
+static int mv88e6xxx_tc_enable(struct mv88e6xxx_chip *chip,
+			       const struct mv88e6xxx_avb_tc_policy *policy)
+{
+	if (!chip->info->ops->tc_ops->tc_enable)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->tc_ops->tc_enable(chip, policy);
+}
+
+static int mv88e6xxx_tc_disable(struct mv88e6xxx_chip *chip)
+{
+	if (!chip->info->ops->tc_ops->tc_disable)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->tc_ops->tc_disable(chip);
+}
+
+/* MQPRIO helpers */
+
+/* Set the AVB global policy limit registers. Caller must acquired register
+ * lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param hilimit	Maximum frame size allowed for AVB Class A frames
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+static int mv88e6xxx_avb_set_hilimit(struct mv88e6xxx_chip *chip, u16 hilimit)
+{
+	u16 data;
+	int err;
+
+	if (hilimit > MV88E6XXX_AVB_CFG_HI_LIMIT_MASK)
+		return -EINVAL;
+
+	err = mv88e6xxx_avb_read(chip, MV88E6XXX_AVB_CFG_HI_LIMIT, &data, 1);
+	if (err)
+		return err;
+
+	data &= ~(MV88E6XXX_AVB_CFG_HI_LIMIT_MASK);
+	data |= MV88E6XXX_AVB_CFG_HI_LIMIT_SET(hilimit);
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_HI_LIMIT, hilimit);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* Set the AVB global policy OUI filter registers. Caller must acquire register
+ * lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param addr		The AVB OUI to load
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+static int mv88e6xxx_avb_set_oui(struct mv88e6xxx_chip *chip,
+				 const unsigned char *addr)
+{
+	u16 reg;
+	int err;
+
+	reg = (addr[0] << 8) | addr[1];
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_OUI_HI, reg);
+	if (err)
+		return err;
+
+	reg = (addr[2] << 8);
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_OUI_LO, reg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* Set the global isochronous queue pointer threshold. Caller must acquire
+ * register lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param threshold	Total number of pointers reserved for isochronous streams
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+static int mv88e6xxx_qav_set_iso_ptr(struct mv88e6xxx_chip *chip, u16 threshold)
+{
+	u16 data;
+	int err;
+
+	err = mv88e6xxx_qav_read(chip, MV88E6XXX_QAV_CFG, &data, 1);
+	if (err)
+		return err;
+
+	data &= ~(MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_MASK);
+	data |= MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_SET(threshold);
+
+	err = mv88e6xxx_qav_write(chip, MV88E6XXX_QAV_CFG, data);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* Map the global AVB mode to a port AVB mode.
+ *
+ * @param chip		Marvell switch chip instance
+ *
+ * @return		A MV88E6XXX_PORT_AVB_CFG_AVB_MODE_XXX bitmask
+ */
+static u16 mv88e6xxx_avb_get_cfg_avb_mode(struct mv88e6xxx_chip *chip)
+{
+	u16 cfg;
+
+	switch (chip->avb_tc_policy.mode) {
+	case MV88E6XXX_AVB_MODE_STANDARD:
+		cfg = MV88E6XXX_PORT_AVB_CFG_AVB_MODE_STANDARD;
+		break;
+	case MV88E6XXX_AVB_MODE_ENHANCED:
+		cfg = MV88E6XXX_PORT_AVB_CFG_AVB_MODE_ENHANCED;
+		break;
+	case MV88E6XXX_AVB_MODE_SECURE:
+		cfg = MV88E6XXX_PORT_AVB_CFG_AVB_MODE_SECURE;
+		break;
+	default:
+		cfg = MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY;
+		break;
+	}
+
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_ENHANCED) {
+		cfg |= MV88E6XXX_PORT_AVB_CFG_AVB_FILTER_BAD_AVB |
+		       MV88E6XXX_PORT_AVB_CFG_AVB_DISCARD_BAD;
+	}
+
+	return cfg;
+}
+
+/* Enable or disable a port for AVB. Caller must acquire register lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param port		Switch port
+ * @param enable	If true, will enable AVB queues on this port.
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+static int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
+					   int port, bool enable)
+{
+	u16 cfg;
+
+	if (enable)
+		cfg = mv88e6xxx_avb_get_cfg_avb_mode(chip);
+	else
+		cfg = MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY;
+
+	return mv88e6xxx_port_avb_write(chip, port, MV88E6XXX_PORT_AVB_CFG, cfg);
+}
+
+static int mv88e6xxx_avb_set_avb_mode(struct mv88e6xxx_chip *chip, bool enable)
+{
+	int port, err;
+
+	for (port = 0, err = 0; port < mv88e6xxx_num_ports(chip); ++port) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port, enable);
+		if (err)
+			break;
+	}
+
+	if (err)
+		return err;
+
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_SECURE) {
+		static const u8 zero_addr[ETH_ALEN] = {};
+		const u8 *addr;
+
+		addr = enable ? eth_maap_mcast_addr_base : zero_addr;
+
+		err = mv88e6xxx_avb_set_oui(chip, addr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
+			    const struct mv88e6xxx_avb_tc_policy *policy)
+{
+	int err;
+
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_ENHANCED) {
+		/* interpret AVB_NRL bits in ATU as AVB entries */
+		err = mv88e6xxx_g1_atu_set_mac_avb(chip, true);
+		if (err)
+			return err;
+	}
+
+	err = mv88e6xxx_qav_set_iso_ptr(chip, mv88e6xxx_num_ports(chip) << 6);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_tc_enable(chip, policy);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_avb_set_avb_mode(chip, true);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mv88e6xxx_avb_tc_disable(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	err = mv88e6xxx_avb_set_avb_mode(chip, false);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_tc_disable(chip);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_qav_set_iso_ptr(chip, 0);
+	if (err)
+		return err;
+
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_ENHANCED) {
+		/* don't interpret AVB NRL bits in ATU as AVB entries */
+		err = mv88e6xxx_g1_atu_set_mac_avb(chip, false);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Assign FPri to QPri mappings for each traffic class
+ *
+ * @param chip		Marvell switch chip instance
+ * @param policy	AVB policy settings
+ * @param map		Callback for setting individual FPri:QPri mapping
+ * @param context	Opaque context passed to callback function
+ *
+ * @return		0 on success, or error returned by callback
+ */
+static int mv88e6xxx_qav_assign_qpri(struct mv88e6xxx_chip *chip,
+				     const struct mv88e6xxx_avb_tc_policy *policy,
+				     int (*map)(u8 fpri, u8 qpri, void *context),
+				     void *context)
+{
+	int tc0_qcount, tc0_base_qpri;
+	size_t tc0_fpri_per_qpri;
+	int err, fpri;
+
+	tc0_base_qpri = policy->map[MV88E6XXX_AVB_TC_LEGACY].qpri;
+	tc0_fpri_per_qpri =
+		DIV_ROUND_UP(IEEE_8021Q_MAX_PRIORITIES - 2,
+			     policy->map[MV88E6XXX_AVB_TC_LEGACY].count);
+
+	/* Match TC1/TC2 (AVB) FPri to QPri mappings to avoid needing to
+	 * configure legacy AVB registers, which map non-AVB frame FPri/QPris
+	 * to non-conflicting values.
+	 *
+	 * Distribute TC0 (non-AVB) queues amongst remaining FPris.
+	 */
+	for (fpri = 0, tc0_qcount = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++) {
+		if (policy->map[MV88E6XXX_AVB_TC_LO].fpri == fpri) {
+			err = map(fpri, policy->map[MV88E6XXX_AVB_TC_LO].qpri, context);
+		} else if (policy->map[MV88E6XXX_AVB_TC_HI].fpri == fpri) {
+			err = map(fpri, policy->map[MV88E6XXX_AVB_TC_HI].qpri, context);
+		} else {
+			int qpri = tc0_base_qpri + (tc0_qcount++ / tc0_fpri_per_qpri);
+
+			err = map(fpri, qpri, context);
+		}
+
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+/* Family-specific 802.1Qav support */
+
+static inline u16 mv88e6352_avb_pri_map_to_reg(const struct mv88e6xxx_avb_priority_map map[])
+{
+	return MV88E6352_AVB_CFG_AVB_HI_FPRI_SET(map[MV88E6XXX_AVB_TC_HI].fpri) |
+		MV88E6352_AVB_CFG_AVB_HI_QPRI_SET(map[MV88E6XXX_AVB_TC_HI].qpri) |
+		MV88E6352_AVB_CFG_AVB_LO_FPRI_SET(map[MV88E6XXX_AVB_TC_LO].fpri) |
+		MV88E6352_AVB_CFG_AVB_LO_QPRI_SET(map[MV88E6XXX_AVB_TC_LO].qpri);
+}
+
+static int mv88e6352_qav_map_fpri_qpri(u8 fpri, u8 qpri, void *reg)
+{
+	mv88e6352_g1_ieee_pri_set(fpri, qpri, (u16 *)reg);
+	return 0;
+}
+
+static int mv88e6352_tc_enable(struct mv88e6xxx_chip *chip,
+			       const struct mv88e6xxx_avb_tc_policy *policy)
+{
+	u16 reg = 0;
+	int err;
+	int tc;
+
+	/* Validate TC to QPri mapping */
+	for (tc = MV88E6XXX_AVB_TC_LO; tc <= MV88E6XXX_AVB_TC_HI; tc++) {
+		if (policy->map[tc].qpri < MV88E6352_AVB_QUEUE_MIN(tc) ||
+		    policy->map[tc].qpri > MV88E6352_AVB_QUEUE_MAX(tc)) {
+			dev_err(chip->dev, "%s: bad QPri %d for TC %d\n",
+				__func__, policy->map[tc].qpri, tc);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB,
+				  mv88e6352_avb_pri_map_to_reg(policy->map));
+	if (err)
+		return err;
+
+	err = mv88e6xxx_qav_assign_qpri(chip, policy, mv88e6352_qav_map_fpri_qpri, &reg);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_set_ieee_pri_map(chip, reg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static struct mv88e6xxx_avb_priority_map
+mv88e6352_init_avb_pri_map[MV88E6XXX_AVB_TC_MAX + 1] = {
+	[MV88E6XXX_AVB_TC_LO] = {
+		/* VI, queue 2 */
+		.fpri = 0x4,
+		.qpri = 0x2
+	},
+	[MV88E6XXX_AVB_TC_HI] = {
+		/* VO, queue 3 */
+		.fpri = 0x5,
+		.qpri = 0x3
+	},
+};
+
+static int mv88e6352_tc_disable(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	err = mv88e6250_g1_ieee_pri_map(chip);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB,
+				  mv88e6352_avb_pri_map_to_reg(mv88e6352_init_avb_pri_map));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+const struct mv88e6xxx_tc_ops mv88e6341_tc_ops = {
+	.tc_enable		= mv88e6352_tc_enable,
+	.tc_disable		= mv88e6352_tc_disable,
+};
+
+const struct mv88e6xxx_tc_ops mv88e6352_tc_ops = {
+	.tc_enable		= mv88e6352_tc_enable,
+	.tc_disable		= mv88e6352_tc_disable,
+};
+
+static inline u16 mv88e6390_avb_pri_map_to_reg(const struct mv88e6xxx_avb_priority_map map[])
+{
+	return MV88E6390_AVB_CFG_AVB_HI_FPRI_SET(map[MV88E6XXX_AVB_TC_HI].fpri) |
+		MV88E6390_AVB_CFG_AVB_HI_QPRI_SET(map[MV88E6XXX_AVB_TC_HI].qpri) |
+		MV88E6390_AVB_CFG_AVB_LO_FPRI_SET(map[MV88E6XXX_AVB_TC_LO].fpri) |
+		MV88E6390_AVB_CFG_AVB_LO_QPRI_SET(map[MV88E6XXX_AVB_TC_LO].qpri);
+}
+
+static int mv88e6390_qav_map_fpri_qpri(u8 fpri, u8 qpri, void *context)
+{
+	int err, port;
+	struct mv88e6xxx_chip *chip = (struct mv88e6xxx_chip *)context;
+
+	for (port = 0, err = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6390_port_set_ieeepmt_ingress_pcp(chip, port, fpri,
+							     fpri, qpri);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int mv88e6390_tc_enable(struct mv88e6xxx_chip *chip,
+			       const struct mv88e6xxx_avb_tc_policy *policy)
+{
+	int err;
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB,
+				  mv88e6390_avb_pri_map_to_reg(policy->map));
+	if (err)
+		return err;
+
+	err = mv88e6xxx_qav_assign_qpri(chip, policy, mv88e6390_qav_map_fpri_qpri, chip);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static struct mv88e6xxx_avb_priority_map
+mv88e6390_init_avb_pri_map[MV88E6XXX_AVB_TC_MAX + 1] = {
+	[MV88E6XXX_AVB_TC_LO] = {
+		/* EE, queue 6 */
+		.fpri = 0x2,
+		.qpri = 0x6
+	},
+	[MV88E6XXX_AVB_TC_HI] = {
+		/* CA, queue 7 */
+		.fpri = 0x3,
+		.qpri = 0x7
+	},
+};
+
+static int mv88e6390_tc_disable(struct mv88e6xxx_chip *chip)
+{
+	int err, port;
+
+	for (port = 0, err = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6390_port_tag_remap(chip, port);
+		if (err)
+			break;
+	}
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB,
+				  mv88e6390_avb_pri_map_to_reg(mv88e6390_init_avb_pri_map));
+	if (err)
+		return err;
+
+	return err;
+}
+
+const struct mv88e6xxx_tc_ops mv88e6390_tc_ops = {
+	.tc_enable		= mv88e6390_tc_enable,
+	.tc_disable		= mv88e6390_tc_disable,
+};
diff --git a/drivers/net/dsa/mv88e6xxx/avb.h b/drivers/net/dsa/mv88e6xxx/avb.h
new file mode 100644
index 0000000000000..d049e30c5c0e2
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Marvell 88E6xxx Switch PTP support
+ *
+ * Copyright (c) 2008 Marvell Semiconductor
+ *
+ * Copyright (c) 2024 PADL Software Pty Ltd
+ */
+
+#ifndef _MV88E6XXX_AVB_H
+#define _MV88E6XXX_AVB_H
+
+#include "chip.h"
+
+/* The Marvell 6352 and 6390 families support the Credit Based Shaper defined
+ * in 802.1Qav. (The 6390 family also supports 802.1Qbv but that is presently
+ * unimplemented.)
+ *
+ * On ingress, frame priority tags (PCP for L2) are mapped to an internal frame
+ * priority, or FPri. This mapping is per-port on all switches that support
+ * AVB. The 6352 family has a per-switch mapping between FPri and QPri (the TX
+ * queue), whereas this mapping on the 6390 family is per-port. Both families
+ * support per-port CBS policies.
+ *
+ * In addition to traffic shaping, the Marvell switches also support a form of
+ * admission control, where true AVB frames are distinguished from other frames
+ * that share the same frame priority. This is done by flagging ATU entries
+ * with the ATU_DATA_STATE_{UC,MC}_STATIC_AVB_NRL flags. When the port is
+ * configured in Enhanced, rather than Standard, AVB mode, AVB frames will only
+ * be forwarded when the DA ATU entry has this bit set. Admission control would
+ * typically be managed by a user-space 802.1Q Stream Reservation Protocol
+ * (SRP) service. This, in combination with the global IsoPtrs register,
+ * ensures that AVB streams always have priority over other traffic. These
+ * features are necessary for Avnu certification.
+ *
+ * A final point is whether Linux TCs should be mapped to AVB classes or
+ * directly to queues. Enhanced AVB support above requires dedicated, global
+ * queues for Class A and B traffic, implying a mapping between TCs and AVB
+ * classes. Unfortunately this means that Marvell switches that support a
+ * larger number of TX queues (such as the 6390 family) must still funnel their
+ * MQPRIO policy through these three TCs. Further, this limits the 6390 family
+ * to per-switch MQPRIO policies whereas otherwise port-port policies could be
+ * supported.
+ *
+ * With that in mind, the current implementation has the following properties:
+ *
+ *	- there are only three traffic classes, hi (2), lo (1) and legacy (0),
+ *	  which correspond to AVB Class A, B, and non-AVB traffic
+ *
+ *	- only a single Ethernet frame priority can be mapped to either of the
+ *	  AVB traffic classes
+ *
+ *	- legacy Ethernet frame priorities are distributed amongst the
+ *	  remaining queues per the MQPRIO policy
+ *
+ *	- queue and frame priority policy is per-switch, not per-port, so
+ *	  HW offload can only be enabled across multiple ports if the policy
+ *	  on each port is the same
+ *
+ *	- on the 6352 family of switches, TC2 can only be in queue 2/3 and
+ *	  TC1 only in queue 1/2; this does not apply to the 6390 family
+ *
+ *	- because the Netlink API has no way to distinguish between FDB/MDB
+ *	  entries managed by SRP from those that are not, the
+ *	  "marvell,mv88e6xxx-avb-mode" device tree property controls whether
+ *	  a FDB or MDB entry is required in order for AVB frames to egress.
+ *	  To avoid breaking static IP MDB entries, only multicast addresses
+ *	  with OUI prefix of 91:e0:ff (IEEE 1722 Annex D) will have the AVB
+ *	  flag set on their ATU entry.
+ */
+
+/* Global AVB registers */
+
+/* Offset 0x00: AVB Global Config */
+
+#define MV88E6XXX_AVB_CFG_AVB			0x00
+#define MV88E6XXX_AVB_CFG_LEGACY		0x04
+
+/* Common AVB Global Config */
+
+#define MV88E6XXX_AVB_CFG_AVB_HI_FPRI_MASK	GENMASK(14, 12)
+#define MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)	FIELD_GET(MV88E6XXX_AVB_CFG_AVB_HI_FPRI_MASK, p)
+#define MV88E6XXX_AVB_CFG_AVB_HI_FPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_HI_FPRI_MASK, p)
+
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK	GENMASK(6, 4)
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_GET(p)	FIELD_GET(MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK, p)
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK, p)
+
+#define MV88E6XXX_AVB_CFG_HI_LIMIT		0x08 /* max frame size for Class A */
+#define MV88E6XXX_AVB_CFG_HI_LIMIT_MASK		GENMASK(10, 0)
+#define MV88E6XXX_AVB_CFG_HI_LIMIT_GET(p)	FIELD_GET(MV88E6XXX_AVB_CFG_HI_LIMIT_MASK, p)
+#define MV88E6XXX_AVB_CFG_HI_LIMIT_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_HI_LIMIT_MASK, p)
+
+#define MV88E6XXX_AVB_CFG_OUI_HI		0x0C
+#define MV88E6XXX_AVB_CFG_OUI_LO		0x0D
+
+/* 6352 Family AVB Global Config (4 TX queues) */
+
+#define MV88E6352_AVB_CFG_AVB_HI_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)
+#define MV88E6352_AVB_CFG_AVB_HI_FPRI_SET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_SET(p)
+
+#define MV88E6352_AVB_CFG_AVB_HI_QPRI_MASK	GENMASK(9, 8)
+#define MV88E6352_AVB_CFG_AVB_HI_QPRI_GET(p)	FIELD_GET(MV88E6352_AVB_CFG_AVB_HI_QPRI_MASK, p)
+#define MV88E6352_AVB_CFG_AVB_HI_QPRI_SET(p)	FIELD_PREP(MV88E6352_AVB_CFG_AVB_HI_QPRI_MASK, p)
+
+#define MV88E6352_AVB_CFG_AVB_LO_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_LO_FPRI_GET(p)
+#define MV88E6352_AVB_CFG_AVB_LO_FPRI_SET(p)	MV88E6XXX_AVB_CFG_AVB_LO_FPRI_SET(p)
+
+#define MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK	GENMASK(1, 0)
+#define MV88E6352_AVB_CFG_AVB_LO_QPRI_GET(p)	FIELD_GET(MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK, p)
+#define MV88E6352_AVB_CFG_AVB_LO_QPRI_SET(p)	FIELD_PREP(MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK, p)
+
+/* 6390 Family AVB Global Config (8 TX queues) */
+
+#define MV88E6390_AVB_CFG_AVB_HI_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)
+#define MV88E6390_AVB_CFG_AVB_HI_FPRI_SET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_SET(p)
+
+#define MV88E6390_AVB_CFG_AVB_HI_QPRI_MASK	GENMASK(10, 8)
+#define MV88E6390_AVB_CFG_AVB_HI_QPRI_GET(p)	FIELD_GET(MV88E6390_AVB_CFG_AVB_HI_QPRI_MASK, p)
+#define MV88E6390_AVB_CFG_AVB_HI_QPRI_SET(p)	FIELD_PREP(MV88E6390_AVB_CFG_AVB_HI_QPRI_MASK, p)
+
+#define MV88E6390_AVB_CFG_AVB_LO_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_LO_FPRI_GET(p)
+#define MV88E6390_AVB_CFG_AVB_LO_FPRI_SET(p)	MV88E6XXX_AVB_CFG_AVB_LO_FPRI_SET(p)
+
+#define MV88E6390_AVB_CFG_AVB_LO_QPRI_MASK	GENMASK(2, 0)
+#define MV88E6390_AVB_CFG_AVB_LO_QPRI_GET(p)	FIELD_GET(MV88E6390_AVB_CFG_AVB_LO_QPRI_MASK, p)
+#define MV88E6390_AVB_CFG_AVB_LO_QPRI_SET(p)	FIELD_PREP(MV88E6390_AVB_CFG_AVB_LO_QPRI_MASK, p)
+
+#define MV88E6352_AVB_QUEUE_MIN(tc)		(tc)
+#define MV88E6352_AVB_QUEUE_MAX(tc)		((tc) + 1)
+
+/* Global Qav registers */
+#define MV88E6XXX_QAV_CFG			0x00
+
+#define MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_MASK	GENMASK(9, 0)
+#define MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_GET(x)	FIELD_GET(MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_MASK, x)
+#define MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_SET(x)	FIELD_PREP(MV88E6XXX_QAV_CFG_GLOBAL_ISO_PTR_MASK, x)
+
+/* allow mgmt frames in isochronous pointer pool */
+#define MV88E6XXX_QAV_CFG_ADMIT_MGMT		0x8000
+
+/* Per-port AVB registers */
+
+/* Offset 0x00: AVB Port Config */
+#define MV88E6XXX_PORT_AVB_CFG				0x00
+#define MV88E6XXX_PORT_AVB_CFG_AVB_MODE			GENMASK(15, 14)
+/* all frames legacy (non-AVB) unless overridden */
+#define MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY		0x0000
+/* AVB frames indicated by priority */
+#define MV88E6XXX_PORT_AVB_CFG_AVB_MODE_STANDARD	0x4000
+/* STANDARD && ATU has STATIC_AVB_NRL bit set */
+#define MV88E6XXX_PORT_AVB_CFG_AVB_MODE_ENHANCED	0x8000
+/* ENHANCED && source port in destination port vector */
+#define MV88E6XXX_PORT_AVB_CFG_AVB_MODE_SECURE		0xc000
+
+#define MV88E6XXX_PORT_AVB_CFG_AVB_OVERRIDE		0x2000
+#define MV88E6XXX_PORT_AVB_CFG_AVB_FILTER_BAD_AVB	0x1000
+#define MV88E6XXX_PORT_AVB_CFG_AVB_TUNNEL		0x0800
+#define MV88E6XXX_PORT_AVB_CFG_AVB_DISCARD_BAD		0x0400
+
+/* action is mv88e6xxx_policy_action */
+#define MV88E6XXX_PORT_AVB_CFG_AVB_HI_POLICY_MASK	GENMASK(3, 2)
+#define MV88E6XXX_PORT_AVB_CFG_AVB_HI_POLICY_GET(p)	\
+	FIELD_GET(MV88E6XXX_PORT_AVB_CFG_AVB_HI_POLICY_MASK, p)
+#define MV88E6XXX_PORT_AVB_CFG_AVB_HI_POLICY_SET(p)	\
+	FIELD_PREP(MV88E6XXX_PORT_AVB_CFG_AVB_HI_POLICY_MASK, p)
+
+#define MV88E6XXX_PORT_AVB_CFG_AVB_LO_POLICY_MASK	GENMASK(1, 0)
+#define MV88E6XXX_PORT_AVB_CFG_AVB_LO_POLICY_GET(p)	\
+	FIELD_GET(MV88E6XXX_PORT_AVB_CFG_AVB_LO_POLICY_MASK, p)
+#define MV88E6XXX_PORT_AVB_CFG_AVB_LO_POLICY_SET(p)	\
+	FIELD_PREP(MV88E6XXX_PORT_AVB_CFG_AVB_LO_POLICY_MASK, p)
+
+/* Per-family 802.1Qav operation tables */
+extern const struct mv88e6xxx_tc_ops mv88e6341_tc_ops;
+extern const struct mv88e6xxx_tc_ops mv88e6352_tc_ops;
+extern const struct mv88e6xxx_tc_ops mv88e6390_tc_ops;
+
+/* Set AVB queue priority policy. Caller must acquire register lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param policy	policy settings to apply
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
+			    const struct mv88e6xxx_avb_tc_policy *policy);
+
+/* Clear AVB queue priority policy. Caller must acquire register lock.
+ *
+ * @param chip		Marvell switch chip instance
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+int mv88e6xxx_avb_tc_disable(struct mv88e6xxx_chip *chip);
+
+/* The MAAP address range is 91:E0:F0:00:00:00 thru 91:E0:F0:00:FF:FF
+ * (IEEE 1722 Annex D)
+ */
+static const u8 eth_maap_mcast_addr_base[ETH_ALEN] __aligned(2) = {
+	0x91, 0xe0, 0xf0, 0x00, 0x00, 0x00
+};
+
+static inline bool ether_addr_is_maap_mcast(const u8 *addr)
+{
+	u8 mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0x00, 0x00 };
+
+	return ether_addr_equal_masked(addr, eth_maap_mcast_addr_base, mask);
+}
+
+#endif /* _MV88E6XXX_AVB_H */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 42189aeb9aec0..6ba2179d1c4ee 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/dcbnl.h>
 #include <linux/delay.h>
 #include <linux/dsa/mv88e6xxx.h>
 #include <linux/etherdevice.h>
@@ -33,6 +34,7 @@
 #include <linux/phylink.h>
 #include <net/dsa.h>
 
+#include "avb.h"
 #include "chip.h"
 #include "devlink.h"
 #include "global1.h"
@@ -2292,7 +2294,8 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		if (!entry.portvec)
 			entry.state = 0;
 	} else {
-		if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC)
+		if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC ||
+		    state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC_AVB_NRL)
 			entry.portvec = BIT(port);
 		else
 			entry.portvec |= BIT(port);
@@ -2875,11 +2878,17 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 				  struct dsa_db db)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	u8 state;
 	int err;
 
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_ENHANCED &&
+	    chip->avb_tc_policy.port_mask & BIT(port))
+		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC_AVB_NRL;
+	else
+		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC;
+
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid, state);
 	if (err)
 		goto out;
 
@@ -2932,7 +2941,9 @@ static int mv88e6xxx_port_db_dump_fid(struct mv88e6xxx_chip *chip,
 			continue;
 
 		is_static = (addr.state ==
-			     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+			     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC ||
+			     addr.state ==
+			     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC_AVB_NRL);
 		err = cb(addr.mac, vid, is_static, data);
 		if (err)
 			return err;
@@ -4529,6 +4540,7 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.ptp_ops = &mv88e6165_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6165_ops = {
@@ -4566,6 +4578,7 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.avb_ops = &mv88e6165_avb_ops,
 	.ptp_ops = &mv88e6165_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6171_ops = {
@@ -4987,10 +5000,11 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
-	.avb_ops = &mv88e6390_avb_ops,
+	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6240_ops = {
@@ -5052,6 +5066,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6250_ops = {
@@ -5097,6 +5112,7 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6250_phylink_get_caps,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6290_ops = {
@@ -5158,6 +5174,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.ptp_ops = &mv88e6390_ptp_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
@@ -5211,6 +5228,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e632x_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
@@ -5263,6 +5281,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e632x_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6341_ops = {
@@ -5328,6 +5347,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6341_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6350_ops = {
@@ -5422,6 +5442,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6351_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
@@ -5486,6 +5507,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_set_tx_amplitude = mv88e6352_serdes_set_tx_amplitude,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6390_ops = {
@@ -5550,6 +5572,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6390x_ops = {
@@ -5614,6 +5637,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.ptp_ops = &mv88e6390_ptp_ops,
 	.phylink_get_caps = mv88e6390x_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6393x_ops = {
@@ -5677,6 +5701,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6393x_phylink_get_caps,
 	.pcs_ops = &mv88e6393x_pcs_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_info mv88e6xxx_table[] = {
@@ -6697,11 +6722,24 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 				  struct dsa_db db)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	u8 state;
 	int err;
 
+	/* In enhanced and secure modes, the switch will drop packets that end
+	 * up with an AVB frame priority but that do not have an ATU entry with
+	 * the AVB flag set. We make a slightly abstraction violating check for
+	 * MAAP multicast addresses (IEEE 1722 Annex D) to allow coexistence
+	 * with static IP MDB entries for packets without AVB frame priorities.
+	 */
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_ENHANCED &&
+	    (chip->avb_tc_policy.port_mask & BIT(port)) &&
+	    ether_addr_is_maap_mcast(mdb->addr))
+		state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL;
+	else
+		state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC;
+
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid, state);
 	if (err)
 		goto out;
 
@@ -6797,6 +6835,193 @@ static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int port,
 	mutex_unlock(&chip->reg_lock);
 }
 
+static int mv88e6xxx_qos_query_caps(struct tc_query_caps_base *base)
+{
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mv88e6xxx_qos_validate_mqprio(const struct device *dev,
+					 const struct mv88e6xxx_chip *chip,
+					 int port,
+					 const struct tc_mqprio_qopt_offload *mqprio,
+					 struct mv88e6xxx_avb_tc_policy *tcpol)
+{
+	const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	u8 avb_tcpol_set = 0;
+	int tc, pri;
+
+	memset(tcpol, 0, sizeof(*tcpol));
+
+	if (qopt->hw != TC_MQPRIO_HW_OFFLOAD_TCS) {
+		NL_SET_ERR_MSG(extack, "only full TC hardware offload is supported");
+		return -EOPNOTSUPP;
+	} else if (mqprio->shaper != TC_MQPRIO_SHAPER_DCB) {
+		NL_SET_ERR_MSG(extack, "only DCB shaper is supported");
+		return -EOPNOTSUPP;
+	} else if (qopt->num_tc > MV88E6XXX_AVB_TC_MAX + 1) {
+		NL_SET_ERR_MSG_FMT(extack, "too many traffic classes: %d", qopt->num_tc);
+		return -EOPNOTSUPP;
+	}
+
+	if (qopt->num_tc == 0)
+		return 0;
+
+	/* Validate and map TC to TX queue */
+	for (tc = MV88E6XXX_AVB_TC_LEGACY; tc < qopt->num_tc; tc++) {
+		if (qopt->offset[tc] + qopt->count[tc] > chip->info->num_tx_queues) {
+			NL_SET_ERR_MSG_FMT(extack, "queue %d out of range",
+					   qopt->offset[tc] + qopt->count[tc] - 1);
+			return -EOPNOTSUPP;
+		}
+
+		if (tc == MV88E6XXX_AVB_TC_LEGACY) {
+			tcpol->map[tc].count = qopt->count[tc];
+		} else if (qopt->count[tc] != 1) {
+			NL_SET_ERR_MSG_FMT(extack, "only one queue supported for TC %d", tc);
+			return -EOPNOTSUPP;
+		}
+
+		tcpol->map[tc].qpri = qopt->offset[tc];
+	}
+
+	/* Validate and map priority to TC */
+	for (pri = 0; pri < IEEE_8021Q_MAX_PRIORITIES; pri++) {
+		tc = qopt->prio_tc_map[pri];
+
+		if (tc == MV88E6XXX_AVB_TC_LEGACY)
+			continue;
+
+		if (avb_tcpol_set & BIT(tc)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "only one frame priority can be mapped to TC %d", tc);
+			return -EOPNOTSUPP;
+		}
+
+		avb_tcpol_set |= BIT(tc);
+		tcpol->map[tc].fpri = pri;
+	}
+
+	if (avb_tcpol_set != GENMASK(MV88E6XXX_AVB_TC_HI, MV88E6XXX_AVB_TC_LO)) {
+		NL_SET_ERR_MSG(extack,
+			       "both hi and lo priority TCs must have 802.1p priorities");
+		return -EOPNOTSUPP;
+	}
+
+	return qopt->num_tc;
+}
+
+static int mv88e6xxx_qos_port_mqprio(struct dsa_switch *ds, int port,
+				     struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct netlink_ext_ack *extack = mqprio->extack;
+	struct mv88e6xxx_avb_tc_policy tcpol;
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct net_device *user;
+	int err, num_tc, tc;
+	bool can_update_pol;
+
+	if (!dsa_is_user_port(ds, port))
+		return -EINVAL;
+
+	num_tc = mv88e6xxx_qos_validate_mqprio(ds->dev, chip, port, mqprio, &tcpol);
+	if (num_tc < 0)
+		return num_tc;
+
+	/* Update the kernel's view of the priority mapping policy, then update the
+	 * switch's.
+	 */
+	user = dsa_to_port(ds, port)->user;
+
+	err = netdev_set_num_tc(user, num_tc);
+	if (err)
+		goto err_reset_tc;
+
+	for (tc = 0; tc < num_tc; tc++) {
+		const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+
+		err = netdev_set_tc_queue(user, tc, 1, qopt->offset[tc]);
+		if (err)
+			goto err_reset_tc;
+	}
+
+	mutex_lock(&chip->reg_lock);
+
+	/* Update the actual priority mapping policy iff no policy has been set or the
+	 * only referant is the requesting port. Silently allow matching updates from
+	 * other ports. All other updates are rejected with -EOPNOTSUPP.
+	 */
+	can_update_pol = chip->avb_tc_policy.port_mask == 0 ||
+			 (hweight16(chip->avb_tc_policy.port_mask) == 1 &&
+			  ffs(chip->avb_tc_policy.port_mask) == port);
+
+	if (!can_update_pol &&
+	    num_tc > 0 &&
+	    memcmp(&tcpol.map, &chip->avb_tc_policy.map, sizeof(tcpol.map)) != 0) {
+		NL_SET_ERR_MSG(extack, "only a single AVB queue policy is supported per switch");
+		err = -EOPNOTSUPP;
+		goto err_unlock;
+	}
+
+	if (can_update_pol) {
+		err = num_tc > 0 ? mv88e6xxx_avb_tc_enable(chip, &tcpol)
+				 : mv88e6xxx_avb_tc_disable(chip);
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack, "failed to %s AVB queue policy: %d",
+					   num_tc > 0 ? "enable" : "disable", err);
+			goto err_unlock;
+		}
+
+		memcpy(&chip->avb_tc_policy.map, &tcpol.map, sizeof(tcpol.map));
+	}
+
+	if (num_tc)
+		chip->avb_tc_policy.port_mask |= BIT(port);
+	else
+		chip->avb_tc_policy.port_mask &= ~BIT(port);
+
+	mutex_unlock(&chip->reg_lock);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&chip->reg_lock);
+
+err_reset_tc:
+	netdev_reset_tc(user);
+
+	return err;
+}
+
+static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
+				   enum tc_setup_type type,
+				   void *type_data)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+
+	if (!chip->info->ops->tc_ops)
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return mv88e6xxx_qos_query_caps(type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return mv88e6xxx_qos_port_mqprio(ds, port, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int mv88e6xxx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 					   struct switchdev_brport_flags flags,
 					   struct netlink_ext_ack *extack)
@@ -7216,6 +7441,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_mdb_del		= mv88e6xxx_port_mdb_del,
 	.port_mirror_add	= mv88e6xxx_port_mirror_add,
 	.port_mirror_del	= mv88e6xxx_port_mirror_del,
+	.port_setup_tc		= mv88e6xxx_port_setup_tc,
 	.crosschip_bridge_join	= mv88e6xxx_crosschip_bridge_join,
 	.crosschip_bridge_leave	= mv88e6xxx_crosschip_bridge_leave,
 	.port_hwtstamp_set	= mv88e6xxx_port_hwtstamp_set,
@@ -7281,6 +7507,28 @@ static const void *pdata_device_get_match_data(struct device *dev)
 	return NULL;
 }
 
+static int mv88e6xxx_get_avb_mode(struct mv88e6xxx_chip *chip,
+				  enum mv88e6xxx_avb_mode *modep)
+{
+	struct dsa_mv88e6xxx_pdata *pdata = chip->dev->platform_data;
+	struct device_node *np = chip->dev->of_node;
+	int mode = MV88E6XXX_AVB_MODE_STANDARD;
+
+	if (np)
+		of_property_read_u32(np, "marvell,mv88e6xxx-avb-mode", &mode);
+	else if (pdata)
+		mode = pdata->avb_mode;
+
+	if (mode < MV88E6XXX_AVB_MODE_STANDARD ||
+	    mode > MV88E6XXX_AVB_MODE_SECURE) {
+		dev_err(chip->dev, "Invalid AVB mode %d\n", mode);
+		return -EINVAL;
+	}
+
+	*modep = mode;
+	return 0;
+}
+
 /* There is no suspend to RAM support at DSA level yet, the switch configuration
  * would be lost after a power cycle so prevent it to be suspended.
  */
@@ -7376,6 +7624,10 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 			chip->eeprom_len = pdata->eeprom_len;
 	}
 
+	err = mv88e6xxx_get_avb_mode(chip, &chip->avb_tc_policy.mode);
+	if (err)
+		goto out;
+
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_switch_reset(chip);
 	mv88e6xxx_reg_unlock(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index b861486a7065e..71e536fbd2d24 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -19,6 +19,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <net/dsa.h>
+#include <net/pkt_sched.h>
 
 #define EDSA_HLEN		8
 #define MV88E6XXX_N_FID		4096
@@ -213,6 +214,7 @@ struct mv88e6xxx_avb_ops;
 struct mv88e6xxx_ptp_ops;
 struct mv88e6xxx_pcs_ops;
 struct mv88e6xxx_cc_coeffs;
+struct mv88e6xxx_tc_ops;
 
 struct mv88e6xxx_irq {
 	u16 masked;
@@ -247,6 +249,46 @@ struct mv88e6xxx_port_hwtstamp {
 	struct kernel_hwtstamp_config tstamp_config;
 };
 
+enum mv88e6xxx_avb_mode {
+	MV88E6XXX_AVB_MODE_STANDARD = 0,
+	MV88E6XXX_AVB_MODE_ENHANCED,
+	MV88E6XXX_AVB_MODE_SECURE,
+};
+
+enum mv88e6xxx_avb_tc {
+	/* Non-AVB traffic */
+	MV88E6XXX_AVB_TC_LEGACY = 0,
+	/* Higher latency, low priority AVB flows (class B) */
+	MV88E6XXX_AVB_TC_LO = 1,
+	/* Low latency, high priority AVB flows (class A) */
+	MV88E6XXX_AVB_TC_HI = 2,
+	MV88E6XXX_AVB_TC_MAX = MV88E6XXX_AVB_TC_HI
+};
+
+struct mv88e6xxx_avb_priority_map {
+	union {
+		/* Number of queues, for MV88E6XXX_AVB_TC_LEGACY */
+		u8 count;
+
+		/* Frame priority, for MV88E6XXX_AVB_TC_LO/HI */
+		u8 fpri;
+	};
+
+	/* Queue priority*/
+	u8 qpri;
+};
+
+struct mv88e6xxx_avb_tc_policy {
+	/* AVB mode */
+	enum mv88e6xxx_avb_mode mode;
+
+	/* Ports participating in HW offload priority mapping */
+	u16 port_mask;
+
+	/* Map from 802.1p frame priority to queue */
+	struct mv88e6xxx_avb_priority_map map[MV88E6XXX_AVB_TC_MAX + 1];
+};
+
 enum mv88e6xxx_policy_mapping {
 	MV88E6XXX_POLICY_MAPPING_DA,
 	MV88E6XXX_POLICY_MAPPING_SA,
@@ -433,6 +475,9 @@ struct mv88e6xxx_chip {
 	int egress_dest_port;
 	int ingress_dest_port;
 
+	/* Global AVB queue policy resources */
+	struct mv88e6xxx_avb_tc_policy avb_tc_policy;
+
 	/* Per-port timestamping resources. */
 	struct mv88e6xxx_port_hwtstamp port_hwtstamp[DSA_MAX_PORTS];
 
@@ -685,6 +730,9 @@ struct mv88e6xxx_ops {
 
 	/* Max Frame Size */
 	int (*set_max_frame_size)(struct mv88e6xxx_chip *chip, int mtu);
+
+	/* Traffic control / Qdisc operations */
+	const struct mv88e6xxx_tc_ops *tc_ops;
 };
 
 struct mv88e6xxx_irq_ops {
@@ -730,6 +778,28 @@ struct mv88e6xxx_avb_ops {
 	int (*tai_read)(struct mv88e6xxx_chip *chip, int addr, u16 *data,
 			int len);
 	int (*tai_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
+
+	/* Access port-scoped Audio Video Bridging registers */
+	int (*port_avb_read)(struct mv88e6xxx_chip *chip, int port, int addr,
+			     u16 *data, int len);
+	int (*port_avb_write)(struct mv88e6xxx_chip *chip, int port, int addr,
+			      u16 data);
+
+	/* Access global Audio Video Bridging registers */
+	int (*avb_read)(struct mv88e6xxx_chip *chip, int addr, u16 *data,
+			int len);
+	int (*avb_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
+
+	/* Access global Class Shaping and Pacing registers */
+	int (*qav_read)(struct mv88e6xxx_chip *chip, int addr, u16 *data,
+			int len);
+	int (*qav_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
+
+	/* Access port-scoped Class Shaping and Pacing registers */
+	int (*port_qav_read)(struct mv88e6xxx_chip *chip, int port, int addr,
+			     u16 *data, int len);
+	int (*port_qav_write)(struct mv88e6xxx_chip *chip, int port, int addr,
+			      u16 data);
 };
 
 struct mv88e6xxx_ptp_ops {
@@ -759,6 +829,12 @@ struct mv88e6xxx_pcs_ops {
 
 };
 
+struct mv88e6xxx_tc_ops {
+	int (*tc_enable)(struct mv88e6xxx_chip *chip,
+			 const struct mv88e6xxx_avb_tc_policy *policy);
+	int (*tc_disable)(struct mv88e6xxx_chip *chip);
+};
+
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
 {
 	return chip->info->max_sid > 0 &&
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 9820cd5967574..ce2c5cc3ea585 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -356,16 +356,21 @@ int mv88e6085_g1_ip_pri_map(struct mv88e6xxx_chip *chip)
 
 /* Offset 0x18: IEEE-PRI Register */
 
+int mv88e6xxx_g1_set_ieee_pri_map(struct mv88e6xxx_chip *chip, u16 map)
+{
+	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, map);
+}
+
 int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip)
 {
 	/* Reset the IEEE Tag priorities to defaults */
-	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, 0xfa41);
+	return mv88e6xxx_g1_set_ieee_pri_map(chip, 0xfa41);
 }
 
 int mv88e6250_g1_ieee_pri_map(struct mv88e6xxx_chip *chip)
 {
 	/* Reset the IEEE Tag priorities to defaults */
-	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, 0xfa50);
+	return mv88e6xxx_g1_set_ieee_pri_map(chip, 0xfa50);
 }
 
 /* Offset 0x1a: Monitor Control */
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 74be4c485ab10..3018901629fef 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -2,7 +2,7 @@
 /*
  * Marvell 88E6xxx Switch Global (1) Registers support
  *
- * Copyright (c) 2008 Marvell Semiconductor
+ * Copyright (c) 2008-2021 Marvell Semiconductor
  *
  * Copyright (c) 2016-2017 Savoir-faire Linux Inc.
  *	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
@@ -62,6 +62,7 @@
 #define MV88E6185_G1_CTL1_MAX_FRAME_1632	0x0400
 #define MV88E6185_G1_CTL1_RELOAD_EEPROM		0x0200
 #define MV88E6393X_G1_CTL1_DEVICE2_EN		0x0200
+#define MV88E6XXX_G1_CTL1_AVB_EN		0x0100
 #define MV88E6XXX_G1_CTL1_DEVICE_EN		0x0080
 #define MV88E6XXX_G1_CTL1_STATS_DONE_EN		0x0040
 #define MV88E6XXX_G1_CTL1_VTU_PROBLEM_EN	0x0020
@@ -193,6 +194,47 @@
 /* Offset 0x18: IEEE-PRI Register */
 #define MV88E6XXX_G1_IEEE_PRI	0x18
 
+/* Switches supporting 4 TX queues pack FPri to QPri mappings into a single
+ * register value.
+ *
+ * Extract QPri for a given FPri from the provided register value.
+ *
+ * @param val	register value
+ * @param fpri	frame priority
+ *
+ * @return	queue priority
+ */
+static inline u16 mv88e6352_g1_ieee_pri_get(u16 val, u8 fpri)
+{
+	u16 mask;
+
+	fpri &= 0x7;
+	fpri <<= 1;
+	mask = GENMASK(fpri + 1, fpri);
+
+	return (val & mask) >> fpri;
+}
+
+/* Add a FPri to QPri mapping to the register value argument.
+ *
+ * @param fpri	frame priority
+ * @param qpri	queue priority
+ * @param reg	register value, should be 0 on first call
+ */
+static inline void mv88e6352_g1_ieee_pri_set(u8 fpri, u8 qpri, u16 *reg)
+{
+	u16 mask;
+
+	fpri &= 0x7;
+	fpri <<= 1;
+	mask = GENMASK(fpri + 1, fpri);
+
+	*reg &= ~(mask);
+	*reg |= (qpri & 0x3) << fpri;
+}
+
+#define MV88E6390_G1_IEEE_PRI_UPDATE	0x80
+
 /* Offset 0x19: Core Tag Type */
 #define MV88E6185_G1_CORE_TAG_TYPE	0x19
 
@@ -311,6 +353,7 @@ int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
 int mv88e6085_g1_ip_pri_map(struct mv88e6xxx_chip *chip);
 
+int mv88e6xxx_g1_set_ieee_pri_map(struct mv88e6xxx_chip *chip, u16 map);
 int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_ieee_pri_map(struct mv88e6xxx_chip *chip);
 
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 82f9b410de0b8..7cebc2dc29db1 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -176,15 +176,17 @@
 #define MV88E6352_G2_AVB_CMD_PORT_TAIGLOBAL	0xe
 #define MV88E6165_G2_AVB_CMD_PORT_PTPGLOBAL	0xf
 #define MV88E6352_G2_AVB_CMD_PORT_PTPGLOBAL	0xf
+#define MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL	0xf
 #define MV88E6390_G2_AVB_CMD_PORT_MASK		0x1f00
 #define MV88E6390_G2_AVB_CMD_PORT_TAIGLOBAL	0x1e
 #define MV88E6390_G2_AVB_CMD_PORT_PTPGLOBAL	0x1f
-#define MV88E6352_G2_AVB_CMD_BLOCK_PTP		0
-#define MV88E6352_G2_AVB_CMD_BLOCK_AVB		1
-#define MV88E6352_G2_AVB_CMD_BLOCK_QAV		2
-#define MV88E6352_G2_AVB_CMD_BLOCK_QVB		3
-#define MV88E6352_G2_AVB_CMD_BLOCK_MASK		0x00e0
-#define MV88E6352_G2_AVB_CMD_ADDR_MASK		0x001f
+#define MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL	0x1f
+#define MV88E6XXX_G2_AVB_CMD_BLOCK_PTP		0
+#define MV88E6XXX_G2_AVB_CMD_BLOCK_AVB		1
+#define MV88E6XXX_G2_AVB_CMD_BLOCK_QAV		2
+#define MV88E6XXX_G2_AVB_CMD_BLOCK_QVB		3
+#define MV88E6XXX_G2_AVB_CMD_BLOCK_MASK		0x00e0
+#define MV88E6XXX_G2_AVB_CMD_ADDR_MASK		0x001f
 
 /* Offset 0x17: AVB Data Register */
 #define MV88E6352_G2_AVB_DATA		0x17
diff --git a/drivers/net/dsa/mv88e6xxx/global2_avb.c b/drivers/net/dsa/mv88e6xxx/global2_avb.c
index 657783e043ff1..e9f75f7d3b3a2 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_avb.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_avb.c
@@ -14,6 +14,7 @@
 #include <linux/bitfield.h>
 
 #include "global2.h"
+#include "avb.h"
 
 /* Offset 0x16: AVB Command Register
  * Offset 0x17: AVB Data Register
@@ -95,7 +96,7 @@ static int mv88e6352_g2_avb_port_ptp_read(struct mv88e6xxx_chip *chip,
 {
 	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
 				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
-		     (port << 8) | (MV88E6352_G2_AVB_CMD_BLOCK_PTP << 5) |
+		     (port << 8) | (MV88E6XXX_G2_AVB_CMD_BLOCK_PTP << 5) |
 		     addr;
 
 	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
@@ -105,7 +106,7 @@ static int mv88e6352_g2_avb_port_ptp_write(struct mv88e6xxx_chip *chip,
 					   int port, int addr, u16 data)
 {
 	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE | (port << 8) |
-		      (MV88E6352_G2_AVB_CMD_BLOCK_PTP << 5) | addr;
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_PTP << 5) | addr;
 
 	return mv88e6xxx_g2_avb_write(chip, writeop, data);
 }
@@ -142,6 +143,92 @@ static int mv88e6352_g2_avb_tai_write(struct mv88e6xxx_chip *chip, int addr,
 					addr, data);
 }
 
+static int mv88e6352_g2_avb_port_avb_read(struct mv88e6xxx_chip *chip,
+					  int port, int addr, u16 *data,
+					  int len)
+{
+	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
+				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
+		     (port << 8) | (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6352_g2_avb_port_avb_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6352_g2_avb_avb_read(struct mv88e6xxx_chip *chip, int addr,
+				     u16 *data, int len)
+{
+	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
+				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
+		     (MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		     (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6352_g2_avb_avb_write(struct mv88e6xxx_chip *chip, int addr,
+				      u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE |
+		      (MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6352_g2_avb_qav_read(struct mv88e6xxx_chip *chip, int addr,
+				     u16 *data, int len)
+{
+	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
+				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
+		     (MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		     (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6352_g2_avb_qav_write(struct mv88e6xxx_chip *chip, int addr,
+				      u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE |
+		      (MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6352_g2_avb_port_qav_read(struct mv88e6xxx_chip *chip,
+					  int port, int addr, u16 *data,
+					  int len)
+{
+	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
+				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
+		     (port << 8) | (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6352_g2_avb_port_qav_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 const struct mv88e6xxx_avb_ops mv88e6352_avb_ops = {
 	.port_ptp_read		= mv88e6352_g2_avb_port_ptp_read,
 	.port_ptp_write		= mv88e6352_g2_avb_port_ptp_write,
@@ -149,6 +236,14 @@ const struct mv88e6xxx_avb_ops mv88e6352_avb_ops = {
 	.ptp_write		= mv88e6352_g2_avb_ptp_write,
 	.tai_read		= mv88e6352_g2_avb_tai_read,
 	.tai_write		= mv88e6352_g2_avb_tai_write,
+	.port_avb_read		= mv88e6352_g2_avb_port_avb_read,
+	.port_avb_write		= mv88e6352_g2_avb_port_avb_write,
+	.avb_read		= mv88e6352_g2_avb_avb_read,
+	.avb_write		= mv88e6352_g2_avb_avb_write,
+	.qav_read		= mv88e6352_g2_avb_qav_read,
+	.qav_write		= mv88e6352_g2_avb_qav_write,
+	.port_qav_read		= mv88e6352_g2_avb_port_qav_read,
+	.port_qav_write		= mv88e6352_g2_avb_port_qav_write,
 };
 
 static int mv88e6165_g2_avb_tai_read(struct mv88e6xxx_chip *chip, int addr,
@@ -174,6 +269,14 @@ const struct mv88e6xxx_avb_ops mv88e6165_avb_ops = {
 	.ptp_write		= mv88e6352_g2_avb_ptp_write,
 	.tai_read		= mv88e6165_g2_avb_tai_read,
 	.tai_write		= mv88e6165_g2_avb_tai_write,
+	.port_avb_read		= mv88e6352_g2_avb_port_avb_read,
+	.port_avb_write		= mv88e6352_g2_avb_port_avb_write,
+	.avb_read		= mv88e6352_g2_avb_avb_read,
+	.avb_write		= mv88e6352_g2_avb_avb_write,
+	.qav_read		= mv88e6352_g2_avb_qav_read,
+	.qav_write		= mv88e6352_g2_avb_qav_write,
+	.port_qav_read		= mv88e6352_g2_avb_port_qav_read,
+	.port_qav_write		= mv88e6352_g2_avb_port_qav_write,
 };
 
 static int mv88e6390_g2_avb_port_ptp_read(struct mv88e6xxx_chip *chip,
@@ -182,7 +285,7 @@ static int mv88e6390_g2_avb_port_ptp_read(struct mv88e6xxx_chip *chip,
 {
 	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
 				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
-		     (port << 8) | (MV88E6352_G2_AVB_CMD_BLOCK_PTP << 5) |
+		     (port << 8) | (MV88E6XXX_G2_AVB_CMD_BLOCK_PTP << 5) |
 		     addr;
 
 	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
@@ -192,7 +295,7 @@ static int mv88e6390_g2_avb_port_ptp_write(struct mv88e6xxx_chip *chip,
 					   int port, int addr, u16 data)
 {
 	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE | (port << 8) |
-		      (MV88E6352_G2_AVB_CMD_BLOCK_PTP << 5) | addr;
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_PTP << 5) | addr;
 
 	return mv88e6xxx_g2_avb_write(chip, writeop, data);
 }
@@ -229,6 +332,92 @@ static int mv88e6390_g2_avb_tai_write(struct mv88e6xxx_chip *chip, int addr,
 					addr, data);
 }
 
+static int mv88e6390_g2_avb_port_avb_read(struct mv88e6xxx_chip *chip,
+					  int port, int addr, u16 *data,
+					  int len)
+{
+	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
+				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
+		     (port << 8) | (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6390_g2_avb_port_avb_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6390_g2_avb_avb_read(struct mv88e6xxx_chip *chip, int addr,
+				     u16 *data, int len)
+{
+	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
+				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
+		     (MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		     (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6390_g2_avb_avb_write(struct mv88e6xxx_chip *chip, int addr,
+				      u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE |
+		      (MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6390_g2_avb_qav_read(struct mv88e6xxx_chip *chip, int addr,
+				     u16 *data, int len)
+{
+	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
+				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
+		     (MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		     (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6390_g2_avb_qav_write(struct mv88e6xxx_chip *chip, int addr,
+				      u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE |
+		      (MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6390_g2_avb_port_qav_read(struct mv88e6xxx_chip *chip,
+					  int port, int addr, u16 *data,
+					  int len)
+{
+	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
+				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
+		     (port << 8) | (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6390_g2_avb_port_qav_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6XXX_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 const struct mv88e6xxx_avb_ops mv88e6390_avb_ops = {
 	.port_ptp_read		= mv88e6390_g2_avb_port_ptp_read,
 	.port_ptp_write		= mv88e6390_g2_avb_port_ptp_write,
@@ -236,4 +425,12 @@ const struct mv88e6xxx_avb_ops mv88e6390_avb_ops = {
 	.ptp_write		= mv88e6390_g2_avb_ptp_write,
 	.tai_read		= mv88e6390_g2_avb_tai_read,
 	.tai_write		= mv88e6390_g2_avb_tai_write,
+	.port_avb_read		= mv88e6390_g2_avb_port_avb_read,
+	.port_avb_write		= mv88e6390_g2_avb_port_avb_write,
+	.avb_read		= mv88e6390_g2_avb_avb_read,
+	.avb_write		= mv88e6390_g2_avb_avb_write,
+	.qav_read		= mv88e6390_g2_avb_qav_read,
+	.qav_write		= mv88e6390_g2_avb_qav_write,
+	.port_qav_read		= mv88e6390_g2_avb_port_qav_read,
+	.port_qav_write		= mv88e6390_g2_avb_port_qav_write,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 66b1b72772810..db5cc28b8b701 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1605,6 +1605,15 @@ int mv88e6390_port_tag_remap(struct mv88e6xxx_chip *chip, int port)
 	return 0;
 }
 
+int mv88e6390_port_set_ieeepmt_ingress_pcp(struct mv88e6xxx_chip *chip, int port,
+					   u8 pcp, u8 fpri, u8 qpri)
+{
+	return mv88e6xxx_port_ieeepmt_write(chip, port,
+					    MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_INGRESS_PCP,
+					    pcp,
+					    (fpri | qpri << 4));
+}
+
 /* Offset 0x0E: Policy Control Register */
 
 static int
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index c1d2f99efb1c6..2d2dde9b45ede 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -527,6 +527,8 @@ int mv88e6xxx_port_set_8021q_mode(struct mv88e6xxx_chip *chip, int port,
 				  u16 mode);
 int mv88e6095_port_tag_remap(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_port_tag_remap(struct mv88e6xxx_chip *chip, int port);
+int mv88e6390_port_set_ieeepmt_ingress_pcp(struct mv88e6xxx_chip *chip, int port,
+					   u8 pcp, u8 fpri, u8 qpri);
 int mv88e6xxx_port_set_egress_mode(struct mv88e6xxx_chip *chip, int port,
 				   enum mv88e6xxx_egress_mode mode);
 int mv88e6085_port_set_frame_mode(struct mv88e6xxx_chip *chip, int port,
diff --git a/include/linux/platform_data/mv88e6xxx.h b/include/linux/platform_data/mv88e6xxx.h
index 21452a9365e1e..6366360fc15e1 100644
--- a/include/linux/platform_data/mv88e6xxx.h
+++ b/include/linux/platform_data/mv88e6xxx.h
@@ -14,6 +14,7 @@ struct dsa_mv88e6xxx_pdata {
 	struct net_device *netdev;
 	u32 eeprom_len;
 	int irq;
+	int avb_mode;
 };
 
 #endif
-- 
2.43.0


