Return-Path: <netdev+bounces-175821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A25A678DE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4092189D5F8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A721147B;
	Tue, 18 Mar 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAoBcdMd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098521148F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314430; cv=none; b=hyKKaUVKkVqfWfJKod5pJvIi3oz6OrDaZxweAObPM1uMKI/xlhVAlFJzHg1w3HgKklabatkNSsGg+NwE2AYal298F2nCcv5y4esgBGh2ggdRk/7qrkkUclGNr6e/4v7K78b+M1Afm/1w7RriK0XE7lTD+ShDi+umWDsg6TPC13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314430; c=relaxed/simple;
	bh=pQkpRAnVQxBXaNMTLoYv15p5v91mGnH/qrlEZt5Gskc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqLy9kerAlHWK2aOo9GuVVHBaFAQZz04CSMdf50OfkaBvg4F/PRiUvry30xPNqz90wRpiK88WF0bWPoUZAOnI0LAlBW/Q+2siJRhck8OvaGWfsZbGLjgqDSxsRyycGoOCyrPgb1UqNTq+vFRRfxgjk27oK2UMIOtT7MQ/qUAKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAoBcdMd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742314429; x=1773850429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQkpRAnVQxBXaNMTLoYv15p5v91mGnH/qrlEZt5Gskc=;
  b=oAoBcdMdqKzWVRfRx8bRBwRkURatSFdBQ7Yblvmh1CBqYtt/rApxD4To
   oz/SLQlspCPpEYm03wgZHIwUQmBjS+n7QKSv1bjNKZ1l0TfFWkZgJWbF8
   Rs4DVtS7p4tA4+XwtmSV5F/Qgv6LgxLXSgU/JLP/X0wiZN+Jjjceo++rh
   cyiuOy66dRJW5fFiCU6MWdFpGT/xu1Kuz7N5BQn4Ej7S7ALGwT7gSl7JC
   dPQtf7EoFDpf4fnqLV3Ex325xKiNuvaLeQ/XxcFqo1K3u38jC4c9pRfau
   ePbRkXR7apCkhaPbwj2NIuWTgYpv7jF10QuVPPAaVmi3QNcHCBXa+gkYi
   A==;
X-CSE-ConnectionGUID: cCsnNAcOQDecHoD1gvIFMw==
X-CSE-MsgGUID: /WsqFQi0Qyup1gjwoxVTeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54458865"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54458865"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:13:34 -0700
X-CSE-ConnectionGUID: EsQwUaM6QMWT7LildxOyXA==
X-CSE-MsgGUID: 0C1juUmbTZipTyZQD2mNJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122041975"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 09:13:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	karol.kolacinski@intel.com,
	richardcochran@gmail.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Tue, 18 Mar 2025 09:13:25 -0700
Message-ID: <20250318161327.2532891-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Since workqueues are created per CPU, the works scheduled to this
workqueues are run on the CPU they were assigned. It may result in
overloaded CPU that is not able to handle virtchnl messages in
relatively short time. Allocating workqueue with WQ_UNBOUND and
WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less loaded
CPUs, what eliminates delays.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


