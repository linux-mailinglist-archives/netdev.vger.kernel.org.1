Return-Path: <netdev+bounces-182069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19971A87AD6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF7016E724
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB03269CF6;
	Mon, 14 Apr 2025 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7m6e+Ef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F6269882;
	Mon, 14 Apr 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620236; cv=none; b=bZXPt2tlHMXAy3o4qnkWcKJ/OTmJfGSg+ckrYja3iy6b8dTBrNSX51gXgKM9GFrg9z1m4oGcUzSh6n9SkKTbQmMtVJkAx7CKDYJPyBhAJTCzIxTxUtp5L9wa8BeSMpAa9vQHjcGUyaGQfqPbB0VTYm0XtKCdiPIsahyXGANidTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620236; c=relaxed/simple;
	bh=OT+iV6RGXvYQH7Z4h/ikFvlwLhr9nic3CO6eW8fJEt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmwMWqmFjWHemuC8BK92+lnb0LrlwsiJv8F1wNlhvvb/nCPKB0SHVbwRtjg6PMLv3ErWJTjdjHVWA0TXZu0b1ucUm/PhWkzU2JF0nTve1wY0+nxRm8t6et4a4cfBHpnMmRWA6kQdVCd+oDt1IspcgdJbEkpXa6q/ktgJlS2wGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7m6e+Ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B7C4CEE2;
	Mon, 14 Apr 2025 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744620233;
	bh=OT+iV6RGXvYQH7Z4h/ikFvlwLhr9nic3CO6eW8fJEt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7m6e+Efk2MGM6nBMZPMe5E74ui25Ums31WDJf3JExFC/aK4f62T9T5irNFdv5FeC
	 dmJqMmGtcUK++yBjpd8wr9JCH0Zgn2r9UbOJlXbpH903vSXY7t9HNNyCOZbdWXG5al
	 RhSiIiIGuW67unvI6WYVh5O4Bf6ITme/hT7w5xIF9jZ9tGVGrXX/Eos/igppTJrL6U
	 tDHIcELONnd3ArOzx56DWs6PD3xINguHfTmKEO7viEEIrALeIHNnfkQSrmNw4g7qvo
	 9ClC+tJkorUyjnDoukaANHLkp3RJRodYLJbnXBa7iH09rzcnrxgcyeo6I956CRWRQl
	 YRZPUjHeXsOtA==
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
Subject: [PATCH net-next v2 1/2] net: ethernet: ti: am65-cpsw: set fwnode for ports
Date: Mon, 14 Apr 2025 10:43:35 +0200
Message-Id: <20250414084336.4017237-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414084336.4017237-1-mwalle@kernel.org>
References: <20250414084336.4017237-1-mwalle@kernel.org>
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

Reviewed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---

v2:
 - move of_node_get() into own fixes patch:
   https://lore.kernel.org/netdev/20250414083942.4015060-1-mwalle@kernel.org/

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 636f4cb66aa1..55a0c37da54c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2760,7 +2760,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	mutex_init(&ndev_priv->mm_lock);
 	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
-	port->ndev->dev.of_node = port->slave.port_np;
+	device_set_node(&port->ndev->dev, of_fwnode_handle(port->slave.port_np));
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
 
-- 
2.39.5


