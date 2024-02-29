Return-Path: <netdev+bounces-75966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43E86BCEC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BE1F22D17
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BE101C8;
	Thu, 29 Feb 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gi6KjYjo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E9BE4F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167300; cv=none; b=muxBfgfCOp/VLkiCCg1p3Qr1+28KfA4PXhDL+F2ZUqiQkyKwnMTaVWZL6HttA4x+liLtFpZcXpGYIMRQofSSwsNef/0mdyEpk7648jgyrNouC7EIs/UcgHjgBEYiNRXDGrRwlKNEFuLlxN7MjJJjy4sTlTXzwaoC/qfAy+M2qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167300; c=relaxed/simple;
	bh=4kQYd2ZHNhkclLG4l+RHqM/REIwhgGEOo6WWbm54+Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqMwgoNhZKigaIep4Xh0m7JpWE8l0FBsYVxRFjS2+PpDJtnR3F9LevMs/0fu6h5kSBsvLYab3Dn0nxrmdX3cGZgdyO1v70SgQVYjQY8oQPxMqOR5O5YmbXapHj/UO4IPq1stFtVh0NhoDlcMYk6SWp9/kMk5pH8Cla9JlmbP1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gi6KjYjo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167300; x=1740703300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4kQYd2ZHNhkclLG4l+RHqM/REIwhgGEOo6WWbm54+Cs=;
  b=gi6KjYjoxkWv4tozEFuVS5xafaoRVb46iW3YypcqynBZIe22iIu90rDy
   4bHd1vH6i1TsJR7FKSAckVhIheeaYVc7taPUPFQSsezoi4mkpJAfJpauH
   iJ/P22jppVz3QURCFIfuuqWF/UNbjzbOIY8/+icKMuV+D5cCxlB4Akx03
   dU7f4N5PCHTaerNTh48FGoELGEWYFNtBGu4cJK588uSMCq3G0beiXXtE/
   pZ5SUPx9k1PH91pKc5wHCb07HAGmwIZhXhVpiv+J112o6HWyHdYqwARDE
   aEWz1Mkl69zljOCpC4lE14vr2ErhzTWPzdQK7c9ThS5XSlqPQkAzLGa/U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776508"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12281943"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 16:41:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2024-02-28 (ixgbe, igc, igb, e1000e, e100)
Date: Wed, 28 Feb 2024 16:41:28 -0800
Message-ID: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ixgbe, igc, igb, e1000e, and e100
drivers.

Jon Maxwell makes module parameter values readable in sysfs for ixgbe,
igb, and e100.

Ernesto Castellotti adds support for 1000BASE-BX on ixgbe.

Arnd Bergmann fixes build failure due to dependency issues for igc.

Vitaly refactors error check to be more concise and prevent future
issues on e1000e.

The following are changes since commit 4ac828960a604e2ae72af59ce44dafdc8b12675f:
  Merge branch 'eee-linkmode-bitmaps'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Arnd Bergmann (1):
  igc: fix LEDS_CLASS dependency

Ernesto Castellotti (1):
  ixgbe: Add 1000BASE-BX support

Jon Maxwell (1):
  intel: make module parameters readable in sys filesystem

Vitaly Lifshits (1):
  e1000e: Minor flow correction in e1000_shutdown function

 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/e100.c             |  4 +--
 drivers/net/ethernet/intel/e1000e/netdev.c    |  8 ++---
 drivers/net/ethernet/intel/igb/igb_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 32 ++++++++++++++++---
 6 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.41.0


