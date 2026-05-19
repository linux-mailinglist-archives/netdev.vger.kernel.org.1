Return-Path: <netdev+bounces-289575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M1pDqipDGpLkgUAu9opvQ
	(envelope-from <netdev+bounces-289575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:19:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E45838D8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D29B31004E8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAE33F8D9;
	Tue, 19 May 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXpyePLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B921344D8C
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214418; cv=none; b=T0Ser1zTaYQ3/aMHz+pZv30yLebyKG5MmpGP0xa+4SXWTeQ8YgfDrRu61f+MO+0j4buxxYE8zB1lmkaYqgRhCZKjelOOAEme1n0pJM87g9gx81YoXIlWgiNf45nPTJJE40IfjzGhJceAzq+Z3ibfmo1G0zuJuTjhq67lH+hTJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214418; c=relaxed/simple;
	bh=YuyvY6lR4seLVkjZlpLKISV+5zAbgi9YvwGKD3oZZtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBknv7pdhxOrhps3xITWQ1dDPcQEtdYmwaYYPtXRzHPIvcj3WoEoGFj0hHT5jKVQH/CfoWleJLKk5o4O101leLXNDlDNPs3SLlljK1ReWFV8XTCplf8u3iAQZEc6dwAaHYLkrgveUJ2j1gJoVHoxCuw/FUeU0OUBeBTLplnZ/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXpyePLz; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651bf695701so3774362d50.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214416; x=1779819216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK9UDeebClR71GiLjHRDE0WHrjlQxfeEp/nIlqA3ZAA=;
        b=RXpyePLzTz8/zoJcTlYL943yi0/WFUu5Goh+jnaP4G88ItwlcVqt9Q22l+Uh6liPa2
         HtcG04Gva4sWhlwbgNj+HueaQeX494DspJjZCXk7T3Zom80amrm9Ulhq3RzZZRpipH9C
         48ym+sNBMik0b7Y/XsQgoUy9otfpO1UPghxOP/qK5nLEcAAFUJAuETp5L3FwD3RLE855
         IB8Vs3yBSPoS220If/lgpGGGw9aNMfTHe1Q7fS3FwrCQBH6jmkN8amLs5dPjrj7RuVG0
         1iw30pLw3hk4GLbESOxUYoLxXZEivq2ko6eKEf1YDkQ/+IPvfcDTxo1oTcQCbFLg1tS9
         +/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214416; x=1779819216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK9UDeebClR71GiLjHRDE0WHrjlQxfeEp/nIlqA3ZAA=;
        b=DYDnFbVhAByhbZxOxXkoaKR7gvy/TxLGn0u18v9ARAWoskvdxl+6c3VjTKatGbX9C7
         B2qi/H4OlsSGEKKaYjzIWlmhIVDX2qIRlGzihb4LfjQYFoN8+heZh3/f2WDLN6f837hK
         0S8G/emk8F74qH1m2neDCsYljijt8F3XEv36RIuwis1Xn08w+Ah0uLJuyrvdjmlOSpzZ
         nZqMjqAxgAzI/7lecaGYRHQWUKXolPwLD53upcvcZ3ikzHpug2cqmEY1GWFnzsn3uvUy
         S9JYU0M89HexrjymUaOh27t/vMq0L8/Ce1S060E18gPUp3+NoHSzHsI15bfxxl482Fj1
         8MuA==
X-Gm-Message-State: AOJu0YwjNT3Qz3wtsDa0iKZ7gfmFaxo8K7RHdsMwhXEfd2X8MStcvuyw
	rWFFFVCnWzfmcvTMOnWBiqwUDxPCw4FSS9RAHnakLQlKJqLW/GMGoVXJ
X-Gm-Gg: Acq92OF4tRCpqNcZYA5/b/7gJ9mGqWSwMTu0+nk1DzcUzTzt8FiN2cGtQsT9uGZLlUH
	YKTAl8ge0RoAIKibNL5PEnCNM+ak20kGgGjLDesOtjuSngUJ9KWJRzkM1yv3bU2KEkHeM0lZO8e
	cc1KpUNBX/dVUi/zh7J/aXDBgkCReBfG70zwZyaGzrGrrTrpMQRkwzfyxT2nrEUjLTSJN4JMbpC
	X/Q5m5efZAnIuTVqUcCGCMGPgF6YfIv9GN+XA6rRtaNOfaQxQVqgN1f1p4VKuWB/oV6XKTbH51W
	jLJ0bqAmNSD8cG2POWYEpRHLCNXCEFWMyJVHPeG7/gw8cCpxyWIdfJgl8rP78fyIqLhSAV5cC/k
	dj+tfGQuut6xHhk9LuOAhPy+FfHA+Kbc7+TsbAB4u9+9F4NIaxbaoHkL5znDav7Wy2cBzQaobFe
	YS640vezFVYmeG7g==
X-Received: by 2002:a05:690e:4409:10b0:65e:d38:aca9 with SMTP id 956f58d0204a3-65e22895bf1mr17448042d50.63.1779214416089;
        Tue, 19 May 2026 11:13:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm8359429d50.2.2026.05.19.11.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 13/14] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Tue, 19 May 2026 11:13:11 -0700
Message-ID: <20260519181314.2731658-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289575-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 905E45838D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ..._qdisc_dynptr_use_after_invalidate_clone.c | 74 +++++++++++++++++++
 2 files changed, 76 insertions(+)
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


