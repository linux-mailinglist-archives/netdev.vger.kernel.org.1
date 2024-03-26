Return-Path: <netdev+bounces-82171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE45988C909
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC01F6424B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6D13CF85;
	Tue, 26 Mar 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oB+0gW3L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5713CC71
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470248; cv=none; b=dzvksqFbkUngVME6dG/GIebs0JXbPtnluUGrmZ73oZKBYOdRb0TfRWZIIZ81zTqGBfyHlLOSyTk3QRpBEMDioKH5/hWd+w0qAKbSdXHfGfCfC2Bn5cbhSpQBeDmVh7bmFhIneTWjO7/zF4aVAQoNP4TGbwYNHsmBMtJ6NzZX22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470248; c=relaxed/simple;
	bh=VS8HjoBFaIfbI5y8plVxaDKgwQrZRmkleXuflkybeps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSwP7fiOvTL7v+U/bMC/oRyYC8u0UvLrmlvJ1sYxY/ZIkVA5Gwm0FyRLOk7hNrFAxh7e9Lh4F5DbY4UcvZQLcMxkSv+fo+zdzhpB5Bn+Mcx8VepQ4ruPvGXAtKA8qpIZFkMv5gfoMJRVx2jp9ClnZ+D3D7VCmK3hc0VTZVIgBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oB+0gW3L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470246; x=1743006246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VS8HjoBFaIfbI5y8plVxaDKgwQrZRmkleXuflkybeps=;
  b=oB+0gW3L3tZY23x1Y/QkTzU0zLhrs//C1BVdke4cIbnkuY5Ps8ac44a9
   Hxe64nIH3QAtHLYzxJQbT2hSV84drQJvyEmvMH+WxuQqmb6l2m3VU8Aoi
   cauT8QMDh1Rl0jyajsj4CV1x93IYoT1qnXsTeT11EArsfLVDm+uWxxAQd
   yeMUBh83rM4PjY4YxSrjXWuufDWlJCbEatbUzol76V6IusdmPdx7CJr19
   GhNVVmxwjcJ18KJ51+vsW79ni8+YRBeLSyPeoIVUwSA5AiRI1fCfPCzRQ
   EDoOFm+40Zq4y11EwlvgEgKwKra3VAejNo9+6/67l0msorT5qigAx/U1Y
   Q==;
X-CSE-ConnectionGUID: f9za5MbjSNSIGJ0GJm9cBw==
X-CSE-MsgGUID: Rl4Hi/pRSveC10N2I+bsXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6471927"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6471927"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16403042"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2024 09:24:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/3] i40e: fix i40e_count_filters() to count only active/new filters
Date: Tue, 26 Mar 2024 09:23:43 -0700
Message-ID: <20240326162358.1224145-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
References: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The bug usually affects untrusted VFs, because they are limited to 18 MACs,
it affects them badly, not letting to create MAC all filters.
Not stable to reproduce, it happens when VF user creates MAC filters
when other MACVLAN operations are happened in parallel.
But consequence is that VF can't receive desired traffic.

Fix counter to be bumped only for new or active filters.

Fixes: 621650cabee5 ("i40e: Refactoring VF MAC filters counting to make more reliable")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6576a0081093..48b9ddb2b1b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1253,8 +1253,11 @@ int i40e_count_filters(struct i40e_vsi *vsi)
 	int bkt;
 	int cnt = 0;
 
-	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
-		++cnt;
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		if (f->state == I40E_FILTER_NEW ||
+		    f->state == I40E_FILTER_ACTIVE)
+			++cnt;
+	}
 
 	return cnt;
 }
-- 
2.41.0


