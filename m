Return-Path: <netdev+bounces-121187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C880B95C13D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070441C20FBB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0C1D1753;
	Thu, 22 Aug 2024 23:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE518AEA
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367956; cv=none; b=Hq7LmEDC3/rH4joygzh8tVGuB+PeiuxSQKeY1v2rJutD0wijSPY+lJp7XrQuOqXomIPBCJ+QTVn/v+JmHcadwNIXwn3I36IRpHzE6ZSNDZeZV8CGssetnOwdzfuejREQs5/+3FaxzJ3ss6RW0HahsBzn1Yfr9RosFYP3fXKRYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367956; c=relaxed/simple;
	bh=0UwZyyLar1BwsnyIRRFg05dZZczkW5Zi6NVmIIa4Q+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V37DbyI0Jtklk6NeFWGrMohxv0VgzysArsw47r/Sx5PgyWktSaLkKJrEZ1CUANvsrukM2aXxRYyajJDAXbePc/hpgIh2/lnnuSeF2V8/m06YA3KhPpgIbmQRjAxjnuVZMkMgUPp8lNOnX3vKMYANuq+tiJ30EKbt0JdBVBvVIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 140caedf-60db-11ef-8e3a-005056bd6ce9;
	Fri, 23 Aug 2024 02:05:52 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Julien Panis <jpanis@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH net-next v1 1/1] net: ethernet: ti: am65-cpsw-nuss: Replace of_node_to_fwnode() with more suitable API
Date: Fri, 23 Aug 2024 02:05:50 +0300
Message-ID: <20240822230550.708112-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_node_to_fwnode() is a IRQ domain specific implementation of
of_fwnode_handle(). Replace the former with more suitable API.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 81d9f21086ec..555aca4ffa24 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2761,7 +2761,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	}
 
 	phylink = phylink_create(&port->slave.phylink_config,
-				 of_node_to_fwnode(port->slave.port_np),
+				 of_fwnode_handle(port->slave.port_np),
 				 port->slave.phy_if,
 				 &am65_cpsw_phylink_mac_ops);
 	if (IS_ERR(phylink))
-- 
2.46.0


