Return-Path: <netdev+bounces-97954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC418CE4DD
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 13:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3001F21643
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C784FA7;
	Fri, 24 May 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ccx6URR+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C29475;
	Fri, 24 May 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550309; cv=none; b=gQum9D1PQyGm1GkYBUZwT0kfWshL5KropXd1mjaJWY0ljfXXOjRpTXlSPzGlvcK209BRaB0OvoliO9a/+w5s74mbwcQHHfs0oHYgFtmU0uZx1kxV4PFSKkiHm+3ai9jAY5UlNny8n3h2z7yEOCsW3aeNiR6OF9Zu/A2V3s8T18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550309; c=relaxed/simple;
	bh=4LBvQetF7IAlYlAy82ZKXQGvBJrIruYN4l+FdhPRo9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRlVrxzBlFHOTQ2WxHCfqEwQ1ey6OEct0aiaLA5WgXP/U8kVWNGuLGhj8f7ovi2KGsPuvlDp6+Qj+StuUjt+aSbJ07lUGohhvzLC+Lp0BJNzlNHMvcEoiF+/9C/0IB+JkMglqupLA0rQlzs+SlQBEXFaRE2V14oWWRXnjq3t3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ccx6URR+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716550307; x=1748086307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4LBvQetF7IAlYlAy82ZKXQGvBJrIruYN4l+FdhPRo9w=;
  b=Ccx6URR+0/PFlO5Oi0HFar46OGN8+NDZoFhUPE4AoKv+LUGrRo/xNAHR
   IL7xkrudYYTck6uFd2FUq16jEAVZuJRFaQ7y23y8Fv7DZyt06iw+vB4as
   pIg7RiXuFROyV5R4Grx5UwPsNMrCk/qEHyqLflV5bZCSjzoIAV/l8oL/T
   +8S3M3ZH2vLcAeUqbjeZB7LjCMpCNCBVnuLy5UO0czpqIkLTjCu6k0MKZ
   XoH8/EEpw5+6xWEC5OkVBpszY1hwDbscNvVCmsPaW78B8zaItZPu5h+Wu
   JDN1ZqYe5OkORKZs56OuVaQN8cl754LdmsLwcifObwGGXDpKd5DNqQN2K
   g==;
X-CSE-ConnectionGUID: 8+O3WPpLRv60RzEBxqHjbA==
X-CSE-MsgGUID: UF7FIWG7QUGbTWqGMC7ktQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12772021"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="12772021"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 04:31:46 -0700
X-CSE-ConnectionGUID: MbmgJak5T4+/wMghuBMT4Q==
X-CSE-MsgGUID: knQZ5qdJTr6hmbJRHeoo3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="38432250"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa003.fm.intel.com with ESMTP; 24 May 2024 04:31:44 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] page_pool: fix &page_pool_params kdoc issues
Date: Fri, 24 May 2024 13:28:59 +0200
Message-ID: <20240524112859.2757403-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the tagged commit, @netdev got documented twice and the kdoc
script didn't notice that. Remove the second description added later
and move the initial one according to the field position.

After merging commit 5f8e4007c10d ("kernel-doc: fix
struct_group_tagged() parsing"), kdoc requires to describe struct
groups as well. &page_pool_params has 2 struct groups which
generated new warnings, describe them to resolve this.

Fixes: 403f11ac9ab7 ("page_pool: don't use driver-set flags field directly")
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index b088d131aeb0..7e8477057f3d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -45,16 +45,17 @@ struct pp_alloc_cache {
 
 /**
  * struct page_pool_params - page pool parameters
+ * @fast:	params accessed frequently on hotpath
  * @order:	2^order pages on allocation
  * @pool_size:	size of the ptr_ring
  * @nid:	NUMA node id to allocate from pages from
  * @dev:	device, for DMA pre-mapping purposes
- * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @napi:	NAPI which is the sole consumer of pages, otherwise NULL
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
- * @netdev:	corresponding &net_device for Netlink introspection
+ * @slow:	params with slowpath access only (initialization and Netlink)
+ * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL
  */
 struct page_pool_params {
-- 
2.45.1


