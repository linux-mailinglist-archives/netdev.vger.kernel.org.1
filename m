Return-Path: <netdev+bounces-261597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI+UDri3oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:14:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17C1AF8EC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2DAF30372E3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA300477E37;
	Thu, 26 Feb 2026 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fdtGLQgT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A3477986
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140405; cv=none; b=BlVe4RbcjQXhmw1u39xxkJ6Mg/UR3Cws2mdxoKQ3yPwcxbBlhjtt9SvNZNUCtTGkZXqekExPeOK7wRFR8/TofXdWGLXpxcDa95CXNwTcuNGI76iEvGJgRspon0U3fCIOWLM1gIye+KnUwZ9Mtc1y+lWd5HTePJ+KJB5xYGBUqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140405; c=relaxed/simple;
	bh=DtCH9UytV+RnLVX1F5DSvLpuB/4gI0meNPXyxa/mOgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNkUjZrAwRJG5PPEKFPxRJ2gy9o/VJUR65+i4JhtlDqRSunl+HxcsDoZWWlkOH4MzfyMqdC0Rt8sCKfaio9pLC5YC+XFblA5e9lpxj3UKBaH5lyKOXhr659QEYmet8mX2B6VbrLhaDWqVPMTHvThZXNqWCxakXPA7XtYI9hH3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fdtGLQgT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so16021245e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140397; x=1772745197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuFl4xqYq6G6RHboEdDI9ZBTYjDGxT8flM5jt2ij3S8=;
        b=fdtGLQgTBBF0Lj7yZjUqS5j6dNuF38Dy7HOEPOp2E/ejRxbj2yGG2BLQ00ku+DsK9B
         69Q+a9kr7KeZAQuqCrveeZ3gGhvdn+6dEIv5oBWUb3heAiAw2/NmzsrDIAqPCyRaVNSZ
         xLepLG5U8ksVMiszLruk1Cr/ARuvgNEKhpVXmvUm+lqJu/YOMWQ5x55sbyfr9QRo3iVT
         nI4FOkP5ilAsiA6dTccvYdb9aKCh/wSVTC6uyKUnlJtwILWfCCcQ0ustiL+HFIXbydTl
         AE1xRJw2jw590w0L4pwI7wzilEhH2DdmzjvDXMjV+2ywHAwDtmgJRRtWWQZ+dlaegUPs
         Gs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140397; x=1772745197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuFl4xqYq6G6RHboEdDI9ZBTYjDGxT8flM5jt2ij3S8=;
        b=lrzM/SvCaTrHkaHi2SkM9gfEZttszzMEOO6G7qfZGjDDRq+7SuOqUYEmVZSUKnxmdt
         +I3NYbOCbSyhxHPJzml7wKiNbJStyqHQB43JhZMIw/ZT1n9m9eCi9chsNM9zPg73qu5D
         59cAR3NeLe3fAKd5rV4Y3JeQtZEosBV2GdkO5bIbyl752JeIu89IyiXcU25FDyKz13+P
         HlJSzEWPbZhwW4cAaKWMdAg8WVhaB8CoXKHjKxuxESu5wTIaC5WoJqUAep5C7ko928TR
         vRiR++5+I9ap+BFV8MiAg2wlQsakKCU2jg6Dq3A94WLEymT5kdbDh/jbkkyQIx+scnmn
         4vCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvzxX1JhH4G/G1nfZNUj/RjwmGVup3fpMiKU618t5vPrbnXGOI1jQCBKINxhmpKkuMp63uwn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5cON9KM/ToNoDq8/KiluwtYwmT94lNBH8uFNXK6eJ78ZwGQ6
	6WOSHNxBDADWnuz073cpJRjgDYoOrwJ+9PlguT/Cr/YvTmw2XJ751vKXmyUnwGjsQE0=
X-Gm-Gg: ATEYQzwJQQv81J7n/gd3aG9MDjII9OsJj/P6/csIvU0cyaNiblltB5BgCN5b+nHInpB
	t7VLQQD/lq97Wje7sy91rDhEvCgS86pdzEdSBsimA4d6xEqPg1A6m0G6lUt9HuIZVeMqhlgf6gx
	N/+rD+ciIJ/2Tct6ahpodQyWb3yNN/2xF/un4m6ElC40uQilDtBDynUrMHsMDRB8aE5Idp+EpQd
	qDN2jDaQu3IcgbchK3EHgxkgnfAg5w59VLBWOmSFph2i8jY9fYNNJA9CTy/i4zpxDCoDUUtWMIA
	lXQfMY21gBR5n74EmTUoSWLbGdsmUpknJPA/XEkNMqZZNgVhVOXX/X2zHPgc4B5LsAXpQA7XfEy
	FiJfGa5qj4AUE7LbHsyNWdjpuH27n4kgx974jC3XYPjbf7QRCiizt9Zzf9166Ztam5of4MFR1jX
	+os1icjrGB1mHbeDEiIEuoXs1b8a99lLXN0JLz61RoL4J5e5rDKmq1736kc1J/xTQf73YC
X-Received: by 2002:a05:600c:a086:b0:483:b3d7:2e80 with SMTP id 5b1f17b1804b1-483c9c1fc82mr3533195e9.33.1772140397078;
        Thu, 26 Feb 2026 13:13:17 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb987b0sm42065325e9.13.2026.02.26.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:15 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:56 +0100
Subject: [PATCH RFC bpf-next 5/5] selftests/bpf: Add functional tests for
 skb local storage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-5-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261597-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email]
X-Rspamd-Queue-Id: 5C17C1AF8EC
X-Rspamd-Action: no action

Exercise skb local storage across program types and hook boundaries.

1. skb_storage_ops: Unit test for the kfunc API - create, read,
   delete, and re-create with an initial value. Runs as a socket
   filter via BPF_PROG_TEST_RUN.

2. tc_clone_redirect: Store from TC egress on lo, bpf_clone_redirect
   to a dummy device, read from TC egress on the dummy - verifies
   storage is not carried over to the clone (BPF_F_CLONE is not
   supported).

3. tc_ingress_to_cgrp_ingress: Store from TC ingress, read from
   cgroup/skb ingress - verifies storage survives across hooks on
   the same skb.

4. tc_ingress_to_sk_filter: Store from TC ingress, read from a
   socket filter - verifies storage is accessible from SO_ATTACH_BPF.

5. cgrp_egress_to_tp_kfree_skb: Store from cgroup/skb egress, read
   from tp_btf/kfree_skb after a blackhole qdisc drops the packet -
   verifies storage survives until skb free.

6. tc_ingress_to_lsm_inet_conn_estab: Store from TC ingress, read
   from LSM inet_conn_established hook - verifies storage is
   accessible from LSM programs.

7. tc_ingress_to_skops_passive_estab: Store from TC ingress, read
   from sock_ops BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB via
   bpf_sock_ops_kern.skb - verifies the sock_ops access path.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../testing/selftests/bpf/prog_tests/skb_storage.c | 405 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/skb_storage.c    | 312 ++++++++++++++++
 2 files changed, 717 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_storage.c b/tools/testing/selftests/bpf/prog_tests/skb_storage.c
new file mode 100644
index 000000000000..32b5669de9f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skb_storage.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare, Inc. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "skb_storage.skel.h"
+
+#define CGROUP_PATH "/skb_storage"
+#define DUMMY_DEV "dum0"
+#define IFINDEX_LO 1
+#define MAGIC_VALUE 0xdeadbeef
+#define TEST_PORT 4242
+
+static int send_udp_packet(__be16 port)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = port,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	int fd, ret = -1;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	ret = sendto(fd, "x", 1, 0, (struct sockaddr *)&addr, sizeof(addr));
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+out:
+	close(fd);
+	return ret;
+}
+
+static int recv_udp_packet(int server_fd)
+{
+	char buf[64];
+	struct sockaddr_in addr;
+	socklen_t len = sizeof(addr);
+
+	return recvfrom(server_fd, buf, sizeof(buf), 0,
+			(struct sockaddr *)&addr, &len);
+}
+
+static void test_skb_storage_ops(struct skb_storage *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+	);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.skb_storage_ops_test),
+				     &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(skel->bss->test_result, 0, "test_result");
+}
+
+static void test_tc_clone_redirect(struct skb_storage *skel)
+{
+	const __be16 test_port = htons(TEST_PORT);
+	struct bpf_link *dummy_link = NULL;
+	struct bpf_link *lo_link = NULL;
+	struct netns_obj *netns;
+	int dummy_ifindex;
+
+	netns = netns_new(__func__, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto cleanup;
+
+	SYS(cleanup, "ip link add " DUMMY_DEV " type dummy");
+	SYS(cleanup, "ip link set " DUMMY_DEV " up");
+
+	dummy_ifindex = if_nametoindex(DUMMY_DEV);
+	if (!ASSERT_GT(dummy_ifindex, 0, "dummy_ifindex"))
+		goto cleanup;
+
+	skel->bss->target_port = test_port;
+	skel->bss->redirect_ifindex = dummy_ifindex;
+
+	lo_link = bpf_program__attach_tcx(skel->progs.tc_clone_redirect_store,
+					  IFINDEX_LO, NULL);
+	if (!ASSERT_OK_PTR(lo_link, "attach_ingress"))
+		goto cleanup;
+
+	dummy_link = bpf_program__attach_tcx(skel->progs.tc_clone_redirect_load,
+					     dummy_ifindex, NULL);
+	if (!ASSERT_OK_PTR(dummy_link, "attach_egress"))
+		goto cleanup;
+
+	skel->bss->store_seen = 0;
+	skel->bss->redir_seen = 0;
+	skel->bss->load_seen = 0;
+	skel->bss->load_value = 0;
+
+	if (!ASSERT_OK(send_udp_packet(test_port), "send_udp"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->store_seen, 1, "store_seen");
+	ASSERT_EQ(skel->bss->redir_seen, 1, "redir_seen");
+	ASSERT_EQ(skel->bss->load_seen, 0, "load_seen");
+	ASSERT_EQ(skel->bss->load_value, 0, "load_value");
+
+cleanup:
+	bpf_link__destroy(dummy_link);
+	bpf_link__destroy(lo_link);
+	netns_free(netns);
+}
+
+static void test_tc_ingress_to_cgrp_ingress(struct skb_storage *skel)
+{
+	struct bpf_link *tc_link = NULL;
+	struct bpf_link *cg_link = NULL;
+	int cgroup_fd = -1;
+	int server_fd = -1;
+	__be16 port;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	skel->bss->target_port = port;
+
+	tc_link = bpf_program__attach_tcx(skel->progs.tc_ingress_store,
+					  IFINDEX_LO, NULL);
+	if (!ASSERT_OK_PTR(tc_link, "attach_tc"))
+		goto cleanup;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_ingress_load,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	skel->bss->store_seen = 0;
+	skel->bss->load_seen = 0;
+	skel->bss->load_value = 0;
+
+	if (!ASSERT_OK(send_udp_packet(port), "send_udp"))
+		goto cleanup;
+
+	if (!ASSERT_GE(recv_udp_packet(server_fd), 0, "recv_udp"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->store_seen, 1, "store_seen");
+	ASSERT_EQ(skel->bss->load_seen, 1, "load_seen");
+	ASSERT_EQ(skel->bss->load_value, MAGIC_VALUE, "load_value");
+
+cleanup:
+	bpf_link__destroy(cg_link);
+	bpf_link__destroy(tc_link);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
+static void test_tc_ingress_to_sk_filter(struct skb_storage *skel)
+{
+	struct bpf_link *tc_link = NULL;
+	int server_fd = -1;
+	int filter_fd = -1;
+	__be16 port;
+	int ret;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	skel->bss->target_port = port;
+
+	tc_link = bpf_program__attach_tcx(skel->progs.tc_ingress_store,
+					  IFINDEX_LO, NULL);
+	if (!ASSERT_OK_PTR(tc_link, "attach_tcx"))
+		goto cleanup;
+
+	filter_fd = bpf_program__fd(skel->progs.sk_filter_load);
+	if (!ASSERT_GE(filter_fd, 0, "get_prog_fd"))
+		goto cleanup;
+
+	ret = setsockopt(server_fd, SOL_SOCKET, SO_ATTACH_BPF,
+			 &filter_fd, sizeof(filter_fd));
+	if (!ASSERT_OK(ret, "attach_socket_filter"))
+		goto cleanup;
+
+	skel->bss->store_seen = 0;
+	skel->bss->load_seen = 0;
+	skel->bss->load_value = 0;
+
+	if (!ASSERT_OK(send_udp_packet(port), "send_udp"))
+		goto cleanup;
+
+	if (!ASSERT_GE(recv_udp_packet(server_fd), 0, "recv_udp"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->store_seen, 1, "store_seen");
+	ASSERT_EQ(skel->bss->load_seen, 1, "load_seen");
+	ASSERT_EQ(skel->bss->load_value, MAGIC_VALUE, "load_value");
+
+cleanup:
+	bpf_link__destroy(tc_link);
+	if (server_fd >= 0)
+		close(server_fd);
+}
+
+static void test_cgrp_egress_to_tp_kfree_skb(struct skb_storage *skel)
+{
+	struct bpf_link *cg_link = NULL;
+	struct bpf_link *tp_link = NULL;
+	struct netns_obj *netns = NULL;
+	int cgroup_fd = -1;
+	__be16 port;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	netns = netns_new(__func__, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto cleanup;
+
+	port = htons(TEST_PORT);
+	skel->bss->target_port = port;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_egress_store,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	tp_link = bpf_program__attach_trace(skel->progs.tp_kfree_skb_load);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		goto cleanup;
+
+	skel->bss->store_seen = 0;
+	skel->bss->load_seen = 0;
+	skel->bss->load_value = 0;
+
+	SYS(cleanup, "tc qdisc add dev lo root handle 1:0 blackhole");
+
+	if (!ASSERT_OK(send_udp_packet(port), "send_udp"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->store_seen, 1, "store_seen");
+	ASSERT_EQ(skel->bss->load_seen, 1, "load_seen");
+	ASSERT_EQ(skel->bss->load_value, MAGIC_VALUE, "load_value");
+
+cleanup:
+	bpf_link__destroy(tp_link);
+	bpf_link__destroy(cg_link);
+	netns_free(netns);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
+static void test_tc_ingress_to_lsm_inet_conn_estab(struct skb_storage *skel)
+{
+	struct bpf_link *lsm_link = NULL;
+	struct bpf_link *tc_link = NULL;
+	int server_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	__be16 port;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	skel->bss->target_port = port;
+
+	tc_link = bpf_program__attach_tcx(skel->progs.tc_ingress_store, IFINDEX_LO, NULL);
+	if (!ASSERT_OK_PTR(tc_link, "attach_tcx"))
+		goto cleanup;
+
+	lsm_link = bpf_program__attach_lsm(skel->progs.lsm_inet_conn_estab_load);
+	if (!ASSERT_OK_PTR(lsm_link, "attach_lsm"))
+		goto cleanup;
+
+	skel->bss->store_seen = 0;
+	skel->bss->load_seen = 0;
+	skel->bss->load_value = 0;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+	close(conn_fd);
+
+	ASSERT_GT(skel->bss->store_seen, 0, "store_seen");
+	ASSERT_GT(skel->bss->load_seen, 0, "load_seen");
+	ASSERT_EQ(skel->bss->load_value, MAGIC_VALUE, "load_value");
+
+cleanup:
+	bpf_link__destroy(lsm_link);
+	bpf_link__destroy(tc_link);
+	if (client_fd >= 0)
+		close(client_fd);
+	if (server_fd >= 0)
+		close(server_fd);
+}
+
+static void test_tc_ingress_to_skops_passive_estab(struct skb_storage *skel)
+{
+	struct bpf_link *cg_link = NULL;
+	struct bpf_link *tc_link = NULL;
+	int cgroup_fd = -1;
+	int server_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	__be16 port;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	skel->bss->target_port = port;
+
+	tc_link = bpf_program__attach_tcx(skel->progs.tc_ingress_store, IFINDEX_LO, NULL);
+	if (!ASSERT_OK_PTR(tc_link, "attach_tcx"))
+		goto cleanup;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.skops_passive_estab_load, cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	skel->bss->store_seen = 0;
+	skel->bss->load_seen = 0;
+	skel->bss->load_value = 0;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+	close(conn_fd);
+
+	ASSERT_GT(skel->bss->store_seen, 0, "store_seen");
+	ASSERT_GT(skel->bss->load_seen, 0, "load_seen");
+	ASSERT_EQ(skel->bss->load_value, MAGIC_VALUE, "load_value");
+
+cleanup:
+	bpf_link__destroy(cg_link);
+	bpf_link__destroy(tc_link);
+	if (client_fd >= 0)
+		close(client_fd);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
+void test_skb_storage(void)
+{
+	struct skb_storage *skel;
+
+	skel = skb_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	if (test__start_subtest("skb_storage_ops"))
+		test_skb_storage_ops(skel);
+	if (test__start_subtest("tc_clone_redirect"))
+		test_tc_clone_redirect(skel);
+	if (test__start_subtest("tc_ingress_to_cgrp_ingress"))
+		test_tc_ingress_to_cgrp_ingress(skel);
+	if (test__start_subtest("tc_ingress_to_sk_filter"))
+		test_tc_ingress_to_sk_filter(skel);
+	if (test__start_subtest("cgrp_egress_to_tp_kfree_skb"))
+		test_cgrp_egress_to_tp_kfree_skb(skel);
+	if (test__start_subtest("tc_ingress_to_lsm_inet_conn_estab"))
+		test_tc_ingress_to_lsm_inet_conn_estab(skel);
+	if (test__start_subtest("tc_ingress_to_skops_passive_estab"))
+		test_tc_ingress_to_skops_passive_estab(skel);
+
+	skb_storage__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/skb_storage.c b/tools/testing/selftests/bpf/progs/skb_storage.c
new file mode 100644
index 000000000000..57628a6d26ae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/skb_storage.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cloudflare, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+#define fallthrough __attribute__((__fallthrough__))
+
+#define ETH_P_IP 0x0800
+#define ETH_HLEN 14
+#define MAGIC_VALUE 0xdeadbeef
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SKB_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, __u32);
+} skb_storage SEC(".maps");
+
+volatile __be16 target_port;
+volatile __u32 redirect_ifindex;
+
+volatile int test_result;
+volatile int store_seen;
+volatile int redir_seen;
+volatile int load_seen;
+volatile int load_value;
+
+enum {
+	CG_DROP = 0,
+	CG_PASS,
+};
+
+enum layer { L2, L3, L4 };
+
+static bool is_test_packet(struct __sk_buff *skb, enum layer layer)
+{
+	__u32 off = 0;
+	__be16 src;
+	__be16 dst;
+	__u8 ihl;
+
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return false;
+
+	switch (layer) {
+	case L2:
+		off += ETH_HLEN;
+		fallthrough;
+	case L3:
+		if (bpf_skb_load_bytes(skb, off, &ihl, 1))
+			return false;
+		off += (ihl & 0xf) * 4;
+		fallthrough;
+	case L4:
+		if (bpf_skb_load_bytes(skb, off, &src, 2))
+			return false;
+		if (bpf_skb_load_bytes(skb, off + 2, &dst, 2))
+			return false;
+	}
+
+	return src == target_port || dst == target_port;
+}
+
+SEC("socket")
+int skb_storage_ops_test(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 init_value = MAGIC_VALUE;
+	__u32 *value;
+	int ret;
+
+	/* Get non-existent storage */
+	test_result = 1;
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (value)
+		goto out;
+
+	/* Create storage and write to it */
+	test_result = 2;
+	value = bpf_skb_storage_get(map, skb, NULL, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value)
+		goto out;
+	if (*value)
+		goto out;
+	*value = MAGIC_VALUE;
+
+	/* Get existing storage and read from it  */
+	test_result = 3;
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+	if (*value != MAGIC_VALUE)
+		goto out;
+
+	/* Delete existing storage */
+	test_result = 4;
+	ret = bpf_skb_storage_delete(map, skb);
+	if (ret)
+		goto out;
+
+	/* Delete non-existent storage */
+	test_result = 5;
+	ret = bpf_skb_storage_delete(map, skb);
+	if (ret != -ENOENT)
+		goto out;
+
+	/* Re-create storage with initial value */
+	test_result = 6;
+	value = bpf_skb_storage_get(map, skb, &init_value, sizeof(init_value),
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value)
+		goto out;
+	if (*value != MAGIC_VALUE)
+		goto out;
+
+	test_result = 0;
+out:
+	return ctx->len;
+}
+
+SEC("tcx/egress")
+int tc_clone_redirect_store(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 *value;
+
+	if (!redirect_ifindex)
+		goto out;
+	if (!is_test_packet(ctx, L2))
+		goto out;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value)
+		goto out;
+
+	*value = MAGIC_VALUE;
+	store_seen++;
+
+	bpf_clone_redirect(ctx, redirect_ifindex, 0);
+out:
+	return TCX_DROP;
+}
+
+SEC("tcx/egress")
+int tc_clone_redirect_load(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 *value;
+
+	if (!is_test_packet(ctx, L2))
+		goto out;
+
+	redir_seen++;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+
+	load_value = *value;
+	load_seen++;
+out:
+	return TCX_DROP;
+}
+
+SEC("tcx/ingress")
+int tc_ingress_store(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 *value;
+
+	if (!is_test_packet(ctx, L2))
+		goto out;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value)
+		goto out;
+
+	*value = MAGIC_VALUE;
+	store_seen++;
+out:
+	return TCX_PASS;
+}
+
+SEC("cgroup_skb/ingress")
+int cgrp_ingress_load(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 *value;
+
+	if (!is_test_packet(ctx, L3))
+		goto out;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+
+	load_value = *value;
+	load_seen++;
+out:
+	return CG_PASS;
+}
+
+SEC("cgroup_skb/egress")
+int cgrp_egress_store(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 *value;
+
+	if (!is_test_packet(ctx, L3))
+		goto out;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!value)
+		goto out;
+
+	*value = MAGIC_VALUE;
+	store_seen++;
+out:
+	return CG_PASS;
+}
+
+SEC("socket")
+int sk_filter_load(struct __sk_buff *ctx)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = bpf_cast_to_kern_ctx(ctx);
+	__u32 *value;
+
+	if (!is_test_packet(ctx, L4))
+		goto out;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+
+	load_value = *value;
+	load_seen++;
+out:
+	return skb->len;
+}
+
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_load, struct sk_buff *skb, void *location,
+	     enum skb_drop_reason reason)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	__u32 *value;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+
+	load_value = *value;
+	load_seen++;
+out:
+	return 0;
+}
+
+SEC("lsm/inet_conn_established")
+int BPF_PROG(lsm_inet_conn_estab_load, struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	__u32 *value;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+
+	load_value = *value;
+	load_seen++;
+out:
+	return 0;
+}
+
+SEC("sockops")
+int skops_passive_estab_load(struct bpf_sock_ops *ctx)
+{
+	struct bpf_sock_ops_kern *kctx = bpf_cast_to_kern_ctx(ctx);
+	struct bpf_map *map = (typeof(map))&skb_storage;
+	struct sk_buff *skb = kctx->skb;
+	__u32 *value;
+
+	if (ctx->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		goto out;
+	if (!skb)
+		goto out;
+
+	value = bpf_skb_storage_get(map, skb, NULL, 0, 0);
+	if (!value)
+		goto out;
+
+	load_value = *value;
+	load_seen++;
+out:
+	return CG_PASS;
+}

-- 
2.43.0


