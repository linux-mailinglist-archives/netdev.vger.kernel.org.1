Return-Path: <netdev+bounces-108832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44956925DC0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C021F229E0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215C9191F9D;
	Wed,  3 Jul 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccWzO00T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A78191F9A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005771; cv=none; b=NpUL4zSSGjdBx8ow0lUrtoOaWJjsw/KdID6tD8VLwm/YUleNlWQHDs+LVLSJLJLSmZvxUXSGAP9q+urjvTGzlrW19CKOBuFUFsoqAEjOlSQTScuvbUTuU/Gj0BCIBMLeUDPfeOu+Ygvcs40oa1Lot+zoLbcdvNWtPo83tIgsqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005771; c=relaxed/simple;
	bh=oCaSs8xj4V/C3pXNHjSf7MiY39U9r7UoJZNsu5aUWOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsJLo2lriprFby8jFF2FXlMhddNZH5lVZyf2AFt/v1le0lfpJwD88Yv6ZWHdCPx4AwS/6sY+y/x3RE2gliJdYs1rJevuGclQ1IJg+S+bQ/tMwfFCEd1xzlQjI65HIQa7VCghwET4d5GiYtIIJE9tkzMfBAev5QwkVk597HP0/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccWzO00T; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720005770; x=1751541770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oCaSs8xj4V/C3pXNHjSf7MiY39U9r7UoJZNsu5aUWOs=;
  b=ccWzO00TCc9Ru+LwoFjupCF7bK55hHNpkl+iBFBcMsRDYiLZROulX7WP
   FH0+sjMvk/Lzm1bF6fYuNWMbUpy4Z9vB7k/RrBem3jZy421mbI1GaZX9C
   pE59qpk5AJtzzn0lveEgNqaE38slz/oWjLyroOqCld7/1Fz04AqJqQNnf
   gdFCL0bDBBBFfu90ipyqwDphWJ3T+//qpHScI7nCq14fNXkYPh9q8vMyT
   o0PlW8HNJ8AlK8qcSxB5M4fRjVYG+oEfCqrBpf0jMsa3W+E/qHSjvYxip
   fakvZ7gHa8sUFkJFp3ll0bEg/jeaiCwim36FqzQq6xgPFxT7h840K1tYm
   w==;
X-CSE-ConnectionGUID: SR8tlN50TtaYu5XOdYrtqg==
X-CSE-MsgGUID: OWqEtyqKTySDKnAa+0Bqyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="34677717"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="34677717"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:22:49 -0700
X-CSE-ConnectionGUID: 66knfgVrSI+1kcF4qBi4KQ==
X-CSE-MsgGUID: yx3fKCKkQP+B96I0y8AgIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51413172"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 03 Jul 2024 04:22:48 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9B1B728184;
	Wed,  3 Jul 2024 12:22:46 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next] ice: Fix field vector array data type
Date: Wed,  3 Jul 2024 13:25:02 +0200
Message-ID: <20240703112502.28021-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the datatype of fv_idx array in struct ice_sw_recipe to be u8
instead of u16. This array contents are used solely to be later passed
to lkup_indx in struct ice_aqc_recipe_content, which is u8.

Fixes: 6d82b8eda4c7 ("ice: Optimize switch recipe creation")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
Targeting next, as the commit to be fixed is on dev-queue.
Tony, please squash this with commit 6d82b8eda4c7 ("ice: Optimize switch recipe creation")
---
 drivers/net/ethernet/intel/ice/ice_switch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 3e4af531b875..671d7a5f359f 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -226,7 +226,7 @@ struct ice_sw_recipe {
 	 */
 	struct ice_fv_word ext_words[ICE_MAX_CHAIN_WORDS];
 	u16 word_masks[ICE_MAX_CHAIN_WORDS];
-	u16 fv_idx[ICE_MAX_CHAIN_WORDS];
+	u8 fv_idx[ICE_MAX_CHAIN_WORDS];
 	u16 fv_mask[ICE_MAX_CHAIN_WORDS];
 
 	/* Bit map specifying the IDs associated with this group of recipe */
-- 
2.45.0


