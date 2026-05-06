Return-Path: <netdev+bounces-284883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F3GG5NQ+2mSZQMAu9opvQ
	(envelope-from <netdev+bounces-284883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A44DC377
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9E453022BA9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3BB481AB2;
	Wed,  6 May 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol0ruqzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4A480DF8
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077654; cv=none; b=coMa7MWqrvPjRUhrl7hZaI+wNPnbUC0v00SeMaNVBJpTopFoVnTEuskejmyxKR6kwV5W66bhbNVf0Xi/zZTjZ/UdB9CJdYgC5tMbUacNzH15w9ErcpHiIHAi0UFmhhOWWNZ1KfKnfcWBpXeUf7ENaDrbpsvwv/jdnS/8WfvP0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077654; c=relaxed/simple;
	bh=jO5QKXIAM6PNo/nvV83Y9iBnQ9iO3saYkOlgfxs7aWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzpDNTz8VTxqVAbF2bldvVvIt6jN38cz8wdbC+DObFKYCxPmTxXsLDtDtKLRT20br21aoEMMeXChaKCLrI/UTHQPcXMSOnjRC+3meUUI+g2p9Uvi+Nz0l0FMn1RFuNO9MvdyJhdAn66leTcjjWdaWDDkYMVRVZhWUz7ZOS/LMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ol0ruqzO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef45a6d9dfso711182885a.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077649; x=1778682449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zraHj7RfOg9+EqIZWjiOOf7hlvWoRxLiS+I5CrsZ1s=;
        b=ol0ruqzO1Ak8z3KdFqoDVG9s/ZYfqSUvAGH8gp7jj9os82EjowWW5d+UDCggix8jES
         5Qm4upKvg5Sl+LgLubE0+h7F/89wSHkseoSvRukT+xk3nf0HoZwS7YPsIs741IUyCguT
         aYjPYbskhVGQNl2jPs8Dh36yFdiEDOh6QeZzqqicSpXRGlj1w9c3bRvi2Thavywjy7fQ
         hLOHwk8L62OhnRpTMczRJfoR9L1s5GNeUeOjd8xW2SirN0vGEfqiL9jqdrnGxnJ3PZqh
         kVKA07oVlNa7GXoCqH6TjGLKV1scs9AlgEwoftfURnPZ4IsT8kGCkPhva9tFGddi+aBq
         uSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077649; x=1778682449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4zraHj7RfOg9+EqIZWjiOOf7hlvWoRxLiS+I5CrsZ1s=;
        b=i0aHyVlyLB3eF5YoyvO+BcWmC6/eT5wZxzyfzHIX1AXqLHBRK0m5uJE1IYMQ7E/GHT
         AvddY3IJxMiBj7oVQDMRO4f7PJuMuk5RM7YoHfoNN4lbF28r6+VX0a4wYTYv9LGWdH3U
         xxWqEorQiutQ5iu9arwK97esXkqm0y8GO3OntE0W4L9Y7+Gg/Al8H7Gjq60vf2x0ItVS
         Hnuy5ZwtNXKQ3VRvK+yJ7mqK+tuFnJuzTHjJdTMtKzHGvreyAFKf7BaCVQMMJDeQtXTj
         lwKYxJSmgrXBhw8h1hCC9vxjbJqPnRefSrVV9KqTM5hyEXOWDWHzQSy/Dk3lj4ZgDRdI
         WJPw==
X-Gm-Message-State: AOJu0YwSgGtnKsOVaaQtM4R7Ea6z46HT19wTakYau9eH2rC7UafgbXHQ
	nbhzb9zRiv/mvZLrVhc/S2yjsFthPArUBPp3a6L2ws+kqZD6BQAiak6K
X-Gm-Gg: AeBDiesg5EFHDT6TFv/kVdfksDHW41E35+LNeNt8N7+UJQQc/txQc92jB+S1Df9VcwJ
	D0fYS4b4KRsoGyO6CwTeDBNiqFwi9V6W1xQ7X2hW0Z8WngKSgbAo+mitfEJa9V82hkzV8SZd/Zw
	LlWRjMStbDgMopyuhMX0TDjWquY1GiKxH6yRyPnQgVf+kcfacQXOuxr6wII1E5maC4hTtwZn7pZ
	fwR+U7g+yGkwQoJhvaFSOFqOW14n4JzmE1Vd8qPrsq9U5cTbqx29vhJ16wQclu4bCq6uU+Mg0l3
	b3LkNXXkMF9fMj0KCVuc+BAK1mti3VKF+wxMydc99uPNjFbTD9TWfuFH0LHfp6IuMpnC/vzUhc+
	ifzzV45SUzWdZ4m0JKFlSCyT5KuESJ5dLlmFRYb8+S3JE+LlNlSb2H7NjnJiIRgyW9WoCbW0eK9
	qEVbgAjd4y2fq6w9uykqDKo1CF4nw=
X-Received: by 2002:a05:6214:44a1:b0:8ac:b70c:8a9b with SMTP id 6a1803df08f44-8bc45942c05mr49044156d6.44.1778077648728;
        Wed, 06 May 2026 07:27:28 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:30::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5397be9ccsm181015696d6.19.2026.05.06.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/12] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Wed,  6 May 2026 07:27:06 -0700
Message-ID: <20260506142709.2298255-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A7A44DC377
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284883-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Make sure the verifier invalidates the dynptr and dynptr slice derived
from an skb after the skb is freed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  6 ++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 68 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 74 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 70 ++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..65277c8fc887 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -8,6 +8,9 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 #include "bpf_qdisc_fail__incompl_ops.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -223,6 +226,9 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
new file mode 100644
index 000000000000..1d96f7987a3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+__failure __msg("Expected an initialized dynptr as R1")
+int BPF_PROG(invalid_dynptr, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	proto = hdr->h_proto;
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)invalid_dynptr,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
new file mode 100644
index 000000000000..2e23b8593af9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+static __noinline int free_skb(struct sk_buff *skb)
+{
+	bpf_kfree_skb(skb);
+	return 0;
+}
+
+SEC("struct_ops")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_cross_frame, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	free_skb(skb);
+
+	proto = hdr->h_proto;
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)invalid_dynptr_cross_frame,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
new file mode 100644
index 000000000000..731216c4e45a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_slice, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	proto = hdr->h_proto;
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)invalid_dynptr_slice,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.52.0


