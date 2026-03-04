Return-Path: <netdev+bounces-263609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEsoIrfTp2nEkAAAu9opvQ
	(envelope-from <netdev+bounces-263609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:39:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5CE1FB3DD
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91DC6303A940
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C1381AEA;
	Wed,  4 Mar 2026 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W555oO6o"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697737F743;
	Wed,  4 Mar 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606386; cv=none; b=lOSAL70PXXIXk7e35pNyJ7l4Z45XEX6dMmyNvSOChfZqPYL/V0djja3dxWTrMfuLr8yCSiRnpSGl/wkpxjC472jlq12K73LjAP1RBp7Jf/Y9RKfOcyVRIa7dGYwpmSLswVR/kTmFN2d4l+N6DLK85Ql/UgTcGaP52/nb9AeyVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606386; c=relaxed/simple;
	bh=6EK4kevhLvn8MwpRl+sYXsC6m0CP/64/dLc/zPKgHGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umoFvw4zqlPMpoVssduSleUUMptORryspeByu1A/kgz7424iF/IzrzLlRD68Zx4fT6Cqieh7yJ9PveZCesoofo2IDFjALko36+tyYszi0ql+cdeEzpksSgRQtifI8kQ0NcVGQwLJJPfX30Mt3MfQCivg/s2srJmQ698F8gmzJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W555oO6o; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+aNyjWwHYPmClz3BrgloLW8wipTLTFpy6aXnO+owLw=;
	b=W555oO6oGOGBLdPzbE4pSIegHFAu7S8ANwX9rU83zXyQQxmJ0ZPq80VTgxJzbbBoNnW2ar
	uF38wV//9YODNivW03OXFThuyYoiSmEwRdMB5SlZNoQBADbPWoKgpHRG51cCdd5C9KxJus
	FR4MfYGdWl5p2JPddgMamDnU31ojWew=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 6/7] selftests/bpf: add splice_read tests for sockmap
Date: Wed,  4 Mar 2026 14:33:57 +0800
Message-ID: <20260304063643.14581-7-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2E5CE1FB3DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add splice_read coverage to sockmap_basic and sockmap_strp selftests.
Each test suite now runs twice: once with normal recv_timeout() and
once with splice-based reads, verifying that data read via splice(2)
through a pipe produces identical results.

A recv_timeout_with_splice() helper is added to sockmap_helpers.h
that creates a temporary pipe, splices data from the socket into
the pipe, then reads from the pipe into the user buffer. MSG_PEEK
calls fall back to native recv since splice does not support peek.
Non-TCP sockets also fall back to native recv.

The splice subtests are distinguished by appending " splice" to
each subtest name via a test__start_subtest macro override.

./test_progs -a sockmap_*
...
Summary: 5/830 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 28 ++++++++-
 .../bpf/prog_tests/sockmap_helpers.h          | 62 +++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 28 ++++++++-
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index dd3c757859f6..ea0b49ec9a93 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -18,6 +18,23 @@
 
 #include "sockmap_helpers.h"
 
+static bool use_splice;
+
+static bool __start_subtest(const char *name)
+{
+	if (!use_splice)
+		return (test__start_subtest)(name);
+
+	char buf[MAX_TEST_NAME];
+
+	snprintf(buf, sizeof(buf), "%s splice", name);
+	return (test__start_subtest)(buf);
+}
+
+#define test__start_subtest(name) __start_subtest(name)
+#define recv_timeout(fd, buf, len, flags, timeout) \
+	recv_timeout_with_splice(fd, buf, len, flags, timeout, use_splice)
+
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
 #define TCP_REPAIR_ON		1
@@ -1314,7 +1331,7 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
-void test_sockmap_basic(void)
+static void __test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
 		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
@@ -1391,3 +1408,12 @@ void test_sockmap_basic(void)
 	if (test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
 }
+
+void test_sockmap_basic(void)
+{
+	use_splice = false;
+	__test_sockmap_basic();
+
+	use_splice = true;
+	__test_sockmap_basic();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index d815efac52fd..1f0da657243f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -80,4 +80,66 @@ static inline int add_to_sockmap(int mapfd, int fd1, int fd2)
 	return xbpf_map_update_elem(mapfd, &u32(1), &u64(fd2), BPF_NOEXIST);
 }
 
+static inline ssize_t recv_timeout_with_splice(int fd, void *buf, size_t len,
+					       int flags,
+					       unsigned int timeout_sec,
+					       bool do_splice)
+{
+	ssize_t total = 0;
+	int pipefd[2];
+	int fl;
+
+	int sotype, protocol;
+	socklen_t optlen = sizeof(sotype);
+
+	if (!do_splice || (flags & MSG_PEEK) ||
+	    getsockopt(fd, SOL_SOCKET, SO_TYPE, &sotype, &optlen) ||
+	    sotype != SOCK_STREAM ||
+	    getsockopt(fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen) ||
+	    protocol != IPPROTO_TCP)
+		return recv_timeout(fd, buf, len, flags, timeout_sec);
+
+	if (poll_read(fd, timeout_sec))
+		return -1;
+
+	if (pipe(pipefd) < 0)
+		return -1;
+
+	/*
+	 * tcp_splice_read() only checks sock->file->f_flags for
+	 * O_NONBLOCK, ignoring SPLICE_F_NONBLOCK for the socket
+	 * side timeout. Set O_NONBLOCK on the fd so the loop won't
+	 * block forever when no more data is available.
+	 */
+	fl = fcntl(fd, F_GETFL);
+	fcntl(fd, F_SETFL, fl | O_NONBLOCK);
+
+	/*
+	 * Pipe has limited buffer slots (default 16), so a single
+	 * splice may not transfer all requested bytes. Loop until
+	 * we've read enough or no more data is available.
+	 */
+	while (total < (ssize_t)len) {
+		ssize_t spliced, n;
+
+		spliced = splice(fd, NULL, pipefd[1], NULL, len - total,
+				 SPLICE_F_NONBLOCK);
+		if (spliced <= 0)
+			break;
+
+		n = read(pipefd[0], buf + total, spliced);
+		if (n <= 0)
+			break;
+
+		total += n;
+	}
+
+	fcntl(fd, F_SETFL, fl);
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+
+	return total > 0 ? total : -1;
+}
+
 #endif // __SOCKMAP_HELPERS__
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 621b3b71888e..2226399eee0d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -6,6 +6,23 @@
 #include "test_skmsg_load_helpers.skel.h"
 #include "test_sockmap_strp.skel.h"
 
+static bool use_splice;
+
+static bool __start_subtest(const char *name)
+{
+	if (!use_splice)
+		return (test__start_subtest)(name);
+
+	char buf[MAX_TEST_NAME];
+
+	snprintf(buf, sizeof(buf), "%s splice", name);
+	return (test__start_subtest)(buf);
+}
+
+#define test__start_subtest(name) __start_subtest(name)
+#define recv_timeout(fd, buf, len, flags, timeout) \
+	recv_timeout_with_splice(fd, buf, len, flags, timeout, use_splice)
+
 #define STRP_PKT_HEAD_LEN 4
 #define STRP_PKT_BODY_LEN 6
 #define STRP_PKT_FULL_LEN (STRP_PKT_HEAD_LEN + STRP_PKT_BODY_LEN)
@@ -431,7 +448,7 @@ static void test_sockmap_strp_verdict(int family, int sotype)
 	test_sockmap_strp__destroy(strp);
 }
 
-void test_sockmap_strp(void)
+static void __test_sockmap_strp(void)
 {
 	if (test__start_subtest("sockmap strp tcp pass"))
 		test_sockmap_strp_pass(AF_INET, SOCK_STREAM, false);
@@ -452,3 +469,12 @@ void test_sockmap_strp(void)
 	if (test__start_subtest("sockmap strp tcp dispatch"))
 		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
 }
+
+void test_sockmap_strp(void)
+{
+	use_splice = false;
+	__test_sockmap_strp();
+
+	use_splice = true;
+	__test_sockmap_strp();
+}
-- 
2.43.0


