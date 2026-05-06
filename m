Return-Path: <netdev+bounces-284884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOj5ALRT+2n+ZQMAu9opvQ
	(envelope-from <netdev+bounces-284884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E44DC770
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9511D3085010
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28BB481A86;
	Wed,  6 May 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOXhKIC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3748033F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077656; cv=none; b=V0wNuoVUIESKPA2GBcLB+oQnyH4B8M1bCcA8rcRguw9jKl46O1vvwjpKRFc0D0ZDDFj8n5XkB96BrQefVqBvzsdqu2+myjrCwvRjz9WCrtM46lUMXvkHZJ8B5ldR47H776EcR9dOvU02/Jolo9uKF/z94txxuKFK78Eo+9VyHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077656; c=relaxed/simple;
	bh=PknOxEDwYtUiqcGb0yzibJrOc5+DQljK442foDX9DdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFplo3ZeyAU1L9LxW8Fa2a5P3KETnpRCSwBK0EBq4w7r1m/4M3BbyVHR4CS196m8Bd8JfXW8SdNmvxW0POb4+rWrggR/DpIJCy/p9PXPO90llRxewY8RAZNFEl9iZJK5BcMPSM06bbl8BZNZo00h7qrTaxHKtf86o19EVfIOVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOXhKIC5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso37530976d6.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077650; x=1778682450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3JwDD8aGgyvCwm8+kdBrl7zPnFCzfcvcvpFjrxGXsM=;
        b=sOXhKIC53iy2LlqKNQlbwpmItJMdZUSYAqkstnxPSbgPbbEj+qtmZqlYH76pJJJZ8u
         0c7Y0yUABEwKJDishuFnLfzdQx6Cdd8icb+PI8QXDAkg9CkVsX4xwpiacFIjVB/MzZvc
         mLvJ9ESg/FIOw3LYmcR/7fLj65DGXcCUY1l/EVkITLeIwtQWUS1SwwrTxHkJLWNwZpVs
         YF+JisImh6zmRxEf3mi7LQZdrWC5lu1hmnr1XN6u1HHdleunjDD7i32PL9zNg6aFLSCr
         EiD55zA6bcjaopteU6tNHhhgHuyoM0QuZz+KZqqleb4sYrQEOHUa9IrRL6mdh+ruYavc
         1JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077650; x=1778682450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3JwDD8aGgyvCwm8+kdBrl7zPnFCzfcvcvpFjrxGXsM=;
        b=aJJ95gs7CGzA/eEqpcnf3OSqijA2pCUNZSSHaUFUA+N94is39do2TXXkNyqfUni0Ap
         RnRwpUXHz7ZHE3GCY2OVZoQ4VKI6MS/O43dKm/IaB0dUW3b+38cnsGMvBT7OdOmIQwQp
         b5UqONdKwjLPG2xa2fvVEx50RcOqgJ0LtZikU3y8XaFT1UsGycr5uvNoc0sqctaoGW6Z
         5ksy5Cl9jGAPyMCKclZQmxyCd7C4eAALDEuILbpDNugxSFfpOAzTdT/96WKSD89xoAjA
         Oo5W4x769ztTQBKNjujlBX6rYLgd59CG81F4V8gG0zFlVFH3X3uBEenb8KjqJJIAy8/V
         TTpw==
X-Gm-Message-State: AOJu0Yx3qj1xLtN5mrHcKBwNzNp43dbPpOOsoilh35vEEWaVBRvTxWNg
	dHhvdLhndM1LYKHPqjlDGWH0+U6v/BN6L6HNDz9mJj6jzyHv6Wu0K7xf
X-Gm-Gg: AeBDies4JwsPn+celCS78OT/v4fKLF8sRqyScw/d13ywBeg3H6rNwRySEPVN0cbCN7t
	gB91/+rQS95SMVlVJzfu+hS/mvetCKi6cOF2nfC45aREjGKmbPc/nXCl9m3cTWJHSvJ2yxgL4kt
	Jd8cZmPwZYSbSUJ6hM5napi4mt54cqNE+6YQt/KwH7ksfIPLyGEGEX0UuLHHBkx8OQVKOu/0e96
	rJJO10AR82oh5BnxynJXnn+hmkezLRi1Z7RAMojWVU9jBDJQEphFe1zuVQKuiXLyX++eJB1iYpz
	fmUyeqr2+Ycxwyhv7kJydXBtrd8hbM8L0Z/Gtiz9jzP+OlIz0hM51Cqug1U4dgy6kRktRyRjE4y
	Kl0PgcglqbrHYbjN980zPFDRCIM4Qa7t5LnoCTAZyWH375kH7zzsSTUh02z9Aov6SsqPra86kCC
	tgBAJf3HA5LL4g96qC/4gam36RuWI=
X-Received: by 2002:a05:6214:3986:b0:8bc:81:c1db with SMTP id 6a1803df08f44-8bc45e1e978mr52051896d6.43.1778077650485;
        Wed, 06 May 2026 07:27:30 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:40::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dce68sm184282176d6.24.2026.05.06.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 11/12] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Wed,  6 May 2026 07:27:07 -0700
Message-ID: <20260506142709.2298255-12-ameryhung@gmail.com>
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
X-Rspamd-Queue-Id: 466E44DC770
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284884-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

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
2.52.0


