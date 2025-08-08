Return-Path: <netdev+bounces-212258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE780B1EDD7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45B718C3684
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7561B394F;
	Fri,  8 Aug 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+657Apc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076A19D065;
	Fri,  8 Aug 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674487; cv=none; b=GO9cpH2IIhclgjMKSeu1bKVlXAmJAwdALzalJ9r9QWZGs9PLLFBpXqRyvXw89uR1Ti8JxU9lEPBM16Q2ObDmrrpmbBaZKFgP9tCjOEMXXWdLEdYt+1UaFfgaY9Y/mAeBY8JbEBZA+fj03oy4evZ8MA0IIQjaTjc428Q7yvQVLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674487; c=relaxed/simple;
	bh=qli6gDNKcthko9iAnJuC8ySanSQngtAs1yxX2emx7dI=;
	h=Subject:To:Cc:From:Date:Message-Id; b=QRvmBXN0MrvhIaZREcHsTWxmho3Fi0VU1ge2ZkW13w7HGNvWjWzai5hjsBMvPOBXceHEEG0IU7cYfgA66gqcmm124cfrrCzbISagHB3JJ4BPIFLUPGPRNRijWr2npT3DEFs8+rKluqxNsvymOYv138X+wCIxrmzrPLVXjvKm5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+657Apc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754674487; x=1786210487;
  h=subject:to:cc:from:date:message-id;
  bh=qli6gDNKcthko9iAnJuC8ySanSQngtAs1yxX2emx7dI=;
  b=f+657ApccnUDV/m99V8OS0p/O0POvMUkzZqq7LioWfojPaNcTLZSQ0zx
   hN+jQoznNSG6MCB7BnE8Ii6SzsJk7nqOUy0dZgvFj8f/E/JZpbdToxfqN
   KRcF7Y1OSWZQtQqeWZ6Uf+CkAImutNuI7WJPLjz4zYaWaoxdUvn/+gCwO
   2kf+vJvwAO3vFJsU+VfOToFVoYWh2al4loVJmdI8TSj2PGK6CT7H6s45R
   8Czy87iJn+KzbL3KndIeVc/YMc8KLewE6ovlZ7XUxE33OPmxrcUpto+So
   YlfZuIjthjl44t3IFuKbyAKV9pXTz7LOREHjI5Ud22HFMjnsy5IP11o/r
   g==;
X-CSE-ConnectionGUID: 1iUD+FNOSJ2Qxur2XId0UQ==
X-CSE-MsgGUID: n7QqaEYhRdGgrcy7tiGdiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57156703"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57156703"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:34:46 -0700
X-CSE-ConnectionGUID: VZlWgZMnT6u7NndKQapE1A==
X-CSE-MsgGUID: S07sJJUPRmWyb6OfkU5zeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="170637913"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2025 10:34:45 -0700
Subject: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Liu Haijun <haijun.liu@mediatek.com>, M Chetan Kumar <m.chetan.kumar@linux.intel.com>, netdev@vger.kernel.org, Ricardo Martinez <ricardo.martinez@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:34:45 -0700
Message-Id: <20250808173444.749F9691@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This reviewer's email no longer works. Remove it from MAINTAINERS.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: Liu Haijun <haijun.liu@mediatek.com>
Cc: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Cc: netdev@vger.kernel.org
---

 b/MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707	2025-08-08 10:30:38.859018798 -0700
+++ b/MAINTAINERS	2025-08-08 10:30:38.876020292 -0700
@@ -15672,7 +15672,6 @@ F:	net/dsa/tag_mtk.c
 
 MEDIATEK T7XX 5G WWAN MODEM DRIVER
 M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
-R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
 R:	M Chetan Kumar <m.chetan.kumar@linux.intel.com>
 R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
_

