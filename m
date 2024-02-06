Return-Path: <netdev+bounces-69369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328084AD04
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 04:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1496DB22B7F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977EF7762B;
	Tue,  6 Feb 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+fvVi9a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33974E07
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190724; cv=none; b=RG9CESNVzN7ADlnuXbicOaC9cy1k0AmJhZXBFqw57mLteds4thKsTLlHAlfzMvS4Y7itwna+vhlSLWiYcId4FzyPN9LjAP7fL3NT/E4c4rzKh03ksU+H2oGLVXAovPPUWYNJ/gsURMgNSopQKeP0jJdojdeiaJMG40ewYIN73+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190724; c=relaxed/simple;
	bh=LII/pxHUmQjvXxWY8Nop+EybCOMdIUqmiemtNt9IPU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MC2FK6I0N5PMPxAIlM9JAXyVVwa/64M/EXA+ReCNc5c+1rH5mxiOk7Dvurtbe4/7vGInUD4Zxozkb2BApDRgDOFHEBqxd0ZSHPPZiZ83NjxsBafFOJ8st5PN6DMsqDYrKayn1KwYyah1l0uQMMDknqd2eSq8S2XKE0NbE/GpV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+fvVi9a; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707190723; x=1738726723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LII/pxHUmQjvXxWY8Nop+EybCOMdIUqmiemtNt9IPU4=;
  b=F+fvVi9azMRYSkfOhuqgPp4jlUDsi2gPkBRZyfoxVkjMe7o949n/z1OP
   k1xmDHuHdb3KmSPKMJAd5yDvKgkr45xuGOY1xbmDy8NAmPZCTdEsuok1t
   V+6B01qohQcVhA3uRuhImSaqWvYMTgsQYJjn4HeXjXxWVqLRno4/RAMuJ
   wqmBEk5wppaQjPZHdU4kzzW314tB9ceARDd1kQcY93elCj5fZFRP87u6y
   Dkck2DS/xdeG3jyF9R4L0pIHcf6ZBhp5LhGDfDemOIYEv1HzhnBsYX3vn
   5jPqP0Dt29Hb+ON040y+WJ1NMCY+kBNJyOWw0T2xw0uIcA+m7mGOTIeh0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824878"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="824878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 19:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5653958"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by orviesa004.jf.intel.com with ESMTP; 05 Feb 2024 19:38:43 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	przemyslaw.kitszel@intel.com,
	igor.bagnucki@intel.com,
	aleksander.lobakin@intel.com,
	Alan Brady <alan.brady@intel.com>
Subject: [PATCH v4 10/10 iwl-next] idpf: remove dealloc vector msg err in idpf_intr_rel
Date: Mon,  5 Feb 2024 19:38:04 -0800
Message-Id: <20240206033804.1198416-11-alan.brady@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206033804.1198416-1-alan.brady@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This error message is at best not really helpful and at worst
misleading. If we're here in idpf_intr_rel we're likely trying to do
remove or reset. If we're in reset, this message will fail because we
lose the virtchnl on reset and HW is going to clean up those resources
regardless in that case. If we're in remove and we get an error here,
we're going to reset the device at the end of remove anyway so not a big
deal. Just remove this message it's not useful.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 1aae6963628b..1e30ef98cd68 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -78,19 +78,12 @@ static void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
  */
 void idpf_intr_rel(struct idpf_adapter *adapter)
 {
-	int err;
-
 	if (!adapter->msix_entries)
 		return;
 
 	idpf_mb_intr_rel_irq(adapter);
 	pci_free_irq_vectors(adapter->pdev);
-
-	err = idpf_send_dealloc_vectors_msg(adapter);
-	if (err)
-		dev_err(&adapter->pdev->dev,
-			"Failed to deallocate vectors: %d\n", err);
-
+	idpf_send_dealloc_vectors_msg(adapter);
 	idpf_deinit_vector_stack(adapter);
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;
-- 
2.40.1


