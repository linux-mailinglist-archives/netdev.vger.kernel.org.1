Return-Path: <netdev+bounces-183272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741DA8B8D4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654894455A0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519D248863;
	Wed, 16 Apr 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHnIgd+W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356423D297
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806203; cv=none; b=MZZCcRg744FtcGFyCHhyuPZ+vQ0aoglwGwCkqudIM1B3tRUpvoudxT6agSyWpBXQ3QzJg/LiL5qhvDf4pEriVMwOCBcyt+zHjRPBvBHf0Qbxwy55uCLydzF6OjReGtKUa4O5WIjJP2uTIbyG/S2QNRcVBKb18e6Qd+cp19hvF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806203; c=relaxed/simple;
	bh=UfUZTnpkqFarf9gI4qKjcYq2OtTQz2Q8GNh6+FeVHRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foujhSfd1d2wvkccU3V783Yz9/DlZUfESRFMnrB4H1ecvZBfQ3PEQuFPavCgBt8o2Gcj8/RxDLlpxiiCzhZH9Exa7B/QBn5a7ljcWmGAEJfLYDK3+HbEgXJ97DXm9oHr6KQfEgQ6jFeIyKO/ps3pjovA9KXIVqlm3i/0Y1SvE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHnIgd+W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744806202; x=1776342202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfUZTnpkqFarf9gI4qKjcYq2OtTQz2Q8GNh6+FeVHRY=;
  b=jHnIgd+WvBVKtH35Dv1iBqwvkUkgv8mWqKJ8wB4atj+7UZhC2c/YYuQ1
   VLePanaKk6s7TkfoW/yboAdRizxJzeX/1tz9/AW+7GYk6DFWmp+KVnxhP
   dIMyrLx7qG4Vi4uMbEnALY+UL/irV/idAux4CySHuRb1dUD+1sY+hxTFk
   xlc7TM5mxVug2KHt1w2CtLU/nBuFsX0bhUfLoih9TsBDCc0Q5affg0+6G
   nZp91VLHr2wnCSxNqRuTE+NeiGJQ6+hVW9fK7GA7b/OJrepEMNh23CssQ
   boQbNEFYQoq5Pp5djqRzqiz955iIZ+cnGQXU0L9B1ENar4hefV8+hKgyD
   Q==;
X-CSE-ConnectionGUID: RfdhSSQCQgeIJaQ3RndAuQ==
X-CSE-MsgGUID: JI2xLT+BTD6rhOhVk97Mlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63889117"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="63889117"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 05:23:10 -0700
X-CSE-ConnectionGUID: 7n1YVcR0TlygIe+yKQsN+A==
X-CSE-MsgGUID: zP28kbLQRaef8VO3hw1aFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130477287"
Received: from gklab-003-014.igk.intel.com ([10.211.116.96])
  by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2025 05:23:08 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v12 iwl-next 01/11] idpf: change the method for mailbox workqueue allocation
Date: Wed, 16 Apr 2025 14:19:00 +0200
Message-ID: <20250416122142.86176-4-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250416122142.86176-2-milena.olech@intel.com>
References: <20250416122142.86176-2-milena.olech@intel.com>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b35713036a54..ae7066b506e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -199,9 +199,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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


