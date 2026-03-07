Return-Path: <netdev+bounces-265103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHFOBfvKq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:51:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2122A819
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE0F530288C0
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E6387587;
	Sat,  7 Mar 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2BoyeEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F1387564
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865893; cv=none; b=j1U5hbVJ1TEBvIm83IHZHoFpO40+VE+/fyw9UR43TAN4HAFWCYGGAzjXaJVQLEv18tDIOy6s93/Okw4KFD012OX3qwFdSoLpHTGvtxnCysPy/v0gdg07I36xlum21/YVgeNE627/aHFeytCXT+SyfUPwZuaTdXYHtWIITkasQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865893; c=relaxed/simple;
	bh=sRBNZON7oW9WvFwOdR9auvkrhzjheeJQcj/mDu/ihqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxGvMcJIugp9d0teZCg3Te+AzUdAYyJRj30BxD5BMXJkkVlIEc4ssuFwCrn0C4tpr6VlXDGYX3guLIWitC05Gi3Y9iTJbXHyjrh8ntI6iDHBbdfl5rzMJm3Uexb4u4sRflh7wfTRzbyNKOA3eGNrqlINuKBJatyRJ9Om6f76Ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2BoyeEh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c738b98bfd9so1280882a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865892; x=1773470692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=b2BoyeEhv30iw/NQeg6eaiMy5WD7tokLTzK5c+EETZfmJmy3hiIki03BdXzjfa/WZ2
         ZkFuU96TomQP3+hqGMEA0C5yNq1Q8EQg9+Bfl2vCmstR8cd7nmdkB9vKEtHcnM3jl0HZ
         eqNUarN/Afv5aHA0JAOhaG/dXVcTL4+zQarGXEyKlhe+SmNl1hqJtFF5VzdnnX4eVsP9
         /+Imu5H2FCP3UANli42QLxejB8+9tT2vtSUAlA3hf8P5OPrHcmPnr5w0wiG1jQdBJTx/
         8r8i0omfYIMoI9FyAYb0p6PEVa2umxuKyewf9Wi9OwrBfbo3nt8a4enjYS6976ytIbbU
         xBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865892; x=1773470692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=FUkrI+73MksLokeO0nhX/cl9fpbLsqI/REX60zVK+UCp7U782FkFpieNFYo1ypE3Ab
         TMbZ4wQ3nYsWIruUJXHJoASVljWgXZfJlS9nSYe2A0IQbJwY53uSPheTbEDVUBCj0eCy
         mYpjY8xqCYok/DxhKK+dIfUDsZsytxoYOPqAGp8xMa16fyyqMjBdOSqor95aydj6LVWC
         WSQnLp3qUVg7gqop/WcTVqG5BgdSmnuyBPEwLBwOtoxXlZJ5g+TUJ//l8PkiJ0qlAQk8
         I+x7HBXOr3pVPkgjSeiVx1FVumS/BxPBctePXPQ8/FHc3qfwcjuuXSWLHasBkyGr3bSR
         NxCw==
X-Gm-Message-State: AOJu0Yyy+h3zNiqFUo4ARgIH3xDgkQNZt+ico/XGc+4KLnNXyhjAm0Vg
	i4+sNROoE9CEDTi9wvzagp/BMa6iDzcHCqNeqiGuBls0IQcJMKzeUTgn
X-Gm-Gg: ATEYQzxwGKY2Tbln10ybcLtGGKASX0obAL3X5ADOJ13VAdSJvPutPchw/yY4NHqa7d/
	8n9i8XBgXW09df9b6z3wbjlnG2S4/lu9hTiXOxPi5TiWUAgBCgo6578COkJ/2Hj+761ylLRLgo8
	AMDFLqQos+H9Y3RGgZ+XxV0sk8ppUt+EKS/C49G4T/XdWZjOCXp5bDW2mNQXBE/pljPgAClO7I0
	BaJxLECmHx8/YwIYfNKAsv4BKKYQF/wVNz1WnZszJA3IM3pBIxtoOTFsueUwy0zJxnjGXzkr1NI
	wteMlYqt1721Xg8zhPyn2M+BU4fiBl5hoj/KBYH3OY93q3UcM6MbhH1nLJTS7xYEiSlpg1kXqs5
	fALbWWQDiwYTNyWtMwNSwBWJYuEPVeo/Mv0/tbFwCC0CauQL8CNYlAmJf8HTBXPtOP/86hZODtU
	M2EwF/Gv99c7pINQ==
X-Received: by 2002:a17:903:320b:b0:2ae:456d:b843 with SMTP id d9443c01a7336-2ae824914demr56158905ad.48.1772865891698;
        Fri, 06 Mar 2026 22:44:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f770ffsm54938275ad.45.2026.03.06.22.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:51 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 10/11] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Fri,  6 Mar 2026 22:44:38 -0800
Message-ID: <20260307064439.3247440-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BF2122A819
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265103-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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


