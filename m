Return-Path: <netdev+bounces-131631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E698F13A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A2D1F22134
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF119D095;
	Thu,  3 Oct 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmCcMPfc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1B197A65
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965153; cv=none; b=H/3pjQWwUBS/ELYA0C5E7iCl7YQ81iKeUooNWXxe2xaZvd6zleg/6mBmMkCRj7mCL4/pRb7lGSUQt/0hWMkD7MfXFOlXujfbM+Oi9nK6VO6sRtGOrIWUBsHxQ0Gh3LJwvWWlbgX5g+B1NC6Gru1xqdgKFkpA8mxQJVCf19DiHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965153; c=relaxed/simple;
	bh=I3HHJCYyOawm3B2PrzYQZA6DulgXKucpF/TAE489InI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/Di3vmFGiSO5sZA9t6X6Y//ZF9MmvIA7PsH4JwUQIX/Laf+m7oAFUv88ahmTQQnPSSl176adkDAziWsbOR5dto26MI5PuDDaipuOV9kcg6bzlV73QS54mg1bG32mHhUz4kuOxN9HX+D3UqKsKe3HPeWRfi3T5zpExZPUTmS3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmCcMPfc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727965152; x=1759501152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3HHJCYyOawm3B2PrzYQZA6DulgXKucpF/TAE489InI=;
  b=OmCcMPfcvkrV0X4YnxE+yXViW9oiDRDeHiGZ4TlmwsMdkh858Dg5TqGi
   ghYzs3Ap7EGqKKzMkfK4pitXca/pLNJeSKdjskLSBx4NuTvZukO/qujAM
   9vgAwbb4ho78g8A5ti4utnq8SswGt9YxKj323X8IIunmI0NIhaVFY3SOZ
   8/TWwqgeKKTiC7Dgwbld6MjqZoc19tXzpOqqVdhBJLdYb79pk6+AzPU8N
   uXodesHbw4S0RKzoxQ/PO0PhD58DPiHyKFkVBxXbehFOUcydzv3nPMvvm
   cvVrVGlLU3LnDDZQqlLwqhPAJNxcM158B9Uv0HVXePg2mgmz4QUKG5pB6
   A==;
X-CSE-ConnectionGUID: Y8DeXE5/RbGbMlAJaFjCbQ==
X-CSE-MsgGUID: E9cd/QnVRVq8vjOi0f4YLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52567236"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="52567236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 07:19:12 -0700
X-CSE-ConnectionGUID: edeZ1SSzSJK6n9EmlIq0+A==
X-CSE-MsgGUID: dNbjF/HZS8qmyWiFFGMyeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74794017"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.117.83])
  by orviesa007.jf.intel.com with ESMTP; 03 Oct 2024 07:19:11 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v9 5/7] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Thu,  3 Oct 2024 16:16:48 +0200
Message-ID: <20241003141650.16524-6-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
References: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required to adopt x540 specific functions by E610 device.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
index b69a680..6ed360c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
+
+#ifndef _IXGBE_X540_H_
+#define _IXGBE_X540_H_
 
 #include "ixgbe_type.h"
 
@@ -17,3 +20,5 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_release_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_init_swfw_sync_X540(struct ixgbe_hw *hw);
 int ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw);
+
+#endif /* _IXGBE_X540_H_ */
-- 
2.43.0


