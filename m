Return-Path: <netdev+bounces-232342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590DC0442E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829E719A5405
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B756272805;
	Fri, 24 Oct 2025 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlRgqQ5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1D2749D7
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276790; cv=none; b=g8Jj/JZKcwTN6MzSYiJpj14LnFzxWAqbmrQb9/f95NNqQ/LFq36A+iG1AS27jd84Jq5mwiYDn1uFeZs3iU9/FCt/arnA+xRf1jKcUmtmHXAa5iZASVQlX/OynfdT8rvzTmYNEJNF5FSZmIblAAzyr0D0xJDl7Hp5nYT47HFdMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276790; c=relaxed/simple;
	bh=vtBgyCttMlcJ2RTqD0BEiKGo9nxWhGDqE+BNz5XY7hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgXOaBQWP4D4Mv3UN21Jl7/uP4gdRggoz85n9M6eHmacmzRPSmSEavcmfdEq3lQ5lhzPs4eRlMgguLBTqqY4XVpmYO5oDXpwPcFezjE5COjuXKR9xyBAZqt1f3gWJFXMaOHjhUPxJmqbe65RxWh03oXeFy4X+ccGD0jmmqRAKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlRgqQ5Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29292eca5dbso21562555ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276788; x=1761881588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIHXLN1jSs0Gveu8jOX7vUP/RM8P/HJmwm5LBtcMRtg=;
        b=HlRgqQ5Q5iY95kF19yTHZpZfaoUz8drShFDFL+b2RZtIM8nLr9/i9YZ9pFnD/S7ieL
         3qbUpSoIS5DsXuKKxPnRfQ9RTnLkadWzNTteGbaZ9JETiZsBe4NRsSNx/fl2pqq0sXqt
         MHzZx3A8QZdZFZNWrUMSaoOd3FPwtRprYdjDvbCVuLy2VBJSO+Ptm47tOshVLPxg+xjp
         J6KKRV+36dVhrYDKkF/CZsWnWsGPUQivNcLSOJTgzEYcrOGTYDSU8rZdozzFHnIdLdxD
         dKw5SR7SXu3F321qBvZyopwck8BJ6j/3a8kIV7aCJ72tuUjIYmXk3yT1CGgGO3G5FJph
         ecLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276788; x=1761881588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIHXLN1jSs0Gveu8jOX7vUP/RM8P/HJmwm5LBtcMRtg=;
        b=NtNyL9QE8sJ7TQrkA4x0yJF+xLUXz4wyV8Ii76GqK8TnEbFYq+O/mB1N97Z8xEdUrK
         ylWHD2KXwSYAzsoKycI65WPSYzvZo9zN8mD6gmHbdQkDZ7nJF8uWgIfumams0IrlFjue
         9EnKezcQlgflhI3mAw6Cyv+HrxCaVSotgmuLd0bCPd1k5XalX0Jny4yU/Jptety7VZJ4
         lZOdL7wi/OYTFeECJF1qmxn4E+yPPIdqBJDirTcTa7sDGjCO+AqWCbsSHrU3p8fujADu
         NExhW0J/iQpYNu2x1WFYxsIrew+HDaus6qdNvWO9vrIxf+7BHIKIWQm7eiNUTIcqqXBr
         +WGg==
X-Gm-Message-State: AOJu0YwDdbaIfmPZ5v17B14Y6tcHTvkK+tjePekVbAd7kq9dsACa16BM
	+J91IKsdaioXrz9boVETOkR9IYXOgQajDWYp4B6Ej2mdeDCbY0jjQNYJa4CGd1I4HJc=
X-Gm-Gg: ASbGncv9vznjUXUX+7eEJjyxJyPDaYri+Lsmt9lGtxxifxhEaxqFed4zb0AMOYSYcsu
	wYZmD1vzd8p1sI4n8gKT1imuB3z4CAsjrms2H3gUku930jFuUihGkhDdgt5PyAR3WEn5fNDUoFa
	M3RPAAlD8B8AyYmlw79AZCqC0YuHfMPioU6+Rb3FukbnwCgyEm6pmdqAP93SbQNUBrefvoqzAIK
	rACj9dvzyqDKvUDgRkdiY+UP3ld/dVppjxr7NooZJPYmWO3zAB30B5khfWyyZd8MyTLMAIAiBoy
	WmfYlWtWtoBQfterwy2HtEfHwSEb+WITZtvpakjtX1Pj0rXDavH57rANZBpAy480/OFE/w875b8
	I+NW9z1e4Hj5YG6a7KZcCDxcKIaHwCqfTUfv2tDFqd0LLRjlR+2nP1uGmK2AInOLRV5qrF6ULLk
	IyF3xjh3I=
X-Google-Smtp-Source: AGHT+IFWzmMLIdXwRN3RNcZHRt4Ga/+I9rtN5rJOzaIkYrpyCjPo7izMGQ1mB0Zrag6Kd78YfLzZ7w==
X-Received: by 2002:a17:903:2441:b0:271:479d:3de3 with SMTP id d9443c01a7336-290c9c93d94mr340310505ad.12.1761276787541;
        Thu, 23 Oct 2025 20:33:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:07 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
Date: Fri, 24 Oct 2025 11:32:27 +0800
Message-ID: <20251024033237.1336249-2-mmyangfl@gmail.com>
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

Support for STP/MST was deferred from the initial submission of the
driver.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 115 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |   9 +++
 2 files changed, 124 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..485fec3ac74f 100644
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
+	if (msti->msti <= 0 || msti->msti >= YT921X_MSTI_NUM)
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
@@ -2788,6 +2899,10 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
index 3e85d90826fb..3546a94f380e 100644
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


