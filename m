Return-Path: <netdev+bounces-181384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D2A84BEA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D471B86399
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8727B1EE033;
	Thu, 10 Apr 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBqZo0D6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90521A3BD7
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308850; cv=none; b=P8g+VjqMJxhDXsj96o+Nr3IraEKBnP9d29lhrZO6D9z7Q/oeQvoPsk9sG5Wr5xE7XeDuzMY6Brj7odtBWV5mzYpqsNxYPiU61oqfRuGAUhxsLy2y935EiLZPdY+rjX0p0nB0w7tQ3vG48DTLuTBQ+5m3dLtswBMfAg1H56te5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308850; c=relaxed/simple;
	bh=mh8IoFcusFGSw+JNDQTgbWfOeyGjRHhF8WynZnAoDR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tRMffmI0KXHvkb4DReSvxSQU3ysuczszzLaQ0UH94IwRJnPdAbKp1vt7Q89WHxsMG6tlsHLH6GmK8QDZbNXvVHQtYMIfGcNhEpQOilGGmN3rEbjbkST2ZY2w+8Etd3s+t0f25THTAPmV4ThA0qPpSIB0Lm659VfuXw6rd33EqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBqZo0D6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744308849; x=1775844849;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=mh8IoFcusFGSw+JNDQTgbWfOeyGjRHhF8WynZnAoDR4=;
  b=IBqZo0D62EA4YEifMkCCv4GKjlHf0MGozpCiPqmZ5M8ZJkTbjuqIto+r
   YzVzhUBd6W9foLcbu+tPdesjYsz5m99Z/xp/92oAaDo361EoPFEOqFRA2
   ezP+uEvbsksHmnCPvZVf2YO3EOkctHvr5IkarwWZnE1rFPvklwGcUgvkt
   4W9p28D2rX8qwt+bgw5UmmgEmgDx1VyyeMfrFsTYA++IE9cfXAaPQBdLf
   ofsKXfmBLP6T8eZVqmnx8kbGWbQ8Nd/d7ejKm8XvOhyPuQE+YRzMpPHpt
   5t6SgxRWey6+c43NxD1sraaaD1UuqasZSOjs23m7LIvEdV2XlBYSl9eOL
   Q==;
X-CSE-ConnectionGUID: Pu2TvjVzR5Wot4QdFR5m1A==
X-CSE-MsgGUID: dJf1tCfpSP+LbOVhMjeBew==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45745467"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45745467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:14:08 -0700
X-CSE-ConnectionGUID: 3Q5Z7TFeSGae9q+jImrf4Q==
X-CSE-MsgGUID: OIYOgn+KRHWZ2kJnS6gIqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="152157380"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:14:08 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 10 Apr 2025 11:13:52 -0700
Subject: [PATCH net] ice: fix vf->num_mac count with port representors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-jk-fix-v-num-mac-count-v1-1-19b3bf8fe55a@intel.com>
X-B4-Tracking: v=1; b=H4sIAF8K+GcC/x2M0QpAQBAAf0X7bOvucpJfkYdzFkuW7pCSf3d5n
 JqZByIFpgh19kCgiyNvkkDnGfjJyUjIfWIwylhVaIXzggPfeKGcK67Oo99OOdBa53tdVbo0HaR
 4D5S0f9yA0AHt+37yV8gQbQAAAA==
X-Change-ID: 20250410-jk-fix-v-num-mac-count-55acd188162b
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The ice_vc_repr_add_mac() function indicates that it does not store the MAC
address filters in the firmware. However, it still increments vf->num_mac.
This is incorrect, as vf->num_mac should represent the number of MAC
filters currently programmed to firmware.

Indeed, we only perform this increment if the requested filter is a unicast
address that doesn't match the existing vf->hw_lan_addr. In addition,
ice_vc_repr_del_mac() does not decrement the vf->num_mac counter. This
results in the counter becoming out of sync with the actual count.

As it turns out, vf->num_mac is currently only used in legacy made without
port representors. The single place where the value is checked is for
enforcing a filter limit on untrusted VFs.

Upcoming patches to support VF Live Migration will use this value when
determining the size of the TLV for MAC address filters. Fix the
representor mode function to stop incrementing the counter incorrectly.

Fixes: ac19e03ef780 ("ice: allow process VF opcodes in different ways")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I am not certain if there is currently a way to trigger a bug from
userspace due to this incorrect count, but I think it still warrants a net
fix.
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 7c3006eb68dd071ab76e62d8715dc2729610586a..6446d0fcc0528656054e506c9208880ce1e417ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -4275,7 +4275,6 @@ static int ice_vc_repr_add_mac(struct ice_vf *vf, u8 *msg)
 		}
 
 		ice_vfhw_mac_add(vf, &al->list[i]);
-		vf->num_mac++;
 		break;
 	}
 

---
base-commit: a9843689e2de1a3727d58b4225e4f8664937aefd
change-id: 20250410-jk-fix-v-num-mac-count-55acd188162b

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


