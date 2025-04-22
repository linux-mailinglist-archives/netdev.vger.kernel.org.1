Return-Path: <netdev+bounces-184737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB868A97122
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AED3168CE8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9F28EA62;
	Tue, 22 Apr 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mz2pG2xd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919928EA5A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336239; cv=none; b=Fz4ZRDGmflZJ2fTCw8mM98zb2DTSef99dzTFeENKRjqIuPdQJmA8xQfFO9h94/MByr7qNRwfm8uHHnzDZnn5rb5PcwQcTmakFaysov1M7okWgV4TW5/aGmRllqsPdP+SxIVvwLPNJ+2/9/ZCMNgQTgEAjVPs9hfm/i35qZyf0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336239; c=relaxed/simple;
	bh=n/Ymh0EFbuVorEMi04SIWJFnWO9TGcRoXwxRzF2Endo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBP/YYWuRbqahleT1LcNj5SLXhQyYmkOdnopQDr1xJPAO5z1geQ9Ghvj+WYoP3uVUs+V2cBK736KW4eFyRjfuF1wc+CjMzI7C4gR4bg6BGQU4PvIEl+JCztAAXQN9g8GSGw9RUCG2LND0kQJSuXfH6tWM3kDxLGPh5N3SLjTlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mz2pG2xd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745336238; x=1776872238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n/Ymh0EFbuVorEMi04SIWJFnWO9TGcRoXwxRzF2Endo=;
  b=Mz2pG2xdhCci3J525xKnSb5L4+Cb3BaUvuysZK97Zod9aHpHs0d5zZlz
   9jYHvyVmaopl6XPH9AEG4nJmY/mDQQL1TBV3jLziqfcE6wUIYoTkiHhb5
   yG/OA1o/yVqSzND9ijpCALEzRzazKt4/A78O0bjVuh+WSDQ5kyVJ8//rU
   JVmR65f4HJCzDG3C9YiJ8S4TbTSLI29QCiwtF/W8f6fkM0XWRx8jBaXwy
   MXLWjiB4KNqyMdMCw1+jwXhshksrKxDRevN0oQ9cHpKsl9v7oMPzntIaG
   iBJKKNw/CQz60TMzTPb3ghq8XyxO68R1WeIIi/9/OrC8cYl/2jYZG7w4v
   w==;
X-CSE-ConnectionGUID: Aq+NybFFQK2qWxADr8rhIA==
X-CSE-MsgGUID: woYIMOILR/CK+8quAiaVlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64312333"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="64312333"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:37:17 -0700
X-CSE-ConnectionGUID: 993qaqTfRcylNdp9inO42A==
X-CSE-MsgGUID: Yfx8QJ6jRU6QZzwAgMXCOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="131947817"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:37:14 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-net 0/3] Fix XDP loading on machines with many CPUs
Date: Tue, 22 Apr 2025 17:36:56 +0200
Message-Id: <20250422153659.284868-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some of our customers have reported a crash problem when trying to load
the XDP program on machines with a large number of CPU cores. After
extensive debugging, it became clear that the root cause of the problem
lies in the Tx scheduler implementation, which does not seem to be able
to handle the creation of a large number of Tx queues (even though this
number does not exceed the number of available queues reported by the
FW).
This series addresses this problem.

First of all, the XDP callback should not crash even if the Tx scheduler
returns an error, so Patch #1 fixes this error handling and makes the
XDP callback fail gracefully.
Patch #2 fixes the problem where the Tx scheduler tries to create too
many nodes even though some of them have already been added to the
scheduler tree.
Finally, Patch #3 implements an improvement to the Tx scheduler tree
rebuild algorithm to add another VSI support node if it is necessary to
support all requested Tx rings.

As testing hints, I include sample failure scenarios below:
  1) Number of LAN Tx/Rx queue pairs: 128
     Number of requested XDP queues: >= 321 and <= 640
     Error message:
        Failed to set LAN Tx queue context, error: -22
  2) Number of LAN Tx/Rx queue pairs: 128
     Number of requested XDP queues: >= 641
     Error message:
        Failed VSI LAN queue config for XDP, error: -5

Thanks,
Michal


Michal Kubiak (3):
  ice: fix Tx scheduler error handling in XDP callback
  ice: create new Tx scheduler nodes for new queues only
  ice: fix rebuilding the Tx scheduler tree for large queue counts

 drivers/net/ethernet/intel/ice/ice_main.c  |  47 +++++++---
 drivers/net/ethernet/intel/ice/ice_sched.c | 103 +++++++++++++++++++--
 2 files changed, 126 insertions(+), 24 deletions(-)

-- 
2.45.2


