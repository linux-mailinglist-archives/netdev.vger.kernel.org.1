Return-Path: <netdev+bounces-222447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FEB5445D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D5F4826E3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1026CE39;
	Fri, 12 Sep 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsFihojK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DD2E401
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664137; cv=none; b=et74smHzHFEaLfYrad4ASfV6+5TyCSqtV65h/yB0Kc3IQd2ETVClunBxVWbWFiGGyHRhWm4XiO42fRNrEJOeFhocITdnDQz2VMLdm90dJQlS94QwK4KJ/D4SzfvcihLEDTNhqkKsrPoLvp/yEzt0UO462Q3BmE0R0DdvjGwtlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664137; c=relaxed/simple;
	bh=NY1dbSZxO/GwHQrfJwBU/bjMhe+uXEvezSrhBtjVNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOoPecxVdSjxSTwnqkvkGZajH0mnS9Ju/iPqNdRj5fr70w5ysrHiFh+Q4kdgOO80sPDBwC0HotCB/TOdejle2i/+qWR5fZ5RzOvq0Skqo0/x5L1xhXE1GGdBeK2ExHbJpg+gyUfNk/3vEvfvT/gKuX5LIN8yULf+QxTMbPl4G9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsFihojK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757664136; x=1789200136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NY1dbSZxO/GwHQrfJwBU/bjMhe+uXEvezSrhBtjVNNk=;
  b=RsFihojKoKPAODXbQJy7eeruLyiS+WHLjPBIlkOrDAwfmiomqVOy7mbV
   r68aly3y4UM/AV39toBPtJcIKvOIhG14FL40UHj/iQe5xIMM87u81Ec6H
   ccw7FL/9MgS4SUCc5zjKU9id+6GFitQCPMGDRXsjsoqBY3P1wRJ6s9Boz
   s0FcOjDgkGTnJhUUF5e0mR8CRFtPiWx8wqEoeGHoEVZL8A1KmxTAF5PBf
   G8TN1B7KvGVO4WBe+I8uoqd1cgLXY0WZJwPS1oKpiu1uSMpNdh7bvs2L0
   bKeveQKM6n67zMIuTfVbU5emluMuiL8k5iWYnXvyPiie+gKV7rn0U8bLO
   w==;
X-CSE-ConnectionGUID: ou42XsfWQMyU1H1A6i2eCg==
X-CSE-MsgGUID: rgCyPoITT7WfHnlXXGwTKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60069064"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60069064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 01:02:11 -0700
X-CSE-ConnectionGUID: V9PCujxnReiNIBnTwgQGKg==
X-CSE-MsgGUID: YZgxGvOYTo6joEItNJ7Ecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="211060316"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 Sep 2025 01:02:10 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1] iavf: fix proper type for error code in iavf_resume()
Date: Fri, 12 Sep 2025 08:02:08 +0000
Message-ID: <20250912080208.1048019-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'err' in iavf_resume() is used to store the return value
of different functions, which return an int. Currently, 'err' is
declared as u32, which is semantically incorrect and misleading.

In the Linux kernel, u32 is typically reserved for fixed-width data
used in hardware interfaces or protocol structures. Using it for a
generic error code may confuse reviewers or developers into thinking
the value is hardware-related or size-constrained.

Replace u32 with int to reflect the actual usage and improve code
clarity and semantic correctness.

No functional change.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 69054af..c2fbe44 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5491,7 +5491,7 @@ static int iavf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct iavf_adapter *adapter;
-	u32 err;
+	int err;
 
 	adapter = iavf_pdev_to_adapter(pdev);
 
-- 
2.49.0


