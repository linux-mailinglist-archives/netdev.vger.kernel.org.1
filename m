Return-Path: <netdev+bounces-277079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAvcJiHf12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:17:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 317703CE055
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49EFB30649CE
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E613E123C;
	Thu,  9 Apr 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvxnsMVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D83E2744
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754755; cv=none; b=spg3R44LpGjBH7i+mQ3/2/okpINEl+tQXbQyUK2gAJvZRbuLmoZxCZMXleEPl65oAdCs4JP6ukO+K4jeqBeXwmHpIH2mwRQSSKtMXV3SJZFNdS7IFvvc86mQSZhcRTXbyw1hoOaYLX+aqjEBXQP5whPrPrxXWC33zhjTx8CMtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754755; c=relaxed/simple;
	bh=+4WVx8f/2+vU0fO+r5uPr9sVtf23lHa78BcGbCxB4IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjrB0xw7wDCvdlELdBl7wikPCs2VnZPo/fz0X+yYdXA9rqQmJLCpupM4eWqprTlAKXXW5fhGkaLOwuRiFg4o5QBmn35RnozhSrE9vABMFgSWIPNfVe1VFJuy/2RIOy3NTn2biK92MO03DPRJE/DiPo3YYzOtUFUe5+9RvruyuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvxnsMVK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b24fdac394so11070545ad.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754753; x=1776359553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+NDWXu5Ducy6eJnnQ/3edoBP8cPmmntQKeSOV1FYCk=;
        b=VvxnsMVKscW815VJ6MQIwNmqA3UhKlu5sFDgZ34ltbil441jGKseO+SmykhQ6bpKTA
         OSdKkB+Tt0DVjHHTiA2kUjd3pdbnhLZ+kgM8ZUmTWiulg9+q/PMijiSN3+ujGCuT+5Hy
         IplN8bo7MV7/LNYz20/2urpZc+5ItsUtMBJ9gVyb+Vnw/v1zEAygztqU/GjgJ3he46/i
         9IoEF3VJ4gBXf2pxek5eU+1kThceKkT9jYbsS0rAYLU36qdcjRnvL23qNCeHBffECOzk
         gboF7AXAgFtNiCQdtRpQeVkB1D6KCMcG18T8PiIJJrG+gLbuXIAoMFJmrSz8QvMTgmES
         IYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754753; x=1776359553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+NDWXu5Ducy6eJnnQ/3edoBP8cPmmntQKeSOV1FYCk=;
        b=jrboKLc9trFQc4FwUrSWqdHrLZf4QQFPVSyk2/wD2u25Koo2N979XF44bTIitjvM6I
         ZI4VwF3wp4DEqlhtwrBLAtJ4nVwfWD9zw+fo1TQ4H9itrbdkUIJTj81mbspxxrw4MdsG
         cVChytExst1iVLpWmpY9xHOFxsyBZLten40qGqnG6trMEfKmXA44EO8gwLX0fq1KgN7b
         nhMc08XD26Phx0x+pq4IQVZu0rcw7sRvczR+O7cSpg2gNZ0HLnqaLdaLGUrAzVVV3kSF
         ifzjOJjI17U7wFOMnQPI/9VZ7xe2B8W+xHPdEEDvyDnEc/bjZrSAnTYEemdUHf3fpZE0
         +jPQ==
X-Gm-Message-State: AOJu0Yzriv38x+wsAuXRlSfRUoStnJnS+8pmEWuhKT3F6qrtiaMUINzZ
	z7x6zw4E9Y3ZbkzUcglan92/Ifpp2h3pm+zwY7uKkg4XHfLMMlgTwFaF1P69esyh
X-Gm-Gg: AeBDiev/l6m88qcTcYbA8XIZFtuFmaGAhnWdsGmPAPXCSATikne69DVS7QSti/nBJCY
	pvEtqkHH2Ph9ugJjr76GbHn86Brd8MymQKmY0Sw7vC4WjwWkxftWZeADUf7hzKQUEzTGS9FVKd1
	+fRlqKWjJqXEmGCzjrzab2LJO1S7YYZUU5XpILSUYWnOBD+jBhOcpX1y9322FHriQletiXPN0hw
	EemydnUM7gznhRiYQMh9dqwrx1g7SW6LON3L0amJcigzyzraRkaT5rqLLNDKC5kR++N/3mhTYu2
	NJAYBfdS4suK2wJe7hFeEKhwCvEO3wYSxn7t4x/tw5eyiK/mVS5j5BqmWfur5+WNeMFNP9SIseA
	8Fgw+CuTP+CRI4xO7aWliVsFRFf6MgtSILeUtKJh9YinS85LV6fnyDv9VRQ/0II1XWA0krvD/Xx
	AydgcfeB3aHbEy7F1IANVGa0cgssZ04W7INYHnCobCnYXBqH40
X-Received: by 2002:a17:903:3b84:b0:2b2:71b4:a3cf with SMTP id d9443c01a7336-2b2816e4279mr275032485ad.19.1775754753280;
        Thu, 09 Apr 2026 10:12:33 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08d1bsm752395ad.54.2026.04.09.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:12:32 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/4] net: dsa: yt921x: Add port qdisc tbf support
Date: Fri, 10 Apr 2026 01:12:04 +0800
Message-ID: <20260409171209.2575583-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409171209.2575583-1-mmyangfl@gmail.com>
References: <20260409171209.2575583-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277079-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 317703CE055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 134 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  65 ++++++++++++++++++-
 2 files changed, 198 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index f0ebbcd2151c..b50d76b2d164 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1274,6 +1275,19 @@ yt921x_marker_tfm_police(struct yt921x_marker *marker,
 				 priv, port, extack);
 }
 
+static int
+yt921x_marker_tfm_shape(struct yt921x_marker *marker, u64 rate, u64 burst,
+			unsigned int flags, bool queue,
+			struct yt921x_priv *priv, int port,
+			struct netlink_ext_ack *extack)
+{
+	return yt921x_marker_tfm(marker, rate, burst, flags,
+				 queue ? priv->queue_shape_slot_ns :
+				 priv->port_shape_slot_ns, YT921X_SHAPE_CIR_MAX,
+				 YT921X_SHAPE_CBS_MAX, YT921X_SHAPE_UNIT_MAX,
+				 priv, port, extack);
+}
+
 static int
 yt921x_police_validate(const struct flow_action_police *police,
 		       const struct flow_action *action,
@@ -1380,6 +1394,111 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
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
+		struct yt921x_marker marker;
+		u64 burst;
+
+		p = &qopt->replace_params;
+
+		/* where is burst??? */
+		burst = div_u64(priv->port_shape_slot_ns * p->rate.rate_bytes_ps,
+				1000000000) + 10000;
+		res = yt921x_marker_tfm_shape(&marker, p->rate.rate_bytes_ps,
+					      burst,
+					      YT921X_MARKER_SINGLE_BUCKET,
+					      false, priv, port, NULL);
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
@@ -3526,6 +3645,20 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
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
 
@@ -3682,6 +3815,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 01cc2298be94..1c4f4b56d1c8 100644
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
 	unsigned char cycle_ns;
-- 
2.53.0


