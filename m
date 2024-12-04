Return-Path: <netdev+bounces-149021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926CE9E3CDA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52939283D85
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472120ADD2;
	Wed,  4 Dec 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwJ9YFAv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15C20A5C3
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322793; cv=none; b=V3dej7zDWuYat+QsLiOazhtJlhMpwzL8R8uEW9eR0grh/jpQUkGFz1NFsMJgU6oYk4ja04c/fAAfYAwwP+EIAvh8FLSoKMs34gCHC2hkQQvm9CQCtPu1U0xP7ufqOvtl5NVkxAYhPUjzozsVACvfmHD95MOQ+2duVPhw3siB2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322793; c=relaxed/simple;
	bh=3bDeFwvAxQpwhTqS+naTgeHPWQZXlwaQCZQSnPeKaw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ymneu60z6V+HND9LYbfgX7XpQ59pD4Fuy14k4AOFFTj2xY+ICSgomT3TDTduuasPT7KJnSQSLTKcZlA3qC6y1q5vCR7QcjgjuhIE5b1uCPgP5c9TCkvEswsqpJh0yil8Wod13x+1pGP8jUbuH859pJU1LhC7mGkq4tED/GexHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwJ9YFAv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733322792; x=1764858792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bDeFwvAxQpwhTqS+naTgeHPWQZXlwaQCZQSnPeKaw4=;
  b=AwJ9YFAv/BdaEOvGqFgaYdNlaG9FsAJyI3WcmJ6pvMosYMIDK5tJWdfi
   95GptLZaL5iAo2JgJDNbDmtQ24SoKno9z6vu1zfrKf978kp1hLWZccP1k
   8eLefyAFw3p7YM+jxNKAk5NPSOYpbek6C0Vxzu1/0sUjPevdRGdE/7/nj
   AN7eEdeBQIVDmXE+xpL9nvmv05buC3G2AT5jgks/kWGUq5tRkcpyxsanE
   RAthqO4l0WmiRl4tWSvhrMktySgmMv/ZsS2vdGIk7SiIQi5sSabNYdACg
   5Q5YabMDJf3T/hALq/cuGlvoxHyOI5V6MEFJTtWN5q7dLQyVa7GFcNE1W
   w==;
X-CSE-ConnectionGUID: XRZGzmXHSw+LEu/UC1FbWw==
X-CSE-MsgGUID: x1YWerJkSX6M/cvZd7YjMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44621849"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44621849"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:33:12 -0800
X-CSE-ConnectionGUID: HMMfnvVOTXOJ3Jbf/waJfg==
X-CSE-MsgGUID: 8zQA6SZwSfy//v6f9YmT3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93456620"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by fmviesa006.fm.intel.com with ESMTP; 04 Dec 2024 06:33:10 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v11 6/8] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Wed,  4 Dec 2024 15:31:10 +0100
Message-ID: <20241204143112.29411-7-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204143112.29411-1-piotr.kwapulinski@intel.com>
References: <20241204143112.29411-1-piotr.kwapulinski@intel.com>
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


