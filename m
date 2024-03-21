Return-Path: <netdev+bounces-81071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE6885A4F
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA9C283565
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D135F84FDA;
	Thu, 21 Mar 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCdDbX3O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644584FCF;
	Thu, 21 Mar 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029944; cv=none; b=q4e0/jWXL1OtoOiUVPwa5RHVpVFw4nEUhIQHx/vjqXJPz4eophWMWw0+0RqwrC7vZRv3w2x3Q+FnQdya5WPI7yb5zqPY5evmU25KUTk445Y62nXYMueNLFJRKW9OIK01XYbQKr3mllr83wOQQiSHGHm2hKNvzELgiiaZtb6MnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029944; c=relaxed/simple;
	bh=xoRt2xQ9+6rlr6ERoM8rH7GWJQCgcNSvCwyFagdBgpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAKjF+W/HOhw187UCUPHW1SCQnu23Eu/e/aMVEq7RlcQ1CkzTRu57XlMQkEw775iwc/WLrnwwrjXicgIB3IND908twCvUAAHYsRnJTDa6cFM/zPUxX9CaZwUudY0PNzZbmTMRJHzODwJTFosvNBfZyb9eyLXpYPG3W7T9aFW3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCdDbX3O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029943; x=1742565943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xoRt2xQ9+6rlr6ERoM8rH7GWJQCgcNSvCwyFagdBgpw=;
  b=SCdDbX3OtCNZ+uRnEL1tN5/L7bXbxuHVwjgg2riKmvSfvH4SU8urJ7nh
   6vfmrvv1P/BVFrnBdwV0A42z+lBNNP9+0Z/fcZ2q0bDPvTuqoFC4nUvbz
   /ByWazZZ5bpnDIkarXzVlXB/Q861ryD3A2goxDAOyb/mYWhs0PTAywT6G
   WmPNAhOPdkF5BML/e0xuIWEse6Vdr672NeS1Zn5Pf59OocVpyyOpuJM8Q
   Yc59qUWHl1i/1i6TCiBC8YL1ztcbHtqkP7F7tjTyqNSVEBhZu2CKr8HAD
   krKKcoOtp/RyE/dTjHmFgjLs1/HjF+ZpmzCmF8dDTgZMi5X8HkdHlDDxW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5911030"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5911030"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911387"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:39 -0700
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
Subject: [PATCH bpf-next v2 6/7] selftests/xsk: test AF_XDP functionality under minimal ring configurations
Date: Thu, 21 Mar 2024 13:49:10 +0000
Message-Id: <20240321134911.120091-7-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321134911.120091-1-tushar.vyavahare@intel.com>
References: <20240321134911.120091-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new test case that stresses AF_XDP and the driver by configuring
small hardware and software ring sizes. This verifies that AF_XDP continues
to function properly even with insufficient ring space that could lead to
frequent producer/consumer throttling. The test procedure involves:

1. Set the minimum possible ring configuration(tx 64 and rx 128).
2. Run tests with various batch sizes(1 and 63) to validate the system's
   behavior under different configurations.

Update Makefile to include network_helpers.o in the build process for
xskxceiver.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 8c26868e17cf..dac2dcf39bb8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2419,6 +2419,26 @@ static int testapp_xdp_metadata_mb(struct test_spec *test)
 	return testapp_xdp_metadata_copy(test);
 }
 
+static int testapp_hw_sw_min_ring_size(struct test_spec *test)
+{
+	int ret;
+
+	test->set_ring = true;
+	test->total_steps = 2;
+	test->ifobj_tx->ring.tx_pending = DEFAULT_BATCH_SIZE;
+	test->ifobj_tx->ring.rx_pending = DEFAULT_BATCH_SIZE * 2;
+	test->ifobj_tx->xsk->batch_size = 1;
+	test->ifobj_rx->xsk->batch_size = 1;
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	/* Set batch size to hw_ring_size - 1 */
+	test->ifobj_tx->xsk->batch_size = DEFAULT_BATCH_SIZE - 1;
+	test->ifobj_rx->xsk->batch_size = DEFAULT_BATCH_SIZE - 1;
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2523,6 +2543,7 @@ static const struct test_spec tests[] = {
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
+	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
 	};
 
 static void print_tests(void)
-- 
2.34.1


