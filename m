Return-Path: <netdev+bounces-66845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9618412CA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F63A28873D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE12E85E;
	Mon, 29 Jan 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjtKVi83"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA1339BF
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554477; cv=none; b=ZXMgLnnnQPnJg3ES19k3HIiv22blNuVZkIitqBYe4MAEXhaAuly5wMGe0HuTwfhxxXCaUZwnnr4R4GOA7Omd7ETtFN50NR/WtMjbjgyxUqdJoob6NjxjR/Qg0bcGx/MM3O+DdIaQcg2MhYHgANKhgVBS8TtYwb2dOnAni6pivns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554477; c=relaxed/simple;
	bh=CO0qpimkcYVRFT76eOvrcw90eIcybxxYaqZEUegV4sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yw7xYVfSblIwUwRESAagFU3ylNPi8yTK4Y3DuFJSkK7MzDsACmNA7d4YNjcy7jVqf6N4BZ4vyDU7PVMFmf0vpp1LEpCzjcMss8Jh0sB6JAqm14Om1BtJWvieS9zlAwgqdN9og7lDWZB0HfgvD+5sjuqH5A4BG8Ne9H5JyNieOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjtKVi83; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706554476; x=1738090476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CO0qpimkcYVRFT76eOvrcw90eIcybxxYaqZEUegV4sg=;
  b=CjtKVi832Towt1AcYjaanbysWBr7fDU/ss0NeRDqQTV/sUqRn0TbHHyd
   XySIAh7/kIhgfdtPzJ4Yv+8ye026CvKi9c9l1wa84pWX3FjjZEqqa4ulO
   zlSnQeXtWQwuZOqgRAI4TZh51gWuXyVtPbXrqlDx5R+BJ7XvLFJlTK/cT
   NkgjohT6TPNqiMnAIe0yrcgmbbhsdFNmN3lI1d9kvHfIh0aokNpOsBF9p
   ZVJvpTQHC1aGQpq22V16VS76Vor4HcD07QDmWAuAm2pAdAiiBV1/3Re6x
   vl9Ro9+dOqcEdD3S4pSpMq4TRP7iFphL+HIJSGGQAEfiMPk6to4QkWO3z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2879914"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2879914"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 10:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3470143"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jan 2024 10:52:49 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2024-01-29 (e1000e, ixgbe)
Date: Mon, 29 Jan 2024 10:52:36 -0800
Message-ID: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to e1000e and ixgbe drivers.

Jake corrects values used for maximum frequency adjustment for e1000e.

Christophe Jaillet adjusts error handling path so that semaphore is
released on ixgbe.

The following are changes since commit 577e4432f3ac810049cb7e6b71f4d96ec7c6e894:
  tcp: add sanity checks to rx zerocopy
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Christophe JAILLET (1):
  ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Jacob Keller (1):
  e1000e: correct maximum frequency adjustment values

 drivers/net/ethernet/intel/e1000e/e1000.h     | 20 +++++++++++++++++
 drivers/net/ethernet/intel/e1000e/ptp.c       | 22 +++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  3 ++-
 3 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.41.0


