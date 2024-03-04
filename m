Return-Path: <netdev+bounces-77241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111F870C20
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F0CB2481B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3211185;
	Mon,  4 Mar 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpFo6nIU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974D7B3E6
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586333; cv=none; b=h1LSRe56DDWx64taa4ItB28r8yH311CywG3xLkJg909eyiDDbghrrcohq9NUsK99esCCAxUUPHimGdMHBHySBgAQQ0TmxRcn95wLOa5/PdJfsyLTxAIXjiOZiTyS3dGda7eGyIecx3yyfMJop6pva5GhtJeiSJyeScdi3//scE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586333; c=relaxed/simple;
	bh=amfHQn+EQN/GB47nYkDkcgApI85825GqjX2Dfj0Esss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8ltqTvmDzWcflZua/cO7VmUGKVIRkpB7LGZWOv/LpYsUp748kc3zg15dslLwXrWavLjOvIPJWKAuZoWo018A1H6GPpDR94PsAg5SLDGWJEPcWZxaMXxIgz6Czc6Ic4e/E18zRfinjj/7tU6nATbknYTTnhEwKqzdqGfaNXtC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpFo6nIU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709586332; x=1741122332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amfHQn+EQN/GB47nYkDkcgApI85825GqjX2Dfj0Esss=;
  b=lpFo6nIUro8nrgSP5eIlCvqUxzlms/IurHQnpIjN8qXB0s05xPyicFdI
   8fVUcD2cUru9xdKWyQcvueKDN8T6SDnKMZRZzaO6ywuAYttpFmxfAOrq7
   g4oHkKgPp0gQ/2UXNj+wl0OlrP32bEs17YcReN3e+pVftQLVdMjBkrNoW
   YnkzOgtlacTanyGbOIH4JL2iCRqKZDFGsVbNw4AAYMpY18ndgWGWXnDq5
   g5+whiGzGjMzGZG7d2dE8E/mgNRPLVlhdsZi4W5+0cZS2kX+XTmpXCtyp
   C51CeHgs+OmNoVYQqvVFJDxume3cWgEmEwa/bGqrXFQJmxwhR1bmjtVgL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21561125"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="21561125"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9539754"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 04 Mar 2024 13:05:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alan Brady <alan.brady@intel.com>,
	anthony.l.nguyen@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net-next 11/11] idpf: remove dealloc vector msg err in idpf_intr_rel
Date: Mon,  4 Mar 2024 13:05:11 -0800
Message-ID: <20240304210514.3412298-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
References: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Brady <alan.brady@intel.com>

This error message is at best not really helpful and at worst
misleading. If we're here in idpf_intr_rel we're likely trying to do
remove or reset. If we're in reset, this message will fail because we
lose the virtchnl on reset and HW is going to clean up those resources
regardless in that case. If we're in remove and we get an error here,
we're going to reset the device at the end of remove anyway so not a big
deal. Just remove this message it's not useful.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 0714d7dcab10..5d3532c27d57 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -79,19 +79,12 @@ static void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
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
2.41.0


