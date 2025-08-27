Return-Path: <netdev+bounces-217141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F7B378EC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84580363DA2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970A2D0C6F;
	Wed, 27 Aug 2025 03:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com [220.197.31.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2A1FECAB
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756267175; cv=none; b=M0eF0Fs4oUw2muod1B88fWxUYUaKlfv46d/zE2WpjhLb1xuMobMdwoQaTdDUNy6nPs46gU6QK41U5kVxLqwyMNXfV5ZZ17Y7PW2Yif3U+EK5/QMPlIiQ5mzC91fCXG8RV70Ux2PrMgOKTB7RecSsva4IplFTmAyA0+pM4u3kHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756267175; c=relaxed/simple;
	bh=8KVOZo9eOdBc5GENtXAE9CNsvSsU6XoxIkTPlL22kas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GXM15S05hQvxtuUSWHsg317shkmHEaUUlkcJxE3cC0NA/xGi2Adp/Y0sRQo5jEyeyga6Ly4HZs3GNvJzoxcj0f6+joiDLJgIlPj0DHP8GLEhtvxBzc82IVhBpwPg0oDssbbDAaLVWnKVhANh038HKbIwtkDciZnXgqZzAE4Cutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id f401266f;
	Wed, 27 Aug 2025 11:23:56 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] i40e: Fix potential invalid access when MAC list is empty
Date: Wed, 27 Aug 2025 11:23:48 +0800
Message-Id: <20250827032348.1374048-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98e98dbb2b022akunm24051186c08aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ0JIVk8YHkJPHhhKH0oaHVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

list_first_entry() never returns NULL — if the list is empty, it still
returns a pointer to an invalid object, leading to potential invalid
memory access when dereferenced.

Fix this by checking list_empty() before calling list_first_entry(),
and only copying the MAC address when the list is not empty.

Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5f1a405cbbf8..0a72157aee0e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -359,12 +359,13 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
 		goto free_cdev;
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
-	if (mac)
+	if (!list_empty(&cdev->lan_info.netdev->dev_addrs.list)) {
+		mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
-	else
+	} else {
 		dev_err(&pf->pdev->dev, "MAC address list is empty!\n");
+	}
 
 	pf->cinst = cdev;
 
-- 
2.20.1


