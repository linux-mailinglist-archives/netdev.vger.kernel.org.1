Return-Path: <netdev+bounces-304373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qBmrBQhbR2qBWwAAu9opvQ
	(envelope-from <netdev+bounces-304373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD876FF318
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:47:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=PjoYfXDA;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304373-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304373-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE68D301A04E
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4BF38836A;
	Fri,  3 Jul 2026 06:46:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB338398D;
	Fri,  3 Jul 2026 06:46:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061185; cv=none; b=dxAUhogyS2092xI5EWDSEL2vjr8kGtSIxk5xfYvsW6X/zee2STjrefOQU/nVSyAM5ZmAa1YRQqnYpfivip9gVVnxt9w0IYd0mVPwBBqyeOe9L/IYJrpzZC7SKF9nrwc/K106V0B8yNxbJvqvFFiQlmdJgOypc1dU4oDfg+ontQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061185; c=relaxed/simple;
	bh=lVMLpC6PPID8dVPcq3+KoLvn5UTUJ1wVNfpw1i5dx34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzekrA4fJMr8Mv1PInZn5xLH9dbReUqJRLeXLdDqZegnhbhlZQuTC8MQ44/MBcIAeuwaSftluHB3uNF9oc/V1aGoBtMiryb6pP9+Zqkqk5Kep6CfXYb99TLk7/XIPbRf5S2QtcUfsnRW6ss0DR5mzv3K37iDCC/Gr1UF0rR86j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=PjoYfXDA; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 5221A60C0B;
	Fri,  3 Jul 2026 02:46:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783061182; bh=RwPGv6YavcGnRUpbTjjpJDd62VFAjmhuN5ATawZpa5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PjoYfXDAW3FdTsrmmM6ewrl4icDOlqkGKIWpXxOvdKBq/czLbte4jIazBbSzUU5bt
	 D0w1j0tefPQxQPeOZRjdr8/nlEeUPGknl6pyPIwtLUThiNaDH+NsAhtLxcWhfum8tm
	 g1l3mly9cJU2YMCw9SkWO1dcMn6KSqTtuMODUEwDEXP/PRUCW1IzitL+Oz72nL3PGH
	 cUbXV/Iwl76CJi5S9hoK5hl33qjVw+PzQmzyGVVLaMY0ZTLrbVbT7Gc76V4FZTP+6U
	 A/7hynrBwbGPyZC4agqXFqIvEMs4JqHaChbQGP5oiEHzzrdVd2+YOhFbnMnkEbkExh
	 osHwFpfG7SelQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:46:06 +1000
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: add support for DCB DSCP
 app
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6xxx-dscp-prio-map-v1-1-250e0ebcce83@padl.com>
References: <20260703-mv88e6xxx-dscp-prio-map-v1-0-250e0ebcce83@padl.com>
In-Reply-To: <20260703-mv88e6xxx-dscp-prio-map-v1-0-250e0ebcce83@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783061173; l=15473;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=lVMLpC6PPID8dVPcq3+KoLvn5UTUJ1wVNfpw1i5dx34=;
 b=cBZBQGdJ+USiVDKJi7x4+MxTzyMlk6RuYJX+2c91cD1BFdVET2g2zhDCluOCHDVzhBMSFou07
 oi50MvkcfPqBBLNn42imX5Ugxp2SoOXmuyjO928O3mtkznYgB3fYpGm
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304373-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD876FF318

Implement {get,add,del}_dscp_prio for Marvell switches that support it.
On switches that do not support setting the QPri independently of FPri,
FPri is set to the default for the DSCP value.

On 6352-class switches the DSCP-to-QPri mapping is a global table with no
per-entry "unmapped" state: every DSCP is always mapped, so the DCB app
table comes up fully populated and deleting an entry restores its
reset-default QPri rather than removing it.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |   6 +
 drivers/net/dsa/mv88e6xxx/chip.h    |  14 ++
 drivers/net/dsa/mv88e6xxx/dcb.c     | 294 ++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/dcb.h     |   6 +
 drivers/net/dsa/mv88e6xxx/global1.h |   8 +
 drivers/net/dsa/mv88e6xxx/port.h    |  10 ++
 6 files changed, 338 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index cefe6be2f0ce9..3bdf8c7b36612 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7434,6 +7434,9 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_get_pcp_prio	= mv88e6xxx_port_get_pcp_prio,
 	.port_add_pcp_prio	= mv88e6xxx_port_add_pcp_prio,
 	.port_del_pcp_prio	= mv88e6xxx_port_del_pcp_prio,
+	.port_get_dscp_prio	= mv88e6xxx_port_get_dscp_prio,
+	.port_add_dscp_prio	= mv88e6xxx_port_add_dscp_prio,
+	.port_del_dscp_prio	= mv88e6xxx_port_del_dscp_prio,
 	.port_setup_tc		= mv88e6xxx_port_setup_tc,
 	.cls_flower_add		= mv88e6xxx_cls_flower_add,
 	.cls_flower_del         = mv88e6xxx_cls_flower_del,
@@ -7471,6 +7474,9 @@ static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
 	ds->pcp_prio_mapping_is_global = dcb_ops &&
 					 dcb_ops->global_get_pcp_prio;
 
+	ds->dscp_prio_mapping_is_global = dcb_ops &&
+					  dcb_ops->global_get_dscp_prio;
+
 	/* Some chips support up to 32, but that requires enabling the
 	 * 5-bit port mode, which we do not support. 640k^W16 ought to
 	 * be enough for anyone.
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 8c4e8b4890907..d6265e925574f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -794,6 +794,20 @@ struct mv88e6xxx_dcb_ops {
 				 u8 pcp);
 	int (*port_set_pcp_prio)(struct mv88e6xxx_chip *chip, int port,
 				 u8 pcp, u8 prio);
+
+	/* Get/set the chip's global DSCP to queue priority (QPri) mapping */
+	int (*global_get_dscp_prio)(struct mv88e6xxx_chip *chip, u8 dscp);
+	int (*global_set_dscp_prio)(struct mv88e6xxx_chip *chip, u8 dscp,
+				    u8 prio);
+	int (*global_del_dscp_prio)(struct mv88e6xxx_chip *chip, u8 dscp);
+
+	/* Get/set a port's DSCP to queue priority (QPri) mapping */
+	int (*port_get_dscp_prio)(struct mv88e6xxx_chip *chip, int port,
+				  u8 dscp);
+	int (*port_set_dscp_prio)(struct mv88e6xxx_chip *chip, int port,
+				  u8 dscp, u8 prio);
+	int (*port_del_dscp_prio)(struct mv88e6xxx_chip *chip, int port,
+				  u8 dscp);
 };
 
 struct mv88e6xxx_ptp_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/dcb.c b/drivers/net/dsa/mv88e6xxx/dcb.c
index 0a3099cdf3882..c26f43b27f09e 100644
--- a/drivers/net/dsa/mv88e6xxx/dcb.c
+++ b/drivers/net/dsa/mv88e6xxx/dcb.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright (c) 2026 Luminex Network Intelligence
 
+#include <linux/bitfield.h>
+
+#include <net/dscp.h>
+
 #include "chip.h"
 #include "dcb.h"
 #include "global1.h"
@@ -134,19 +138,201 @@ static int mv88e6393x_port_set_pcp_prio(struct mv88e6xxx_chip *chip, int port,
 	return mv88e639x_port_set_pcp_prio(chip, port, pcp, prio, true);
 }
 
+/* The DCB priority maps the DSCP to an egress queue priority (QPri); the frame
+ * priority (FPri) is left untouched.  These chips always map every DSCP, so
+ * there is no per-entry "unmapped" state on the global (6352) table: deleting
+ * an entry restores its reset-default QPri rather than removing it.
+ */
+
+/* G1 offset 0x19 is the IP Mapping Table only on these families; elsewhere it is
+ * the Core Tag Type register, so report DSCP mapping as unsupported there.
+ */
+static bool mv88e6352_has_ip_pri_map(struct mv88e6xxx_chip *chip)
+{
+	switch (chip->info->family) {
+	case MV88E6XXX_FAMILY_6320:
+	case MV88E6XXX_FAMILY_6341:
+	case MV88E6XXX_FAMILY_6352:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int mv88e6352_get_dscp_prio(struct mv88e6xxx_chip *chip, u8 dscp)
+{
+	u16 val;
+	int err;
+
+	if (!mv88e6352_has_ip_pri_map(chip))
+		return -EOPNOTSUPP;
+
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	/* load the table pointer (Update clear), then read the entry back */
+	err = mv88e6xxx_g1_write(chip, MV88E6352_G1_IP_PRI_MAP,
+				 FIELD_PREP(MV88E6352_G1_IP_PRI_MAP_PTR_MASK,
+					    dscp));
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6352_G1_IP_PRI_MAP, &val);
+	if (err)
+		return err;
+
+	return FIELD_GET(MV88E6352_G1_IP_PRI_MAP_QPRI_MASK, val);
+}
+
+/* Update only the QPri of a DSCP entry, preserving the global UseIpFPri bit and
+ * the per-entry FPri so the frame priority handling is left untouched.
+ */
+static int mv88e6352_write_dscp_qpri(struct mv88e6xxx_chip *chip, u8 dscp,
+				     u8 prio)
+{
+	u16 val;
+	int err;
+
+	/* load the table pointer (Update clear), then read the entry back */
+	err = mv88e6xxx_g1_write(chip, MV88E6352_G1_IP_PRI_MAP,
+				 FIELD_PREP(MV88E6352_G1_IP_PRI_MAP_PTR_MASK,
+					    dscp));
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6352_G1_IP_PRI_MAP, &val);
+	if (err)
+		return err;
+
+	val &= ~(MV88E6352_G1_IP_PRI_MAP_PTR_MASK |
+		 MV88E6352_G1_IP_PRI_MAP_QPRI_MASK);
+	val |= MV88E6352_G1_IP_PRI_MAP_UPDATE |
+	       FIELD_PREP(MV88E6352_G1_IP_PRI_MAP_PTR_MASK, dscp) |
+	       FIELD_PREP(MV88E6352_G1_IP_PRI_MAP_QPRI_MASK, prio);
+
+	return mv88e6xxx_g1_write(chip, MV88E6352_G1_IP_PRI_MAP, val);
+}
+
+static int mv88e6352_set_dscp_prio(struct mv88e6xxx_chip *chip, u8 dscp,
+				   u8 prio)
+{
+	if (!mv88e6352_has_ip_pri_map(chip))
+		return -EOPNOTSUPP;
+
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	/* QPri range as for the PCP-to-priority mapping */
+	if (prio >= 4)
+		return -EINVAL;
+
+	return mv88e6352_write_dscp_qpri(chip, dscp, prio);
+}
+
+static int mv88e6352_del_dscp_prio(struct mv88e6xxx_chip *chip, u8 dscp)
+{
+	if (!mv88e6352_has_ip_pri_map(chip))
+		return -EOPNOTSUPP;
+
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	/* No per-entry disable exists, so restore the reset-default QPri, which
+	 * is the top two DSCP bits (DSCP >> 4: 0x00-0x0f->0, 0x10-0x1f->1,
+	 * 0x20-0x2f->2, 0x30-0x3f->3).
+	 */
+	return mv88e6352_write_dscp_qpri(chip, dscp, dscp >> 4);
+}
+
+static int mv88e6390_port_get_dscp_prio(struct mv88e6xxx_chip *chip, int port,
+					u8 dscp)
+{
+	u16 val;
+	int err;
+
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	/* load the table pointer (Update clear), then read the entry back */
+	err = mv88e6xxx_port_write(chip, port, MV88E6390_PORT_IP_PRI_MAP,
+				   FIELD_PREP(MV88E6390_PORT_IP_PRI_MAP_PTR_MASK,
+					      dscp));
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6390_PORT_IP_PRI_MAP, &val);
+	if (err)
+		return err;
+
+	if (val & MV88E6390_PORT_IP_PRI_MAP_DIS_IP_QPRI)
+		return -EOPNOTSUPP;
+
+	return FIELD_GET(MV88E6390_PORT_IP_PRI_MAP_QPRI_MASK, val);
+}
+
+static int mv88e6390_port_set_dscp_prio(struct mv88e6xxx_chip *chip, int port,
+					u8 dscp, u8 prio)
+{
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	/* QPri range as for the PCP-to-priority mapping */
+	if (prio >= 8)
+		return -EINVAL;
+
+	/* This write defines the whole entry: enable and set the QPri, disable
+	 * the FPri override so frame priority is left unchanged, and leave
+	 * IP_YELLOW clear.  The entry is owned solely by this API, so a blind
+	 * write is sufficient and no read-modify-write is needed.
+	 */
+	return mv88e6xxx_port_write(chip, port, MV88E6390_PORT_IP_PRI_MAP,
+				   MV88E6390_PORT_IP_PRI_MAP_UPDATE |
+				   MV88E6390_PORT_IP_PRI_MAP_DIS_IP_FPRI |
+				   FIELD_PREP(MV88E6390_PORT_IP_PRI_MAP_PTR_MASK,
+					      dscp) |
+				   FIELD_PREP(MV88E6390_PORT_IP_PRI_MAP_QPRI_MASK,
+					      prio));
+}
+
+static int mv88e6390_port_del_dscp_prio(struct mv88e6xxx_chip *chip, int port,
+					u8 dscp)
+{
+	if (dscp >= DSCP_MAX)
+		return -EINVAL;
+
+	/* Disable both the QPri and FPri overrides so the DSCP falls back to the
+	 * port default; get_dscp_prio then reports the entry as removed.
+	 */
+	return mv88e6xxx_port_write(chip, port, MV88E6390_PORT_IP_PRI_MAP,
+				   MV88E6390_PORT_IP_PRI_MAP_UPDATE |
+				   MV88E6390_PORT_IP_PRI_MAP_DIS_IP_QPRI |
+				   MV88E6390_PORT_IP_PRI_MAP_DIS_IP_FPRI |
+				   FIELD_PREP(MV88E6390_PORT_IP_PRI_MAP_PTR_MASK,
+					      dscp));
+}
+
 const struct mv88e6xxx_dcb_ops mv88e6352_dcb_ops = {
 	.global_get_pcp_prio = mv88e6352_get_pcp_prio,
 	.global_set_pcp_prio = mv88e6352_set_pcp_prio,
+	.global_get_dscp_prio = mv88e6352_get_dscp_prio,
+	.global_set_dscp_prio = mv88e6352_set_dscp_prio,
+	.global_del_dscp_prio = mv88e6352_del_dscp_prio,
 };
 
 const struct mv88e6xxx_dcb_ops mv88e6390_dcb_ops = {
 	.port_get_pcp_prio = mv88e6390_port_get_pcp_prio,
 	.port_set_pcp_prio = mv88e6390_port_set_pcp_prio,
+	.port_get_dscp_prio = mv88e6390_port_get_dscp_prio,
+	.port_set_dscp_prio = mv88e6390_port_set_dscp_prio,
+	.port_del_dscp_prio = mv88e6390_port_del_dscp_prio,
 };
 
 const struct mv88e6xxx_dcb_ops mv88e6393x_dcb_ops = {
 	.port_get_pcp_prio = mv88e6393x_port_get_pcp_prio,
 	.port_set_pcp_prio = mv88e6393x_port_set_pcp_prio,
+	.port_get_dscp_prio = mv88e6390_port_get_dscp_prio,
+	.port_set_dscp_prio = mv88e6390_port_set_dscp_prio,
+	.port_del_dscp_prio = mv88e6390_port_del_dscp_prio,
 };
 
 static int mv88e6xxx_dcb_get_pcp_prio(struct mv88e6xxx_chip *chip, int port,
@@ -227,3 +413,111 @@ int mv88e6xxx_port_del_pcp_prio(struct dsa_switch *ds, int port, u8 pcp,
 	mv88e6xxx_reg_unlock(chip);
 	return err;
 }
+
+static int mv88e6xxx_dcb_get_dscp_prio(struct mv88e6xxx_chip *chip, int port,
+				       u8 dscp)
+{
+	const struct mv88e6xxx_dcb_ops *dcb_ops = chip->info->ops->dcb_ops;
+
+	if (!dcb_ops)
+		return -EOPNOTSUPP;
+
+	if (dcb_ops->port_get_dscp_prio)
+		return dcb_ops->port_get_dscp_prio(chip, port, dscp);
+
+	if (dcb_ops->global_get_dscp_prio)
+		return dcb_ops->global_get_dscp_prio(chip, dscp);
+
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_dcb_set_dscp_prio(struct mv88e6xxx_chip *chip, int port,
+				       u8 dscp, u8 prio)
+{
+	const struct mv88e6xxx_dcb_ops *dcb_ops = chip->info->ops->dcb_ops;
+
+	if (!dcb_ops)
+		return -EOPNOTSUPP;
+
+	if (dcb_ops->port_set_dscp_prio)
+		return dcb_ops->port_set_dscp_prio(chip, port, dscp, prio);
+
+	if (dcb_ops->global_set_dscp_prio)
+		return dcb_ops->global_set_dscp_prio(chip, dscp, prio);
+
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_dcb_del_dscp_prio(struct mv88e6xxx_chip *chip, int port,
+				       u8 dscp)
+{
+	const struct mv88e6xxx_dcb_ops *dcb_ops = chip->info->ops->dcb_ops;
+
+	if (!dcb_ops)
+		return -EOPNOTSUPP;
+
+	if (dcb_ops->port_del_dscp_prio)
+		return dcb_ops->port_del_dscp_prio(chip, port, dscp);
+
+	if (dcb_ops->global_del_dscp_prio)
+		return dcb_ops->global_del_dscp_prio(chip, dscp);
+
+	return -EOPNOTSUPP;
+}
+
+int mv88e6xxx_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_dcb_get_dscp_prio(chip, port, dscp);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+int mv88e6xxx_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (prio >= IEEE_8021Q_MAX_PRIORITIES)
+		return -EINVAL;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_dcb_set_dscp_prio(chip, port, dscp, prio);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+int mv88e6xxx_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+
+	err = mv88e6xxx_dcb_get_dscp_prio(chip, port, dscp);
+	if (err == -EOPNOTSUPP) {
+		/* No explicit mapping for this DSCP, so nothing to remove */
+		err = 0;
+		goto unlock;
+	}
+	if (err < 0)
+		goto unlock;
+	if (err != prio) {
+		/* Mapping was changed in the meantime; leave it alone */
+		err = 0;
+		goto unlock;
+	}
+
+	err = mv88e6xxx_dcb_del_dscp_prio(chip, port, dscp);
+
+unlock:
+	mv88e6xxx_reg_unlock(chip);
+	return err;
+}
diff --git a/drivers/net/dsa/mv88e6xxx/dcb.h b/drivers/net/dsa/mv88e6xxx/dcb.h
index 7a2124ec23ba9..e1cf92bbd8729 100644
--- a/drivers/net/dsa/mv88e6xxx/dcb.h
+++ b/drivers/net/dsa/mv88e6xxx/dcb.h
@@ -18,4 +18,10 @@ int mv88e6xxx_port_add_pcp_prio(struct dsa_switch *ds, int port, u8 pcp,
 int mv88e6xxx_port_del_pcp_prio(struct dsa_switch *ds, int port, u8 pcp,
 				u8 prio);
 
+int mv88e6xxx_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp);
+int mv88e6xxx_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio);
+int mv88e6xxx_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
+				 u8 prio);
+
 #endif /* _MV88E6XXX_DCB_H_ */
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 3dbb7a1b8fe11..fdc9795fa5c6d 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -195,6 +195,14 @@
 /* Offset 0x19: Core Tag Type */
 #define MV88E6185_G1_CORE_TAG_TYPE	0x19
 
+/* Offset 0x19: IP Mapping Table (6172/6176/6240/6320/6341/6352) */
+#define MV88E6352_G1_IP_PRI_MAP			0x19
+#define MV88E6352_G1_IP_PRI_MAP_UPDATE		0x8000
+#define MV88E6352_G1_IP_PRI_MAP_USE_IP_FPRI	0x4000
+#define MV88E6352_G1_IP_PRI_MAP_PTR_MASK	0x3f00
+#define MV88E6352_G1_IP_PRI_MAP_FPRI_MASK	0x0070
+#define MV88E6352_G1_IP_PRI_MAP_QPRI_MASK	0x0003
+
 /* Offset 0x1A: Monitor Control */
 #define MV88E6185_G1_MONITOR_CTL			0x1a
 #define MV88E6185_G1_MONITOR_CTL_INGRESS_DEST_MASK	0xf000
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 56143fa534c16..230a99f404606 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -448,6 +448,16 @@
 /* Control for Special LED (Index 0x7 of LED Control on Port 2) */
 #define MV88E6XXX_PORT_LED_CONTROL_0x07_P2_PTP_ACT		0 /* bits 6:0 PTP Activity */
 
+/* Offset 0x17: IP Priority Mapping Table */
+#define MV88E6390_PORT_IP_PRI_MAP			0x17
+#define MV88E6390_PORT_IP_PRI_MAP_UPDATE		BIT(15)
+#define MV88E6390_PORT_IP_PRI_MAP_PTR_MASK		GENMASK(14, 9)
+#define MV88E6390_PORT_IP_PRI_MAP_IP_YELLOW		BIT(8)
+#define MV88E6390_PORT_IP_PRI_MAP_DIS_IP_QPRI		BIT(7)
+#define MV88E6390_PORT_IP_PRI_MAP_QPRI_MASK		GENMASK(6, 4)
+#define MV88E6390_PORT_IP_PRI_MAP_DIS_IP_FPRI		BIT(3)
+#define MV88E6390_PORT_IP_PRI_MAP_FPRI_MASK		GENMASK(2, 0)
+
 /* Offset 0x18: IEEE Priority Mapping Table */
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE			0x18
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_UPDATE		0x8000

-- 
2.43.0


