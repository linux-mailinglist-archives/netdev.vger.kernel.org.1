Return-Path: <netdev+bounces-170241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45BA47EE0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ED81643FC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7B22C321;
	Thu, 27 Feb 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XppFeV7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA5227BB6
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662295; cv=none; b=Lu15y8PC93jSoq/46QKH8BqIeK/wf12OrcUhQHohK+XmUXTdnjCs6i9Z1IrdyfwoTOdbs+rcDIjN5dlQ0dBW6yKjBGcJXrC65Pd1hWqUu+uoSV93CfG5YRI9kv9DrYwvz2KtNp2lCTCUxzz2k1NaodpNBZcoN6lTIDe9xK2J+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662295; c=relaxed/simple;
	bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zp4noviAn4FIGHDx6q7stQuo9V9tMnLsYBfhIMohIflvSNG4yV9FDCKS1KvZGKvi5CDcCSHaHUmSP/2E10f33K3e/2UbAyWXVZqgLh7/2lIXz7KtEFIPiPyzNI9g958KhRUQm6eWb9p0HzzlDl3zrjV5M2GBDUxY/0+cAFcSIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XppFeV7Z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740662294; x=1772198294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
  b=XppFeV7Z2KRqnw/eQBrVHd9QQCpxtcTRMHdQjo6yocJRWR58iASj2PD6
   rlQZSoYKeXYC+c4F9THr5hW2zatAY9pf/rq03QbyJ+l8E4jx8KoEvN0Oq
   hYaBtY6/Za21aykMhmbLe3kLODPInFxDGmyLsmbYj+/r4hDu7UvdH47SQ
   AYp7Mi/ynMXAvYKi56OdZwPNSk+w7/NjTwqHNuAiZ5U1AEImgKnVed6s4
   eppFkgexjV5VaRj5AV7fGk7lc9YDsxjrxmJcXm/WAtkvmjuVuKQVxbZRF
   i5N6g4B1SGT9lzrVxIof+W6aMH+3wzsviiv/pA1wZNjW+cYqHmxV8Tr76
   A==;
X-CSE-ConnectionGUID: UvBjOrK1SzOeebKdHrHUGA==
X-CSE-MsgGUID: 9K00y/2sSJCyLW44JH2MqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41252605"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41252605"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 05:18:14 -0800
X-CSE-ConnectionGUID: uDNp9EBWQLutvTz48CWxxw==
X-CSE-MsgGUID: IotC7fy7T3SwPH8jtWSFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121151333"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by fmviesa003.fm.intel.com with ESMTP; 27 Feb 2025 05:18:11 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v8 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Thu, 27 Feb 2025 14:13:27 +0100
Message-Id: <20250227131314.2317200-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227131314.2317200-1-milena.olech@intel.com>
References: <20250227131314.2317200-1-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since workqueues are created per CPU, the works scheduled to this
workqueues are run on the CPU they were assigned. It may result in
overloaded CPU that is not able to handle virtchnl messages in
relatively short time. Allocating workqueue with WQ_UNBOUND and
WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less loaded
CPUs, what eliminates delays.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 60bae3081035..022645f4fa9c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -198,9 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
-					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
-					  dev_driver_string(dev),
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
+					  0, dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
 		dev_err(dev, "Failed to allocate mailbox workqueue\n");
-- 
2.31.1


