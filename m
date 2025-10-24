Return-Path: <netdev+bounces-232344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE53C04434
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B02F84E9367
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331E27C84E;
	Fri, 24 Oct 2025 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAvBUlXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553627E7DA
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276797; cv=none; b=uVcf0HAcuU63f3TPc3DkY/08mU1pdhCh7wALjrSRFgTyHYsdToaENnXGW+RLSh2Z3fkdhqhv2rLgn7X3/p1UQRMCjFTqxdwDuwKCjN071prfJ0LED540Nu53n8iE37URRcBr8JV54Jqvs+W+HMFxlStl1y367uTm3jVWikqp9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276797; c=relaxed/simple;
	bh=8mNRaktnDZjddf/hiIoTFG8PZJH/DelAI5SfSfgclQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6RSY/MeVIRJmeRHEDR1RBvoX44fOvFDSb+LeqvYTPH7iCtGCeMBXC4iKiV6IL4uq51Y1LXJcNEvzCHZLX4VPg4y4p8rRoA7azzBfOuWGOY/ZRQeFPpOxR7iQXal0d2O9yo7jlseBzO3fZSV6Z51Og24Jp25fVZMB35CSRdONxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAvBUlXI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so22872985ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276795; x=1761881595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrFID4/+UrIHKrArhdAdtN2WsYEUYH8YfC3PSEJWy08=;
        b=EAvBUlXIbo7Y2qgb0X4aF3PWC56LaBW5Mff89Cb0g4PVseDhwNPSeLeGXU4wReIVhc
         rISojbBT1QZnIvKOtYSuC9a8myv1BSbZFEvAfqNcvmR3qIyynP89op3lyJ07gTelreBx
         Ys0B0yBGSQqgnAXA2v2y18JXONNRBsRx16K/CcUloiy+aVFVBZxT1yMgZlywb1wIBTq+
         psrfE+TAiQZztcgrJq1K+ogb+crDFB/UMqV9OVLPXgG8eGJ8aHAGD23uLmftEZ3WLLmM
         YotrM2VKOF7M7/Q83EkyL1Y2ybuHN7H5NHrWb2CVoJ9WdCNaIo1m+6gQHRRsRkpSxuW6
         ulbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276795; x=1761881595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrFID4/+UrIHKrArhdAdtN2WsYEUYH8YfC3PSEJWy08=;
        b=QRleBP6Y15Ut2kALuIW7yQ9Gq0YP+d/44g5b1zSTnzJf/rtcOU4rxEjRgsuF7/Defy
         GckT/hicQaYmcxWKfq3ATr7kpEaqkFiDGMv3RyGniA432RKJdW0nipatzxZDAFFpCDSc
         OJGYQlba+bxiB3wt9K6SumjWhXpT+nWnVrYZP8l3JSei5ONh2e5qufQ8ejxVtH+GWTHK
         AzaQO00E/i5v4G+sgrDriuddaTaD4aiklc9sVJY/a5J9JWr5uzg1YDwUPaHYs9THjol7
         DMJR4fg4tYCTm6Tt956Y8LDw43aTZ0MVYlktxQF/lLSGjOoYuNYQCWIZkO2u5wXcfBqT
         mqtQ==
X-Gm-Message-State: AOJu0YwhIUQ2KE9fzq221Gp/CyxJmzZPiOmXpUz/9P4fsTz0iMwGAwu5
	DM1VYjNQULT3Xcfv1iafY7OeNFDafT6CoWdUCLkmLnMJXzKQSQfhq3mppd8qZXGLyBY=
X-Gm-Gg: ASbGncuXAYVESQ/JZPihu/4Et15N8jobil0ti6+xfOReebs78sD3CQVjnVOxkgWYxJ1
	Mt5EKB6mJ3BI5RrbJE6MjvWEp1bU6w/sxrzEglXeoILHUGiSiKUOL5LRM5bI69/fuydohjXQUHo
	1fQZ/LzLEjjpvAc8Wm52QcAUgKCfScYOWxtI9zxRaCTS0qqzFv0F6ijE+jg8mia/hnsMOus47+k
	72UgEuVZvEpcPGYBErmEnVlO6H/bQO66LBUjpZZefsmJSM2GUVv58vH8E+7tDUNkj0uydjcVWep
	8bMRc0CkjT2u3Dvr5xQ0bwkYDaCqKqV4nUoBxGWeTje0hJosJSRhgGGx2YbeCpgtOXPlkStIcRY
	zFEe0/kGm3Fo/CjhoaKQvMRhdtk7W6BZn8Mcm2IqicysBYctByoHLVbPNxOgR3TdJupMRtjRB1b
	wiWJ6DmZ0=
X-Google-Smtp-Source: AGHT+IHI7r04yzhwK69K8rpawCPYb5WS526gHAvbUvZIVfklkumt4Vvr9D4Cs5WO1JuhFqNs0o/mig==
X-Received: by 2002:a17:902:cece:b0:292:fc65:3579 with SMTP id d9443c01a7336-292fc65380cmr132461465ad.17.1761276795074;
        Thu, 23 Oct 2025 20:33:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:14 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: dsa: yt921x: Add LAG offloading support
Date: Fri, 24 Oct 2025 11:32:29 +0800
Message-ID: <20251024033237.1336249-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024033237.1336249-1-mmyangfl@gmail.com>
References: <20251024033237.1336249-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/yt921x.c | 184 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  20 +++++
 2 files changed, 204 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 885a63f2b978..406e972c4cfb 100644
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
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3546a94f380e..5e6dcf741e31 100644
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


