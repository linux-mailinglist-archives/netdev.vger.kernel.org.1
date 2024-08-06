Return-Path: <netdev+bounces-115991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49989948B43
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30661F22228
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8401BD02E;
	Tue,  6 Aug 2024 08:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D31BD4F4
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932750; cv=none; b=IV/MyxNF1ari8En701E7Utv+7WQcAonJechYB/k5YHCKWCi4Bvajl7Mgmam5BOc1Cu5dvxqjZQ9YiP3VV5tWKQZ0zpp9s6J2clfoDALRvGd3pMzAa7rNhRJxziZg7eZ327uVr3t8aL7gROwNcHTooGh9evvHI9KbKCHCmZS++0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932750; c=relaxed/simple;
	bh=jgW5liG7JqXigdHLrZ5ltvatbMmnE/VfCtxBwMwDJis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUR2ez9+7YNezy1a3mFmFIaeKkHd10QBorqzPi1DIokbeuUunyj68loe/7u3vBv6rJcYfhXTk+9cIlJM4CIMh4cqXhbG3wQsGeZJH9NGxrDwZ3PWaYimNbX5CP9E2ErXOSCOrZ2FlgJt9NXoggVMd8x32LZACgyM0Awvxp/OVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp80t1722932732tww2100n
X-QQ-Originating-IP: byhfTOwl0ED7SqiAHc1pPXYYRHDtun7PUJoH4TfB4iY=
Received: from localhost.localdomain ( [125.119.244.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 Aug 2024 16:25:24 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9873904562735366112
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net] net: ngbe: Fix phy mode set to external phy
Date: Tue,  6 Aug 2024 16:25:20 +0800
Message-ID: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

When use rgmmi to attach to external phy, set
PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
And it is does matter to internal phy.

Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index ba33a57b42c2..be99ef5833da 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -218,7 +218,7 @@ int ngbe_phy_connect(struct wx *wx)
 	ret = phy_connect_direct(wx->netdev,
 				 wx->phydev,
 				 ngbe_handle_link_change,
-				 PHY_INTERFACE_MODE_RGMII_ID);
+				 PHY_INTERFACE_MODE_RGMII_RXID);
 	if (ret) {
 		wx_err(wx, "PHY connect failed.\n");
 		return ret;
-- 
2.43.2


