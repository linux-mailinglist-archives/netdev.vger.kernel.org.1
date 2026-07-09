Return-Path: <netdev+bounces-306289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0phPBA+3T2rInAIAu9opvQ
	(envelope-from <netdev+bounces-306289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D217328E3
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:58:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iZ6gLnSz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306289-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0189230DDD02
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4193A3E8321;
	Thu,  9 Jul 2026 14:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88727389443
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:49:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608559; cv=none; b=qidTRgah8sHJNBKj8NI75k9OwbsHfAr/UIO0XmUoQsn8N8FzjWI+totTLmoG09FxhmbR+tepJrlTiairctR5F2nynkAQpPePcibaXdhZcjW9pqZ4eucB0B4sFKQszSErP56rUmxxfIhwMh8MSlrBZqDcELy6obPjP47S5tH1RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608559; c=relaxed/simple;
	bh=EitmCVy+LU3Q5DzsSwudd+EqxxFPElWArb9moAc+YuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpXN/ycZIS2/Jcp9D9EPqzzzZ2ObEwz9R0t9WciApJ+agiFPe6UADwJEU0VLwyB/2yLOAB1c4G5X+UxHfYDIc5T38zCYc/7joBc/Cl0P5WCR/XYkVSDuDHSEu0691qIvR/tdAX80+OZvlzLC+MAXzu8KbRlAWjnsMS+CuvOUrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ6gLnSz; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ba701891so14737105e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608556; x=1784213356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OTlVbX3QZZA0ufld2LOVNvKjP7TAMS4JRgxjqJ7SLM=;
        b=iZ6gLnSzT+ii7VcuiR7LyTh6aF5dqS8TFuz7w6jCrdhv4joYaGlSci/7IH1Vw0v0bM
         MUZdOiUfWF2KgHxFoRil+gd5DPQrS9amHLd7uEQXOIPvP9alJS4khfOTsO20KOjO3TwK
         71VoKcw9b41oPNiZIFFXuoanEySQcTvGnKd9qteLTjQIToeQ7aUzUga5C6yEM47UkO7o
         Td7LqXoGua4Z87e4PyBFtR3B78sVe4QLrBaWRzI6uWFtxtTv8E5ZiI80BH1R2/CSvDy2
         GdD0fn98KKnrv4HB1r9quHXKx9qDHHzu9jB5chfeWAJw/xgKQFfHlegpMkUfrhqj1dtg
         icqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608556; x=1784213356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OTlVbX3QZZA0ufld2LOVNvKjP7TAMS4JRgxjqJ7SLM=;
        b=RiQ8deIXYZVKNk+8CcwVqthucAgwhD7EdltQ0jwmhfnbTlSDuqtrn8nj2hCxzkjcYN
         CQ6HBC9d/LLv3yFjf2IWa02CsPAKbpve/gyNwqgF8Kqm2Pk1odz2YDDEvf3rdsMB2Nfp
         ToDpCbNAwa+LsXsCQiWrtbJ1DUcmeOkNZZecib54kjr6N5/Dz/FYEt/zNI7qZQ63HPlC
         rUKCxQ/uhm5n9WJL0LVgm50KCLOBZWcwRpaUL+5z8KG1TZKV39c5GvqeJW++8OUQYQ96
         CEulN7FiNNlrO/SouUiy/Yq6clDSKcd1zkIyquzYmu4ul4wuR8wbUCJYcthdHSp6JGuc
         d/+w==
X-Forwarded-Encrypted: i=1; AHgh+RpCj3BEhsMhATLM5XG1s5teVTI2WMRVRGthyPmFXiZlEmjXmPHU8YQuZk2Xsh6lhDhoKNREyBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqjbYQQZO/+WxajexPxkZKshWGGY/PlRYkM/OO21x/zZHQwCZ
	7qXrD0InqWZ0N6HFdjhQxX7/fktzrgviU3p/jeLMar+VT4QhYHkJ/Idw
X-Gm-Gg: AfdE7clK6clJQiOS4adkaQUrcKFZN9HGiauFDSIy14q1r7s/Q0r7rS3BCz63wkpNIga
	9FpdDwzhhFVjs+/yiBRTObkHLETot+vMnbDgbq8D9JhT3medHl5oZJksGOrJDxqhonhmrpD3z/r
	E1Qttu3NfM4z7/9otm003qFsWsSOHYwWq4qWhtYSxnCkaikWqVlHovrsn2lYFnOYGJy0QUZxkxr
	G48edIHrRRLGb/j5lDxIF0DlukSYjRMdf8LlScnIT+yYZRKk3aXF5c4jF2z1mddpaU8fP390vBi
	8Euo1t5FAC3UxRm4Yso1/72YxVs0SDLg9wXIu+wv7vUKjRA9GVNy6a5EQaHivEnBagcMAFHknov
	Y6+H91g+VxK797nrJ8ls0LbxrHRjLrVhWOx2nztwdrxhvHyi+2p+Wcxix94puU5e4t79nsyeFLK
	DGaTwB6qRUPfYKf2thcxZM5kl4oiHnbZhzbvVkNrxGTrnQOofig9yB9IKIi4oqxhW1dZax
X-Received: by 2002:a05:600c:c8a:b0:493:c3f9:65a2 with SMTP id 5b1f17b1804b1-493e688cf81mr79336805e9.5.1783608555943;
        Thu, 09 Jul 2026 07:49:15 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:15 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 5/5] selftests/bpf: add bpf_icmp_send no route test
Date: Thu,  9 Jul 2026 14:49:00 +0000
Message-Id: <20260709144900.245904-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306289-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:sdf.kernel@gmail.com,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,vger.kernel.org,google.com,redhat.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jrife.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63D217328E3

For normal live cgroup_skb paths, the skb should already be routed. The
exception is for test run via BPF_PROG_TEST_RUN with packets created
via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
would quietly fail by returning early.

This test exercises this and makes sure the kfunc returns -ENETUNREACH.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index bb532aa0d158..9318d4bc7ce8 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -169,6 +169,49 @@ static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
 	}
 }

+static void run_icmp_no_route_test(struct icmp_send *skel, int af)
+{
+	union {
+		struct ipv4_packet v4;
+		struct ipv6_packet v6;
+	} pkt;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt,
+	);
+	int err;
+
+	switch (af) {
+	case AF_INET:
+		pkt.v4 = pkt_v4;
+		pkt.v4.iph.version = 4;
+		pkt.v4.iph.daddr = htonl(INADDR_LOOPBACK);
+		pkt.v4.tcp.dest = htons(80);
+		opts.data_size_in = sizeof(pkt.v4);
+		skel->bss->unreach_type = ICMP_DEST_UNREACH;
+		break;
+	case AF_INET6:
+		pkt.v6 = pkt_v6;
+		pkt.v6.iph.version = 6;
+		pkt.v6.iph.daddr = in6addr_loopback;
+		pkt.v6.tcp.dest = htons(80);
+		opts.data_size_in = sizeof(pkt.v6);
+		skel->bss->unreach_type = ICMPV6_DEST_UNREACH;
+		break;
+	default:
+		ASSERT_FAIL("af_not_supported");
+		return;
+	}
+
+	skel->bss->server_port = 80;
+	skel->data->kfunc_ret = KFUNC_RET_UNSET;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+
+	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
+}
+
 void test_icmp_send_unreach_cgroup(void)
 {
 	struct icmp_send *skel;
@@ -193,6 +236,12 @@ void test_icmp_send_unreach_cgroup(void)
 	if (test__start_subtest("ipv6"))
 		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

+	if (test__start_subtest("no_route_ipv4"))
+		run_icmp_no_route_test(skel, AF_INET);
+
+	if (test__start_subtest("no_route_ipv6"))
+		run_icmp_no_route_test(skel, AF_INET6);
+
 cleanup:
 	icmp_send__destroy(skel);
 	if (cgroup_fd >= 0)
--
2.34.1


