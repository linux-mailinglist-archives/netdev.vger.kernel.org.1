Return-Path: <netdev+bounces-283491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOxFHshy9mloVAIAu9opvQ
	(envelope-from <netdev+bounces-283491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 208DD4B38D7
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4166F301705C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333D38B7B0;
	Sat,  2 May 2026 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4L/sLbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF63A3E62
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758857; cv=none; b=sba0Oc9EpmMRnhT8qadfbKV13PQHJpM5oiwBL9NQ8viLIbZZ7ezt+zU5kEFQ9PMTKLBg+6XlLLgbUMod/aDYVtis72GOFuS1+9HvaP2c5qryHkfm/jVXi9J4Yg8DSjBPedWOHuEersATTp4ZWUF4tD/5Z7bd3blfI0COyi5X3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758857; c=relaxed/simple;
	bh=cRnWCMQ88GSHrKRzoEl4e2//bkZFdnLonj7I/X92Vlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeAdW9582qEEXbPwq3CMR5OISEe2fu9Vz65Hbrye0uARfDZdUVLD2YDn82ZOCQgCqiHZKO0v2/PKmh03y0IqRnc9XfFNiYhk6BCLSaUAS7NIYGm2OeDyRmW+jbh0ayZrMK+UqP3ybKyCd9ciI64uRhetO0ifhZ5F72WCjjGQtws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4L/sLbC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so25966235ad.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777758855; x=1778363655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTLIWvyiu4EREhHJ+YnuwMmWukQlgS0TtUJWhXuNCiw=;
        b=c4L/sLbCVLrA+BpVC1i4lO/G+UpE6dp7fBJiUYbxldKSYUFxK5zvI6ekBPRTOoGhy2
         41YBhYaA3VrIF8sWyEg/iRsEGE65Eo5lPPvMMngsCT+AtQqorCb+rtYs1KJCHa6JcNLq
         HhGDJq6JULqcJCA4F6+7KixnFifXu+CLIpPOQZEHQ0IsF2PswEulaEBqZ7b/pVNY/2HY
         Rw07NVTy1E0WWSRL+uGhV5FcQ+GDCsakqs3KtpcJnqshCFxsEHdGJn2mbvE5AMx+AhoG
         si5IzmhfLEJukaylWcVLKHeNTtZOE7wuDEIRq9IAflkoWlMLxa1ZQ7C1XM6/nTX2P57Y
         ImLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777758855; x=1778363655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTLIWvyiu4EREhHJ+YnuwMmWukQlgS0TtUJWhXuNCiw=;
        b=l5N5oEvE3zhVSwxpnX9IHK24xvMJEs2OoiWSSi5fG0W1hvcdrJEFmTWYWTXDvboBj1
         iCPWFKKnp693oy/9TezvOmbJHKaEBqT0TENb0JmUt+OVd8rXRTJFfcfK04g5PdBtLDke
         vNBbFN9EyGb5NpchnkWBSxQCLlHYQPs0a5kJSdN5YCHqFsxvZ9pejnPQ7CWYwjLs/bse
         ngdPnpPfL60dwkhjVlXL2lr3PgfQ6aX7cDutMAo0vHM/RbN47SKLLzKm+Odx3bRb9+HB
         edVMOFp4sSqQ3gWbffGVAk5hRtIX2ApV/XC/9Z/vrwQTQgsucgcI1DDHzCQvqrPwgu5m
         peBQ==
X-Gm-Message-State: AOJu0YzrGRPSE+lVQDZg6IhaK6o8LKG5H5pk09jVQUq2bb1acG0FbV//
	Ez929Gqzj80RPfRpoYlEm5QwNBWxPZ7XgRJhv1UEY+7pIlry/34r/CMW67BTZekf
X-Gm-Gg: AeBDieskdBoNBMqteE26XzXjBBTdxqQQWkMddf/Ojtg3ayolDVD/Q4kem7aNf8SPwpb
	mAJk7Ip0+3NUhFUmrPsYpt8RQRWLq2o8OkicTye2LVnMt7U1wYOqSNgZY9nP8VTjqJyDQ4657yD
	uw6rc4mWAOyENzHreKDA2ciY8jkLrlFDBTqlAxkT4StkMEt6GPR7tbJZJ6oEx9CMphjBAIoAe3b
	zt5vbLdRQ26Iuv9pL3Es1Lq15+KXWyMBATrUYri4/GrdlN288TgQ9aNwBCp2gtLK8yPwtU+37f/
	8NgXrfutCnufd4WLPTj+VX8YbTd4VzlrdQG7y1OrXdgdcDv+Pmi/YdSxeGQZxkB2OKUug/7Dds7
	SlpcgOImsabiUNcUddz4LbT25FQMA1iT8Z80Aa30F0gaHVghyCnmO/qsFvkiiK4wductDk7Likp
	jXTriCEi71jB0DZu4F3T6F+c3BVT0cRN/fEhTqkInXse0LWQZS4oyYybFAvcSU
X-Received: by 2002:a17:903:2f4f:b0:2b9:cd2d:6f14 with SMTP id d9443c01a7336-2b9f25343e2mr43703005ad.2.1777758855137;
        Sat, 02 May 2026 14:54:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae1e293sm60508315ad.45.2026.05.02.14.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:54:14 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: dsa: yt921x: Add port qdisc tbf support
Date: Sun,  3 May 2026 05:53:10 +0800
Message-ID: <20260502215314.917687-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502215314.917687-1-mmyangfl@gmail.com>
References: <20260502215314.917687-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 208DD4B38D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Enable port shaping and support limiting the rate of outgoing traffic.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 138 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  66 ++++++++++++++++++-
 2 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index fd1fdcd5f9a3..9560fb2b8657 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -24,6 +24,7 @@
 #include <net/dsa.h>
 #include <net/dscp.h>
 #include <net/ieee8021q.h>
+#include <net/pkt_cls.h>
 
 #include "yt921x.h"
 
@@ -1272,6 +1273,19 @@ yt921x_marker_tfm_police(struct yt921x_marker *marker,
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
@@ -1378,6 +1392,115 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_tbf_validate(struct yt921x_priv *priv,
+		    const struct tc_tbf_qopt_offload *qopt, int *queuep)
+{
+	struct netlink_ext_ack *extack = qopt->extack;
+	int queue = -1;
+
+	/* TODO: queue support */
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
+
+		p = &qopt->replace_params;
+
+		res = yt921x_marker_tfm_shape(&marker, p->rate.rate_bytes_ps,
+					      p->max_size,
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
@@ -3524,6 +3647,20 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
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
 
@@ -3680,6 +3817,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* rate */
 	.port_policer_del	= yt921x_dsa_port_policer_del,
 	.port_policer_add	= yt921x_dsa_port_policer_add,
+	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* hsr */
 	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 	.port_hsr_join		= dsa_port_simple_hsr_join,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 546b12a8994a..0114a89b58b8 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -521,6 +521,12 @@ enum yt921x_app_selector {
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
@@ -531,6 +537,48 @@ enum yt921x_app_selector {
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
+#define YT921X_PORTn_SHAPE_STAT(port)	(0x356000 + 4 * (port))
+
 #define YT921X_EDATA_EXTMODE	0xfb
 #define YT921X_EDATA_LEN	0x100
 
@@ -556,6 +604,11 @@ enum yt921x_fdb_entry_status {
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
@@ -573,7 +626,16 @@ enum yt921x_fdb_entry_status {
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
@@ -652,6 +714,8 @@ struct yt921x_priv {
 
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
+	unsigned int port_shape_slot_ns;
+	unsigned int queue_shape_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
 	unsigned char cycle_ns;
-- 
2.53.0


