Return-Path: <netdev+bounces-138228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1539ACA7B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BC128318A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216A1BF80C;
	Wed, 23 Oct 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoFQuhMC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1921BCA0E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687526; cv=none; b=dKMSqNKNlIrfQ2uIr4Q8Pvnq+/SGQU1/uKoNXc8XhwXjMmHW45clFq11WkGkJTczf1bHbNR2c/Qcdo1TX8QTuDn6oQvzZuTLbqgaxV6jf23PgmCMdiIAFjIjCqoej3oOV2PglQh9ijswI9k3vmXZnHX3jPYmc5KyEIHB+HUJNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687526; c=relaxed/simple;
	bh=I3HHJCYyOawm3B2PrzYQZA6DulgXKucpF/TAE489InI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnPM3kKbg7M+AtyanFKLI4mKch94mmfA5Q8jtts/leJl2EMjAG9a8vWnAXBzDC4fV7spHBItKKcmc2WWMAbBPmtVrbdNcsv4DxA++cjz2tveB6FSG6dCUWXUIuj5yYf8hzURgRQDehEBUU4IxdKhgr9L98/4HeCi/vgsc1RWikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoFQuhMC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729687524; x=1761223524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3HHJCYyOawm3B2PrzYQZA6DulgXKucpF/TAE489InI=;
  b=SoFQuhMChhKhgvNvRQ0odutGZyBJKTBC09V0M2PlxWiHxvV8uU+vK7Np
   B+8V4HGE+jwS7co0GxyC+Z/a/mlf0Cwda1W3+H61uP9K3SH2JPe6YbkIk
   lZfHuGZtJRmmEW5sviw6vUn4nmIwE3FrW6pmX+heKk0mhXj6Z0G0L8UJd
   Xgt1gzvRArPLpY8agsOX2aCdVO78Cjut7OuWuipLiiJjKt6Wk+S5c6SY2
   UhGDQ0NtBNYSZjgPnWdK2MZYfjy9hqMO+7s5w5RDXDUhEM2oV5YR0onnP
   8l+KUL4dCRadREiQkgiTT4rNcH+APua9RgcGuG6+V8lluM7BQnJdfnhwf
   A==;
X-CSE-ConnectionGUID: wM/zqGaAQWq1geD08cbO6Q==
X-CSE-MsgGUID: +a37ahy6Q22/VdJFOhTX2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51814152"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51814152"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:45:24 -0700
X-CSE-ConnectionGUID: ZHoEkKNLQpSWrmy2LG771A==
X-CSE-MsgGUID: dAEUJ/J6Snu5ClePSiu63g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80119823"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by orviesa010.jf.intel.com with ESMTP; 23 Oct 2024 05:45:23 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v10 5/7] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Wed, 23 Oct 2024 14:43:56 +0200
Message-ID: <20241023124358.6967-6-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
References: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
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


