Return-Path: <netdev+bounces-276075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIhKArsu1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA863B1B8F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD7FA3029A15
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D636DA1B;
	Tue,  7 Apr 2026 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSaP78Sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224063D0907
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578238; cv=none; b=b4wJQw2SfskIu34NYtetIxWp5BeL4IMiIq/H/nMkHCaaYZCYo/T7HfILA+geFReWViQqOW90ZyCyB78PDimasUcPC+r+4DcNYdRTkqSpvp2X9EFbtua3T72o4MnWF9FljStp8wxTpuTWmC5G2g/NsXgLktconIcwg4N271V6hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578238; c=relaxed/simple;
	bh=hF82NWQJBc2WFU61B+UG2P726TqXY6jc7G43zMgos4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLAeuDbyGMnOSJCp9vzZ64leBt86ok8ByzD6DTsAni7iDGgIX/CoEBcMyfYi/270CNtCAuvem7rOA6gtd9YJVcsPaGJQaT87UoGeWPOmrtmiPWdTcCydwN94HyiHY8XN66EM5UVTx2z8bA/RkSXzxggUykks3UN1P4lzK0hTguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSaP78Sj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76b87931b8so3616270a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578229; x=1776183029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRUvXpceETuGX3yJUhh4jXH+4ZRB9zEdwf1xaftsJqs=;
        b=MSaP78Sj7FRxGMaHonQUKdZwa8HfXm1zCuP7QRYUcYQRxsJX94jaLMGDuORHxVoGYv
         8X4KHzGjri1f4NFvnYXJOZmiy6oqT793fVFAHd8kcAsU7sI9qVGVTGL+Ccoh4N4hCAqS
         H2vx/CAxWdOVkXkGzi+6ZTkRWIzbief5Fc9QObBwgFOvBAb9zRzuP9vn2DzEabyPlgIo
         qYdINbwhWvHj+FZgyCos8JDYsVWhAs3UlzsOtgy/ove6v4QGMxKoX46M9UsBuW84ldEy
         7efw2xXtAXIXqNRt4tlzGek7CkiOgyOR6HvBjkpJFu2H9WC87cO6qIbMV9BDirx/ak2F
         kwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578229; x=1776183029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRUvXpceETuGX3yJUhh4jXH+4ZRB9zEdwf1xaftsJqs=;
        b=d/5NIxWkWWtNMxHo2fQ9Zd68TnWu9Qd4FPfP2q/MfnFBFE6bef5JwnDPbcVT88S76t
         TGVGjh9NfebtRDoY8Wmrx+mhFvULVEGR7Goxwkxnb7woTT8zdOTurM0Egco48Trd9nyD
         tExWysnOV4c5ExUzLyR6RKuFSM6iygjh5LfJ0akwab1X21XIRuAFhM16K0g4sBPcUsJV
         vu3XJwPsfD85Uto59QYoLynmd3OZspA/tCb+BGd02NbFqM3jKCPzzkB6ndGyilEPndgB
         VooJeH+3oJqWyEu32mHGZIlboN9XjU7klSeAGBQkiW/6MMOTGmsTV5dTw8QzOVXQULU/
         biKw==
X-Gm-Message-State: AOJu0YzeLCon3vfMlfi34ZW3/1MGMOXzuSHRxMtivB0WD9KLDjkeQSrL
	AZdEpeUwTA0koUa7HoiCKZHLDzBccDorg2PbQvaUf/a2SjFY9h/n4CAql09RCw==
X-Gm-Gg: AeBDieueOlwfgwOt3/j7gzlO92AdoFJpWdYq1KmD4l4XbxDEryI7vOvc1sS+1OinIBh
	igjlnudOCVS/YT1/ofPokhOZFeKMwT192Kuy8MIifMYmwHNXAeC5IGxiTMu0Anai/bXyKK1JBQr
	szrNwH2PD7GRNuMPGwWB4feYpf9V8FrtIrTCZkaerdDxPi6yQb3kRyM0nKPqND1HsD1Bd2gdP7D
	NoC9mST4S5+Z3iOH5EDJkOYkS0CElXobkCkbvsjxfIHQstfe9vM5gr+jU028DifVpvPYTUuZGEZ
	g2bE2P9eQZpIjPlyUDNPLAfhWZjiVPuNzQx3Ac4oezuIblyD1hEYgs0a6WVS3KBdIGNj4uLm0aE
	VSSLHeAtjNoP9oVrSvqGP3nVOpteexa0bk5UbQ0zk0t06xD5K9fDDuNjeCTxeN82XQ8iH2jWlQv
	PErN4GqoOIQzG5IrNkmXPn6E4Qk7F6cdZ13miTl39FvHfSzh92
X-Received: by 2002:a05:6a21:a105:b0:39c:a791:6ab1 with SMTP id adf61e73a8af0-39f2f050544mr15128274637.31.1775578228850;
        Tue, 07 Apr 2026 09:10:28 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6372078sm15650238a12.0.2026.04.07.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:10:28 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: dsa: yt921x: Add port qdisc tbf support
Date: Wed,  8 Apr 2026 00:05:56 +0800
Message-ID: <20260407160559.1747616-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407160559.1747616-1-mmyangfl@gmail.com>
References: <20260407160559.1747616-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276075-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AA863B1B8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 123 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  65 ++++++++++++++++++++-
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index e77bd4a34e10..0c87a0e02148 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1330,6 +1331,113 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_tbf_validate(struct yt921x_priv *priv,
+		    const struct tc_tbf_qopt_offload *qopt, int *queuep)
+{
+	struct device *dev = to_device(priv);
+	int queue = -1;
+
+	/* TODO: queue support */
+	if (qopt->parent != TC_H_ROOT) {
+		dev_err(dev, "Parent should be \"root\"\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (qopt->command) {
+	case TC_TBF_REPLACE: {
+		const struct tc_tbf_qopt_offload_replace_params *p;
+
+		p = &qopt->replace_params;
+
+		if (!p->rate.mpu) {
+			dev_info(dev, "Assuming you want mpu = 64\n");
+		} else if (p->rate.mpu != 64) {
+			dev_err(dev, "mpu other than 64 not supported\n");
+			return -EINVAL;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+	*queuep = queue;
+	return 0;
+}
+
+static int
+yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
+				  const struct tc_tbf_qopt_offload *qopt)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 ctrls[2];
+	int res;
+
+	switch (qopt->command) {
+	case TC_TBF_DESTROY:
+		ctrls[0] = 0;
+		ctrls[1] = 0;
+		break;
+	case TC_TBF_REPLACE: {
+		const struct tc_tbf_qopt_offload_replace_params *p;
+		struct yt921x_meter meter;
+		u64 burst;
+
+		p = &qopt->replace_params;
+
+		/* where is burst??? */
+		burst = div_u64(priv->port_shape_slot_ns * p->rate.rate_bytes_ps,
+				1000000000) + 10000;
+		res = yt921x_meter_tfm(priv, port, priv->port_shape_slot_ns,
+				       p->rate.rate_bytes_ps, burst,
+				       YT921X_METER_SINGLE_BUCKET,
+				       YT921X_SHAPE_CIR_MAX,
+				       YT921X_SHAPE_CBS_MAX,
+				       YT921X_SHAPE_UNIT_MAX, &meter);
+		if (res)
+			return res;
+
+		ctrls[0] = YT921X_PORT_SHAPE_CTRLa_CIR(meter.cir) |
+			   YT921X_PORT_SHAPE_CTRLa_CBS(meter.cbs);
+		ctrls[1] = YT921X_PORT_SHAPE_CTRLb_UNIT(meter.unit) |
+			   YT921X_PORT_SHAPE_CTRLb_EN;
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg64_write(priv, YT921X_PORTn_SHAPE_CTRL(port), ctrls);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
+			 enum tc_setup_type type, void *type_data)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	switch (type) {
+	case TC_SETUP_QDISC_TBF: {
+		const struct tc_tbf_qopt_offload *qopt = type_data;
+		int queue;
+
+		res = yt921x_tbf_validate(priv, qopt, &queue);
+		if (res)
+			return res;
+
+		return yt921x_dsa_port_setup_tc_tbf_port(ds, port, qopt);
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -3476,6 +3584,20 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
 		return res;
 	priv->meter_slot_ns = ctrl * op_ns;
 
+	ctrl = max(priv->port_shape_slot_ns / op_ns,
+		   YT921X_PORT_SHAPE_SLOT_MIN);
+	res = yt921x_reg_write(priv, YT921X_PORT_SHAPE_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->port_shape_slot_ns = ctrl * op_ns;
+
+	ctrl = max(priv->queue_shape_slot_ns / op_ns,
+		   YT921X_QUEUE_SHAPE_SLOT_MIN);
+	res = yt921x_reg_write(priv, YT921X_QUEUE_SHAPE_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->queue_shape_slot_ns = ctrl * op_ns;
+
 	return 0;
 }
 
@@ -3632,6 +3754,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index a640672d1f1e..991989a31727 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -524,6 +524,12 @@ enum yt921x_app_selector {
 #define  YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED	BIT(1)
 #define  YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED	BIT(0)
 
+#define YT921X_PORTn_PRIO_UCAST_QUEUE(port)	(0x300200 + 4 * (port))
+#define  YT921X_PORT_PRIOm_UCAST_QUEUE_M(m)	(7 << (3 * (m)))
+#define   YT921X_PORT_PRIOm_UCAST_QUEUE(m, x)		((x) << (3 * (m)))
+#define YT921X_PORTn_PRIO_MCAST_QUEUE(port)	(0x300280 + 4 * (port))
+#define  YT921X_PORT_PRIOm_MCAST_QUEUE_M(m)	(3 << (2 * (m)))
+#define   YT921X_PORT_PRIOm_MCAST_QUEUE(m, x)		((x) << (2 * (m)))
 #define YT921X_MIRROR			0x300300
 #define  YT921X_MIRROR_IGR_PORTS_M		GENMASK(26, 16)
 #define   YT921X_MIRROR_IGR_PORTS(x)			FIELD_PREP(YT921X_MIRROR_IGR_PORTS_M, (x))
@@ -534,6 +540,47 @@ enum yt921x_app_selector {
 #define  YT921X_MIRROR_PORT_M			GENMASK(3, 0)
 #define   YT921X_MIRROR_PORT(x)				FIELD_PREP(YT921X_MIRROR_PORT_M, (x))
 
+#define YT921X_QUEUE_SHAPE_SLOT		0x340008
+#define  YT921X_QUEUE_SHAPE_SLOT_SLOT_M		GENMASK(11, 0)
+#define YT921X_PORT_SHAPE_SLOT		0x34000c
+#define  YT921X_PORT_SHAPE_SLOT_SLOT_M		GENMASK(11, 0)
+#define YT921X_QUEUEn_SCH(x)		(0x341000 + 4 * (x))
+#define  YT921X_QUEUE_SCH_E_DWRR_M		GENMASK(27, 18)
+#define   YT921X_QUEUE_SCH_E_DWRR(x)			FIELD_PREP(YT921X_QUEUE_SCH_E_DWRR_M, (x))
+#define  YT921X_QUEUE_SCH_C_DWRR_M		GENMASK(17, 8)
+#define   YT921X_QUEUE_SCH_C_DWRR(x)			FIELD_PREP(YT921X_QUEUE_SCH_C_DWRR_M, (x))
+#define  YT921X_QUEUE_SCH_E_PRIO_M		GENMASK(7, 4)
+#define   YT921X_QUEUE_SCH_E_PRIO(x)			FIELD_PREP(YT921X_QUEUE_SCH_E_PRIO_M, (x))
+#define  YT921X_QUEUE_SCH_C_PRIO_M		GENMASK(3, 0)
+#define   YT921X_QUEUE_SCH_C_PRIO(x)			FIELD_PREP(YT921X_QUEUE_SCH_C_PRIO_M, (x))
+#define YT921X_C_DWRRn(x)		(0x342000 + 4 * (x))
+#define YT921X_E_DWRRn(x)		(0x343000 + 4 * (x))
+#define  YT921X_DWRR_PKT_MODE			BIT(0)	/* 0: byte rate mode */
+#define YT921X_QUEUEn_SHAPE_CTRL(x)	(0x34c000 + 0x10 * (x))
+#define  YT921X_QUEUE_SHAPE_CTRLc_TOKEN_OVERFLOW_EN	BIT(6)
+#define  YT921X_QUEUE_SHAPE_CTRLc_E_EN		BIT(5)
+#define  YT921X_QUEUE_SHAPE_CTRLc_C_EN		BIT(4)
+#define  YT921X_QUEUE_SHAPE_CTRLc_PKT_MODE	BIT(3)	/* 0: byte rate mode */
+#define  YT921X_QUEUE_SHAPE_CTRLc_UNIT_M	GENMASK(2, 0)
+#define   YT921X_QUEUE_SHAPE_CTRLc_UNIT(x)		FIELD_PREP(YT921X_QUEUE_SHAPE_CTRLc_UNIT_M, (x))
+#define  YT921X_QUEUE_SHAPE_CTRLb_EBS_M		GENMASK(31, 18)
+#define   YT921X_QUEUE_SHAPE_CTRLb_EBS(x)		FIELD_PREP(YT921X_QUEUE_SHAPE_CTRLb_EBS_M, (x))
+#define  YT921X_QUEUE_SHAPE_CTRLb_EIR_M		GENMASK(17, 0)
+#define   YT921X_QUEUE_SHAPE_CTRLb_EIR(x)		FIELD_PREP(YT921X_QUEUE_SHAPE_CTRLb_EIR_M, (x))
+#define  YT921X_QUEUE_SHAPE_CTRLa_CBS_M		GENMASK(31, 18)
+#define   YT921X_QUEUE_SHAPE_CTRLa_CBS(x)		FIELD_PREP(YT921X_QUEUE_SHAPE_CTRLa_CBS_M, (x))
+#define  YT921X_QUEUE_SHAPE_CTRLa_CIR_M		GENMASK(17, 0)
+#define   YT921X_QUEUE_SHAPE_CTRLa_CIR(x)		FIELD_PREP(YT921X_QUEUE_SHAPE_CTRLa_CIR_M, (x))
+#define YT921X_PORTn_SHAPE_CTRL(port)	(0x354000 + 8 * (port))
+#define  YT921X_PORT_SHAPE_CTRLb_EN		BIT(4)
+#define  YT921X_PORT_SHAPE_CTRLb_PKT_MODE	BIT(3)	/* 0: byte rate mode */
+#define  YT921X_PORT_SHAPE_CTRLb_UNIT_M		GENMASK(2, 0)
+#define   YT921X_PORT_SHAPE_CTRLb_UNIT(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLb_UNIT_M, (x))
+#define  YT921X_PORT_SHAPE_CTRLa_CBS_M		GENMASK(31, 18)
+#define   YT921X_PORT_SHAPE_CTRLa_CBS(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CBS_M, (x))
+#define  YT921X_PORT_SHAPE_CTRLa_CIR_M		GENMASK(17, 0)
+#define   YT921X_PORT_SHAPE_CTRLa_CIR(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CIR_M, (x))
+
 #define YT921X_EDATA_EXTMODE	0xfb
 #define YT921X_EDATA_LEN	0x100
 
@@ -559,6 +606,11 @@ enum yt921x_fdb_entry_status {
 #define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
 #define YT921X_METER_CIR_MAX	((1 << 18) - 1)
 #define YT921X_METER_CBS_MAX	((1 << 16) - 1)
+#define YT921X_PORT_SHAPE_SLOT_MIN	80
+#define YT921X_QUEUE_SHAPE_SLOT_MIN	132
+#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
+#define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
 
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
@@ -576,7 +628,16 @@ enum yt921x_fdb_entry_status {
 #define YT921X_TAG_LEN	8
 
 /* 8 internal + 2 external + 1 mcu */
-#define YT921X_PORT_NUM			11
+#define YT921X_PORT_NUM		11
+#define YT921X_UCAST_QUEUE_NUM	8
+#define YT921X_MCAST_QUEUE_NUM	4
+#define YT921X_PORT_QUEUE_NUM \
+	(YT921X_UCAST_QUEUE_NUM + YT921X_MCAST_QUEUE_NUM)
+#define YT921X_UCAST_QUEUE_ID(port, queue) \
+	(YT921X_UCAST_QUEUE_NUM * (port) + (queue))
+#define YT921X_MCAST_QUEUE_ID(port, queue) \
+	(YT921X_UCAST_QUEUE_NUM * YT921X_PORT_NUM + \
+	 YT921X_MCAST_QUEUE_NUM * (port) + (queue))
 
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
@@ -655,6 +716,8 @@ struct yt921x_priv {
 
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
+	unsigned int port_shape_slot_ns;
+	unsigned int queue_shape_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
 	u8 cycle_ns;
-- 
2.53.0


