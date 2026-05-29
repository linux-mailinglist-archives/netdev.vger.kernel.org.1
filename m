Return-Path: <netdev+bounces-292940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DfHM8zxGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE15FC2DF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1690431A5088
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C3363C5A;
	Fri, 29 May 2026 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0AHkQ3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB313644C4
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019395; cv=none; b=MdhJKvg72/aMGjDZxP2CWxil8jBk9xVVe3dIF4B3fwtkVpNtZAn5zgCH9Mvg22aYYE0WZkK8zUrMjeqmIMQjo6NAOBw6rMy6raS668DhVU01KfeLndh5VoN6/krvkASd5tzFiWzTNw6D6ShQbqpdDtyvUT3xXpEL6VOG+SAiOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019395; c=relaxed/simple;
	bh=NYneCGKnQ7LIXs3sXUH6hETaPgBJYuTPlhVQmYHmrDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bG+Q77DiwDw7zEe6+Uu3Ug5E3LnnB9rHFfdtaV+T9fCjHuQ8Id1tJff+AbsjViVr+mYO5zFsK740/k20cA+5mEk+LuKIh/ngZ0SQky2gt9nfqCQlWZg0CKCH3rHY6ttWT3LEvVul8c9U06I/89YN+iAuAwal4DiYr6q+vErFDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0AHkQ3X; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so602369a91.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019391; x=1780624191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwqwlPBf3FCjAT186yXbJ+Yd55pNjiN+lHpC4X7ZKbE=;
        b=G0AHkQ3XAVO7jwvhSxIHSkgpD4NkTrGob/LrEinZSPwKr2iZnR/1/uo5QTUedGK+E6
         LBBfCsebRBh6eeAaC3YYT0PuXAuiYE+34T6sbn8sOVumqRCKG7+QoyIUYSUmw78Z8m8/
         UFlDIfvA7ZomVPSQNPO/5/sCsBAcCDuy4hTGZ4M/a4n3CXHcPyq1hbS/5dE+H9bx4gAf
         BbYC0rgfC1JsDN4xpC3iiL8MBMfNsoU1ETYDhGEqx/IF+ebfPegaRD2RFVnoXkMRZU8B
         JaYiPazeIsglxli5kvgynZeGk8nC5Qi5ptuu7x7uVz/3a49rM0izZsnRyEXIdTEgZptG
         7PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019391; x=1780624191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwqwlPBf3FCjAT186yXbJ+Yd55pNjiN+lHpC4X7ZKbE=;
        b=o9fBBw9wmOOgw9SGuMr3dq8lKB91eaErKbY8EWcgu+zKIZfLnYOP6Dkpv5Rk6HRgro
         guVqwqUankW8D5iEmHgWHuS5uh9W+D6OYrQZ+OK8HrOJCmxXQJcOecn58qr/yVZg4F6o
         kWfMBfPrhvUemLAQLxgFV8JjfdIkj1kpPz1LTb3euMsSKeeFC4zuClcHcRECL9ahVVD7
         kTfZCgVvzUIdxjckNqGzDKQH6NW1/E5143j+PvDHyzn1nBnVhSKo6iO2Kk6TPcVI3d+J
         jK2XNm6qkchDz3d7GE5y5sHLyqaWe0Y4NYl5cy5cVFBBlp99Z4fbK/uH/tZ+e57twJcy
         Ljhw==
X-Gm-Message-State: AOJu0YzA70y19Mb1sAwHfEiWpYT1upZtsjV9NAxjaei+QvuC76IKSiCB
	K4E6gQKLEXcBZaTwWe+QsQICFpJjWpp2w/mltOtvPIU/6s4m6QqKty+q
X-Gm-Gg: Acq92OEn3WxBLYhNEhzZ6/gC2/EzPFmpvQtT6W/uqWBNV0rem2i7iOzuwvfz/sdd7oa
	STmJC9HDE1XNkrwLupkGlxx7rdb9m+0m/E6mp+Pne+hVtEhaHX3dfjtHNvx86MsXbz7K54GWAIu
	Gb+dVYthC3nO/3UMqNgMIHRZnPsM11aK04qILpcsX+vNROsEWt8WobOrsJU8aiwQSzcyaUdme3O
	OsTJZtCaI8TVojVCD7iMuujjdmyRg5PnC+B72MbjO57i7JCH3e1M1F7IvPnX9+f8UYElx7PuUEw
	y/SdP4A86JThKlzBDdFPSCnMisJ4Bd97u8Og3dRFfeZlZCHZ0sO7CvTZyK71Kmz6HBJtPTr18ac
	YZpQv4gn2sgtnlUn1645lozQ7ZO7+h3YUqN2woMHhrh9CXwDJZgKIc662RHMg2OQQalzCl6Roj0
	dqHPNF8qbnclQxL67WEa7fts9G
X-Received: by 2002:a17:903:2392:b0:2bf:2015:5b94 with SMTP id d9443c01a7336-2bf20533a7dmr10834045ad.3.1780019391190;
        Thu, 28 May 2026 18:49:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm918775ad.33.2026.05.28.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 11/13] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Thu, 28 May 2026 18:49:34 -0700
Message-ID: <20260529014936.2811085-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292940-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 53DE15FC2DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  8 ++
 ..._qdisc_dynptr_use_after_invalidate_clone.c | 74 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..77f1c0550c9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -8,6 +8,10 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 #include "bpf_qdisc_fail__incompl_ops.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -223,6 +227,10 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
+	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
new file mode 100644
index 000000000000..ac626cfa2a98
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
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
-- 
2.53.0-Meta


