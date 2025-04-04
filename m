Return-Path: <netdev+bounces-179272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337EA7BAD3
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F65517883B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483E1EB5E5;
	Fri,  4 Apr 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RP+KdNma"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B81EB187
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762586; cv=none; b=RVyLhWAYQouozmPTaelzKFEhAQj2ZeDcENxkJHhkF6IYsdeLGuPeK8boVWdGjD7SkulTbnP5sJS5j0xVQrULNhS9VgaRUONVfy+ZGrmuWXO8irwKnIw89zx0bl1dAyuuRpz3oXZ1GzSXOEGIroiOz2U0/SrKjAUh1PRowquNY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762586; c=relaxed/simple;
	bh=RG93Fpdngz5z7PSj8asDmrw/ZjfV29C/fDhTOXzFCEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uLELGpFspB7Ss8YEUXYOL/LZVpYqioYamARZfTATmso9+QBxYKVX9899BTpli948yDr2wOioXRq+OgbspiZDod1OYw8vuDMyUl5fHiRJwNfYhpuv6R/35fYxi8OPiQrkf4cBK3ncIGks8RFv2kPb9c9MWUdWLArVvXRKVNj3EBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RP+KdNma; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743762584; x=1775298584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RG93Fpdngz5z7PSj8asDmrw/ZjfV29C/fDhTOXzFCEk=;
  b=RP+KdNmad5IdJugailw3ANMamwlsjIBER0YY9kkUzs5H9Bc1cydLikUa
   3MZGgknVzYtODHW+b+eCuVjfkViL41fGyEMUTJQIpU1DdLxgiNXoC+82m
   f4osxpxospKuCFjFB60R5GDbeqvjpbYOwYFc7lo3XP252OvCek4/ajYF0
   3oe00c3vjg235UY0R/1OSp3SYOUUV0R28DYJLhEGkU50AZv/SFRD/T2mi
   RIsDShiqy40Yj/PDt9xorq2OwwMLzolnM7GSjC68DJUMON4Fbb/Uq7OIL
   iyx+Z13AXengmWL1uYEUF++KbjeO5MiQq1EJg5QNHixMr9SE1q5BMqULX
   w==;
X-CSE-ConnectionGUID: QuCQuW6GQ2+p6eT/T+RoUQ==
X-CSE-MsgGUID: m1X81jwGRfOjcC2iyqvD0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="48992428"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="48992428"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:29:42 -0700
X-CSE-ConnectionGUID: VD45QYLXSnSyIchbUbXj8w==
X-CSE-MsgGUID: 7fELeSEDTnS66HAbkDlthg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164485283"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2025 03:29:40 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AED4133E99;
	Fri,  4 Apr 2025 11:29:39 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 0/6] undeadlock iavf
Date: Fri,  4 Apr 2025 12:23:15 +0200
Message-Id: <20250404102321.25846-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some deadlocks in iavf, and make it less error prone for the future.

Patch 1 is simple and independed from the rest.
Patches 2, 3, 4 are strictly a refactor, but it enables the last patch
	to be much smaller.
	(Technically Jake given his RB tags not knowing I will send it to -net).
Patch 5 just adds annotations, this also helps prove last patch to be correct.
Patch 6 removes the crit lock, with its unusual try_lock()s.

I have more refactoring for scheduling done for -next, to be sent soon.

There is a simple test:
 add VF; decrease number of queueus; remove VF
that was way too hard to pass without this series :)

Testing hints for VAL:
whole regression set, both against ice and i40e.

Przemek Kitszel (6):
  iavf: iavf_suspend(): take RTNL before netdev_lock()
  iavf: centralize watchdog requeueing itself
  iavf: simplify watchdog_task in terms of adminq task scheduling
  iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
  iavf: sprinkle netdev_assert_locked() annotations
  iavf: get rid of the crit lock

 drivers/net/ethernet/intel/iavf/iavf.h        |   1 -
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  29 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 289 ++++++------------
 3 files changed, 96 insertions(+), 223 deletions(-)

-- 
2.39.3


