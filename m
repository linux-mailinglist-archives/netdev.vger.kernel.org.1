Return-Path: <netdev+bounces-122972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04D963510
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249A1B253CB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381B1A7AD8;
	Wed, 28 Aug 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JB7zObz/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCD139578
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885691; cv=none; b=UWXgDMek97yZMAYzbiN3Ngcw7yHP9FTsx4pSI179yS3ItzzXJN90KC3yS+z+nGF24g75ssxuzNtx+kdPtSVLazgNQXtaShT7Wey6rF/A9CDN6AK1nlDS5WDgPs1GZGg58f3NQtuOpVJ6my78VqWB9I+HQa+jkxSwjPK6mJ8WRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885691; c=relaxed/simple;
	bh=uZCwDHlKEHjneT2J2ZmXUtuUfwcD+RCsUm2Xjs+9vMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDX7LQeWEe18Dp5VHp8NY2zwCF0waJP2e3oIAXqW+En+ThJ0HL+S1tlO9MWAEZn5x++rdSTfvC1zARVL57SHrvfBGQcNWkxj4h7rc2PFqa4a9clKg6MZYAMnY5HFI7uZvxqoGI2+T1PCAmIu6b0/MEYvJvQtzg8sRQ+BStpGrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JB7zObz/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724885690; x=1756421690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uZCwDHlKEHjneT2J2ZmXUtuUfwcD+RCsUm2Xjs+9vMg=;
  b=JB7zObz/PCEPLza+xiFW1tCEWzfLFxL1v1oJ8gRa+NxrQsZ+eE9pYH+j
   Zl5zz9JuzV2BeU5wpcKAWOZmXvVx9ba+vbBFNlkTX/QlSfEjb6/qnpilP
   QFl9tpXajpa+Ghzx65ZvrLnKSTeOlbNQfQm74wdx85J1ai9OcRbBQOvJE
   5s1NDpd2T+xatM3oHa9gOhBohUEiuQzNJvwWcYUoGy3y7LRtjR3Sk04Ai
   EFqCKshe5NSYPejlI9EXYrvXJNkSYlD6YCHeFUtMAMZ17dO8DRoDhQD6+
   t/KZ2xyXVPxDQMDJoeQ59JqoH0CwXAfKjMl1yO+ccsYPv6NKEY4acodGd
   Q==;
X-CSE-ConnectionGUID: UD96KdqdT7qoldcTb0Jq6g==
X-CSE-MsgGUID: y0yaguJHRg+mJA5pXqSRpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23408503"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23408503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:54:49 -0700
X-CSE-ConnectionGUID: zgLAHNV2SxmHKx17LmSIlQ==
X-CSE-MsgGUID: i/DjgDDPTb6WFVJN/X1MDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63022897"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 28 Aug 2024 15:54:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2024-08-28 (igb, ice)
Date: Wed, 28 Aug 2024 15:54:40 -0700
Message-ID: <20240828225444.645154-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to igb and ice drivers.

Daiwei Li restores writing the TSICR (TimeSync Interrupt Cause)
register on 82850 devices to workaround a hardware issue for igb.

Dawid detaches netdev device for reset to avoid ethtool accesses during
reset causing NULL pointer dereferences on ice.

The following are changes since commit 3a0504d54b3b57f0d7bf3d9184a00c9f8887f6d7:
  sctp: fix association labeling in the duplicate COOKIE-ECHO case
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Daiwei Li (1):
  igb: Fix not clearing TimeSync interrupts for 82580

Dawid Osuchowski (1):
  ice: Add netif_device_attach/detach into PF reset flow

 drivers/net/ethernet/intel/ice/ice_main.c |  7 +++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

-- 
2.42.0


