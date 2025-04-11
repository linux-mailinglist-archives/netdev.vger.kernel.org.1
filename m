Return-Path: <netdev+bounces-181620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB6A85C80
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587144451F1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82DB29AB1F;
	Fri, 11 Apr 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFJZLBhq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0A29AB14;
	Fri, 11 Apr 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373376; cv=none; b=jFkDqKMqmVw7PV+bsSovaMepN4bY7TdqpbEJddtOo1OHKWPaLyI/Z2yOIJ/EVLddeDJWZjXnXzo1JUU3Je9GPxsHZF6Hx8YKluKgkx+0vq0hRT+Cxs9sQuO6D+8wWhPjzLRlha896MctAc0KrHnvJf/Y5V4ExcpMYLM6z6c0PAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373376; c=relaxed/simple;
	bh=dAYppr2WyAl9VFdAU0iu6wgFo0sivnbiYlB0AfqCqr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dcv6UDZ7ZDDblQ1hYOZL0rlZq3MEBzIVJ11yJ2B3YdgLcPqq29ESpYnmGu2su+VNfZoKlHNgxf9/5P4uhAlXvABRr7TJ0r8BlAPYiAQIy1E+WHD3iVF/y6Z6dwtEmKiwGD3iYnPs5JPoYU56aKJtwoqKLPNZtdmaGxRKly2DSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFJZLBhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461B0C4CEE7;
	Fri, 11 Apr 2025 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373376;
	bh=dAYppr2WyAl9VFdAU0iu6wgFo0sivnbiYlB0AfqCqr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFJZLBhqTXYILA6dC+EaCwwEHzoAjnYsQdQh5v6sldETkPCBDx18gx2G3dwrYxDaG
	 9p3Z9J4sSTC1EtgTKGuehuYu0USYvFPBafgelt4NeVGEK6qw+jr3AGKaNd3W9kLiv1
	 xTLbfjwPdlUajVU0QNs1OX4W4nS4k5MePKc6ziQfstU4QQR5UKjjSlgxlhB3YZNc6q
	 bEszjrKYtdirGAT9uXvODBN9lptyZB+kl/lY8QLtoYQOB2lrDe4bUSvOaIkq00pj7Z
	 kNie9qqwsILEUN/6ki8FjbZ/Q68xgpyQCmYpM/n3Ajl16/40Api+9jCXkopEC0MX5C
	 yPMox4Bqr2WJA==
From: Michael Walle <mwalle@kernel.org>
To: Saravana Kannan <saravanak@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next 1/2] net: ethernet: ti: am65-cpsw: set fwnode for ports
Date: Fri, 11 Apr 2025 14:09:14 +0200
Message-Id: <20250411120915.3864437-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411120915.3864437-1-mwalle@kernel.org>
References: <20250411120915.3864437-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode needs to be set for a device for fw_devlink to be able to
track/enforce its dependencies correctly. Without this, you'll see error
messages like this when the supplier has probed and tries to make sure
all its fwnode consumers are linked to it using device links:

am65-cpsw-nuss 8000000.ethernet: Failed to create device link (0x180) with supplier ..

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index c9fd34787c99..af7d0f761597 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2749,7 +2749,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	mutex_init(&ndev_priv->mm_lock);
 	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
-	port->ndev->dev.of_node = port->slave.port_np;
+	device_set_node(&port->ndev->dev,
+			of_fwnode_handle(of_node_get(port->slave.port_np)));
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
 
-- 
2.39.5


