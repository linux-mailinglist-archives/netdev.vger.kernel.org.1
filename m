Return-Path: <netdev+bounces-158084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22785A10669
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46396169D17
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7361C2337;
	Tue, 14 Jan 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbNYOxxX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80C236EC3
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736856966; cv=none; b=a8auNuvn8D1FAOSGSRcEW0SJAK7RqewJ8Zv9MmMW7KELst3TWstqq1sZS13TpHeE+wVMjAUMsu8QdoiAvDS1dDS5rtrVdjNY11kfX4pkUZIXg9qUmcWHvLCRmgL+jxzAz26gsQ/rPxkb9uxoURhFMi/uJfILYQcnWFWSI7SLpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736856966; c=relaxed/simple;
	bh=lO44xu74L9hP8teUnj4QEYpRhlSZ+ynqWFZz1/lGBeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8BNDBIrbhJxLBZlKU83iGrJoaiNrJjNBv5twyJFLdJkn99UGdKuCJTVKCRkBvZ3ClQFsOUV/tSV4eUqx14pAbunZig3pfwWYXgToJhez/Nbo5EZRcNVdR8Jn6Rzsm06gqgX0ClTCgJxTtuFgpLUHX5VDBAm7kQSYEjMVzy6jz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbNYOxxX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736856966; x=1768392966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lO44xu74L9hP8teUnj4QEYpRhlSZ+ynqWFZz1/lGBeM=;
  b=gbNYOxxXeka+YiKROrwoQLkogW1ebx3sJneTplnLE0GR2jZg818A/9I+
   fxhK2yYI5scJ8PlXZhuOV7CQHoBGBPr3r3KyUXTl97li7eidzTK3wZIG1
   RtK6ouaktn6JtpdEK2j8oookNfjigddkahIy16uh8tIdkUtTRTbJ1NGS0
   8XAKmx2MDirmZtYMqokxzUScm3UDgATLTOtRTEWuLYnJ29ROthqdn4T++
   k5u2aoaYU3crrZVzUsolEDFMSs2JYCh34bwp04/rqT23WafJ/GW1k6Dj7
   DBYJGwMkiVLyDuFaypgmAhReWle3MeS4s3xTuLYboJloYSeJJPiNRIs2Y
   Q==;
X-CSE-ConnectionGUID: eJ57KmxdS4O3w2QC0iovtQ==
X-CSE-MsgGUID: lmO/S83OQ26iAxzmcmpE6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59632214"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="59632214"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 04:16:02 -0800
X-CSE-ConnectionGUID: GeZJJfpZRpqFfjmUHvCfFw==
X-CSE-MsgGUID: EPpvYxebRi2DdBngBUzTwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104642148"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 14 Jan 2025 04:15:59 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v4 iwl-next 10/10] idpf: change the method for mailbox workqueue allocation
Date: Tue, 14 Jan 2025 13:11:17 +0100
Message-Id: <20250114121103.605288-11-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250114121103.605288-1-milena.olech@intel.com>
References: <20250114121103.605288-1-milena.olech@intel.com>
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
index 85c65c2145f7..66f9e4633e3a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -222,9 +222,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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


