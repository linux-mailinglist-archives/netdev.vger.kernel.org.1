Return-Path: <netdev+bounces-179886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C49A7ECB6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257E17A3025
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D1222590;
	Mon,  7 Apr 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkMds6wl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E4219A75
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053036; cv=none; b=bQ6eKOKXfNtrHvDMree/bFZLLYtM+1H/0K2bw7SaWBiJ16L3geHzo/o7eEHqj8qxP+P/qKgSHlXQm/PtK2MOnOptEfub1Gh5/s3WbHagKOG/2NGcWf/1ubrDa47Xrk5VmBmGjadAL40jnCLNwxF9HNLQV19wjJ4LuQrcGo3RdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053036; c=relaxed/simple;
	bh=cp7rBFD+69jqcn07SMI3PajyGC2f1r5uZony8lWnO54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/4ad5VS1uMBmrPVxI/dac4+3MP1X164fqr4OgRN6XJCC/qZBE6bNEpH3/kAnxZOyZa0D9zfFKXU0YNIk6cLXxoH6FgjnB8GvtmdRu/08ZsHc/ZUdnuHs3nkXpCG74oD+QdyFhDpAjuhkrvdK5PZqF1XMYtM4kxDwkBxXRtCd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkMds6wl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744053035; x=1775589035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cp7rBFD+69jqcn07SMI3PajyGC2f1r5uZony8lWnO54=;
  b=PkMds6wleEqpabu9pIMGah7bWPKfXhk9TZAuUqcj7aJrDdoRAddeVuAD
   NkcgfbktXJwk1+hqVXRHHPU8ZInm55bZCMiRziFGa5J9GKQlC0X/E8p7U
   MR+ryhrR8IWITPpPdp1a3JSrGOzOKPeToDcsl4ah3An4EkMKu/RmzdZzQ
   7CBP1+DrXHzTqJbWxFjqwUvx1XJSozADD5ELS0DGcxTURIFNSdxyiZ+6c
   cDV0AbbI1CvZkBAf9cAkRcnb5pA41MwbKs04U7GKwYLynhvCyb6h4BuQ+
   /0E9pVWnLjjAraG9pFfHLmjbaMU4Ju3gggOh5lD1r1n34FKfNr+VKH2N0
   Q==;
X-CSE-ConnectionGUID: Xev0bYQBRMOCvIx1n3SsGQ==
X-CSE-MsgGUID: 2+MNtv+STl24XI//PMpgIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45550348"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45550348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:10:35 -0700
X-CSE-ConnectionGUID: gU26WAqnQt++lPQnIU7mdA==
X-CSE-MsgGUID: iMM0RthcRtGorbY+qkTIow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132177569"
Received: from puneetse-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:10:27 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	ahmed.zaki@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com
Subject: [PATCH iwl-next v2 0/3] idpf: add flow steering support
Date: Mon,  7 Apr 2025 13:10:14 -0600
Message-ID: <20250407191017.944214-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic flow steering. For now, we support IPv4 and TCP/UDP only.

Patch 1 renames "enum virtchnl2_cap_rss" to a more generic "enum 
virtchnl2_flow_types" that can be used with RSS and flow steering.

Patch 2 adds the required flow steering virtchnl2 OP codes and patch 3
adds the required flow steering ethtool ntuple ops to the idpf driver.
---
v2: - Rename "enum virtchnl2_cap_rss" to virtchnl2_flow_types in
      a separate patch (Patch 1).
    - Change comments of freed BIT(6, 13) in patch 2 (Tony).
    - Remove extra lines before VIRTCHNL2_CHECK_STRUCT_LEN (this makes
      checkpatch complaints, but Tony believes this is preferred.
    - Expand commit of patch 3 (Sridhar).
    - Fix lkp build error (patch 3).
    - Move 'include "idpf_virtchnl.h"' from idpf.h to idpf_ethtool.c
      (patch 3) (Olek).
    - Expand the cover letter text (Olek).
    - Fix kdocs warnings.

v1:
    - https://lore.kernel.org/netdev/20250324134939.253647-1-ahmed.zaki@intel.com/

Ahmed Zaki (2):
  virtchnl2: rename enum virtchnl2_cap_rss
  idpf: add flow steering support

Sudheer Mogilappagari (1):
  virtchnl2: add flow steering support

 drivers/net/ethernet/intel/idpf/idpf.h        |  33 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 298 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 121 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 249 +++++++++++++--
 6 files changed, 666 insertions(+), 46 deletions(-)

-- 
2.43.0


