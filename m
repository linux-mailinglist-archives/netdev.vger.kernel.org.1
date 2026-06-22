Return-Path: <netdev+bounces-301086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z2eGBeklOWrynQcAu9opvQ
	(envelope-from <netdev+bounces-301086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B96AF510
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:09:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EFZvxq8V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301086-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301086-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2779C305B960
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EC3A7F4E;
	Mon, 22 Jun 2026 12:05:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3D03A6F0F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:05:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129935; cv=none; b=daYX9Ez6/ISA6jh1WvdM64TlOEtjx0TuDR0iN63YPltTU9VnzVzKo97R8cRMoeDrd+G52U1njU1fboGOnvN2IChPKuZ2J+dIiiDMqD8EE6Klj0IK2sl6a5NTD8c+WJU9qucgMwSUNr3hHHP8R3yyhWmU34BhiGLEzXijX4OqKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129935; c=relaxed/simple;
	bh=+XXLsYvzWy3Cx1K/Ya+/rF2zKVvfqM7an5l9XdeQbKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9mPFjMWIBqrBMnGt7Xr5HBYZOKMOEvgHaG+Cwx6SVyIDtKD7p4ba9VTlkVuL0Ad0yXs4/RZiQPvQ9IFsluWr6NXuyKfyBP0ANJsV1vUex5RquBT31TYEpFV8NCDOdcvtfxyF3vfrfJcTpjNTXd0Iq1QNi8QM9tLI79d/Gt0H7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFZvxq8V; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so30772385e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129932; x=1782734732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlnP1BOraaXzt3q027zNJ40vl15H69zIaffK3Fv5n80=;
        b=EFZvxq8V0slF1A9+9wfeZnie7mlUwVT0eHLwPKzOtdYtaTBnQTcHGdpxqP4/feSU/y
         QSmuBBaT+4/hVEKTeMuBAUCBqNbNTvKoVycksAjScX0ZA+IK9NKTiuWeBuFkX59UTjQZ
         RfJv2+VSxkHRSF3VFpHpaRF3p/mvu31UZsGJULn5RocozCh025GS36JetlM2ja8arEPy
         hKxNfnz9EY85KhpVNOoFV7q75Rzc94qpqNEcFpnTzaEOP4pxXsAl+cn0n6N/JEOGl2OG
         upRMjxALwU+5qNGTHcPvNQQJiH/KgZrSrxZEE5LuvWUfB3Yq7yb629uUwnC+GKy5WRv6
         U0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129932; x=1782734732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlnP1BOraaXzt3q027zNJ40vl15H69zIaffK3Fv5n80=;
        b=HUtxKyeXJlEpZRdDKTz4RW9TPOMwuvKgchV5qRGGiX0NMaLQhV01iCbPgdqIICzezS
         0LtHzLcMClXgN6j/+cwlX3kYJstUXGJ/ezHCBmoHlM30+Wefrx87wvVMknC52GKgEErv
         f1Lchzb3zdb1GhWcV9CoYpTkItnewpgE+GQqQPAeURMIhWqeUe8BQhkFZgGlk56q2FBe
         LvXVpwgVD6cV6mcET6DrEalBdniiHknZ+Prg/6yy5OGynAyO35QI3zz9GiD+0BbD+X+9
         TttLHtWs6dJf9aJLdH5s21Ns+xRrlNNEOXu9C2daupQJhYt3w/djjyNMH0uoTkIAIIKy
         RktA==
X-Forwarded-Encrypted: i=1; AFNElJ/slLnLlP0zpUPbd5tbUp5+df/VlrvE9AnMGfCTYfuBnCSbXoxoowA+QM6At7KkKJeazkRc5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQGxPQQGeJ/FvNU9R0zqWd7gXMeN92Vu8s3iSrC8VCOCk8Cdd
	etvzzkmZm3UrZhTg47l5X0ieuG7L913Mbtk40MAKvcZAI73V6JGRs6np
X-Gm-Gg: AfdE7cnKukmGfypZRNOzMUniApbgS3wt/Yq6zIIGCwnaCk0eeerDbnast+uclvc1VeH
	Q0KtbwZHVgkv0SsnSwiqqVEpl7yguJ9mUWHNCz/+Dv+rInY9p2huyDuDzPbCr8N+XeLgRzR9Xff
	86Mm7qTwap7ffp43GI3cx00nmIgKIC/2ErtjQQ6e+UfuBIMz/4laVpSdxazhT0e158NWQyyCFhQ
	r3DZ1JOqB25HH1KDu48bwr03y/RTqWTiYpbWDU3nk9R7VNbQceq4Ua6ajzc+6SKQnJLDi9siEct
	b3bU2ezRRlLnViTcMKHjBaCFoL2FCRaYECziZbqpsaSgU5+p85E6Manr+Ea2o8Qzq3lUBvUOGud
	7fgP4FpzmO8ldwqTsdvx8ZlJdJLIlpMHwwozENXwGK/trM1X0sX15/ea4R2wDb+WHNZ+fi4jGzH
	klBcjy4ExsFR5BveT3G2+AhpTz1bw=
X-Received: by 2002:a05:600c:3b99:b0:490:e5c1:b897 with SMTP id 5b1f17b1804b1-49242572367mr225762215e9.20.1782129931181;
        Mon, 22 Jun 2026 05:05:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	yonghong.song@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v8 6/7] selftests/bpf: add bpf_icmp_send kfunc tc tests
Date: Mon, 22 Jun 2026 12:05:14 +0000
Message-Id: <20260622120515.137082-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622120515.137082-1-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301086-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 512B96AF510

This test is similar to the one with cgroup_skb programs but uses tc
egress instead.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 25 ++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 60 +++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index a5ac1a6ea77a..66447681f72d 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -178,3 +178,28 @@ void test_icmp_send_unreach_cgroup(void)
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
 }
+
+void test_icmp_send_unreach_tc(void)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, opts);
+	struct icmp_send *skel;
+	struct bpf_link *link = NULL;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	link = bpf_program__attach_tcx(skel->progs.tc_egress, 1, &opts);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		goto cleanup;
+
+	if (test__start_subtest("ipv4"))
+		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
+
+	if (test__start_subtest("ipv6"))
+		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
+
+cleanup:
+	bpf_link__destroy(link);
+	icmp_send__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6e1ba539eeb0..5fa5467bdb70 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -2,6 +2,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"

 /* 127.0.0.1 in host byte order */
 #define SERVER_IP 0x7F000001
@@ -65,4 +66,63 @@ int egress(struct __sk_buff *skb)
 	return SK_DROP;
 }

+SEC("tc/egress")
+int tc_egress(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct ipv6hdr *ip6h;
+	struct tcphdr *tcph;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TCX_PASS;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		iph = (void *)(eth + 1);
+		if ((void *)(iph + 1) > data_end)
+			return TCX_PASS;
+
+		if (iph->protocol != IPPROTO_TCP ||
+		    iph->daddr != bpf_htonl(SERVER_IP))
+			return TCX_PASS;
+
+		tcph = (void *)iph + iph->ihl * 4;
+		if ((void *)(tcph + 1) > data_end)
+			return TCX_PASS;
+
+		if (tcph->dest != bpf_htons(server_port))
+			return TCX_PASS;
+
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		ip6h = (void *)(eth + 1);
+		if ((void *)(ip6h + 1) > data_end)
+			return TCX_PASS;
+
+		if (ip6h->nexthdr != IPPROTO_TCP)
+			return TCX_PASS;
+
+		if (ip6h->daddr.in6_u.u6_addr32[0] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[1] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[2] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[3] != bpf_htonl(SERVER_IP6_LO))
+			return TCX_PASS;
+
+		tcph = (void *)(ip6h + 1);
+		if ((void *)(tcph + 1) > data_end)
+			return TCX_PASS;
+
+		if (tcph->dest != bpf_htons(server_port))
+			return TCX_PASS;
+	} else {
+		return TCX_PASS;
+	}
+
+	kfunc_ret = bpf_icmp_send(skb, unreach_type, unreach_code);
+
+	return TCX_DROP;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1


