Return-Path: <netdev+bounces-108429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749D923C3F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B834728329A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DC15B0FF;
	Tue,  2 Jul 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRqA4W+2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF6157469
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919106; cv=none; b=my54g25BqDtaDPSoilnybPkkI8MksdY/gVbR5FxYADVkjM1rBlCrvucWnODKYb2xTh7AnmKZx6/C/GhRBuW9Dmh3TvFahiwbizCR+htEYD+yoQppiLxuP7ss/ls4abJc83q0suAUg4lk9G1i/QaqK7h9paJ0J0tpABu2/LrW6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919106; c=relaxed/simple;
	bh=3n5NEBZLdFEteR11qjJ/4y7R0o7wx6C2YeZBWutLvQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsQZZ62GmeNinQ1QkCiRBARNUSBi7cTPJrL9yyS2Of2Mva3vcn27W2bLnV8S2ME5MHiouMn3tnzcguX5A7uGIe00wWs07A4+OZuFSuUX4VPULVW+4Fl38HVF/O6RgWzqZd9JbH1xIfsd8HuvaEAGZLEO1BkA+UXKoS5ntB8QHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRqA4W+2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719919106; x=1751455106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3n5NEBZLdFEteR11qjJ/4y7R0o7wx6C2YeZBWutLvQ4=;
  b=KRqA4W+2w7sT2opmA/tAXiM/W858ZkF2jhc2iKr6l1POwcs+LLSauPO6
   xqA4/d8T4MIaOlDjm0DaPw2eVlreiy/H5AouMimAactm0hsWRq7lUOFmd
   1fy8tSug0Jqgtfl0ZxJre6AjnWVo5yzqXFwnDTQvhEgDaVujAntsF6Z//
   PdcBx72yQtCrRDPd58tSVhGthRxlohPpMAWgFidsQYXgTJb8fUPS9th4S
   ZDLAvWV9EkIDllOAa9bpWZlAPgMtlTwfT+Qoa11HNakwmna9EznDIRIgI
   eggAq82yMMNiKiiir3Bn7VOMwWdeY3iMCa9HqQctF1fqhNa2dWCDRBe0H
   g==;
X-CSE-ConnectionGUID: WK/ienijTtSW9P/OU3L6HQ==
X-CSE-MsgGUID: gC5yEQhiRRildame91gpFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28482082"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28482082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 04:18:25 -0700
X-CSE-ConnectionGUID: ZiiKdZQ2QM6vkEVFdLAKFg==
X-CSE-MsgGUID: jqF5gOhST5W7gunqXsnXrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46006195"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2024 04:18:23 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-net 0/3] ice: Fix incorrect input/output pin behavior
Date: Tue,  2 Jul 2024 13:13:18 +0200
Message-ID: <20240702111807.87802-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes incorrect external timestamps handling, which
may result in kernel crashes or not requested extts/perout behavior.

Jacob Keller (2):
  ice: Don't process extts if PTP is disabled
  ice: Reject pin requests with unsupported flags

Milena Olech (1):
  ice: Fix improper extts handling

 drivers/net/ethernet/intel/ice/ice_ptp.c | 131 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h |   9 ++
 2 files changed, 110 insertions(+), 30 deletions(-)

V2 -> V3: Adjusted formatting in "ice: Fix improper extts handling" and
          reworded commit message
V1 -> V2: Fixed typos and other formatting issues in all patches

base-commit: 0a8975e20f25bb2f5edb28d883dc715802231e71
-- 
2.45.2


