Return-Path: <netdev+bounces-241835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE9CC88F7F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CF1E4E2A29
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE0302749;
	Wed, 26 Nov 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz16Cttr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C462F83DB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149605; cv=none; b=e+KwTOLTowgY/ZmZDDGCu+gGwe3Wb/gqIBlM3/mgQqctIDOpm20CBIQGbBE5AxyEt+MTn2juPa+QiC2rOG+ChnLFS6mJLiUSPQnZ4L+X0g5BOo66rWu8i13UZ1j3FsyK25Dpt1PDvBgTw0Ag5cVHRuCmv3tAB67CXGih7Skw9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149605; c=relaxed/simple;
	bh=gNUpBA9c2Pz02hjTEKFBL5eTpwkIvueigCWLibEbcbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1Iz4bXjxr7DTyAnsdGtVYmHzypI7LLqm4dhjNW7rd0BfzaCo4Bkt4C3VttAkpozC+CbgAL7hUW0d8U2Fs5+wIz+ou+vG5aEvLju40jJfr2HmbO4/P/LgMtEvmUlgxAsRhsBy/UiI8oSx6zpuGEP9ifeUhkn7mTXQX4HibvLEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz16Cttr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2984dfae0acso102038425ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764149602; x=1764754402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EBg/2pwllvFAyTVpIevNOA+M/71rW550rNi/OLZk/g=;
        b=bz16Cttrd7UTfS6qPJWYhMTJKQlImWXABsRa00JO7sqzwS8UUn/goZly0oRdLJr/Fw
         nc/cpUMwMoC7pDHhQfD86ga7vuika8L4Rz9RqzujMY3gT0p0CdEQW54ucDDQVT7sEYHQ
         n2JktmCg466sfpQDTvdxeLb1q4Z1PJBN5vzp4cltfenJ0S3nTsGT+3ZvF0542S63mnvg
         IZhBPqLXNXmeAj2q0ve8KXk2cVX3SgTocHQneIO/PlyGjKLr3H6RVpiSwsdhrbGtOzms
         zYtKVc0aKD6L695++S7MSlBQLsdEH0rsS4Pm531GpW2Q7QR1DmbFgFGeSVDBXb5JeZHe
         zJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149602; x=1764754402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6EBg/2pwllvFAyTVpIevNOA+M/71rW550rNi/OLZk/g=;
        b=S3fRRFOQYP3DoNkkBlR8r1rXwCUiisunzA79DBXcUamN0t5oqdcyu9mvFr7Bc/BNdk
         vU9g2zmQbm/rVqPDQ2d2T/9EVKRMXgwq58/bO1rZvZVfQG1zeyJiIh2u4rAIckUctlix
         G/CKCvn3Imi9oqsiOpLUY6CQqkKT1nwVJgg9y1JQqxvn4Y6erRy2pHzOpXW3xV22YpL4
         ydp+o+piqjGwqIOmnoP3PLe5cRnt4c8VX9vU2/J/NmDdDR5mwh9lONcy91aBbcJ3B2Bh
         kz7+r2fZnjqVljNycxIqYkRfNr4TABLH8tUQX3IIvaDbqls+ZT8h0EzBN0cJrHnFARjl
         8JnQ==
X-Gm-Message-State: AOJu0YxEUzStUle4UsEz02uXWJ7VlAVeSR43v9ipFzIMK9q90LZWFPvl
	hN6c/LrkE8dtJJBCDd6/jB+0UjHMmJeSXVnDRoPFoF5S2n4Lu2t/BR0AZkTVRg==
X-Gm-Gg: ASbGncvEtd1AtDTBUvLhdkQtMnD9JH/nDHhiCcyi20VxoIw4rzoGHFEN6VY/lIzxy+9
	uQm5RwVZGPNyYWAL3F1d9Exr9G5xMeBBH35oXEq2a55/jYaZozAKbhLEMSyZbT3eGtz10U5JQ7h
	bvnBoV0lVJ/Iw4ETWxQHtSOJiXVCMBNnUUVP5Crn065MJyZqCqn+FjHMVFEBSqbW909vANnnefV
	fOCS2EDrXJgGEPQG8FNiUjaL49KJVvVbf5eyn7NcYlRbO9bDmDAw1RzV0LpPc30N0ikAKH+Kffl
	RRanHu2Smsm1HPuqocjhGEdAPa32AOkUp45IZUXhO3m9EPwrlptTfOm0YTdgxsvCgzNKOH4QhmT
	9BNqFk083HYuaeimXHqE+Eo8juNL637xsGNaS0+ZAho7yGPAR77xtXIo4cezM3xipWdMANI70Dp
	ty6xebDO23cjuZHsyuZsyjXQ==
X-Google-Smtp-Source: AGHT+IGJS56hE7pO81m3GboXB35g8h493eEZ8hMW1if/mdrBxij0tMBmVoe2DI2V50W5trjrljaPaQ==
X-Received: by 2002:a17:903:17c4:b0:27d:6f49:febc with SMTP id d9443c01a7336-29baae42203mr69158525ad.1.1764149602055;
        Wed, 26 Nov 2025 01:33:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b78740791sm132101735ad.56.2025.11.26.01.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:33:21 -0800 (PST)
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
Subject: [PATCH net-next v3 2/4] net: dsa: yt921x: Add STP/MST support
Date: Wed, 26 Nov 2025 17:32:35 +0800
Message-ID: <20251126093240.2853294-3-mmyangfl@gmail.com>
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

Support for STP/MST was deferred from the initial submission of the
driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 115 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |   9 +++
 2 files changed, 124 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 133151abef8b..e88b4037ee80 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2103,6 +2103,117 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_dsa_port_mst_state_set(struct dsa_switch *ds, int port,
+			      const struct switchdev_mst_state *st)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	mask = YT921X_STP_PORTn_M(port);
+	switch (st->state) {
+	case BR_STATE_DISABLED:
+		ctrl = YT921X_STP_PORTn_DISABLED(port);
+		break;
+	case BR_STATE_LISTENING:
+	case BR_STATE_LEARNING:
+		ctrl = YT921X_STP_PORTn_LEARNING(port);
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		ctrl = YT921X_STP_PORTn_FORWARD(port);
+		break;
+	case BR_STATE_BLOCKING:
+		ctrl = YT921X_STP_PORTn_BLOCKING(port);
+		break;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_update_bits(priv, YT921X_STPn(st->msti), mask, ctrl);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
+			 const struct switchdev_vlan_msti *msti)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	u64 mask64;
+	u64 ctrl64;
+	int res;
+
+	if (!msti->vid)
+		return -EINVAL;
+	if (!msti->msti || msti->msti >= YT921X_MSTI_NUM)
+		return -EINVAL;
+
+	mask64 = YT921X_VLAN_CTRL_STP_ID_M;
+	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
+				       mask64, ctrl64);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static void
+yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct device *dev = to_device(priv);
+	bool learning;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	mask = YT921X_STP_PORTn_M(port);
+	learning = false;
+	switch (state) {
+	case BR_STATE_DISABLED:
+		ctrl = YT921X_STP_PORTn_DISABLED(port);
+		break;
+	case BR_STATE_LISTENING:
+		ctrl = YT921X_STP_PORTn_LEARNING(port);
+		break;
+	case BR_STATE_LEARNING:
+		ctrl = YT921X_STP_PORTn_LEARNING(port);
+		learning = dp->learning;
+		break;
+	case BR_STATE_FORWARDING:
+	default:
+		ctrl = YT921X_STP_PORTn_FORWARD(port);
+		learning = dp->learning;
+		break;
+	case BR_STATE_BLOCKING:
+		ctrl = YT921X_STP_PORTn_BLOCKING(port);
+		break;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	do {
+		res = yt921x_reg_update_bits(priv, YT921X_STPn(0), mask, ctrl);
+		if (res)
+			break;
+
+		mask = YT921X_PORT_LEARN_DIS;
+		ctrl = !learning ? YT921X_PORT_LEARN_DIS : 0;
+		res = yt921x_reg_update_bits(priv, YT921X_PORTn_LEARN(port),
+					     mask, ctrl);
+	} while (0);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "set STP state for",
+			port, res);
+}
+
 static int yt921x_port_down(struct yt921x_priv *priv, int port)
 {
 	u32 mask;
@@ -2789,6 +2900,10 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_bridge_flags	= yt921x_dsa_port_bridge_flags,
 	.port_bridge_leave	= yt921x_dsa_port_bridge_leave,
 	.port_bridge_join	= yt921x_dsa_port_bridge_join,
+	/* mst */
+	.port_mst_state_set	= yt921x_dsa_port_mst_state_set,
+	.vlan_msti_set		= yt921x_dsa_vlan_msti_set,
+	.port_stp_state_set	= yt921x_dsa_port_stp_state_set,
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 85d995cdb7c5..2a986b219080 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -220,6 +220,13 @@
 #define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
 #define YT921X_PORTn_ISOLATION(port)	(0x180294 + 4 * (port))
 #define  YT921X_PORT_ISOLATION_BLOCKn(port)	BIT(port)
+#define YT921X_STPn(n)			(0x18038c + 4 * (n))
+#define  YT921X_STP_PORTn_M(port)		GENMASK(2 * (port) + 1, 2 * (port))
+#define   YT921X_STP_PORTn(port, x)			((x) << (2 * (port)))
+#define   YT921X_STP_PORTn_DISABLED(port)		YT921X_STP_PORTn(port, 0)
+#define   YT921X_STP_PORTn_LEARNING(port)		YT921X_STP_PORTn(port, 1)
+#define   YT921X_STP_PORTn_BLOCKING(port)		YT921X_STP_PORTn(port, 2)
+#define   YT921X_STP_PORTn_FORWARD(port)		YT921X_STP_PORTn(port, 3)
 #define YT921X_PORTn_LEARN(port)	(0x1803d0 + 4 * (port))
 #define  YT921X_PORT_LEARN_VID_LEARN_MULTI_EN	BIT(22)
 #define  YT921X_PORT_LEARN_VID_LEARN_MODE	BIT(21)
@@ -395,6 +402,8 @@ enum yt921x_fdb_entry_status {
 	YT921X_FDB_ENTRY_STATUS_STATIC = 7,
 };
 
+#define YT921X_MSTI_NUM		16
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


