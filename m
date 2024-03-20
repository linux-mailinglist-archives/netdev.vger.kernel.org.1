Return-Path: <netdev+bounces-80720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56915880A1F
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5521F23B6A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491610A16;
	Wed, 20 Mar 2024 03:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2312E40
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710905102; cv=none; b=tg9EmRU/fFErcY+vAxsKZnZtofov84IyeljtLwbJNWghcRfYlULamYGr1/8ZiIYUqzkWRYEm5zeyIUaPcdNaGq2HbYuC7EzCTHTpVtLcmnjvzvqXuGL40g4N4TnHzIY1MdGppZ6YBz9awFCaKWtSyLm/Os1tlIlnOK82xKNHnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710905102; c=relaxed/simple;
	bh=J+0NilHQuo7UocbvkIqJ+iHPmnvkjXKssFOjOzMjWN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfBGoVSUWMJQGldgJmfo0mhElzkBTUY/6q3p+Z7xM5df4C07gSSVIRcjNTeFEbvoodGv7gSdEFL+knnHbQ7SLMnk+MyC8WwjP45bkBgznKyV8FXtvlHhcq2/lPTrWOGiQ4Op1QypN/0UOc8+VQZAzZ8ATIDBBOTc6jTJuo0FR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp76t1710905006tbppqx3z
X-QQ-Originating-IP: P/D23fFU8t9HHAeGpwhehXJwIf1pT98n1Cp6VEg9YEg=
Received: from localhost.trustnetic.com ( [36.20.53.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Mar 2024 11:23:24 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: q+EIYT+FhZrCESqExo8Gjge/lXas+tMZ3WU+9kLT7tE5gz2CvjKI4mZQkUZ37
	MO9hzhQu68NnUCh6K4Mnipa/TU7SBhswOs77LerQwgnnpghDaxPeSQla3VQOK+QP6Fl0/5q
	1Gj+KTUjVw8LDLKEtZvA5cI6z9PoJKWCw11XdNexi5s8E1PnJWbpG3aYBUhXmlAMrdQLO8Z
	0imLJtXtVOVnECpCy7V7ku1Vo1KdwJNo0IfuGV6otDWuXaVmDwT/03/AlLWX22plwcr/B9k
	9FX7Mketv+O3sHBDU3Q4GtpIfziHXbzPSJrksbbBQGTbZPiEMqaGc1awJ/P1XUNeVIZyxnh
	4VbBOFPv3Pu1uM+lMusnLlYL5L8J/fBSMl35Wc1wGqs4OaqMTPDIhJI7eSp/5SVtKlJ6N/U
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16273658386177788653
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	wangxiongfeng2@huawei.com
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net] net: txgbe: fix i2c dev name cannot match clkdev
Date: Wed, 20 Mar 2024 11:22:24 +0800
Message-Id: <20240320032224.326541-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

txgbe clkdev shortened clk_name, so i2c_dev info_name
also need to shorten. Otherwise, i2c_dev cannot initialize
clock.

Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5b5d5e4310d1..84d04e231b88 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -634,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = "i2c_designware";
+	info.name = "i2c_dw";
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
-- 
2.27.0


