Return-Path: <netdev+bounces-304371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gJK1H31aR2oBWwAAu9opvQ
	(envelope-from <netdev+bounces-304371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31B6FF2AE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=kG2n7bl+;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304371-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304371-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 636483009091
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2D385D6E;
	Fri,  3 Jul 2026 06:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3923393F;
	Fri,  3 Jul 2026 06:45:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061113; cv=none; b=ey7Txg6i+wLGqL0RZB8DryAJU9PG/gkMq38+kHOGBR4IP8Ww5E0Mbuhy3mqAKbYklix4Nu8fF1spq2tpflaa+maTsvccx5eGAzpn3uyFdcrr2u4P2U/gaE0kPAlE6Z/FE8SAOI1O2D3DJZP1jMykDmZNuMayHN6iVWJ1A/glC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061113; c=relaxed/simple;
	bh=lwrptk61eAtrVkqQO8Dilra0XURHlkaSjTium5iKlQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GNY7W9yPZZPSZMyNWowTimq9tqMQtYASaxC4xxfm29o//rq8OmccbTm/6Bl8MhM70Mr2Iycit3OsXH3kE16+F020R5JEdRTGfGJIh0LbuPZy7j3CyGDO7Qo2nlRKLtmKpcWaKba+DFqtHbTwIcF/eCuw0iydxxKvmDZJ1sWnINg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=kG2n7bl+; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 289CF60C1E;
	Fri,  3 Jul 2026 02:45:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783061109; bh=OaeVtkVlVtO1zKd5ayjjIrU+PxbPdAvQFY6WtnU9EbI=;
	h=From:Date:Subject:To:Cc:From;
	b=kG2n7bl+pswtS48fRmuRa3vOsFQgeckWL90lY2mAGD1s1nZVb9C5ch4HtIFVcRDN4
	 DkhScAv/uE5i+JdeHrbJ6upsvpZWrYJAnYwsMikg6Yzy57vue5UJVA7QajHOIZtmx9
	 TwIubIkAmWI2O0d4pJK7clS7WFG0J3NvVah61pzZucXa0xpXd5m2U7Jw1x6OUAGh97
	 BejUWki2ivmEvKf/e606g7X8rSbv4xYEJLuU6P6rDUUTjOzMvA8zDffu3RtyMoNB5M
	 1rYgkJWl3IIUGB4vN1/B65GVFYCVdzZNzMY9UxGEAMmvAt79B3BLGerPvA84JLbRJ9
	 TpkroXUSobj2A==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:44:54 +1000
Subject: [PATCH RFC net-next v3] net: dsa: mv88e6xxx: MQPRIO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6xxx-8021qat-mqprio-v3-1-5b94f5e9fed5@padl.com>
X-B4-Tracking: v=1; b=H4sIAGlaR2oC/4WQy04DIRSGX6VhLRPuzMzKxMQHcGtcAD3Top1Lg
 ZIxTd9ditV0YeLykPMdvv8/owjBQ0T95owCZB/9PJWBP2yQ25tpB9hvy4wYYYoowvCY2xbUuq6
 4JYweTcLjcQl+xkINTii11QQoKvgSYPBrPf2KXp6frm8TJDzBmtDb90I82Xdw6frBDQlwPBWJd
 ON+HfpNNRCc4J8jdyrORswoo1R1zhjV9lmj+wQ3WhH+F724BdcIUktWeN0xZftcU1gTAbt5HH0
 qrRhrgRPGqRB0oIO1nBMJXSuFk8pwoSQxg+Q13t7HNIfP2mxmNc3/JWaGCdbMAhWSMdDucTHbQ
 1ME6s3iVFuZM4SGat21gkpOmp1PzeH0Afu79cvl8gWc+HZK3gEAAA==
X-Change-ID: 20260602-mv88e6xxx-8021qat-mqprio-46fc466d70e1
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, Simon Gapp <simon.gapp@gapp-audio.com>, 
 Max Holtmann <mh@rme-audio.de>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783061103; l=31374;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=lwrptk61eAtrVkqQO8Dilra0XURHlkaSjTium5iKlQA=;
 b=bFiTbcvktFlR3CTnGNJx9YfOl4rkecmDUGSQ0AqsNPeeTfAu6tmmKfKnnuhy3jgRp53Xsegp6
 f7gk9tYEmfQAkT23cO+LU+9KSy/s78K1fuQM3PJ3vZVYVktj3wfTI0k
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304371-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:cedric.jehasse@gmail.com,m:max@huntershome.org,m:kieran@sienda.com,m:simon.gapp@gapp-audio.com,m:mh@rme-audio.de,m:christoph.mellauner@joyned.at,m:lukeh@padl.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,huntershome.org,sienda.com,gapp-audio.com,rme-audio.de,joyned.at,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E31B6FF2AE

Add MQPRIO traffic class offload for the Marvell 6352 and 6390 families
of switches.

Three traffic classes are supported: legacy (TC0), low (TC1) and high
(TC2), corresponding to non-AVB, AVB Class B and AVB Class A traffic.
A single Ethernet frame priority may be mapped to each AVB class.

As the policy is per-switch, HW offload can only be enabled across
multiple ports if the policy matches. This is similar to configuration
of DCB ingress priority mappings on switches that only support global
configuration. Attempts to configure a different policy on an additional
port will return -EEXIST.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
This patch series introduces support for using MQPRIO to configure
egress queues, using the AVB frame priority to queue mapping which
is supported by some Marvell switches.

It does configure the isochronous pointer reservation and enable
the standard AVB mode on all ports. The former potentially belongs
in a local patch: discussion is welcome. For this reason, and also
Jakub's comments about technical debt [1], I have demoted this to
a RFC.

This is the only way to configure priority to queue mappings on
egress on Marvell switches (their configuration of _ingress_ mappings
is more flexible and, on the 6390, is supported per-port). Egress
queues can be set in TCAM entries, but my understanding is that
tc-flower offloading can only specify priority, not queue, mappings.

We are using it in conjunction with the since rejected support for
802.1Q Dynamic Reservation Entries to implement hardware offloaded
AVB (802.1BA) bridging. The Dynamic Reservation Entry extension to
the FDB could potentially be implemented using tc-flower in a manner
acceptable to upstream; I do not have the resources to investigate
this at this time.

[1] https://lore.kernel.org/all/20260615095112.1dca0977@kernel.org/
---
Changes in v3:
- dropped support for Dynamic Resevation Entries in the MDB. Although
  these are defined in the 802.1Q specification, it seemed unlikely that
  the Linux bridge would accept this change. I maintain the old patches
  at https://github.com/PADL/linux/tree/b4/mv88e6xxx-8021qat-mqprio.
- Link to v2: https://patch.msgid.link/20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com

Changes in v2:
- dropped CBS implementation (this is provided separately by Cedric
  Jehasse's patch series, and is required for its definition of
  num_tx_queues and qav_info)
- added MQPRIO channel support
- admission control is configured using a bridge port flag rather than
  a device tree entry
- software bridge support for admission control
- Link to v1: https://lore.kernel.org/all/cover.1779841530.git.lukeh@padl.com/

To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/dsa/mv88e6xxx/Makefile      |   3 +-
 drivers/net/dsa/mv88e6xxx/avb.c         | 189 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/avb.h         |  67 ++++++++++
 drivers/net/dsa/mv88e6xxx/chip.c        | 208 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  45 +++++++
 drivers/net/dsa/mv88e6xxx/global1.h     |   1 +
 drivers/net/dsa/mv88e6xxx/global2.h     |   2 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c | 121 +++++++++++++++++++
 8 files changed, 635 insertions(+), 1 deletion(-)

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
index 0000000000000..f02aa8a4ad458
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.c
@@ -0,0 +1,189 @@
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
+static int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
+					   int port, u16 avb_mode)
+{
+	u16 data;
+	int err;
+
+	err = mv88e6xxx_port_avb_read(chip, port, MV88E6XXX_PORT_AVB_CFG,
+				      &data, 1);
+	if (err)
+		return err;
+
+	data &= ~(MV88E6XXX_PORT_AVB_CFG_AVB_MODE |
+		  MV88E6XXX_PORT_AVB_CFG_AVB_OVERRIDE |
+		  MV88E6XXX_PORT_AVB_CFG_AVB_TUNNEL);
+
+	data |= avb_mode & MV88E6XXX_PORT_AVB_CFG_AVB_MODE;
+	data |= MV88E6XXX_PORT_AVB_CFG_AVB_FILTER_BAD_AVB;
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
+u16 mv88e6xxx_avb_pri_map_to_reg(const struct tc_mqprio_qopt *qopt)
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
+	int err, port;
+
+	if (!qav)
+		return -EOPNOTSUPP;
+
+	/* Reserve 64 (1 << 6) isochronous pointers per port for the AVB queues. */
+	err = mv88e6xxx_qav_set_iso_ptr(chip, mv88e6xxx_num_ports(chip) << 6);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB,
+				  mv88e6xxx_avb_pri_map_to_reg(&mqprio->qopt));
+	if (err)
+		goto err_iso_ptr;
+
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port,
+						      MV88E6XXX_PORT_AVB_CFG_AVB_MODE_STANDARD);
+		if (err)
+			goto err_port_mode;
+	}
+
+	return 0;
+
+err_port_mode:
+	while (--port >= 0) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		mv88e6xxx_avb_set_port_avb_mode(chip, port,
+						MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY);
+	}
+	mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB, qav->avb_pri_map);
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
+	/* Return every user port to legacy. */
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port,
+						      MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY);
+		if (err)
+			return err;
+	}
+
+	err = mv88e6xxx_avb_write(chip, MV88E6XXX_AVB_CFG_AVB, qav->avb_pri_map);
+	if (err)
+		return err;
+
+	return mv88e6xxx_qav_set_iso_ptr(chip, 0);
+}
+
diff --git a/drivers/net/dsa/mv88e6xxx/avb.h b/drivers/net/dsa/mv88e6xxx/avb.h
new file mode 100644
index 0000000000000..f231824d4eac7
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/avb.h
@@ -0,0 +1,67 @@
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
+#define MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(x)	FIELD_GET(MV88E6XXX_AVB_CFG_AVB_HI_FPRI_MASK, x)
+
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK	GENMASK(6, 4)
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_SET(p)	FIELD_PREP(MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK, p)
+#define MV88E6XXX_AVB_CFG_AVB_LO_FPRI_GET(x)	FIELD_GET(MV88E6XXX_AVB_CFG_AVB_LO_FPRI_MASK, x)
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
+u16 mv88e6xxx_avb_pri_map_to_reg(const struct tc_mqprio_qopt *qopt);
+int mv88e6xxx_avb_enable(struct mv88e6xxx_chip *chip,
+			 struct tc_mqprio_qopt_offload *mqprio);
+int mv88e6xxx_avb_disable(struct mv88e6xxx_chip *chip);
+
+#endif /* _MV88E6XXX_AVB_H */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index dc8f9a04ab5e5..2d619fb809c1e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -34,6 +34,7 @@
 #include <net/dsa.h>
 #include <net/pkt_sched.h>
 
+#include "avb.h"
 #include "chip.h"
 #include "devlink.h"
 #include "global1.h"
@@ -5708,6 +5709,10 @@ static const struct mv88e6xxx_qav_info mv88e6352_qav_info = {
 	.rate_mask = GENMASK(14, 0),
 	.hilimit_mask = GENMASK(14, 0),
 	.queue_mask = GENMASK(3, 0),
+	/* legacy (all queues), lo (queue 1/2), hi (queue 2/3) */
+	.avb_queue_mask = { GENMASK(3, 0), GENMASK(2, 1), GENMASK(3, 2) },
+	/* HI FPri 5/QPri 3, LO FPri 4/QPri 2 */
+	.avb_pri_map = 0x5342,
 };
 
 static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
@@ -5715,6 +5720,10 @@ static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
 	.rate_mask = GENMASK(15, 0),
 	.hilimit_mask = GENMASK(13, 0),
 	.queue_mask = GENMASK(3, 0),
+	/* legacy (all queues), lo (queue 1/2), hi (queue 2/3) */
+	.avb_queue_mask = { GENMASK(3, 0), GENMASK(2, 1), GENMASK(3, 2) },
+	/* HI FPri 5/QPri 3, LO FPri 4/QPri 2 */
+	.avb_pri_map = 0x5342,
 };
 
 static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
@@ -5722,6 +5731,10 @@ static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
 	.rate_mask = GENMASK(15, 0),
 	.hilimit_mask = GENMASK(13, 0),
 	.queue_mask = GENMASK(7, 0),
+	/* AVB traffic allowed on all queues */
+	.avb_queue_mask = { GENMASK(7, 0), GENMASK(7, 0), GENMASK(7, 0) },
+	/* HI FPri 3/QPri 7, LO FPri 2/QPri 6  */
+	.avb_pri_map = 0x3726,
 };
 
 static const struct mv88e6xxx_info mv88e6xxx_table[] = {
@@ -7244,6 +7257,197 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
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
+static int mv88e6xxx_validate_tc_mqprio(const struct mv88e6xxx_chip *chip,
+					const struct tc_mqprio_qopt_offload *mqprio)
+{
+	const struct mv88e6xxx_qav_info *qav = chip->info->qav;
+	const struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	u8 avb_tc_set = 0;
+	int tc, fpri;
+
+	if (qopt->num_tc == 0)
+		return 0;
+
+	if (qopt->hw != TC_MQPRIO_HW_OFFLOAD_TCS) {
+		NL_SET_ERR_MSG_MOD(extack, "only full TC hardware offload is supported");
+		return -EOPNOTSUPP;
+	} else if (!qav || !chip->info->ops->avb_ops) {
+		NL_SET_ERR_MSG_MOD(extack, "chip does not support MQPRIO DCB offload");
+		return -EOPNOTSUPP;
+	} else if (mqprio->mode != TC_MQPRIO_MODE_DCB) {
+		NL_SET_ERR_MSG_MOD(extack, "only DCB mode is supported");
+		return -EOPNOTSUPP;
+	} else if (mqprio->shaper != TC_MQPRIO_SHAPER_DCB) {
+		NL_SET_ERR_MSG_MOD(extack, "only DCB shaper is supported for AVB mode");
+		return -EOPNOTSUPP;
+	} else if (mqprio->preemptible_tcs) {
+		NL_SET_ERR_MSG_MOD(extack, "frame preemption is not supported");
+		return -EOPNOTSUPP;
+	} else if (qopt->num_tc > MV88E6XXX_AVB_TC_MAX + 1) {
+		NL_SET_ERR_MSG_MOD(extack, "too many traffic classes for AVB mode");
+		return -EOPNOTSUPP;
+	}
+
+	/* Validate switch-side constraints on AVB traffic classes. TC0 queue
+	 * mapping can only be configured on ingress using the DCB PCP app.
+	 */
+	for (tc = MV88E6XXX_AVB_TC_LO; tc < qopt->num_tc; tc++) {
+		if (qopt->count[tc] != 1) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "only one queue supported for TC%d", tc);
+			return -EOPNOTSUPP;
+		} else if ((qav->avb_queue_mask[tc] & BIT(qopt->offset[tc])) == 0) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "queue %d not valid for TC%d",
+					       qopt->offset[tc], tc);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/* Each AVB traffic class must map exactly one frame priority */
+	for (fpri = 0; fpri < IEEE_8021Q_MAX_PRIORITIES; fpri++) {
+		tc = qopt->prio_tc_map[fpri];
+
+		if (tc == MV88E6XXX_AVB_TC_LEGACY)
+			continue;
+
+		if (avb_tc_set & BIT(tc)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "only one frame priority can be mapped to TC%d", tc);
+			return -EOPNOTSUPP;
+		}
+
+		avb_tc_set |= BIT(tc);
+	}
+
+	if (avb_tc_set != GENMASK(MV88E6XXX_AVB_TC_HI, MV88E6XXX_AVB_TC_LO)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "both TC1 and TC2 must have 802.1p priorities assigned");
+		return -EOPNOTSUPP;
+	}
+
+	return qopt->num_tc;
+}
+
+static void mv88e6xxx_mqprio_update_policy(struct mv88e6xxx_tc_policy *pol,
+					   int port, int num_tc)
+{
+	if (num_tc) {
+		pol->tc_port_mask |= BIT(port);
+		pol->enabled = true;
+	} else {
+		pol->tc_port_mask &= ~BIT(port);
+		if (!pol->tc_port_mask)
+			pol->enabled = false;
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
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_tc_policy *pol;
+	struct net_device *user;
+	bool can_update_pol;
+	u16 avb_pri_map;
+	int num_tc, err;
+
+	if (!dsa_is_user_port(ds, port))
+		return -EINVAL;
+
+	num_tc = mv88e6xxx_validate_tc_mqprio(chip, mqprio);
+	if (num_tc < 0)
+		return num_tc;
+
+	avb_pri_map = num_tc ? mv88e6xxx_avb_pri_map_to_reg(&mqprio->qopt) : 0;
+
+	user = dsa_to_port(ds, port)->user;
+
+	mv88e6xxx_reg_lock(chip);
+
+	pol = &chip->tc_policy;
+
+	if (!num_tc && !(pol->tc_port_mask & BIT(port))) {
+		netdev_reset_tc(user);
+		mv88e6xxx_reg_unlock(chip);
+		return 0;
+	}
+
+	can_update_pol = !pol->tc_port_mask || pol->tc_port_mask == BIT(port);
+	if (!can_update_pol && num_tc && avb_pri_map != pol->avb_pri_map) {
+		NL_SET_ERR_MSG_MOD(extack, "only a single priority mapping supported per switch");
+		err = -EEXIST;
+		goto err_unlock;
+	}
+
+	err = mv88e6xxx_mqprio_netdev_set_tc(user, &mqprio->qopt, num_tc);
+	if (err)
+		goto err_reset_tc;
+
+	if (can_update_pol) {
+		err = num_tc ? mv88e6xxx_avb_enable(chip, mqprio)
+			     : mv88e6xxx_avb_disable(chip);
+		if (err) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "failed to %s AVB",
+					       num_tc ? "enable" : "disable");
+			goto err_reset_tc;
+		}
+	}
+
+	mv88e6xxx_mqprio_update_policy(pol, port, num_tc);
+
+	if (num_tc && can_update_pol)
+		pol->avb_pri_map = avb_pri_map;
+	else if (!pol->tc_port_mask)
+		pol->avb_pri_map = 0;
+
+	mv88e6xxx_reg_unlock(chip);
+
+	return 0;
+
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
@@ -7335,6 +7539,10 @@ static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
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
index d42d839e636bc..5e7c1c6bfbb95 100644
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
@@ -252,6 +254,30 @@ struct mv88e6xxx_port_hwtstamp {
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
+struct mv88e6xxx_tc_policy {
+	/* AVB MQPRIO offload active on the switch */
+	bool enabled;
+
+	/* Ports with MQPRIO TC installed */
+	u16 tc_port_mask;
+
+	/* Switch-wide AVB FPri/QPri register value */
+	u16 avb_pri_map;
+};
+
 enum mv88e6xxx_policy_mapping {
 	MV88E6XXX_POLICY_MAPPING_DA,
 	MV88E6XXX_POLICY_MAPPING_SA,
@@ -463,6 +489,9 @@ struct mv88e6xxx_chip {
 	/* TCAM entries */
 	struct mv88e6xxx_tcam tcam;
 
+	/* Global MQPRIO traffic class configuration */
+	struct mv88e6xxx_tc_policy tc_policy;
+
 	/* Global2 scratch register config data3 */
 	u8 g2_scratch_config3;
 };
@@ -777,6 +806,20 @@ struct mv88e6xxx_avb_ops {
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
@@ -817,6 +860,8 @@ struct mv88e6xxx_qav_info {
 	u16 rate_mask; /* QPri Rate valid bits mask */
 	u16 hilimit_mask; /* QPri HiLimit bits mask*/
 	u8 queue_mask; /* supported queues bitmask */
+	u8 avb_queue_mask[MV88E6XXX_AVB_TC_MAX + 1]; /* AVB supported queues bitmask */
+	u16 avb_pri_map; /* default AVB FPri to QPri map */
 };
 
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe11..199a826d426f0 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -111,6 +111,7 @@
 
 /* Offset 0x0A: ATU Control Register */
 #define MV88E6XXX_G1_ATU_CTL		0x0a
+#define MV88E6XXX_G1_ATU_CTL_MAC_AVB	0x8000
 #define MV88E6XXX_G1_ATU_CTL_LEARN2ALL	0x0008
 #define MV88E6161_G1_ATU_CTL_HASH_MASK	0x0003
 
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index df52ff3adc88c..ae361cca51274 100644
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

---
base-commit: 3abbe30231441f1fbb3305e9854c56a34650af53
change-id: 20260602-mv88e6xxx-8021qat-mqprio-46fc466d70e1
prerequisite-change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68:v7
prerequisite-patch-id: 8ad59c43368d4639e0cabcc59a7f6e487560d3f7
prerequisite-patch-id: 22f1cda311b1826bd4151fc7d4cdf3d87ca519ed
prerequisite-change-id: 20260603-net-next-mv88e6xxx-pcp-prio-5752caa7926b:v1
prerequisite-patch-id: f324a0334ef91256d6f09562d978e9d6c32b7f3c
prerequisite-patch-id: 79c2b056ae68846b5e2950b9738cb83e73d2710e

Best regards,
--  
Luke Howard <lukeh@padl.com>


