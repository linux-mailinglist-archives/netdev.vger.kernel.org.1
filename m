Return-Path: <netdev+bounces-26511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6718B777FCD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3201C21191
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129C22EE0;
	Thu, 10 Aug 2023 17:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA221D22
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:59:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360E0270F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691690385; x=1723226385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36jgOgLbyEbm/tPJDZDsKMsQ7azzqjrfSfIwSGNGBCI=;
  b=Co9c01qSiu790epff+OehfiJSPI2hymodtaM9OMpPuX6dECS/Sh1A6Au
   2Y+ZRhFzv4U4qhYVZWvHiCKj9iTWunJjDjseTckZer2l9UHzYZUb3bj0I
   zg5kWOFpIWzEv2ZWi6mtYQi18n6Zj6QaCVG+cw2jjMcwB7ygw8DjJkf2u
   JDc+LvEf37xcGH5PA13kFqeiLqofsYetxR1dGqiYfR8zQezKtNedEyfsR
   /MT+BGZ0PQoGJHOe1e9aJxOsm70K7b4wXnElKHwVFgKQD5ZTOYu4QvmGw
   CXK4k9tfVJGRjZ3dGnbF++ilJ8aQycQXPNIKNFAGFLxTvEBae4NY5nuJB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437825466"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="437825466"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="725933340"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="725933340"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 10:59:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/4] i40e: Replace one-element array with flex-array member in struct i40e_package_header
Date: Thu, 10 Aug 2023 10:52:59 -0700
Message-Id: <20230810175302.1964182-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
References: <20230810175302.1964182-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct i40e_package_header with flexible-array
member.

The `+ sizeof(u32)` adjustments ensure that there are no differences
in binary output.

Link: https://github.com/KSPP/linux/issues/335
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c  | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 969120587cad..0e72abd178ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -220,7 +220,7 @@ static bool i40e_ddp_is_pkg_hdr_valid(struct net_device *netdev,
 		netdev_err(netdev, "Invalid DDP profile - size is bigger than 4G");
 		return false;
 	}
-	if (size < (sizeof(struct i40e_package_header) +
+	if (size < (sizeof(struct i40e_package_header) + sizeof(u32) +
 		sizeof(struct i40e_metadata_segment) + sizeof(u32) * 2)) {
 		netdev_err(netdev, "Invalid DDP profile - size is too small.");
 		return false;
@@ -281,7 +281,7 @@ int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
 	if (!i40e_ddp_is_pkg_hdr_valid(netdev, pkg_hdr, size))
 		return -EINVAL;
 
-	if (size < (sizeof(struct i40e_package_header) +
+	if (size < (sizeof(struct i40e_package_header) + sizeof(u32) +
 		    sizeof(struct i40e_metadata_segment) + sizeof(u32) * 2)) {
 		netdev_err(netdev, "Invalid DDP recipe size.");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 5f61546f50d8..08ad83ee4a43 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1455,7 +1455,7 @@ struct i40e_ddp_version {
 struct i40e_package_header {
 	struct i40e_ddp_version version;
 	u32 segment_count;
-	u32 segment_offset[1];
+	u32 segment_offset[];
 };
 
 /* Generic segment header */
-- 
2.38.1


