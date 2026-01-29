Return-Path: <netdev+bounces-254663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAUxFIMge2lPBgIAu9opvQ
	(envelope-from <netdev+bounces-254663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:55:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA7ADD3E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A82C303EA87
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10332D0605;
	Thu, 29 Jan 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icpxbqc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA237F0E7
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676819; cv=none; b=juufrXa+FzMrTwn54W3n+YnnMMhtbXoDLF+3I19LTmKFyX/rM5Wb84YSGSxjcD0/mLH9VFleWNTJltla0lsmZl4iKqr9owRy1MZn+JMNz2MWIX460KYfBFAahUyXe3GyfNXK23Ml5dFoVa4m1mzAdB7k2KsYugTw64Un/jw4ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676819; c=relaxed/simple;
	bh=J8x+gpWIU4xPWLJUL20SP6uxFJQBFf53d6giQxdUFVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYVKPtm6ws78zO0ykaRt4tdkuWLOczWoPumVwoJtY+2RGzwx6fr3g7FDY1bgfq5Ktc4bMoB0VgeIUjWKIWULMP/463fFe0/Tthh8CXTl9fav/JSrhfmTz2VtRx3aL/IAeRLkPT+CM/gNNT+bc8ekeI3IaoqP4R16ipCns1NDuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icpxbqc2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82310b74496so487778b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676813; x=1770281613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+eQCaJasdwise2KMZcUhrqlyiXBHdQjhfaNW7h8jho=;
        b=Icpxbqc2Q8ePEr0/fj6DVbuXllHl7XEJRXgsLopjLKvIwaRRC+qXQRPaoW195Oi/ax
         JJ3hXT+QrAr69ET3L3umGFnHodaEr+DNbTnPmBMNNBeV8Jlb86wHmx/t27Ey79mpVuRx
         yfzvMYM0Rw8CiwcJWUXXWGA3rW9nVx5sR4yoj9w/QEzyf532Kn5Xgk7D6/dNKGqYHoxZ
         tTJlEdIUHFjGjfuUVMAqSqVhfMpsL0IYs2wevC3hFIOyxqf2qw+ADhJUVFbgFDdspVkk
         GH6nykv1tXKu+j03EMpaxQyDoIBcUcwuHZtNQPx8IM/k6Baf8FYMaeMGQPP7ZdLahvWV
         WPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676813; x=1770281613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+eQCaJasdwise2KMZcUhrqlyiXBHdQjhfaNW7h8jho=;
        b=FgKA0L/DBHz32sQY1XKnHa9oUK3zXnwdXUJLa2TPfVvQ18SOelxcVqjWL6Ssiisg1p
         r+d8p3+nLSDsujWbrKSB45f34wvP9dOwcym8wuPCK1Njq7phHHPwCcR2wISJflosX6rE
         zxjbl9Eib8ZHJaTZn7zhex2unC1gwdT8Hcm6/k6UQAQsMyzks1je1WpeQRJXmhMV1mrz
         oywrTq/DXd1sblrmWCPVKkH6UyeWg8hRkyoNFiyJ3vFbclq0SQnwtdJqlesrjHVDB6qv
         chltJTZidLd7OuQUNUlZivSg/HSU2VyRm3eNjk5Qx058NWM6zRlzoFztSiZLWbjNuQVU
         paQQ==
X-Gm-Message-State: AOJu0Ywg1GH5RNa1l4A+IFQVyxe1UAFX42o4tBf4Q95P/3PYwGZSNJ7R
	MohqstZeyAkJ9WVOnFOx4T6L0R2+iV0JlWAE7l6OtiIwNzhaqPHzQryFLZtGbhF3
X-Gm-Gg: AZuq6aJiYLsbD2AtdySlFw3xARmPe51o3pRXJ6Ex2659mZyNSVmVUwH6sG0p4BTubSs
	wlDOd2guIjeRJ9JuSAtm3//RKZ+L54EjtJDA49fI/Y3D4QcnxI1t1OaFNjsvrToIGHm/lskaSPU
	PL67Pl3LHr0+3/qsZIfvsBmXx2koYoh56i9ZzUAa5SSEu1CgccRwpdFfK73+XXAS0PDrefIzj15
	ty/+2OEkzghVfUjFMMBI70tJEkYPmLRran3EOK0e6nMq2Q9T0bB7k8nYYixRufJZ+njYSP0+IkF
	qbPGH7HaVukiocgPDkVWO6iy7ho0iysnK54/SbLRQIe49vrxHpVTZOmAptc8yQO7yhU49RR2BHQ
	YAj81B2sj1Hies/KJ0n9owBLUL4Zy+WuZw0J5yS2LAjrffTKBA+E8vC0ACm1yjDXP6ASx+8ChQp
	3OI9y09ZX3c7rPADEFjmCRjtsawS0VvQCodAeZbBvb0gANug==
X-Received: by 2002:a05:6a21:62c1:b0:387:5ded:994a with SMTP id adf61e73a8af0-38ec657e4d6mr6127625637.60.1769676813248;
        Thu, 29 Jan 2026 00:53:33 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef50sm44651165ad.12.2026.01.29.00.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:53:33 -0800 (PST)
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
Subject: [RFC net-next 4/4] net: dsa: yt921x: Add port qdisc tbf support
Date: Thu, 29 Jan 2026 16:51:36 +0800
Message-ID: <20260129085139.2767649-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129085139.2767649-1-mmyangfl@gmail.com>
References: <20260129085139.2767649-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254663-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EFA7ADD3E
X-Rspamd-Action: no action

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 113 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  18 +++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index f1465c4d9b1b..dd279f1db837 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1291,6 +1292,110 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
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
@@ -3445,6 +3550,13 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
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
 
@@ -3601,6 +3713,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 129073ed3a4b..dbcd89c7bd6c 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -537,6 +537,19 @@ enum yt921x_app_selector {
 #define  YT921X_MIRROR_PORT_M			GENMASK(3, 0)
 #define   YT921X_MIRROR_PORT(x)				FIELD_PREP(YT921X_MIRROR_PORT_M, (x))
 
+#define YT921X_PORT_SHAPE_SLOT		0x34000c
+#define  YT921X_PORT_SHAPE_SLOT_SLOT_M		GENMASK(11, 0)
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
 
@@ -562,6 +575,10 @@ enum yt921x_fdb_entry_status {
 #define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
 #define YT921X_METER_BURST_MAX	((1 << 16) - 1)
 #define YT921X_METER_RATE_MAX	((1 << 18) - 1)
+#define YT921X_PORT_SHAPE_SLOT_MIN	80
+#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_SHAPE_BURST_MAX	((1 << 14) - 1)
+#define YT921X_SHAPE_RATE_MAX	((1 << 18) - 1)
 
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
@@ -658,6 +675,7 @@ struct yt921x_priv {
 
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
+	unsigned int port_shape_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
 	u8 cycle_ns;
-- 
2.51.0


