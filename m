Return-Path: <netdev+bounces-148270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E89E0FA8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3846C164943
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8602500DF;
	Tue,  3 Dec 2024 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJZkGHRv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CA63B9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185603; cv=none; b=pD3Aa/MpvEtAMRZkvA3UjkwgXCwTXgo2uqYwwWhsXUilcJJPK9L+ljXtnC/Yp/A0nHCMvjSvgZGiP2/XiGlbz0YLDHy3B3fSqvCN3+2m9+zEtUqMJMOfU0kdwk8cG+UnCJWOHaIaBKI/yGCYRRvWrvJOHgf/RM95rRHUC6UlRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185603; c=relaxed/simple;
	bh=jzVsU+tttxm8IfUHHUpvkT2TCP2ifIbrzkPvui9Agp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LM7N8Y/mq69SNF48EBH/rJLBR2xETKB92wv9ZQM36F3riWsw3nRIPxzJ/ic9VXSJYGSuSKLPoQA/uH0MKFwuHuhPDnAynbHNR2c2o3vsXCrpTpZydCQy90kmO3c7YL238EC6iB79DsXKPcEfkbEdJwfD+nhS8USb8jrX+57VniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJZkGHRv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733185601; x=1764721601;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jzVsU+tttxm8IfUHHUpvkT2TCP2ifIbrzkPvui9Agp8=;
  b=HJZkGHRvlJtbzuqfhCPZOLVoYMRyTVNBgtYEdBsB9Mqa/QHOoE/muFmM
   h2WRD7UUnHaSSwumFBGC93PCi0Yr18H3fCVBjLA8xdicd5n5J1KFrK6NU
   P3PjSdEgkaT9XFJidz297Rsy4DJnFuhoKQI84UaWyqt3cq3T75Z4AsLP0
   QmR7ddLXM7vkcB2P+AwZgg3mgyq+iUA5TzL4CKwgO4BFw2i1KvPjtcrgU
   h53QzqAxHer19HkM0eAn73E3OqaMOpp11amJOYdhJZ8FQi3mMXtaq/6aM
   TvDofxyKm5+2FQHRsZUgZDm4ReMYe4hMGYqslZsvPi+PqEGfTMP7girFO
   Q==;
X-CSE-ConnectionGUID: 3T864Td3TzOtqkdkx8NjfQ==
X-CSE-MsgGUID: lgQa9X7kRWa5aWHlxdefaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33509734"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33509734"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:26:39 -0800
X-CSE-ConnectionGUID: QpLXU/ACRfGO0AV27Wb7eA==
X-CSE-MsgGUID: lZc0ssOqS8qdaucLjvE33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93454790"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:26:39 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 02 Dec 2024 16:26:27 -0800
Subject: [PATCH net-next v7 4/9] ice: remove int_q_state from ice_tlan_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-packing-pack-fields-and-ice-implementation-v7-4-ed22e38e6c65@intel.com>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
In-Reply-To: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The int_q_state field of the ice_tlan_ctx structure represents the internal
queue state. However, we never actually need to assign this or read this
during normal operation. In fact, trying to unpack it would not be possible
as it is larger than a u64. Remove this field from the ice_tlan_ctx
structure, and remove its packing field from the ice_tlan_ctx_info array.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 -
 drivers/net/ethernet/intel/ice/ice_common.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 611577ebc29d8250c8cce85f58f3477ff3b51a66..0e8ed8c226e68988664d64c1fd3297cee32af020 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -590,7 +590,6 @@ struct ice_tlan_ctx {
 	u8 drop_ena;
 	u8 cache_prof_idx;
 	u8 pkt_shaper_prof_idx;
-	u8 int_q_state;	/* width not needed - internal - DO NOT WRITE!!! */
 };
 
 #endif /* _ICE_LAN_TX_RX_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b22e71dc59d4e4ec0efea96e5afd812859a98bdd..0f5a80269a7be0a302d4229a42bb8bbfc500905a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1467,7 +1467,6 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
 	ICE_CTX_STORE(ice_tlan_ctx, drop_ena,			1,	165),
 	ICE_CTX_STORE(ice_tlan_ctx, cache_prof_idx,		2,	166),
 	ICE_CTX_STORE(ice_tlan_ctx, pkt_shaper_prof_idx,	3,	168),
-	ICE_CTX_STORE(ice_tlan_ctx, int_q_state,		122,	171),
 	{ 0 }
 };
 

-- 
2.47.0.265.g4ca455297942


