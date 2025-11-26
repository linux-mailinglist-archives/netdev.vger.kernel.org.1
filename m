Return-Path: <netdev+bounces-241837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D0C88F98
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260853B6F2C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31C31B102;
	Wed, 26 Nov 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI/y+fVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD631A55E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149611; cv=none; b=GFdpNbC5H9THaChdcfC8pNWnGzcR8IRmBqqVRw2mmEhYmGqdvI1MShecmM+0RUxjDROOKTmzuccaAPM/yPLeINZdtkN3hi26ywH1AmoHHaVVgfJ0YDEz4yUP08I79fGSFmS1Snbk9rkZ2tDYjZyNrxRayfPmGOfFD4mU3UGa/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149611; c=relaxed/simple;
	bh=ZTM0QJuUZycfuLi8Cz6pRi9vK6GKp41jf/OVUW+nA/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXDQsjTmWfFC/+gF9lzS5fY0jEo3LjID9fEd0lsbQUBH/Jrrmc1v7nGrhah79Qu6T9YqED4inAE/u5lS8nuxBc67fW6owIrcOsP60+vQO8pVRjcvSuuIE0VWxXIFNCq2fvlOn1Fl4HIg37dLdvntcJRGvDgx7rC4R6IlTX2rGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI/y+fVf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2956d816c10so75620665ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764149609; x=1764754409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJRzhSEBj40vJG51qMX+dPArFTafJMlPn4v/oTWTn98=;
        b=nI/y+fVfkdyvyvZfR0G5W5OZkj/L8ofLZno9L/uK97EIEocYp3NLPoCkg9rxZSSKVf
         lv3J/0vO5tugkJBt/+RPQd9N5kMrARJjD+sUdp41YvnhHDzLpPYELp1k8mXimtlGmQxN
         Jx/R82nT5DrJRm57KPpA6z9/GARHvBhZ/mSv3JzaHV49vwt4D5hTO/MFE1Dj8K+4bBID
         p31hL9WHHVlshhwRYqHAnjRa/+XZHjQSHyp1h9ifcw2pW7Ozu6bO7sCQ0lmgI60M1tdx
         VO2B5wBSDyXY9IdPWE1v8ZXD2vLg+ntHYFPVjaXtzjSEDrlN3izIwT8OiUSoafsxxz6Y
         Qfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149609; x=1764754409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJRzhSEBj40vJG51qMX+dPArFTafJMlPn4v/oTWTn98=;
        b=QIpIlhBJptXo/2oPWXSNHU9QWUT3uBxCTbdNZfbiKXZb4C/AOLq3hlwWzHnInRwia3
         zyDQzZMTUFA0n9XXdaM3fa/JzfxGvFaGVLTT6pd31dzvSRh9iWu5ue3dfZGB5y6wN+KC
         tIgCO6DO7yelYWLo90xIqkgmVnGpLcZ9sANCeyzgmjDfAfYDH0NUrPD0UhvNQ9hocSSQ
         ra59cGMJJsORPmeWyhoj5SCAlsmyKNLioOrZYcrnK+pwHv8zwt9chiG/vQvYSOw/BakR
         AJjG317dHZBm4dE921v5U/7wqe+nDqbIUo0iPg0s2OLB2Uv+60DrCdC3lvxssi69PArq
         kQ2A==
X-Gm-Message-State: AOJu0Yz4E7FGKCYw02GiOUN5wO6QapEraQxXipIg/p+2zkcvm7HUd6up
	bNfEZEdc5z65OvC3XDQsxGzkjDXrFA69CLbUwXfycFFcMhDftJY7iBwPWeBmCA==
X-Gm-Gg: ASbGncsmHhpDEo9QgIP7dQsRC3yiMHhCF/Huxk6gpWJehraCXp2IICDRmNsfg/bShUu
	IXV0jmwnwM3msmb2KPitsaBHhPfo7LDkuvF6BeUDsUVVLDwuAhFUZXqV3k3tmI4Q2b6fb5AXD4a
	fm3SaxPmLw2msaoT5+afWnqixpRyJZdkKQkBILDqt/Jqmi1VNNMJ/0/y+1kBnOQRk4eEOG7isTY
	rPfTWyKNM5HpWPm8imSbLNovHxKO0qu7x1YWuIIra3oqaahwn86G1neSf+/6jDoUEe2L9yWscKj
	qMRu9U+U7y1wW6xF6Dw+vIP5vSvXNWPNhXybzyOm2kdkPp7po7sJuCy39HfxWdCnauAIuSxVbbI
	tN7EKvWuMeOkfzjWZfLxR7MMQ9XWTxs//n1yiODOJiUaRyDugfSt+2nc8Xe3HyELkT3m2x4pIT0
	KDusOSoudHYUI22jCwRA8T5g==
X-Google-Smtp-Source: AGHT+IE8UZZry4bkrIVBcjhFkIMJ/aRCCU5sVXGFT+PnLVbKlRefFAAUuCa7f3nJaWxw+2KFAmBjrg==
X-Received: by 2002:a17:903:8cb:b0:295:70b1:edc8 with SMTP id d9443c01a7336-29b6be917a2mr223905635ad.2.1764149608678;
        Wed, 26 Nov 2025 01:33:28 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b78740791sm132101735ad.56.2025.11.26.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:33:28 -0800 (PST)
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
Subject: [PATCH net-next v3 4/4] net: dsa: yt921x: Add LAG offloading support
Date: Wed, 26 Nov 2025 17:32:37 +0800
Message-ID: <20251126093240.2853294-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126093240.2853294-1-mmyangfl@gmail.com>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add offloading for a link aggregation group supported by the YT921x
switches.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 185 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  20 +++++
 2 files changed, 205 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index e7b416719b58..609dd38adefc 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1143,6 +1143,187 @@ yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int yt921x_lag_hash(struct yt921x_priv *priv, u32 ctrl, bool unique_lag,
+			   struct netlink_ext_ack *extack)
+{
+	u32 val;
+	int res;
+
+	/* Hash Mode is global. Make sure the same Hash Mode is set to all the
+	 * 2 possible lags.
+	 * If we are the unique LAG we can set whatever hash mode we want.
+	 * To change hash mode it's needed to remove all LAG and change the mode
+	 * with the latest.
+	 */
+	if (unique_lag) {
+		res = yt921x_reg_write(priv, YT921X_LAG_HASH, ctrl);
+		if (res)
+			return res;
+	} else {
+		res = yt921x_reg_read(priv, YT921X_LAG_HASH, &val);
+		if (res)
+			return res;
+
+		if (val != ctrl) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Mismatched Hash Mode across different lags is not supported");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int yt921x_lag_leave(struct yt921x_priv *priv, u8 index)
+{
+	return yt921x_reg_write(priv, YT921X_LAG_GROUPn(index), 0);
+}
+
+static int yt921x_lag_join(struct yt921x_priv *priv, u8 index, u16 ports_mask)
+{
+	unsigned long targets_mask = ports_mask;
+	unsigned int cnt;
+	u32 ctrl;
+	int port;
+	int res;
+
+	cnt = 0;
+	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
+		ctrl = YT921X_LAG_MEMBER_PORT(port);
+		res = yt921x_reg_write(priv, YT921X_LAG_MEMBERnm(index, cnt),
+				       ctrl);
+		if (res)
+			return res;
+
+		cnt++;
+	}
+
+	ctrl = YT921X_LAG_GROUP_PORTS(ports_mask) |
+	       YT921X_LAG_GROUP_MEMBER_NUM(cnt);
+	return yt921x_reg_write(priv, YT921X_LAG_GROUPn(index), ctrl);
+}
+
+static int
+yt921x_dsa_port_lag_leave(struct dsa_switch *ds, int port, struct dsa_lag lag)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	if (!lag.id)
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_lag_leave(priv, lag.id - 1);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_port_lag_check(struct dsa_switch *ds, struct dsa_lag lag,
+			  struct netdev_lag_upper_info *info,
+			  struct netlink_ext_ack *extack)
+{
+	unsigned int members;
+	struct dsa_port *dp;
+
+	if (!lag.id)
+		return -EINVAL;
+
+	members = 0;
+	dsa_lag_foreach_port(dp, ds->dst, &lag)
+		/* Includes the port joining the LAG */
+		members++;
+
+	if (members > YT921X_LAG_PORT_NUM) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload more than 4 LAG ports");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload LAG using hash TX type");
+		return -EOPNOTSUPP;
+	}
+
+	if (info->hash_type != NETDEV_LAG_HASH_L2 &&
+	    info->hash_type != NETDEV_LAG_HASH_L23 &&
+	    info->hash_type != NETDEV_LAG_HASH_L34) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload L2 or L2+L3 or L3+L4 TX hash");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_dsa_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
+			 struct netdev_lag_upper_info *info,
+			 struct netlink_ext_ack *extack)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct dsa_port *dp;
+	bool unique_lag;
+	unsigned int i;
+	u32 ctrl;
+	int res;
+
+	res = yt921x_dsa_port_lag_check(ds, lag, info, extack);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	switch (info->hash_type) {
+	case NETDEV_LAG_HASH_L34:
+		ctrl |= YT921X_LAG_HASH_IP_DST;
+		ctrl |= YT921X_LAG_HASH_IP_SRC;
+		ctrl |= YT921X_LAG_HASH_IP_PROTO;
+
+		ctrl |= YT921X_LAG_HASH_L4_DPORT;
+		ctrl |= YT921X_LAG_HASH_L4_SPORT;
+		break;
+	case NETDEV_LAG_HASH_L23:
+		ctrl |= YT921X_LAG_HASH_MAC_DA;
+		ctrl |= YT921X_LAG_HASH_MAC_SA;
+
+		ctrl |= YT921X_LAG_HASH_IP_DST;
+		ctrl |= YT921X_LAG_HASH_IP_SRC;
+		ctrl |= YT921X_LAG_HASH_IP_PROTO;
+		break;
+	case NETDEV_LAG_HASH_L2:
+		ctrl |= YT921X_LAG_HASH_MAC_DA;
+		ctrl |= YT921X_LAG_HASH_MAC_SA;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Check if we are the unique configured LAG */
+	unique_lag = true;
+	dsa_lags_foreach_id(i, ds->dst)
+		if (i != lag.id && dsa_lag_by_id(ds->dst, i)) {
+			unique_lag = false;
+			break;
+		}
+
+	mutex_lock(&priv->reg_lock);
+	do {
+		res = yt921x_lag_hash(priv, ctrl, unique_lag, extack);
+		if (res)
+			break;
+
+		ctrl = 0;
+		dsa_lag_foreach_port(dp, ds->dst, &lag)
+			ctrl |= BIT(dp->index);
+		res = yt921x_lag_join(priv, lag.id - 1, ctrl);
+	} while (0);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
 {
 	struct device *dev = to_device(priv);
@@ -2907,6 +3088,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
+	/* lag */
+	.port_lag_leave		= yt921x_dsa_port_lag_leave,
+	.port_lag_join		= yt921x_dsa_port_lag_join,
 	/* fdb */
 	.port_fdb_dump		= yt921x_dsa_port_fdb_dump,
 	.port_fast_age		= yt921x_dsa_port_fast_age,
@@ -3001,6 +3185,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	ds->priv = priv;
 	ds->ops = &yt921x_dsa_switch_ops;
 	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
+	ds->num_lag_ids = YT921X_LAG_NUM;
 	ds->num_ports = YT921X_PORT_NUM;
 
 	mdiodev_set_drvdata(mdiodev, priv);
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 2a986b219080..0afd90461108 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -316,6 +316,14 @@
 #define  YT921X_FILTER_PORTn(port)		BIT(port)
 #define YT921X_VLAN_EGR_FILTER		0x180598
 #define  YT921X_VLAN_EGR_FILTER_PORTn(port)	BIT(port)
+#define YT921X_LAG_GROUPn(n)		(0x1805a8 + 4 * (n))
+#define  YT921X_LAG_GROUP_PORTS_M		GENMASK(13, 3)
+#define   YT921X_LAG_GROUP_PORTS(x)			FIELD_PREP(YT921X_LAG_GROUP_PORTS_M, (x))
+#define  YT921X_LAG_GROUP_MEMBER_NUM_M		GENMASK(2, 0)
+#define   YT921X_LAG_GROUP_MEMBER_NUM(x)		FIELD_PREP(YT921X_LAG_GROUP_MEMBER_NUM_M, (x))
+#define YT921X_LAG_MEMBERnm(n, m)	(0x1805b0 + 4 * (4 * (n) + (m)))
+#define  YT921X_LAG_MEMBER_PORT_M		GENMASK(3, 0)
+#define   YT921X_LAG_MEMBER_PORT(x)			FIELD_PREP(YT921X_LAG_MEMBER_PORT_M, (x))
 #define YT921X_CPU_COPY			0x180690
 #define  YT921X_CPU_COPY_FORCE_INT_PORT		BIT(2)
 #define  YT921X_CPU_COPY_TO_INT_CPU		BIT(1)
@@ -360,6 +368,15 @@
 #define  YT921X_PORT_IGR_TPIDn_STAG(x)		BIT((x) + 4)
 #define  YT921X_PORT_IGR_TPIDn_CTAG_M		GENMASK(3, 0)
 #define  YT921X_PORT_IGR_TPIDn_CTAG(x)		BIT(x)
+#define YT921X_LAG_HASH			0x210090
+#define  YT921X_LAG_HASH_L4_SPORT		BIT(7)
+#define  YT921X_LAG_HASH_L4_DPORT		BIT(6)
+#define  YT921X_LAG_HASH_IP_PROTO		BIT(5)
+#define  YT921X_LAG_HASH_IP_SRC			BIT(4)
+#define  YT921X_LAG_HASH_IP_DST			BIT(3)
+#define  YT921X_LAG_HASH_MAC_SA			BIT(2)
+#define  YT921X_LAG_HASH_MAC_DA			BIT(1)
+#define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
 
 #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
 #define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_EN	BIT(31)
@@ -404,6 +421,9 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
+#define YT921X_LAG_NUM		2
+#define YT921X_LAG_PORT_NUM	4
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


