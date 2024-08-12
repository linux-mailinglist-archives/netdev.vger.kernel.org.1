Return-Path: <netdev+bounces-117659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FD94EB30
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D751C21711
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBD170A2B;
	Mon, 12 Aug 2024 10:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823416EBF7
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458769; cv=none; b=W/8Bmu1Y+Vi4DENXELiZdlbYOsDqutyVu+eYW5tpmSkuqhIGcfT1NVJ9pqK67uWEl4Sx36vrtGya/kUr/zEiU86nO0s5t5PQpcUme/JS4Dq0ayybizWn70kHvsZdrjMS0e/GIBNVmGu0XHnOPCljoUE76z0A1KVpzUHhO/8Py+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458769; c=relaxed/simple;
	bh=6ox6EOyB4YiV3LTYdVyRzKYf6CbGeH/BvEA/mPE6ZQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIr6kZ6R+1BSIzuH0hUGtr7dEPJQPrz09SpGz6yOMHzxUj5qatan13pBGAeS1ww62ZzmPYvdb8f0bk+UB4uyBb6yWizzrUhuHhDpDCHk4yTdqaU7OVySyNo1iT3tkwQGcLbPFpB1bbtpduxDeD4rkTT+8OQDvUa3Kru/kDGYoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz11t1723458635tmeak0
X-QQ-Originating-IP: IR5CZfK10uLH9IwIqeph6og+yIK0E2EHaUFflo3V2dc=
Received: from localhost.localdomain ( [115.204.250.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Aug 2024 18:30:27 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: W+onFc5Tw4O0GzjUL0bfFBPldsmACkGU5WMtu+WFjYiesEPcG7w9s/FFX/3Xr
	UObWt9imtbRKSbWOyAP7Tq+LI1bkDH+VXH4NjbYQdsqG1Arzwth6mVQTwK8NQQMHpdDyhbn
	s3TSw64FpE72fzC1J03E4tEepAoYVXM3PEUHVqurZGkwJiBrx5UStpIXRcdwHoHrU2yh0yc
	AiR5463OOpPvtWiPMNEOxuIGNZfCLcmBinkPW027MSZGWTtN9W002RJTgnO+NQ8EaDr5gMF
	2aPDnF6Bb4y7QZ37I+nOvadcj4T3DrWBlQNMqoiWL4vRd8xIDO1tVDHGzg3c2rlE9UY4RIk
	awx9lRLPsT4UtYlMP2ydLGnCihVQ2KG7cqCZKPe/L+MLI+aqWiQwKv6EUMlXFG1coeaBGtq
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12866155087578669008
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net] net: ngbe: Fix phy mode set to external phy
Date: Mon, 12 Aug 2024 18:30:25 +0800
Message-ID: <E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

The MAC only has add the TX delay and it can not be modified.
MAC and PHY are both set the TX delay cause transmission problems.
So just disable TX delay in PHY, when use rgmii to attach to
external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
And it is does not matter to internal phy.

Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
v2:
-Add a comment for the code modification.
-Add the problem in commit messages.
v1:
https://lore.kernel.org/netdev/C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com/

 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index ba33a57b42c2..0876b2e810c0 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -215,10 +215,14 @@ int ngbe_phy_connect(struct wx *wx)
 {
 	int ret;
 
+	/* The MAC only has add the Tx delay and it can not be modified.
+	 * So just disable TX delay in PHY, and it is does not matter to
+	 * internal phy.
+	 */
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


