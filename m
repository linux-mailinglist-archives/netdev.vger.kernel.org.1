Return-Path: <netdev+bounces-307548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lydyFrR2Vmqv6AAAu9opvQ
	(envelope-from <netdev+bounces-307548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2607579C4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:49:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=BiiqVhOr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307548-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307548-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 836F13018AA1
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156E47DD79;
	Tue, 14 Jul 2026 17:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3B2EEE97
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051335; cv=none; b=Q/eUEs8E7MWag44Z+bocY4P3F1xy86SVBaeEOn08ccVcfWsWQ7UBsKmdNvYw9qrHmO7zsegaMBj71EXsSDwnKb8ksSSSv2BXsTEhfmGLnwnClPaGMuG+RHqYWfeGncaockBx8PaDRvSn3bGHacqn79pbbPwyxbzSdI8Zrr8SIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051335; c=relaxed/simple;
	bh=bTpIqRJD7Q7xr7H9o9DhZ24FTRPWuwH/UVe+e/TPYhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q86KBijAnQNXBJhCmu5CuVdInVlD2JGhLkWFYgguwncWnwj0St1uIE/d3gyJfcBqmuNxjDlt30CRNPPY/dOeR3dw9RzKhvUTCvo+qU0FOY1S6L/WHO/a9zWz8DAegzos2LziA7r/VSNMqKePY8RAc4RovZjmfK+OMpmclut6IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BiiqVhOr; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so24914125e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051314; x=1784656114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/i/x02dtZj5S5NQOerY7DACGhttbTq4eQT4EUMGcGq8=;
        b=BiiqVhOrb6+tCrrlIcz2CQe+s/4PWaYJgvYqrt8xjntl1NgLL4aV6dLhY1CsgODTrw
         pQeBobJFxtQ0lnCeSoyz1urHJhpNFFljfVBfce+l34RhZJYdE7UXTHTAP7nZKw/EYdXu
         VEb+qYOypaMtw8GwA6479JIW3bN6jMUGRxy0z8e/cYk7wfXZwpBgWE+bR3tfDj7+kemj
         N0WlcbKchbzDudJmRJXzJrz0HLPkiOEMeq/1K9WHFDnPMyMio0uVFGhrZHUmkfTmh3fs
         7im70EeNOYvg29IAIfvLVmf6GYaHreY3k/+brEGXiSHdFy8zpXVJ6JjHxd3J4AUIzRgZ
         1prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051314; x=1784656114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/i/x02dtZj5S5NQOerY7DACGhttbTq4eQT4EUMGcGq8=;
        b=r9xnVBq1/q2D/00XlI8x24ehd/CLxK84NBiBTal7cVhZx2RBp5oujcH8rm3IUYCEBC
         ZyBn7K0JHcqFeyCi0EhDByWo8298ouDMEibnAo2xGb6EDCZRFok+BbqgqgOr2A1s7faW
         aEgzY0/5wFtEcNjccBCuf4hMzehmGM9uGbSfkiNpmt9CcrmXaf6XqsT60HBXxMCUiTbL
         tl0BWksOdK/7a47mgvGBbY4PfSgIv3/mXovhZ6OCHnZfLwsbUxKeYpUlLm0otN4AzYcZ
         UelL5enpjJ8dKqi8n2sabgtDi50p/ORVVnEVJNysgFBlAPONXjyYMbMlxPUXzdLKe9E2
         FdcA==
X-Gm-Message-State: AOJu0YznhZwmwWBKUpqaizjvJGVC9fJ7j4zZvcb3DG7EgGD7JT2Oehu3
	Cr0iAmU++6e9bZVw0KY3AC1hoYZucCri3kv06tCDnNLBB2KiHH+pHe0BUMfwmL4sMlY=
X-Gm-Gg: AfdE7cmQeyUBS3/JV9PgD2WMSbTwirTKHgQdfkaqBuClHzWiMjVX2nOC4aIs44j7Cpw
	0SyN4aZPmDBVlj2K2wx2Ou3n/du8rlv9kU20SHlvx3pW7iuVDO577leZPpl0ZTRtx9v23GaATna
	mcqG8u/cQc5n2W2HODKk0UGAkg4JEFQ13L8pjb/a98nhgwIkLQoioR4X29A1MV3tYD/yP+GwuZn
	tPqnXKLWJPEeLY8D9MCay2pV1YKWmkC+htvNfrzFFtjo4aAuk3oIN+/rLk+6c8N/LymLrJMBGIR
	R8oWkTj3vtOtScRPc4Q9miIop69XiJDtA8rrXmo0TrT120bqR0Rz07ZgBge+iX4vygipCEGINtl
	mHlheMWtcGFUuLvaEKFOUv8HonqgQ88gQWk9UVwYKoyhYx/sgxXPYumQfqkf65OyJgt9Ac1Y3A1
	al5eNeSG1aIWyOnfjSOvZ3XWMaRoxH3uvU7bNBd7OSDO2klh66blbNuCvQpg==
X-Received: by 2002:a05:600c:3e15:b0:493:eccb:8cb2 with SMTP id 5b1f17b1804b1-493f882e148mr155052255e9.30.1784051313629;
        Tue, 14 Jul 2026 10:48:33 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96cfsm10275668f8f.20.2026.07.14.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:23 +0200
Subject: [PATCH RFC net-next 4/6] selftests/bpf: Add tests for
 bpf_dynptr_from_skb_ext
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-4-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307548-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:from_mime,cloudflare.com:mid,cloudflare.com:email,cloudflare.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A2607579C4

Test the bpf_dynptr_from_skb_ext() kfunc and skb_ext survival across
network stack hooks.

Cover the dynptr interface with TC-to-TC tests on a tuntap device:

- write/read via bpf_dynptr_read and bpf_dynptr_write
- write/read via bpf_dynptr_slice and bpf_dynptr_slice_rdwr
- clone read via bpf_dynptr_clone
- error paths: no allocation without F_CREATE, invalid flags, read-only
  enforcement without F_CREATE
- double allocation: data from first alloc survives second skb_ext_add

Cover cross-hook survival by writing skb_ext at TC ingress and reading
it at later hooks:

- TC -> cgroup/skb ingress (UDP loopback)
- TC -> socket filter (UDP loopback)
- TC -> sock_ops passive established (TCP loopback)
- TC -> LSM inet_conn_established (TCP loopback)
- cgroup/skb egress -> tp_btf/kfree_skb (survival until skb free)

Cover skb clone isolation:

- clone_ext_read: ext read from a mirred clone shares data with
  original
- clone_ext_cow: F_CREATE on clone triggers COW, writes to clone do
  not affect original

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 412 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 392 ++++++++++++++++++++
 2 files changed, 804 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 26159e0499c7..c603f2484803 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -427,6 +427,338 @@ static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 	netns_free(ns);
 }
 
+/* Send test_payload over loopback UDP to recv_fd */
+static int send_loopback_udp(int recv_fd)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	char buf[TEST_PAYLOAD_LEN];
+	int ret = -1;
+	int fd = -1;
+	__be16 port;
+
+	port = get_socket_local_port(recv_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto out;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto out;
+
+	addr.sin_port = port;
+	sendto(fd, test_payload, TEST_PAYLOAD_LEN, 0,
+	       (void *)&addr, sizeof(addr));
+	recvfrom(recv_fd, buf, sizeof(buf), 0, NULL, NULL);
+	ret = 0;
+out:
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
+
+enum udp_reader_type {
+	READER_CGRP_SKB,
+	READER_SK_FILTER,
+};
+
+/* Test skb_ext survival across TC ingress -> UDP reader hook */
+static void test_skb_ext_udp(struct test_xdp_meta *skel, const char *name,
+			     enum udp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int filter_fd;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	cgroup_fd = test__join_cgroup(name);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	switch (reader) {
+	case READER_CGRP_SKB:
+		reader_link = bpf_program__attach_cgroup(skel->progs.cgrp_skb_ext_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_cgroup"))
+			goto cleanup;
+		break;
+	case READER_SK_FILTER:
+		filter_fd = bpf_program__fd(skel->progs.sk_filter_skb_ext_read);
+		ret = setsockopt(server_fd, SOL_SOCKET, SO_ATTACH_BPF,
+				 &filter_fd, sizeof(filter_fd));
+		if (!ASSERT_OK(ret, "attach_socket_filter"))
+			goto cleanup;
+		break;
+	}
+
+	if (send_loopback_udp(server_fd))
+		goto cleanup;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	bpf_link__destroy(reader_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
+enum tcp_reader_type {
+	READER_SKOPS,
+	READER_LSM,
+};
+
+/* Test skb_ext survival across TC ingress -> TCP reader hook */
+static void test_skb_ext_tcp(struct test_xdp_meta *skel, const char *name,
+			     enum tcp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	__be16 port;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	cgroup_fd = test__join_cgroup(name);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
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
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write_port);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	switch (reader) {
+	case READER_SKOPS:
+		reader_link = bpf_program__attach_cgroup(skel->progs.skops_skb_ext_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_skops"))
+			goto cleanup;
+		break;
+	case READER_LSM:
+		reader_link = bpf_program__attach_lsm(skel->progs.lsm_skb_ext_read);
+		if (!ASSERT_OK_PTR(reader_link, "attach_lsm"))
+			goto cleanup;
+		break;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (conn_fd >= 0)
+		close(conn_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	bpf_link__destroy(reader_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
+/* Test skb_ext survives skb clone (via tc mirred).
+ * dummy_prog runs on the clone (dummy ingress).
+ */
+static void test_mirred_clone_ext(struct test_xdp_meta *skel,
+				  struct bpf_program *dummy_prog)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int dummy_ifindex;
+	int tap_ifindex;
+	int tap_fd = -1;
+	int ret;
+
+	skel->bss->test_pass = false;
+
+	ns = netns_new("mirred_clone", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Dummy dev: attach reader */
+	SYS(close, "ip link add name " DUMMY_NAME " type dummy");
+	SYS(close, "ip link set dev " DUMMY_NAME " up");
+
+	dummy_ifindex = if_nametoindex(DUMMY_NAME);
+	if (!ASSERT_GE(dummy_ifindex, 0, "dummy_ifindex"))
+		goto close;
+
+	tc_hook.ifindex = dummy_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "dummy_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(dummy_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "dummy_attach"))
+		goto close;
+
+	/* TAP dev: attach writer + mirred to dummy */
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "tap_ifindex"))
+		goto close;
+
+	tc_hook.ifindex = tap_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "tap_hook_create"))
+		goto close;
+
+	tc_opts.prog_id = 0;
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "tap_attach"))
+		goto close;
+
+	SYS(close, "tc filter add dev " TAP_NAME " ingress "
+		   "protocol all matchall "
+		   "action mirred ingress mirror dev " DUMMY_NAME);
+
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+/* Test skb_ext survival until skb free: cgroup/skb egress -> kfree_skb.
+ * Send UDP to a closed port. The packet is dropped, triggering kfree_skb.
+ */
+static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = htons(4321),
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	struct bpf_link *cg_link = NULL;
+	struct bpf_link *tp_link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd = -1;
+	char buf[1];
+	int fd = -1;
+	int ret;
+
+	cgroup_fd = test__join_cgroup("/cgrp_to_kfree");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new("cgrp_to_kfree", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_skb_ext_write,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	tp_link = bpf_program__attach_trace(skel->progs.tp_kfree_skb_ext_read);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		goto cleanup;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto cleanup;
+
+	ret = connect(fd, (void *)&addr, sizeof(addr));
+	if (!ASSERT_OK(ret, "connect"))
+		goto cleanup;
+
+	send(fd, test_payload, TEST_PAYLOAD_LEN, 0);
+
+	/* Wait for ICMP error -- confirms the packet was freed */
+	ret = recv(fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(errno, ECONNREFUSED, "recv_econnrefused");
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	bpf_link__destroy(tp_link);
+	bpf_link__destroy(cg_link);
+	netns_free(ns);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
 void test_xdp_context_tuntap(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -515,6 +847,86 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_change_proto,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	/* Tests for BPF dynptr from skb_ext */
+	if (test__start_subtest("tc_skb_ext__write_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_write,
+			    skel->progs.tc_skb_ext_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__write_clone_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_write,
+			    skel->progs.tc_skb_ext_clone_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__write_slice_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_write,
+			    skel->progs.tc_skb_ext_slice_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__slice_write_read"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_slice_write,
+			    skel->progs.tc_skb_ext_read,
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__no_alloc"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_no_alloc,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__invalid_flags"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_invalid_flags,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__rdonly"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_rdonly,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+	if (test__start_subtest("tc_skb_ext__double_alloc"))
+		test_tuntap(NULL, /* xdp */
+			    skel->progs.tc_skb_ext_double_alloc,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
+
+	test_xdp_meta__destroy(skel);
+}
+
+static void test_mirred_clone_ext_cow(struct test_xdp_meta *skel)
+{
+	struct bpf_link *tp_link;
+
+	skel->bss->clone_cow_done = false;
+	tp_link = bpf_program__attach(skel->progs.tp_kfree_skb_cow_check);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		return;
+
+	test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_clone_redir_cow);
+	bpf_link__destroy(tp_link);
+}
+
+void test_skb_ext_cross_hook(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_to_cgrp"))
+		test_skb_ext_udp(skel, "tc_to_cgrp", READER_CGRP_SKB);
+	if (test__start_subtest("tc_to_sk_filter"))
+		test_skb_ext_udp(skel, "tc_to_sk_filter", READER_SK_FILTER);
+	if (test__start_subtest("tc_to_lsm"))
+		test_skb_ext_tcp(skel, "tc_to_lsm", READER_LSM);
+	if (test__start_subtest("tc_to_skops"))
+		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
+	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
+		test_cgrp_egress_to_kfree_skb(skel);
+	if (test__start_subtest("clone_ext_read"))
+		test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_read);
+	if (test__start_subtest("clone_ext_cow"))
+		test_mirred_clone_ext_cow(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index fa73b17cb999..25fbdc00657c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -3,9 +3,11 @@
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <errno.h>
 
 #include "bpf_kfuncs.h"
+#include "bpf_misc.h"
 #include "bpf_tracing_net.h"
 
 #define META_SIZE 32
@@ -64,6 +66,21 @@ static bool check_skb_metadata(const char *file, int line, struct __sk_buff *skb
 
 #define check_skb_metadata(skb) check_skb_metadata(__FILE__, __LINE__, skb)
 
+/* Test packets carry test metadata pattern as payload. */
+static bool is_test_packet_tc(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+
+	if (ctx->len < META_SIZE)
+		return false;
+	if (bpf_skb_load_bytes(ctx, ctx->len - META_SIZE, meta_have, META_SIZE))
+		return false;
+	if (__builtin_memcmp(meta_have, meta_want, META_SIZE))
+		return false;
+
+	return true;
+}
+
 SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
@@ -670,4 +687,379 @@ int helper_skb_change_proto(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to skb_ext using bpf_dynptr_write helper */
+SEC("tc")
+int tc_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0))
+		return TC_ACT_SHOT;
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from skb-ext metadata using bpf_dynptr_read helper */
+SEC("tc")
+int tc_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, ARRAY_SIZE(meta_have), &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from a cloned skb_ext dynptr */
+SEC("tc")
+int tc_skb_ext_clone_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta, clone;
+	__u8 meta_have[META_SIZE];
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_clone(&meta, &clone))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, ARRAY_SIZE(meta_have), &clone, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from skb_ext using bpf_dynptr_slice */
+SEC("tc")
+int tc_skb_ext_slice_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *meta_have;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	meta_have = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Write to skb_ext using bpf_dynptr_slice_rdwr */
+SEC("tc")
+int tc_skb_ext_slice_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *dst;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	dst = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!dst)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, meta_want, META_SIZE);
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Opening skb_ext without F_CREATE on a fresh skb should fail */
+SEC("tc")
+int tc_skb_ext_no_alloc(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta) != -ENOENT)
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Invalid flags are rejected */
+SEC("tc")
+int tc_skb_ext_invalid_flags(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, ~0ULL, &meta) != -EINVAL)
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Without F_CREATE the dynptr is read-only */
+SEC("tc")
+int tc_skb_ext_rdonly(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	/* Create and populate the ext */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	/* Reopen without F_CREATE -- should be read-only */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+
+	/* Verify read-only: writes must fail, reads must work */
+	if (!bpf_dynptr_is_rdonly(&meta))
+		return TC_ACT_SHOT;
+	if (!bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Double alloc: data from first alloc survives second skb_ext_add */
+SEC("tc")
+int tc_skb_ext_double_alloc(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	/* First alloc + write */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	/* Second alloc -- skb_ext_add returns existing ext */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read skb_ext from cgroup/skb ingress -- tests cross-hook survival */
+SEC("cgroup_skb/ingress")
+int cgrp_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return 1;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 1;
+	if (!check_metadata(meta_have))
+		return 1;
+
+	test_pass = true;
+	return 1;
+}
+
+volatile __be16 target_port;
+
+#define TCPV4_HDR_OFF	(sizeof(struct ethhdr) + sizeof(struct iphdr))
+#define TCPV4_SPORT_OFF	(TCPV4_HDR_OFF + offsetof(struct tcphdr, source))
+#define TCPV4_DPORT_OFF	(TCPV4_HDR_OFF + offsetof(struct tcphdr, dest))
+
+/* Write skb_ext on TCP packets to/from target_port */
+SEC("tc")
+int tc_skb_ext_write_port(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__be16 sport, dport;
+
+	if (ctx->protocol != __bpf_constant_htons(ETH_P_IP))
+		return TC_ACT_UNSPEC;
+	if (bpf_skb_load_bytes(ctx, TCPV4_SPORT_OFF, &sport, sizeof(sport)))
+		return TC_ACT_UNSPEC;
+	if (bpf_skb_load_bytes(ctx, TCPV4_DPORT_OFF, &dport, sizeof(dport)))
+		return TC_ACT_UNSPEC;
+	if (sport != target_port && dport != target_port)
+		return TC_ACT_UNSPEC;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_UNSPEC;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0);
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Read skb_ext from sock_ops passive established -- tests TC -> sock_ops path */
+SEC("sockops")
+int skops_skb_ext_read(struct bpf_sock_ops *ctx)
+{
+	struct bpf_sock_ops_kern *kctx;
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+	struct sk_buff *skb;
+
+	if (ctx->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		return 1;
+
+	kctx = bpf_cast_to_kern_ctx(ctx);
+	skb = kctx->skb;
+	if (!skb)
+		return 1;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 1;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 1;
+	if (!check_metadata(meta_have))
+		return 1;
+
+	test_pass = true;
+	return 1;
+}
+
+/* Read skb_ext from LSM inet_conn_established -- tests TC -> LSM path */
+SEC("lsm/inet_conn_established")
+int BPF_PROG(lsm_skb_ext_read, struct sock *sk, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 0;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 0;
+	if (!check_metadata(meta_have))
+		return 0;
+
+	test_pass = true;
+	return 0;
+}
+
+/* Read skb_ext from socket filter -- tests TC -> sk_filter path */
+SEC("socket")
+int sk_filter_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		goto out;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		goto out;
+	if (!check_metadata(meta_have))
+		goto out;
+
+	test_pass = true;
+out:
+	return ctx->len;
+}
+
+/* Write skb_ext from cgroup/skb egress */
+SEC("cgroup_skb/egress")
+int cgrp_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return 1;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return 1;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0);
+
+	return 1;
+}
+
+static const __u8 meta_zero[META_SIZE] = {};
+
+volatile bool clone_cow_done;
+
+/* Overwrite skb_ext on the clone via F_CREATE (COW) -- must not affect original.
+ * Runs on the dummy ingress (clone side), synchronously during tc mirred.
+ */
+SEC("tc")
+int tc_skb_ext_clone_redir_cow(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+
+	/* Zero out the clone's ext -- must not affect original */
+	bpf_dynptr_write(&meta, 0, (void *)meta_zero, META_SIZE, 0);
+
+	clone_cow_done = true;
+	return TC_ACT_SHOT;
+}
+
+/* Verify COW isolation at kfree_skb time: once clone_cow_done is set,
+ * check that the original skb still has meta_want.
+ */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_cow_check, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!clone_cow_done)
+		return 0;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 0;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 0;
+
+	if (check_metadata(meta_have))
+		test_pass = true;
+
+	return 0;
+}
+
+/* Read skb_ext from tp_btf/kfree_skb -- tests survival until skb free */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_ext_read, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 0;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 0;
+	if (!check_metadata(meta_have))
+		return 0;
+
+	test_pass = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


