Return-Path: <netdev+bounces-241836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D8C88F81
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B78C24E15EE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1884311587;
	Wed, 26 Nov 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhEKEeJl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51677305078
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149607; cv=none; b=IWBqjLphHtUtRqIVcRyabiOywjSfTSshHBEQ222RaKKTefUNIZZ6QcwrGkcYU1dzB+Q37LdBrxFGiujjKlDHLapaySWdsGmofjPz+R2jlWbF9g2KZvRTIVDdiN1qassCleUKgM6u+d7VDpEsBp+jD1Rpyqq/GfGTtCaaiX0uB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149607; c=relaxed/simple;
	bh=4zzbOxMPkXe/4tQNGglH4QUKmNDWx66LWV4v8+bILg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KglLxkfFgypvWxKT9pgZEJRhZERgb3+Yj7QUSGq5UJZJQTOuSf+VGcMcjCTWrQSZFqR3U1qmalQV35nOggMa4bQx/h0AAkx46PpXMEWKaN7kKLfpC4Y2qSqzbO9uRbWeiwYhwNYOgifhMhLQJCXddYN7ENSv6tMZuubgaW+jyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhEKEeJl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29ba9249e9dso23434305ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764149605; x=1764754405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqJqJrlMSLkRydDrXYGtfXhQQqVvrofmZY18LI6Fuv8=;
        b=AhEKEeJlxL0o7+HB3M6y+jOjaJGGW81APaahUBZ/wS9QwRfyKlWBwe8Nx+F4DE6wWV
         RvqlnMgsjHeqwBEiZzLAvd84tBvtXiOCGqqgcbp7Imbg1xytO65rgn1WsCsGrn033iqB
         QCCES0+rIWxhwK7rYGbJhORCL+Hri4LUk+murJ5m1wfw3/EznFsRlIlU+D6kkiUAaZh/
         OhgRBYG2+qQPIoZP+MnPRYXAjxQPQgQXyJMcaE4Dxl+NeWYrJYn00YCqGqt1pAG8ue+U
         MXKIBgJIiUNqDSYCHM/NqX7MhuqlCc4fd5kR58UFRt2SEsewbaxvB2eT3C6kQqZra3M0
         iiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149605; x=1764754405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YqJqJrlMSLkRydDrXYGtfXhQQqVvrofmZY18LI6Fuv8=;
        b=GccFZsNLTPUKqnxRg32EV4NMyeh6yB0PagSaYCtVtKsWHk04H3yGw1yXJ/2mW9cw+t
         +ut4f2us8HUx+Hj3+96ipgqCVMmNLLd0jf4jFixn5ljai2o/xcwq3FZ1aMcpx9/l3ZSc
         20Q+G1YI4Migr5uhxIR43onn0pmnQq0FoI7VyMO5DMFNhODbKSBXjSBGqNkJ9m2yzigk
         1bj+pKsvegfqPmccwOhmF8HV4Z01NNHcez9LaJBCecZntNr6F+h6mVqpMCf0Vj8FDry0
         ye8jCFkFqlQGmtm7SDVs6jlekRE50g5Azay7aszl2aW6wR33rohHjEq0vjYaqjlyBu2S
         xomw==
X-Gm-Message-State: AOJu0YyW8S80Ve9tKCSbkjOqmVhla+0A+bImUaAJOC9khnFbDPkBJuW3
	vIV4K/OQPch5T7lYNQDzhG1838SH8XJpVlEei43GBydnaADpWiJvSj5lyVb0cg==
X-Gm-Gg: ASbGncvCqacSQ5CBCNqYYO4h8KToF8FWZZrVGToGWtjlcxdMLg9OelyfAhnzzhcpyzE
	1JaF+H+qOp3HAQppBuBJh6Qu0V1ZBF7N6sjXmaTE3krbLicHFVDYOI3I+bn4ZlZNjjH0o34zl4s
	4snWaGznjNmvCnDqvPpIK3oz4YMYY9PqX09jglmmol+gIrdDbHOnx8T4SJcCUI/kcliIkyvyKKc
	/Qp0Z94FOI8Oh34Fa5/z0enSbw9l3UXpPAyCZH6BfJwMfRecvuBVUeAp2FJ8hL7a/BM3xSrrObV
	drxGXafAYuAHnLTK3Gn3nVpRxgRokTSu1AfNqUlzLEP6SSIu8il/TXu2fi4BVSoleEEjU251qSf
	ix11FQqMHYDD3CiaIhNkMLQ2ydjjCwM7RoNyt9xhcyTlLqHT4rnyA+5P7Yl0+RmGbU621oEzfE3
	tplmfr0FnsA2WKDv/V1Y3eqw==
X-Google-Smtp-Source: AGHT+IF/RoDT8rwgc3IB6KW/nYWFdGo0AqNDeggqp19LPhS/Wh+ftCZ152rxFYdHGwXisLmNw82dSQ==
X-Received: by 2002:a17:903:2349:b0:299:dea1:e795 with SMTP id d9443c01a7336-29b6c693f84mr210052655ad.44.1764149605346;
        Wed, 26 Nov 2025 01:33:25 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b78740791sm132101735ad.56.2025.11.26.01.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:33:25 -0800 (PST)
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
Subject: [PATCH net-next v3 3/4] net: dsa: yt921x: Add HSR offloading support
Date: Wed, 26 Nov 2025 17:32:36 +0800
Message-ID: <20251126093240.2853294-4-mmyangfl@gmail.com>
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

Add offloading for packet duplication supported by the YT921x switches.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 24 ++++++++++++++++++++++++
 net/dsa/tag_yt921x.c     |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index e88b4037ee80..e7b416719b58 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1038,6 +1038,27 @@ static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
 	return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TAG_LEN;
 }
 
+static int
+yt921x_dsa_port_hsr_leave(struct dsa_switch *ds, int port,
+			  struct net_device *hsr)
+{
+	return 0;
+}
+
+static int
+yt921x_dsa_port_hsr_join(struct dsa_switch *ds, int port,
+			 struct net_device *hsr, struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct net_device *user = dp->user;
+
+	/* Nothing special here; we natively support tx packet duplication */
+
+	user->features |= NETIF_F_HW_HSR_DUP;
+
+	return 0;
+}
+
 static int
 yt921x_mirror_del(struct yt921x_priv *priv, int port, bool ingress)
 {
@@ -2880,6 +2901,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mtu */
 	.port_change_mtu	= yt921x_dsa_port_change_mtu,
 	.port_max_mtu		= yt921x_dsa_port_max_mtu,
+	/* hsr */
+	.port_hsr_leave		= yt921x_dsa_port_hsr_leave,
+	.port_hsr_join		= yt921x_dsa_port_hsr_join,
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 995da44f0a2a..0ad83924fda1 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -46,6 +46,7 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct dsa_port *dp = dsa_user_to_port(netdev);
 	unsigned int port = dp->index;
+	struct dsa_port *partner;
 	__be16 *tag;
 	u16 tx;
 
@@ -59,6 +60,9 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tag[1] = 0;
 	tag[2] = 0;
 	tx = YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
+	if (dp->hsr_dev)
+		dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
+			tx |= YT921X_TAG_TX_PORTn(partner->index);
 	tag[3] = htons(tx);
 
 	return skb;
-- 
2.51.0


