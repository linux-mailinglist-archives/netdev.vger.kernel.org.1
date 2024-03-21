Return-Path: <netdev+bounces-81072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7A885A51
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44C9283441
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BEE84FC4;
	Thu, 21 Mar 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbFOiizD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330684A28;
	Thu, 21 Mar 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029949; cv=none; b=E+zfjOlYUYtJhTTyrSIhloigOkEezA16GikeLx0Kpy8kEvWqlM2qBX9wnL7TMpcZmMvse8AK6EcG/qiQVfl3aOgJSO46090N+BHSMWMvxisAHE6p0At/KLMbXzAuLCkBImsTLdVhFhYMXjaYlpt1NxCXNxzDstozcijm0HkWKK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029949; c=relaxed/simple;
	bh=3uNXAkTK6wlGV4bLJ+siP19LdInTvZftHrQul3EII+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3L4drMC0KttBQIzSNl62QbaMGi/OC36YEwPtPsUYRQnLABnzBN8oGAV+TqZdZkLyKFbSihEjt1bGFj4XY3UvhlY3T5GpeLz4mI5asjC5ZjgfpRD2o0HGDk8mo45Of216e3ZN29cKRZw29DUN0IFy1/E1pxlYGzUpZ8mvCBN3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbFOiizD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029948; x=1742565948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uNXAkTK6wlGV4bLJ+siP19LdInTvZftHrQul3EII+Y=;
  b=kbFOiizDlJzU2A0atkhg/atKxRO1bwhZVZsiTMx5MCamJS6UFrzO2BpX
   zBA0Z+YXmdWBoYt7PyvfwT4z2bNlwnvegFBOd3lE/f2mwCsPQMB280OxU
   /OPiFLgNC2XOt0OmSAw2kele+4Z7pxdkLXq7w6FPng3VROz5qU1GxHqPx
   w3MHAVzxBuPnrAZgJcdYV121UQ2xtSd9HAap0byqGhyYWyzSn8jh22tIg
   UTmCaeJL7rezHyac6KkVzFWud3UmU9v9MRAffzeQNV4C5PRZpjQPPwZUI
   Wq9XT0oUZc4dMi/jLI5eiy01BVUP7iRzZ8z86Xelon+3JpvZs+5LYHtQc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5911051"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5911051"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911404"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:43 -0700
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
Subject: [PATCH bpf-next v2 7/7] selftests/xsk: add new test case for AF_XDP under max ring sizes
Date: Thu, 21 Mar 2024 13:49:11 +0000
Message-Id: <20240321134911.120091-8-tushar.vyavahare@intel.com>
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

Introduce a test case to evaluate AF_XDP's robustness by pushing hardware
and software ring sizes to their limits. This test ensures AF_XDP's
reliability amidst potential producer/consumer throttling due to maximum
ring utilization. The testing strategy includes:

1. Configuring rings to their maximum allowable sizes.
2. Executing a series of tests across diverse batch sizes to assess
   system's behavior under different configurations.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index dac2dcf39bb8..2eac0895b0a1 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2439,6 +2439,30 @@ static int testapp_hw_sw_min_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_hw_sw_max_ring_size(struct test_spec *test)
+{
+	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
+	int ret;
+
+	test->set_ring = true;
+	test->total_steps = 2;
+	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
+	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
+	test->ifobj_rx->umem->num_frames = max_descs;
+	test->ifobj_rx->xsk->rxqsize = max_descs;
+	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	/* Set batch_size to 4095 */
+	test->ifobj_tx->xsk->batch_size = max_descs - 1;
+	test->ifobj_rx->xsk->batch_size = max_descs - 1;
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2544,6 +2568,7 @@ static const struct test_spec tests[] = {
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
+	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	};
 
 static void print_tests(void)
-- 
2.34.1


