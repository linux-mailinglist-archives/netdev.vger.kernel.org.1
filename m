Return-Path: <netdev+bounces-274613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFwbG/mRzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C526638B8D5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA1C30E400B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C283EE1E3;
	Thu,  2 Apr 2026 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOPWCJFG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35983537E4;
	Thu,  2 Apr 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145045; cv=none; b=eWOQIMagrXqKxEqL79sdPThFbiZyoBsHKm8+si8d9MipOKImjI5ul726vXNBd/r6+oHSSLywlXk1QbDpzNHIUInBEs9E3PRSAcMN0PKgIn3vuD12ph+Rhbt9dFjsDxjyoyL1/gHutOyZhfbBJm1vARZWcytVUe+LcJ8sCz2sHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145045; c=relaxed/simple;
	bh=g0KXPH+hKuSK6OJM4UpWLFSGewvYqKddkq1Z5X12Xsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msRyxBeUUxqwQ9lG6X1e+nViF9oxZp44wsXtqX7rf/Oc3atRmskcv4OED0vdCIIn5las1SznhK0KadiUo38dswMdT1uN0IevtNzsyyqYhEyn3LHG+NZ9Sg9oax+96iqZl9h03NIodqIfVcCWeNYQUmrxjnWERmJc92sdjaesrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOPWCJFG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145044; x=1806681044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g0KXPH+hKuSK6OJM4UpWLFSGewvYqKddkq1Z5X12Xsg=;
  b=eOPWCJFGIqFHEv6Qb0n9fQxK5dPUYgfbvCeUIBIH3vv662FYFoioRij+
   gaHVdYUfzUYMLAhYD4Qf6M7100UJOJG+3Hc7GIvie0Qz/sJ+x065ULCKv
   0H/5nYObupyPUQLn4g5CUvsuILtXheVeO2WJQAfwpOmUMjl27U1JzV0zm
   hkvbSG/9Bnl0aNtUpoNeTalQkvop0eMzOkO5+8WkmR1FuQZK1SSkyNs9u
   cvXUGOv8PAdU9iDQn+HEewTPKtqYmtBvCDsxyZUdpMtWHOXw7HF8747we
   G/4Xd/V0ty5bOTAUCPm4wqt4KglpBkMdQ1XQBBecM4O73N6xUWkRPohIx
   Q==;
X-CSE-ConnectionGUID: JmQm8j+HTe6LHRh4MduONg==
X-CSE-MsgGUID: /c9hzMlxReu9afJOx7/K7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75927987"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75927987"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:44 -0700
X-CSE-ConnectionGUID: Jza4gsFnQWaTEMR1y7B2BA==
X-CSE-MsgGUID: PbBc/9jDRNu+2VdwmJ/LgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157697"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:41 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v6 net 5/8] selftests: bpf: introduce a common routine for reading procfs
Date: Thu,  2 Apr 2026 17:49:55 +0200
Message-Id: <20260402154958.562179-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274613-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C526638B8D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Parametrize current way of getting MAX_SKB_FRAGS value from {sys,proc}fs
so that it can be re-used to get cache line size of system's CPU. All
that just to mimic and compute size of kernel's struct skb_shared_info
which for xsk and test suite interpret as tailroom.

Introduce two variables to ifobject struct that will carry count of skb
frags and tailroom size. Do the reading and computing once, at the
beginning of test suite execution in xskxceiver, but for test_progs such
way is not possible as in this environment each test setups and torns
down ifobject structs.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 25 +------------------
 .../selftests/bpf/prog_tests/test_xsk.h       | 23 +++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 19 ++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.c      | 23 +++++++++++++++++
 4 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7e38ec6e656b..62118ffba661 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -179,25 +179,6 @@ int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem
 	return xsk_socket__create(&xsk->xsk, ifobject->ifindex, 0, umem->umem, rxr, txr, &cfg);
 }
 
-#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
-static unsigned int get_max_skb_frags(void)
-{
-	unsigned int max_skb_frags = 0;
-	FILE *file;
-
-	file = fopen(MAX_SKB_FRAGS_PATH, "r");
-	if (!file) {
-		ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
-		return 0;
-	}
-
-	if (fscanf(file, "%u", &max_skb_frags) != 1)
-		ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
-
-	fclose(file);
-	return max_skb_frags;
-}
-
 static int set_ring_size(struct ifobject *ifobj)
 {
 	int ret;
@@ -2242,11 +2223,7 @@ int testapp_too_many_frags(struct test_spec *test)
 	if (test->mode == TEST_MODE_ZC) {
 		max_frags = test->ifobj_tx->xdp_zc_max_segs;
 	} else {
-		max_frags = get_max_skb_frags();
-		if (!max_frags) {
-			ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
-			max_frags = 17;
-		}
+		max_frags = test->ifobj_tx->max_skb_frags;
 		max_frags += 1;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 8fc78a057de0..1ab8aee4ce56 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -31,6 +31,9 @@
 #define SOCK_RECONF_CTR			10
 #define USLEEP_MAX			10000
 
+#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
+#define SMP_CACHE_BYTES_PATH "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
+
 extern bool opt_verbose;
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 
@@ -45,6 +48,24 @@ static inline u64 ceil_u64(u64 a, u64 b)
 	return (a + b - 1) / b;
 }
 
+static inline unsigned int read_procfs_val(const char *path)
+{
+	unsigned int read_val = 0;
+	FILE *file;
+
+	file = fopen(path, "r");
+	if (!file) {
+		ksft_print_msg("Error opening %s\n", path);
+		return 0;
+	}
+
+	if (fscanf(file, "%u", &read_val) != 1)
+		ksft_print_msg("Error reading %s\n", path);
+
+	fclose(file);
+	return read_val;
+}
+
 /* Simple test */
 enum test_mode {
 	TEST_MODE_SKB,
@@ -115,6 +136,8 @@ struct ifobject {
 	int mtu;
 	u32 bind_flags;
 	u32 xdp_zc_max_segs;
+	u32 umem_tailroom;
+	u32 max_skb_frags;
 	bool tx_on;
 	bool rx_on;
 	bool use_poll;
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
index dd4c35c0e428..6e2f63ee2a6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -62,6 +62,7 @@ int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
 
 static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 {
+	u32 max_frags, umem_tailroom, cache_line_size;
 	struct ifobject *ifobj_tx, *ifobj_rx;
 	struct test_spec test;
 	int ret;
@@ -84,6 +85,24 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
 	}
 
+	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
+	if (!cache_line_size)
+		cache_line_size = 64;
+
+	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
+	if (!max_frags)
+		max_frags = 17;
+
+	ifobj_tx->max_skb_frags = max_frags;
+	ifobj_rx->max_skb_frags = max_frags;
+
+	/* 48 bytes is a part of skb_shared_info w/o frags array;
+	 * 16 bytes is sizeof(skb_frag_t)
+	 */
+	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
+	ifobj_tx->umem_tailroom = umem_tailroom;
+	ifobj_rx->umem_tailroom = umem_tailroom;
+
 	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
 		goto delete_rx;
 	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 05b3cebc5ca9..7dad8556a722 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -80,6 +80,7 @@
 #include <linux/mman.h>
 #include <linux/netdev.h>
 #include <linux/ethtool.h>
+#include <linux/align.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -333,6 +334,7 @@ static void print_tests(void)
 int main(int argc, char **argv)
 {
 	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
+	u32 cache_line_size, max_frags, umem_tailroom;
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -354,6 +356,27 @@ int main(int argc, char **argv)
 
 	setlocale(LC_ALL, "");
 
+	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
+	if (!cache_line_size) {
+		ksft_print_msg("Can't get SMP_CACHE_BYTES from system, using default (64)\n");
+		cache_line_size = 64;
+	}
+
+	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
+	if (!max_frags) {
+		ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
+		max_frags = 17;
+	}
+	ifobj_tx->max_skb_frags = max_frags;
+	ifobj_rx->max_skb_frags = max_frags;
+
+	/* 48 bytes is a part of skb_shared_info w/o frags array;
+	 * 16 bytes is sizeof(skb_frag_t)
+	 */
+	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
+	ifobj_tx->umem_tailroom = umem_tailroom;
+	ifobj_rx->umem_tailroom = umem_tailroom;
+
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
 
 	if (opt_print_tests) {
-- 
2.43.0


