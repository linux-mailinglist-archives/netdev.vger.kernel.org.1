Return-Path: <netdev+bounces-174700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C948FA5FF00
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E5617C4FD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509491EEA37;
	Thu, 13 Mar 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcnHBRNX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA2A1E51EE
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889612; cv=none; b=QeC89UHleMXKn84JEHkVdJBvjGEmf4Z385be1gKyCBLcc7WWyc4ERZB14JigezTk4AJL621biBDL3KuzRzCsI3VLBa002qPFePRc19Xj3NFQUHO+Q7eO0KHwTsQIZtxGyuSUOeg5G1qFk3eWCepnM8Ee/iBQIwI5BsOS79+SmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889612; c=relaxed/simple;
	bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4R5JDsSDLBOhDukr6mBm24WqKdG1FCCDXg539+zKDLT+fEJ5i1CB+Y7y9oykjSaKK+xfeqcyNslvbMe4QgFiDfGw7hRVVVDA/5IMfdghZvhW19N2/27wc9wLLU942ZeSBAi1fjwrhxbM+EzPrxEQIBcHww4/eyH5+Wz369MMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcnHBRNX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741889610; x=1773425610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N77XQ5Q5mO4PoQ6m80+S+vewn+DOxv1GOBJVib08tpY=;
  b=HcnHBRNXKRd7JteQ5oHnqDOGWR280XUc734FAOqsLl9bDeyLjWnKc9lY
   //Cij/h1KJh/Oqk6EHju60K0wjuRLgeqkz7GLxnRxx3HV6gcM986BkQO5
   82L+8TtHtWxbNydDOzUvUAOJR0RBVAMS2eTeKo4Eeh651nCA3PWuMIxK/
   OLeKzoer+04QeCpmhg3quZVL1tK9Pd/rTfCOe9MPLIqQScRDJYzwm52Zp
   7HoighAbrLRnWYJj+tjuD49Jxb8LIUoOsP8CI3I6XmJg/bZ76S+KiiXIL
   UgOXJlW/pJ2VB+MmLIjDIY9RR8T7n7TfZpv5Rh393CU4ozIhysPX+k4fQ
   w==;
X-CSE-ConnectionGUID: 8SiUVyRYSJ+SRzK1UpeQHg==
X-CSE-MsgGUID: 12MsrXuVThapb8mMlqluqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="45796156"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="45796156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:13:29 -0700
X-CSE-ConnectionGUID: VDqiAx98RHCN69gZB+8IFQ==
X-CSE-MsgGUID: zdw+c4wdRva4d9ZECrC+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120990628"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 11:13:28 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v9 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Thu, 13 Mar 2025 19:04:31 +0100
Message-Id: <20250313180417.2348593-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313180417.2348593-1-milena.olech@intel.com>
References: <20250313180417.2348593-1-milena.olech@intel.com>
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


