Return-Path: <netdev+bounces-300612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VYEWE5TiNGo4jQYAu9opvQ
	(envelope-from <netdev+bounces-300612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDF6A41FD
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:32:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F01I2N3G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300612-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300612-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2151F30D43AC
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD953546F9;
	Fri, 19 Jun 2026 06:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54A34F255
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850663; cv=none; b=UnPu0Qy70Zn5Fvjvk7q5+a+U++JMQWAcUhDs/4p5b/T9wWN8fSjuepe9sX5Doq03KDP31G5fgsgKFw0sk54hNwFJHzkbqdlN8C6BSIUtoQ4kSVpJJZBxErEsEO6I2Vh5G7mbuJ5XkmOU5dQOSqGw4LxO28+WmDw/oNMHyJSJ7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850663; c=relaxed/simple;
	bh=YS0u1EKD53vo2t6W+IEib8k/HgYIgbkb0atxBhbXQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvzSusI7o8A5nv7WhErpnP4ZH2UDUKucyZ/hdQ5Ni68YGFFYhBKH+JhVraGU5TeTDSRccK4GdkNA91WHwT7SxvVIKG+eELHv7+8OaLNrOYpyzlamvrWa75W/e25EVOWx1J+5ZPKraQEnzf5dTgwKJmGhpABe3qCs4ncg6lNLXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F01I2N3G; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so1284358b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850662; x=1782455462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=F01I2N3Gsz2fPxhJFaz/zd7SIEU2U28sa00lnrMprURx3igiDP9Hl0nXV9WmO/nOEl
         +E8qZhbJHd/jjTlSIJ1VDZe/6I2zbdoaBLuvRAUTWNfY0iQnm4cFF0meFPrzBm1UgKw6
         rlY+0zzgQFP661GZoH0+ZNvW/2bT8yPRnV7lx8+8T0Og0OFC3ZbMC2E09rtM+8+kdsU/
         I4Jjpg2viX7o9Fw5DpdVznDUFvWhjzL7sEuTWX5YLuixJa2FFu0h4dNn0p7f1nxBzCRd
         VLFFR6MEjjOYUXrXU3kmV+4O6KWVm1H7s+JkH8geuNNA9snZMu/cev4PD9sjfI9FrEXd
         Sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850662; x=1782455462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=P1BCNDUdELqcKixTSzATbYk+OFTXLZonS8KARs1rw0vrB5zNfXTQks45tmF7ZYPzTY
         alf3ffgbzIAfvm5hq0STMXgvDKmvmU/AZ8Irapu2PxDwY27TaZdHEN+1QXqiBf+XUUyX
         c0ta0mCcORdXwuv6dsGCGHsBEWCOxDn0Z8+KaZkv8WxUOJ8nW1ue2WstpvEras7Tz1GA
         37YQkTUHj++A5Pen9LCVXZqlKRdwIvJb/XWQf7lsGVDc9RXwQ6LPkwkt1bw9NwcuiC0+
         jGaGd/bvLGinWcFRCQ42PDNLVrMxb/QeYgiXFHe5JaB1MNZ7D2lO2Nkw2XnhorwpAtOV
         NkpA==
X-Forwarded-Encrypted: i=1; AFNElJ8mvWs0ufaVUTWU67NCxgYakP7AgCARx6TpzUqiWG2x2+BXJW7Ls8IbakeHfAoPMEryNJFtGdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0a2KMJKI6HLsKmGy2opakek1s/nqpsU8x05cA5ahq4TNZIgkY
	/IBMAsKfLJkBoceRc+8e09+ARc+bEQCW97y7aCjO8+hleQgl6YDYNn9V
X-Gm-Gg: AfdE7cmNl7eZWLByYZf2A+2PVD1iCMEQrAxNLuv5KoaOox6x54HGbR5bECzmKygzFAb
	KQjRtIKfOfUMi+8wlI2pds0815wlptBaiMMi86Uazvcjik4yjtGB5Hgqzh2EWlQAFQO9IJvEMMM
	SAwTwgtvNDuVf0xM3pIg//HAnEhSwKREtpZYHp5nYOsfeZ4FtYwe2uLiTxx6fs1HkeVwolIiw5+
	bwMbvYI2nSgR9iPqQ5IJbgmL3ULjE44VNfTZfAhFRUxdrpOsfW46ZigfOABbL3YRKG7hZ8koXNg
	hPoeBVEW+zsfcv5JDEZOGGuUSxu57OXYiMeLXNSOvojQAJk8aiCv4HT7RxMy43T9S3wM4Hyu4nQ
	64wo1/2IOVQGmOgMizoDvG6KJHpsYjwvMXfL5lEb1xN44i6qg4wQzRDRzJDEQvHlzov0GD9em1m
	fT7APiqZQ2WAZE2oGWtM3BsHKNLQlwUhYM6CYcgEhrY8+0Iu5fYEK6qznov8wwDQ==
X-Received: by 2002:a05:6a00:3916:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-8455604dfa2mr1641891b3a.9.1781850661847;
        Thu, 18 Jun 2026 23:31:01 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b886sm1380096b3a.51.2026.06.18.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:31:01 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 3/3] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
Date: Fri, 19 Jun 2026 06:29:52 +0000
Message-ID: <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300612-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:kuniyu@google.com,m:willemb@google.com,m:shuah@kernel.org,m:jolsa@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBCDF6A41FD

Verify that attaching an SK_SKB stream parser that can modify the packet
is rejected, while a read-only parser still attaches.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 621b3b71888e..1d7231728eaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -431,6 +431,35 @@ static void test_sockmap_strp_verdict(int family, int sotype)
 	test_sockmap_strp__destroy(strp);
 }
 
+static void test_sockmap_strp_parser_reject(void)
+{
+	struct test_sockmap_strp *strp = NULL;
+	int parser_mod, parser_ro, link;
+	int err, map;
+
+	strp = test_sockmap_strp__open_and_load();
+	if (!ASSERT_OK_PTR(strp, "test_sockmap_strp__open_and_load"))
+		return;
+
+	map = bpf_map__fd(strp->maps.sock_map);
+	parser_mod = bpf_program__fd(strp->progs.prog_skb_parser_resize);
+	parser_ro = bpf_program__fd(strp->progs.prog_skb_parser);
+
+	err = bpf_prog_attach(parser_mod, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	ASSERT_ERR(err, "bpf_prog_attach parser_mod");
+
+	link = bpf_link_create(parser_ro, map, BPF_SK_SKB_STREAM_PARSER, NULL);
+	if (!ASSERT_GE(link, 0, "bpf_link_create parser_ro"))
+		goto out;
+
+	err = bpf_link_update(link, parser_mod, NULL);
+	ASSERT_ERR(err, "bpf_link_update parser_mod");
+out:
+	if (link >= 0)
+		close(link);
+	test_sockmap_strp__destroy(strp);
+}
+
 void test_sockmap_strp(void)
 {
 	if (test__start_subtest("sockmap strp tcp pass"))
@@ -451,4 +480,6 @@ void test_sockmap_strp(void)
 		test_sockmap_strp_multiple_pkt(AF_INET, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp tcp dispatch"))
 		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
+	if (test__start_subtest("sockmap strp parser reject pkt mod"))
+		test_sockmap_strp_parser_reject();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index dde3d5bec515..fe88fa6d40bc 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -50,4 +50,11 @@ int prog_skb_parser_partial(struct __sk_buff *skb)
 	return 10;
 }
 
+SEC("sk_skb/stream_parser")
+int prog_skb_parser_resize(struct __sk_buff *skb)
+{
+	bpf_skb_change_tail(skb, skb->len, 0);
+	return skb->len;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


