Return-Path: <netdev+bounces-220797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D027CB48C6C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507024E168F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDB21FF4A;
	Mon,  8 Sep 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5hkS/I9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5681D5150
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331832; cv=none; b=QQi33bkwllGr+RmeLTiOBcB4OFW4h3lSSVJbRCBbvwDY1t5q4+qwAGogYQXKrJqc+WS3+UKjDFqOXxVk1IEuXx7naY2XXZ/W03p9vgT/QEQDWBSs2JIisCP4k7FZDxxpSY4NmVzNEpR0zkcYZ0/MRiHjK3OPL4TQh2+WkdjUBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331832; c=relaxed/simple;
	bh=cj3DufsB9KuohV6+o1exFCW2sERmdm38ERn1NLLh3KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4AMKFtlGntkOc2dJ+a8niDQxiq9SF9cZX683Z53sRRfIO2W2VUjWanH6N/0l/DTgJbP/39ADAP31cfcCxZNNQWG0BOjikQUzwDTSUnisv8LrQjvqNt8FSc8eD5dq2fooYARSOrK/2y03CQF19nCA7xIkdQveC4kWTr8/0KMjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5hkS/I9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757331830; x=1788867830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cj3DufsB9KuohV6+o1exFCW2sERmdm38ERn1NLLh3KQ=;
  b=T5hkS/I9ROc2hp5dXjYXrdbZ1fd9kgjyi91T6WG5vqEh2ewCuBWhaXvt
   aUdlsla1ZBQ70rAti9g4T6GUb6/b3MsnZJDpJAiYl2LkTbkHxC++LbOPc
   xKeFXFHzubEKS4vit2FjEGRjvfnzoT6UVNTiuC5vowL/STUGaBedS6iFP
   Fej5heZsbFFrIwOlQLeBAouZdK5xogV0RGV9EEYUPRfkAMOZzqy4+rnkE
   S22Xlin9GlHBAfu6n9AkzipAg0gGZuci7xOTrCMWGlcVeB/d+epc1tPxJ
   D5RULgHQhX2cRU67k1i+NIRCIOCYQ2JJTt8bH3G5DZDivCgClAhWL7gbg
   w==;
X-CSE-ConnectionGUID: 9Q/t0psPQKiX0s0uDHK6/Q==
X-CSE-MsgGUID: vUOrXJS/SP2+ppgYaOfppg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="63412830"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="63412830"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:43:49 -0700
X-CSE-ConnectionGUID: /1bOsHKHRp+RsY/XapnyjA==
X-CSE-MsgGUID: x4/7f681QdedMmB6hl5CWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="177126082"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa005.fm.intel.com with ESMTP; 08 Sep 2025 04:43:48 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-net v2 0/2] ixgbe: fix aci.lock issues
Date: Mon,  8 Sep 2025 13:26:27 +0200
Message-Id: <20250908112629.1938159-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 mutex (aci.lock) issues in ixgbe driver:
1) call trace on load - addressed by the 1st patch
2) call trace on unload - uncovered by the 1st patch and fixed by the
   2nd one

Both issues are highlighted by the commit 337369f8ce9e
("locking/mutex: Add MUTEX_WARN_ON() into fast path") and appear only
when CONFIG_DEBUG_MUTEXES flag is set.

Jedrzej Jagielski (2):
  ixgbe: initialize aci.lock before it's used
  ixgbe: destroy aci.lock later within ixgbe_remove path
---
v2: introduce additional patch in order to fix call trace appearing  after
applying 1st patch - call trace on reload
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.31.1


