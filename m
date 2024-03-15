Return-Path: <netdev+bounces-80076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843F87CEAA
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006DDB2264A
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC932376FA;
	Fri, 15 Mar 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsCKTAN5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F3376F8;
	Fri, 15 Mar 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512607; cv=none; b=MoQUoT0D2JV7fIq6NX3eGU1uVphZQ2DoI9ebceYM1cf5mtoZ2yHUDYwIykNPpCaH8O3eI2OfOLZph45quhH7w8WV1tcZAWKAGmBdabR3asSSJJkyBEvw4MvnecH1TOvPbRA2AJK5LDxykFPcqOwzmZbXwVR0gmnEtPbqLzq5vM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512607; c=relaxed/simple;
	bh=sUEItuKgutLTb5MQiwL0cprRpiEgiKKPW8dPQXXVeqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iiAdQXzq6PgDGtcpGodIrPLxpya+ILfvH++gGIVWc7jYN5TILhvZ/opLJtLMgLHrV2pNCUnmklLvEBRXeHG6193YC5gqd3ncK0bh7vBqEx1o8UqK6QF4lz0nlHcZILmonIaoRgxrFtjzHYJhxcdTfNqLvvcfbmUL0pADXzo0C2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsCKTAN5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512606; x=1742048606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sUEItuKgutLTb5MQiwL0cprRpiEgiKKPW8dPQXXVeqA=;
  b=OsCKTAN5mgHaMUHCTPxQXW2r3563yNiL69w/FJzDRN2nwf+8p3cg7/jb
   PkoYCecUrZjbw2gQ039nrVrhRFhgtRJfpyIThDNPgbDuvRudHtiTjOokz
   phI1jgVCXj1rs3XnP6Dijto1LLpcvB4XEW8Y4d9ymB4ovLilbhpFwTNDE
   FOsMEZ5Xv52HEqrdni2+hCb4Jk/vWyNVP3S5YbPQm3xDX/hhCrPXcRntK
   w6Qw4qEEysuspoQka8nx6SRa/XRs+bvCTmg5s50M5gPB1CcNNv7bmw7EA
   iP8GiX49l/lbTUrHCObXHGBrxOoc8q9WLBNXplLM3SIJoG7AV8OFf4FOF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5250003"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5250003"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140735"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:19 -0700
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
Subject: [PATCH bpf-next 0/6] Enhancing selftests/xsk Framework: Maximum and Minimum Ring Configurations
Date: Fri, 15 Mar 2024 14:07:20 +0000
Message-Id: <20240315140726.22291-1-tushar.vyavahare@intel.com>
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

1: Adds the definition of ethtool_ringparam to the UAPI header, a
   necessary step for the subsequent patches to run tests with various
   ring sizes.

2: Modifies the BATCH_SIZE from a constant to a variable, batch_size, to
   support dynamic modification at runtime for testing different hardware
   ring sizes.

3: Implements a function, get_hw_ring_size, to retrieve the current
   maximum interface size and store this information in the hw_ring
   structure.

4: Implements a new function, set_hw_ring_size, which allows for the
   dynamic configuration of the ring size within an interface.

5: Adds a new test case that puts the AF_XDP driver under stress by
   configuring minimal hardware and software ring sizes, verifying its
   functionality under constrained conditions.

6: Enhances the framework by adding a new test case that evaluates the
   maximum ring sizes for AF_XDP, ensuring its reliability under maximum
   ring utilization.

Testing Strategy:

Check the system in extreme scenarios, such as maximum and minimum
configurations. This helps identify and fix any bugs that may occur.

Tushar Vyavahare (6):
  tools/include: add ethtool_ringparam definition to UAPI header
  selftests/xsk: make batch size variable
  selftests/xsk: implement get_hw_ring_size function to retrieve current
    and max interface size
  selftests/xsk: implement set_hw_ring_size function to configure
    interface ring size
  selftests/xsk: test AF_XDP functionality under minimal ring
    configurations
  selftests/xsk: enhance framework with a new test case for AF_XDP under
    max ring sizes

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

---
 tools/include/uapi/linux/ethtool.h       |  41 ++++++
 tools/testing/selftests/bpf/xskxceiver.c | 155 +++++++++++++++++++++--
 tools/testing/selftests/bpf/xskxceiver.h |  14 +-
 3 files changed, 200 insertions(+), 10 deletions(-)

-- 
2.34.1


