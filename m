Return-Path: <netdev+bounces-277974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GL5D82b3GkxUAkAu9opvQ
	(envelope-from <netdev+bounces-277974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D963E846E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F2A630120CA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D038AC79;
	Mon, 13 Apr 2026 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ6x9nAX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DB3939D0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065447; cv=none; b=g5vV1s1Ejy7Aw6lrv4BLDJ1D7BC+c1ZtNY0i2S2VwwbppmHE6eNuVROC+IRw85VUCTw/fzOrCh90SCQtIgrBlO2EyzazZXwUYFrx7GW7TXVFrjMeZTZzh/NFdQn7mqHJpAgZqTzkE7f5WvUsK3VCGqUV75EbD9lbTQbwtuzG3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065447; c=relaxed/simple;
	bh=W9ya2vXRkq7Xpvvhcfs8QUpkp0MBFOwlS2aQ4IaNQn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rycF/eqNRpMp5M9gglaixlzF6q7Gd2aoZ1Eljvv21OsdczackOA1BwbLuz7c+kn3MLZrmWEsyi9sBVyYftC5uS9E9Eg4mwqo/Lsf/FXRyuAfiEf1NfjqiPu4dsFmfCRU5dQgjlk8lvbF57voRtr7fh/KX5ElWrNNcwhGaTK3IN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ6x9nAX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776065446; x=1807601446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9ya2vXRkq7Xpvvhcfs8QUpkp0MBFOwlS2aQ4IaNQn4=;
  b=TQ6x9nAX4SHvStM/9eH6/a7HiLnlSTrFcCXkfgMcPrrBsYnm0qUfJcqh
   dnjgymIiJLWpHWKnDiM+WV23d73eqwyZ+WnN0LlNizfgpZBvu9EIjohZF
   3aQqvJDtZi40hd3i6Rxm+xCtAkXVSoZSmhdEMM6OYnCuCMTdASFuu97As
   dcIEASsDMEOhXJfhhZkCNmc0u1D3Y8agmsTxDtNnaD0DdW9qazxJ9Xs1o
   oZYiYmQyBvluN0FXdfrTMb3oZUolaDpCB2RLfg9/CzduJwpaVE7QXt2sT
   zR3K+CDBtM/fN/bkqEbFnne8nvrtZTm1nLSAGKgJCdHKYkCIEVG5199aE
   Q==;
X-CSE-ConnectionGUID: 5IfszJiYTwO9/ZYgUBNOzA==
X-CSE-MsgGUID: VJcWMm5IQdCneXXvzymjOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80876644"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80876644"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 00:30:45 -0700
X-CSE-ConnectionGUID: NTVZjr6ZQHONvniZ2cX5dg==
X-CSE-MsgGUID: BBmfq9oATGyMdBhr/cHfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="267700568"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 13 Apr 2026 00:30:44 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kiran Patil <kiran.patil@intel.com>
Subject: [PATCH iwl-net 5/5] iavf: return 0 when TC flower filter not found after qdisc teardown
Date: Mon, 13 Apr 2026 09:30:35 +0200
Message-ID: <20260413073035.4082204-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,tor.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277974-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: A9D963E846E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kiran Patil <kiran.patil@intel.com>

When an egress qdisc is destroyed, the driver proactively deletes all
associated cloud filters to prevent stale hardware state, decrementing
num_cloud_filters to zero in the process.

The kernel netdev layer is unaware of this implicit cleanup and may
still try to delete the same filters individually. If the filter is
not found in the driver's list and num_cloud_filters is already zero,
return 0 instead of -EINVAL to avoid confusing upper layers that
believe the filter is still offloaded in hardware.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 5e4035b..05aaae9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4175,7 +4175,16 @@ static int iavf_delete_clsflower(struct iavf_adapter *adapter,
 	if (filter) {
 		filter->del = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
-	} else {
+	} else if (adapter->num_cloud_filters) {
+		/* When the egress qdisc is detached the driver implicitly
+		 * deletes all associated cloud filters to prevent stale
+		 * hardware entries, reducing num_cloud_filters to zero.
+		 * The netdev layer is unaware of this implicit cleanup and
+		 * may still request deletion of individual filters.  Only
+		 * return -EINVAL when a filter lookup fails and
+		 * num_cloud_filters is non-zero, indicating a genuine
+		 * lookup failure rather than a post-teardown stale delete.
+		 */
 		err = -EINVAL;
 	}
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
-- 
2.52.0


