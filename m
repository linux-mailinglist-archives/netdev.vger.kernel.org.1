Return-Path: <netdev+bounces-80081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5587CEB8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3504B1F228AD
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC753DBBC;
	Fri, 15 Mar 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyi1Nxnj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0183D575;
	Fri, 15 Mar 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512628; cv=none; b=f9uTMhiSmef9umZxFKS5MrbCzq/npTH3OfoMHGzmYNY/fwYoEe26d60kWE8Kq7jwB6xXpcWr0lbDK0jE0AK9Gr0FjYahvgZz4uDly5gwvCloUKygmBPk4CdbhZVPlxXeNt9gGvwE57ucsacSDc29YGcO54G7evsfuFCDMvk32zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512628; c=relaxed/simple;
	bh=IgxxG8teAX2Wi5yKO8lrW9VDFBr+MNwOs9XcX07ZWcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WT7lt9G3Ica3ejL+LEpGCcrkFcI4hKbjFI3Nd420rhBsZTXb4z3YYgGu6xpldaddC/oQOGsBEwp/28fPMM0yiBhAf8pXRv/Iv4mUKogtsjOWCimmOcDy9OJSz7DX1L9Uus8Zl/lx2T/GQ2Xv6H/M1nsC/gaagEhME2mWfOvMCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyi1Nxnj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512627; x=1742048627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgxxG8teAX2Wi5yKO8lrW9VDFBr+MNwOs9XcX07ZWcA=;
  b=gyi1NxnjhN/ZU9B/8OJw1mVx3pFBfXpgdJaoXysAZo2J/dufiZlBLt0F
   xLepLTFuwoXXjg+ikkaOX5UCqPM/4NEU6RiEUb8y78CcQFyW98xkKb7/w
   3/Aig3SCBLlNRbpOgfSojAWNwrgswVT9jh5xS8R2T52A9YbtxzvAWKctQ
   8UaYkisLNEF/3NfmEMVCvNni758xnXSP8+N9yRIn/lhpHscfnB8sQFqL/
   5J4D4IJhgMs+kLwzDyWIwsbFxCmq9ZMztE8xRlQHf4bv/0tTG8aLZkdv4
   XlYMZrdybxam2lskimqeYV+VHXIeDODdV+jm4AJl7LR2I4qRM+I7RgJgv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5250092"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5250092"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140757"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:42 -0700
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
Subject: [PATCH bpf-next 5/6] selftests/xsk: test AF_XDP functionality under minimal ring configurations
Date: Fri, 15 Mar 2024 14:07:25 +0000
Message-Id: <20240315140726.22291-6-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315140726.22291-1-tushar.vyavahare@intel.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
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

1. Set the minimum possible ring configuration(tx 64 and rx 64).
2. Run tests with various batch sizes(1 and 63) to validate the system's
   behavior under different configurations.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 47 ++++++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.h |  3 ++
 2 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index aafa78307586..5326ca5c458c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -476,6 +476,12 @@ static int set_hw_ring_size(struct ifobject *ifobj, u32 tx, u32 rx)
 	return 0;
 }
 
+static int hw_ring_size_reset(struct ifobject *ifobj)
+{
+	return set_hw_ring_size(ifobj, ifobj->ring.default_tx,
+				ifobj->ring.default_rx);
+}
+
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			     struct ifobject *ifobj_rx)
 {
@@ -519,6 +525,9 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		}
 	}
 
+	if (ifobj_tx->hw_ring_size_supp)
+		hw_ring_size_reset(ifobj_tx);
+
 	test->ifobj_tx = ifobj_tx;
 	test->ifobj_rx = ifobj_rx;
 	test->current_step = 0;
@@ -530,6 +539,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
 	test->xdp_prog_tx = ifobj_tx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_tx = ifobj_tx->xdp_progs->maps.xsk;
+	test->ifobj_tx->ring.set_tx = 0;
+	test->ifobj_tx->ring.set_rx = 0;
 }
 
 static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
@@ -1929,6 +1940,16 @@ static int testapp_validate_traffic(struct test_spec *test)
 		return TEST_SKIP;
 	}
 
+	if (ifobj_tx->ring.set_tx) {
+		if (ifobj_tx->hw_ring_size_supp) {
+			return set_hw_ring_size(ifobj_tx, ifobj_tx->ring.set_tx,
+						ifobj_tx->ring.set_rx);
+		} else {
+			ksft_test_result_skip("Changing HW ring size not supported.\n");
+			return TEST_SKIP;
+		}
+	}
+
 	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
@@ -2442,6 +2463,23 @@ static int testapp_xdp_metadata_mb(struct test_spec *test)
 	return testapp_xdp_metadata_copy(test);
 }
 
+static int testapp_hw_sw_min_ring_size(struct test_spec *test)
+{
+	int ret;
+
+	test->total_steps = 2;
+	test->ifobj_tx->ring.set_tx = DEFAULT_BATCH_SIZE;
+	test->ifobj_tx->ring.set_rx = DEFAULT_BATCH_SIZE;
+	test->ifobj_rx->xsk->batch_size = 1;
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	/* Set batch size to hw_ring_size - 1 */
+	test->ifobj_rx->xsk->batch_size = DEFAULT_BATCH_SIZE - 1;
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2546,6 +2584,7 @@ static const struct test_spec tests[] = {
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
+	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
 };
 
 static void print_tests(void)
@@ -2566,6 +2605,7 @@ int main(int argc, char **argv)
 	int modes = TEST_MODE_SKB + 1;
 	struct test_spec test;
 	bool shared_netdev;
+	int ret;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -2603,6 +2643,10 @@ int main(int argc, char **argv)
 			modes++;
 	}
 
+	ret = get_hw_ring_size(ifobj_tx);
+	if (!ret)
+		ifobj_tx->hw_ring_size_supp = true;
+
 	init_iface(ifobj_rx, worker_testapp_validate_rx);
 	init_iface(ifobj_tx, worker_testapp_validate_tx);
 
@@ -2650,6 +2694,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (ifobj_tx->hw_ring_size_supp)
+		hw_ring_size_reset(ifobj_tx);
+
 	pkt_stream_delete(tx_pkt_stream_default);
 	pkt_stream_delete(rx_pkt_stream_default);
 	xsk_unload_xdp_programs(ifobj_tx);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 4f58b70fa781..21926672f877 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -119,6 +119,8 @@ struct hw_ring {
 	u32 default_rx;
 	u32 max_tx;
 	u32 max_rx;
+	u32 set_tx;
+	u32 set_rx;
 };
 
 struct ifobject;
@@ -154,6 +156,7 @@ struct ifobject {
 	bool unaligned_supp;
 	bool multi_buff_supp;
 	bool multi_buff_zc_supp;
+	bool hw_ring_size_supp;
 };
 
 struct test_spec {
-- 
2.34.1


