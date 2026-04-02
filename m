Return-Path: <netdev+bounces-274720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHRVKGXvzmktsAYAu9opvQ
	(envelope-from <netdev+bounces-274720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:36:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59E38ED45
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11100305E61E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20F373BE0;
	Thu,  2 Apr 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgrjnXCm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAA3CA489
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169309; cv=none; b=Ag8NCPC0cGKCm0yRzzxy/xja+bdsNiA2sHC8JA7IcRGvl3ayNRx7TRutx51ZRx/eCP4r/Q9e2/HyjQIzcUa2O6h9xRizRZMrW9n4zM4DrAawFeLvq7hifwdNlKfwBXJh2fu9d9mi9teLC6sAnju6ZK4+rXqhh+v+LILhWRiwywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169309; c=relaxed/simple;
	bh=q9D4v4DiLbfopMD597VLIizyXwdamEPtJut/pHfserM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TED7PvZwYTxl7QB9utoc0MHgSLbShgBTKBLa/gb611BsuK9TyOzhY9fqSBeEQ63lQ7KXvL90FxUtWHB6izs6Vw5IM7n0ZcSS+l7RnEpQ6JJVmsZnr8A2EdAHlzxZD5kifNJ/RBadkKbdw5095nuCw7wf27DfiFj/7SXIhvgO/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgrjnXCm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so689213b3a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775169307; x=1775774107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBBb0dSCbw/VgdEeWJ3io/3ohDhEz9KduwD7tGY/ZSs=;
        b=FgrjnXCmtrfVxC+71KhnWY7KkQZD5Za2E7pBHehJ6oWUHFCI6SsVMwthJayBwJ2wO/
         Y9lfQgITGapzmHCAWXaBvrZWamWC9gtxYMs7KamZB8Wwz/wu1J71MqXNsArdPGdyYft3
         r90iBAMJmhC+JCOWO7AGqJgxHGEtF9xd1boOSvbV3/+N9xztla4U/68Cg2gV5FKZD130
         7AWz8BwuEKsuUBMShg/zgL0Yz3Ipt6VLcecA4RaVD75PkN8cd911MLbObVkg4CXew+pp
         AkXYJcDSz6a+4DMuSPjicPIFQs4dtcN9ZHtqXRAaI1sb4HhycRnY84/9pHuZ1CMZVhuY
         vWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169307; x=1775774107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBBb0dSCbw/VgdEeWJ3io/3ohDhEz9KduwD7tGY/ZSs=;
        b=LFSThVLuEQg16EpWa+D8W9ViCy7+2ob3AD+4lVS4eBYauwOegjsfq7hC3H/POVUKeW
         FHrmLNJVYp/s5HXj4eQaFw9uhqiDOtJstDLCeKE5ucJtpXz3r2W05LpMf6zn4D4f4zAT
         0omq3ZclGVixjYdML1v6W7PUPXjUW73+RpxWIgVgfqtWy/qXtV24/kWDNSJiTF2Nd2PJ
         qe5zATfAAHUws3JlMYcOf4Fnc5ym50/NkAlTR1tzzEtlTDovzRpRiYgWq8AVLlbAmQ5S
         4BdWJ0lmkTPXqKtzRE4w+EWhiOWho8r7mZ1KGYoqnOhnukdvV+7PJhCE9cvIsVZ3b3n9
         XxHw==
X-Gm-Message-State: AOJu0YzbXwvRg4beBhpc6VuKnM6vjbxlrOEIRgYNxj5pOgdRwzaONXTj
	lyk8KRIWe60zhiKuDzk2LvlZN1yjFUGCfh0OCTDd26kKKg37v8cwnfy7ok4Rfw==
X-Gm-Gg: ATEYQzylwCUYvU9v7Udq1wbACNGXli1eut3lOmli1mCNkeFs/plWIV3dkIJkpOab2aG
	8LUdrW+yPXbXhKHHNe7UqMjLkoWKAfkzwGd/tnXgS0LCfR4cPcWNTYzQssEesh/DgG7ApY+aszJ
	wfgUkkMO1cZTN+6xTEyRnYHfQuBTpOb/jPLmfv02rcsgTTI62txCcL+5K2W5plyxuOf2riK2rwT
	Y8iz3hZqBj3aA5utW0DNe1+qu7hTfaaSyoNuXIqdlPg3CO6NVeKyMBA+J/BIGV6tSHoTMggDT4d
	HHkPviTvyeSLU20gPbft4HgX8NOodthpsiZFjVMI4Gof/s/J7O2nhy2znOhBZnD33qJk480TGU/
	yTFmxx5EZVrMS2xNSlLvWU83czC66Bnog92AwGvwjO+ZXAtNlf82RXwQM97fH9w2Li78cpInFJS
	76k9O4wXpHP/rhQaBn328vf58xebWbbPD3GeuE5R8CF0Gi79Z2kw==
X-Received: by 2002:a05:6a21:99a3:b0:39b:e789:7d06 with SMTP id adf61e73a8af0-39f2f0f7b40mr508358637.51.1775169307482;
        Thu, 02 Apr 2026 15:35:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm4294291b3a.57.2026.04.02.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:35:07 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] net: dsa: yt921x: Add port qdisc tbf support
Date: Fri,  3 Apr 2026 06:34:32 +0800
Message-ID: <20260402223437.109097-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402223437.109097-1-mmyangfl@gmail.com>
References: <20260402223437.109097-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274720-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F59E38ED45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 122 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  65 ++++++++++++++++++++-
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 54d99e54dda7..0f97d0a4f042 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1340,6 +1341,112 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
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
+				       YT921X_SHAPE_RATE_MAX,
+				       YT921X_SHAPE_BURST_MAX,
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
@@ -3499,6 +3606,20 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
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
 
@@ -3655,6 +3776,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index e7022657c994..2ec59e03043d 100644
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
 #define YT921X_METER_BURST_MAX	((1 << 16) - 1)
 #define YT921X_METER_RATE_MAX	((1 << 18) - 1)
+#define YT921X_PORT_SHAPE_SLOT_MIN	80
+#define YT921X_QUEUE_SHAPE_SLOT_MIN	132
+#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
+#define YT921X_SHAPE_BURST_MAX	((1 << 14) - 1)
+#define YT921X_SHAPE_RATE_MAX	((1 << 18) - 1)
 
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


