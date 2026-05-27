Return-Path: <netdev+bounces-292019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAYZF8I+FmomjwcAu9opvQ
	(envelope-from <netdev+bounces-292019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81305DE06C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A09307FC25
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8D301486;
	Wed, 27 May 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="2CYRV3W9"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433C22D792;
	Wed, 27 May 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842649; cv=none; b=YtwG2SIp2YGUNss55og0C/aLobnCvK8Z6Szjmj4SxnKLp/iObhj4Gx3BuH1CcU2Q++BNvFwjnOevZR/zW7h9Rv08kDAGk2RDdBVJWZisXxJ1AlxaKr6CCdDV7wfbKYOORq4wPPgJORHeSSg9BTX5WajmceaWEb74z7IMf+GmOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842649; c=relaxed/simple;
	bh=WV73yGMriYScpZk3noteET3ObyG4UvnKvFCI2P/aEZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw3x9o+tRYRHAPVr1q2c117/qvQY4ARKQ4JY5rB39WAZ5hNT2muFZptKtB8NMGatuFsGyLuJ3j+C+Gl2N1paTx5yLUS/BCUHIsO5SdcBsPgiWy8aJcK082l9FAtbAhcXwqjLfCS7B8orVBvHKssKA84PHhGz6v4zFgB8vX39v/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=2CYRV3W9; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tI030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:50 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tI030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842633; bh=6tjWCnW60LeD+YTuVumVesDjhDxRx5aeyp3eLtnsjEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2CYRV3W9N7c/NbEePTKg6dv6id94vg6M2gbBnPXkbHCPW991BPP+y3JAmB96y5m1F
	 ZhY3UcMDv6ppFs13YEaIIT7H3n6OnC643OZPIxiy9642mWJNd3TJUpJM4Xv4te76r0
	 ev4rhjU2i0tioBB489KnBAR0Hy4EMTsS8j+s3MT5iImPi3fnG6kzNToifuoTxQyRmw
	 euRpSX2qBQwZbCscQNms1Td8iYmqiYZ45dcLeHb+X0x6KJPui0/u+0m/pBYqRYe0pM
	 CDQwcgZkXmRcRevl+9PaaoSbIl1f/g3vX37eGxTs00d3a50uiezFtKX7lobB8O4Fax
	 +InvugrFIqDZw==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: dsa: mv88e6xxx: CBS support
Date: Wed, 27 May 2026 10:42:51 +1000
Message-ID: <b4279a06b836da86ad0c0137c3a6989a99241427.1779841530.git.lukeh@padl.com>
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
	FREEMAIL_CC(0.00)[padl.com,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292019-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,padl.com:mid,padl.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,luminex.be:email]
X-Rspamd-Queue-Id: A81305DE06C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the 802.1Qav Credit Based Shaper (CBS) to Marvell switches
that support AVB. CBS policies can be configured per-port, but are subject
to the global policy limitations imposed by the Marvell MQPRIO
implementation.

Co-developed-by: Cedric Jehasse <cedric.jehasse@luminex.be>
Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/avb.c  | 189 +++++++++++++++++++++++++------
 drivers/net/dsa/mv88e6xxx/avb.h  |  31 +++++
 drivers/net/dsa/mv88e6xxx/chip.c |  73 ++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  22 ++++
 drivers/net/dsa/mv88e6xxx/port.c |  45 ++++++++
 drivers/net/dsa/mv88e6xxx/port.h |  20 ++++
 6 files changed, 343 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/avb.c b/drivers/net/dsa/mv88e6xxx/avb.c
index c535bf4fe3623..1a6365ff66378 100644
--- a/drivers/net/dsa/mv88e6xxx/avb.c
+++ b/drivers/net/dsa/mv88e6xxx/avb.c
@@ -107,7 +107,67 @@ static int mv88e6xxx_tc_disable(struct mv88e6xxx_chip *chip)
 	return chip->info->ops->tc_ops->tc_disable(chip);
 }
 
-/* MQPRIO helpers */
+/* MQPRIO and CBS helpers */
+
+/* Ensure strict priority scheduling is enabled for CBS ports */
+static int mv88e6xxx_cbs_update_scheduler(struct mv88e6xxx_chip *chip, int port,
+					  bool has_cbs)
+{
+	const struct mv88e6xxx_ops *ops = chip->info->ops;
+	u8 mode;
+
+	if (!ops->port_set_scheduling_mode)
+		return 0;
+
+	mode = has_cbs ? chip->info->num_tx_queues - 1 : 0;
+
+	return ops->port_set_scheduling_mode(chip, port, mode);
+}
+
+/* Return true if any CBS queue has a non-zero rate configured on a port. */
+static bool mv88e6xxx_avb_port_has_cbs(struct mv88e6xxx_chip *chip, int port)
+{
+	int queue, err;
+	u16 rate;
+
+	for (queue = 0; queue < chip->info->num_tx_queues; queue++) {
+		err = mv88e6xxx_port_qav_read(chip, port,
+					      MV88E6XXX_PORT_QAV_CFG_RATE(queue),
+					      &rate, 1);
+		if (err)
+			continue;
+		else if (rate)
+			return true;
+	}
+
+	return false;
+}
+
+/* Enable/disable CBS and, if supported, strict priority, on a port */
+int mv88e6xxx_qav_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				    const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	const struct mv88e6xxx_ops *ops = chip->info->ops;
+	const struct mv88e6xxx_tc_ops *tc_ops = ops->tc_ops;
+	bool old_active, new_active;
+	int err;
+
+	if (!tc_ops->set_port_cbs_qopt)
+		return -EOPNOTSUPP;
+
+	old_active = mv88e6xxx_avb_port_has_cbs(chip, port);
+
+	err = tc_ops->set_port_cbs_qopt(chip, port, cbs_qopt);
+	if (err)
+		return err;
+
+	new_active = cbs_qopt->enable ? true : mv88e6xxx_avb_port_has_cbs(chip, port);
+
+	if (old_active != new_active)
+		return mv88e6xxx_cbs_update_scheduler(chip, port, new_active);
+
+	return 0;
+}
 
 /* Set the AVB global policy limit registers
  *
@@ -197,19 +257,19 @@ static u16 mv88e6xxx_avb_get_cfg_avb_mode(struct mv88e6xxx_chip *chip)
 	return cfg;
 }
 
-/* Enable or disable a port for AVB
- *
- * @param chip		Marvell switch chip instance
- * @param port		Switch port
- * @param enable	If true, will enable AVB queues on this port.
- *
- * @return		0 on success, or a negative error value otherwise
- */
-static int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
-					   int port, bool enable)
+int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
+				    int port, bool enable)
 {
 	u16 cfg;
 
+	/* When disabling, only revert to legacy mode if no CBS queue
+	 * is still active on this port.
+	 */
+	if (!enable && mv88e6xxx_avb_port_has_cbs(chip, port)) {
+		dev_info(chip->dev, "p%d: CBS active, not disabling AVB\n", port);
+		return 0;
+	}
+
 	if (enable)
 		cfg = mv88e6xxx_avb_get_cfg_avb_mode(chip);
 	else
@@ -218,22 +278,6 @@ static int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_port_avb_write(chip, port, MV88E6XXX_PORT_AVB_CFG, cfg);
 }
 
-static int mv88e6xxx_avb_set_avb_mode(struct mv88e6xxx_chip *chip, bool enable)
-{
-	int port, err;
-
-	for (port = 0, err = 0; port < mv88e6xxx_num_ports(chip); ++port) {
-		if (!dsa_is_user_port(chip->ds, port))
-			continue;
-
-		err = mv88e6xxx_avb_set_port_avb_mode(chip, port, enable);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
 int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
 			    const struct mv88e6xxx_avb_tc_policy *policy)
 {
@@ -254,14 +298,8 @@ int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
 	if (err)
 		goto err_iso_ptr;
 
-	err = mv88e6xxx_avb_set_avb_mode(chip, true);
-	if (err)
-		goto err_tc;
-
 	return 0;
 
-err_tc:
-	mv88e6xxx_tc_disable(chip);
 err_iso_ptr:
 	mv88e6xxx_qav_set_iso_ptr(chip, 0);
 err_mac_avb:
@@ -273,11 +311,18 @@ int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
 
 int mv88e6xxx_avb_tc_disable(struct mv88e6xxx_chip *chip)
 {
-	int err;
+	int port, err;
 
-	err = mv88e6xxx_avb_set_avb_mode(chip, false);
-	if (err)
-		return err;
+	/* Revert all user ports to legacy mode irrespective of CBS setting */
+	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
+		if (!dsa_is_user_port(chip->ds, port))
+			continue;
+		err = mv88e6xxx_port_avb_write(chip, port,
+					       MV88E6XXX_PORT_AVB_CFG,
+					       MV88E6XXX_PORT_AVB_CFG_AVB_MODE_LEGACY);
+		if (err)
+			return err;
+	}
 
 	err = mv88e6xxx_tc_disable(chip);
 	if (err)
@@ -297,6 +342,26 @@ int mv88e6xxx_avb_tc_disable(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static int mv88e6xxx_qav_set_port_config(struct mv88e6xxx_chip *chip, int port,
+					 int queue, u16 rate, u16 hilimit)
+{
+	int err;
+
+	err = mv88e6xxx_port_qav_write(chip, port,
+				       MV88E6XXX_PORT_QAV_CFG_RATE(queue),
+				       rate);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_port_qav_write(chip, port,
+				       MV88E6XXX_PORT_QAV_CFG_HI_LIMIT(queue),
+				       hilimit);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /* Assign FPri to QPri mappings for each traffic class
  *
  * @param chip		Marvell switch chip instance
@@ -424,14 +489,63 @@ static int mv88e6352_tc_disable(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static int mv88e6xxx_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				       const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	const struct mv88e6xxx_qav_info *qav = chip->info->qav;
+	u16 rate, hilimit;
+
+	if (!qav)
+		return -EOPNOTSUPP;
+
+	if (cbs_qopt->enable) {
+		rate = DIV_ROUND_UP(cbs_qopt->idleslope, qav->rate_unit);
+		rate = clamp_t(u16, rate, 1, qav->rate_mask);
+
+		hilimit = cbs_qopt->hicredit;
+		hilimit = clamp_t(u16, hilimit, 1, qav->hi_limit_mask);
+	} else {
+		rate = 0;
+		hilimit = qav->hi_limit_mask;
+	}
+
+	return mv88e6xxx_qav_set_port_config(chip, port, cbs_qopt->queue,
+					     rate, hilimit);
+}
+
 const struct mv88e6xxx_tc_ops mv88e6341_tc_ops = {
 	.tc_enable		= mv88e6352_tc_enable,
 	.tc_disable		= mv88e6352_tc_disable,
+	.set_port_cbs_qopt	= mv88e6xxx_set_port_cbs_qopt,
 };
 
+static int mv88e6352_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				       const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	u16 cfg;
+	int err;
+
+	err = mv88e6xxx_set_port_cbs_qopt(chip, port, cbs_qopt);
+	if (err)
+		return err;
+
+	/* Set undocumented enable register */
+	err = mv88e6xxx_port_qav_read(chip, port, MV88E6352_PORT_QAV_CFG, &cfg, 1);
+	if (err)
+		return err;
+
+	if (cbs_qopt->enable)
+		cfg |= MV88E6352_PORT_QAV_CFG_ENABLE;
+	else
+		cfg &= ~MV88E6352_PORT_QAV_CFG_ENABLE;
+
+	return mv88e6xxx_port_qav_write(chip, port, MV88E6352_PORT_QAV_CFG, cfg);
+}
+
 const struct mv88e6xxx_tc_ops mv88e6352_tc_ops = {
 	.tc_enable		= mv88e6352_tc_enable,
 	.tc_disable		= mv88e6352_tc_disable,
+	.set_port_cbs_qopt	= mv88e6352_set_port_cbs_qopt,
 };
 
 static inline u16 mv88e6390_avb_pri_map_to_reg(const struct mv88e6xxx_avb_priority_map map[])
@@ -515,4 +629,5 @@ static int mv88e6390_tc_disable(struct mv88e6xxx_chip *chip)
 const struct mv88e6xxx_tc_ops mv88e6390_tc_ops = {
 	.tc_enable		= mv88e6390_tc_enable,
 	.tc_disable		= mv88e6390_tc_disable,
+	.set_port_cbs_qopt	= mv88e6xxx_set_port_cbs_qopt,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/avb.h b/drivers/net/dsa/mv88e6xxx/avb.h
index 72d1c26a84731..5c21842bb68c4 100644
--- a/drivers/net/dsa/mv88e6xxx/avb.h
+++ b/drivers/net/dsa/mv88e6xxx/avb.h
@@ -94,6 +94,9 @@
 #define MV88E6XXX_AVB_CFG_OUI_HI		0x0C
 #define MV88E6XXX_AVB_CFG_OUI_LO		0x0D
 
+#define MV88E6XXX_PORT_QAV_CFG_RATE(queue)	((((queue) & 0x7) << 1))
+#define MV88E6XXX_PORT_QAV_CFG_HI_LIMIT(queue)	((((queue) & 0x7) << 1) + 1)
+
 /* 6352 Family AVB Global Config (4 TX queues) */
 
 #define MV88E6352_AVB_CFG_AVB_HI_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)
@@ -110,6 +113,9 @@
 #define MV88E6352_AVB_CFG_AVB_LO_QPRI_GET(p)	FIELD_GET(MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK, p)
 #define MV88E6352_AVB_CFG_AVB_LO_QPRI_SET(p)	FIELD_PREP(MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK, p)
 
+#define MV88E6352_PORT_QAV_CFG			0x08
+#define MV88E6352_PORT_QAV_CFG_ENABLE		0x8000
+
 /* 6390 Family AVB Global Config (8 TX queues) */
 
 #define MV88E6390_AVB_CFG_AVB_HI_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)
@@ -176,6 +182,17 @@ extern const struct mv88e6xxx_tc_ops mv88e6341_tc_ops;
 extern const struct mv88e6xxx_tc_ops mv88e6352_tc_ops;
 extern const struct mv88e6xxx_tc_ops mv88e6390_tc_ops;
 
+/* Enable or disable a port for AVB. Caller must acquire register lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param port		Switch port
+ * @param enable	If true, will enable AVB queues on this port.
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+int mv88e6xxx_avb_set_port_avb_mode(struct mv88e6xxx_chip *chip,
+				    int port, bool enable);
+
 /* Set AVB queue priority policy. Caller must acquire register lock.
  *
  * @param chip		Marvell switch chip instance
@@ -194,4 +211,18 @@ int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
  */
 int mv88e6xxx_avb_tc_disable(struct mv88e6xxx_chip *chip);
 
+struct tc_cbs_qopt_offload;
+
+/* Set AVB credit based shaper policy. Caller must acquire register lock.
+ *
+ * @param chip		Marvell switch chip instance
+ * @param port		Switch port
+ * @param cbs_qopt	CBS policy to apply
+ *
+ * @return		0 on success, or a negative error value otherwise
+ */
+int mv88e6xxx_qav_set_port_cbs_qopt(struct mv88e6xxx_chip *chip,
+				    int port,
+				    const struct tc_cbs_qopt_offload *cbs_qopt);
+
 #endif /* _MV88E6XXX_AVB_H */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index cb7dd75ab6ef2..bea9356b3e244 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5031,6 +5031,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6352_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5474,6 +5475,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6352_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5537,6 +5539,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6390_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5602,6 +5605,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6390_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5665,6 +5669,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.port_set_ether_type = mv88e6393x_port_set_ether_type,
 	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6097_port_egress_rate_limiting,
+	.port_set_scheduling_mode = mv88e6390_port_set_scheduling_mode,
 	.port_pause_limit = mv88e6390_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
@@ -5708,6 +5713,19 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.tc_ops = &mv88e6390_tc_ops,
 };
 
+static const struct mv88e6xxx_qav_info mv88e6352_qav_info = {
+	.rate_unit = 32,
+	.rate_mask = GENMASK(14, 0),
+	.hi_limit_mask = GENMASK(14, 0),
+};
+
+/* The 6341 family shares the 6390-family rate-shaper encoding. */
+static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
+	.rate_unit = 64,
+	.rate_mask = GENMASK(15, 0),
+	.hi_limit_mask = GENMASK(13, 0),
+};
+
 static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 	[MV88E6020] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6020,
@@ -5922,6 +5940,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6161_ops,
 	},
 
@@ -5948,6 +5967,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6165_ops,
 	},
 
@@ -6152,6 +6172,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6191_ops,
 	},
 
@@ -6178,6 +6199,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6393x_ops,
 	},
 
@@ -6206,6 +6228,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6393x_ops,
 	},
 
@@ -6261,6 +6284,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6240_ops,
 	},
 
@@ -6311,6 +6335,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6290_ops,
 	},
 
@@ -6340,6 +6365,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6320_ops,
 	},
 
@@ -6369,6 +6395,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6321_ops,
 	},
 
@@ -6397,6 +6424,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6341_ops,
 	},
 
@@ -6448,6 +6476,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6351_ops,
 	},
 
@@ -6476,6 +6505,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
 		.num_tx_queues = 4,
+		.qav = &mv88e6352_qav_info,
 		.ops = &mv88e6352_ops,
 	},
 	[MV88E6361] = {
@@ -6504,6 +6534,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6393x_ops,
 	},
 	[MV88E6390] = {
@@ -6533,6 +6564,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6390_ops,
 	},
 	[MV88E6390X] = {
@@ -6560,6 +6592,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.edsa_support = MV88E6XXX_EDSA_UNDOCUMENTED,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6390x_ops,
 	},
 
@@ -6588,6 +6621,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.multi_chip = true,
 		.ptp_support = true,
 		.num_tx_queues = 8,
+		.qav = &mv88e6390_qav_info,
 		.ops = &mv88e6393x_ops,
 	},
 };
@@ -7044,6 +7078,43 @@ static int mv88e6xxx_qos_port_mqprio(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static int mv88e6xxx_qos_port_cbs_set(struct dsa_switch *ds, int port,
+				      struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (!dsa_is_user_port(ds, port))
+		return -EINVAL;
+
+	if (cbs_qopt->queue >= chip->info->num_tx_queues) {
+		dev_err(ds->dev, "p%d: invalid AVB queue %d\n", port, cbs_qopt->queue);
+		return -EINVAL;
+	}
+
+	mutex_lock(&chip->reg_lock);
+
+	if (cbs_qopt->enable &&
+	    !(chip->avb_tc_policy.port_mask & BIT(port))) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	err = mv88e6xxx_qav_set_port_cbs_qopt(chip, port, cbs_qopt);
+	if (!err)
+		err = mv88e6xxx_avb_set_port_avb_mode(chip, port, cbs_qopt->enable);
+
+out:
+	mutex_unlock(&chip->reg_lock);
+
+	if (err) {
+		dev_info(ds->dev, "p%d: failed to %s AVB CBS policy: %d\n",
+			 port, cbs_qopt->enable ? "enable" : "disable", err);
+	}
+
+	return err;
+}
+
 static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
 				   enum tc_setup_type type,
 				   void *type_data)
@@ -7058,6 +7129,8 @@ static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
 		return mv88e6xxx_qos_query_caps(type_data);
 	case TC_SETUP_QDISC_MQPRIO:
 		return mv88e6xxx_qos_port_mqprio(ds, port, type_data);
+	case TC_SETUP_QDISC_CBS:
+		return mv88e6xxx_qos_port_cbs_set(ds, port, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index b6f4331affdc6..6c2f67e3378ef 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -126,6 +126,7 @@ enum mv88e6xxx_edsa_support {
 };
 
 struct mv88e6xxx_ops;
+struct mv88e6xxx_qav_info;
 
 struct mv88e6xxx_info {
 	enum mv88e6xxx_family family;
@@ -180,6 +181,11 @@ struct mv88e6xxx_info {
 	/* Number of TX queues */
 	u8 num_tx_queues;
 
+	/* 802.1Qav credit-based shaping capability data, or NULL if the
+	 * chip does not support CBS offload.
+	 */
+	const struct mv88e6xxx_qav_info *qav;
+
 	/* Internal PHY start index. 0 means that internal PHYs range starts at
 	 * port 0, 1 means internal PHYs range starts at port 1, etc
 	 */
@@ -654,6 +660,13 @@ struct mv88e6xxx_ops {
 				   size_t size);
 
 	int (*port_egress_rate_limiting)(struct mv88e6xxx_chip *chip, int port);
+
+	/* Select egress scheduling mode: number of highest-numbered queues that
+	 * use strict priority instead of WRR/WFQ. Used to ensure CBS-shaped
+	 * queues take precedence over best-effort traffic.
+	 */
+	int (*port_set_scheduling_mode)(struct mv88e6xxx_chip *chip, int port,
+					u8 mode);
 	int (*port_pause_limit)(struct mv88e6xxx_chip *chip, int port, u8 in,
 				u8 out);
 	int (*port_disable_learn_limit)(struct mv88e6xxx_chip *chip, int port);
@@ -875,6 +888,15 @@ struct mv88e6xxx_tc_ops {
 	int (*tc_enable)(struct mv88e6xxx_chip *chip,
 			 const struct mv88e6xxx_avb_tc_policy *policy);
 	int (*tc_disable)(struct mv88e6xxx_chip *chip);
+	int (*set_port_cbs_qopt)(struct mv88e6xxx_chip *chip, int port,
+				 const struct tc_cbs_qopt_offload *cbs_qopt);
+};
+
+/* Per-family 802.1Qav credit-based shaping capability data. */
+struct mv88e6xxx_qav_info {
+	u16 rate_unit;		/* in kbps */
+	u16 rate_mask;		/* QPri Rate valid bits mask */
+	u16 hi_limit_mask;	/* QPri Hi Limit valid bits mask */
 };
 
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 3a842c4d18105..936b07d8e6b0a 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1323,6 +1323,51 @@ int mv88e6097_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port)
 				    0x0001);
 }
 
+/* Set the egress scheduling mode (WRR vs strict priority for top queues).
+ * @mode is the number of high-numbered queues to put into strict priority
+ * (0 = WRR for all queues, 3 = all queues strict).
+ */
+int mv88e6352_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode)
+{
+	u16 reg;
+	int err;
+
+	if (mode > FIELD_MAX(MV88E6352_PORT_EGRESS_RATE_CTL2_SCHEDULE_MASK))
+		return -EINVAL;
+
+	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_EGRESS_RATE_CTL2,
+				  &reg);
+	if (err)
+		return err;
+
+	reg &= ~MV88E6352_PORT_EGRESS_RATE_CTL2_SCHEDULE_MASK;
+	reg |= FIELD_PREP(MV88E6352_PORT_EGRESS_RATE_CTL2_SCHEDULE_MASK, mode);
+
+	return mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_EGRESS_RATE_CTL2,
+				    reg);
+}
+
+/* Set the egress scheduling mode (WFQ vs strict priority for top queues).
+ * @mode is the number of high-numbered queues to put into strict priority
+ * (0 = WFQ for all queues, 7 = all queues strict).
+ */
+int mv88e6390_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode)
+{
+	u16 reg;
+
+	if (mode > FIELD_MAX(MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK))
+		return -EINVAL;
+
+	reg = MV88E6390_PORT_QUEUE_CTL_UPDATE |
+	      FIELD_PREP(MV88E6390_PORT_QUEUE_CTL_PTR_MASK,
+			 MV88E6390_PORT_QUEUE_CTL_PTR_SCHEDULE) |
+	      FIELD_PREP(MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK, mode);
+
+	return mv88e6xxx_port_write(chip, port, MV88E6390_PORT_QUEUE_CTL, reg);
+}
+
 /* Offset 0x0B: Port Association Vector */
 
 int mv88e6xxx_port_set_assoc_vector(struct mv88e6xxx_chip *chip, int port,
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index 3ebd2ebafbf0f..8aaf3adb5e4d9 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -241,6 +241,22 @@
 
 /* Offset 0x0A: Egress Rate Control 2 */
 #define MV88E6XXX_PORT_EGRESS_RATE_CTL2		0x0a
+/* Number of highest-numbered queues using strict priority instead of WRR.
+ * 0 = WRR for all queues, 3 = all queues strict priority.
+ */
+#define MV88E6352_PORT_EGRESS_RATE_CTL2_SCHEDULE_MASK	GENMASK(13, 12)
+
+/* Offset 0x1C: Port Queue Control (6390 family) */
+#define MV88E6390_PORT_QUEUE_CTL			0x1c
+#define MV88E6390_PORT_QUEUE_CTL_UPDATE			BIT(15)
+#define MV88E6390_PORT_QUEUE_CTL_PTR_MASK		GENMASK(14, 8)
+#define MV88E6390_PORT_QUEUE_CTL_DATA_MASK		GENMASK(7, 0)
+/* Pointers */
+#define MV88E6390_PORT_QUEUE_CTL_PTR_SCHEDULE		0x00
+/* Number of highest-numbered queues using strict priority instead of WFQ.
+ * 0 = WFQ for all queues, 7 = all queues strict priority.
+ */
+#define MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK		GENMASK(2, 0)
 
 /* Offset 0x0B: Port Association Vector */
 #define MV88E6XXX_PORT_ASSOC_VECTOR			0x0b
@@ -563,6 +579,10 @@ int mv88e6165_port_set_jumbo_size(struct mv88e6xxx_chip *chip, int port,
 				  size_t size);
 int mv88e6095_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port);
 int mv88e6097_port_egress_rate_limiting(struct mv88e6xxx_chip *chip, int port);
+int mv88e6352_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode);
+int mv88e6390_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
+				       u8 mode);
 int mv88e6xxx_port_set_assoc_vector(struct mv88e6xxx_chip *chip, int port,
 				    u16 pav);
 int mv88e6097_port_pause_limit(struct mv88e6xxx_chip *chip, int port, u8 in,
-- 
2.43.0


