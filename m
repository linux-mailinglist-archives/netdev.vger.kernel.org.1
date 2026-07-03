Return-Path: <netdev+bounces-304374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HAvwEhNbR2qMWwAAu9opvQ
	(envelope-from <netdev+bounces-304374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:47:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5A6FF32F
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=YXV1D1iC;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304374-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304374-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B84F30522C8
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9A3859F0;
	Fri,  3 Jul 2026 06:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD27385D9F;
	Fri,  3 Jul 2026 06:46:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061190; cv=none; b=L1cbBSucVDwEjY1w5UQsvmarlne3cfWs4dFMKdlc1etsR3q3QbUndxle415opcNkM1gS0IbCm2ZyM2Czx/4GMr/KTPjtXHG4dXUh4tt4FsGAVPnHc2X0m/m9qwCf8zzxOUAOWmbWfznwP1+S1dXjXBS1mC+OUVahX1IMjyLnTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061190; c=relaxed/simple;
	bh=fbRdwSoptsuNMbImCLs3tATkb1HB6bGl/5P9cNkwnss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N327zoTLqxJIgAp96six42i4OPQAdsjLzfa3H5ghttRFb3MbLcrQj4L7ra0MWCKr5WHIRiov5rAYv8OW+WuA0DnddpPRhyXAGHe9tJf+tkji9RqFU0SLBTC7NWcYPRx5aDu1VSv0wZt3Oyxjvj845TOqHEz21Vvcl2HtMOudbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=YXV1D1iC; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id B602C60964;
	Fri,  3 Jul 2026 02:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783061186; bh=qwSRSUovcf4Rb1HGP/MHjOYxxhnIfbDFW6aBHFum6rY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YXV1D1iCQxepNwFARcv0FBEpHq5uzOTC5FgiXVtdWn6X548kxqpGgnEnqnjsi7/vl
	 A+IpUbVO/CMOVqfOVeYDx4MtzRNdU2oa5P3smiUVtRoAh9xG2ruid/DJLQHDfmAO05
	 7YDFClCSsl9KDWWiC0WnKT2/zIl2UkPA1k3wqk5hVQZaoha06uypkyZV7FGHuiE5SF
	 eYNZQyv6cukTHBxtxAUwJMy3Jz5/t8GSml1/H10KD73m3uT70u8MPRlvdcUqwXSEot
	 FanpLme8A6xioUlQQ2Kvu4lBEu/CAMEvbiIo4Uw9TRCARFzxiRFodUD8CPc2DqLmeX
	 pVj/oX6x/hkXQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:46:07 +1000
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for DCB
 apptrust app
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6xxx-dscp-prio-map-v1-2-250e0ebcce83@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783061173; l=7338;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=fbRdwSoptsuNMbImCLs3tATkb1HB6bGl/5P9cNkwnss=;
 b=BP17bJpHC0R+nKuzMMtZIoyyV4fqwpFtK9wm51d5n4Dipuripgm/tqRVl2q6jzGjN1/Zb6eNU
 FdPHzjocK6oDoHnGgWXSurUEYb0ePk66/WmnUnA8hrptp8uRdXjJdAj
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304374-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AB5A6FF32F

Implement port_{get,set}_apptrust for Marvell switches that support it.

This maps to the per-port USE_TAG / USE_IP / TAG_IF_BOTH bits in Port
Control 0, which the driver already initialises for every port (trust
both, IP taking precedence), so apptrust is available across the shared
mv88e6352_dcb_ops families, not only the 6352/6390/6393x.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |   2 +
 drivers/net/dsa/mv88e6xxx/chip.h |   6 +++
 drivers/net/dsa/mv88e6xxx/dcb.c  | 112 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/dcb.h  |   5 ++
 4 files changed, 125 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3bdf8c7b36612..6b85b2d0a982f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7437,6 +7437,8 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_get_dscp_prio	= mv88e6xxx_port_get_dscp_prio,
 	.port_add_dscp_prio	= mv88e6xxx_port_add_dscp_prio,
 	.port_del_dscp_prio	= mv88e6xxx_port_del_dscp_prio,
+	.port_get_apptrust	= mv88e6xxx_port_get_apptrust,
+	.port_set_apptrust	= mv88e6xxx_port_set_apptrust,
 	.port_setup_tc		= mv88e6xxx_port_setup_tc,
 	.cls_flower_add		= mv88e6xxx_cls_flower_add,
 	.cls_flower_del         = mv88e6xxx_cls_flower_del,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index d6265e925574f..e95be110dfa7b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -808,6 +808,12 @@ struct mv88e6xxx_dcb_ops {
 				  u8 dscp, u8 prio);
 	int (*port_del_dscp_prio)(struct mv88e6xxx_chip *chip, int port,
 				  u8 dscp);
+
+	/* Get/set a port's trusted application priority sources */
+	int (*port_get_apptrust)(struct mv88e6xxx_chip *chip, int port,
+				 u8 *sel, int *nsel);
+	int (*port_set_apptrust)(struct mv88e6xxx_chip *chip, int port,
+				 const u8 *sel, int nsel);
 };
 
 struct mv88e6xxx_ptp_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/dcb.c b/drivers/net/dsa/mv88e6xxx/dcb.c
index c26f43b27f09e..08a08acb9bfad 100644
--- a/drivers/net/dsa/mv88e6xxx/dcb.c
+++ b/drivers/net/dsa/mv88e6xxx/dcb.c
@@ -311,12 +311,86 @@ static int mv88e6390_port_del_dscp_prio(struct mv88e6xxx_chip *chip, int port,
 					      dscp));
 }
 
+/* Application trust (apptrust).
+ *
+ * InitialPri (the UseTag/UseIP bits) selects which ingress values a port
+ * trusts for priority assignment; TagIfBoth breaks the tie when a frame
+ * matches both.  DCB lists selectors in increasing precedence, so the
+ * last-named selector is the most trusted.
+ */
+
+static int mv88e6xxx_set_apptrust(struct mv88e6xxx_chip *chip, int port,
+				  const u8 *sel, int nsel)
+{
+	bool use_tag = false, use_ip = false, tag_wins = false;
+	u16 reg;
+	int i, err;
+
+	for (i = 0; i < nsel; i++) {
+		switch (sel[i]) {
+		case DCB_APP_SEL_PCP:
+			use_tag = true;
+			tag_wins = true;
+			break;
+		case IEEE_8021QAZ_APP_SEL_DSCP:
+			use_ip = true;
+			tag_wins = false;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg);
+	if (err)
+		return err;
+
+	reg &= ~(MV88E6185_PORT_CTL0_USE_TAG | MV88E6185_PORT_CTL0_USE_IP |
+		 MV88E6XXX_PORT_CTL0_TAG_IF_BOTH);
+	if (use_tag)
+		reg |= MV88E6185_PORT_CTL0_USE_TAG;
+	if (use_ip)
+		reg |= MV88E6185_PORT_CTL0_USE_IP;
+	if (use_tag && use_ip && tag_wins)
+		reg |= MV88E6XXX_PORT_CTL0_TAG_IF_BOTH;
+
+	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_CTL0, reg);
+}
+
+static int mv88e6xxx_get_apptrust(struct mv88e6xxx_chip *chip, int port,
+				  u8 *sel, int *nsel)
+{
+	bool tag_wins;
+	u16 reg;
+	int err, n = 0;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg);
+	if (err)
+		return err;
+
+	/* Report in increasing precedence: the winner of TagIfBoth comes last */
+	tag_wins = reg & MV88E6XXX_PORT_CTL0_TAG_IF_BOTH;
+
+	if (!tag_wins && (reg & MV88E6185_PORT_CTL0_USE_TAG))
+		sel[n++] = DCB_APP_SEL_PCP;
+	if (reg & MV88E6185_PORT_CTL0_USE_IP)
+		sel[n++] = IEEE_8021QAZ_APP_SEL_DSCP;
+	if (tag_wins && (reg & MV88E6185_PORT_CTL0_USE_TAG))
+		sel[n++] = DCB_APP_SEL_PCP;
+
+	*nsel = n;
+
+	return 0;
+}
+
 const struct mv88e6xxx_dcb_ops mv88e6352_dcb_ops = {
 	.global_get_pcp_prio = mv88e6352_get_pcp_prio,
 	.global_set_pcp_prio = mv88e6352_set_pcp_prio,
 	.global_get_dscp_prio = mv88e6352_get_dscp_prio,
 	.global_set_dscp_prio = mv88e6352_set_dscp_prio,
 	.global_del_dscp_prio = mv88e6352_del_dscp_prio,
+	.port_get_apptrust = mv88e6xxx_get_apptrust,
+	.port_set_apptrust = mv88e6xxx_set_apptrust,
 };
 
 const struct mv88e6xxx_dcb_ops mv88e6390_dcb_ops = {
@@ -325,6 +399,8 @@ const struct mv88e6xxx_dcb_ops mv88e6390_dcb_ops = {
 	.port_get_dscp_prio = mv88e6390_port_get_dscp_prio,
 	.port_set_dscp_prio = mv88e6390_port_set_dscp_prio,
 	.port_del_dscp_prio = mv88e6390_port_del_dscp_prio,
+	.port_get_apptrust = mv88e6xxx_get_apptrust,
+	.port_set_apptrust = mv88e6xxx_set_apptrust,
 };
 
 const struct mv88e6xxx_dcb_ops mv88e6393x_dcb_ops = {
@@ -333,6 +409,8 @@ const struct mv88e6xxx_dcb_ops mv88e6393x_dcb_ops = {
 	.port_get_dscp_prio = mv88e6390_port_get_dscp_prio,
 	.port_set_dscp_prio = mv88e6390_port_set_dscp_prio,
 	.port_del_dscp_prio = mv88e6390_port_del_dscp_prio,
+	.port_get_apptrust = mv88e6xxx_get_apptrust,
+	.port_set_apptrust = mv88e6xxx_set_apptrust,
 };
 
 static int mv88e6xxx_dcb_get_pcp_prio(struct mv88e6xxx_chip *chip, int port,
@@ -521,3 +599,37 @@ int mv88e6xxx_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
 	mv88e6xxx_reg_unlock(chip);
 	return err;
 }
+
+int mv88e6xxx_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+				int *nsel)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	const struct mv88e6xxx_dcb_ops *dcb_ops = chip->info->ops->dcb_ops;
+	int err;
+
+	if (!dcb_ops || !dcb_ops->port_get_apptrust)
+		return -EOPNOTSUPP;
+
+	mv88e6xxx_reg_lock(chip);
+	err = dcb_ops->port_get_apptrust(chip, port, sel, nsel);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
+int mv88e6xxx_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+				int nsel)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	const struct mv88e6xxx_dcb_ops *dcb_ops = chip->info->ops->dcb_ops;
+	int err;
+
+	if (!dcb_ops || !dcb_ops->port_set_apptrust)
+		return -EOPNOTSUPP;
+
+	mv88e6xxx_reg_lock(chip);
+	err = dcb_ops->port_set_apptrust(chip, port, sel, nsel);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
diff --git a/drivers/net/dsa/mv88e6xxx/dcb.h b/drivers/net/dsa/mv88e6xxx/dcb.h
index e1cf92bbd8729..256d25d650014 100644
--- a/drivers/net/dsa/mv88e6xxx/dcb.h
+++ b/drivers/net/dsa/mv88e6xxx/dcb.h
@@ -24,4 +24,9 @@ int mv88e6xxx_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
 int mv88e6xxx_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp,
 				 u8 prio);
 
+int mv88e6xxx_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+				int *nsel);
+int mv88e6xxx_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+				int nsel);
+
 #endif /* _MV88E6XXX_DCB_H_ */

-- 
2.43.0


