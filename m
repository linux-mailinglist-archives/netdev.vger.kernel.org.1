Return-Path: <netdev+bounces-139264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4B9B13AE
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CC9285730
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84AA934;
	Sat, 26 Oct 2024 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cnuql9RC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4410E5;
	Sat, 26 Oct 2024 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901158; cv=none; b=PZZhnFxO7dgC/2ft8FY6PI0CFKMxuMI3BGXq8qL8p1U4oUaQ8mpCfvBDmwPiB6otaDnq9c5nLY9qMrVgHDG3YVS8NUg6f7lgr/Y7eatfaaUdwLssAHNvs1r0BSApu6yxEr0/rjCn23GLR+pkvWklqXtizPXe+p0yP6WoL0A6ESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901158; c=relaxed/simple;
	bh=smdCnKK5JCnXzm+UfTq+T7poKVvmdHV4Efr4cxIXJpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjwAdN1mrT+TypCUnH2JpP3GLk3mQEgqcYFopCBWGGI03kcX92cZekd/PAfwYN7sfyzfNlYPy4PAkgxx7LWeZqAZDeuYvPomNhyxWg2jJrwDsOYfJ6nR/lK/U0QVLD6vIsbsP+letpw5B+ktTtVMC3tmKBvkqtzZJP6EmevRQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cnuql9RC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729901156; x=1761437156;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=smdCnKK5JCnXzm+UfTq+T7poKVvmdHV4Efr4cxIXJpQ=;
  b=Cnuql9RCCKjkZ0L5M6DkpElRI7Ma/JhnE9hcAxv0B0qjX//wi4TPVcHl
   prtESxwPKl0KM98IftyeLcIUwAUM+1uYKvp6GIZwcDHGclde79epVlJ5p
   QFDYC4GqwVhFGP1e59FzwJef6kXJgluZ0w5o9JucFx/dSrZ1gWy1GEbEw
   P9DRDUvUJVRbnXG8l3rLZAV4tz4YtmKK7WV872pLnIQLk/2UQCMhtJzWq
   E2bBP+J+lzjtSpFdac63nmYSa+o084w3MQMiLzed02BVTCyv0PH/w78f0
   1qFzqqKlj67rkh6C2fqBgqgC47+A/5vv7X1+6PbewtEHqedaYFk/FMwpE
   g==;
X-CSE-ConnectionGUID: 9VBR7xeqTc+P7ZiEjqVEUw==
X-CSE-MsgGUID: 42nTIb5uSbOX27WGWWzaeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40959140"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40959140"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
X-CSE-ConnectionGUID: EOt1Hw6+Q9SQORb1r1vRLw==
X-CSE-MsgGUID: 9SCH0tg0QAGMC+s/7qkDag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="104386848"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Oct 2024 17:04:56 -0700
Subject: [PATCH net-next v2 4/9] ice: remove int_q_state from ice_tlan_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-packing-pack-fields-and-ice-implementation-v2-4-734776c88e40@intel.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1

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
index 611577ebc29d..0e8ed8c226e6 100644
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
index b22e71dc59d4..0f5a80269a7b 100644
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


