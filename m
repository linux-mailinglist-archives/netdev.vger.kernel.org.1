Return-Path: <netdev+bounces-291766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hn1HNHAFWoiaQcAu9opvQ
	(envelope-from <netdev+bounces-291766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5295D9064
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D014F314E1AA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE667378D9E;
	Tue, 26 May 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4qqI6iA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C164377543
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809854; cv=none; b=LEo7wPpfKw/srMtb8bSE3wfVZSqOfOnh+n9sVijUoO8OBFJ9EsAYBWO9JqQZlRokscCnX+erToKOrnfQCY8xiDObRSBeQaTKKV/XmaIapNgqxE87nksJfqrvaHtOYB0tk9DFy5TlTrZguP4yOsP0InNSvWNLMEHBaRH7pM8oEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809854; c=relaxed/simple;
	bh=aHiP5iPDgTnfx2MlFNZtRtLLl24SwK+8MfSYE5ZAVhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a9ON3HPh8btlnWmnXeViYcrwISiaTpiWfSYvjnR4FWa/dtnJkVyS7dkq56BEqY2nyT99qnCfvjwIEwIBXrcUYbmryk2506YTQtV+C3Tl5nsxMcmmDq/emXmYuReuaolRlgqFmlrLn2+1caNWFPgi+y0TMEXh6Iq5GVWNllkxu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4qqI6iA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49040362e4aso51688975e9.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809851; x=1780414651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9PBIjlRM30LWt9CU8BNuDCg7sgYuhWgWgktG0ZmDLI=;
        b=O4qqI6iAhdOgkB4aYzm3DT3o7HJiI+uzEE+cr1mN0076ylsVg0bBBftDtX4OBWihpd
         D4GueLSK62FXwTHox+B0W0jOFf9//4c459AlDHrv15iPy1HoNR0DgSwVtd5kGdNHZa7N
         56BRqnFL9XSFYsiOtcD4Yv+52kq1gH99gB25F1Ddw+7ksI3UczURRfHAxOBJqNM0274z
         DixwogMr5ddkngvpVgTkK/sLUtjziu1S9cbs4uB4zjLFarMbhNtw+jRfOZk5tvkTyfQ7
         Bx2gWBLRn2NLpI46eponPmoQvJF+gLMR/vVRaQiW4JRRFzdg4xaWcOVg/H/NDPWzAyEK
         UrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809851; x=1780414651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9PBIjlRM30LWt9CU8BNuDCg7sgYuhWgWgktG0ZmDLI=;
        b=dWUut2xEBOADhH84KyInMF2X7ZXyuN7/WrFgKUqOg9+Z967QoDkVBDZE5G5hqc2IhU
         mpaqCm+1yIk9MwKsLM8V5sz10gmwLTkiloFEEXQS51mePJcOCXBziafk9IS0DQ0K60sx
         6jt5bfakBnVwaS539ZDTcvk54gFERFnwlPMyDjWyPa0QESl9Bxxx8yMCkh2N0jUIgtKu
         O7AIi+q1QC7C2mwzIU1nRh7mqFWtehAgx3SPEHl/hqqM7tzuKcJuAMssEC8FAbYZkvVG
         xnUbsLmOWtFnHA94y6Z63+SJXsw3fKTWz2NxWNbKS2VRo7OAsm7rE/3B+bOijyW/Zf28
         kdtg==
X-Forwarded-Encrypted: i=1; AFNElJ9IISo3fwAn7qZFsFoVT9HVXQ9Tff9nXIlv5NeZnYeIATZAvDm49+H4gGNfPpWS0ZAkPv1oWLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvtFlCInctHB9+60rRDwXNSsNG1ZgxxrolAjlu+ed4DAZW0DF
	pqo1RmEKv1u4SSah8AXeYqauPfyR9e5s5zsTu4VjCC2s3LY8erT+FyWD
X-Gm-Gg: Acq92OFmAweqfLxbeK1Kd6s5sZobC4J3DPmGRIL/XMNQXS+n9oYnJPgyIVf6mTVwsAl
	+UpuFuq+5DaXgDk5sI1SNPbV/ThuMhM5hJj/GWGt2DbgvGANHKaELaqGrxrZWlDL1fHiFN1lKqR
	LDpLSbqPno1U5pFRBIhG5dGKat7rqgAxIsAwj2dqs4wx3nkCTpJIxOyelzFcM1ctlE/751aOTPN
	ubZ1MVqK/OXwgCxKySzeISf0AFKhp70t0VVUMDYTlxIrFzL3WIDUY/uXgTRRmlshauNvbO5LkdY
	/VRTTE7f+ZsHfOYqRA4+mvufO0gywsQCYrG3vOe0p5HSeaSmaOOY4CI2fYurohMEplc4hv43RD9
	rUqiEPa4J87SCtP33Z+cA/iuGrfFsYgXFqbsZG/DhtvUogbZdaU2XgYliYgbg/zhpslSyWpMthv
	A8yZE06YVOvdk5l0Ruq188wH6AjHw=
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr316962155e9.16.1779809851296;
        Tue, 26 May 2026 08:37:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 7/7] selftests/bpf: add bpf_icmp_send recursion test
Date: Tue, 26 May 2026 15:37:08 +0000
Message-Id: <20260526153708.279717-8-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526153708.279717-1-mahe.tardy@gmail.com>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291766-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F5295D9064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This test is similar to test_icmp_send_unreach_cgroup but checks that,
in case of recursion, meaning that the BPF program calling the kfunc was
re-triggered by the icmp_send done by the kfunc, the kfunc will stop
early and return -EBUSY.

The test attaches to the root cgroup to ensure the ICMP packet generated
by the kfunc re-triggers the BPF program. Since it's attached only for
this recursion test, it should not disrupt the whole network.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 42 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/icmp_send.c | 44 +++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index 51f809ea6896..f48e1d41e3ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <cgroup_helpers.h>
 #include <linux/errqueue.h>
 #include <poll.h>
 #include "icmp_send.skel.h"
@@ -10,6 +11,7 @@
 #define ICMP_DEST_UNREACH 3
 #define ICMPV6_DEST_UNREACH 1

+#define ICMP_HOST_UNREACH 1
 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
 #define ICMPV6_REJECT_ROUTE 6
@@ -193,7 +195,6 @@ void test_icmp_send_unreach_tc(void)

 	if (test__start_subtest("ipv4"))
 		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
-
 	if (test__start_subtest("ipv6"))
 		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

@@ -201,3 +202,42 @@ void test_icmp_send_unreach_tc(void)
 	bpf_link__destroy(link);
 	icmp_send__destroy(skel);
 }
+
+void test_icmp_send_unreach_recursion(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	if (setup_cgroup_environment()) {
+		fprintf(stderr, "Failed to setup cgroup environment\n");
+		goto cleanup;
+	}
+
+	cgroup_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
+		goto cleanup;
+
+	skel->links.recursion =
+		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
+		goto cleanup;
+
+	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
+					"127.0.0.1");
+
+	/* Because there's recursion involved, the first call will return at
+	 * index 1 since it will return the second, and the second call will
+	 * return at index 0 since it will return the first.
+	 */
+	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
+	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
+
+cleanup:
+	cleanup_cgroup_environment();
+	icmp_send__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 5fa5467bdb70..c899fb7b28d2 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -14,6 +14,9 @@ int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;

+unsigned int rec_count = 0;
+int rec_kfunc_rets[] = { -1, -1 };
+
 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
@@ -125,4 +128,45 @@ int tc_egress(struct __sk_buff *skb)
 	return TCX_DROP;
 }

+SEC("cgroup_skb/egress")
+int recursion(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+	int ret;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4)
+		return SK_PASS;
+
+	if (iph->daddr != bpf_htonl(SERVER_IP))
+		return SK_PASS;
+
+	if (iph->protocol == IPPROTO_TCP) {
+		tcph = (void *)iph + iph->ihl * 4;
+		if ((void *)(tcph + 1) > data_end ||
+		    tcph->dest != bpf_htons(server_port))
+			return SK_PASS;
+	} else if (iph->protocol != IPPROTO_ICMP) {
+		return SK_PASS;
+	}
+
+	/* This call will provoke a recursion: the ICMP packet generated by the
+	 * kfunc will re-trigger this program since we are in the root cgroup in
+	 * which the kernel ICMP socket belongs. However when re-entering the
+	 * kfunc, it should return EBUSY.
+	 */
+	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
+	rec_kfunc_rets[rec_count & 1] = ret;
+	__sync_fetch_and_add(&rec_count, 1);
+
+	/* Let the first ICMP error message pass */
+	if (iph->protocol == IPPROTO_ICMP)
+		return SK_PASS;
+
+	return SK_DROP;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1


