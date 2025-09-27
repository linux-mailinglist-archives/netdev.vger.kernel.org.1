Return-Path: <netdev+bounces-226846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6FBA5A0F
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639D34E0244
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B727AC5C;
	Sat, 27 Sep 2025 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="BkzzmCaw"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD21EF38C
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758956917; cv=none; b=onES7pyIKj5WVTpS6bGDcFBAO8p1om55HNLTjNusKm/LS7izonJIkCQnJpPTmpUeBWLACFPOdlsTvNsPnn8IMu32bYV6tArS6kmYOQZ1cqczhVGfk+z7nAuNiYNK4b447YgWCTfE8/16jsHhnUxcRrVdEfsDMYQvU0rcRbWFVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758956917; c=relaxed/simple;
	bh=pY9Oe4H9/Hsi9mdywL0+x6lWhR6pS0X2NE6BLR0QHJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLcQ0Gz8YUcN+rkCj5YzQW2csZG0bqm5ndzkFzyXaVnsoQenZwT6aVDSWp/Y5Vi7IUqQqR+nx/xL+EaRpCwd4Q6R5xoMbhGdENaTthL66WU7aNH93TYVLlbkWJGwI/t4ImuEaXBhmF7KSNs7Nr9AaDVaWckVbYV47jRrQlLsOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=BkzzmCaw; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58R77w8C026773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 08:08:22 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58R77w8C026773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758956904; bh=/n1onkR8cW6xxlO1EXYkAG7CcZmC39dKOYNfLf8aXOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkzzmCaw08EIGiGH81S7C0C0JVoQ9hyBLVlwTNI6HUfmqshanxXPTq7BP9Avk4bls
	 5poay9FH6MaaAiXYjpdTX77C7ryAbuTJhxcPQVDNh78lTo35NPRRlUd6UavYBvCDmw
	 QrHv7TfVxExFvSQU7Y5yip2bUHTnxstRTQt0PGWbL/QLKEgXkHj/LIINoyJ7xhRpn5
	 xlKLynhtTZDDpY/6ijKZZSahFV4v6PDym7y7Ds1TK7v0ae+Q40OrSdsnqLxRri14kN
	 nxG5CmWgu0k0t8pxWVMHcQFfAfjcljfmK94IaM0kHfNSw7rf+pPiUC0qAfqiYnWCWv
	 nlQFS7Gq5TJwg==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, max@huntershome.org,
        Luke Howard <lukeh@padl.com>
Subject: [RFC net-next 4/5] net: dsa: mv88e6xxx: CBS support
Date: Sat, 27 Sep 2025 17:07:07 +1000
Message-ID: <20250927070724.734933-5-lukeh@padl.com>
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

Add support for the 802.1Qav Credit Based Shaper (CBS) to Marvell switches
that support AVB. CBS policies can be configured per-port, but are subject
to the global policy limitations imposed by the Marvell MQPRIO
implementation.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/avb.c  | 115 ++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/avb.h  |  33 +++++++++
 drivers/net/dsa/mv88e6xxx/chip.c |  27 ++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |   2 +
 4 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/avb.c b/drivers/net/dsa/mv88e6xxx/avb.c
index 361e7ff821567..513e0504735a6 100644
--- a/drivers/net/dsa/mv88e6xxx/avb.c
+++ b/drivers/net/dsa/mv88e6xxx/avb.c
@@ -107,7 +107,16 @@ static int mv88e6xxx_tc_disable(struct mv88e6xxx_chip *chip)
 	return chip->info->ops->tc_ops->tc_disable(chip);
 }
 
-/* MQPRIO helpers */
+/* MQPRIO and CBS helpers */
+
+int mv88e6xxx_qav_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				    const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	if (!chip->info->ops->tc_ops->set_port_cbs_qopt)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->tc_ops->set_port_cbs_qopt(chip, port, cbs_qopt);
+}
 
 /* Set the AVB global policy limit registers. Caller must acquired register
  * lock.
@@ -330,6 +339,26 @@ int mv88e6xxx_avb_tc_disable(struct mv88e6xxx_chip *chip)
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
@@ -456,14 +485,77 @@ static int mv88e6352_tc_disable(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static int mv88e6341_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				       const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	u16 rate, hilimit;
+
+	if (cbs_qopt->enable) {
+		rate = DIV_ROUND_UP(cbs_qopt->idleslope, MV88E6341_AVB_CFG_RATE_UNITS);
+		rate = clamp_t(u16, rate, 1, MV88E6341_AVB_CFG_RATE_MASK);
+
+		hilimit = cbs_qopt->hicredit;
+		hilimit = clamp_t(u16, hilimit, 1, MV88E6341_AVB_CFG_HI_LIMIT_MASK);
+	} else {
+		rate = 0;
+		hilimit = MV88E6341_AVB_CFG_HI_LIMIT_MASK;
+	}
+
+	return mv88e6xxx_qav_set_port_config(chip, port, cbs_qopt->queue,
+					     rate, hilimit);
+}
+
 const struct mv88e6xxx_tc_ops mv88e6341_tc_ops = {
 	.tc_enable		= mv88e6352_tc_enable,
 	.tc_disable		= mv88e6352_tc_disable,
+	.set_port_cbs_qopt	= mv88e6341_set_port_cbs_qopt,
 };
 
+static int mv88e6352_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				       const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	u16 rate, hilimit;
+	u16 cfg;
+	int err;
+
+	if (cbs_qopt->enable) {
+		rate = DIV_ROUND_UP(cbs_qopt->idleslope, MV88E6352_AVB_CFG_RATE_UNITS);
+		rate = clamp_t(u16, rate, 1, MV88E6352_AVB_CFG_RATE_MASK);
+
+		hilimit = cbs_qopt->hicredit;
+		hilimit = clamp_t(u16, hilimit, 1, MV88E6352_AVB_CFG_HI_LIMIT_MASK);
+	} else {
+		rate = 0;
+		hilimit = MV88E6352_AVB_CFG_HI_LIMIT_MASK;
+	}
+
+	err = mv88e6xxx_qav_set_port_config(chip, port, cbs_qopt->queue,
+					    rate, hilimit);
+	if (err)
+		return err;
+
+	/* Set undocumented enable register */
+
+	err = mv88e6xxx_port_qav_read(chip, port, MV88E6352_PORT_QAV_CFG, &cfg, 1);
+	if (err)
+		return err;
+
+	if (cbs_qopt->enable)
+		cfg |= MV88E6352_PORT_QAV_CFG_ENABLE;
+	else
+		cfg &= ~(MV88E6352_PORT_QAV_CFG_ENABLE);
+
+	err = mv88e6xxx_port_qav_write(chip, port, MV88E6352_PORT_QAV_CFG, cfg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 const struct mv88e6xxx_tc_ops mv88e6352_tc_ops = {
 	.tc_enable		= mv88e6352_tc_enable,
 	.tc_disable		= mv88e6352_tc_disable,
+	.set_port_cbs_qopt	= mv88e6352_set_port_cbs_qopt,
 };
 
 static inline u16 mv88e6390_avb_pri_map_to_reg(const struct mv88e6xxx_avb_priority_map map[])
@@ -544,7 +636,28 @@ static int mv88e6390_tc_disable(struct mv88e6xxx_chip *chip)
 	return err;
 }
 
+static int mv88e6390_set_port_cbs_qopt(struct mv88e6xxx_chip *chip, int port,
+				       const struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	u16 rate, hilimit;
+
+	if (cbs_qopt->enable) {
+		rate = DIV_ROUND_UP(cbs_qopt->idleslope, MV88E6390_AVB_CFG_RATE_UNITS);
+		rate = clamp_t(u16, rate, 1, MV88E6390_AVB_CFG_RATE_MASK);
+
+		hilimit = cbs_qopt->hicredit;
+		hilimit = clamp_t(u16, hilimit, 1, MV88E6390_AVB_CFG_HI_LIMIT_MASK);
+	} else {
+		rate = 0;
+		hilimit = MV88E6390_AVB_CFG_HI_LIMIT_MASK;
+	}
+
+	return mv88e6xxx_qav_set_port_config(chip, port, cbs_qopt->queue,
+					     rate, hilimit);
+}
+
 const struct mv88e6xxx_tc_ops mv88e6390_tc_ops = {
 	.tc_enable		= mv88e6390_tc_enable,
 	.tc_disable		= mv88e6390_tc_disable,
+	.set_port_cbs_qopt	= mv88e6390_set_port_cbs_qopt,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/avb.h b/drivers/net/dsa/mv88e6xxx/avb.h
index d049e30c5c0e2..b83db1e9878bf 100644
--- a/drivers/net/dsa/mv88e6xxx/avb.h
+++ b/drivers/net/dsa/mv88e6xxx/avb.h
@@ -94,6 +94,9 @@
 #define MV88E6XXX_AVB_CFG_OUI_HI		0x0C
 #define MV88E6XXX_AVB_CFG_OUI_LO		0x0D
 
+#define MV88E6XXX_PORT_QAV_CFG_RATE(queue)	(((queue) & 0x7) << 1)
+#define MV88E6XXX_PORT_QAV_CFG_HI_LIMIT(queue)	((((queue) & 0x7) << 1) + 1)
+
 /* 6352 Family AVB Global Config (4 TX queues) */
 
 #define MV88E6352_AVB_CFG_AVB_HI_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)
@@ -110,6 +113,18 @@
 #define MV88E6352_AVB_CFG_AVB_LO_QPRI_GET(p)	FIELD_GET(MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK, p)
 #define MV88E6352_AVB_CFG_AVB_LO_QPRI_SET(p)	FIELD_PREP(MV88E6352_AVB_CFG_AVB_LO_QPRI_MASK, p)
 
+#define MV88E6352_AVB_CFG_RATE_UNITS		32 /* 32Kbps */
+#define MV88E6352_AVB_CFG_RATE_MASK		GENMASK(14, 0) /* 1Gbps */
+#define MV88E6352_AVB_CFG_HI_LIMIT_MASK		GENMASK(14, 0) /* 32k */
+
+#define MV88E6352_PORT_QAV_CFG			0x08
+#define MV88E6352_PORT_QAV_CFG_ENABLE		0x8000
+
+/* 6341 Family AVB Global Config (4 TX queues) */
+#define MV88E6341_AVB_CFG_RATE_UNITS		64 /* 64Kbps */
+#define MV88E6341_AVB_CFG_RATE_MASK		GENMASK(15, 0) /* 4Gbps */
+#define MV88E6341_AVB_CFG_HI_LIMIT_MASK		GENMASK(13, 0) /* 16k */
+
 /* 6390 Family AVB Global Config (8 TX queues) */
 
 #define MV88E6390_AVB_CFG_AVB_HI_FPRI_GET(p)	MV88E6XXX_AVB_CFG_AVB_HI_FPRI_GET(p)
@@ -126,6 +141,10 @@
 #define MV88E6390_AVB_CFG_AVB_LO_QPRI_GET(p)	FIELD_GET(MV88E6390_AVB_CFG_AVB_LO_QPRI_MASK, p)
 #define MV88E6390_AVB_CFG_AVB_LO_QPRI_SET(p)	FIELD_PREP(MV88E6390_AVB_CFG_AVB_LO_QPRI_MASK, p)
 
+#define MV88E6390_AVB_CFG_RATE_UNITS		64 /* 64Kbps */
+#define MV88E6390_AVB_CFG_RATE_MASK		GENMASK(15, 0) /* 4Gbps */
+#define MV88E6390_AVB_CFG_HI_LIMIT_MASK		GENMASK(13, 0) /* 16k */
+
 #define MV88E6352_AVB_QUEUE_MIN(tc)		(tc)
 #define MV88E6352_AVB_QUEUE_MAX(tc)		((tc) + 1)
 
@@ -194,6 +213,20 @@ int mv88e6xxx_avb_tc_enable(struct mv88e6xxx_chip *chip,
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
 /* The MAAP address range is 91:E0:F0:00:00:00 thru 91:E0:F0:00:FF:FF
  * (IEEE 1722 Annex D)
  */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6ba2179d1c4ee..16f41604b932b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7003,6 +7003,31 @@ static int mv88e6xxx_qos_port_mqprio(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static int mv88e6xxx_qos_port_cbs_set(struct dsa_switch *ds, int port,
+				      struct tc_cbs_qopt_offload *cbs_qopt)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (cbs_qopt->queue >= chip->info->num_tx_queues) {
+		dev_info(ds->dev, "p%d: invalid AVB queue %d\n", port, cbs_qopt->queue);
+		return -EINVAL;
+	}
+
+	mutex_lock(&chip->reg_lock);
+
+	err = mv88e6xxx_qav_set_port_cbs_qopt(chip, port, cbs_qopt);
+
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
@@ -7017,6 +7042,8 @@ static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
 		return mv88e6xxx_qos_query_caps(type_data);
 	case TC_SETUP_QDISC_MQPRIO:
 		return mv88e6xxx_qos_port_mqprio(ds, port, type_data);
+	case TC_SETUP_QDISC_CBS:
+		return mv88e6xxx_qos_port_cbs_set(ds, port, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 71e536fbd2d24..6bbfb503b237f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -833,6 +833,8 @@ struct mv88e6xxx_tc_ops {
 	int (*tc_enable)(struct mv88e6xxx_chip *chip,
 			 const struct mv88e6xxx_avb_tc_policy *policy);
 	int (*tc_disable)(struct mv88e6xxx_chip *chip);
+	int (*set_port_cbs_qopt)(struct mv88e6xxx_chip *chip, int port,
+				 const struct tc_cbs_qopt_offload *cbs_qopt);
 };
 
 static inline bool mv88e6xxx_has_stu(struct mv88e6xxx_chip *chip)
-- 
2.43.0


