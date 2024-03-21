Return-Path: <netdev+bounces-81065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07D885A43
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC7B1F225AD
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615284FAD;
	Thu, 21 Mar 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fV9ZJCbW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F258AA8;
	Thu, 21 Mar 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029916; cv=none; b=q7IVoavlhJhsqLyVL40Kq2ClDUrZL1E/Or6mAW9qykyCawly/6LqsCcCHgINKQyGXZZYRB+RMWiaDIYKLC7gm7ckgZsMVrDyeKsZoSnj/Sh5/EeFIZiVu0J6nJHhcX2P20YBfqTIVa3gtxWY/tLAQCEc2EEJGpx5U9pZjxJk0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029916; c=relaxed/simple;
	bh=jH8bQ0u9CUSKqXv05SFVoT15Aw5bdy9ExHvUoS+Bugs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGU8sLko0CFDb7drVCkmAGB1adNI/mEYRGZuHnIqfNRegBl++pPom43YknxBl6f4gkcQTgeUVRi6UqNm+u0L5etIOoo518O1CojrmVtvxfvkyiFBudBr3c13elq4pYu2uGHxM+xoDQqvXhp2lflyKrozNKkuvwnAgAZzC6HNJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fV9ZJCbW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029914; x=1742565914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jH8bQ0u9CUSKqXv05SFVoT15Aw5bdy9ExHvUoS+Bugs=;
  b=fV9ZJCbWP2Fy8lvQYvJ3L5NVLdYYz/l6v2QDNHtcy9YRtzZEylOtompg
   6ruFzeQz07s81/UpCflOQun5Wi2TY3KLtcGFwdnpdNlgi+UHKdgulz4/+
   dWUym8BZbI/wgfibUi4oAqrtoBWIOandRLM0IHHKKiCIGc6R0qEOXTChu
   XOpp9br9IRBxQaR8+QQY3Z4oORdCAygziuJpLGIwQ2hAJrWrsHh99y098
   vefgMGPUVcoim1xVcmWg3pUTGQfPu+xKByZJphXcdooqSITwg2Nzw1AC1
   jRSiwrnmql9zuN5VeGleeJFV/g3upKzA2swEXPU/jIuEDewKuz9do/7ol
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5910895"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5910895"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911250"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:09 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v2 0/7] Selftests/xsk: Test with maximum and minimum HW ring size configurations
Date: Thu, 21 Mar 2024 13:49:04 +0000
Message-Id: <20240321134911.120091-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please find enclosed a patch set that introduces enhancements and new test
cases to the selftests/xsk framework. These test the robustness and
reliability of AF_XDP across both minimal and maximal ring size
configurations.

While running these tests, a bug [1] was identified when the batch size is
roughly the same as the NIC ring size. This has now been addressed by
Maciej's fix.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=913eda2b08cc49d31f382579e2be34c2709eb789

Patch Summary:

1. This commit syncs the ethtool.h header file between the kernel source
   tree and the tools directory to maintain consistency.

2: Modifies the BATCH_SIZE from a constant to a variable, batch_size, to
   support dynamic modification at runtime for testing different hardware
   ring sizes.

3: Implements a function, get_hw_ring_size, to retrieve the current
   maximum interface size and store this information in the
   ethtool_ringparam structure.

4: Implements a new function, set_hw_ring_size, which allows for the
   dynamic configuration of the ring size within an interface.

5: Introduce a new function, set_ring_size(), to manage asynchronous AF_XDP
   socket closure. Make sure to retry the set_hw_ring_size function
   multiple times, up to SOCK_RECONF_CTR, if it fails due to an active
   AF_XDP socket. Immediately return an error for non-EBUSY errors.

6: Adds a new test case that puts the AF_XDP driver under stress by
   configuring minimal hardware and software ring sizes, verifying its
   functionality under constrained conditions.

7: Add a new test case that evaluates the maximum ring sizes for AF_XDP,
   ensuring its reliability under maximum ring utilization.

Testing Strategy:

Check the system in extreme scenarios, such as maximum and minimum
configurations. This helps identify and fix any bugs that may occur.

Tushar Vyavahare (7):
  tools/include: copy ethtool.h to tools directory
  selftests/xsk: make batch size variable
  selftests/bpf: implement get_hw_ring_size function to retrieve current
    and max interface size
  selftests/bpf: implement set_hw_ring_size function to configure
    interface ring size
  selftests/xsk: introduce set_ring_size function with a retry mechanism
    for handling AF_XDP socket closures
  selftests/xsk: test AF_XDP functionality under minimal ring
    configurations
  selftests/xsk: add new test case for AF_XDP under max ring sizes

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

---
Changelog:
v1->v2
- copy ethtool.h to tools directory [Stanislav]
- Use ethtool_ringparam directly for get_hw_ring_size() [Stanislav]
- get_hw_ring_size() and get_hw_ring_size() moved to network_helpers.c [Stanislav]
- return -errno to match the other cases where errors are < 0. [Stanislav]
- Cleaned up set_ring_size() function by removing unused variables and
  refactoring logic for clarity. [Alexei]
- Implement a retry mechanism for the set_ring_size function to handle
  the asynchronous nature of AF_XDP socket closure. [Magnus]
---

 tools/include/uapi/linux/ethtool.h            | 2229 ++++++++++++++++-
 tools/testing/selftests/bpf/Makefile          |    2 +-
 tools/testing/selftests/bpf/network_helpers.c |   48 +
 tools/testing/selftests/bpf/network_helpers.h |    5 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |   14 -
 tools/testing/selftests/bpf/xskxceiver.c      |  123 +-
 tools/testing/selftests/bpf/xskxceiver.h      |   12 +-
 7 files changed, 2376 insertions(+), 57 deletions(-)

-- 
2.34.1


