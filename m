Return-Path: <netdev+bounces-149284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8D9E502A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648431882509
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9B1D89F0;
	Thu,  5 Dec 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH5B+6ey"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20101D516F
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388372; cv=none; b=CgALGobv/UaQBRkbUtGQFggex/C9alCzsPI+v8svfffC/iYQG9jZZmm2I3QCLqe1XHb7Z+B/fcyU0GM2iffK309f6rvKDPRwsHOCPw12fdF3bRbhfboqISlundFxOQy+sN38asm+VCBhNMb+s4H/ELZ9YRCf2AUiaLPgsq6dU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388372; c=relaxed/simple;
	bh=3bDeFwvAxQpwhTqS+naTgeHPWQZXlwaQCZQSnPeKaw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJh5FGElM5jUK0eHq1lDgFK9z+3j4CuPZpCQQ6FbZvvKsw/FLHqDj1k1Y4oLsWVEeSihePDheLUDlxSh1l2fLuhK47SioWWps1K6OWCIh997wz4sLbXmIqq4d2tpQlQWpGasQTYmmbu1+8Xg1TnetBQ5snnIvSZcS1K8OtPl2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH5B+6ey; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733388371; x=1764924371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bDeFwvAxQpwhTqS+naTgeHPWQZXlwaQCZQSnPeKaw4=;
  b=RH5B+6eyOgXfXvoHPs64983KqzQqnm0zznle9YLGdJBnF69l8cxBR5T2
   N77Z0XnlKC7C4usk4nq2KlafrTY/ICEUjY0OJQzJ/oRVNenOJCcDc7wtv
   n1PaNvuRNyK20BUPHm9jnlOkspYu/m9X2/RW6il+kPFC64JrSmF6fQe/G
   SouWRx14UrQiVJ6HX4MZdItkfQAjvGr/6MQWfOCfCTqdind0+r2ZG7uLO
   OsHXqYHMKO+q1nQrKgRdh3j/qacyMJ9L202uEjBxo/uE5t9cgRvnSYfPR
   yVpzojAPyUVhbdlF2UHI4Gby/WF9zaXkQWNoxe/uTr70pMVApP6Gt4jmy
   Q==;
X-CSE-ConnectionGUID: 3a75QqIiSuWcUFGPmoN8dQ==
X-CSE-MsgGUID: 9Ks5KdoKQ2WWcyUkPrdIuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37623284"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37623284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:46:02 -0800
X-CSE-ConnectionGUID: kZ2i5K9jTia22h77mcnd8A==
X-CSE-MsgGUID: bcDKNca3QAWn+BJAQPWlNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94864192"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.2.76])
  by orviesa008.jf.intel.com with ESMTP; 05 Dec 2024 00:46:00 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v12 6/8] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Thu,  5 Dec 2024 09:44:48 +0100
Message-ID: <20241205084450.4651-7-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241205084450.4651-1-piotr.kwapulinski@intel.com>
References: <20241205084450.4651-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required to adopt x540 specific functions by E610 device.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


