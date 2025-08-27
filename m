Return-Path: <netdev+bounces-217259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0525B381CD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801232057D5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38762EF654;
	Wed, 27 Aug 2025 11:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m825.xmail.ntesmail.com (mail-m825.xmail.ntesmail.com [156.224.82.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A31EDA09
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.82.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295832; cv=none; b=VYIB42yePJ5539cC8xAVINeyqqV2fQcuujJ2OSbcoovHEWjg7BIr/4SFQD8H3+u8bcEZqsL8/cMll6TOVD8Pwvetn60zYJy+R5H0/n5m7Ixd1KNFRXGqf6vKpjxNDSjCN+2DuqODSrFaEDph9S3XzfkhGfz0nPxPpbDCakuAxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295832; c=relaxed/simple;
	bh=Jd85fuQCAmwXl7WZrwWCMxTjWijKR6OeNvzxJ8MO4zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcdcDtbpsuUVK4SGz5u7dPJEi2OwDP78tsRuV1fKzDj2t/ROCLZEdUPZYO9OMJsmBcIhDh0xlrbr1a8fl3dP0YYcQV+4OnqdzjAUDXy3K+MDvEqjlp0RdpA0Dd7ICC2GyNtyt0DWU4kuFU+58byrWBntk9E16O5mW4Ud4tFVBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=156.224.82.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id f46bbc4e;
	Wed, 27 Aug 2025 19:56:52 +0800 (GMT+08:00)
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
Subject: [PATCH iwl-net v2] i40e: Fix potential invalid access when MAC list is empty
Date: Wed, 27 Aug 2025 19:56:31 +0800
Message-Id: <20250827115631.1428742-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250827032348.1374048-1-zhen.ni@easystack.cn>
References: <20250827032348.1374048-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98eb6353aa022akunmaac10b1a148a57
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ09CVkxKHhoeSktOGhpKSFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

list_first_entry() never returns NULL — if the list is empty, it still
returns a pointer to an invalid object, leading to potential invalid
memory access when dereferenced.

Fix this by using list_first_entry_or_null instead of list_first_entry.

Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Replace the list_empty() pre-check with list_first_entry_or_null()
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5f1a405cbbf8..518bc738ea3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -359,8 +359,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
 		goto free_cdev;
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
+	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 	if (mac)
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
 	else
-- 
2.20.1


