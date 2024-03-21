Return-Path: <netdev+bounces-81070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC1885A4D
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273871F226E0
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79E84FD0;
	Thu, 21 Mar 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcpGSmtE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7484FCF;
	Thu, 21 Mar 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029940; cv=none; b=CZSmLbCO3kYpA7vPTkS/8id4rduS76DPcTC/inRCheTQ9MgzybNqh/kky2/ttnag/h1LGck3LPzG5zX9JEEzJiGcl+VKefCgSbDH2BWNlDidzuZSTiFDEF1fdr+fhBhnuQZD/EhNvYJVqvYUwFgv6Rrlq1S/lAi9w7xP5CrY6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029940; c=relaxed/simple;
	bh=+g/DIk4m50i+TJ1gbAgNCfjLmKC8e6IG2kk/eaBMAbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TimB5VR6iUg9em4nN4o4gk9TjH3cFpZHaLxaw1TymGoIto9MlB9Ys/XkNzno7kEdoj5ZewLzcXE4x5wIPuEnbRpC49X9rfhsJiS3nU/z9KOzLgeun+xv9O3/8GQ+SryBfkaxkbJdzIEptaSuGQl11/bLhZsXnVUhSTz8Gfjgxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcpGSmtE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029939; x=1742565939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+g/DIk4m50i+TJ1gbAgNCfjLmKC8e6IG2kk/eaBMAbM=;
  b=hcpGSmtEEdgtV6Pcn1NDWrLWlCY4TtNDRrymvyURG2D31aQzCazon4TI
   Srz1mwBxJbEL5EycBJxLXKLsQl2cIsgHiNxR2Ve1VQZ9SkXQ7z8Y6YDC7
   u6ZKb5Rj/DPEwJuqaS9g9+lpiR8l7Zz4ccljhJ/84yRpT0SscDSSSMV6g
   LC7rpDls9AG+ya6kkORONn9HjkcjlHAv1jMhmBxrUlQd62guTx3igj7Xi
   RQYgNGEAwmMWInAW4zvR+BdmJ7nG4yAPz9Ko7edx/N32HcCG0HqyV/cJE
   j4oEAxZ6TYNlnBvK4G3ss/FTW35JRhODuaqjppJ5cSQduD5yJL5lOIR6T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5911014"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5911014"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14911372"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:05:34 -0700
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
Subject: [PATCH bpf-next v2 5/7] selftests/xsk: introduce set_ring_size function with a retry mechanism for handling AF_XDP socket closures
Date: Thu, 21 Mar 2024 13:49:09 +0000
Message-Id: <20240321134911.120091-6-tushar.vyavahare@intel.com>
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

Introduce a new function, set_ring_size(), to manage asynchronous AF_XDP
socket closure. Retry set_hw_ring_size up to SOCK_RECONF_CTR times if it
fails due to an active AF_XDP socket. Return an error immediately for
non-EBUSY errors. This enhances robustness against asynchronous AF_XDP
socket closures during ring size changes.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/Makefile     |  2 +-
 tools/testing/selftests/bpf/xskxceiver.c | 57 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  9 ++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b9eb40d6343..6fe26277e8ce 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -695,7 +695,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 
 # Include find_bit.c to compile xskxceiver.
 EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c
-$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index eaa102c8098b..8c26868e17cf 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -81,6 +81,7 @@
 #include <linux/mman.h>
 #include <linux/netdev.h>
 #include <linux/bitmap.h>
+#include <linux/ethtool.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <locale.h>
@@ -105,11 +106,15 @@
 #include "../kselftest.h"
 #include "xsk_xdp_common.h"
 
+#include <network_helpers.h>
+
 static bool opt_verbose;
 static bool opt_print_tests;
 static enum test_mode opt_mode = TEST_MODE_ALL;
 static u32 opt_run_test = RUN_ALL_TESTS;
 
+void test__fail(void) { /* for network_helpers.c */ }
+
 static void __exit_with_error(int error, const char *file, const char *func, int line)
 {
 	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
@@ -409,6 +414,33 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	}
 }
 
+static int set_ring_size(struct ifobject *ifobj)
+{
+	int ret;
+	u32 ctr = 0;
+
+	while (ctr++ < SOCK_RECONF_CTR) {
+		ret = set_hw_ring_size(ifobj->ifname, &ifobj->ring);
+		if (!ret)
+			break;
+
+		/* Retry if it fails */
+		if (ctr >= SOCK_RECONF_CTR || errno != EBUSY)
+			return -errno;
+
+		usleep(USLEEP_MAX);
+	}
+
+	return ret;
+}
+
+static int hw_ring_size_reset(struct ifobject *ifobj)
+{
+	ifobj->ring.tx_pending = ifobj->set_ring.default_tx;
+	ifobj->ring.rx_pending = ifobj->set_ring.default_rx;
+	return set_ring_size(ifobj);
+}
+
 static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			     struct ifobject *ifobj_rx)
 {
@@ -452,12 +484,16 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 		}
 	}
 
+	if (ifobj_tx->hw_ring_size_supp)
+		hw_ring_size_reset(ifobj_tx);
+
 	test->ifobj_tx = ifobj_tx;
 	test->ifobj_rx = ifobj_rx;
 	test->current_step = 0;
 	test->total_steps = 1;
 	test->nb_sockets = 1;
 	test->fail = false;
+	test->set_ring = false;
 	test->mtu = MAX_ETH_PKT_SIZE;
 	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
 	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
@@ -1862,6 +1898,14 @@ static int testapp_validate_traffic(struct test_spec *test)
 		return TEST_SKIP;
 	}
 
+	if (test->set_ring) {
+		if (ifobj_tx->hw_ring_size_supp)
+			return set_ring_size(ifobj_tx);
+
+	ksft_test_result_skip("Changing HW ring size not supported.\n");
+	return TEST_SKIP;
+	}
+
 	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
@@ -2479,7 +2523,7 @@ static const struct test_spec tests[] = {
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
-};
+	};
 
 static void print_tests(void)
 {
@@ -2499,6 +2543,7 @@ int main(int argc, char **argv)
 	int modes = TEST_MODE_SKB + 1;
 	struct test_spec test;
 	bool shared_netdev;
+	int ret;
 
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -2536,6 +2581,13 @@ int main(int argc, char **argv)
 			modes++;
 	}
 
+	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
+	if (!ret) {
+		ifobj_tx->hw_ring_size_supp = true;
+		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
+		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
+	}
+
 	init_iface(ifobj_rx, worker_testapp_validate_rx);
 	init_iface(ifobj_tx, worker_testapp_validate_tx);
 
@@ -2583,6 +2635,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (ifobj_tx->hw_ring_size_supp)
+		hw_ring_size_reset(ifobj_tx);
+
 	pkt_stream_delete(tx_pkt_stream_default);
 	pkt_stream_delete(rx_pkt_stream_default);
 	xsk_unload_xdp_programs(ifobj_tx);
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 425304e52f35..906de5fab7a3 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -114,6 +114,11 @@ struct pkt_stream {
 	bool verbatim;
 };
 
+struct set_hw_ring {
+	u32 default_tx;
+	u32 default_rx;
+};
+
 struct ifobject;
 struct test_spec;
 typedef int (*validation_func_t)(struct ifobject *ifobj);
@@ -130,6 +135,8 @@ struct ifobject {
 	struct xsk_xdp_progs *xdp_progs;
 	struct bpf_map *xskmap;
 	struct bpf_program *xdp_prog;
+	struct ethtool_ringparam ring;
+	struct set_hw_ring set_ring;
 	enum test_mode mode;
 	int ifindex;
 	int mtu;
@@ -146,6 +153,7 @@ struct ifobject {
 	bool unaligned_supp;
 	bool multi_buff_supp;
 	bool multi_buff_zc_supp;
+	bool hw_ring_size_supp;
 };
 
 struct test_spec {
@@ -163,6 +171,7 @@ struct test_spec {
 	u16 current_step;
 	u16 nb_sockets;
 	bool fail;
+	bool set_ring;
 	enum test_mode mode;
 	char name[MAX_TEST_NAME_SIZE];
 };
-- 
2.34.1


