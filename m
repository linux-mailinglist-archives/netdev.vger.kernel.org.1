Return-Path: <netdev+bounces-292021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNnwLSM/FmomjwcAu9opvQ
	(envelope-from <netdev+bounces-292021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:47:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7855DE09A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B7B530B4F8D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1B2EF652;
	Wed, 27 May 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="dURYzIW9"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44787279334;
	Wed, 27 May 2026 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842659; cv=none; b=MLgj7PrBmhWGBli/wAmT/6KNVEguuNgynzhmzrweUnWFkB0NLNtcXx6uXfnJ5NTcGDLsMgDQlhkBCO311S++c762LgE9RJxrc4xAh8YHnpVlP5d6Myg2uFckn8w/Up4sjix6c6Hb4D+E6tJEhi5E2xmT95lgR7O5VWu4s7Y1AB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842659; c=relaxed/simple;
	bh=guPJ4eEDK1lvss2uFmb6DnOxuntIRwlPluv9ghUboe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H82Y+5eT0iCmfym/tYHbLhs6LZNezhMSfd+1A71VpGP9f35iFzugeIb3vwaTR4wWwttQfWq/klDjdtIgOUdCuP7meTujX7+SOASTiZF5Mj8XVfJ0g90asjiF3vuW/oDgaGJXY0xTqHwDzQub5YrdlZqMHcJN6Bqz3SBPioCQb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=dURYzIW9; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tH030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:45 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tH030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842629; bh=8rRU2/NlYN+ehmrlDHDaKOFB/u2alnivzWqgk+qtElc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dURYzIW912lnINpGvlp2JZwKTj1GdTT1RTdUgibvQmjBdeB0BpyiW5mOXxnVDZ1X+
	 U6PoFYr5CqlP3lcaMO/z9dt3x26SJFgKoZMikxa0Fbg0PAncCXFVYPr20hyMl2a/UK
	 brHpg0zw26tcuxdkk/7phGROjk5CH2D0DYTkAo8ygug/QrMo5L0dJpJ/BiciWp0GX/
	 2n4mIShK9ZBHSzzKr8g7Cblv7Zm+Pa3Ui32YdEQUsVW4/aw2dw13vI3wdw+5cbcwWa
	 AXgV0AlWK0RPQMwqO7csm3G24Vq0rPBA5jOHnGTxgWW979zpFiD8BxZPkLO6FOUSIU
	 9Aykg7nmvxdLw==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: dsa: mv88e6xxx: MQPRIO support
Date: Wed, 27 May 2026 10:42:50 +1000
Message-ID: <5840fea34d60313f25d91d36b31bb84620736060.1779841530.git.lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779841530.git.lukeh@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[padl.com,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292021-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,padl.com:mid,padl.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tcpol.map:url]
X-Rspamd-Queue-Id: DE7855DE09A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/dsa/mv88e6xxx/avb.c         | 518 ++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/avb.h         | 197 +++++++++
 drivers/net/dsa/mv88e6xxx/chip.c        | 276 ++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        |  76 ++++
 drivers/net/dsa/mv88e6xxx/global1.c     |   9 +-
 drivers/net/dsa/mv88e6xxx/global1.h     |  45 +-
 drivers/net/dsa/mv88e6xxx/global2.h     |  14 +-
 drivers/net/dsa/mv88e6xxx/global2_avb.c | 205 +++++++++-
 drivers/net/dsa/mv88e6xxx/port.c        |   9 +
 drivers/net/dsa/mv88e6xxx/port.h        |   2 +
 include/linux/platform_data/mv88e6xxx.h |   1 +
 12 files changed, 1336 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.h

diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index b0b08c6f159c6..6123b431e255e 100644
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
index 0000000000000..c535bf4fe3623
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Marvell 88E6xxx Switch AVB support
+ *
+ * Copyright (c) 2008 Marvell Semiconductor
+ *
+ * Copyright (c) 2024-2026 PADL Software Pty Ltd
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
+/* Set the AVB global policy limit registers
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
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_HI_LIMIT, data);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* Set the global isochronous queue pointer threshold
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
+/* Enable or disable a port for AVB
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
+	return err;
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
+		goto err_mac_avb;
+
+	err = mv88e6xxx_tc_enable(chip, policy);
+	if (err)
+		goto err_iso_ptr;
+
+	err = mv88e6xxx_avb_set_avb_mode(chip, true);
+	if (err)
+		goto err_tc;
+
+	return 0;
+
+err_tc:
+	mv88e6xxx_tc_disable(chip);
+err_iso_ptr:
+	mv88e6xxx_qav_set_iso_ptr(chip, 0);
+err_mac_avb:
+	if (chip->avb_tc_policy.mode >= MV88E6XXX_AVB_MODE_ENHANCED)
+		mv88e6xxx_g1_atu_set_mac_avb(chip, false);
+
+	return err;
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
+
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
index 0000000000000..72d1c26a84731
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.h
@@ -0,0 +1,197 @@
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
+#endif /* _MV88E6XXX_AVB_H */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5d45363c67bbd..cb7dd75ab6ef2 100644
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
@@ -2291,7 +2293,8 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		if (!entry.portvec)
 			entry.state = 0;
 	} else {
-		if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC)
+		if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC ||
+		    state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC_AVB_NRL)
 			entry.portvec = BIT(port);
 		else
 			entry.portvec |= BIT(port);
@@ -2931,7 +2934,9 @@ static int mv88e6xxx_port_db_dump_fid(struct mv88e6xxx_chip *chip,
 			continue;
 
 		is_static = (addr.state ==
-			     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+			     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC ||
+			     addr.state ==
+			     MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC_AVB_NRL);
 		err = cb(addr.mac, vid, is_static, data);
 		if (err)
 			return err;
@@ -4539,6 +4544,7 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 	.ptp_ops = &mv88e6165_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6165_ops = {
@@ -4576,6 +4582,7 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 	.avb_ops = &mv88e6165_avb_ops,
 	.ptp_ops = &mv88e6165_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6171_ops = {
@@ -4993,10 +5000,11 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
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
@@ -5057,6 +5065,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6250_ops = {
@@ -5102,6 +5111,7 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6250_phylink_get_caps,
 	.set_max_frame_size = mv88e6185_g1_set_max_frame_size,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6290_ops = {
@@ -5163,6 +5173,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
 	.tcam_ops = &mv88e6390_tcam_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
@@ -5219,6 +5230,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e632x_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
@@ -5275,6 +5287,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e632x_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6341_ops = {
@@ -5339,6 +5352,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6341_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6350_ops = {
@@ -5433,6 +5447,7 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6351_phylink_get_caps,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
@@ -5496,6 +5511,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.phylink_get_caps = mv88e6352_phylink_get_caps,
 	.pcs_ops = &mv88e6352_pcs_ops,
+	.tc_ops = &mv88e6352_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6390_ops = {
@@ -5560,6 +5576,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
 	.tcam_ops = &mv88e6390_tcam_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6390x_ops = {
@@ -5623,6 +5640,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.ptp_ops = &mv88e6390_ptp_ops,
 	.phylink_get_caps = mv88e6390x_phylink_get_caps,
 	.pcs_ops = &mv88e6390_pcs_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_ops mv88e6393x_ops = {
@@ -5687,6 +5705,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.phylink_get_caps = mv88e6393x_phylink_get_caps,
 	.pcs_ops = &mv88e6393x_pcs_ops,
 	.tcam_ops = &mv88e6393_tcam_ops,
+	.tc_ops = &mv88e6390_tc_ops,
 };
 
 static const struct mv88e6xxx_info mv88e6xxx_table[] = {
@@ -6724,11 +6743,48 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 				  struct dsa_db db)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_atu_entry existing;
+	u16 fid;
+	u8 state;
 	int err;
 
+	/* In Enhanced and Secure AVB modes, the switch drops AVB-priority
+	 * frames whose destination ATU entry lacks the AVB bit. Userspace
+	 * marks an MDB entry as belonging to a reserved stream via the
+	 * MDB_FLAGS_STREAM_RESERVED bridge flag, which arrives here as
+	 * SWITCHDEV_MDB_F_STREAM_RESERVED.
+	 */
+	if (mdb->flags & SWITCHDEV_MDB_F_STREAM_RESERVED)
+		state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL;
+	else
+		state = MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC;
+
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+
+	/* The ATU AVB bit is per-entry (per (FID, MAC)) and applies to every
+	 * port in the entry's portvec. The bridge's MDB_PG_FLAGS_STREAM_RESERVED
+	 * is per port group. Detect and reject the mismatch case where another
+	 * port has already established a different state for this MAC, so that
+	 * userspace gets MDB_FLAGS_OFFLOAD_FAILED rather than silently having
+	 * one port's intent overwrite another's.
+	 */
+	err = mv88e6xxx_port_db_get(chip, mdb->addr, mdb->vid, &fid, &existing);
+	if (err)
+		goto out;
+
+	if (ether_addr_equal(existing.mac, mdb->addr) &&
+	    (existing.state == MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC ||
+	     existing.state == MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC_AVB_NRL) &&
+	    existing.state != state &&
+	    (existing.portvec & ~BIT(port))) {
+		dev_info_ratelimited(chip->dev,
+				     "p%d: MDB %pM stream-reserved flag mismatches existing ATU entry\n",
+				     port, mdb->addr);
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid, state);
 	if (err)
 		goto out;
 
@@ -6824,6 +6880,189 @@ static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int port,
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
+			if (qopt->count[tc] == 0) {
+				NL_SET_ERR_MSG(extack, "legacy TC must have at least one queue");
+				return -ERANGE;
+			}
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
+	user = dsa_to_port(ds, port)->user;
+
+	mutex_lock(&chip->reg_lock);
+
+	can_update_pol = chip->avb_tc_policy.port_mask == 0 ||
+			 (hweight16(chip->avb_tc_policy.port_mask) == 1 &&
+			  ffs(chip->avb_tc_policy.port_mask) == port + 1);
+
+	if (!can_update_pol &&
+	    num_tc > 0 &&
+	    memcmp(&tcpol.map, &chip->avb_tc_policy.map, sizeof(tcpol.map)) != 0) {
+		NL_SET_ERR_MSG(extack, "only a single AVB queue policy is supported per switch");
+		err = -EOPNOTSUPP;
+		goto err_unlock;
+	}
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
+	if (can_update_pol) {
+		err = num_tc > 0 ? mv88e6xxx_avb_tc_enable(chip, &tcpol)
+				 : mv88e6xxx_avb_tc_disable(chip);
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack, "failed to %s AVB queue policy: %d",
+					   num_tc > 0 ? "enable" : "disable", err);
+			goto err_reset_tc;
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
+err_reset_tc:
+	netdev_reset_tc(user);
+err_unlock:
+	mutex_unlock(&chip->reg_lock);
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
@@ -7243,6 +7482,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_mdb_del		= mv88e6xxx_port_mdb_del,
 	.port_mirror_add	= mv88e6xxx_port_mirror_add,
 	.port_mirror_del	= mv88e6xxx_port_mirror_del,
+	.port_setup_tc		= mv88e6xxx_port_setup_tc,
 	.crosschip_bridge_join	= mv88e6xxx_crosschip_bridge_join,
 	.crosschip_bridge_leave	= mv88e6xxx_crosschip_bridge_leave,
 	.port_hwtstamp_set	= mv88e6xxx_port_hwtstamp_set,
@@ -7310,6 +7550,28 @@ static const void *pdata_device_get_match_data(struct device *dev)
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
@@ -7405,6 +7667,10 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
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
index 146723fbca658..b6f4331affdc6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -19,6 +19,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <net/dsa.h>
+#include <net/pkt_sched.h>
 
 #define EDSA_HLEN		8
 #define MV88E6XXX_N_FID		4096
@@ -216,6 +217,7 @@ struct mv88e6xxx_ptp_ops;
 struct mv88e6xxx_pcs_ops;
 struct mv88e6xxx_cc_coeffs;
 struct mv88e6xxx_tcam_ops;
+struct mv88e6xxx_tc_ops;
 
 struct mv88e6xxx_irq {
 	u16 masked;
@@ -250,6 +252,46 @@ struct mv88e6xxx_port_hwtstamp {
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
@@ -440,6 +482,9 @@ struct mv88e6xxx_chip {
 	int egress_dest_port;
 	int ingress_dest_port;
 
+	/* Global AVB queue policy resources */
+	struct mv88e6xxx_avb_tc_policy avb_tc_policy;
+
 	/* Per-port timestamping resources. */
 	struct mv88e6xxx_port_hwtstamp port_hwtstamp[DSA_MAX_PORTS];
 
@@ -721,6 +766,9 @@ struct mv88e6xxx_ops {
 
 	/* Ternary Content Addressable Memory operations */
 	const struct mv88e6xxx_tcam_ops *tcam_ops;
+
+	/* Traffic control / Qdisc operations */
+	const struct mv88e6xxx_tc_ops *tc_ops;
 };
 
 struct mv88e6xxx_irq_ops {
@@ -766,6 +814,28 @@ struct mv88e6xxx_avb_ops {
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
@@ -801,6 +871,12 @@ struct mv88e6xxx_tcam_ops {
 	int (*flush_tcam)(struct mv88e6xxx_chip *chip);
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
index 8204321502c1f..1a0f9c5de8132 100644
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
index ff5adf7c9bc3a..8645add6f7da0 100644
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
index ea1fab71968a0..3a842c4d18105 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1606,6 +1606,15 @@ int mv88e6390_port_tag_remap(struct mv88e6xxx_chip *chip, int port)
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
index 5b6cde9f7406f..3ebd2ebafbf0f 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -523,6 +523,8 @@ int mv88e6xxx_port_set_8021q_mode(struct mv88e6xxx_chip *chip, int port,
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


