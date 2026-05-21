Return-Path: <netdev+bounces-290186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E+RG1VaDmo4+AUAu9opvQ
	(envelope-from <netdev+bounces-290186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:05:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694959D806
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DABF3024818
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D92D0C82;
	Thu, 21 May 2026 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q79Pndzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECD2BE7AC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325455; cv=none; b=FCJMUEoj+FkOSXP6+m0kzhSIkitbvmnyocNfQD7zug+slJs3XIvGTU5K94OwLwpVZEy/OZFZsiqxS1zP9GBaBw19tMmHSWnwO4hWEUyE9i0ldfJ2vk6wzYsLNs0KWkCLgD8a8qe2g8UZ5DfE9k1kD5xlPLfylR7FO0NkcS0Q0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325455; c=relaxed/simple;
	bh=a5lw+ZWNnkXskn4epJZ8umdeexpyjZpwnavsvLPxSFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFsiwJKyVn8D4qtibhTrkuWwgz8z7Di4p0ezRQNNy7C8DtZF+GYN0WJsT2B7q17x/CSoPRGo8Em2fV4jyj9tef527uctzFUFMt5WvIqJGM2wQPL5bVg+2xkOjoSWwPqlNyFmJS3IIl61Wh+1ydnowBHBzyf/DmK43x9QTMEW6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q79Pndzy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3699cdeec05so2134978a91.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325453; x=1779930253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwPhEgGJz2L9oeS85kbGuc6+jFjA70v+GRwapYHP/2s=;
        b=Q79PndzyueOa/+YZcTEibyLav1Z80TphNBKMQpl30wXt/Boy1/gRtaoFrcJQQCROZ0
         4OZ1hG8FRaNUjITTimAxE0c1TwUY/SKqWuKLfd38ZJ4wx3k0bkyvUBr6frtV1sAsaSpo
         bgJ/dYvR8qNXxs/8DZE1AMkoxRl16vu3CcnlYTGgJD9cCRbqrmqo+kJHEpqHgzoF94ra
         0AKU/lHoqWQh0ya/7t5ji2xFYKHHnvNsLjJqAg/6rXQWRs1zPXQccU/ho95CPkORvK15
         9403ialsU4LQ1fpdcJ6gTI+O0dfStfgTr5EhdjbFcLW8USNphQVRAPFnfiz0CeYvRw3j
         6HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325453; x=1779930253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwPhEgGJz2L9oeS85kbGuc6+jFjA70v+GRwapYHP/2s=;
        b=UnIlw2zq0wSWd7fzpx6sfXCBT0NlL+vOGMc1vhk3UjKDrKces56UfAsuCqSAjGgh8/
         7hyHqbyqgeZED+XKKf/cznPp4WsQAP5UoQJobOzeABhdEu1PtAnuO45WC8y5eCNo4DH5
         UuAEX6+aTZymtNA6LS3pC+wi4ytlNWq8n58OPssoLXMfsm4scX/ofGVikBpjV4X+2Tm5
         3CJDTUVpucXgUDKkUCIFRV518NpxqoteRhbf4eb2REd+acJmOqDOm4Nl2R0tpq1wGfsR
         vPrORRVlVfxx5ieOSKVenwA3oQGIQAqnuGGz1W+gjwI0oH3VDXk1SgG2cJ2yBPCDujMo
         WN0w==
X-Gm-Message-State: AOJu0YxHXiDmvke8h/x2LXyWpuEloKqD/SDNG1agpQ6L4j2bc0eki9gJ
	um/19F3MpLvOqFCXSiOxdMQih8G1H813BqMQUjPMxhwz7yfTADaxBqHwRwMymvVp
X-Gm-Gg: Acq92OEVtTnMdPp7NR3agbir2CmqmSsAA5lcSkit+/QXJ8Tlq+25iPOI27eWCqXK+ra
	yIiuUbF/a+r2LxYQuYaIPHArVPHWMUVhnbnSp+bnYZKPIMqbMzFL0MrqlvaX2Chdrv72G43xob2
	xuLq9RZa4/0XHD+BnJ8sdTo+mCWmxHTyMLYGvh4VVKG4er4TwjCst6tIH5KfOISMBpxpxqdcEqD
	7G8RW0ZXASmCFM6p/qool1AxVcEA0J0bIbF0mVYXSdgTuQpfrFlhFr6rF5OLA10o3IyT9uZDjxb
	K2rMt6uP9DPd8tfcz94MraQMZdo505SbxiW1WCSsSh33DC/LaMS+1ykl0/4NJPdOStOL/AhHqD9
	V51Q/KENka5l5o4CgYFxjjzdmT8hPljwxogPr8BK2L/xBUAn6sJGI0p/moc0F2G8rx4Hp7m9jMN
	nttTjoiJcfkXP0x+DWyJX+X50jD6frRu1uqs9Dd9JHHTWWER2m2xTbbM1l4Aa6
X-Received: by 2002:a17:90b:3505:b0:368:3d3e:efa6 with SMTP id 98e67ed59e1d1-36a45621dc5mr691121a91.20.1779325452803;
        Wed, 20 May 2026 18:04:12 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:1232::1d0:bf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114a70sm26319616a12.22.2026.05.20.18.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:04:12 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/3] net: dsa: yt921x: Add port TBF support
Date: Thu, 21 May 2026 09:03:07 +0800
Message-ID: <20260521010320.208138-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521010320.208138-1-mmyangfl@gmail.com>
References: <20260521010320.208138-1-mmyangfl@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7694959D806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

React to TC_SETUP_QDISC_TBF and configure the egress shaper as
appropriate with the maximum rate and burst size requested by the user.
Per queue shaper is possible, though not touched in this commit.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 87 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h | 18 +++++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index fd1fdcd5f9a3..9cc211b90c6c 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1272,6 +1273,17 @@ yt921x_marker_tfm_police(struct yt921x_marker *marker,
 				 priv, port, extack);
 }
 
+static int
+yt921x_marker_tfm_shape(struct yt921x_marker *marker, u64 rate, u64 burst,
+			unsigned int flags, struct yt921x_priv *priv, int port,
+			struct netlink_ext_ack *extack)
+{
+	return yt921x_marker_tfm(marker, rate, burst, flags,
+				 priv->port_shape_slot_ns, YT921X_SHAPE_CIR_MAX,
+				 YT921X_SHAPE_CBS_MAX, YT921X_SHAPE_UNIT_MAX,
+				 priv, port, extack);
+}
+
 static int
 yt921x_police_validate(const struct flow_action_police *police,
 		       const struct flow_action *action,
@@ -1378,6 +1390,73 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
+				  const struct tc_tbf_qopt_offload *qopt)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct netlink_ext_ack *extack = qopt->extack;
+	u32 ctrls[2];
+	int res;
+
+	if (qopt->parent != TC_H_ROOT)
+		return -EOPNOTSUPP;
+
+	switch (qopt->command) {
+	case TC_TBF_STATS:
+		/* Unfortunately the convention for TC_*_STATS is a mess,
+		 * neither 0 nor -EOPNOTSUPP is perfect here.
+		 */
+		return -EOPNOTSUPP;
+	case TC_TBF_DESTROY:
+		ctrls[0] = 0;
+		ctrls[1] = 0;
+		break;
+	case TC_TBF_REPLACE: {
+		const struct tc_tbf_qopt_offload_replace_params *p;
+		struct yt921x_marker marker;
+
+		p = &qopt->replace_params;
+
+		res = yt921x_marker_tfm_shape(&marker, p->rate.rate_bytes_ps,
+					      p->max_size,
+					      YT921X_MARKER_SINGLE_BUCKET,
+					      priv, port, extack);
+		if (res)
+			return res;
+
+		ctrls[0] = YT921X_PORT_SHAPE_CTRLa_CIR(marker.cir) |
+			   YT921X_PORT_SHAPE_CTRLa_CBS(marker.cbs);
+		ctrls[1] = YT921X_PORT_SHAPE_CTRLb_UNIT(marker.unit) |
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
+	switch (type) {
+	case TC_SETUP_QDISC_TBF: {
+		const struct tc_tbf_qopt_offload *qopt = type_data;
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
@@ -3524,6 +3603,13 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
 		return res;
 	priv->meter_slot_ns = ctrl * op_ns;
 
+	ctrl = max(priv->port_shape_slot_ns / op_ns,
+		   YT921X_PORT_SHAPE_SLOT_MIN);
+	res = yt921x_reg_write(priv, YT921X_PORT_SHAPE_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->port_shape_slot_ns = ctrl * op_ns;
+
 	return 0;
 }
 
@@ -3680,6 +3766,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 546b12a8994a..70fa780c337f 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -531,6 +531,19 @@ enum yt921x_app_selector {
 #define  YT921X_MIRROR_PORT_M			GENMASK(3, 0)
 #define   YT921X_MIRROR_PORT(x)				FIELD_PREP(YT921X_MIRROR_PORT_M, (x))
 
+#define YT921X_PORT_SHAPE_SLOT		0x34000c
+#define  YT921X_PORT_SHAPE_SLOT_SLOT_M		GENMASK(11, 0)
+#define YT921X_PORTn_SHAPE_CTRL(port)	(0x354000 + 8 * (port))
+#define  YT921X_PORT_SHAPE_CTRLb_EN		BIT(4)
+#define  YT921X_PORT_SHAPE_CTRLb_PKT_MODE	BIT(3)	/* 0: byte rate mode */
+#define  YT921X_PORT_SHAPE_CTRLb_UNIT_M		GENMASK(2, 0)
+#define   YT921X_PORT_SHAPE_CTRLb_UNIT(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLb_UNIT_M, (x))
+#define  YT921X_PORT_SHAPE_CTRLa_CBS_M		GENMASK(31, 18)
+#define   YT921X_PORT_SHAPE_CTRLa_CBS(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CBS_M, (x))
+#define  YT921X_PORT_SHAPE_CTRLa_CIR_M		GENMASK(17, 0)
+#define   YT921X_PORT_SHAPE_CTRLa_CIR(x)		FIELD_PREP(YT921X_PORT_SHAPE_CTRLa_CIR_M, (x))
+#define YT921X_PORTn_SHAPE_STAT(port)	(0x356000 + 4 * (port))
+
 #define YT921X_EDATA_EXTMODE	0xfb
 #define YT921X_EDATA_LEN	0x100
 
@@ -556,6 +569,10 @@ enum yt921x_fdb_entry_status {
 #define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
 #define YT921X_METER_CIR_MAX	((1 << 18) - 1)
 #define YT921X_METER_CBS_MAX	((1 << 16) - 1)
+#define YT921X_PORT_SHAPE_SLOT_MIN	80
+#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
+#define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
 
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
@@ -652,6 +669,7 @@ struct yt921x_priv {
 
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
+	unsigned int port_shape_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
 	unsigned char cycle_ns;
-- 
2.53.0


