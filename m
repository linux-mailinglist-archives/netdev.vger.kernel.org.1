Return-Path: <netdev+bounces-292942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DDCLAbyGGr4pAgAu9opvQ
	(envelope-from <netdev+bounces-292942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:55:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FD5FC31B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60DF31CA95D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D7364EAF;
	Fri, 29 May 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWzxkcxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B6362149
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019397; cv=none; b=ONFzyw8/4+TlNMaLGmB0xgZLlOy0B2c4XiiUfTbPFPrX71ykJoKaXLWVYrzobDIZ8pISqG2OMqbgU6El+ugFIjWBfWKdmwLBEbbaayxJHrj3ITOrxp+ugPg1Aanr8/2R5iA9Mu9JVvwN8DWbJHALQN9zYqY9dizuXSQQAv3cdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019397; c=relaxed/simple;
	bh=KTt0aucQRwSSY1v/g2cx63/4D7+yZyyp6PlNYp3orEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrUpeF+aN/n64QX0w4ZXu6PCR/mpGSe/piURA/upt73wiacpoI8fu8Ng4iYx1wXnZAdEg/mUUdc8jRBy3XvxU7/L6/wIerKzoi+Jj9MC+1QidmJ8fy0GR6uVRLElcfzn3tFZR+epjhn6JolCbrUhIAtjIh4Zu6g91zYXtDXWhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWzxkcxx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso7201835a91.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019393; x=1780624193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uif7b+czjKlcBWebCKP3CIhJtu2V0IJ9fXlMskACjYs=;
        b=cWzxkcxxMWPBvruPrCXa3hGMVAdfTgssTk20YqNfI5mLu34uqRBE+UHl3ZTl/h3+lB
         Ez4CmbmiQTwGzmHE4IfNyslg7VuTe+55yCAaxHhgs3zzZKRscTRlZr3n5/DEiDEEmo69
         TWDy9q+U0/p8JMo6i/zKQC4V2e2o64/j1YBwKK1Y1w0qav5ilckZEYgeF7hwx8CloirX
         pD2Ox2hg8dW03Uwpt6Gt2Gfb6oILA2MRSAv8+satNtUQ/yWp1sHsuSQMSdpfrM7h755E
         fkhOFZC0pkrInS2PmLOrY5Q3fvhyrGZse5gzpc0YnAJwBKj4gCQDtT14BaD3m8JKdPB0
         I7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019393; x=1780624193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uif7b+czjKlcBWebCKP3CIhJtu2V0IJ9fXlMskACjYs=;
        b=U17NXQxQ//ccY0TJ50SFjrid51IQ9MZegiD64ZThF1jVEfXPFjZ/+yjcKc0fj2Sxdy
         6bW+j5Yp1jqyrNyzvod6ANlfP4zyXpfGoMC6D3ETSPkPeC2rbkc0gdssem5D7y6bbzs+
         Z27Nk4Tz2EGp81MNVFKDbbe6KiIpm2MH7fXvomnWZnqWFVR6V9LDexjUWua4mD98YOFp
         rqmlM83NbH9y3/1u43xIF/+Vyr/jxaH0cejw+f9NgN5u2FDXmRolhkx2t4UEimlGgkka
         Vtjf3+wO/wxTvxpSIIBesOEZnwV3mY2C5rHTthw1lC5rcOSbLClPgfjhM/israk7yNQs
         BZkw==
X-Gm-Message-State: AOJu0Yyq8+3TE+kOmQIsIwDDwdHPNk7lUJrkoGWOtQM9AF1uId4QrOQm
	514kgGa+dOss5t7Kz65PDaYmjyW8iFihJT6P/lYqGXA+5caMw76zWT0m
X-Gm-Gg: Acq92OHz/0JHmVHmoyoRi2XoRfoWfrJyE1cIdzl+ud/KRNH9/JKGjzrR/exlESjgrUd
	RhtCIHnojFvup9n9GAOyoCi4USB779zYq8S2QAt9NHwcsQ3luuLsxSjLL9gNrJVPKneMzuBaePB
	AGrpKxfu9o2IWm4ShW5t0CaAtZixkVoGcin9fims2J+m13OneRynqZLJ8U8gAXOP+YI/0YZQ2vH
	0ncapcc30ys0AkZIYtjTTHw4HS7zHeutPwju3u9x5/p1hlLA1+H47Mldtjrzibyzng9EJxkaDCI
	6dkq75fr8ONE+fvS1ns79Jfpc0qUA3PSfD47jgBuRGlAxZQMnb9dQpdZliaGfmQfWy5JVHxm2/X
	LEZasuezc+yX9cl/2T82s3ftfdy5QcmSE601hpK+opmcyTHm/PS6/DngVNsE4tDg3oDJ+sIa8rC
	4e1669PghL2ll9nfxRyIqXdX13FNwa8hyxeZ4=
X-Received: by 2002:a17:90b:5410:b0:368:1064:62f2 with SMTP id 98e67ed59e1d1-36bbcc146femr1080719a91.3.1780019393156;
        Thu, 28 May 2026 18:49:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7af3sm119510a12.5.2026.05.28.18.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 13/13] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Thu, 28 May 2026 18:49:36 -0700
Message-ID: <20260529014936.2811085-14-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292942-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 118FD5FC31B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure the verifier invalidates the dynptr and dynptr slice derived
from an skb after the skb is freed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 68 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 74 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 70 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

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
2.53.0-Meta


