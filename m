Return-Path: <netdev+bounces-250711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BCD38FC2
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 614963025D8C
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA42264CD;
	Sat, 17 Jan 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1FyPzCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F31E3DCD
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666903; cv=none; b=EimltVOIXfpYpIHyfNEDbxf447V2k6XfNlfr97DkBI4zMwIOrOV9Bj8vY4NxpEGGX6lGhONfyJBXk8uLIXu91x72GE9D11Ng4ez8yoNVyz50e4D1V/X6DbrIX4nF1WnrMoilcuccSJhJ7oFii7574/A/USB/wDoExJKfJdHeLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666903; c=relaxed/simple;
	bh=jCjfFiQQRow2LuNKfBPUxtPVHT++GzLVY0iVKZwf8hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVuk+Q7CP/1tG3DsIVCVvYMwKa2gBPmF1euDdhuZuPFB47MT7QPjs1BvL+FHfKmzq1NUrVEdJanfwtAgl1vviZKkwT6f3BXl0BU7Zh6fUlSNRx6oW2rTpfK9pxyN9xA8I2AWTexpvtR8p6DREVt9yHTATeVpXlxMQaHA4XvHH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1FyPzCQ; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1957380a12.1
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768666900; x=1769271700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMYIlq/oU2j1/VQrtCuEay5CG2cw1Y9WblK4zT3sU4c=;
        b=I1FyPzCQruYDA6fLGf6yTZ8xHE3lzclHSue9VlORESic1heLT29/5iEVQFV5tOnw2F
         3utIUeheJw4zQQKrJ9Yz//tYV7p4I6qWQGU5wVMcn8w3liLaCiM6OSn1iEoU952Tvalz
         Fc5zQ5n7EwHNo1gqvatAj/LLXhC+pjb0lHBxVRli20hQnce/Wys+D5QYcwHPhWhNYQ05
         O3eTkMrZmgr15jcB5PRraRfxmmQpFAEKKmugHKC1wMZeQ7Xwu44B39hHcujuJ/UIIg63
         TNAsB44sB/q+2JKxYgaJWLhWUSOp7Hsniouut/QnkmTODC8FS5u8D/380aeyYN2ChqVp
         JmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768666900; x=1769271700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMYIlq/oU2j1/VQrtCuEay5CG2cw1Y9WblK4zT3sU4c=;
        b=KZE0jFV3qCcP1q+JEl1uVUhLRhOxf5GCbzOWvwvU4G+Ra/XqmET8y9FuSXyx+R62nW
         WSGlME5uWfHsaBwYQL3cCcB2Q9vozAJWRM3kDDt5MdRfgVIOdIpUz+IIAT46WMXugjuD
         bDMzYqjoD11xlOA6ryuqG17bCUm5jMdTwc1TM3cLzgVoeWoLWR184znr0bEYDUG4yBfD
         OeZLrRVD37gLkE7hF8Xht86gdfmUPfwytcOO3GZOZ+YaOWrL4pV28WjEU8y2d7rN8HKe
         pIkKtKv5wcUC04HN455C7eta8zQa4j6VStBAq38ciyDn9zsSHuD9/N7kL6+tPu+MCU5O
         iYcA==
X-Gm-Message-State: AOJu0Yx8JxlBT29SXaQGDhmWJiue+PWOwNnQsCFitVwSjyxlSzZmfNvY
	lOHNC7Xx+hiHSsqd1XhwDfvHEyzY2qBY3qOCRIdX16BebGpuaduUeGLQA+hK+xaS
X-Gm-Gg: AY/fxX6q3aNTp6Vm4M0A8OLD9N3jLN4vE5qtXjxDDenSNPCLsxzr72fpmWmmQ119cXr
	YHAjliI45UH9gTtiKmEhwa2usIccPRmRXtMO5ztGuT6Jsg5u3Bpe2IJ11PR2bbo2vG7XN4VU5RU
	NxpnFCNr7q1cOgeC87EmgS7mSm+IDY0926OwIhRU7MTxMBomXZaF56Umr94AAPnyzrtothbVk2f
	R1/6iy54+aKrC+ld74bwNbaHqCNT7CtBAAQMoqgTX/jzehS88U29DgtMXDuWA1HoCJXifBk0WDV
	hHEdMZ+ozm+xWY+UAbGwm2r+JmlNjVV5qHcyUWslBgfL2EHEcOJsEEcM6pA+zbZ1vpEM5+F1eE6
	+fZAxcOaLZyiMizD6psT5wrfy75Rf+U2nhq0NB7hhyxI8bk5xJLhid99ivdNISCDtIXN6dc1Y4r
	mlnQafeybjGQCLyGNTB7TmvJ18iOONp5V/3BZSAZLEnFxw6ry4nw==
X-Received: by 2002:a05:6a20:7490:b0:36b:38e0:4bf5 with SMTP id adf61e73a8af0-38dfe7d6e0emr6769749637.51.1768666899703;
        Sat, 17 Jan 2026 08:21:39 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b50fasm4828248b3a.64.2026.01.17.08.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 08:21:38 -0800 (PST)
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
Subject: [PATCH net-next v2] net: dsa: yt921x: Add LAG offloading support
Date: Sun, 18 Jan 2026 00:21:11 +0800
Message-ID: <20260117162116.1063043-1-mmyangfl@gmail.com>
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
v1: https://lore.kernel.org/r/20260114151448.253238-1-mmyangfl@gmail.com
  - fix malfunctionality of port_lag_leave
Picked from: https://lore.kernel.org/r/20251126093240.2853294-5-mmyangfl@gmail.com
 drivers/net/dsa/yt921x.c | 186 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  20 +++++
 2 files changed, 206 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 0b3df732c0d1..a4b346ddf8dd 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1117,6 +1117,188 @@ yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
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
+static int yt921x_lag_set(struct yt921x_priv *priv, u8 index, u16 ports_mask)
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
+	struct dsa_port *dp;
+	u32 ctrl;
+	int res;
+
+	if (!lag.id)
+		return -EINVAL;
+
+	ctrl = 0;
+	dsa_lag_foreach_port(dp, ds->dst, &lag)
+		ctrl |= BIT(dp->index);
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_lag_set(priv, lag.id - 1, ctrl);
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
+		res = yt921x_lag_set(priv, lag.id - 1, ctrl);
+	} while (0);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
 {
 	struct device *dev = to_device(priv);
@@ -2881,6 +3063,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
+	/* lag */
+	.port_lag_leave		= yt921x_dsa_port_lag_leave,
+	.port_lag_join		= yt921x_dsa_port_lag_join,
 	/* fdb */
 	.port_fdb_dump		= yt921x_dsa_port_fdb_dump,
 	.port_fast_age		= yt921x_dsa_port_fast_age,
@@ -2977,6 +3162,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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


