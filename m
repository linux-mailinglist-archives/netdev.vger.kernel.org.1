Return-Path: <netdev+bounces-121180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A94F95C0D6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D01284CA6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A01CCEEB;
	Thu, 22 Aug 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjeC734U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2665AEC5;
	Thu, 22 Aug 2024 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365778; cv=none; b=Wa6CifoDQ37KvmAuNi9kdEmcGkUlKEnSDaDUXwVwF5xhDIPEc0LPJvvnyd0Qk2mfRHKIeBjNpVFN+XAWYZAucp0JwbQwvmL60UDAYTaBPw99vrkc3GlVBNy+bK01OrHYV+r5DRd6Q0JXInkQTUEIslfydsUXxHvVo2D1UHdjlcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365778; c=relaxed/simple;
	bh=uoTeruy2C34oOFfNzZVYVsNBxCT+EvypAvtOIkcUyac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQWZD461OEzk91E01I9lUhISZ+MUv1wh1yKx20GkO3VMtPAJ9oQ1zRFiafJ0QoerANvBK3m8ScSdmTUQT2oddnBXgiojSBwIdDBDxsZGmWZoNHcbCupPWX3XajpHjo4F1awOwaoc4OUb1w+7YNA+DJfg2Ur+E25xJoC53dHlMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjeC734U; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724365776; x=1755901776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uoTeruy2C34oOFfNzZVYVsNBxCT+EvypAvtOIkcUyac=;
  b=BjeC734UQi/Uj2Tvogun54b+SoT7qHYBSHBRfMWHzQsW2qfk5OPEW+63
   VySjjHPctZmlZTj2jdGC+yCis1KVEvQX2U35uqafjRKx9F7r6a3CUWyDE
   G6oluypqRIHFyYRU9I5GHArNeCtyPVf9oGolWIwgovx/S223kk+9yzuOz
   CP1mNv9LPK+yJ6O8xeKtdoR2yN37sQJUcR32XmQXBh8YOZkwxcM2B4/fD
   Xjjf90rS5agjXgcgfcbdVRlztY4lVNMkcrTfI/Xes5/RzAfx5Nxz74KI2
   NGKnLy8gMFGlZ/KKeMSDmQkQFgeiNz4Uy0mzYq1i62EoCmLNcFNHISkpY
   A==;
X-CSE-ConnectionGUID: l096AbNNTcaXyf2Q6FGGcw==
X-CSE-MsgGUID: khJVmsCaSWCddW7gJ+lZ+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40324998"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="40324998"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 15:29:36 -0700
X-CSE-ConnectionGUID: kzrHlVg9TCCQNY/ZXxHE/A==
X-CSE-MsgGUID: DkQNrn/AQOCu9MQHPZoijg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="61903150"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa006.jf.intel.com with ESMTP; 22 Aug 2024 15:29:32 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v3 0/2] Add Embedded SYNC feature for a dpll's pin
Date: Fri, 23 Aug 2024 00:25:11 +0200
Message-Id: <20240822222513.255179-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce and allow DPLL subsystem users to get/set capabilities of
Embedded SYNC on a dpll's pin.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Arkadiusz Kubalewski (2):
  dpll: add Embedded SYNC feature for a pin
  ice: add callbacks for Embedded SYNC enablement on dpll pins

 Documentation/driver-api/dpll.rst         |  21 ++
 Documentation/netlink/specs/dpll.yaml     |  24 +++
 drivers/dpll/dpll_netlink.c               | 130 +++++++++++++
 drivers/dpll/dpll_nl.c                    |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c | 223 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 include/linux/dpll.h                      |  15 ++
 include/uapi/linux/dpll.h                 |   3 +
 8 files changed, 417 insertions(+), 5 deletions(-)


base-commit: d6f75d86aa786740ef7a7607685e9e1039e30aab
-- 
2.38.1


