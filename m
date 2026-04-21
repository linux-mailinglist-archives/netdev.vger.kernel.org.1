Return-Path: <netdev+bounces-280265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLndOOT252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1D4400D8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DC2830A7D47
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C43A759B;
	Tue, 21 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPa0CWDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8753A6EF3
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809428; cv=none; b=YH2YZtOGljbFYIF5mwvc2N9xaViYYsfiWQF3/8mAme1r8F2y99f9tEdGu09GZzE9MUzdrlpdlrNGo+L1om9y6fjk7RdHUkkAkuZxOHx9sSxzpP4lACCLGe6eSwvhpEMKSGD4H2H0yRsEAgV+OobvSqT8lm3FxEFeq8V9abCeoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809428; c=relaxed/simple;
	bh=o72cBAvkomlz02FtjAM/uQMhr3e5Z35AgXo7SBCRXko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEfgFjFp/rriumUAE+46Xt9FlUecYimZ48XDusCEOlOtkbeWPFDnEmlxH66tGjKsRZNIqc98kR/QPDS6vCamB/acvcqjOoJ0Ap5PMu8e2cs4V8ougBjbcysB17iHPM8n86yz+/K3KLvSrgINOpmyEGQyv16oGf93QUOah6GkFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPa0CWDC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so26394695ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809427; x=1777414227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6GR+fTkq3Uedb8lJqPIpFLwpiwmbc1o8ZoLNraEbVw=;
        b=iPa0CWDCsRBUHbQwAsVhCB7ZJVnTKTv/rCciMba3YLCsMg5UGu/HFlAcW/SuwX0FsN
         V0P3uoxg190LY9n6OeyQLbJ/im68kxVyhLxkX5ie3qHeX/gfCVAkIJq/Gd7flLf7FNr+
         Shd8moJJisCt0/YGe5pNnNOSx0OMpvd7WrCDMrSnqHPIMYLLppH2C9/8WvpSRg6CauyY
         zi7YzGsZrkV5I6WZ8mJLY615n8/00gH2zbohW7O83v9WKlR4Q+HyzhB1u8n+iHNBs4pC
         2jWl0Abz3ldNpV1/bh73ZGRH/4IgSQqTyhQ/k/20f7itbeUbH05lHQQQMPlpxF7cbuUi
         7lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809427; x=1777414227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6GR+fTkq3Uedb8lJqPIpFLwpiwmbc1o8ZoLNraEbVw=;
        b=NIPOJLsQDV7WU+MfqzezPergHw5aWpelqS4ZTIWdPMPYFANwLIDSjYYORa6/Ilspnr
         D2ctRSZ92PiMKsMpBTY+D5WlwjGqsQ3983mvnb2JgCVf8pGmFxDzPJZpZurCM0k2wQ7h
         OlYh1O1/kPFMiEvQoB+ERKHBlP3BmJtJw15c5R9wVGZ2ktk0qKiQzKKyZlmT3szxt5nN
         A8vThEI5bQBtdut/YVM6OeCwH5vjPyMnWJFrfqCIXvcpU4acs/Ng7nLXp+vr/JX5pQ5i
         enHy4rTBkBfBRA7JEZj4JKMX8oaNqMTSxqN9/BuPSixl8+LTpn8qNjAzpb4aHt4B+EgX
         I7Sw==
X-Gm-Message-State: AOJu0Yx07doC7b7xku1G3h1l1rGW6guy7oQe78KHHAWhDpIICf9p33vb
	ZJRcotHxzDS9rzkaGumhvtcY5qJTI2JPy/2IDBgmYboIhXhliknsADRI
X-Gm-Gg: AeBDieugcseDksY/TpDqFvTHHk2DXEuXgmrQ+ejVGh8YgzfIIBGPqDBLBr/8Mou5iF7
	UYWzr3alRRrVknqhW5xfrHd9OF/lI4twkzlh+EDaAzh5HlrLv1EBh/O4WAy1Ya7F6PWDUaIlxk1
	n2W2CgvlBygKodw97fEv8kD+52+x0K7dG9Lw4uQsAwZGSNEkSpASN5zx0auT7rKXb1Uxht9NA1J
	3L9Kz5PpQPsvwc2tWq5oU7zv8sYdShrKKgEtNOkuBQNXeIM/bE06OCBrOiBG4hQYR3NuSCrN7Yj
	QU7Ag/rGKzEBAXd8fWn+hwyREC+TzGwwnl6SrwT3r4IwOOUzez6FES0vaJMj603muLj9HVVGee5
	MYXvOIS45y7nY77IZXlbYg+nuc8KweMUDTeUutIaZxYiD4DAzMJ5ju+gOQa+3jQT2zzJ6cqVQzs
	iz0VrPxcNMkfe90M+NBhLY2L68
X-Received: by 2002:a17:903:fa3:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2b5f9e5df98mr204879535ad.1.1776809426891;
        Tue, 21 Apr 2026 15:10:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm142158255ad.68.2026.04.21.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 8/9] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Tue, 21 Apr 2026 15:10:15 -0700
Message-ID: <20260421221016.2967924-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280265-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61D1D4400D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ..._qdisc_dynptr_use_after_invalidate_clone.c | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 65277c8fc887..77f1c0550c9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -229,6 +230,7 @@ void test_ns_bpf_qdisc(void)
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
+	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
new file mode 100644
index 000000000000..cca2accf081d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
@@ -0,0 +1,75 @@
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
+__success
+int BPF_PROG(dynptr_use_after_invalidate_clone, struct sk_buff *skb, struct Qdisc *sch,
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
+	.enqueue   = (void *)dynptr_use_after_invalidate_clone,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
+
-- 
2.52.0


