Return-Path: <netdev+bounces-42754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD77D009C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BF31C20B2D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B97339BF;
	Thu, 19 Oct 2023 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMpLnKVJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050D35516
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58050132
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736759; x=1729272759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2e5umfMsab6ue4cMJEuaxUB+RQvPHIiRu+TRKMkOg9M=;
  b=NMpLnKVJ1q8yP/qBdd3UkqXxqB4db+s7RbteIAUWW7n6C9lUkNPXy9hr
   eOhFud8rCAQnReKuP1XXOf8Uohy7GmBX0eCxXptMcPEMR37TC8cqoWTAv
   0L/cWhl5tiECiqXJZlvRlDNDidLmzHY1mnlimMDPlE0DKLRoZq1ACvNVK
   +5GkFMLK1SpXYZiznGfI0jboStDS5DS7QtTDkOhM71RNsuB6E0EWiOUV8
   54Koxr+BKumxRaOcE7j+PwbBylF511u8zLV5iYG8mgepcpKGWoO/upf2O
   DCdwu0JL0NCwxPGqq/BZvItNNeRhUC7iRwP7kRoBrzpdQLB0U0tR9ZFy2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183726"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722710"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722710"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 11/11] ixgbe: fix end of loop test in ixgbe_set_vf_macvlan()
Date: Thu, 19 Oct 2023 10:32:27 -0700
Message-ID: <20231019173227.3175575-12-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

The list iterator in a list_for_each_entry() loop can never be NULL.
If the loop exits without hitting a break then the iterator points
to an offset off the list head and dereferencing it is an out of
bounds access.

Before we transitioned to using list_for_each_entry() loops, then
it was possible for "entry" to be NULL and the comments mention
this.  I have updated the comments to match the new code.

Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index cd593f5719e1..9cfdfa8a4355 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -640,6 +640,7 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
 	struct vf_macvlans *entry;
+	bool found = false;
 	int retval = 0;
 
 	if (index <= 1) {
@@ -661,22 +662,22 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 	if (!index)
 		return 0;
 
-	entry = NULL;
-
 	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
-		if (entry->free)
+		if (entry->free) {
+			found = true;
 			break;
+		}
 	}
 
 	/*
 	 * If we traversed the entire list and didn't find a free entry
-	 * then we're out of space on the RAR table.  Also entry may
-	 * be NULL because the original memory allocation for the list
-	 * failed, which is not fatal but does mean we can't support
-	 * VF requests for MACVLAN because we couldn't allocate
-	 * memory for the list management required.
+	 * then we're out of space on the RAR table.  It's also possible
+	 * for the &adapter->vf_mvs.l list to be empty because the original
+	 * memory allocation for the list failed, which is not fatal but does
+	 * mean we can't support VF requests for MACVLAN because we couldn't
+	 * allocate memory for the list management required.
 	 */
-	if (!entry || !entry->free)
+	if (!found)
 		return -ENOSPC;
 
 	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
-- 
2.41.0


