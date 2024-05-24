Return-Path: <netdev+bounces-97990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2108CE76A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F86EB21020
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80512CD8E;
	Fri, 24 May 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpyMYNqT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81312D1E0
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562577; cv=none; b=Wwp8qC0VfemWdahoTolIDjjim6qzKHxlotS1p+Li/ds2gG0EXmzjx9GzSNOBCB1FFJAbS7ovTMNKgWjjb5Qbp2GIUzF0dZCxOO7HWr5k0uxlwDjq8bow/tGGSr9aIs2/wLXki78KHFKgAWDlWSpSC6afuMhLotecLWgWCnUk2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562577; c=relaxed/simple;
	bh=yAlmKvQNAV/yUXqHSOBMs6ZT4KrFx6wmrNXDkPsKJTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHX87YIAYknRYRqbPzJaGi2l+foVHpBnqLazzpELuIXFOO05Q5wmxw4VaKKs2Juwu1LxfGt9NJ3pBSV2IMsibfk9wu2ATFV02UmZXmGiodW5KHl6mWCUUsAzwiqWZ1VMr2rgBWAAJuAyejk58md1PCc/EtQnZXfyz5S6K/h/rBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpyMYNqT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716562577; x=1748098577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAlmKvQNAV/yUXqHSOBMs6ZT4KrFx6wmrNXDkPsKJTs=;
  b=BpyMYNqTm3owrolPOguWDMq3lH+eJvbz+K1ti/ZpxyGttcEyKHF/q7jr
   Hl+GsO1jq4dX+6wMbsJH249aD1kS+4w476fS256CsVlS9yEPBCrdBvjgu
   O1OD5h++nnKzcmb1QKLeu1rRPZ51u9Dahc13r6vv9U1rDetFCjdwFSf72
   3tRra0pdM2Z8BiMfdFMyCQYwBLbVdz4hrPGyC1VhdQVpN21DbEVNaPgdq
   Ho5Vu73TPCtUc/5rgsIqAqatlhL2epsY1r3OW1VIW5KTLvMLYaOMzCJFm
   drHdqx0ySQENNhwCRkjJ9gLAmlj4RnTiqXaWvZJziphJtQXtKsw04GTCS
   g==;
X-CSE-ConnectionGUID: JC/Q50XgTXOtH0NWFmvpYA==
X-CSE-MsgGUID: K5/ITcOqTu24Fzmc1wrQew==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="24070389"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="24070389"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 07:56:16 -0700
X-CSE-ConnectionGUID: tLAR01f2TWeFIr1N+Wn4AA==
X-CSE-MsgGUID: cXWDh18iTGGKJtXE7DwvGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="33946100"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by orviesa010.jf.intel.com with ESMTP; 24 May 2024 07:56:15 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v6 5/7] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Fri, 24 May 2024 17:13:09 +0200
Message-Id: <20240524151311.78939-6-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240524151311.78939-1-piotr.kwapulinski@intel.com>
References: <20240524151311.78939-1-piotr.kwapulinski@intel.com>
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
2.31.1


