Return-Path: <netdev+bounces-260815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI9CEtu+nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:20:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF6194CD0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E57312928C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9933815D3;
	Wed, 25 Feb 2026 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTQTjlMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1863806D3
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010569; cv=none; b=p2le0H3QBDb00DX6f3awbv6A7x6/ynAXSXonTdwTvrC/Z1FvCOmNYP6xnQGwBjVyKiub34WPbhPW9OTQlR5sT4KGeTNyjAXQMRcWN3ZN8ReObNPxI8QBAP/Gov75K/bxyEjrj7rhMGxGByxOtUJnhSxoqgWOhQ0G08dGWUQ9+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010569; c=relaxed/simple;
	bh=mxWhD+3XgMO1uXubJTzTs7MTBPhQYvPegZC3A7X+nAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqvnKB9M67NDPl8Ntm6H9W7jd1ZiCR1hrohrFwhlt8ihnLCIi38HTiuGlXIthq9eEhBcH/rUeKUn1akSkSXgyuC0B4g5Knul46Gi2hmeEoizuaveUbU8dLlcMgj2fXpHkc+15dydhih7xLkDtZwS3a4z46QFZeCsekZ8ZSZA/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTQTjlMr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-823075fed75so466495b3a.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772010564; x=1772615364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ubUSbhiXZLHD3xAZM3OX2BZS1Gxwwr5PThGybo9n2k=;
        b=nTQTjlMr0V21NEhkbGsB8I92lN0zy/UyS3jGoXYYbb/S6qeuGOW/AtAGzFODmdFn/T
         PzH1q/+XE53rQCVjDEyfcmSl+oK75FG6Ov6jDLrWh2E8NqIpP6mfdSU9R0hD0ilGtU+j
         KyA0H0LSsuY7OYaAwrczpoEPNHN6zIsvHbuqyph5M0exT+6jVa5Uz1qOQvF2qe0+vAvS
         qXIcyBa70xSVluNjlyPrfsAC064dkFc6K0oeiIrjYPiselhGXy53iSsnPWQccfX+IdRl
         aVuZYigG0m01HlzJd0yzcCWydlTGkzDankqzV24gnR8zo8tk7LnavfMZxKsUiv2M4iCp
         2o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010564; x=1772615364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ubUSbhiXZLHD3xAZM3OX2BZS1Gxwwr5PThGybo9n2k=;
        b=L3olCsALdE3jPS94Da6fMbh9ek9nuAhKbZ/Cib0iBzq3PBkb6Gs6d4kLNTg0xC1XvO
         23jkV3oPllDFfMv8WmUxIjCUNKn8C10euDfuL7dcpbAw4k0ASXnUU47TCeyihlBMPf0K
         q5gG3svFYO48ygGqK/5bGqMe+ZOjjK1q35Ycw1C/tSAMZjlkMdFLSPC/fA8fw46KQ8RY
         FtLrDWzMytjZQQD68WUcelpsNbZKeMdbS6SkgZN9Tw/4RLA92bZ7X6OYG/JbRnOlor3N
         FV3IC02H/29AP0DlXqHm5NaWpLTSxsYVW6d3JhpWPu6QKh1nPVP9bhj9eTdoz+EaySOc
         37sg==
X-Gm-Message-State: AOJu0YxrtOCkBJl4xM1Mh6XOzTcky4yOstQ3qWYoZltwvh6YUW4BOKuI
	2YtLAK3M4ptfm/apoiNAKjkhmXquV5o+ZV+9cjVEKffM4o4IkKZWW+wSd6UzCuL6
X-Gm-Gg: ATEYQzyYg2t2NAzGITIuoFIvI7+4DJFuo47qGpSCtekp8/KlZnMkgS3PWQKmje4u8i/
	0hLWFEBkZMSB6gsZghhKRe1/gfWcfonm6dvIwYrBpdLbB3p0ax201eKTUIlNCaQJlv4r8b/S8e7
	FF0IE25awEjE7Z13oSPsB6ifLuApXkYrsOuER17MDbcTCrQxgtb9IsYpxIhhPihgIDLz2MM7kqM
	zcbq3SPTiDipQ9PELgZZ4QhIfwxMcDYFBXFyPGYI70tqpb+CIfV9coQH6/fNPTNG6wQPvPuPD3U
	OEQ37Atb9O7RRNQoPEFcuOW9XD21e4peI1wkDKzYSS/ZJV49ZOf6n8siuFIaal3AFl8FaeBLU25
	6hfdjG3B7UBGW7aKyE1R5toUaoaXhtvrD0FbTEc4bvKBdLPKFVncy2FtxZ3zqejfBc0CepMwvq3
	Nmm/EBzt5z1HROYBfQk+PsYJTwvGcYffj6JRGP+abMh13V
X-Received: by 2002:a05:6a00:4614:b0:7ab:2c18:34eb with SMTP id d2e1a72fcca58-82720f95d68mr2450803b3a.12.1772010564107;
        Wed, 25 Feb 2026 01:09:24 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ecb2dsm12883345b3a.60.2026.02.25.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:09:23 -0800 (PST)
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
Subject: [PATCH net-next 3/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Wed, 25 Feb 2026 17:08:47 +0800
Message-ID: <20260225090853.2021140-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225090853.2021140-1-mmyangfl@gmail.com>
References: <20260225090853.2021140-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260815-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCAF6194CD0
X-Rspamd-Action: no action

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 120 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  67 +++++++++++++++++++++-
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 6fa70cea0631..48b322185124 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1304,6 +1305,110 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_tbf_validate(struct yt921x_priv *priv,
+		    const struct tc_tbf_qopt_offload *qopt, int *queuep)
+{
+	struct device *dev = to_device(priv);
+	int queue = -1;
+
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
+	u32 ctrls[YT921X_PORT_SHAPE_CTRL_S];
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
+		burst = priv->port_shape_slot_ns * p->rate.rate_bytes_ps /
+			1000000000 + 10000;
+		meter = yt921x_meter_tfm(priv, port, priv->port_shape_slot_ns,
+					 p->rate.rate_bytes_ps, burst,
+					 YT921X_METER_SINGLE_BUCKET,
+					 YT921X_SHAPE_RATE_MAX,
+					 YT921X_SHAPE_BURST_MAX,
+					 YT921X_SHAPE_UNIT_MAX);
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
+	res = yt921x_longreg_write(priv, YT921X_PORTn_SHAPE_CTRL(port),
+				   ctrls, YT921X_PORT_SHAPE_CTRL_S);
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
@@ -3465,6 +3570,20 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
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
 
@@ -3621,6 +3740,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index b033b942b394..e18216996ee9 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -526,6 +526,12 @@ enum yt921x_app_selector {
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
@@ -536,6 +542,49 @@ enum yt921x_app_selector {
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
+#define  YT921X_QUEUE_SHAPE_CTRL_S		3
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
+#define  YT921X_PORT_SHAPE_CTRL_S		2
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
 
@@ -561,6 +610,11 @@ enum yt921x_fdb_entry_status {
 #define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
 #define YT921X_METER_BURST_MAX	((1 << 16) - 1)
 #define YT921X_METER_RATE_MAX	((1 << 18) - 1)
+#define YT921X_PORT_SHAPE_SLOT_MIN	80
+#define YT921X_QUEUE_SHAPE_SLOT_MIN	132
+#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_SHAPE_BURST_MAX	((1 << 14) - 1)
+#define YT921X_SHAPE_RATE_MAX	((1 << 18) - 1)
 
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
@@ -578,7 +632,16 @@ enum yt921x_fdb_entry_status {
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
@@ -657,6 +720,8 @@ struct yt921x_priv {
 
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
+	unsigned int port_shape_slot_ns;
+	unsigned int queue_shape_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
 	u8 cycle_ns;
-- 
2.51.0


