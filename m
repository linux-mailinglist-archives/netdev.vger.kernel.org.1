Return-Path: <netdev+bounces-300775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jid3Nh3/NWr66gYAu9opvQ
	(envelope-from <netdev+bounces-300775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 04:46:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 449086A83A7
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 04:46:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=X7kWZhmU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300775-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B6330A37B9
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760CE1FC101;
	Sat, 20 Jun 2026 02:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DB1A9F97
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:44:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923497; cv=none; b=VTz+a4v6A7cFunQhxzrAueVGR8EuicTG0hoG96VEeYc9uhzBZ+Tg+dLZbYDtqgRhucN2RzJioQx40jno/YZe6c0vkbYDIvgUNdLygqF/RL6dGZKLpPRTmPs3vnmSBVCoLmJ/Mk/vwboaQlNBmY0dFI1XMsprj8IqhWjejge2REQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923497; c=relaxed/simple;
	bh=YXXYvTua7xSnHRRQX7UMZYFBwjxqSm8D+R0Oz3PNVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClnmQzwg67yj/LU2QkgxMqQIAo2qemycDIrMsD8YqYEKe+oSvW9Lh5sOJgBY3TIUskpsFDL4AZIA+x2nEmnsHf2OiiRQhwyyob0Y4loPoON+2jaI/n4nksneKu98igABevpn/IMGQfiGHdnLSdhJK97tGE0JQnkQObngRmrrFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7kWZhmU; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37c8e7c8137so1365918a91.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923495; x=1782528295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoheuMpaBBYEB0ARICeSI4vr55A0uKbRHvd5QkzvWCs=;
        b=X7kWZhmUZrK3J7H/3V5xmtseDKk5KU1sA4ueKvNdkrDLh0XT9ziaCP6RpzQgdI1eR3
         8F4NdXcrVkGaypjvUKNMpoBJIJ90iDQRSuk7I5itD5E1rUsEr1Ed15/cN0+4N0MMefku
         JSjZ2KAm6TMShnentWZJX1WBAyTvHgGz19baF+hoUtxpOgfX+x3KuL/ufZL1rO1mZCsv
         FRND7ecxlhc0dpVOpYqtO5geqfCK6e84JD5QHgf53VBWDi4TwJjkvwjvddnoLOp2PtiQ
         T/Jp4hVraSQD7bkuD675nOx0DVPosEvrNcLIpM/z1phLj0DndLtHogZ2xap7od4+9Dpd
         wnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923495; x=1782528295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CoheuMpaBBYEB0ARICeSI4vr55A0uKbRHvd5QkzvWCs=;
        b=IImVQC7+S+kOtZAvoa3NeAo6Enpur9DWxPpUWVGxbpohU8G30scxahqgVxEp5XI5DD
         kWGyq8LrLsxp5KHEpSypv9hPj26GbGXpYCU6awEfsaNCtwf7BY0TJEqnvsMSsV8fyjT2
         oJ40SMMg9J9TfR/IhdI7YlF/VZZ2GPA2VMc6oOW1gs30RJ3bIWrr7Q9gZIpb3sIYWs1V
         HhkB9eTeMQf6s6dbiNF1WuoOi1r0oNd675RLbLTcvRHOqRaVP3/JiuHxpkEfVivpsrAv
         /SBzBo74yyXqcaYp20cukubJEln+nMpj4D/XZ5ol1rULE6L51NbyXz8y8jQ2U6SAFmUZ
         9WAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+14E6/1JlRtAc/G6MBw8u5YZG7hzjL8HMAQo80Nv8RTh5a0uAdMa9rTNl6+6Mg3rl9YsXS52E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULyCfDMnxLsS73KbZUW7mhqhhOhleNFj6HyRMxthxozta24wN
	P0edwjkJU2Lpda+JDsQSiyDhxXVduHC0eh4IrL/+Ff6mhXp48zO6L6/ybbwnl0kW
X-Gm-Gg: AfdE7cmUQrt29rFoiuAa9uYuKC5gA7RAFoIBUrnDwNfn8xPRPU+g+a1WbR+L08nmIX+
	dr7yQ4lG7cA6Aa8Xl5MmkTXd3eBR+xMA3TNEvDaOE0ueu/Hv42kuYnTjdUCgx24lu5IwoEYzKHZ
	lCKOlQ+UmDc4uTAVZs62KrKrm2odX7gZVPWeGI2AJ07W9Tw/iu7HowI5azeMi9WvQtQlsIHheeR
	TjjRU03mWEaBGhg+9jehTP49UAfc0IAJwWSI/f9Zl5D8FT8Co+A45qRDExVV4Tjit0iUWoX63/d
	cpaMD+7bNfCwWlMTAT6DKMZWcAQeF+mxJXS45ggGRVWlaUR1DAMq4Nv5P89vGtcFTXIZTv2khWp
	oMt8+ae0n1JOvPLqIFcRofstyaZ6kyV2IU1PaJ1gWOCEoTgopD5qkWqL048shfFGl5wVRomh8ty
	tOJwZiBS43EHpcqTU1BakSjOWkwFA0flbpQBgTQomif6j2ECRPtOQ=
X-Received: by 2002:a17:90b:4b84:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-37d1e82238fmr4681205a91.7.1781923495427;
        Fri, 19 Jun 2026 19:44:55 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1600975asm1087971a91.0.2026.06.19.19.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 19:44:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
Date: Sat, 20 Jun 2026 02:44:18 +0000
Message-ID: <20260620024423.4141004-4-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
References: <20260620024423.4141004-1-rhkrqnwk98@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:eddyz87@gmail.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:memxor@gmail.com,m:horms@kernel.org,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:bobby.eshleman@bytedance.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,linux.dev,gmail.com,bytedance.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 449086A83A7

Verify that attaching an SK_SKB stream parser that can modify the packet
is rejected, while a read-only parser still attaches.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
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


