Return-Path: <netdev+bounces-265049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BfRKXudq2lsewEAu9opvQ
	(envelope-from <netdev+bounces-265049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EA229F5D
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13415306EC94
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30103101C2;
	Sat,  7 Mar 2026 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4lskImh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA33101A9
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854604; cv=none; b=sBAlcqv8uKJnOM0NWKCc22HTeh5dOIVyAddaIa8cOPkEHsYG3/k4tBYd0vqjXN1lN5iafwmuDiALeYd5gZKURlMAgMZnSR28cwA1naljaZX+X84KpiUudbKK9h7Gs7n2V2BEPRxfgTYoNxYDitMs63iXD3UxBQY8W1tUwYNVqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854604; c=relaxed/simple;
	bh=0vAlEkgKi5wbGj8pBmPBNklDyUqIF74bkJ6aB7Udl2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpsSCIPUEcgste/RT/1zF7ADn0iQRxsmNzpWVS2GFdByggmMPVWVjBB/qFw3g4w/Q4gfEEis93gzd0SfGAmc5EnJnX/PQKDxxSZocNdWLpRH75JTL96gYia4Q4PXzozbsqPPrN2l3UeEkarURyLhDDo44kWtZNf+++Hvd21G2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4lskImh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33CDC2BCAF;
	Sat,  7 Mar 2026 03:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772854604;
	bh=0vAlEkgKi5wbGj8pBmPBNklDyUqIF74bkJ6aB7Udl2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4lskImhLZroigHmJLewvGwWfeMAsCrx5kTanPI0UsWlhUq+fwcWIleCIuK+PVlwT
	 qYW2ZbMZf9togFYrYEoqH3IJZXNwMKDtnEfvhoaU9S+P0GpVP8NmXJ8SEAF+0Dk23P
	 rEzpO3lK9OgP/4ocVt/DPVpRl6Kb3NTLGVvg8ZMdD7E/Y4jIeSMKA4nkqutP1NlJTT
	 we7WVfAPrUfbnluA9TvMnZKqYQtu0nLz22aZa0SrxhuvfprrX7oASaqAW46KdmS6X0
	 f88XZYEzcrjmautU8sZ54YZiQEtaQZIwvQaeXSHNFcN8QNVxZw/WbFRk7SZOOxvvBk
	 n5GSFJWx7xqag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 02/10] tools: ynl: convert netdev sample to selftest
Date: Fri,  6 Mar 2026 19:36:22 -0800
Message-ID: <20260307033630.1396085-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307033630.1396085-1-kuba@kernel.org>
References: <20260307033630.1396085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 226EA229F5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265049-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert netdev.c to produce KTAP output with 3 tests:
- dev_dump: dump all netdev devices, skip if empty
- dev_get: query first device from dump by ifindex
- ntf_check: subscribe to "mgmt", create a veth via rt-link,
  verify netdev notification is received, then delete the veth

Remove stdin/scanf-based UI. Add rt-link dependency for the veth
notification test.

  TAP version 13
  1..3
  # Starting 3 tests from 1 test cases.
  #  RUN           netdev.dump ...
  #       lo[1]	xdp-features (0): xdp-rx-metadata-features (0): xsk-fea...
  #     sit0[2]	xdp-features (0): xdp-rx-metadata-features (0): xsk-fea...
  #            OK  netdev.dump
  ok 1 netdev.dump
  #  RUN           netdev.get ...
  #       lo[1]	xdp-features (0): xdp-rx-metadata-features (0): xsk-fea...
  #            OK  netdev.get
  ok 2 netdev.get
  #  RUN           netdev.ntf_check ...
  #    veth0[7]	xdp-features (0): xdp-rx-metadata-features (7): timesta...
  #            OK  netdev.ntf_check
  ok 3 netdev.ntf_check
  # PASSED: 3 / 3 tests passed.
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile |  29 +++--
 tools/net/ynl/tests/netdev.c | 229 +++++++++++++++++++++++++----------
 2 files changed, 187 insertions(+), 71 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 5fa36c877235..1d77d3662f46 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -18,16 +18,29 @@ TEST_PROGS := \
 	test_ynl_ethtool.sh \
 # end of TEST_PROGS
 
-SRCS=$(wildcard *.c)
-BINS=$(patsubst %.c,%,${SRCS})
+TEST_GEN_PROGS := \
+	netdev \
+# end of TEST_GEN_PROGS
 
+BINS := \
+	devlink \
+	ethtool \
+	ovs \
+	rt-addr \
+	rt-link \
+	rt-route \
+	tc \
+	tc-filter-add \
+# end of BINS
+
+CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
 CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 
 include $(wildcard *.d)
 
 INSTALL_PATH ?= $(DESTDIR)/usr/share/kselftest
 
-all: $(BINS) $(TEST_PROGS)
+all: $(TEST_GEN_PROGS) $(BINS)
 
 ../lib/ynl.a:
 	@$(MAKE) -C ../lib
@@ -35,7 +48,7 @@ all: $(BINS) $(TEST_PROGS)
  ../generated/protos.a:
 	@$(MAKE) -C ../generated
 
-$(BINS): ../lib/ynl.a ../generated/protos.a
+$(TEST_GEN_PROGS) $(BINS): %: %.c ../lib/ynl.a ../generated/protos.a
 	@echo -e '\tCC test $@'
 	@$(COMPILE.c) $(CFLAGS_$@) $@.c -o $@.o
 	@$(LINK.c) $@.o -o $@  $(LDLIBS)
@@ -45,7 +58,7 @@ $(BINS): ../lib/ynl.a ../generated/protos.a
 		./$$test; \
 	done
 
-install: $(TEST_PROGS) $(BINS)
+install: $(TEST_GEN_PROGS) $(BINS)
 	@mkdir -p $(INSTALL_PATH)/ynl
 	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(INSTALL_PATH)/
 	@for test in $(TEST_PROGS); do \
@@ -56,10 +69,10 @@ install: $(TEST_PROGS) $(BINS)
 		    $$test > $(INSTALL_PATH)/ynl/$$name; \
 		chmod +x $(INSTALL_PATH)/ynl/$$name; \
 	done
-	@for bin in $(BINS); do \
+	@for bin in $(TEST_GEN_PROGS) $(BINS); do \
 		cp $$bin $(INSTALL_PATH)/ynl/$$bin; \
 	done
-	@for test in $(TEST_PROGS); do \
+	@for test in $(TEST_PROGS) $(TEST_GEN_PROGS); do \
 		echo "ynl:$$test"; \
 	done > $(INSTALL_PATH)/kselftest-list.txt
 
@@ -67,7 +80,7 @@ install: $(TEST_PROGS) $(BINS)
 	rm -f *.o *.d *~
 
 distclean: clean
-	rm -f $(BINS)
+	rm -f $(TEST_GEN_PROGS) $(BINS)
 
 .PHONY: all install clean distclean run_tests
 .DEFAULT_GOAL=all
diff --git a/tools/net/ynl/tests/netdev.c b/tools/net/ynl/tests/netdev.c
index 22609d44c89a..f849e3d7f4b3 100644
--- a/tools/net/ynl/tests/netdev.c
+++ b/tools/net/ynl/tests/netdev.c
@@ -6,29 +6,29 @@
 
 #include <net/if.h>
 
+#include <kselftest_harness.h>
+
 #include "netdev-user.h"
+#include "rt-link-user.h"
 
-/* netdev genetlink family code sample
- * This sample shows off basics of the netdev family but also notification
- * handling, hence the somewhat odd UI. We subscribe to notifications first
- * then wait for ifc selection, so the socket may already accumulate
- * notifications as we wait. This allows us to test that YNL can handle
- * requests and notifications getting interleaved.
- */
-
-static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
+static void netdev_print_device(struct __test_metadata *_metadata,
+				struct netdev_dev_get_rsp *d, unsigned int op)
 {
 	char ifname[IF_NAMESIZE];
 	const char *name;
 
+	EXPECT_TRUE((bool)d->_present.ifindex);
 	if (!d->_present.ifindex)
 		return;
 
 	name = if_indextoname(d->ifindex, ifname);
+	EXPECT_TRUE((bool)name);
 	if (name)
-		printf("%8s", name);
-	printf("[%d]\t", d->ifindex);
+		ksft_print_msg("%8s[%d]\t", name, d->ifindex);
+	else
+		ksft_print_msg("[%d]\t", d->ifindex);
 
+	EXPECT_TRUE((bool)d->_present.xdp_features);
 	if (!d->_present.xdp_features)
 		return;
 
@@ -38,10 +38,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
-	printf(" xdp-rx-metadata-features (%llx):", d->xdp_rx_metadata_features);
+	printf(" xdp-rx-metadata-features (%llx):",
+	       d->xdp_rx_metadata_features);
 	for (int i = 0; d->xdp_rx_metadata_features >= 1U << i; i++) {
 		if (d->xdp_rx_metadata_features & (1U << i))
-			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
+			printf(" %s",
+			       netdev_xdp_rx_metadata_str(1 << i));
 	}
 
 	printf(" xsk-features (%llx):", d->xsk_features);
@@ -58,71 +60,172 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 	printf("\n");
 }
 
-int main(int argc, char **argv)
+static int veth_create(struct ynl_sock *ys_link)
+{
+	struct rt_link_getlink_ntf *ntf_gl;
+	struct rt_link_newlink_req *req;
+	struct ynl_ntf_base_type *ntf;
+	int ret;
+
+	req = rt_link_newlink_req_alloc();
+	if (!req)
+		return -1;
+
+	rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE | NLM_F_ECHO);
+	rt_link_newlink_req_set_linkinfo_kind(req, "veth");
+
+	ret = rt_link_newlink(ys_link, req);
+	rt_link_newlink_req_free(req);
+	if (ret)
+		return -1;
+
+	if (!ynl_has_ntf(ys_link))
+		return 0;
+
+	ntf = ynl_ntf_dequeue(ys_link);
+	if (!ntf || ntf->cmd != RTM_NEWLINK) {
+		ynl_ntf_free(ntf);
+		return 0;
+	}
+	ntf_gl = (void *)ntf;
+	ret = ntf_gl->obj._hdr.ifi_index;
+	ynl_ntf_free(ntf);
+
+	return ret;
+}
+
+static void veth_delete(struct __test_metadata *_metadata,
+			struct ynl_sock *ys_link, int ifindex)
+{
+	struct rt_link_dellink_req *req;
+
+	req = rt_link_dellink_req_alloc();
+	ASSERT_NE(NULL, req);
+
+	req->_hdr.ifi_index = ifindex;
+	EXPECT_EQ(0, rt_link_dellink(ys_link, req));
+	rt_link_dellink_req_free(req);
+}
+
+FIXTURE(netdev)
+{
+	struct ynl_sock *ys;
+	struct ynl_sock *ys_link;
+};
+
+FIXTURE_SETUP(netdev)
+{
+	struct ynl_error yerr;
+
+	self->ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	ASSERT_NE(NULL, self->ys) {
+		TH_LOG("Failed to create YNL netdev socket: %s", yerr.msg);
+	}
+}
+
+FIXTURE_TEARDOWN(netdev)
+{
+	if (self->ys_link)
+		ynl_sock_destroy(self->ys_link);
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(netdev, dump)
 {
 	struct netdev_dev_get_list *devs;
-	struct ynl_ntf_base_type *ntf;
-	struct ynl_error yerr;
-	struct ynl_sock *ys;
+
+	devs = netdev_dev_get_dump(self->ys);
+	ASSERT_NE(NULL, devs) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
+
+	if (ynl_dump_empty(devs)) {
+		netdev_dev_get_list_free(devs);
+		SKIP(return, "no entries in dump");
+	}
+
+	ynl_dump_foreach(devs, d)
+		netdev_print_device(_metadata, d, 0);
+
+	netdev_dev_get_list_free(devs);
+}
+
+TEST_F(netdev, get)
+{
+	struct netdev_dev_get_list *devs;
+	struct netdev_dev_get_req *req;
+	struct netdev_dev_get_rsp *dev;
 	int ifindex = 0;
 
-	if (argc > 1)
-		ifindex = strtol(argv[1], NULL, 0);
-
-	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
-	if (!ys) {
-		fprintf(stderr, "YNL: %s\n", yerr.msg);
-		return 1;
+	devs = netdev_dev_get_dump(self->ys);
+	ASSERT_NE(NULL, devs) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
 	}
 
-	if (ynl_subscribe(ys, "mgmt"))
-		goto err_close;
+	ynl_dump_foreach(devs, d) {
+		if (d->_present.ifindex) {
+			ifindex = d->ifindex;
+			break;
+		}
+	}
+	netdev_dev_get_list_free(devs);
 
-	printf("Select ifc ($ifindex; or 0 = dump; or -2 ntf check): ");
-	if (scanf("%d", &ifindex) != 1) {
-		fprintf(stderr, "Error: unable to parse input\n");
-		goto err_destroy;
+	if (!ifindex)
+		SKIP(return, "no device to query");
+
+	req = netdev_dev_get_req_alloc();
+	ASSERT_NE(NULL, req);
+	netdev_dev_get_req_set_ifindex(req, ifindex);
+
+	dev = netdev_dev_get(self->ys, req);
+	netdev_dev_get_req_free(req);
+	ASSERT_NE(NULL, dev) {
+		TH_LOG("dev_get failed: %s", self->ys->err.msg);
 	}
 
-	if (ifindex > 0) {
-		struct netdev_dev_get_req *req;
-		struct netdev_dev_get_rsp *d;
+	netdev_print_device(_metadata, dev, 0);
+	netdev_dev_get_rsp_free(dev);
+}
 
-		req = netdev_dev_get_req_alloc();
-		netdev_dev_get_req_set_ifindex(req, ifindex);
+TEST_F(netdev, ntf_check)
+{
+	struct ynl_ntf_base_type *ntf;
+	int veth_ifindex;
+	bool received;
+	int ret;
 
-		d = netdev_dev_get(ys, req);
-		netdev_dev_get_req_free(req);
-		if (!d)
-			goto err_close;
-
-		netdev_print_device(d, 0);
-		netdev_dev_get_rsp_free(d);
-	} else if (!ifindex) {
-		devs = netdev_dev_get_dump(ys);
-		if (!devs)
-			goto err_close;
-
-		if (ynl_dump_empty(devs))
-			fprintf(stderr, "Error: no devices reported\n");
-		ynl_dump_foreach(devs, d)
-			netdev_print_device(d, 0);
-		netdev_dev_get_list_free(devs);
-	} else if (ifindex == -2) {
-		ynl_ntf_check(ys);
+	ret = ynl_subscribe(self->ys, "mgmt");
+	ASSERT_EQ(0, ret) {
+		TH_LOG("subscribe failed: %s", self->ys->err.msg);
 	}
-	while ((ntf = ynl_ntf_dequeue(ys))) {
-		netdev_print_device((struct netdev_dev_get_rsp *)&ntf->data,
+
+	self->ys_link = ynl_sock_create(&ynl_rt_link_family, NULL);
+	ASSERT_NE(NULL, self->ys_link)
+		TH_LOG("failed to create rt-link socket");
+
+	veth_ifindex = veth_create(self->ys_link);
+	ASSERT_GT(veth_ifindex, 0)
+		TH_LOG("failed to create veth");
+
+	ynl_ntf_check(self->ys);
+
+	ntf = ynl_ntf_dequeue(self->ys);
+	received = ntf;
+	if (ntf) {
+		netdev_print_device(_metadata,
+				    (struct netdev_dev_get_rsp *)&ntf->data,
 				    ntf->cmd);
 		ynl_ntf_free(ntf);
 	}
 
-	ynl_sock_destroy(ys);
-	return 0;
+	/* Drain any remaining notifications */
+	while ((ntf = ynl_ntf_dequeue(self->ys)))
+		ynl_ntf_free(ntf);
 
-err_close:
-	fprintf(stderr, "YNL: %s\n", ys->err.msg);
-err_destroy:
-	ynl_sock_destroy(ys);
-	return 2;
+	veth_delete(_metadata, self->ys_link, veth_ifindex);
+
+	ASSERT_TRUE(received)
+		TH_LOG("no notification received");
 }
+
+TEST_HARNESS_MAIN
-- 
2.53.0


