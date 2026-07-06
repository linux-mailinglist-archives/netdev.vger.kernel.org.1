Return-Path: <netdev+bounces-304940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MeFVC6uXS2qkWAEAu9opvQ
	(envelope-from <netdev+bounces-304940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:55:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D8710226
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:55:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T4PnH5q+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304940-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304940-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB22337E5B9D
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9E43C7B7;
	Mon,  6 Jul 2026 09:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5943B6E7
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330553; cv=none; b=iyQohLk16Vn8RpxzEDfNs9onv8SFzxlQoDq1DZVS2sD/SYRgXeW+FRSeGhGeAg3ZyAEyV2va33IuU/KW2WLSueN5rBP12YSsfyAg2TuY6An1cvC2fotnTWeIzNz53hxrA2xeKZR9GPDKs9XIVqBMhtbXe6yTidvLP/m0DXvjlWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330553; c=relaxed/simple;
	bh=LkbDUITHcVIMSdNbfB4iuLmMd002FIwjIehN9J2b920=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsMcDtDwALQlSkEQzBmXAIXIMF0cFq1xPdD9CiUie4w/yVf7W3+0PD4ybhQ5acbDDfoyDIyt3qsNEBVzI2fm601GhZTZWjiwovhyfDMcc8zWRfNgiCcFkxx66bcK2Zs5SiI9WCMxEroDBylaeiZnhzHoSW2xS2chOz++5LNzso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4PnH5q+; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1394816f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330546; x=1783935346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOcr3Ek60ukkbbM/bpYf9F0+mvBBqkSW/FD62UP3Vks=;
        b=T4PnH5q+/hh+oKAxPH1bJCwWkpaA5DZ5j33FrUoEREcrEWG5z3AwTATjljbN4eHnsS
         y78rXklNtLQjSIYYh+HB+FC8XK/Y2h8/9jHZUUX1Hxwz7ZEZCqYdKOoqLKJ6iV0mmvQN
         9OCscLQxelb+CB6u7dicJdM73MXDWvhAzqSFFN2r7wlcyVSiZiDuwfaA/3h2etsO8XB5
         CCH4MyV756cmFeGimk6CDmtVFE2QcDzkdvgvkrx+FJL9gXJ9CDlVvWaGwKkaLrtBgy7H
         5D4kM6NZS5p84SKenEwf5gwq9XmLe3p3v6Rf0kAZP2ebFvoBEbQusD29ROei+e1OYnA7
         HHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330546; x=1783935346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOcr3Ek60ukkbbM/bpYf9F0+mvBBqkSW/FD62UP3Vks=;
        b=bM3pNgb9qEjiXMvz38GehzuhtqX5ODaALx+wkhhVXhkE99nFKxK4skoICl4toroirX
         uBmENz79iw/ug/llVGlRunmcP+bWMaHzJhHyLBtLDqO4EeqVYfZIJQeFuTSJ3qby5BjH
         yx/DBLJy7J/Gn2QJ5bw1gsWn+O7PBkOvpCi1Amy5PsebTfv5aPCp5ieR6SbyxKijoufX
         IDnaJa9W+nB6iZ09Ybs9zU+3uqfg6/4eiV0hRJ5gxgchoCmtKX7OofXwWZjdHFLREM/o
         lkzayIQsJ7YWQNhKgmlnuyeEvycHlFcf3Eg9AsM5Es4inXZC9qMeVBuYOfbiUUX0Uhql
         fmVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnypV3beT/7GtkbsTG50U6G8BBnSNJgmYMCugPBawRq8v95UaP26pr5v/9eBnXxpzu5583Ybo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDGDqvWrmE97nMFqwrgYnO/vovGoZ/8q2ikkeQqF9UuxvBgFY
	d1Pe3kkcO/SC0lGvq+nYvdKXantE+6yJEvVEKxSXMRRSxkX5iPWk6DRO
X-Gm-Gg: AfdE7cmMAWXtNXaK2/SM4QA7Rmn76H+UM/nuliEj07cfIF+MEsjvch1mFXkIsSQPemb
	Q1GV4cmGdrBRW9M87b+ZyUGFY1xw5LPU7tLeeBTR0gc4Cca44YyjslniVeWcuriToxxOCsh0/qA
	To93HTWfkeK01O9PiVNie4WgU0k+jDgy2CTKYdS7IvANFHLoTiRwy9VzyzSo14mXCS1Qgt2bZ/f
	KeCOf1eyaG6qZfpbRWoLsfc820xMsuBtqzUpAH+RmGKyoOiX7QcPWAvjEhy5QkjLjqlzWwfEuzM
	pNQ1+AeOh6uNhDEXllFQ0TsjioHdorgRyvPQ7Rp9WH5GhA3X2hlRGWKdICUnuuK+UGTaCNOZwHL
	z/o4r9t7Cv+jQYAtlpH64hPrG79tVfOQrwOEYaLwHygxiuaXx1j0m47yLj445pj+3iCCpjRaA31
	fx3HHPHolm4o7p5ebz
X-Received: by 2002:a5d:5e8d:0:b0:461:e27d:5690 with SMTP id ffacd0b85a97d-47aaaadf193mr10514727f8f.26.1783330545776;
        Mon, 06 Jul 2026 02:35:45 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:45 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 5/6] selftests/bpf: Add ksock net ns quota tests
Date: Mon,  6 Jul 2026 09:35:24 +0000
Message-Id: <20260706093525.13030-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304940-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahe.tardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[create_opts.family:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 754D8710226

The new bpf_ksock_create() kfunc is limited by quota enforced at the
network namespace layer. This test verifies that the quota are enforced
and the acquire/release patch increase/reduce the counters.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_quota.c    | 139 +++++++++++++++
 .../testing/selftests/bpf/progs/ksock_quota.c | 167 ++++++++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_quota.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_quota.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_quota.c b/tools/testing/selftests/bpf/prog_tests/ksock_quota.c
new file mode 100644
index 000000000000..c86d9b0a9513
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_quota.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <sys/stat.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "sysctl_helpers.h"
+#include "ksock_quota.skel.h"
+
+#define NS_NET_QUOTA_TEST1 "ksock_net_quota_ns1"
+#define NS_NET_QUOTA_TEST2 "ksock_net_quota_ns2"
+#define KSOCK_MAX_SYSCTL "/proc/sys/net/core/bpf_ksock_max"
+#define KSOCK_QUOTA_NS_SLOTS 3
+#define KSOCK_QUOTA_NS1_OFFSET 0
+#define KSOCK_QUOTA_NS2_OFFSET KSOCK_QUOTA_NS_SLOTS
+
+static int ksock_run_prog(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (err)
+		return err;
+	return opts.retval;
+}
+
+static __u64 ksock_quota_release_completed(struct ksock_quota *skel)
+{
+	return __atomic_load_n(&skel->bss->quota_release_completed,
+			       __ATOMIC_ACQUIRE);
+}
+
+static int ksock_release_quota_slots(struct ksock_quota *skel, int slot_offset)
+{
+	__u64 completed;
+	int err;
+
+	completed = ksock_quota_release_completed(skel);
+	skel->bss->quota_slot_offset = slot_offset;
+	err = ksock_run_prog(skel->progs.ksock_quota_release);
+	if (!ASSERT_OK(err, "ksock_quota_release"))
+		return -1;
+
+	while (ksock_quota_release_completed(skel) - completed <
+	       skel->bss->quota_released)
+		usleep(1000);
+
+	return skel->bss->quota_released;
+}
+
+static bool ksock_expect_quota(struct ksock_quota *skel, int slot_offset,
+			       const char *name)
+{
+	int err;
+
+	skel->bss->quota_slot_offset = slot_offset;
+	err = ksock_run_prog(skel->progs.ksock_quota_create);
+	if (!ASSERT_OK(err, name))
+		return false;
+	if (!ASSERT_EQ(skel->bss->quota_created, 2, name))
+		return false;
+	return ASSERT_EQ(skel->bss->quota_err, -ENOSPC, name);
+}
+
+static bool record_current_ns(struct ksock_quota *skel, int target)
+{
+	struct stat st;
+	int err;
+
+	err = stat("/proc/self/ns/net", &st);
+	if (!ASSERT_OK(err, "stat netns"))
+		return false;
+	skel->bss->target_netns_inum[target] = (__u32)st.st_ino;
+	return true;
+}
+
+void serial_test_ksock_net_quota(void)
+{
+	char old_max[16] = {};
+	struct netns_obj *netns1 = NULL, *netns2 = NULL;
+	struct ksock_quota *skel;
+	int released;
+
+	skel = ksock_quota__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock quota skeleton"))
+		return;
+	skel->links.ksock_release_work_enter =
+		bpf_program__attach_trace(skel->progs.ksock_release_work_enter);
+	if (!ASSERT_OK_PTR(skel->links.ksock_release_work_enter,
+			   "attach ksock release work entry"))
+		goto out;
+	skel->links.ksock_release_work_exit =
+		bpf_program__attach_trace(skel->progs.ksock_release_work_exit);
+	if (!ASSERT_OK_PTR(skel->links.ksock_release_work_exit,
+			   "attach ksock release work exit"))
+		goto out;
+
+	if (sysctl_set_or_fail(KSOCK_MAX_SYSCTL, old_max, "2"))
+		goto out;
+
+	netns1 = netns_new(NS_NET_QUOTA_TEST1, true);
+	if (!ASSERT_OK_PTR(netns1, "create first netns"))
+		goto out;
+	if (!record_current_ns(skel, 0))
+		goto out;
+
+	if (!ksock_expect_quota(skel, KSOCK_QUOTA_NS1_OFFSET,
+				"first netns quota"))
+		goto out;
+
+	/* The host-wide setting grants the full allowance to each netns. */
+	netns2 = netns_new(NS_NET_QUOTA_TEST2, true);
+	if (!ASSERT_OK_PTR(netns2, "create second netns"))
+		goto out;
+	if (!record_current_ns(skel, 1))
+		goto out;
+
+	if (!ksock_expect_quota(skel, KSOCK_QUOTA_NS2_OFFSET,
+				"second netns quota"))
+		goto out;
+
+	released = ksock_release_quota_slots(skel, KSOCK_QUOTA_NS2_OFFSET);
+	if (!ASSERT_EQ(released, 2, "second netns quota released"))
+		goto out;
+
+	/* Both released slots must become available again. */
+	ksock_expect_quota(skel, KSOCK_QUOTA_NS2_OFFSET, "recovered quota");
+
+out:
+	ksock_release_quota_slots(skel, KSOCK_QUOTA_NS2_OFFSET);
+	ksock_release_quota_slots(skel, KSOCK_QUOTA_NS1_OFFSET);
+	netns_free(netns2);
+	netns_free(netns1);
+	if (old_max[0])
+		sysctl_set_or_fail(KSOCK_MAX_SYSCTL, NULL, old_max);
+	ksock_quota__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_quota.c b/tools/testing/selftests/bpf/progs/ksock_quota.c
new file mode 100644
index 000000000000..91854ea333c1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_quota.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+#define KSOCK_QUOTA_NS_SLOTS 3
+#define KSOCK_QUOTA_NETNS 2
+#define KSOCK_QUOTA_SLOTS (KSOCK_QUOTA_NS_SLOTS * KSOCK_QUOTA_NETNS)
+
+struct ksock_quota_value {
+	struct bpf_ksock __kptr * ctx;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct ksock_quota_value);
+	__uint(max_entries, KSOCK_QUOTA_SLOTS);
+} quota_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, u64);
+	__type(value, u8);
+	__uint(max_entries, KSOCK_QUOTA_SLOTS);
+} release_workers SEC(".maps");
+
+u32 quota_created;
+u32 quota_released;
+u32 quota_slot_offset;
+u32 target_netns_inum[KSOCK_QUOTA_NETNS];
+u64 quota_release_completed;
+int quota_err;
+
+static __always_inline bool
+ksock_quota_create_one(u32 i,
+		       const struct bpf_ksock_create_opts *create_opts)
+{
+	struct ksock_quota_value *v;
+	struct bpf_ksock *ks, *old;
+	int err = 0;
+
+	i += quota_slot_offset;
+	if (i >= KSOCK_QUOTA_SLOTS) {
+		quota_err = -ERANGE;
+		return true;
+	}
+
+	barrier_var(err);
+	ks = bpf_ksock_create(create_opts, sizeof(*create_opts), &err);
+	if (!ks) {
+		quota_err = err;
+		return true;
+	}
+
+	v = bpf_map_lookup_elem(&quota_map, &i);
+	if (!v) {
+		bpf_ksock_release(ks);
+		quota_err = -ENOENT;
+		return true;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ks);
+	if (old)
+		bpf_ksock_release(old);
+	quota_created++;
+	return false;
+}
+
+static __always_inline void ksock_quota_release_one(u32 i)
+{
+	struct ksock_quota_value *v;
+	struct bpf_ksock *ks;
+
+	i += quota_slot_offset;
+	if (i >= KSOCK_QUOTA_SLOTS)
+		return;
+
+	v = bpf_map_lookup_elem(&quota_map, &i);
+	if (!v)
+		return;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (ks) {
+		bpf_ksock_release(ks);
+		quota_released++;
+	}
+}
+
+SEC("syscall")
+int ksock_quota_create(void *ctx)
+{
+	struct bpf_ksock_create_opts create_opts = {};
+
+	create_opts.family = AF_INET;
+	create_opts.type = SOCK_DGRAM;
+	create_opts.protocol = IPPROTO_UDP;
+	quota_created = 0;
+	quota_err = 0;
+
+	if (ksock_quota_create_one(0, &create_opts))
+		return 0;
+	if (ksock_quota_create_one(1, &create_opts))
+		return 0;
+	ksock_quota_create_one(2, &create_opts);
+
+	return 0;
+}
+
+SEC("syscall")
+int ksock_quota_release(void *ctx)
+{
+	quota_released = 0;
+	ksock_quota_release_one(0);
+	ksock_quota_release_one(1);
+	ksock_quota_release_one(2);
+
+	return 0;
+}
+
+SEC("fentry/ksock_release_work_fn")
+int BPF_PROG(ksock_release_work_enter, struct work_struct *work)
+{
+	struct rcu_work *rwork = container_of(work, struct rcu_work, work);
+	struct bpf_ksock *ks = container_of(rwork, struct bpf_ksock, rwork);
+	u64 pid_tgid = bpf_get_current_pid_tgid();
+	struct net *net;
+	u32 inum;
+	u8 tracked = 1;
+
+	/* ksock_release_work_fn() frees ks before the fexit program runs. */
+	net = BPF_CORE_READ(ks, sock, sk, __sk_common.skc_net.net);
+	if (!net)
+		return 0;
+
+	inum = BPF_CORE_READ(net, ns.inum);
+	if (inum != target_netns_inum[0] &&
+	    inum != target_netns_inum[1])
+		return 0;
+
+	bpf_map_update_elem(&release_workers, &pid_tgid, &tracked, BPF_ANY);
+	return 0;
+}
+
+SEC("fexit/ksock_release_work_fn")
+int BPF_PROG(ksock_release_work_exit, struct work_struct *work)
+{
+	u64 pid_tgid = bpf_get_current_pid_tgid();
+	u8 *tracked;
+
+	tracked = bpf_map_lookup_elem(&release_workers, &pid_tgid);
+	if (!tracked)
+		return 0;
+	bpf_map_delete_elem(&release_workers, &pid_tgid);
+
+	/* The worker has released the socket and returned its quota charge. */
+	__sync_fetch_and_add(&quota_release_completed, 1);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1


