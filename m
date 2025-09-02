Return-Path: <netdev+bounces-219364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC16B410B7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFB2561F01
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF828134C;
	Tue,  2 Sep 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAQeJFUR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5227F195
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855304; cv=none; b=MLtn6VouT8SejQeGd5QIiNAn75p36Tb8/i8jg64KThe34w4IHvFf73dQMxT0UuTrRnNfXMwZH7p3G3SZIXB8HVKZPOajVGBjASCCIAO/+BE4MOJzjEgmL8UUngwD22bds3+m5BrinyBHaR9krRuU2UpTcmwGJmIu61VaMqUF5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855304; c=relaxed/simple;
	bh=XGOpqRz6sbDpwTr3VpOPxIY1HQzZDTDfKW+p19iO7F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzFSGOvjQxnuIH4i0UikZ/pBIJ4L6Z98F76kTeqJkSy7Yy1f8yvbj+hO+SJLkEbgNIx7wjmwJaqGeBH1tv3EdNN+SfnBOJfVmj7U1xOlhcVwptMmtQ0tEfdswpQEXZrJTU44YL26FYQSQjyML5NVHo8no+6bdq12myE1j/ss0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAQeJFUR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855302; x=1788391302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGOpqRz6sbDpwTr3VpOPxIY1HQzZDTDfKW+p19iO7F8=;
  b=oAQeJFURY8hHbHHZw9NMtH+sziVZsCwfxTabZNX8IUpDipkOOBGCrTAj
   JGnG/GSA33a0JQJdM/s2Z1XXKgi+koZMDE1IpG/I6OdyKXF3Tzb9gC2Lm
   /GzRwtg/nK2QxQZvCUgmJcwEL3O2m7bjFTFwUqlBDzlmvO3QTwTGXPBAl
   66NeM3EUiuB5HV2QhLUPJD0vQfNq2GgVXQefE+Tc41RkeWdJ2qB/F9ZTO
   XO9PWmgd4j5aZeDf1L15xuF0J46msMw1ooJNw2Ilyu/MOUSHZcDwMKmGk
   uMU82SrYhM2wB+YuCpuyB51f5WJZgWlpSN1Nb2rsy+OLK2ytj9Lze7v60
   A==;
X-CSE-ConnectionGUID: nvqKi8YqQxq4poMeCsa5zQ==
X-CSE-MsgGUID: FGYDc3LJSkaUfCS5wdLuhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767225"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767225"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:38 -0700
X-CSE-ConnectionGUID: ABGaPbTTTtCLVUc4eAF44A==
X-CSE-MsgGUID: HwM3vA2ZT1inCctG6Mi17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575906"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Zhen Ni <zhen.ni@easystack.cn>,
	anthony.l.nguyen@intel.com,
	dledford@redhat.com,
	przemyslaw.kitszel@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net 6/8] i40e: Fix potential invalid access when MAC list is empty
Date: Tue,  2 Sep 2025 16:21:26 -0700
Message-ID: <20250902232131.2739555-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhen Ni <zhen.ni@easystack.cn>

list_first_entry() never returns NULL - if the list is empty, it still
returns a pointer to an invalid object, leading to potential invalid
memory access when dereferenced.

Fix this by using list_first_entry_or_null instead of list_first_entry.

Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5f1a405cbbf8..518bc738ea3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -359,8 +359,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
 		goto free_cdev;
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
+	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 	if (mac)
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
 	else
-- 
2.47.1


