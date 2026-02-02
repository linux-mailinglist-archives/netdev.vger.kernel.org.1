Return-Path: <netdev+bounces-256018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IFoAB8cgWm0EAMAu9opvQ
	(envelope-from <netdev+bounces-256018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:50:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791EDD1D77
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF1933051CBC
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECDE314A64;
	Mon,  2 Feb 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeppS5uA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC173148CD
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068904; cv=none; b=LKsgDCxFtrlHa0yjywqFKvUk/uXfPJ9Nm1on2RunvM7XeNLymHBDJjysZSR323LkN0V83mE+9b5S0ONkZKEXQSZJv/3RFXkYjVVIAfo2mr51DLf2JtbECuqVgMY+VNTrByCRZTrCNpJhngXD1B3bioARb3NU60MGnKFP1QtPN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068904; c=relaxed/simple;
	bh=sRBNZON7oW9WvFwOdR9auvkrhzjheeJQcj/mDu/ihqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQaFkWgwli9EqjJeGKQDHYVs5MONUMVeecNriENp6Na/6H8XMT+kqPQ/Sp2SvYEo8y6rQxOzflv7lhfDTlwZQntld5cXbCmHy/AnqFhzBWD1LvTCyCNMuHvQs0UzmAF6fRVHZkKCacD8ienU/chuX+/R6o8QtcK57dZ10rHZMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeppS5uA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a8a7269547so47785715ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068902; x=1770673702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=YeppS5uAw3jhHpDKJknWloGd/eXhdD2AtVLcVCKVV91MOfPrYQNtHFNJi41CFhb5Sp
         STiiWqbUWTVVs1vz5EdA5V6OBrHhqv0IunHjByQiA0jO77HdPU4RVd8jzcSX1ejUjIOP
         2alfJ55sTgLIv6rumGwSG/4Et1BVRooWM/ZIU0TRrax003DsI+oXY5RXxlTY0uHBBzD9
         aHz+WgPr6cXPgTPLm3EGmiPfHCUn8gA/HyRyIaGhS4ry/fsC9pS2h3+0foUQjbLqscnN
         0aBOBsesJgWFoJ0DvYMzQMH1PDF4haE6E3HJk4MiwWqAK9gcelwx/3POl9tWiviRNSQa
         znpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068902; x=1770673702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=vpW9zffn437dEMAds8Tcre8tWw4LszwSG9R3fuubhKN4x1G8LLRiuyK6/me5L18sYW
         SaELQ2guKpE8NJnYW4WF0kDvzkvILACSU1MWMt8/AAWhnszPGkl/lynCMIHwHHohut8Z
         5eK9ZmdDp5Mcx4rIqGw0wsXjv8z93RtvgK8jhUqjvVxHT6JUc50GRy/unayOx3/lFUuO
         lecO8O1nqZly8V+UxfzMvW2S4em/gQQ3gxjVocz3B0U8k49QNPuSdWKU5oT6ps7RXDSe
         n5qPHcMWoGFI1e14Jtmw5MectTW0ryE8495NACezJDLcCFNKLfaPbm9iu6evkX7cqHwm
         pspQ==
X-Gm-Message-State: AOJu0YzkevSj6omgBSFOoJVIBUK6EVtjt02xSF2VaN7MURXvMli34lCy
	UM3zGXJ9RoOrFlVdGni8vaV4OjNKUqpWP0fa8DvZqo1yZ4O5X3QvvAWe
X-Gm-Gg: AZuq6aIIJffxXQ3zHdM9LR+uSVFhkxRLGJJZVi3Z95w+aXqmyr/XBfmQMOFTF+94Hgt
	xhuHK2Li47eCTSuRUZcoigElGVnmGk/Nu27/uyn+7Ojso4zdQ83iqfYojVkvsIRodLJRyeC/Gfb
	8fCFI0Mcl7UF7Ek81NgzBhzy3Rv94nSnfVLsFDNgGlMVdt/TNiW8qB9cYQgsOA7fkb7DQcESj3S
	DbZ1DaiY8uHiN1S8zB6L+pJBspt4fC3cnnodlF3+Z0FiTclGFU8pzyqMge9gGkoDpktXcoLCuC9
	szQ91rJCqZQYvfLQR/h02R5g+/LJJEnseagMNb3vaxRTWS1JFTZT38yoU/vk166J3XoqMkoi6pF
	R7Vvt/4y0wvecxAS22ZBTk+CTpowkkBPD314jXxvr+Vpx+4T5+RAzTP2pA9KmoatzO+QocWbwMY
	gchGCLj69LWFda
X-Received: by 2002:a17:903:8c6:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2a8d9931d2emr146281985ad.40.1770068901718;
        Mon, 02 Feb 2026 13:48:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8b47f4717sm147463335ad.18.2026.02.02.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:21 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 4/4] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Mon,  2 Feb 2026 13:48:17 -0800
Message-ID: <20260202214817.2853236-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
References: <20260202214817.2853236-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256018-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 791EDD1D77
X-Rspamd-Action: no action

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 14 ++++
 .../bpf/progs/bpf_qdisc_dynptr_clone.c        | 69 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index ec5b346138c5..ba14738c509b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -186,6 +187,17 @@ static void test_invalid_dynptr_cross_frame(void)
 		bpf_qdisc_fail__invalid_dynptr_cross_frame__destroy(skel);
 }
 
+static void test_dynptr_clone(void)
+{
+	struct bpf_qdisc_dynptr_clone *skel;
+
+	skel = bpf_qdisc_dynptr_clone__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_qdisc_dynptr_clone__open_and_load"))
+		return;
+
+	bpf_qdisc_dynptr_clone__destroy(skel);
+}
+
 static int get_default_qdisc(char *qdisc_name)
 {
 	FILE *f;
@@ -259,6 +271,8 @@ void test_ns_bpf_qdisc(void)
 		test_invalid_dynptr_slice();
 	if (test__start_subtest("invalid_dynptr_cross_frame"))
 		test_invalid_dynptr_cross_frame();
+	if (test__start_subtest("dynptr_clone"))
+		test_dynptr_clone();
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c
new file mode 100644
index 000000000000..f23581e19da1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr, ptr_clone;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &ptr_clone);
+
+	hdr = bpf_dynptr_slice(&ptr_clone, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	*(int *)&ptr = 0;
+
+	proto = hdr->h_proto;
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)bpf_qdisc_test_enqueue,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
+
-- 
2.47.3


