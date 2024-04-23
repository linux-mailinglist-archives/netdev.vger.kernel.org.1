Return-Path: <netdev+bounces-90637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9C8AF683
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349ABB239DF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4413E889;
	Tue, 23 Apr 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XH1N0Qy0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96513E418
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896856; cv=none; b=gn2XgDBYbDp0SC4nvyXmyEfK6gCi1J5cUVP3D4tXMujgCWZCvkHQThdDabq7jO5iRo7O0/W6j7KyiEbhA52DoADB6N2zb6GIQaghqGwGmggmkLQsuabGpQx6Fd2SHsSwdOwkhd9yj+3Ct2O0uHeAGh2xvT/weq3VZ8QLnc78oUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896856; c=relaxed/simple;
	bh=cOfAh/6Vwk0Tpyxmk8SnubvVZiaXDf/vAFAfjpFQMkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaerPJm7zwpj3GJlxPZ1kFMabEDQn7O7Coi7/EQW+TPW+iehlcVDoicjQl8icwfsOBbUS4KFl8Tzcj858nsvqnbt0UHKeP13A5zOJ76insZMybORgVAEh86FX/UH8Y/Gt7jRE+G6cOvstJOk/g+7+VDBUvHszlYdYwdVDDXdJl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XH1N0Qy0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713896855; x=1745432855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cOfAh/6Vwk0Tpyxmk8SnubvVZiaXDf/vAFAfjpFQMkE=;
  b=XH1N0Qy0KPNwV4pb4Zt2MrV7ScGvM1sUJlBXWZtX5euCNz5BCLPVNy+G
   BkK2nDdF8kn5qpIRVT7l7GhAuXCL1a4NPCOe51UHeBdYrUIqMKd48VwiK
   6Y8OYEDjghAlp/+1ZvU4BP1LKcTUsC/WnSdJUT/wkVaMwHMATvi+s2zcZ
   Zu9u9mAN8vDDJMpGzJojKC+pL50Pqf8X/PRw634RLqfWoY92fvWoB4c79
   kVRDJjKThWpNv+qq5Wa56RvdjkpqVFnsa/q0cjCe2D83PXweY1kO2wR/3
   vmXjggt2t/ja0HnFAJxIQVTZp039EdmDxEPpY2V73DBf4m2RqA7yj/78A
   Q==;
X-CSE-ConnectionGUID: 5s16gJnkTNyHxiC+l65oOQ==
X-CSE-MsgGUID: HH9wVtkMTbGpRya4FJG4yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20195258"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20195258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:27:35 -0700
X-CSE-ConnectionGUID: fYs2kEH5S3K1WQmb+y2UPw==
X-CSE-MsgGUID: g91iWkJeTBioJ/RtYfC81g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47726097"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 11:27:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-04-23 (i40e, iavf, ice)
Date: Tue, 23 Apr 2024 11:27:16 -0700
Message-ID: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e, iavf, and ice drivers.

Sindhu removes WQ_MEM_RECLAIM flag from workqueue for i40e.

Erwan Velu adjusts message to avoid confusion on base being reported on
i40e.

Sudheer corrects insufficient check for TC equality on iavf.

Jake corrects ordering of locks to avoid possible deadlock on ice.

The following are changes since commit a44f2eb106a46f2275a79de54ce0ea63e4f3d8c8:
  tools: ynl: don't ignore errors in NLMSG_DONE messages
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Erwan Velu (1):
  i40e: Report MFS in decimal base instead of hex

Jacob Keller (1):
  ice: fix LAG and VF lock dependency in ice_reset_vf()

Sindhu Devale (1):
  i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Sudheer Mogilappagari (1):
  iavf: Fix TC config comparison with existing adapter TC config

 drivers/net/ethernet/intel/i40e/i40e_main.c |  6 ++---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 30 ++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 16 +++++------
 3 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.41.0


