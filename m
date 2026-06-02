Return-Path: <netdev+bounces-293942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GZlLC8oHmpZhgkAu9opvQ
	(envelope-from <netdev+bounces-293942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:47:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B980626B40
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C05A23020AA2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC223264FB;
	Tue,  2 Jun 2026 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="bhPVnhsx"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C71291864;
	Tue,  2 Jun 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361106; cv=none; b=hplsH26iFJw1YjQ9+nr0Vu5V7UJLOChyggcKdY2wDqTiz4GkjHg4hbYm7ZxxLg0KWc9VNipyHeJ9ytxHx87ZiPP0gzQICWVp0sqMcdPnepxS4dMVTRVcx6Cmmo7GbRXkyaeA+Wqfy/5M9cBUaSLMpUND2eMqzJYQyWYeZFLdmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361106; c=relaxed/simple;
	bh=EmXHVzJJK7B6rU+GjSuf0G26abMuaCFGcpItcbu6MpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgP0f13QUcAzQq8Jxp4YVWEGbn6B/6bBO3fBxb1PvvGeMNpFsTzxQGbltQtmkuNDczYiV9V9gjG7DQYow3I/r8HEBa+hxa4c2E8aqVmF8jcTXqxAmnnX2DB4k39Q3Rs2w0Zaq1WfJNX7Pg6vLvQIQ+j9+jucdlt025Jdcp/SAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=bhPVnhsx; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8v030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:32 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8v030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361077; bh=pNW1FA7rWsA7eeyI+OBHGA7RvFzKQWxBl2UY2t0KMEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bhPVnhsx+l/v1Oso/S33d45aMAM3t6JevCn4dQWT19IuZroJ1wEH7ttPBKq6iPZGL
	 MpGG3uaQ8hgcpbv3nvVpN0dzsR86Of5uSuqpgcOpdI9msACFbuRN6N22KvCXCwa2tx
	 qWWaq40D+aysIz9rA40LoG2/1uiXgkwPP9nqH48U1XRje6ymE7IEUdPqEa8Iyh520W
	 AV4hgyh1+pUPcLtcyweosUNCl1TZvRGnqi0MRHnrtvrsg6Zv81jt1ugeWc4RKe6BWW
	 o3eDVqqTwlfVtOrd1XTvrv7h2tAug6ASCtWs5+lp1m19oQlH0+//9aMGj1Ff5NxM36
	 yvAmct6giYyhg==
From: Luke Howard <lukeh@padl.com>
Date: Tue, 02 Jun 2026 10:43:50 +1000
Subject: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
In-Reply-To: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>,
        Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293942-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 6B980626B40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add MQPRIO traffic class offload for the Marvell 6352 and 6390 families
of switches, in two modes.

In DCB mode the switch is configured for AVB. Three traffic classes are
supported: legacy (TC0), low (TC1) and high (TC2), corresponding to
non-AVB, AVB Class B and AVB Class A traffic. A single Ethernet frame
priority may be mapped to each AVB class; the remaining "legacy"
(non-AVB) frame priorities are distributed amongst the other queues per
the MQPRIO TC policy.

In channel mode any frame priority may be mapped to any queue, without
AVB semantics. On the 6390 family the frame priority to queue priority
mapping is programmed per-port, so each port may have an independent
policy.

The AVB (DCB mode) policy is held in switch-global registers and so is
necessarily per-switch rather than per-port: HW offload can only be
enabled across multiple ports if the policy on each enabled port is the
same. This restriction does not apply to channel mode on devices with
per-port priority maps.

While in AVB mode, a port with the BR_FILTER_STREAM_RESERVED bridge flag
set is placed in enhanced AVB mode, which discards AVB-priority frames
whose destination is not a reserved stream.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/Makefile      |   3 +-
 drivers/net/dsa/mv88e6xxx/avb.c         | 221 +++++++++++++++++
 drivers/net/dsa/mv88e6xxx/avb.h         |  79 +++++++
 drivers/net/dsa/mv88e6xxx/chip.c        | 406 +++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h        |  68 +++++-
 drivers/net/dsa/mv88e6xxx/global1.c     |  28 ++-
 drivers/net/dsa/mv88e6xxx/global1.h     |   6 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  17 ++
 drivers/net/dsa/mv88e6xxx/global2.h     |   2 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c | 121 ++++++++++
 drivers/net/dsa/mv88e6xxx/port.c        |  18 ++
 drivers/net/dsa/mv88e6xxx/port.h        |   2 +
 12 files changed, 959 insertions(+), 12 deletions(-)

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
index 0000000000000..d992ae560454c
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Marvell 88E6xxx Switch AVB support
+ *
+ * Copyright (c) 2024-2026 PADL Software Pty Ltd
+ */
+
+#include "avb.h"
+#include "chip.h"
+#include "global1.h"
+#include "global2.h"
+#include "port.h"
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
+static int mv88e6xxx_avb_write(struct mv88e6xxx_chip *chip, int addr, u16 data)
+{
+	if (!chip->info->ops->avb_ops->avb_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->avb_ops->avb_write(chip, addr, data);
+}
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
+	return mv88e6xxx_qav_write(chip, MV88E6XXX_QAV_CFG, data);
+}
+
+int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
+				    int port, enum mv88e6xxx_avb_mode mode)
+{
+	u16 data;
+	int err;
+
+	err = mv88e6xxx_port_avb_read(chip, port, MV88E6XXX_PORT_AVB_CFG, &data, 1);
+	if (err)
+		return err;
+
+	data &= ~(MV88E6XXX_PORT_AVB_CFG_AVB_MODE |
+		  MV88E6XXX_PORT_AVB_CFG_AVB_FILTER_BAD_AVB |
+		  MV88E6XXX_PORT_AVB_CFG_AVB_DISCARD_BAD);
+
+	/* Enhanced mode additionally discards AVB-priority frames whose
+	 * destination is not a reserved-stream (AVB_NRL) ATU entry, reserving
+	 * the AVB traffic classes for reserved streams.
+	 */
+	switch (mode) {
+	case MV88E6XXX_AVB_MODE_DISABLED:
+		data |= MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY;
+		break;
+	case MV88E6XXX_AVB_MODE_STANDARD:
+		data |= MV88E6XXX_PORT_AVB_CFG_AVB_MODE_STANDARD;
+		break;
+	case MV88E6XXX_AVB_MODE_ENHANCED:
+		data |= MV88E6XXX_PORT_AVB_CFG_AVB_MODE_ENHANCED |
+			MV88E6XXX_PORT_AVB_CFG_AVB_FILTER_BAD_AVB |
+			MV88E6XXX_PORT_AVB_CFG_AVB_DISCARD_BAD;
+		break;
+	}
+
+	return mv88e6xxx_port_avb_write(chip, port, MV88E6XXX_PORT_AVB_CFG, data);
+}
+
+static u8 mv88e6xxx_mqprio_tc_fpri(const struct tc_mqprio_qopt *qopt, int tc)
+{
+	u8 fpri;
+
+	for (fpri = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++)
+		if (qopt->prio_tc_map[fpri] == tc)
+			return fpri;
+
+	return 0;
+}
+
+static u16 mv88e6xxx_avb_pri_map_to_reg(const struct tc_mqprio_qopt *qopt)
+{
+	u8 hi_fpri = mv88e6xxx_mqprio_tc_fpri(qopt, MV88E6XXX_AVB_TC_HI);
+	u8 lo_fpri = mv88e6xxx_mqprio_tc_fpri(qopt, MV88E6XXX_AVB_TC_LO);
+	u8 hi_qpri = qopt->offset[MV88E6XXX_AVB_TC_HI];
+	u8 lo_qpri = qopt->offset[MV88E6XXX_AVB_TC_LO];
+
+	return MV88E6XXX_AVB_CFG_AVB_HI_FPRI_SET(hi_fpri) |
+	       MV88E6XXX_AVB_CFG_AVB_HI_QPRI_SET(hi_qpri) |
+	       MV88E6XXX_AVB_CFG_AVB_LO_FPRI_SET(lo_fpri) |
+	       MV88E6XXX_AVB_CFG_AVB_LO_QPRI_SET(lo_qpri);
+}
+
+int mv88e6xxx_avb_enable(struct mv88e6xxx_chip *chip,
+			 struct tc_mqprio_qopt_offload *mqprio)
+{
+	const struct mv88e6xxx_qav_info *qav = chip->info->qav;
+	enum mv88e6xxx_avb_mode mode;
+	int err, port;
+
+	if (!qav)
+		return -EOPNOTSUPP;
+
+	err = mv88e6xxx_qav_set_iso_ptr(chip, mv88e6xxx_num_ports(chip) << 6);
+	if (err)
+		return err;
+
+	/* interpret AVB_NRL bits in the ATU as STREAM_RESERVED */
+	err = mv88e6xxx_g1_atu_set_mac_avb(chip, true);
+	if (err)
+		goto err_iso_ptr;
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB,
+				  mv88e6xxx_avb_pri_map_to_reg(&mqprio->qopt));
+	if (err)
+		goto err_mac_avb;
+
+	/* A port with BR_FILTER_STREAM_RESERVED set uses enhanced AVB mode to
+	 * reserve its AVB queues for reserved streams.
+	 */
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		mode = (chip->tc_policy.avb_enhanced_port_mask & BIT(port)) ?
+			MV88E6XXX_AVB_MODE_ENHANCED : MV88E6XXX_AVB_MODE_STANDARD;
+
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port, mode);
+		if (err)
+			goto err_port_mode;
+	}
+
+	return 0;
+
+err_port_mode:
+	while (port-- > 0) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		mv88e6xxx_avb_set_port_avb_mode(chip, port, MV88E6XXX_AVB_MODE_DISABLED);
+	}
+	mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB, qav->avb_pri_map);
+err_mac_avb:
+	mv88e6xxx_g1_atu_set_mac_avb(chip, false);
+err_iso_ptr:
+	mv88e6xxx_qav_set_iso_ptr(chip, 0);
+
+	return err;
+}
+
+int mv88e6xxx_avb_disable(struct mv88e6xxx_chip *chip)
+{
+	const struct mv88e6xxx_qav_info *qav = chip->info->qav;
+	int err, port;
+
+	if (!qav)
+		return -EOPNOTSUPP;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port,
+						      MV88E6XXX_AVB_MODE_DISABLED);
+		if (err)
+			return err;
+	}
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB, qav->avb_pri_map);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_atu_set_mac_avb(chip, false);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_qav_set_iso_ptr(chip, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
diff --git a/drivers/net/dsa/mv88e6xxx/avb.h b/drivers/net/dsa/mv88e6xxx/avb.h
new file mode 100644
index 0000000000000..0bd92724af4e2
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Marvell 88E6xxx Switch AVB support
+ *
+ * Copyright (c) 2024-2026 PADL Software Pty Ltd
+ */
+
+#ifndef _MV88E6XXX_AVB_H
+#define _MV88E6XXX_AVB_H
+
+#include "chip.h"
+
+/* Global AVB registers */
+
+/* Offset 0x00: AVB Global Config */
+
+#define MV88E6XXX_AVB_CFG_AVB			0x00
+
+#define MV88E6XXX_AVB_CFG_AVB_HI_FPRI_MASK	GENMASK(14, 12)
+#define MV88E6XXX_AVB_CFG_AVB_HI_FPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_HI_FPRI_MASK, p)
+
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK	GENMASK(6, 4)
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK, p)
+
+#define MV88E6XXX_AVB_CFG_AVB_HI_QPRI_MASK	GENMASK(10, 8)
+#define MV88E6XXX_AVB_CFG_AVB_HI_QPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_HI_QPRI_MASK, p)
+
+#define MV88E6XXX_AVB_CFG_AVB_LO_QPRI_MASK	GENMASK(2, 0)
+#define MV88E6XXX_AVB_CFG_AVB_LO_QPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_LO_QPRI_MASK, p)
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
+int mv88e6xxx_avb_enable(struct mv88e6xxx_chip *chip,
+			 struct tc_mqprio_qopt_offload *mqprio);
+int mv88e6xxx_avb_disable(struct mv88e6xxx_chip *chip);
+
+/**
+ * enum mv88e6xxx_avb_mode - Current AVB mode
+ * @MV88E6XXX_AVB_MODE_DISABLED: No AVB TCs (DCB Qdisc) configured
+ * @MV88E6XXX_AVB_MODE_STANDARD: AVB configured, BR_FILTER_STREAM_RESERVED unset
+ * @MV88E6XXX_AVB_MODE_ENHANCED: AVB configured, BR_FILTER_STREAM_RESERVED set
+ */
+enum mv88e6xxx_avb_mode {
+	MV88E6XXX_AVB_MODE_DISABLED = 0,
+	MV88E6XXX_AVB_MODE_STANDARD,
+	MV88E6XXX_AVB_MODE_ENHANCED,
+};
+
+int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip, int port,
+				    enum mv88e6xxx_avb_mode mode);
+
+#endif /* _MV88E6XXX_AVB_H */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 2596e05681b43..db79302c2b84d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -34,6 +34,7 @@
 #include <net/dsa.h>
 #include <net/pkt_sched.h>
 
+#include "avb.h"
 #include "chip.h"
 #include "devlink.h"
 #include "global1.h"
@@ -1615,7 +1616,7 @@ static int mv88e6xxx_pri_setup(struct mv88e6xxx_chip *chip)
 	int err;
 
 	if (chip->info->ops->ieee_pri_map) {
-		err = chip->info->ops->ieee_pri_map(chip);
+		err = chip->info->ops->ieee_pri_map(chip, NULL);
 		if (err)
 			return err;
 	}
@@ -5531,6 +5532,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.port_set_cmode = mv88e6390_port_set_cmode,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
 	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
+	.port_ieee_pri_map = mv88e6390_port_ieee_pri_map,
 	.stats_snapshot = mv88e6390_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
@@ -5596,6 +5598,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.port_set_cmode = mv88e6390x_port_set_cmode,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
 	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
+	.port_ieee_pri_map = mv88e6390_port_ieee_pri_map,
 	.stats_snapshot = mv88e6390_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6390_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6320_stats_get_sset_count,
@@ -5653,6 +5656,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
 	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
+	.port_ieee_pri_map = mv88e6390_port_ieee_pri_map,
 	.port_pause_limit = mv88e6390_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5700,6 +5704,10 @@ static const struct mv88e6xxx_qav_info mv88e6352_qav_info = {
 	.rate_mask = GENMASK(14, 0),
 	.hi_limit_mask = GENMASK(14, 0),
 	.queue_mask = GENMASK(3, 0),
+	/* legacy (all queues), lo (queue 1/2), hi (queue 2/3) */
+	.avb_queue_mask = { GENMASK(3, 0), GENMASK(2, 1), GENMASK(3, 2) },
+	/* HI FPri 5/QPri 3, LO FPri 4/QPri 2 */
+	.avb_pri_map = 0x5342,
 };
 
 static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
@@ -5707,6 +5715,10 @@ static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
 	.rate_mask = GENMASK(15, 0),
 	.hi_limit_mask = GENMASK(14, 0),
 	.queue_mask = GENMASK(3, 0),
+	/* legacy (all queues), lo (queue 1/2), hi (queue 2/3) */
+	.avb_queue_mask = { GENMASK(3, 0), GENMASK(2, 1), GENMASK(3, 2) },
+	/* HI FPri 5/QPri 3, LO FPri 4/QPri 2 */
+	.avb_pri_map = 0x5342,
 };
 
 static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
@@ -5714,6 +5726,10 @@ static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
 	.rate_mask = GENMASK(15, 0),
 	.hi_limit_mask = GENMASK(13, 0),
 	.queue_mask = GENMASK(7, 0),
+	/* AVB traffic allowed on all queues */
+	.avb_queue_mask = { GENMASK(7, 0), GENMASK(7, 0), GENMASK(7, 0) },
+	/* HI FPri 3/QPri 7, LO FPri 2/QPri 6  */
+	.avb_pri_map = 0x3726,
 };
 
 static const struct mv88e6xxx_info mv88e6xxx_table[] = {
@@ -6878,7 +6894,8 @@ static int mv88e6xxx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 	const struct mv88e6xxx_ops *ops;
 
 	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
-			   BR_BCAST_FLOOD | BR_PORT_LOCKED | BR_PORT_MAB))
+			   BR_BCAST_FLOOD | BR_PORT_LOCKED | BR_PORT_MAB |
+			   BR_FILTER_STREAM_RESERVED))
 		return -EINVAL;
 
 	ops = chip->info->ops;
@@ -6889,6 +6906,30 @@ static int mv88e6xxx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 	if ((flags.mask & BR_MCAST_FLOOD) && !ops->port_set_mcast_flood)
 		return -EINVAL;
 
+	if ((flags.mask & BR_FILTER_STREAM_RESERVED) && !chip->info->qav)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mv88e6xxx_port_set_avb_mode(struct mv88e6xxx_chip *chip, int port,
+				       bool enhanced)
+{
+	int err;
+
+	if (chip->tc_policy.tc_mode == MV88E6XXX_TC_MODE_AVB) {
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port,
+						      enhanced ? MV88E6XXX_AVB_MODE_ENHANCED :
+								 MV88E6XXX_AVB_MODE_STANDARD);
+		if (err)
+			return err;
+	}
+
+	if (enhanced)
+		chip->tc_policy.avb_enhanced_port_mask |= BIT(port);
+	else
+		chip->tc_policy.avb_enhanced_port_mask &= ~BIT(port);
+
 	return 0;
 }
 
@@ -6949,6 +6990,14 @@ static int mv88e6xxx_port_bridge_flags(struct dsa_switch *ds, int port,
 		if (err)
 			goto out;
 	}
+
+	if (flags.mask & BR_FILTER_STREAM_RESERVED) {
+		bool enhanced = !!(flags.val & BR_FILTER_STREAM_RESERVED);
+
+		err = mv88e6xxx_port_set_avb_mode(chip, port, enhanced);
+		if (err)
+			goto out;
+	}
 out:
 	mv88e6xxx_reg_unlock(chip);
 
@@ -7236,6 +7285,355 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
 	return err_sync ? : err_pvt;
 }
 
+static int mv88e6xxx_tc_query_caps(struct tc_query_caps_base *base)
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
+static int mv88e6xxx_validate_tc_mqprio_avb(const struct mv88e6xxx_chip *chip,
+					    const struct tc_mqprio_qopt_offload *mqprio,
+					    u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES])
+{
+	const struct mv88e6xxx_qav_info *qav = chip->info->qav;
+	const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	int tc0_qcount, tc0_base_qpri, tc0_fpri_per_qpri;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	u8 ieee_pri_map_set = 0;
+	int tc, fpri;
+
+	if (!qav || !chip->info->ops->avb_ops) {
+		NL_SET_ERR_MSG_MOD(extack, "chip does not support MQPRIO DCB offload");
+		return -EOPNOTSUPP;
+	} else if (mqprio->shaper != TC_MQPRIO_SHAPER_DCB) {
+		NL_SET_ERR_MSG_MOD(extack, "only DCB shaper is supported for AVB mode");
+		return -EOPNOTSUPP;
+	} else if (qopt->num_tc > MV88E6XXX_AVB_TC_MAX + 1) {
+		NL_SET_ERR_MSG_MOD(extack, "too many traffic classes for AVB mode");
+		return -EOPNOTSUPP;
+	}
+
+	/* Validate and map TCs to QPri */
+	for (tc = MV88E6XXX_AVB_TC_LEGACY; tc < qopt->num_tc; tc++) {
+		if (qopt->offset[tc] + qopt->count[tc] > chip->info->num_tx_queues) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "queue %d out of range",
+					       qopt->offset[tc] + qopt->count[tc] - 1);
+			return -EOPNOTSUPP;
+		}
+
+		if (tc == MV88E6XXX_AVB_TC_LEGACY) {
+			if (qopt->count[tc] == 0) {
+				NL_SET_ERR_MSG_MOD(extack, "TC0 must have at least one queue");
+				return -ERANGE;
+			}
+
+			tc0_base_qpri = qopt->offset[tc];
+			tc0_fpri_per_qpri = DIV_ROUND_UP(IEEE_8021Q_MAX_PRIORITIES - 2,
+							 qopt->count[tc]);
+		} else if (qopt->count[tc] != 1) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "only one queue supported for TC%d", tc);
+			return -EOPNOTSUPP;
+		} else if ((qav->avb_queue_mask[tc] & BIT(qopt->offset[tc])) == 0) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "queue %d not valid for TC%d",
+					       qopt->offset[tc], tc);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/* Validate and map FPri to QPri: AVB FPris are mapped to a single QPri,
+	 * with the remaining legacy (TC0) FPris being distributed amongst the
+	 * remaining QPris.
+	 */
+	for (fpri = 0, tc0_qcount = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++) {
+		tc = qopt->prio_tc_map[fpri];
+
+		if (tc == MV88E6XXX_AVB_TC_LEGACY) {
+			ieee_pri_map[fpri] = tc0_base_qpri + (tc0_qcount++ / tc0_fpri_per_qpri);
+			continue;
+		}
+
+		if (ieee_pri_map_set & BIT(tc)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "only one frame priority can be mapped to TC%d", tc);
+			return -EOPNOTSUPP;
+		}
+
+		ieee_pri_map_set |= BIT(tc);
+		ieee_pri_map[fpri] = qopt->offset[tc];
+	}
+
+	if (ieee_pri_map_set != GENMASK(MV88E6XXX_AVB_TC_HI, MV88E6XXX_AVB_TC_LO)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "both TC1 and TC2 must have 802.1p priorities assigned");
+		return -EOPNOTSUPP;
+	}
+
+	return qopt->num_tc;
+}
+
+static int mv88e6xxx_validate_tc_mqprio_qpri(const struct mv88e6xxx_chip *chip,
+					     const struct tc_mqprio_qopt_offload *mqprio,
+					     u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES])
+{
+	const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	int tc, qpri, fpri;
+
+	if (mqprio->flags & (TC_MQPRIO_F_MIN_RATE | TC_MQPRIO_F_MAX_RATE)) {
+		NL_SET_ERR_MSG_MOD(extack, "per-queue rate limiting is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	for (tc = 0; tc < qopt->num_tc; tc++) {
+		if (qopt->offset[tc] + qopt->count[tc] > chip->info->num_tx_queues) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "queue %d out of range",
+					       qopt->offset[tc] + qopt->count[tc] - 1);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	for (fpri = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++) {
+		qpri = qopt->prio_tc_map[fpri];
+		ieee_pri_map[fpri] = qopt->offset[qpri];
+	}
+
+	return qopt->num_tc;
+}
+
+static inline enum mv88e6xxx_tc_mode
+mv88e6xxx_mqprio_get_tc_mode(const struct tc_mqprio_qopt_offload *mqprio)
+{
+	switch (mqprio->mode) {
+	case TC_MQPRIO_MODE_DCB:
+		return MV88E6XXX_TC_MODE_AVB;
+	case TC_MQPRIO_MODE_CHANNEL:
+		return MV88E6XXX_TC_MODE_QPRI;
+	default:
+		return 0;
+	}
+}
+
+static int mv88e6xxx_validate_tc_mqprio(const struct mv88e6xxx_chip *chip,
+					const struct tc_mqprio_qopt_offload *mqprio,
+					enum mv88e6xxx_tc_mode *tc_mode,
+					u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES])
+{
+	const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	int err;
+
+	if (qopt->num_tc == 0) {
+		*tc_mode = chip->tc_policy.tc_mode;
+		return 0;
+	}
+
+	if (qopt->hw != TC_MQPRIO_HW_OFFLOAD_TCS) {
+		NL_SET_ERR_MSG_MOD(extack, "only full TC hardware offload is supported");
+		return -EOPNOTSUPP;
+	} else if (mqprio->preemptible_tcs) {
+		NL_SET_ERR_MSG_MOD(extack, "frame preemption is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	*tc_mode = mv88e6xxx_mqprio_get_tc_mode(mqprio);
+
+	switch (*tc_mode) {
+	case MV88E6XXX_TC_MODE_AVB:
+		err = mv88e6xxx_validate_tc_mqprio_avb(chip, mqprio, ieee_pri_map);
+		break;
+	case MV88E6XXX_TC_MODE_QPRI:
+		err = mv88e6xxx_validate_tc_mqprio_qpri(chip, mqprio, ieee_pri_map);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int mv88e6xxx_set_port_ieee_pri_map(struct mv88e6xxx_chip *chip,
+					   int port, const u8 *ieee_pri_map)
+{
+	if (!chip->info->ops->port_ieee_pri_map)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->port_ieee_pri_map(chip, port, ieee_pri_map);
+}
+
+static int mv88e6xxx_set_ieee_pri_map(struct mv88e6xxx_chip *chip,
+				      const u8 *ieee_pri_map)
+{
+	int port, err;
+
+	if (chip->info->ops->ieee_pri_map)
+		return chip->info->ops->ieee_pri_map(chip, ieee_pri_map);
+
+	if (!chip->info->ops->port_ieee_pri_map)
+		return -EOPNOTSUPP;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = chip->info->ops->port_ieee_pri_map(chip, port, ieee_pri_map);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static inline bool mv88e6xxx_tc_mode_map_equal(struct mv88e6xxx_chip *chip,
+					       enum mv88e6xxx_tc_mode tc_mode,
+					       const u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES])
+{
+	if (memcmp(ieee_pri_map, chip->tc_policy.ieee_pri_map,
+		   IEEE_8021Q_MAX_PRIORITIES))
+		return false;
+
+	if (chip->tc_policy.tc_mode != tc_mode)
+		return false;
+
+	return true;
+}
+
+static void mv88e6xxx_mqprio_update_policy(struct mv88e6xxx_tc_policy *pol,
+					   int port, int num_tc,
+					   enum mv88e6xxx_tc_mode tc_mode)
+{
+	if (num_tc) {
+		pol->tc_port_mask |= BIT(port);
+		pol->tc_mode = tc_mode;
+	} else {
+		pol->tc_port_mask &= ~BIT(port);
+		if (!pol->tc_port_mask)
+			pol->tc_mode = MV88E6XXX_TC_MODE_NONE;
+	}
+}
+
+static int mv88e6xxx_mqprio_netdev_set_tc(struct net_device *user,
+					  const struct tc_mqprio_qopt *qopt,
+					  int num_tc)
+{
+	int err, tc;
+
+	err = netdev_set_num_tc(user, num_tc);
+	if (err)
+		return err;
+
+	for (tc = 0; tc < num_tc; tc++) {
+		err = netdev_set_tc_queue(user, tc, qopt->count[tc],
+					  qopt->offset[tc]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int mv88e6xxx_setup_tc_mqprio(struct dsa_switch *ds, int port,
+				     struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct netlink_ext_ack *extack = mqprio->extack;
+	u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES];
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_tc_policy *pol;
+	enum mv88e6xxx_tc_mode tc_mode;
+	struct net_device *user;
+	bool can_update_pol;
+	bool per_port_pol;
+	int num_tc, err;
+
+	if (!dsa_is_user_port(ds, port))
+		return -EINVAL;
+
+	num_tc = mv88e6xxx_validate_tc_mqprio(chip, mqprio, &tc_mode, ieee_pri_map);
+	if (num_tc < 0)
+		return num_tc;
+
+	user = dsa_to_port(ds, port)->user;
+
+	per_port_pol = (tc_mode == MV88E6XXX_TC_MODE_QPRI &&
+			chip->info->ops->port_ieee_pri_map);
+
+	mv88e6xxx_reg_lock(chip);
+
+	pol = &chip->tc_policy;
+
+	if (num_tc && pol->tc_mode && pol->tc_mode != tc_mode) {
+		NL_SET_ERR_MSG_MOD(extack, "all switch ports must use the same MQPRIO mode");
+		err = -EOPNOTSUPP;
+		goto err_unlock;
+	}
+
+	can_update_pol = per_port_pol ||
+			 !pol->tc_port_mask || pol->tc_port_mask == BIT(port);
+	if (!can_update_pol && num_tc &&
+	    !mv88e6xxx_tc_mode_map_equal(chip, tc_mode, ieee_pri_map)) {
+		NL_SET_ERR_MSG_MOD(extack, "only a single priority mapping supported per switch");
+		err = -EOPNOTSUPP;
+		goto err_unlock;
+	}
+
+	err = mv88e6xxx_mqprio_netdev_set_tc(user, &mqprio->qopt, num_tc);
+	if (err)
+		goto err_reset_tc;
+
+	if (can_update_pol) {
+		const u8 *map = num_tc ? ieee_pri_map : NULL;
+
+		if (per_port_pol)
+			err = mv88e6xxx_set_port_ieee_pri_map(chip, port, map);
+		else
+			err = mv88e6xxx_set_ieee_pri_map(chip, map);
+		if (err) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "p%d: failed to %s priority mapping",
+					       port, num_tc ? "enable" : "disable");
+			goto err_reset_tc;
+		}
+
+		if (tc_mode == MV88E6XXX_TC_MODE_AVB) {
+			err = num_tc ? mv88e6xxx_avb_enable(chip, mqprio)
+				     : mv88e6xxx_avb_disable(chip);
+			if (err) {
+				NL_SET_ERR_MSG_FMT_MOD(extack, "failed to %s AVB",
+						       num_tc ? "enable" : "disable");
+				goto err_reset_pri_map;
+			}
+		}
+	}
+
+	mv88e6xxx_mqprio_update_policy(pol, port, num_tc, tc_mode);
+
+	if (num_tc && can_update_pol && !per_port_pol)
+		memcpy(pol->ieee_pri_map, ieee_pri_map, sizeof(ieee_pri_map));
+	else if (!pol->tc_port_mask)
+		memset(pol->ieee_pri_map, 0, sizeof(ieee_pri_map));
+
+	mv88e6xxx_reg_unlock(chip);
+
+	return 0;
+
+err_reset_pri_map:
+	mv88e6xxx_set_ieee_pri_map(chip, NULL);
+err_reset_tc:
+	netdev_reset_tc(user);
+err_unlock:
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
 static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
 				  struct tc_cbs_qopt_offload *cbs)
 {
@@ -7324,6 +7722,10 @@ static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
 				   enum tc_setup_type type, void *type_data)
 {
 	switch (type) {
+	case TC_QUERY_CAPS:
+		return mv88e6xxx_tc_query_caps(type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return mv88e6xxx_setup_tc_mqprio(ds, port, type_data);
 	case TC_SETUP_QDISC_CBS:
 		return mv88e6xxx_setup_tc_cbs(ds, port, type_data);
 	default:
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index afcf88fd02a03..11f895ad99f3f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -8,6 +8,7 @@
 #ifndef _MV88E6XXX_CHIP_H
 #define _MV88E6XXX_CHIP_H
 
+#include <linux/dcbnl.h> /* for IEEE_8021Q_MAX_PRIORITIES */
 #include <linux/idr.h>
 #include <linux/if_vlan.h>
 #include <linux/irq.h>
@@ -19,6 +20,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <net/dsa.h>
+#include <net/pkt_sched.h>
 
 #define EDSA_HLEN		8
 #define MV88E6XXX_N_FID		4096
@@ -252,6 +254,45 @@ struct mv88e6xxx_port_hwtstamp {
 	struct kernel_hwtstamp_config tstamp_config;
 };
 
+/**
+ * enum mv88e6xxx_avb_tc - Traffic class values for AVB mode
+ * @MV88E6XXX_AVB_TC_LEGACY: Non-AVB traffic
+ * @MV88E6XXX_AVB_TC_LO:     Low priority AVB (Class B)
+ * @MV88E6XXX_AVB_TC_HI:     High priority AVB (Class A)
+ */
+enum mv88e6xxx_avb_tc {
+	MV88E6XXX_AVB_TC_LEGACY = 0,
+	MV88E6XXX_AVB_TC_LO = 1,
+	MV88E6XXX_AVB_TC_HI = 2,
+	MV88E6XXX_AVB_TC_MAX = MV88E6XXX_AVB_TC_HI,
+};
+
+/**
+ * enum mv88e6xxx_tc_mode - Current MQPRIO mode
+ * @MV88E6XXX_TC_MODE_NONE: No MQPRIO Qdisc configured
+ * @MV88E6XXX_TC_MODE_AVB:  DCB Qdisc configured, TCs are AVB classes
+ * @MV88E6XXX_TC_MODE_QPRI: Channel Qdisc configured, TCs are QPris
+ */
+enum mv88e6xxx_tc_mode {
+	MV88E6XXX_TC_MODE_NONE = 0,
+	MV88E6XXX_TC_MODE_AVB,
+	MV88E6XXX_TC_MODE_QPRI,
+};
+
+struct mv88e6xxx_tc_policy {
+	/* Current MQPRIO mode */
+	enum mv88e6xxx_tc_mode tc_mode;
+
+	/* Ports with MQPRIO TC installed */
+	u16 tc_port_mask;
+
+	/* Ports in enhanced AVB mode (BR_FILTER_STREAM_RESERVED set) */
+	u16 avb_enhanced_port_mask;
+
+	/* FPri/QPri mapping */
+	u8 ieee_pri_map[IEEE_8021Q_MAX_PRIORITIES];
+};
+
 enum mv88e6xxx_policy_mapping {
 	MV88E6XXX_POLICY_MAPPING_DA,
 	MV88E6XXX_POLICY_MAPPING_SA,
@@ -463,6 +504,9 @@ struct mv88e6xxx_chip {
 	/* TCAM entries */
 	struct mv88e6xxx_tcam tcam;
 
+	/* Global MQPRIO traffic class configuration */
+	struct mv88e6xxx_tc_policy tc_policy;
+
 	/* Global2 scratch register config data3 */
 	u8 g2_scratch_config3;
 };
@@ -512,7 +556,10 @@ struct mv88e6xxx_ops {
 	 */
 	int (*setup_errata)(struct mv88e6xxx_chip *chip);
 
-	int (*ieee_pri_map)(struct mv88e6xxx_chip *chip);
+	/* Setup IEEE FPri to QPri mapping. ieee_pri_map is NULL to reset,
+	 * or an array of IEEE_8021Q_MAX_PRIORITIES frame priorities.
+	 */
+	int (*ieee_pri_map)(struct mv88e6xxx_chip *chip, const u8 *ieee_pri_map);
 	int (*ip_pri_map)(struct mv88e6xxx_chip *chip);
 
 	/* Ingress Rate Limit unit (IRL) operations */
@@ -629,6 +676,9 @@ struct mv88e6xxx_ops {
 			      phy_interface_t mode);
 	int (*port_get_cmode)(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
 
+	int (*port_ieee_pri_map)(struct mv88e6xxx_chip *chip, int port,
+				 const u8 *ieee_pri_map);
+
 	/* LED control */
 	int (*port_setup_leds)(struct mv88e6xxx_chip *chip, int port);
 
@@ -777,6 +827,20 @@ struct mv88e6xxx_avb_ops {
 	/* Access port-scoped 802.1Qav registers */
 	int (*port_qav_write)(struct mv88e6xxx_chip *chip, int port, int addr,
 			      u16 data);
+
+	/* Access global Class Shaping and Pacing registers */
+	int (*qav_read)(struct mv88e6xxx_chip *chip, int addr, u16 *data,
+			int len);
+	int (*qav_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
+
+	/* Access port-scoped Audio Video Bridging registers */
+	int (*port_avb_read)(struct mv88e6xxx_chip *chip, int port, int addr,
+			     u16 *data, int len);
+	int (*port_avb_write)(struct mv88e6xxx_chip *chip, int port, int addr,
+			      u16 data);
+
+	/* Access global Audio Video Bridging registers */
+	int (*avb_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
 };
 
 struct mv88e6xxx_ptp_ops {
@@ -817,6 +881,8 @@ struct mv88e6xxx_qav_info {
 	u16 rate_mask; /* QPri Rate valid bits mask */
 	u16 hi_limit_mask; /* Qpri Hi Limit bits mask*/
 	u8 queue_mask; /* supported queues bitmask */
+	u8 avb_queue_mask[MV88E6XXX_AVB_TC_MAX + 1]; /* AVB supported queues bitmask */
+	u16 avb_pri_map; /* default AVB FPri to QPri map */
 };
 
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 9820cd5967574..e9a3db0a7c2c6 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -356,16 +356,32 @@ int mv88e6085_g1_ip_pri_map(struct mv88e6xxx_chip *chip)
 
 /* Offset 0x18: IEEE-PRI Register */
 
-int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip)
+static int mv88e6xxx_g1_set_ieee_pri_map(struct mv88e6xxx_chip *chip,
+					 const u8 *map)
 {
-	/* Reset the IEEE Tag priorities to defaults */
-	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, 0xfa41);
+	u16 val = 0;
+	u8 fpri;
+
+	for (fpri = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++)
+		val |= (map[fpri] & 0x3) << (2 * fpri);
+
+	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, val);
 }
 
-int mv88e6250_g1_ieee_pri_map(struct mv88e6xxx_chip *chip)
+static const u8 mv88e6085_default_ieee_pri_map[] = { 1, 0, 0, 1, 2, 2, 3, 3 };
+
+int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip, const u8 *map)
 {
-	/* Reset the IEEE Tag priorities to defaults */
-	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, 0xfa50);
+	return mv88e6xxx_g1_set_ieee_pri_map(chip,
+					     map ? map : mv88e6085_default_ieee_pri_map);
+}
+
+static const u8 mv88e6250_default_ieee_pri_map[] = { 0, 0, 1, 1, 2, 2, 3, 3 };
+
+int mv88e6250_g1_ieee_pri_map(struct mv88e6xxx_chip *chip, const u8 *map)
+{
+	return mv88e6xxx_g1_set_ieee_pri_map(chip,
+					     map ? map : mv88e6250_default_ieee_pri_map);
 }
 
 /* Offset 0x1a: Monitor Control */
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe11..9456ee6f65165 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -111,6 +111,7 @@
 
 /* Offset 0x0A: ATU Control Register */
 #define MV88E6XXX_G1_ATU_CTL		0x0a
+#define MV88E6XXX_G1_ATU_CTL_MAC_AVB	0x8000
 #define MV88E6XXX_G1_ATU_CTL_LEARN2ALL	0x0008
 #define MV88E6161_G1_ATU_CTL_HASH_MASK	0x0003
 
@@ -310,8 +311,8 @@ int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
 int mv88e6085_g1_ip_pri_map(struct mv88e6xxx_chip *chip);
 
-int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip);
-int mv88e6250_g1_ieee_pri_map(struct mv88e6xxx_chip *chip);
+int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip, const u8 *map);
+int mv88e6250_g1_ieee_pri_map(struct mv88e6xxx_chip *chip, const u8 *map);
 
 int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port);
 
@@ -322,6 +323,7 @@ int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index);
 
 int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all);
+int mv88e6xxx_g1_atu_set_mac_avb(struct mv88e6xxx_chip *chip, bool mac_avb);
 int mv88e6xxx_g1_atu_set_age_time(struct mv88e6xxx_chip *chip,
 				  unsigned int msecs);
 int mv88e6xxx_g1_atu_getnext(struct mv88e6xxx_chip *chip, u16 fid,
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index c47f068f56b32..429a1ee44e47d 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -41,6 +41,23 @@ int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all)
 	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_CTL, val);
 }
 
+int mv88e6xxx_g1_atu_set_mac_avb(struct mv88e6xxx_chip *chip, bool mac_avb)
+{
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_ATU_CTL, &val);
+	if (err)
+		return err;
+
+	if (mac_avb)
+		val |= MV88E6XXX_G1_ATU_CTL_MAC_AVB;
+	else
+		val &= ~MV88E6XXX_G1_ATU_CTL_MAC_AVB;
+
+	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_CTL, val);
+}
+
 int mv88e6xxx_g1_atu_set_age_time(struct mv88e6xxx_chip *chip,
 				  unsigned int msecs)
 {
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index c2b9baf0a9371..bc7bc167a3c51 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -176,9 +176,11 @@
 #define MV88E6352_G2_AVB_CMD_PORT_TAIGLOBAL	0xe
 #define MV88E6165_G2_AVB_CMD_PORT_PTPGLOBAL	0xf
 #define MV88E6352_G2_AVB_CMD_PORT_PTPGLOBAL	0xf
+#define MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL	0xf
 #define MV88E6390_G2_AVB_CMD_PORT_MASK		0x1f00
 #define MV88E6390_G2_AVB_CMD_PORT_TAIGLOBAL	0x1e
 #define MV88E6390_G2_AVB_CMD_PORT_PTPGLOBAL	0x1f
+#define MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL	0x1f
 #define MV88E6352_G2_AVB_CMD_BLOCK_PTP		0
 #define MV88E6352_G2_AVB_CMD_BLOCK_AVB		1
 #define MV88E6352_G2_AVB_CMD_BLOCK_QAV		2
diff --git a/drivers/net/dsa/mv88e6xxx/global2_avb.c b/drivers/net/dsa/mv88e6xxx/global2_avb.c
index 6b54e275d21ab..fe1607bc78734 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_avb.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_avb.c
@@ -119,6 +119,27 @@ static int mv88e6352_g2_avb_port_qav_write(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_avb_write(chip, writeop, data);
 }
 
+static int mv88e6352_g2_avb_port_avb_read(struct mv88e6xxx_chip *chip,
+					  int port, int addr, u16 *data,
+					  int len)
+{
+	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
+				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
+		     (port << 8) | (MV88E6352_G2_AVB_CMD_BLOCK_AVB << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6352_g2_avb_port_avb_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6352_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 static int mv88e6352_g2_avb_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 				     u16 *data, int len)
 {
@@ -151,6 +172,38 @@ static int mv88e6352_g2_avb_tai_write(struct mv88e6xxx_chip *chip, int addr,
 					addr, data);
 }
 
+static int mv88e6352_g2_avb_qav_read(struct mv88e6xxx_chip *chip, int addr,
+				     u16 *data, int len)
+{
+	u16 readop = (len == 1 ? MV88E6352_G2_AVB_CMD_OP_READ :
+				 MV88E6352_G2_AVB_CMD_OP_READ_INCR) |
+		     (MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		     (MV88E6352_G2_AVB_CMD_BLOCK_QAV << 5) |
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
+		      (MV88E6352_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6352_g2_avb_avb_write(struct mv88e6xxx_chip *chip, int addr,
+				      u16 data)
+{
+	u16 writeop = MV88E6352_G2_AVB_CMD_OP_WRITE |
+		      (MV88E6352_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		      (MV88E6352_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 const struct mv88e6xxx_avb_ops mv88e6352_avb_ops = {
 	.port_ptp_read		= mv88e6352_g2_avb_port_ptp_read,
 	.port_ptp_write		= mv88e6352_g2_avb_port_ptp_write,
@@ -159,6 +212,11 @@ const struct mv88e6xxx_avb_ops mv88e6352_avb_ops = {
 	.tai_read		= mv88e6352_g2_avb_tai_read,
 	.tai_write		= mv88e6352_g2_avb_tai_write,
 	.port_qav_write		= mv88e6352_g2_avb_port_qav_write,
+	.qav_read		= mv88e6352_g2_avb_qav_read,
+	.qav_write		= mv88e6352_g2_avb_qav_write,
+	.port_avb_read		= mv88e6352_g2_avb_port_avb_read,
+	.port_avb_write		= mv88e6352_g2_avb_port_avb_write,
+	.avb_write		= mv88e6352_g2_avb_avb_write,
 };
 
 static int mv88e6165_g2_avb_tai_read(struct mv88e6xxx_chip *chip, int addr,
@@ -185,6 +243,11 @@ const struct mv88e6xxx_avb_ops mv88e6165_avb_ops = {
 	.tai_read		= mv88e6165_g2_avb_tai_read,
 	.tai_write		= mv88e6165_g2_avb_tai_write,
 	.port_qav_write		= mv88e6352_g2_avb_port_qav_write,
+	.qav_read		= mv88e6352_g2_avb_qav_read,
+	.qav_write		= mv88e6352_g2_avb_qav_write,
+	.port_avb_read		= mv88e6352_g2_avb_port_avb_read,
+	.port_avb_write		= mv88e6352_g2_avb_port_avb_write,
+	.avb_write		= mv88e6352_g2_avb_avb_write,
 };
 
 static int mv88e6390_g2_avb_port_ptp_read(struct mv88e6xxx_chip *chip,
@@ -217,6 +280,27 @@ static int mv88e6390_g2_avb_port_qav_write(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_avb_write(chip, writeop, data);
 }
 
+static int mv88e6390_g2_avb_port_avb_read(struct mv88e6xxx_chip *chip,
+					  int port, int addr, u16 *data,
+					  int len)
+{
+	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
+				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
+		     (port << 8) | (MV88E6352_G2_AVB_CMD_BLOCK_AVB << 5) |
+		     addr;
+
+	return mv88e6xxx_g2_avb_read(chip, readop, data, len);
+}
+
+static int mv88e6390_g2_avb_port_avb_write(struct mv88e6xxx_chip *chip,
+					   int port, int addr, u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE | (port << 8) |
+		      (MV88E6352_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 static int mv88e6390_g2_avb_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 				     u16 *data, int len)
 {
@@ -249,6 +333,38 @@ static int mv88e6390_g2_avb_tai_write(struct mv88e6xxx_chip *chip, int addr,
 					addr, data);
 }
 
+static int mv88e6390_g2_avb_qav_read(struct mv88e6xxx_chip *chip, int addr,
+				     u16 *data, int len)
+{
+	u16 readop = (len == 1 ? MV88E6390_G2_AVB_CMD_OP_READ :
+				 MV88E6390_G2_AVB_CMD_OP_READ_INCR) |
+		     (MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		     (MV88E6352_G2_AVB_CMD_BLOCK_QAV << 5) |
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
+		      (MV88E6352_G2_AVB_CMD_BLOCK_QAV << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
+static int mv88e6390_g2_avb_avb_write(struct mv88e6xxx_chip *chip, int addr,
+				      u16 data)
+{
+	u16 writeop = MV88E6390_G2_AVB_CMD_OP_WRITE |
+		      (MV88E6390_G2_AVB_CMD_PORT_AVBGLOBAL << 8) |
+		      (MV88E6352_G2_AVB_CMD_BLOCK_AVB << 5) | addr;
+
+	return mv88e6xxx_g2_avb_write(chip, writeop, data);
+}
+
 const struct mv88e6xxx_avb_ops mv88e6390_avb_ops = {
 	.port_ptp_read		= mv88e6390_g2_avb_port_ptp_read,
 	.port_ptp_write		= mv88e6390_g2_avb_port_ptp_write,
@@ -257,4 +373,9 @@ const struct mv88e6xxx_avb_ops mv88e6390_avb_ops = {
 	.tai_read		= mv88e6390_g2_avb_tai_read,
 	.tai_write		= mv88e6390_g2_avb_tai_write,
 	.port_qav_write		= mv88e6390_g2_avb_port_qav_write,
+	.qav_read		= mv88e6390_g2_avb_qav_read,
+	.qav_write		= mv88e6390_g2_avb_qav_write,
+	.port_avb_read		= mv88e6390_g2_avb_port_avb_read,
+	.port_avb_write		= mv88e6390_g2_avb_port_avb_write,
+	.avb_write		= mv88e6390_g2_avb_avb_write,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 758b8d41f4853..e2defc817fed3 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1651,6 +1651,24 @@ int mv88e6390_port_tag_remap(struct mv88e6xxx_chip *chip, int port)
 	return 0;
 }
 
+int mv88e6390_port_ieee_pri_map(struct mv88e6xxx_chip *chip, int port, const u8 *map)
+{
+	u8 fpri, qpri;
+	int err;
+
+	for (fpri = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++) {
+		qpri = map ? (map[fpri] & 0x7) : fpri;
+
+		err = mv88e6xxx_port_ieeepmt_write(chip, port,
+						   MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_INGRESS_PCP,
+						   fpri, (fpri | qpri << 4));
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* Offset 0x0E: Policy Control Register */
 
 static int
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index a380f356eb83d..5d46fbea16f05 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -535,6 +535,8 @@ int mv88e6xxx_port_set_8021q_mode(struct mv88e6xxx_chip *chip, int port,
 				  u16 mode);
 int mv88e6095_port_tag_remap(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_port_tag_remap(struct mv88e6xxx_chip *chip, int port);
+int mv88e6390_port_ieee_pri_map(struct mv88e6xxx_chip *chip, int port,
+				const u8 *map);
 int mv88e6xxx_port_set_egress_mode(struct mv88e6xxx_chip *chip, int port,
 				   enum mv88e6xxx_egress_mode mode);
 int mv88e6085_port_set_frame_mode(struct mv88e6xxx_chip *chip, int port,

-- 
2.43.0


