Return-Path: <netdev+bounces-232903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0214C09D79
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974253A9B77
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE566303CB4;
	Sat, 25 Oct 2025 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob5jkLdK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33160304BD3
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411992; cv=none; b=LUZj8n5IvqO+kIUYpZTy2doOBziC0OKHZLFdMfWLcQKSNFaFfP62J1T2qF6NGge6rvobUktmoy9CXoSG2W6k1m/BAods/zerP7d5e4uWD9qHtiw5kbUVQ292LbZMwfNBn/ZVLymTVBSaJ4Ic3Wtihjn2XE51EefwgJFfgQmkCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411992; c=relaxed/simple;
	bh=2dxQC3wyZueaMEnOwoWXRHlFpSs6OgygyE9+UYsElzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ6726qXYC2uqKgsB3aSN/hGiqagWKxnSaEGGXmdDgxs6BtiKTzh/A0Eew88VKOgMDLs2yDRPbTIvvnQobp9mQzOxNbrYD3ClV+RUy7iVg18LyqiSI8OQqoVM0E0n7sYNhliR8iEzhaVclkn99KpNPnukHNSAo/8102VNPYq7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob5jkLdK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso3517819b3a.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411990; x=1762016790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM3FTCWkFUdaa4aFlf56htgtPRFQ9+Op0+Uy5qhWdhc=;
        b=Ob5jkLdKx6Id5iq06NN21xEoAghR9UfQzAfPQczQhW7oR4RgAr3MBi4/Y/Pgtp7cVl
         n6UgWWgitiSK7AZ73Qo6t8LrsM++vVTkZ7OlP4m0I+RTSISxuy4zQ9NpxfQNRqbVNn/E
         nUTPMis1U8gQ7Ff1sDkTRNTAOeeJoTu+DKfmYpcJoJYvrbhcvGRdm6CCRJyTMFyN4EsH
         8vgIOF+sZZdIht/ycYbE0Kpe6YQJN71DnApvwCByKAh2maABPm7yRq2bm+0sZMcxAuq1
         UY0a94NLbwPa87rq0bYBRh+tJdsJPOp2ZtkemTcB1ulUP9vNMW+CVh9AAydwpclIybWq
         2F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411990; x=1762016790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM3FTCWkFUdaa4aFlf56htgtPRFQ9+Op0+Uy5qhWdhc=;
        b=DYvP23HzLjLSSRmRxtAqOsyxkp6euJ4srGPUCgYvNGuDjNSLRgZBa3U7FZqdh3lHPO
         Nc3XT++DNmk/rPg8wQQfzqfLS4gNGFl/ncZeXU/U5WeqTyhJ1J5c/1lnfh+vW2lUag9v
         SMVxEfOL1c01ZKrQzXrK7ZsSr6DjRGudSpMrjD0O1bTMXZS4gU9O69Durx2BcZYm2r6L
         Dg2iYweeglCeYm5Kz794XaHzt9k3frx6s0cK6H72pr+PIN8Hx/BiAGeJ1U8/lYiOZ6tE
         ZIrbcCYaJKh/gsKyJLeup6CaWloOEOlwbTCoAdRBiEfHa86tiQnz9waQPo9hfkMDgEMn
         TVzg==
X-Gm-Message-State: AOJu0YwbXzIZSmaW6NT/Gd9gaiXJaTiP9yPiqx7CtMiI1qIGcpnxQyzj
	6ew7hC3IQn+XHh/1kGQnYWUln/71CDY8t2Aqe/E9gJv8KX4db1EfwKzhkI1YiDzM
X-Gm-Gg: ASbGncuFD068k1/Yi3s+B7cBk1XpseGSA/fCAOpVzt+AL7wtsrqjNKqr5BFf3JtQ2bJ
	mDGcfcjoBd3gGjaMLSelpAUJ17mC5a5mdQxEA2yuSlW8e8eAuXWEF1HpGvkH7i4Tc3Utjyw+7kR
	ZzgmEN0u78lUoLyvz+H2cRaqYObf4nbV3xdJDy+YWy1q8myIHTZBKO15iymvLi0ip6WBBAEwLqL
	Zr5jqY0EKNdeTD2Hr1xjrCvC05JKtzmf3A5oC8mftFozerFyQtkAYJNkN/HMoQpM5jvl3Q+TUPq
	carruVRj5RkNyeKyNM1+g0TQNgJRqWMsxSmypF8AIbIEGYUnXC/bWTLMt/mC4r0u1JCjGxu3QuL
	/uHHQPGvihkZqjo8O/gCuVDvPhGhhkfG8L8++ZPDfiB02fk6Apx3u9gyvE+bLuq73pz1+ZyT7FW
	y0WBj8DCldtqIpKgNoJA==
X-Google-Smtp-Source: AGHT+IENyejyeawlBEItrvmhxyRV78AAC7HJ7ORCzzVMdYH71cv2wGWnnAwQWzE0xmst5RUKdrjEvQ==
X-Received: by 2002:a17:903:38c8:b0:276:76e1:2e87 with SMTP id d9443c01a7336-2946e22bbcfmr114585715ad.44.1761411990123;
        Sat, 25 Oct 2025 10:06:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:29 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] net: dsa: yt921x: Add LAG offloading support
Date: Sun, 26 Oct 2025 01:05:27 +0800
Message-ID: <20251025170606.1937327-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025170606.1937327-1-mmyangfl@gmail.com>
References: <20251025170606.1937327-1-mmyangfl@gmail.com>
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
index 885a63f2b978..1d18d1e89cb8 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1143,6 +1143,187 @@ yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_dsa_port_lag_check(struct dsa_switch *ds, struct dsa_lag lag,
+			  struct netdev_lag_upper_info *info,
+			  struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp;
+	unsigned int members;
+
+	if (lag.id <= 0)
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
+static int yt921x_lag_hash(struct yt921x_priv *priv, u32 ctrl, bool unique_lag)
+{
+	struct device *dev = to_device(priv);
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
+			dev_err(dev,
+				"Mismatched Hash Mode across different lag is not supported\n");
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
+	if (lag.id <= 0)
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
+		res = yt921x_lag_hash(priv, ctrl, unique_lag);
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
@@ -2906,6 +3087,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
+	/* lag */
+	.port_lag_leave		= yt921x_dsa_port_lag_leave,
+	.port_lag_join		= yt921x_dsa_port_lag_join,
 	/* fdb */
 	.port_fdb_dump		= yt921x_dsa_port_fdb_dump,
 	.port_fast_age		= yt921x_dsa_port_fast_age,
@@ -3000,6 +3184,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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


