Return-Path: <netdev+bounces-73501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D0185CD15
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3C31C21FFA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625720E4;
	Wed, 21 Feb 2024 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyWD2gCC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE257468
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476662; cv=none; b=Jabj3Kq8SMYS9KUUh765nogGVHqYhXwjbZj4JOpfstedpQyzbaNGCku8xgvgtOpfs8YkNuz4+uEANdccFQnqtmEgxiZyYlG6HsnFGSUkl/Ldx0n9zqIYCMqCfpGWRe3+KQpbN2JRJb1WKn0fj/jm0WKu2Ioh+IRFcuqmrx4V5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476662; c=relaxed/simple;
	bh=P3ldWfnbctUdIGUueUJiC1QMP2t3BC8zgPf77u8WyaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtTg+nkUnU7iJJVq/cr3xVd0afx7f29wUuQo0df+stR5gPZvCaiD5t3mVYPNnJNj1cGsRQ11UxCKfImgF8OaN07DYR1Ydf2aAjN/T5PZ/hAHbUFGJ6iPJZm/zDogpgYy69BuPcTMZlygeci6bwaCxJA4MOezs2Js+56uPbr2rGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyWD2gCC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708476661; x=1740012661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P3ldWfnbctUdIGUueUJiC1QMP2t3BC8zgPf77u8WyaI=;
  b=WyWD2gCC+mSbICm0A9qs6gzv1T/e/Nn/S1m0wYMgMRVxCpJ+GZOBdonR
   saN70fmX+4w3H+IAVkrl4l61SPK4ZqgpkRjUM/u0fMzzYlfl20qUnLSSx
   zvO5rCLC/mFpZCUSk5l6QP1aMalqZSmS3TXSD3hkvD/g66D39Weu3FniJ
   5yFsE0RecbVEUJfUJb1V9C8vyD7JDTlJ3oQ0Yf2k0zMp91zb8Tq89XV5P
   NvHGD2RQQFTeBmxQGLZrjWwnZGQXfozydXEyIICyNhU3fX77oK2vBizpC
   zweO3xTIDXjp9qgTmHIJNd5rIgLUwjgYomTDD7iwRQf665QvZz+W8xNBb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2500825"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2500825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9551006"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2024 16:51:00 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v5 10/10 iwl-next] idpf: remove dealloc vector msg err in idpf_intr_rel
Date: Tue, 20 Feb 2024 16:49:49 -0800
Message-ID: <20240221004949.2561972-11-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221004949.2561972-1-alan.brady@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
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

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
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
2.43.0


