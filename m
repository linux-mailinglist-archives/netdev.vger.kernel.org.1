Return-Path: <netdev+bounces-265102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAaiByLLq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:52:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1622A83E
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 581E93047DEC
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2C38756C;
	Sat,  7 Mar 2026 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfKPoTDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA1377ED6
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865892; cv=none; b=uwLu47Mr+MHRzkIDvTrcB00syOGLKyNKzzZbJOrbBZ6zKE8c1OVCMhPsAKMp3RFCPT5u5WrUFhySeoEXPk+87qYCIAJOlNAUtBUIXbrPheHmHDZUHn/H8pbCz4LG3XCDZUp6/vxFmgZTFfaJAL4uYvgFnE8N66/+LA7t/9RCo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865892; c=relaxed/simple;
	bh=zuuLkMVe7SZA3iVK1lFQ85Qdn04qV/iB4YX77NjzDew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnP07Rzwmrhyr1IdfxRudOsDXoRt4miNfHXAlp9lHB4txtd92R0QHX9L3zyBaiqKPs2BpmcRWfkkskuG4a3Sbxnrd+4EZ3DFVZdmSctieS2leVAshqmLh/jPJHSvArF+nOThVAgwF6hiO5CRW8CEdu2h9PnqWVBJnAbh5UmZxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfKPoTDc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad21f437eeso71566325ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865891; x=1773470691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrFe5Hs5AFhr9NmcFMmLTsMPxRNuGf96D5IxwXuuxe8=;
        b=FfKPoTDcJhcs8dC7z0M0kdKGF3K2MGA9wyeB8dNpcZlEu3YnzuUhDcHFUEQrrZLwqV
         asCMm4rgNEGMzkKnlwVKUhO58q66BFbox1y6rXYQbyQRNtYwDNCSSca5wowO03Am6fHA
         XMLn6bv6Xg6ZHmz582HVTAi+cXwNWAKVgVGaYl5m/8hu9Z2EqoJP8ZwCoiUS3Jg0kgN5
         YxrO3TJnAGn6L092oqANZ1JGSZwqlt6sEwfsLxJxHLTdOdXh7/ByJ1HtvL97vZNySX4E
         lJG72U3LKLcjlNNz0naq2VZJPBm0Cocx+d4N4z5Rd6YG24HjgCx16De/dfdYApJAoFq9
         I7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865891; x=1773470691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrFe5Hs5AFhr9NmcFMmLTsMPxRNuGf96D5IxwXuuxe8=;
        b=wbLZKMwy6geVzqa3KhRqu6aY6zDtDe+8PtM1SzueDz6C0WhllHVSCbBDftxWfJH33Y
         wGvfG4H8Ua23Zokx7KhMH8WX53i1IEitY8tdtmLtjPhzQunTbuU7DwNoLFAr6FdRexJM
         88VJux/Y8AnIroo50HlPYbtACux1fznuQ4SMTmsnrpnx8X8+0q8dV/75ITLSTpaz4ene
         VWNNhf0YE5f+V6z6J8ovYSAssQR23DM22IXFFdpA71nwHBk6lMm+w5HdlWyV5UL3snMo
         hukgGQIfyp56xVl4PCFsinJfLqNppWiF1jonwJXJb+HTvmo4V/slyKrKVSd8zNGefDVk
         H4kw==
X-Gm-Message-State: AOJu0Yy+LGOt6XJlweECIDUPSFbV2AB22xotpaAKIJwOHJLt/iZfVs0i
	qeGMd8RJQI8Zg4WzU+E78GACtaC/x9LG84kGuHqXNnzb9KkgIE1CYi7e
X-Gm-Gg: ATEYQzx7+D4sWPj1UGk6Ejfqt/OgpO/hKHDf8IkzDYIgOoBDPQYefx4zdap8Qe0DT+v
	RPJs02RrFDZruORzCww5b9ho7dh9aCs3lkzJI3RAN3/cOMLOcx7FGZnNhXCYipAgahyCKa14dsP
	ihd/Z9UfZtUds9ONV4fN/z0n3U1z0AW9bZzhw/BXAfv/voDctfqXE2jhvx6Fk10mpIhai+Km52e
	+rA9ooLpKp+PdHDDfcji2M0kj6G/amWCt+/qxIw202NMwmbMwwF9BspttXnarBdrYG6WQBK0Zs1
	qZr5fxv6/eUib0tS7hzToqzEiWg9Lnjkmq61AMtFEwVB9JHQDdq3tpGviyVEmHL8wo5VTp2ooq5
	tDZspPH/QwdKViNyquc7sUUK5U97FvngKLhCE23ZyiSgM06wrjYjENcoCJUBb/3tDTMze1TbCFT
	B+gEGBXNsHgQ==
X-Received: by 2002:a17:903:2a83:b0:2ae:4af7:d1d4 with SMTP id d9443c01a7336-2ae75c86497mr94936815ad.29.1772865890798;
        Fri, 06 Mar 2026 22:44:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9ad26sm52114455ad.28.2026.03.06.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:50 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 09/11] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Fri,  6 Mar 2026 22:44:37 -0800
Message-ID: <20260307064439.3247440-10-ameryhung@gmail.com>
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
X-Rspamd-Queue-Id: C5B1622A83E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265102-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Make sure the verifier invalidates the dynptr and dynptr slice derived
from an skb after the skb is freed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 36 ++++++++++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 62 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 68 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 64 +++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..ec5b346138c5 100644
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
 
@@ -156,6 +159,33 @@ static void test_incompl_ops(void)
 	bpf_qdisc_fail__incompl_ops__destroy(skel);
 }
 
+static void test_invalid_dynptr(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr__destroy(skel);
+}
+
+static void test_invalid_dynptr_slice(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr_slice *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr_slice__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr_slice__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr_slice__destroy(skel);
+}
+
+static void test_invalid_dynptr_cross_frame(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr_cross_frame *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr_cross_frame__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr_cross_frame__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr_cross_frame__destroy(skel);
+}
+
 static int get_default_qdisc(char *qdisc_name)
 {
 	FILE *f;
@@ -223,6 +253,12 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	if (test__start_subtest("invalid_dynptr"))
+		test_invalid_dynptr();
+	if (test__start_subtest("invalid_dynptr_slice"))
+		test_invalid_dynptr_slice();
+	if (test__start_subtest("invalid_dynptr_cross_frame"))
+		test_invalid_dynptr_cross_frame();
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
new file mode 100644
index 000000000000..2e76470bc261
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
@@ -0,0 +1,62 @@
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
new file mode 100644
index 000000000000..565dea13bde8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -0,0 +1,68 @@
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
+static __noinline int free_skb(struct sk_buff *skb)
+{
+	bpf_kfree_skb(skb);
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
new file mode 100644
index 000000000000..95e8c070a37d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
@@ -0,0 +1,64 @@
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
-- 
2.47.3


