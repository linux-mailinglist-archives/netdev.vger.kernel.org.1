Return-Path: <netdev+bounces-253121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DTeHhtjdWl+EwEAu9opvQ
	(envelope-from <netdev+bounces-253121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:26:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A87F613
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B11C9300A8F0
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046918DB35;
	Sun, 25 Jan 2026 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx6r08/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532B176ADE
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769300757; cv=none; b=uVnMLg8IIg/n9G7vSn/wVNsuwNpaZMrs3wCDcdR7YaQT6WQVdNkpTF/z0SP4NylP4v909yc0gEOvNYbVLE2gOL4kQc0YdH2FgDx9oBu43seLylf81cVVk/AlK0MnYSH4GO7eAv3lgD1+BYohDiSSgoU2/9vrpZBnrPz6Y2mMLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769300757; c=relaxed/simple;
	bh=Cp9tcEDvZY+rCSt5oJdKKqf8fujxVTz3AeZXH62Fda0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5GoimyGwppNsoBxK+zqb/ZSu73b9wlgs9TLvHKng5u8As2cOwhZk0GI5hpv7ARHdTuEOsLDOWtkPa5cJRQrnuT3mPiXv2ZYMeHMw062mAo06ovSp7BWXCPLtR/h5adVxViUs0WbQ49g85cp4Nu83ErwwAV1rxK+jq9ILvCAmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx6r08/l; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso2337831a91.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 16:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769300755; x=1769905555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWjvS+hgkHY1R8yWAiQX8zpJxH14skCSIGHxJEj8U/E=;
        b=Wx6r08/l9QGuQFlQm9Hj7Dd7n0RM9RcVrJG9RCmP9hQs5r9TAnn9tNZ772e16CBG5X
         q8BogMh6OSg/Z3lvFhhCXBlEBsFM5kzywr1fZpC1FNoTbaPfRN0x4TP2ovByNa2mEnk3
         BpaxW7uoXMJRn0bNCa7Xnmt3pwVZOF5xAPfNNWtHy/yOY2rfZiyX4xJ/L637zeEn/WhV
         NdDbUW9/pybmhoc6mILmxGV1SXE7YmA2TNdKaWeU18BPcb7Ect4QljWTo+Ziq2RIr5QJ
         8pZYT/rx6nuU5PPy2dLRbPYlmHaBGTEDryNNivzvNfM7bT/FP6pqeJaxr5FrzBOxnpSR
         7LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769300755; x=1769905555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWjvS+hgkHY1R8yWAiQX8zpJxH14skCSIGHxJEj8U/E=;
        b=RlsTS2kv4IWlwavBt6jGgJNTY1NYlODqZnTnB4dCCkvZabU/tgKN5WHMMFgrNAgQM4
         585szQRQHNbrIJgFZyhTQMP2jrsLL1zOno6z9Jpc1FzTtkLbWzK4T/6AlF/rxvO0ETZY
         SqRj/CLv/yh6uMp9cSyreit9aFkedbxn0ZIY5x+0+iJnZWI1dxVUvlmobw3xbPhQsMg4
         r9UCXN8tVKP+J2NzqgQ+pKejhJGzlxcBEQt5ujhI749+o8jKPRL+/WHN40PPJatlGxN4
         e0U7gzJs6xCHGeRDhmq7isgp7j9HNOhd8AWxqYwSvDUAcQ3XfQ7KcYz3eVzYnKdRi6bp
         vn9Q==
X-Gm-Message-State: AOJu0Yyetuz9y6YJdBwnwGgNU1acedMz20NNFGve400TOBGQ9XxN/ipr
	payBVwzD/ZWm28Cb8+NC5/UBeV5u7Yx1eZ/gvv1u+zdtltiw1wg44ZskBPsPjg==
X-Gm-Gg: AZuq6aI2y/jwJRea6TqvO8SVstHtigLnw23/3pnIbKqqDEi54W3O/gdVNOeLRb/YggL
	d4oQk3haya8Uv+A3ahnh0YPgsOGSujpNx+PPJQ/v1eyD+p4P0z7nCHJ3CoLkdAPk1CG6cn2iYKc
	AkEbFvCHxss3EiXzM0Vxvys2iCNhKejMzraBmsDcAxX9tO3J3il/vleshYnM0WlGmNKe73GZiOL
	4TxhL1YkkpFjp71HFXjvQsfAOky/lM/jmZ52k2QIgKjqM7EiSZxDbsouip+0gzwCiH0MGn5/A0D
	BFEEkWWXmMpj1P/yMmsK7PyqsiT2lDbtpTcF0GIFXBcsD8XM59Xs6vPZXmEhmZsLg97ErEy2cCC
	mjgA4ktfxiemB5Jv/toltyaH8lH4gmqhRnUK9FKcHf8i2UbamH5T5JbvfEu8Ux0fan9wXEh2pdi
	UEO75Ko7tD+VbMOsvk46FqBSLOLTm0slUTMoFcqf9Pi5bo3kR8Zk1hJA==
X-Received: by 2002:a17:90b:50c7:b0:340:bfcd:6afa with SMTP id 98e67ed59e1d1-353c40b3808mr270430a91.8.1769300755204;
        Sat, 24 Jan 2026 16:25:55 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a1307f3sm5027274a12.3.2026.01.24.16.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 16:25:54 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: dsa: yt921x: Add DCB/QoS support
Date: Sun, 25 Jan 2026 08:24:48 +0800
Message-ID: <20260125002531.3787314-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125001328.3784006-1-mmyangfl@gmail.com>
References: <20260125001328.3784006-1-mmyangfl@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253121-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA3A87F613
X-Rspamd-Action: no action

Set up global DSCP/PCP priority mappings and add related DCB methods.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 239 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  52 +++++++--
 3 files changed, 281 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 7eb301fd987d..24c37cbf70d7 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -158,6 +158,7 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 config NET_DSA_YT921X
 	tristate "Motorcomm YT9215 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_IEEE8021Q_HELPERS if DCB
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
 	  chip.
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 880e3b5966f8..c2a1bc3729b4 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2025 David Yang
  */
 
+#include <linux/dcbnl.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_hsr.h>
@@ -18,8 +19,11 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/sort.h>
 
 #include <net/dsa.h>
+#include <net/dscp.h>
+#include <net/ieee8021q.h>
 
 #include "yt921x.h"
 
@@ -1773,8 +1777,11 @@ yt921x_port_set_vlan_aware(struct yt921x_priv *priv, int port, bool vlan_aware)
 {
 	u32 ctrl;
 
+	/* Abuse SVLAN for PCP parsing without polluting the FDB - it just works
+	 * despite YT921X_VLAN_CTRL_SVLAN_EN never being set
+	 */
 	if (!vlan_aware)
-		ctrl = 0;
+		ctrl = YT921X_PORT_IGR_TPIDn_STAG(0);
 	else
 		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
 	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);
@@ -2396,6 +2403,123 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 			port, res);
 }
 
+static int __maybe_unused
+yt921x_dsa_port_get_default_prio(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_PORTn_QOS(port), &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	return FIELD_GET(YT921X_PORT_QOS_PRIO_M, val);
+}
+
+static int __maybe_unused
+yt921x_dsa_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	if (prio >= YT921X_PRIO_NUM)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	mask = YT921X_PORT_QOS_PRIO_M | YT921X_PORT_QOS_PRIO_EN;
+	ctrl = YT921X_PORT_QOS_PRIO(prio) | YT921X_PORT_QOS_PRIO_EN;
+	res = yt921x_reg_update_bits(priv, YT921X_PORTn_QOS(port), mask, ctrl);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused appprios_cmp(const void *a, const void *b)
+{
+	return ((const u8 *)b)[1] - ((const u8 *)a)[1];
+}
+
+static int __maybe_unused
+yt921x_dsa_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
+			     int *nselp)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u8 appprios[2][2] = {};
+	int nsel;
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_PORTn_PRIO_ORD(port), &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	appprios[0][0] = IEEE_8021QAZ_APP_SEL_DSCP;
+	appprios[0][1] = (val >> (3 * YT921X_APP_SEL_DSCP)) & 7;
+	appprios[1][0] = DCB_APP_SEL_PCP;
+	appprios[1][1] = (val >> (3 * YT921X_APP_SEL_CVLAN_PCP)) & 7;
+	sort(appprios, ARRAY_SIZE(appprios), sizeof(appprios[0]), appprios_cmp,
+	     NULL);
+
+	nsel = 0;
+	for (int i = 0; i < ARRAY_SIZE(appprios) && appprios[i][1]; i++) {
+		sel[nsel] = appprios[i][0];
+		nsel++;
+	}
+	*nselp = nsel;
+
+	return 0;
+}
+
+static int __maybe_unused
+yt921x_dsa_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
+			     int nsel)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	u32 ctrl;
+	int res;
+
+	if (nsel > YT921X_APP_SEL_NUM)
+		return -EINVAL;
+
+	/* Order 0 means disabled - except for port default prio */
+	ctrl = 0;
+	for (int i = 0; i < nsel; i++) {
+		switch (sel[i]) {
+		case IEEE_8021QAZ_APP_SEL_DSCP:
+			ctrl |= YT921X_PORT_PRIO_ORD_APPm(YT921X_APP_SEL_DSCP,
+							  7 - i);
+			break;
+		case DCB_APP_SEL_PCP:
+			ctrl |= YT921X_PORT_PRIO_ORD_APPm(YT921X_APP_SEL_CVLAN_PCP,
+							  7 - i);
+			ctrl |= YT921X_PORT_PRIO_ORD_APPm(YT921X_APP_SEL_SVLAN_PCP,
+							  7 - i);
+			break;
+		default:
+			dev_err(dev,
+				"Invalid apptrust selector (at %d-th). Supported: dscp, pcp\n",
+				i + 1);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_PORTn_PRIO_ORD(port), ctrl);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_port_down(struct yt921x_priv *priv, int port)
 {
 	u32 mask;
@@ -2721,6 +2845,13 @@ static int yt921x_port_setup(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
+	/* Clear prio order (even if DCB is not enabled) to avoid unsolicited
+	 * priorities
+	 */
+	res = yt921x_reg_write(priv, YT921X_PORTn_PRIO_ORD(port), 0);
+	if (res)
+		return res;
+
 	if (dsa_is_cpu_port(ds, port)) {
 		/* Egress of CPU port is supposed to be completely controlled
 		 * via tagging, so set to oneway isolated (drop all packets
@@ -2764,6 +2895,55 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 	return res;
 }
 
+/* Not "port" - DSCP mapping is global */
+static int __maybe_unused
+yt921x_dsa_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 val;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_IPM_DSCPn(dscp), &val);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		return res;
+
+	return FIELD_GET(YT921X_IPM_PRIO_M, val);
+}
+
+static int __maybe_unused
+yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+			       YT921X_IPM_PRIO(IEEE8021Q_TT_BK));
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused
+yt921x_dsa_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	if (prio >= YT921X_PRIO_NUM)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+			       YT921X_IPM_PRIO(prio));
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_edata_wait(struct yt921x_priv *priv, u32 *valp)
 {
 	u32 val = YT921X_EDATA_DATA_IDLE;
@@ -2903,6 +3083,43 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 	return 0;
 }
 
+static int __maybe_unused yt921x_chip_setup_qos(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	/* 802.1Q QoS to internal priorities */
+	for (u8 pcp = 0; pcp < 8; pcp++)
+		for (u8 dei = 0; dei < 2; dei++) {
+			ctrl = YT921X_IPM_PRIO(pcp);
+			if (dei)
+				ctrl |= YT921X_IPM_DROP_PRIO(3);
+
+			for (u8 svlan = 0; svlan < 2; svlan++) {
+				u32 reg = YT921X_IPM_PCPn(svlan, dei, pcp);
+
+				res = yt921x_reg_write(priv, reg, ctrl);
+				if (res)
+					return res;
+			}
+		}
+
+	/* DSCP to internal priorities */
+	for (u8 dscp = 0; dscp < DSCP_MAX; dscp++) {
+		int prio = ietf_dscp_to_ieee8021q_tt(dscp);
+
+		if (prio < 0)
+			return prio;
+
+		res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
+				       YT921X_IPM_PRIO(prio));
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
 static int yt921x_chip_setup(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
@@ -2983,6 +3200,12 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+#if IS_ENABLED(CONFIG_DCB)
+	res = yt921x_chip_setup_qos(priv);
+	if (res)
+		return res;
+#endif
+
 	/* Miscellaneous */
 	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
 	if (res)
@@ -3092,10 +3315,23 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_mst_state_set	= yt921x_dsa_port_mst_state_set,
 	.vlan_msti_set		= yt921x_dsa_vlan_msti_set,
 	.port_stp_state_set	= yt921x_dsa_port_stp_state_set,
+#if IS_ENABLED(CONFIG_DCB)
+	/* dcb */
+	.port_get_default_prio	= yt921x_dsa_port_get_default_prio,
+	.port_set_default_prio	= yt921x_dsa_port_set_default_prio,
+	.port_get_apptrust	= yt921x_dsa_port_get_apptrust,
+	.port_set_apptrust	= yt921x_dsa_port_set_apptrust,
+#endif
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
 	.port_setup		= yt921x_dsa_port_setup,
+#if IS_ENABLED(CONFIG_DCB)
+	/* dscp */
+	.port_get_dscp_prio	= yt921x_dsa_port_get_dscp_prio,
+	.port_del_dscp_prio	= yt921x_dsa_port_del_dscp_prio,
+	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
+#endif
 	/* chip */
 	.setup			= yt921x_dsa_setup,
 };
@@ -3162,6 +3398,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	ds = &priv->ds;
 	ds->dev = dev;
 	ds->assisted_learning_on_cpu_port = true;
+	ds->dscp_prio_mapping_is_global = true;
 	ds->priv = priv;
 	ds->ops = &yt921x_dsa_switch_ops;
 	ds->ageing_time_min = 1 * 5000;
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index bacd4ccaa8e5..845a146deb75 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -269,6 +269,35 @@
 #define YT921X_TPID_EGRn(x)		(0x100300 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_EGR_TPID_M			GENMASK(15, 0)
 
+#define YT921X_IPM_DSCPn(n)		(0x180000 + 4 * (n))	/* Internal Priority Map */
+#define YT921X_IPM_PCPn(map, dei, pcp)	(0x180100 + 4 * (16 * (map) + 8 * (dei) + (pcp)))
+#define  YT921X_IPM_PRIO_M			GENMASK(4, 2)
+#define   YT921X_IPM_PRIO(x)				FIELD_PREP(YT921X_IPM_PRIO_M, (x))	/* Higher first */
+#define  YT921X_IPM_DROP_PRIO_M			GENMASK(1, 0)
+#define   YT921X_IPM_DROP_PRIO(x)			FIELD_PREP(YT921X_IPM_DROP_PRIO_M, (x))	/* Drop higher first */
+#define YT921X_PORTn_QOS(port)		(0x180180 + 4 * (port))
+#define  YT921X_PORT_QOS_CVLAN_PRIO_MAP_ID	BIT(5)
+#define  YT921X_PORT_QOS_SVLAN_PRIO_MAP_ID	BIT(4)
+#define  YT921X_PORT_QOS_PRIO_M			GENMASK(3, 1)
+#define   YT921X_PORT_QOS_PRIO(x)			FIELD_PREP(YT921X_PORT_QOS_PRIO_M, (x))
+#define  YT921X_PORT_QOS_PRIO_EN		BIT(0)
+#define YT921X_PORTn_PRIO_ORD(port)	(0x180200 + 4 * (port))
+#define  YT921X_PORT_PRIO_ORD_APPm_M(m)		GENMASK(3 * (m) + 2, 3 * (m))
+#define   YT921X_PORT_PRIO_ORD_APPm(m, x)		((x) << (3 * (m)))	/* Higher first */
+
+enum yt921x_app_selector {
+	YT921X_APP_SEL_MAC_SA,
+	YT921X_APP_SEL_MAC_DA,
+	YT921X_APP_SEL_VID,
+	YT921X_APP_SEL_ACL,
+	YT921X_APP_SEL_DSCP,
+	YT921X_APP_SEL_CVLAN_PCP,
+	YT921X_APP_SEL_SVLAN_PCP,
+	/* The physical port, i.e. YT921X_PORT_QOS_PRIO */
+	YT921X_APP_SEL_PORT,
+	YT921X_APP_SEL_NUM
+};
+
 #define YT921X_VLAN_IGR_FILTER		0x180280
 #define  YT921X_VLAN_IGR_FILTER_PORTn_BYPASS_IGMP(port)	BIT((port) + 11)
 #define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
@@ -337,7 +366,7 @@
 #define YT921X_FDB_OUT0			0x1804b0
 #define  YT921X_FDB_IO0_ADDR_HI4_M		GENMASK(31, 0)
 #define YT921X_FDB_OUT1			0x1804b4
-#define  YT921X_FDB_IO1_EGR_INT_PRI_EN		BIT(31)
+#define  YT921X_FDB_IO1_EGR_PRIO_EN		BIT(31)
 #define  YT921X_FDB_IO1_STATUS_M		GENMASK(30, 28)
 #define   YT921X_FDB_IO1_STATUS(x)			FIELD_PREP(YT921X_FDB_IO1_STATUS_M, (x))
 #define   YT921X_FDB_IO1_STATUS_INVALID			YT921X_FDB_IO1_STATUS(0)
@@ -356,9 +385,9 @@
 #define   YT921X_FDB_IO2_EGR_PORTS(x)			FIELD_PREP(YT921X_FDB_IO2_EGR_PORTS_M, (x))
 #define  YT921X_FDB_IO2_EGR_DROP		BIT(17)
 #define  YT921X_FDB_IO2_COPY_TO_CPU		BIT(16)
-#define  YT921X_FDB_IO2_IGR_INT_PRI_EN		BIT(15)
-#define  YT921X_FDB_IO2_INT_PRI_M		GENMASK(14, 12)
-#define   YT921X_FDB_IO2_INT_PRI(x)			FIELD_PREP(YT921X_FDB_IO2_INT_PRI_M, (x))
+#define  YT921X_FDB_IO2_IGR_PRIO_EN		BIT(15)
+#define  YT921X_FDB_IO2_PRIO_M			GENMASK(14, 12)
+#define   YT921X_FDB_IO2_PRIO(x)			FIELD_PREP(YT921X_FDB_IO2_PRIO_M, (x))
 #define  YT921X_FDB_IO2_NEW_VID_M		GENMASK(11, 0)
 #define   YT921X_FDB_IO2_NEW_VID(x)			FIELD_PREP(YT921X_FDB_IO2_NEW_VID_M, (x))
 #define YT921X_FILTER_UNK_UCAST		0x180508
@@ -406,8 +435,9 @@
 #define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
 #define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
 #define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
-#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT_ULL(21)
-#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK_ULL(20, 18)
+#define  YT921X_VLAN_CTRL_PRIO_EN		BIT_ULL(21)
+#define  YT921X_VLAN_CTRL_PRIO_M		GENMASK_ULL(20, 18)
+#define   YT921X_VLAN_CTRL_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRL_PRIO_M, (x))
 #define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
 #define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
 #define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
@@ -433,14 +463,14 @@
 #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
 
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
-#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_EN	BIT(31)
-#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_EN	BIT(30)
+#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
+#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_EN	BIT(30)
 #define  YT921X_PORT_VLAN_CTRL_SVID_M		GENMASK(29, 18)
 #define   YT921X_PORT_VLAN_CTRL_SVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_SVID_M, (x))
 #define  YT921X_PORT_VLAN_CTRL_CVID_M		GENMASK(17, 6)
 #define   YT921X_PORT_VLAN_CTRL_CVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_CVID_M, (x))
-#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_M	GENMASK(5, 3)
-#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_M	GENMASK(2, 0)
+#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_M	GENMASK(5, 3)
+#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_M	GENMASK(2, 0)
 #define YT921X_PORTn_VLAN_CTRL1(port)	(0x230080 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_EN	BIT(8)
 #define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_PROFILE_ID_M	GENMASK(7, 4)
@@ -478,6 +508,8 @@ enum yt921x_fdb_entry_status {
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
 
+#define YT921X_PRIO_NUM	8
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


