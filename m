Return-Path: <netdev+bounces-249856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B0D1FA95
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2C09300924A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50631A81F;
	Wed, 14 Jan 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lafS/C9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D031961F
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403705; cv=none; b=hmJamjy+4MiC4Qn3lUf1Pq2ULvqTAGJq1zZ8K0fTbJ2H6gDslFSDpm66N2WjkZkzrlpv2AefKsxTX49FT+2chopsnrWn5umuMNyqCbTMeFuSLjhsfia3ns7fe3sNU4uJ3pRvLwZkGw8PSunQ3aZdTcnVvl/pOHLs4Zw6zj3FkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403705; c=relaxed/simple;
	bh=1wH8V2j+wy4VhEpErKF298l0LRe75cmFr3dQBz0NpwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fyg2FkB0Y5QH4OELEG1G9BU6hcu0rNdr6ZqIOYo4K0G/azt694nlTgrjhbkUbZPzM/AumwSOwgFkCc8VAuIbcwVAm4ejzKk28o3xHxI1FmTL0dBEK+MagT5pOhaN2eKFVA6YS3id2b9/U/cHj4VyKg53W3MhNfl2GW5lb+WE1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lafS/C9w; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c21417781so5631968a91.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768403701; x=1769008501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piEx1vihU5HF7w/WyGEz6G5tLKFgaNTXAXHJU1BSUQo=;
        b=lafS/C9wyxPYuwz5QXEPGNI0EMsfC7w9KJ1V4LJPUd3sfIBxkksrbatYknrkogsETc
         BRYKvqPp0JZptWLB26/22KNJMBod3t1no2a56JHtv3V+n5yHuNGigncc23D+1RvIlGO/
         eqGyY0Llt+DkjhRkB03ThZZLPPduyhReisgvzaU5chS3yDQN6rnBbkJEhYU3HkDv4zDQ
         vHRIGBQrBGWEpkn6SYBOjMgCV8plvT9wGRWv7SUTQzHsF3usBlZrl9pAb/VKbY58WP7b
         819AEsEFMVjevluSZ3LpRe/y/GWp/KB7HqKWF45zLO3fdy6cJWYWF21+UHW4VmNT8c3X
         FeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403701; x=1769008501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piEx1vihU5HF7w/WyGEz6G5tLKFgaNTXAXHJU1BSUQo=;
        b=a7guNhCcYoUa90Gs0dLCaHqLKCCLQjbeqFmx0wKb3qLZ6ZOT5xIKtuzGnPYNZOaCXn
         +XAjQ/HF4UwixxrrAZlCTDCANojdf9h1/hzQnPNqxTZdu5Y6XuHWAKTSl9xwbUyhGIx8
         D2/vSh8S9fUgS3nFnzpHHVlD4TSBr6qzQUPHcBt2WHT97E4qMNRN3+7vhxC3+s9Z7G7X
         cehZPMv1QFLSoG2eMVwRWn8WK7Cu5/yZ4g2IqQxsrxGoQU/c/Cegw3WwdE4eBnJI7SDM
         lo3wcgVb87e4yakF2hr5LX0D9Lb81ckOTshG9GIF8avXjZSItXN8uB3wD1bqaBlmy5xK
         lE3g==
X-Gm-Message-State: AOJu0YwrRVII8mU3HB4qjsqI+PsB2e331TIGvNqxgv4SqgujiiitY58j
	P8yK45CjXBPkdT1YR91EvH/UdO+DCks8IKQHO9GevaqvGeDx8v8KtD8EnlKiTe+T
X-Gm-Gg: AY/fxX4N2RhnNm3UwNpQvdb/QSlRaVpMhZtD8La49r82hOSGwI1/9aaDvrEdV4Z1Dl6
	4FMUwneUlPNf0XqR7kDr39ut75AL1s+2/7Fvxh4Jm3fjV9PjX/lgHkkcmJTTgbVIU6zuI4vjkSq
	fxicJnqzCPl3+hUglOp/dWuGpp44P1cdmgRxNeFY8hxAW1mXSR1YxZGrYk8GLe7RcHsYLpzhNmA
	Dv7+0oFNf4mHjQYwsnJEzEF1afymiS6bWmJ+l9pIlXjjO3qCwSku1caq8vvtxdm6li8lXb7iL38
	fiwMsa0aQDzu+9tXU4n1kYHDQ6H8ubOs6M+YEnqB3f+uZUDXOIJKPmH/Hbws4tO/p5Qd8q/bKF+
	Ggz7DJ8qOusASivb2pp2QXWv3KxrmbXpMI8Lnzxc6wuE9M+bo2YhTWu2DHCSIyvxcNgTTvf122v
	EuCdH3bdZhqxYXYhNk0R/9s5y7+r8nLVSgx5+RpwFDyGKcKFhsrQ==
X-Received: by 2002:a17:90b:274e:b0:349:2936:7f4 with SMTP id 98e67ed59e1d1-3510b143bbbmr2223164a91.32.1768403700384;
        Wed, 14 Jan 2026 07:15:00 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109c78f20sm2307408a91.13.2026.01.14.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:14:59 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: yt921x: Add LAG offloading support
Date: Wed, 14 Jan 2026 23:14:45 +0800
Message-ID: <20260114151448.253238-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
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
Picked from: https://lore.kernel.org/r/20251126093240.2853294-5-mmyangfl@gmail.com
 drivers/net/dsa/yt921x.c | 185 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  20 +++++
 2 files changed, 205 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 1c511f5dc6ab..11633de91a91 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1117,6 +1117,187 @@ yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
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
@@ -2880,6 +3061,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
+	/* lag */
+	.port_lag_leave		= yt921x_dsa_port_lag_leave,
+	.port_lag_join		= yt921x_dsa_port_lag_join,
 	/* fdb */
 	.port_fdb_dump		= yt921x_dsa_port_fdb_dump,
 	.port_fast_age		= yt921x_dsa_port_fast_age,
@@ -2976,6 +3160,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	ds->ageing_time_min = 1 * 5000;
 	ds->ageing_time_max = U16_MAX * 5000;
 	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
+	ds->num_lag_ids = YT921X_LAG_NUM;
 	ds->num_ports = YT921X_PORT_NUM;
 
 	mdiodev_set_drvdata(mdiodev, priv);
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 61bb0ab3b09a..bacd4ccaa8e5 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -370,6 +370,14 @@
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
@@ -414,6 +422,15 @@
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
@@ -458,6 +475,9 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_MSTI_NUM		16
 
+#define YT921X_LAG_NUM		2
+#define YT921X_LAG_PORT_NUM	4
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


