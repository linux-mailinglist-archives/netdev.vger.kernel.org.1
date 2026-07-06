Return-Path: <netdev+bounces-304939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jtw5GaGHS2okUwEAu9opvQ
	(envelope-from <netdev+bounces-304939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:46:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C368770F725
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:46:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h5NuMX8R;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304939-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304939-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0EB13027DA3
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1F143C7B4;
	Mon,  6 Jul 2026 09:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9143B6DB
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330552; cv=none; b=EIgZLPlAqv8S/5ropqZYEnDb/SX6hwPofD+O27CBGZ7R2uja6CLEsjxII+m66bQpwzhy+BOzYy9v1gfL5tgnP3KtlDkxWEwmHejiR3n7N0MHuJGmTYtlZyoHDSA712GTfYI1QLN73sESAlJcdyjorq2ZwwI+QSN3K9MHopUpt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330552; c=relaxed/simple;
	bh=XfNrypmuBMSHhelOYnrwXTVhWErDX5uLjd7qFzom3QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMsBLj6qdvYN8fSLc3Laxzb7iVPR7jPf0HXzOFPjSyTq4coB4Src4NjBwIIj6JnMSnAo6iEftAdTPuxWVqO7vNNHR0bEazWOoXq1yFCgABe5oe5jIf4oNT7me58iqaSs0Ae+NX6xNXL4p9/omyeJpM40lGanc38nYzo7XW4NwSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5NuMX8R; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-470174001a0so1352929f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330545; x=1783935345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLMlNoR+vLs2pg7PpRikYiE5J8mE4fMgaMGZcRJFNx8=;
        b=h5NuMX8RSK9IBFHqrMe/D7qGpSqTV21H4MD/mVIJRdMulpRGaVa0cz1t/AXuY31Gqi
         RsE+qLKjqDV+Jud3C6YUMEpAtrEC5qBGHjKdO+obCxDpKGkdOOfi5ukw/XRqWSrCDFzL
         tvmGVkaEUgSI8RSeFiMK3KgrSWOYbqKSSl6TA1AyTTbacdwTzm4JnZAGDjYUt+Y2p7qf
         MI6PylHANjzmRIGHxE1ktOCymtnkyTgA+C8MnLJkoZZgaPej69n+t0YuZiwTLp5b5cWQ
         VTkOj4vOey23L6XHKtNBbZAoJQe24XqoIA6J4gTOtO4F1u06tnlFHgWcVNYj+iOOwA1+
         d56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330545; x=1783935345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLMlNoR+vLs2pg7PpRikYiE5J8mE4fMgaMGZcRJFNx8=;
        b=kk0aVnOZ+MZVY4LX64UXUdUr/wFqTheFkC8RjnfFdrA22c/tNc/Ebf/gKOE9wiG854
         VvuMgZCOtx/oEoEWIsMshU8O6lIXU4bdJs9NHmmGFLPyeATW3lA8nLSWoxwzuWVbQCBo
         P/CWwbg61tw3AvtE5yMtSCKqYUc1UwqxLcVwFAy2ehoNvYRy+ooJpXwVa7+0Rlgn0eBl
         FneVpb431EYOAZp6WHUMHThxFoRwGuMEAxRaZ5Vkw9ZDfmKyc9VCRaWiJue73O4pkk6x
         ARMQItR9ghx6a5eQwkl2Zd9lP6C62Zvo5V8T5JEsyz9E5vjkZm7u3bpU/bFNOE/CdG3y
         3QcA==
X-Forwarded-Encrypted: i=1; AHgh+RpCyPduAWFQs+wuYbwnFiWxzF3DZBVDqyyxpf+tYR7ZabdpBS5ebRO9mIgTx8CUJAMaQRNvVzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgUXfHdZ0N3LntY7SsS/ZJqJ7jyGI2Dq+IBQFSd2YgM2+59ty
	MjK8WvCKoLJFbLcwbBhApHbNHCTpQri1FPMxtXvWpghWxAULqfZwujW7
X-Gm-Gg: AfdE7ckt0YvT0c40h59QYCBy1Ve2axboV+1pUe7cG6jiA0ez5Rm6wkr6iNjvmqm4GJ7
	04YxB2GtBhny5tD3Pj0DOtvGg1Uw7KHLb3OvdK0lMnAkhB463/1w5rQ4TRbPqqjzLlNlsfg9lNw
	N2d3kqtX+LOM5nrQ6uxtJhxmhxEgQuSQ1DvlSBBZTJQlfR7BbmeQ90pbHN1+3ZZqth3FtzVft6R
	KjR87NmyhBBFHLh471Vyqoh6xwr56zHdhwQtE1lLD7Au1sxeKNdIlMA3kk9JoN6VYJXZGgnnWjp
	wfk0bYljMaAGs3cT10SPU+ZDCTMddHOdzHCbgj9axzQYK7O1FQ4pACWw8bN1c3vy35VO19p4Ppu
	UBWLZFZo7zDNH9Bu46s9gxathm8O7v+jpX1vmgYEAx6atA8OstS6ueqBZTKNjZATRxPf/fPlBtS
	gJTRMP6Jz4Q4fsHwhK
X-Received: by 2002:a05:6000:70c:b0:475:f0f0:9ecb with SMTP id ffacd0b85a97d-47aad54b70amr10859613f8f.54.1783330544298;
        Mon, 06 Jul 2026 02:35:44 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:43 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
Date: Mon,  6 Jul 2026 09:35:22 +0000
Message-Id: <20260706093525.13030-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304939-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahe.tardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,create_opts.family:url,addr_opts.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C368770F725

Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
bpf setup program creates a ksock context and connect the socket.
Another syscall bpf program lookup the context and send test data.
The userspace harness create a network namespace and a new socket on
loopback, run the setup and send syscall bpf progs then check that the
userspace socket received the data from bpf.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 165 ++++++++++++++++++
 .../testing/selftests/bpf/progs/ksock_basic.c |  68 ++++++++
 .../selftests/bpf/progs/ksock_common.h        |  73 ++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
new file mode 100644
index 000000000000..085ddb59067e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <arpa/inet.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "ksock_basic.skel.h"
+
+#define NS_TEST "ksock_basic_ns"
+#define LOOPBACK_IP "127.0.0.1"
+#define RECV_PORT 7777
+#define RECV_TIMEOUT_SEC 5
+
+struct ksock_test_env {
+	const char *netns;
+	bool netns_created;
+	struct nstoken *nstoken;
+	struct sockaddr_in addr;
+	int rfd;
+	char buf[32];
+};
+
+static bool ksock_test_env_setup(struct ksock_test_env *env, const char *netns)
+{
+	struct timeval tv;
+	int err;
+
+	memset(env, 0, sizeof(*env));
+	env->netns = netns;
+	env->rfd = -1;
+
+	SYS(fail, "ip netns add %s", netns);
+	env->netns_created = true;
+	SYS(fail, "ip -net %s link set lo up", netns);
+
+	env->nstoken = open_netns(netns);
+	if (!ASSERT_OK_PTR(env->nstoken, "open_netns"))
+		goto fail;
+
+	env->rfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(env->rfd, "receiver socket"))
+		goto fail;
+
+	env->addr.sin_family = AF_INET;
+	env->addr.sin_addr.s_addr = inet_addr(LOOPBACK_IP);
+	env->addr.sin_port = htons(RECV_PORT);
+
+	err = bind(env->rfd, (struct sockaddr *)&env->addr, sizeof(env->addr));
+	if (!ASSERT_OK(err, "bind receiver"))
+		goto fail;
+
+	tv.tv_sec = RECV_TIMEOUT_SEC;
+	tv.tv_usec = 0;
+	err = setsockopt(env->rfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (!ASSERT_OK(err, "set rcvtimeo"))
+		goto fail;
+
+	return true;
+
+fail:
+	if (env->rfd >= 0) {
+		close(env->rfd);
+		env->rfd = -1;
+	}
+	if (env->nstoken) {
+		close_netns(env->nstoken);
+		env->nstoken = NULL;
+	}
+	if (env->netns_created) {
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", netns);
+		env->netns_created = false;
+	}
+	return false;
+}
+
+static void ksock_test_env_cleanup(struct ksock_test_env *env)
+{
+	if (env->rfd >= 0)
+		close(env->rfd);
+	if (env->nstoken)
+		close_netns(env->nstoken);
+	if (env->netns_created) {
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", env->netns);
+		env->netns_created = false;
+	}
+}
+
+static void ksock_assert_recv(struct ksock_test_env *env, const char *data,
+			      size_t data_sz)
+{
+	ssize_t n;
+
+	memset(env->buf, 0, sizeof(env->buf));
+	n = recvfrom(env->rfd, env->buf, sizeof(env->buf), 0, NULL, NULL);
+	if (!ASSERT_EQ(n, data_sz, "recvfrom len"))
+		return;
+	ASSERT_MEMEQ(env->buf, data, data_sz, "payload match");
+}
+
+static bool ksock_setup_ctx(struct ksock_basic *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err, pfd;
+
+	skel->bss->ipv4_remote = inet_addr(LOOPBACK_IP);
+	skel->bss->remote_port = RECV_PORT;
+
+	pfd = bpf_program__fd(skel->progs.ksock_setup);
+	if (!ASSERT_OK_FD(pfd, "ksock_setup fd"))
+		return false;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "ksock_setup run"))
+		return false;
+	if (!ASSERT_OK(opts.retval, "ksock_setup retval"))
+		return false;
+
+	return true;
+}
+
+void test_ksock_basic(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_test_env env;
+	struct ksock_basic *skel;
+	int err, pfd;
+
+	skel = ksock_basic__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	err = ksock_basic__load(skel);
+	if (!ASSERT_OK(err, "skel load")) {
+		ksock_basic__destroy(skel);
+		return;
+	}
+
+	if (!ksock_test_env_setup(&env, NS_TEST))
+		goto fail;
+
+	/* Step 1: Run the setup SYSCALL prog to create ksock */
+	if (!ksock_setup_ctx(skel))
+		goto fail;
+
+	/* Step 2: Run the send SYSCALL prog */
+	pfd = bpf_program__fd(skel->progs.ksock_send);
+	if (!ASSERT_OK_FD(pfd, "ksock_send fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "ksock_send run"))
+		goto fail;
+	if (!ASSERT_EQ(opts.retval,
+		       sizeof(skel->data->send_data), "sendmsg bytes"))
+		goto fail;
+
+	/* Step 3: Receive and verify the data */
+	ksock_assert_recv(&env, skel->data->send_data,
+			  sizeof(skel->data->send_data));
+
+fail:
+	ksock_test_env_cleanup(&env);
+	ksock_basic__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_basic.c b/tools/testing/selftests/bpf/progs/ksock_basic.c
new file mode 100644
index 000000000000..e8131932d97b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_basic.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+__be32 ipv4_remote;
+__u16 remote_port;
+
+char send_data[32] = "hello from bpf ksock";
+
+SEC("syscall")
+int ksock_setup(void *ctx)
+{
+	struct bpf_ksock_create_opts create_opts = {};
+	struct bpf_ksock_addr_opts addr_opts = {};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	create_opts.family = AF_INET;
+	create_opts.type = SOCK_DGRAM;
+	create_opts.protocol = IPPROTO_UDP;
+
+	ks = bpf_ksock_create(&create_opts, sizeof(create_opts), &err);
+	if (!ks)
+		return err;
+
+	addr_opts.family = AF_INET;
+	addr_opts.port = remote_port;
+	addr_opts.ipv4_addr = ipv4_remote;
+
+	err = bpf_ksock_connect(ks, &addr_opts, sizeof(addr_opts));
+	if (err) {
+		bpf_ksock_release(ks);
+		return err;
+	}
+
+	err = ksock_ctx_insert(ks);
+	if (err && err != -EEXIST)
+		return err;
+	return 0;
+}
+
+SEC("syscall")
+int ksock_send(void *ctx)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+	int send = -1;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return -ENOENT;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return -ENOENT;
+
+	send = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+	return send;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
new file mode 100644
index 000000000000..87d92372d28d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _KSOCK_COMMON_H
+#define _KSOCK_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+#define SOCK_STREAM	1
+#define SOCK_DGRAM	2
+#define IPPROTO_TCP	6
+#define IPPROTO_UDP	17
+
+struct bpf_ksock *bpf_ksock_create(const struct bpf_ksock_create_opts *opts,
+				   u32 opts__sz, int *err__uninit) __ksym;
+int bpf_ksock_bind(struct bpf_ksock *ks,
+		   const struct bpf_ksock_addr_opts *opts, u32 opts__sz) __ksym;
+int bpf_ksock_connect(struct bpf_ksock *ks,
+		      const struct bpf_ksock_addr_opts *opts, u32 opts__sz) __ksym;
+struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
+void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
+int bpf_ksock_send(struct bpf_ksock *ks,
+		   const void *data, u32 data__sz) __ksym;
+
+struct __ksock_ctx_value {
+	struct bpf_ksock __kptr * ctx;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __ksock_ctx_value);
+	__uint(max_entries, 1);
+} __ksock_ctx_map SEC(".maps");
+
+static inline struct __ksock_ctx_value *ksock_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__ksock_ctx_map, &key);
+}
+
+static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
+{
+	struct __ksock_ctx_value local, *v;
+	struct bpf_ksock *old;
+	u32 key = 0;
+	int err;
+
+	local.ctx = NULL;
+	err = bpf_map_update_elem(&__ksock_ctx_map, &key, &local, 0);
+	if (err) {
+		bpf_ksock_release(ctx);
+		return err;
+	}
+
+	v = bpf_map_lookup_elem(&__ksock_ctx_map, &key);
+	if (!v) {
+		bpf_ksock_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_ksock_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _KSOCK_COMMON_H */
--
2.34.1


