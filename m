Return-Path: <netdev+bounces-283778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OGoIWZx+GlCvAIAu9opvQ
	(envelope-from <netdev+bounces-283778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1349F4BB836
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650DA30158B3
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86309391E57;
	Mon,  4 May 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC8JV9DD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5838C423
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889631; cv=none; b=WiX9lt8k6/e8X/VH2UTWhX5KML2U69KhsE2fnmpqj1PJnmruXg0W/hiXiY3CDHhEd3PmO0oCnwp1EAjjfjJOJ126/bqbIxXKTARl+wQCRCkJBrtX98j/66KM/bR06W6NLyX/EA+TQqoTVceWeCkqU/xOY5TWkOVDVh74UNYUVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889631; c=relaxed/simple;
	bh=QrxzpA0GiXoHm7RCzoHPdzDiRzt9hYqD8UzCVTFrFuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk4bjRn+TMuNzT5s/wXkyjd70Ua/KjKYBjwlEe8hkCqakMMeOkC3QfaSNzN5ZCVAir9yfnJPETgyk090qU8N7sHa1OXKEeBo+B+pAOXh3MpUPiYzVYsKlbVLYZFX7Zj3kxYl8hBMf6mJp712wMPgM1kNSQ7ilbA5aM2+e1+CaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC8JV9DD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8296d553142so2746418b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889629; x=1778494429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKiZYwrOXmYbchKN5aqn3H9VsvZ64UWqf0h7N9kmfHc=;
        b=JC8JV9DDtgM3Gc0VzNBTAC5QeHj0bzjLm6Kq736XCtLMwQDbY0xVwBSM124kuhW0fY
         oa9qK76mgU0lZdPoKUmdLMbmDGEc/tT3SDIevr+5yKuXVZllM3UOyNTbyrGWoBbvvrW2
         GfwgbpLTW4D6+y30AYCdSwMVestbFsuuOzPhCzczPrOTR5Rw0sGJeERfzg9YZd32yHz6
         4aCSs33rNx4TfhxHDqIPLtxkY7A4tfcPLQxSUboRatafDM7quDKv93t/e9lGjyYiMpAc
         2ZxZi1rF0IkMsazuPppX51awxPVDbCSOsACiXCp8cB2wGbpc15dfypQnmucDtJYHKsds
         ZiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889629; x=1778494429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKiZYwrOXmYbchKN5aqn3H9VsvZ64UWqf0h7N9kmfHc=;
        b=pF5gmtCj0/FSjpfErgeunWnbDbimWcFJATcPxGFDSXJpzUjBOdyWEOo5exvM3tqIGx
         qOS6C6iXL8C4AiCSV7qFjPghyaeih35h82zxE82BdGKM1i6VAp/cF1CMly6lnIbYqXSz
         Nrwno6JIwnWzXCIy8WQ4pMFn89t7da5tMPAAY0iAerPpthMuMcQStC3VGkbvZmXFDvwG
         kXOUxkdoTLvyhlba7ANWhT5rIhD/3vczY58eDMO60F25+fjj2TdDSg+HzUBOQSvX8Z5w
         eZ7Ya6M8Yoh86tViUc1G+DpMk8+4os9OPRYBgWM1fEYHpIkD8LvSqu+FLquSlshIvPEp
         KoXw==
X-Gm-Message-State: AOJu0YwYYPz3Y9APrDbrCxmBWdmsoypQljFRbf3yQeWoV9Av6k5wnc26
	uZu01wZESD/vSc3Mq8k5CfOFYNuiH8ImfL+Sb5lhBecKahP4Nroxk9bRnLjcfPtb
X-Gm-Gg: AeBDievP/3/jajNhi46GgVykFPrFb7UmjwnltaFkAC5TYW6z+B7sIUQqY/ql/YmEjiA
	tY0lwDP1/ua5uY9uHTF8wQ0jUqz3F6eTJL+X1IKrw/aBbTXoXMmYND1gyYbWK8Nz9UaN0Y3NvWp
	soLPFieO1A0bwO/pS7cLAWQ+1dqso3IKyx2h76p2G6uxons9Da+TzVKQcVVaUA8K42zTpksd6Wh
	9/PJno3kP4juvP8AiXMLC0923pFhzKOOe428/lnO4vvMVF41uqE0VOxbKeLUgOUK79/Wm7gPKPv
	iVqxoKGGFELTTk+01M/CnqH//OsD0N3vCjvLVmmgZr6NSbAAW0izwEEMZpZgil7HSOTTxomWZ7E
	Dub27oZzpr1/dDHQzyzT+OlKLOq9pZnOV11/2WKGB18/UKAAh7g+IF5DAEjomgyNe63vXVgKPxY
	5mIQmEmREpNMZLKUZ+0UrygaMXgNnpkPzB8SvJnTvUIp21XNnx+GP8kwkHx6y5
X-Received: by 2002:a05:6a00:3a15:b0:824:9bc5:e946 with SMTP id d2e1a72fcca58-8352d2ac213mr8324730b3a.46.1777889629282;
        Mon, 04 May 2026 03:13:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bd62fsm10813486b3a.24.2026.05.04.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:13:48 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Mon,  4 May 2026 18:12:55 +0800
Message-ID: <20260504101258.1608004-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504101258.1608004-1-mmyangfl@gmail.com>
References: <20260504101258.1608004-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1349F4BB836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283778-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 126 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  18 ++++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index fd1fdcd5f9a3..fd77e1ef53bb 100644
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
@@ -1378,6 +1390,112 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_tbf_validate(struct yt921x_priv *priv,
+		    const struct tc_tbf_qopt_offload *qopt)
+{
+	struct netlink_ext_ack *extack = qopt->extack;
+
+	if (qopt->parent != TC_H_ROOT) {
+		NL_SET_ERR_MSG_MOD(extack, "Parent should be \"root\"");
+		return -EOPNOTSUPP;
+	}
+
+	switch (qopt->command) {
+	case TC_TBF_REPLACE: {
+		const struct tc_tbf_qopt_offload_replace_params *p;
+
+		p = &qopt->replace_params;
+
+		if (p->mtu || p->peak.rate_bytes_ps) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Offload not supported when mtu/peakrate is configured");
+			return -EOPNOTSUPP;
+		}
+
+		if (!p->rate.mpu) {
+			NL_SET_ERR_MSG_MOD(extack, "Assuming mpu = 64");
+		} else if (p->rate.mpu != 64) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Offload not supported when mpu is other than 64");
+			return -EOPNOTSUPP;
+		}
+
+		break;
+	}
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
+				  const struct tc_tbf_qopt_offload *qopt)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct netlink_ext_ack *extack = qopt->extack;
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
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	switch (type) {
+	case TC_SETUP_QDISC_TBF: {
+		const struct tc_tbf_qopt_offload *qopt = type_data;
+
+		res = yt921x_tbf_validate(priv, qopt);
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
@@ -3524,6 +3642,13 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
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
 
@@ -3680,6 +3805,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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


