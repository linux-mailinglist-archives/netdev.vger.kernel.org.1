Return-Path: <netdev+bounces-74132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421D860231
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF81C2669F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499796AF8E;
	Thu, 22 Feb 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XE0ucoeU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDE14B81F
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628714; cv=none; b=t1l8QE8Cy2t5UGJzKfY4sevanTs8f6ExI5fJe3wHr/TgB5y/V0d7+4gBWxUhqj8JTPgzmzrDbxrdPCoSVWPLvyYAk1uHI6A7rlc4eHLMbrGiT9SpqxatDxkKqB/Xv9t53vqNgoXdC0DDm5Uug4BbBHmO7jWM+jsNdBXQ9N/ctNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628714; c=relaxed/simple;
	bh=wA6maNwAMiuZt50va+iiGSJ9t208euuKhsCRPNUJd7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aibXRhiFlZLkyUHpcLRJXAfvqKSL/6gN5Fi/eiD9qerkWBIeo8HZ4QnYzgY3j4CYFqY5L2Fs706Akw++IAx+j7hT8P9Zbv9oHyMAy1aWeQ858suBOG2lcKWWxVPIAyx+iesp6L60UtXGuWxWRGrbKV7UrWahIT7t/YdS1bzSyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XE0ucoeU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708628713; x=1740164713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wA6maNwAMiuZt50va+iiGSJ9t208euuKhsCRPNUJd7w=;
  b=XE0ucoeUvIF/kXdjRD6+MkHLfj8ao18+5Pz3X87xR+uJAaoeoPSL0rk0
   sBVrt749cYVd07mNGTxAq7Dr88Sf0AmbSL3kwak+gvvKjfY5iwPl9drw+
   uhccXNxhzTi7I8xSkwv++k7/n3g9vHUPRsDNi0fx3llUwtxoC2O+mK3Bc
   wPcCqQ7Jqx+svZmnULUk+T54Rd0s84CczgA+STz1iExojT2SnsopMMnvi
   ZE2bXUY1ZiiW5AbeO++V8NLdk7pnNF/siQ+tM6ChTW0g2zyVU8NDFsdFi
   5zpDpjkzAasiBOj3c29zK/Ror3HEfdvz713a3WP3c6ttYWzDkeEUsC8zn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13506406"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13506406"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10171453"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 11:05:12 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v6 11/11 iwl-next] idpf: remove dealloc vector msg err in idpf_intr_rel
Date: Thu, 22 Feb 2024 11:04:41 -0800
Message-ID: <20240222190441.2610930-12-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222190441.2610930-1-alan.brady@intel.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
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
2.43.0


