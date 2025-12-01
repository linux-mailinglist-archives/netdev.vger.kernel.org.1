Return-Path: <netdev+bounces-242924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DBC966DB
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99F6F341514
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A63016E3;
	Mon,  1 Dec 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3VlwMX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227530276C
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582197; cv=none; b=K4DGUvSPIRhCMI2hO3HfS+HJBnEwf6hgcYSc+R7aLdBDmopcDvldHL3l1VB0880oajeBg5xmThVk1oxv17pISR9AfHioITPMHZ7lpmR20s8KCKn+5FtqN4kxgvgx5d8n0LNup8+9v4TbDs099x3LMulKca//nDqCevD22tTCYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582197; c=relaxed/simple;
	bh=/6POPplqXgF8+/AVfKQSG/ycrJEwE/5D6VNhle+33lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1ZmGJv5eeRJNUbMqY60Wloldg2NMbli+z12Biy22Zc2ayWRqE5aBvAL58fK3Vrll3UtkGRJS7fYDzduKd0ywA6J0B4NuaaXjAXmy0cO1DDvAuHXFFVqe2viItX9IDBATd/at4G9ZCRvVgbFKIkmCQ5kJwXiSeyxIHjGo+KArf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3VlwMX1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso2364913b3a.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764582194; x=1765186994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsdPz6R0L8wJxtolMW9vVXyoDczdkbYFtBrrwl976Ec=;
        b=K3VlwMX1dMug8j2SWDmtJ1CiI6wOTOiWE1wz6qJEKFg9yzjQNslh5vkGmCNYDBGiJ9
         eMMryUSPKvPtcOH8p9p91iPWRpGyMxPUtjhIgmExjxx09462h2tXOPxPr/Jst835nQ60
         Lr8Y7u8AlpKubMAxd9XIDoW9/7BLDCHZ++e0AvxLoSNjfKxmrJNvmWClwX/tsvaeiiHH
         ic9iPXsIhEtW1/2IPQZ4Mz3nJg+VBVySSFYqh8BnP9+kb2mgImhpCH9tzCYqBTRZ3VwC
         MBbLluI2MqjHtfNphMKuUfPlFHJvFDrs8/IzXqzTSbEkpfBGQEppGQyRkgbhvPIab7fW
         MdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582194; x=1765186994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsdPz6R0L8wJxtolMW9vVXyoDczdkbYFtBrrwl976Ec=;
        b=X4NIaijyNsQyqy5Idx00v3ztTkWf7g46t8cKqnxCFAFDAinkWGrNmx+ac+IKQVWoOi
         jFeo1sRKsgtp3pq4Phr6iZMG12cdCdbwVSRY/JxOo5mbG+m1M5NQE+IgFCGkutKzKOx7
         Zl8c5Ut4iep73wIG4k9+XnDUkygwH4GI39ZbzXPZZL6Rvo0QxYfdU2xujqCzRPoizz0G
         PHI9UmJHMAks8TCzh5gaxUc0R8WIQBHLJXlbLn2saEsoGAurcXXCnaSGirjox7o0XdQL
         CkdxbeqSui2Hp0sZth00dGGxI7P5epWeTeYaRM7iK8/WlybqrASTB4NQackzIquhsYj5
         m6QQ==
X-Gm-Message-State: AOJu0Ywaghqs39zo7fl+nAnqf60n4vkOpNZMs58+9MKIoEOG/91ZL5d2
	TotK29rik3FLgCWorAlLRXSVy/10WJWlgjAZchhvHvnYzysm7F7QxC9ZldmmbA==
X-Gm-Gg: ASbGncu5fmb8vRqojRhhzWYGTkZ/UbpbIyjWlOD3b0G2/+xxsZcg+xyEV0twOLEagwY
	pCnE2K12iU+c9yCOfYNrqUAeOdKFbjAZ7KRB4MzBkI8qKf8DH9j+xa+cx91yMW01stJwIy8ZrEL
	ZX1T1Drjjzzf6E6VY+eSW4pbz9/ojBS67tDA5KKVrstM55dNaIc298kvwO69fGE8rWvz7dTvgFS
	YJv+w/OhDTLapUYv7LOnOe+Cb30peNiCdnNpxfBiL4SZxHj3cX7/RYjfOiIxO63fgxTr9D6Lu1Q
	Z1zE/KICiCRaLNcsfzc4uBPRKsJd7sLI9G8KFUjCwXf3fHZdWUusSu0fDh40z5Vu2VeX3MKGjXu
	t46yWCtGjt5tyfdzM0F9/NyM+UvRvsGypB0CrknYFr4CcXo40quefNEwctas0JudGDpWfw7raoh
	zp1qxSf5u9LbK2w05ZlizvGg==
X-Google-Smtp-Source: AGHT+IE84q3npyCQcgx8/3FEbWc9DdLWLiU4Ktu/rPdQv2B65VWqYy4gmG+r5whTMUtlTsG0/ZXBtA==
X-Received: by 2002:a05:6a00:a1f:b0:7b8:8d43:fcde with SMTP id d2e1a72fcca58-7c568934bdfmr36246135b3a.8.1764582194127;
        Mon, 01 Dec 2025 01:43:14 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f9260a4sm12928333b3a.58.2025.12.01.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:43:13 -0800 (PST)
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
Subject: [PATCH net-next v4 2/2] net: dsa: yt921x: Add STP/MST support
Date: Mon,  1 Dec 2025 17:42:29 +0800
Message-ID: <20251201094232.3155105-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201094232.3155105-1-mmyangfl@gmail.com>
References: <20251201094232.3155105-1-mmyangfl@gmail.com>
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
index 675e24575834..bd19e9edd8cb 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2098,6 +2098,117 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
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
@@ -2784,6 +2895,10 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
index 01ef623946fd..61bb0ab3b09a 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -274,6 +274,13 @@
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
@@ -449,6 +456,8 @@ enum yt921x_fdb_entry_status {
 	YT921X_FDB_ENTRY_STATUS_STATIC = 7,
 };
 
+#define YT921X_MSTI_NUM		16
+
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
 
-- 
2.51.0


