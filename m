Return-Path: <netdev+bounces-298658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ock+EAUHLGqMJwQAu9opvQ
	(envelope-from <netdev+bounces-298658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB42679B36
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=WotCd8T6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298658-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E783223995
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE853E95BD;
	Fri, 12 Jun 2026 13:11:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7838F233
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:11:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269907; cv=none; b=o9sqWPEXAwERybySMaeaphg2IOrqlDEd2FP/EzE5ZWfml9hKh5K+3pfkPDxZq7Tr9s8EPFTTu8ASE2wtLP8NqzbnqD6R8ESxP8kFePD3LcG94TA8wiauDulP7CgDGAezVaSwe7Ill0lX5lj+YoTHSmmqbk8r8wccXyAHOt1kcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269907; c=relaxed/simple;
	bh=KCraM+EOKKtEb873qQFCwAKytsR15+WPPZ/s6qIBlbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJr1oL9iK4bLd7cYkf/oSVDoQbkB0HWBDc/ZXv4xmIOI4Z5qpnotAlzqcEkNn8hWQ2Xngp5+mFxHk7SWgp8jpmtlQ9K8VbQNnv1u0KZW7WT9GDGtLKTC8rS9/gunWLpVqoooP8UskvgRnESk4lxnW3Z1X+8cJS2Arl4bZwHXqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WotCd8T6; arc=none smtp.client-ip=91.218.175.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781269904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oh5du0PbUOJ2GCFr1/FdoSkmCPgoB9UDf0M/aVUSOIg=;
	b=WotCd8T6xhakfQS10jEkOBFsEtnhX0jhGy/njNitf+TPhmjVoN5W+tsO8IQcvS3SJh7KlB
	+dGlnwkO3/5PXldwWe0uIYgCX8wqRBxuD4wRvih6PPJjdIKuJ4k/DeaRKueV/Rc+uc9D2v
	XR6875vUTWJi9EUtCWbzlnxU4HWJb+M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Sechang Lim <rhkrqnwk98@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: add test for bpf_msg_pop_data() overflow
Date: Fri, 12 Jun 2026 21:07:51 +0800
Message-ID: <20260612130919.299124-8-jiayuan.chen@linux.dev>
In-Reply-To: <20260612130919.299124-1-jiayuan.chen@linux.dev>
References: <20260612130919.299124-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:rhkrqnwk98@gmail.com,m:jiayuan.chen@linux.dev,m:emil@etsalapatis.com,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,etsalapatis.com,iogearbox.net,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEB42679B36

From: Sechang Lim <rhkrqnwk98@gmail.com>

Add a test in sockmap_basic.c that calls bpf_msg_pop_data() with a length
close to U32_MAX, which overflows the start + len bounds check. The sk_msg
program records the return value over a sendmsg and the test checks that
the call is rejected with -EINVAL.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index d2846579285f2..cb3229711f93a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -14,6 +14,7 @@
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
 #include "test_sockmap_change_tail.skel.h"
+#include "test_sockmap_msg_pop_data.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -666,6 +667,51 @@ static void test_sockmap_skb_verdict_change_tail(void)
 	test_sockmap_change_tail__destroy(skel);
 }
 
+static void test_sockmap_msg_verdict_pop_data(void)
+{
+	struct test_sockmap_msg_pop_data *skel;
+	int err, map, verdict;
+	int c1 = -1, p1 = -1, sent;
+	int zero = 0;
+	char *buf;
+	const size_t len = 32 * 1024;
+
+	skel = test_sockmap_msg_pop_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_msg_pop_data);
+	map = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out_close;
+
+	buf = calloc(len, 1);
+	if (!ASSERT_OK_PTR(buf, "calloc"))
+		goto out_close;
+
+	sent = xsend(c1, buf, len, 0);
+	ASSERT_EQ(sent, (ssize_t)len, "xsend");
+	ASSERT_EQ(skel->data->pop_data_ret, -EINVAL, "pop_data_rejects overflow");
+
+	free(buf);
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_msg_pop_data__destroy(skel);
+}
+
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
 	int err, c1, p1, zero = 0, sent, recvd, avail;
@@ -1373,6 +1419,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict change tail"))
 		test_sockmap_skb_verdict_change_tail();
+	if (test__start_subtest("sockmap msg_verdict pop_data overflow"))
+		test_sockmap_msg_verdict_pop_data();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
new file mode 100644
index 0000000000000..301e65b95256c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+#define POP_START 0x48a3
+#define POP_LEN   0xfffffffd
+
+long pop_data_ret = 1;
+
+SEC("sk_msg")
+int prog_msg_pop_data(struct sk_msg_md *msg)
+{
+	if (msg->size <= POP_START)
+		return SK_PASS;
+
+	pop_data_ret = bpf_msg_pop_data(msg, POP_START, POP_LEN, 0);
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


