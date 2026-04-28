Return-Path: <netdev+bounces-281728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOYDFE118GkfTwEAu9opvQ
	(envelope-from <netdev+bounces-281728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:52:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A64809F3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 507DB3022C85
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D73D5663;
	Tue, 28 Apr 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+xSBhME"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590E3A7F47;
	Tue, 28 Apr 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365970; cv=none; b=pxkiy8NS6cMIVo8x0OWWZli3+o3EYti6bibzz01F+hQVklS8oidaT9gzbAC599QNaAWxYQkgWruF2hFO3z2CMXRqe7+KxzBCRDDbOGIxG6YgLudstFGBDHXyqFEwc6X4HeYkvP10BNoNN9yOPZErpciuByc7pN06fa0ewF0A8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365970; c=relaxed/simple;
	bh=V/YqYsOv8ohk19JaaseOHKuEW4qY3B14Yp+Ir4XEsZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2MYhLXbT91OWocVyqJwkNIbxiG0E4fbQknZ/lIBdWwpTm//ujO3LBIg3lcChRXuQORkVJ7EC09tb5Lp0GSohPneRABiP5GBKHQWsRfIDFnzyg3Qywy+BEG2Kt5+UBp2+t5tKnwesgWtaMuB9eEY47D1ojCBHZCzgos7jQDSDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+xSBhME; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365969; x=1808901969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/YqYsOv8ohk19JaaseOHKuEW4qY3B14Yp+Ir4XEsZw=;
  b=e+xSBhME+lBPURsyVNpL7pd8AMYU69qh2XWxBvQ7dFFoW2qjRatjvAQc
   8ALCLvfH226SgmaoS3V4KUpoloXWmQns7uhkcI8oydobZ1pFYscWZjvkx
   YhyLyuqZte19Uv8PwvWS6flQXGa9ozHLOkp3DxTu2hWc0qCBdOab28KU/
   KBg0ZXZhAWIfG3Kh6/a9Zj2GNvCjmIEZHSIIW6PyR/M7fNCrl1WB+VNm8
   Ap0f0hj05X/jZ4ZWwpEAbmg6idsOEGRaWtgIt7qy6nw8xaINboo0Zmsrj
   RelHZJRlqZnLV+nNOWH1IUn+nibKl6e6PIrinod0tJkohQ05xcPkbe39a
   g==;
X-CSE-ConnectionGUID: bh6kIdKpSdec8owrKudZKA==
X-CSE-MsgGUID: 4zme510IQ1WV43fITjoGAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77433249"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77433249"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:08 -0700
X-CSE-ConnectionGUID: B4R1bVIsRFCrow/GsVqtaw==
X-CSE-MsgGUID: yk7ZGIAZR46NXCpI8LIwLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233027298"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:04 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH 1/5] selftests/xsk: Introduce helpers for setting UMEM properties
Date: Tue, 28 Apr 2026 13:33:12 +0530
Message-ID: <20260428080317.702124-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080317.702124-1-tushar.vyavahare@intel.com>
References: <20260428080317.702124-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 160A64809F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

UMEM properties are set via open-coded field assignments in multiple test
paths, which makes updates noisy and error-prone.

Introduce three helpers to set UMEM properties through a single interface.
This keeps setup logic consistent across tests and makes future refactoring
simpler.

No functional behavior change is intended.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7950c504ed28..d5cd8f590b25 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -303,6 +303,22 @@ static void test_spec_reset(struct test_spec *test)
 	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
 }
 
+static void test_spec_set_unaligned(struct test_spec *test)
+{
+	test_spec_set_unaligned(test);
+}
+
+static void test_spec_set_frame_size(struct test_spec *test, u32 size)
+{
+	test->ifobj_tx->umem->frame_size = size;
+	test->ifobj_rx->umem->frame_size = size;
+}
+
+static void test_spec_set_frame_headroom(struct test_spec *test, u32 size)
+{
+	test->ifobj_rx->umem->frame_headroom = size;
+}
+
 static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
 				   struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
 				   struct bpf_map *xskmap_tx)
@@ -1953,7 +1969,7 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 
 int testapp_headroom(struct test_spec *test)
 {
-	test->ifobj_rx->umem->frame_headroom = UMEM_HEADROOM_TEST_SIZE;
+	test_spec_set_frame_headroom(test, UMEM_HEADROOM_TEST_SIZE);
 	return testapp_validate_traffic(test);
 }
 
@@ -1968,8 +1984,8 @@ int testapp_stats_rx_dropped(struct test_spec *test)
 
 	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 3) + umem_tr, 0))
 		return TEST_FAILURE;
-	test->ifobj_rx->umem->frame_headroom = test->ifobj_rx->umem->frame_size -
-		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr;
+	test_spec_set_frame_headroom(test, test->ifobj_rx->umem->frame_size -
+			      XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr);
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
@@ -2025,8 +2041,7 @@ int testapp_stats_fill_empty(struct test_spec *test)
 
 int testapp_send_receive_unaligned(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	/* Let half of the packets straddle a 4K buffer boundary */
 	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
 		return TEST_FAILURE;
@@ -2037,8 +2052,7 @@ int testapp_send_receive_unaligned(struct test_spec *test)
 int testapp_send_receive_unaligned_mb(struct test_spec *test)
 {
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
@@ -2204,7 +2218,7 @@ int testapp_poll_txq_tmout(struct test_spec *test)
 {
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
-	test->ifobj_tx->umem->frame_size = 2048;
+	test_spec_set_frame_size(test, 2048);
 	if (pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048))
 		return TEST_FAILURE;
 	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
@@ -2337,8 +2351,7 @@ int testapp_send_receive(struct test_spec *test)
 
 int testapp_send_receive_2k_frame(struct test_spec *test)
 {
-	test->ifobj_tx->umem->frame_size = 2048;
-	test->ifobj_rx->umem->frame_size = 2048;
+	test_spec_set_frame_size(test, 2048);
 	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE))
 		return TEST_FAILURE;
 	return testapp_validate_traffic(test);
@@ -2363,15 +2376,13 @@ int testapp_aligned_inv_desc(struct test_spec *test)
 
 int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
 {
-	test->ifobj_tx->umem->frame_size = 2048;
-	test->ifobj_rx->umem->frame_size = 2048;
+	test_spec_set_frame_size(test, 2048);
 	return testapp_invalid_desc(test);
 }
 
 int testapp_unaligned_inv_desc(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	return testapp_invalid_desc(test);
 }
 
@@ -2380,10 +2391,8 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
 	u64 page_size, umem_size;
 
 	/* Odd frame size so the UMEM doesn't end near a page boundary. */
-	test->ifobj_tx->umem->frame_size = 4001;
-	test->ifobj_rx->umem->frame_size = 4001;
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_frame_size(test, 4001);
+	test_spec_set_unaligned(test);
 	/* This test exists to test descriptors that staddle the end of
 	 * the UMEM but not a page.
 	 */
@@ -2402,8 +2411,7 @@ int testapp_aligned_inv_desc_mb(struct test_spec *test)
 
 int testapp_unaligned_inv_desc_mb(struct test_spec *test)
 {
-	test->ifobj_tx->umem->unaligned_mode = true;
-	test->ifobj_rx->umem->unaligned_mode = true;
+	test_spec_set_unaligned(test);
 	return testapp_invalid_desc_mb(test);
 }
 
-- 
2.43.0


