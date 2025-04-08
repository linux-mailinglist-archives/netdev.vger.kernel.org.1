Return-Path: <netdev+bounces-180157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE24A7FC86
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F613B2A6B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2E2690DB;
	Tue,  8 Apr 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckFnDD/i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BBE268FF0
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108615; cv=none; b=N1P9eG4MlWyv8LjzL4nGJWB4bAQDRzoFHmBZ7oD4HDpJhmXs5FjLu584imoDyHaEA1KyxVv9BKFnaJgt71K0WxkxWXrh0PEetu4e62XuRvDLzN8g829VJQ5QGNFh++4smr9F+R2srgV2d36S1/s6B9q2GUt+7hO+q98mIKdGh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108615; c=relaxed/simple;
	bh=3Vx/ihRlbHMtnQNkzEUcCKuQ8DY+Ibh9PKfY7sUV+8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhCKRg/vkSlSzAAwZxjR/pciGFOBII9CMqZKw0tpAGP+Cu6bNBkNaGg9Fl6MfkoB1d7V8nqzmXJrHe16pDAct7osUYziE4ZSCjdbryu+WSkK5cbKKA1Rs8YRwHCboZ52J9g6Lrsw7ZCHbwgRxc+eX22wm94D/awTWM6QSGSsDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckFnDD/i; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744108614; x=1775644614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Vx/ihRlbHMtnQNkzEUcCKuQ8DY+Ibh9PKfY7sUV+8w=;
  b=ckFnDD/icFkFs++oDO+HVzCBkRykvrEeFcMzsbpBfkRUqeDzsinEtxMO
   rjjEbLxXZMmPV0M3zJsM45pitXJl5Z0FkJhy4p9SetQOZZuw4MHdn97fn
   wHtOoGx2SVw5w4fRC66CSu/+g3tTbP3WW/+8HYTqSvE5JL54FjhLnaAwg
   FJ7b8UuUHTaKvz2OkFrXkn5Ux82+zp+cAflHM6smSTgkYQzUbuT92VnPv
   fCsKKnA4uxyTUrKsPHcn/jNVETXbGVXRXZXPP6wVJhVAEVR8WbETcAQO5
   9ufbXjY9QQ1gt5pUVP59sSyhEIVbW0/5Bdrr1CcqnBgqH9d+lD5nFW4D7
   w==;
X-CSE-ConnectionGUID: KJAsMVK2Sq6A/Sjeg/Nuww==
X-CSE-MsgGUID: aBtySWpcQZOar+QBQAO6pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56901639"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56901639"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 03:36:53 -0700
X-CSE-ConnectionGUID: lycLOXVGQ/6adLAyjvSAFg==
X-CSE-MsgGUID: mdZdqj0oT2Seat2FjCXRrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="128563539"
Received: from gklab-003-014.igk.intel.com ([10.211.116.96])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2025 03:36:51 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH v10 iwl-next 01/11] idpf: change the method for mailbox workqueue allocation
Date: Tue,  8 Apr 2025 12:30:48 +0200
Message-ID: <20250408103240.30287-4-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408103240.30287-2-milena.olech@intel.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
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
Tested-by: Samuel Salin <Samuel.salin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index bec4a02c5373..1284ab2adaf1 100644
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
2.43.5


