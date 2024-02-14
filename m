Return-Path: <netdev+bounces-71798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0605855194
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F2C1C2159A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302612839B;
	Wed, 14 Feb 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QO8IGZtG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42961292D5
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933837; cv=none; b=YUvt2JJIo3hUnH1+z+Bw9ayq69i9VPG5jJuUaPrAbq2oxHVOAl7DfuI/ShZ1J/EgXXSt6uWr10G9zEsTEIHqxRniKZbFbo8arnQtmhxXgMNq2CvIfqABER6BJhip1czdz5EIjyIexGMRKxcwdDPUP/DnMBiV0FPYbCfLl639UGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933837; c=relaxed/simple;
	bh=tiqBUEG2hLM/Nzu8bpZL1r5y4QWrpsbsVwuQRQY2rG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/Vcqnlmjf5eC8zqX7hOfiuK6GwV+O8+Tugtqd1MqgjBc+1InZdmae9ztGQSR56pY5GAc7Bs3FtLVEtHclLmOVMqhKRyIWNfKZgtDWi7qet77YMn1D5l78TnYY0mWduZSMlMAMp4eW6K9QjcATgXOgHrzAb3vewk0gauh8J5uZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QO8IGZtG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933836; x=1739469836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tiqBUEG2hLM/Nzu8bpZL1r5y4QWrpsbsVwuQRQY2rG8=;
  b=QO8IGZtG078m8W6ljnu4Psvz6qjEAMrKbiwlXuyDCcNL4zXHyE0dp34b
   9M8CIe9wqcTocaJfUZxc/55PmhjmFEtdYHnzVM3JiQ+k7rbzZ15777+Lk
   TYpuB2/ftTx+XQVxEpcoSsY++tFsybCuzp2CQEiabTV0n6dyfoZfaIfAC
   YGQDLFCUhXeJQNIZ+LVvjx/V6Fl9+HrDyVYiphyOmQlE1GXG/h1E2UbWo
   QAj3SnnYddRmNdQtoLRKllQ0SynFcFpei+t6ep/jnix4l9tadOR8kqORv
   6kllMwSmOOCqP5Y0YIrE9u6HlFJJZ0svUx+4TQaae2oWJxDhFfLB0RQLF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19505798"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19505798"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3251272"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 10:03:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 0/2][pull request] Intel Wired LAN Driver Updates 2024-02-06 (igb, igc)
Date: Wed, 14 Feb 2024 10:03:43 -0800
Message-ID: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to igb and igc drivers.

Kunwu Chan adjusts firmware version string implementation to resolve
possible NULL pointer issue for igb.

Sasha removes workaround on igc.
---
v2:
- Added to commit message (patch 2)

v1: https://lore.kernel.org/netdev/20240206212820.988687-1-anthony.l.nguyen@intel.com/

The following are changes since commit 9b23fceb4158a3636ce4a2bda28ab03dcfa6a26f:
  ethernet: cpts: fix function pointer cast warnings
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Kunwu Chan (1):
  igb: Fix string truncation warnings in igb_set_fw_version

Sasha Neftin (1):
  igc: Remove temporary workaround

 drivers/net/ethernet/intel/igb/igb.h      |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++-----------
 drivers/net/ethernet/intel/igc/igc_phy.c  |  6 +---
 3 files changed, 20 insertions(+), 23 deletions(-)

-- 
2.41.0


