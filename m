Return-Path: <netdev+bounces-80082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AC87CEBA
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917691F228AC
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A93BB33;
	Fri, 15 Mar 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOO4/P6C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B293FB1B;
	Fri, 15 Mar 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512632; cv=none; b=q6gbBWDdcqv+hG3klKRkMFgL6AUgJD3FAYgaAcJcXShiHVmW8+Wmru9MFgZkMFfSCdPoBbA9SnLLytK6dugcsh4QIytHe4mwTWDwgpiXlwdSDOOWkAhI/AW1gVagFoYYRlFfmwbbzA+Z0Nlgzu9KZnX4N/e8WvGGFkzbs/yLAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512632; c=relaxed/simple;
	bh=ymtlPopoAK6IcVkhxWyn3VJniXSJJ6SOqftfCTa+nu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNsQwmcgWJr0ggpodRk3Tz3ZF2T2XoIr4E1qL1qiL++HkS4eErwEPPglpmmJ32zLY7/f3FwboKx0r+GJ8wxtvMa9ni9L1v53/ixbkrNbaKBekb/hTD6i/pMBxvKhpVtWlxFKyaTOkKKGfUSV9QvymJqy5UGyG2kAavOBhWqTou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOO4/P6C; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512631; x=1742048631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymtlPopoAK6IcVkhxWyn3VJniXSJJ6SOqftfCTa+nu0=;
  b=WOO4/P6CIMbAWMpVXvT9ZzdV++1UIUc0TTh96jJh3KOmRMy8tyUMoHTh
   8XVukbvGHCaqgqol6MqsEOxy7o81SoCyzEtNpzxBaaolTw+NMV+SXJ3J1
   OjQ9pNbS+ULbTLp7QBNt6jXc2pFnTtf6hNGZC1wnyVzTCA6AnaUvZ37Ke
   H+LnljRuUoNzWA+D7taEB81I8/sQ0Sx/QE8kVkftUgRp5CXRVojq6U+5m
   wYrPrAJQ1dSbPHXCNQ85Xw9WoVApS7pLPdhUH7IciBicwhrEvleBDHLP1
   ADx5oWvUpKnhJQQTGq0XZ4BDkO2rWU5gWtiAJzG/78hRDyGBm8ccqoCov
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5250119"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5250119"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140761"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:23:47 -0700
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
Subject: [PATCH bpf-next 6/6] selftests/xsk: enhance framework with a new test case for AF_XDP under max ring sizes
Date: Fri, 15 Mar 2024 14:07:26 +0000
Message-Id: <20240315140726.22291-7-tushar.vyavahare@intel.com>
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

Introduce a test case to evaluate AF_XDP's robustness by pushing hardware
and software ring sizes to their limits. This test ensures AF_XDP's
reliability amidst potential producer/consumer throttling due to maximum
ring utilization. The testing strategy includes:

1. Configuring rings to their maximum allowable sizes.
2. Executing a series of tests across diverse batch sizes to assess system
   performance under varying load conditions.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 5326ca5c458c..f545b529e404 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2480,6 +2480,26 @@ static int testapp_hw_sw_min_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_hw_sw_max_ring_size(struct test_spec *test)
+{
+	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
+	int ret;
+
+	test->total_steps = 2;
+	test->ifobj_tx->ring.set_tx = test->ifobj_tx->ring.max_tx;
+	test->ifobj_tx->ring.set_rx = test->ifobj_tx->ring.max_rx;
+	test->ifobj_rx->umem->num_frames = max_descs;
+	test->ifobj_rx->xsk->rxqsize = max_descs;
+	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	/* Set batch_size to 4095 */
+	test->ifobj_rx->xsk->batch_size = max_descs - 1;
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2585,6 +2605,7 @@ static const struct test_spec tests[] = {
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
+	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 };
 
 static void print_tests(void)
-- 
2.34.1


