Return-Path: <netdev+bounces-235992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7290C37B7F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646593B3009
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AD34EF10;
	Wed,  5 Nov 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WE5QKJ/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF134846A
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374016; cv=none; b=ajlwvOPw6iaiFXwmyC113stjQuFfoHDlCYFRx7wKVhVipl7ml0swUklEDKY58B7l1lKifYKZFDtiVI+z/5vZrDZPzLbbqBOux8IcYYdyTGyAZrHEf2Z/Rsn0YMXob3k0ngKcam85PNZ0dTL6vmbPV/ahPuNLtHnop7QxkEMZmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374016; c=relaxed/simple;
	bh=3T/Hsy7D2ETU3ts6jORrqLbmSWADZQIxylm0XZst7/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+yI/WwnGA2cN6hf4O8/8wd6R7YeuV3IOFXJEPstQnYZU2Dzjxe+xHBCJf08B8KY21VtaLjecVdQ7jJxzQhpj7JsZvUq98ZXEOF7cWSY7aOJz20tnbBNsZoMyDKuPV2Kibd9w/ee0xfnMuW6idF1oZgXJmUzfIu2m0Uvh+39CGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WE5QKJ/l; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so291385a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374013; x=1762978813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+Gn/d2JoZxtozCB8xYxnRk8/St3kahnkKyT6VkGXO4=;
        b=WE5QKJ/l70e6rQ40GtBS/Oyj5jCziP1nTW8/j+lM1FBPoeTBzlXd69By0gLdT7Fed5
         Xwc6jNcRit1HtZwZxQQkA/L5ck6xojbXsgOVoJvSZAGz9Gb05n7A3kAO0lMweYtiM+gp
         2e6Elb3Eptoe+8r1cUm3BGzbKGelMrT4acTfPuzdM6hd4m7v+KzZELOEtdnY/JPyAB7E
         nZobb7UpKzvb8q/XV6tHCqhlDnTU+FBh1wmG51/B6sftl8Yzd6AKp0Vy3Zyru2yI1Byt
         un282a5XUFlJQU7ImeM+FnprJSdRsmNwXg9/cM6B7E72Y91ktezlbF5xSW2cOS5c8VHJ
         ELBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374013; x=1762978813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Gn/d2JoZxtozCB8xYxnRk8/St3kahnkKyT6VkGXO4=;
        b=JGkL4eCJv01HJJtDXNC2YbeC63zgxYKtywaIjariw3Uun6lUIfr5UxJ6yjCIr7BlR/
         2lDqF6Vhn4LpdmQAa6M/ZIboVc4NuRAFeVNfzxkfDoux8M82CfQf1aUAhjyaz2YqYFsF
         Jil2p9nArCnBgU0+CzkjXCgt6YCiX18CjtpkFb70S2+INVIWJyENcnpSV8JbAWa5UvRT
         2Cu6TMV0q9C6VZKlwD7CvVcZ3eTWiSu3EyElBuhzx9RvuiJOkxQApP8rt0WVSpypZDtM
         raCQ/hhlv4F4aYa2ZWN05/2OggHKG7otthPvWk/FzsD+3cl610pScIFArGpzx+D66TpU
         pMXA==
X-Forwarded-Encrypted: i=1; AJvYcCWcOqGznWeoLFxWkuSEFg7uNc5N799nUW0zq0W+EuPTR1OYZT5glxFx0RjjSsFhY3eyscElLZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoGuLLTEGPeK/xi51owze/gpjuuuh0YNzApgFCsYGytm/cfe/
	P4315IBHZFOfVDAqI22QxuCbwUZN80AIuZbbRSvOrsXp8kJkGlSAA64ozTCXIgP5nsg=
X-Gm-Gg: ASbGncstHWJ95nVr3Qp3vJEIgGelBh2Tvc43N6cM0uwhhaYdeaovu3/m23pRY5P5kxA
	1srZ2wwrowK0H/qGPRNiQOsTqUktTSmwj4zo9u0PZhX1NYVnWB1572XECIip6wxchRlHsJt6XOD
	Aw7ZOkb+CQOhGanNipe7++koxab8ObZ18WhPpHa7/HJgT4lZltpFC10Ib5kSvkYmLUUKPHlMA5H
	Pza+NFo4i4udfQIXS7ETWfpOSEF41iMV5DgdJ9pcoQsJL0YrSOF8Yz7EMeu9criiG27rpMI1KPa
	Wp+NpzlUfRggCHsUHXknH4bsE1+2zgzpLZVD7Gq7HpLAiOWwfW1RrQ4TxJz0v4jzXXphMHBm9V/
	DXY6d1ejBaAN3Qt619ddfKM12HxBN3kRqq/USuFEUS6V+tWaLVaeBHmggngGjjqasg7k39hNciO
	potFEDux09UYpoVeSRKFnzAJQXMQYeaA/mr4uWIyOfCwkKNQ==
X-Google-Smtp-Source: AGHT+IH55QIrXwitElfIiKYgLCa3R/SABjslCUXi1BGuRmgPCsnX+RhPrKYey2s1Zjo0Al85Wp1RBg==
X-Received: by 2002:a17:907:1c8e:b0:b49:2021:793f with SMTP id a640c23a62f3a-b726553bb4amr477373366b.53.1762374012586;
        Wed, 05 Nov 2025 12:20:12 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893342aasm49080266b.3.2025.11.05.12.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:12 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:53 +0100
Subject: [PATCH bpf-next v4 16/16] selftests/bpf: Cover skb metadata access
 after bpf_skb_change_proto
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-16-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add a test to verify that skb metadata remains accessible after calling
bpf_skb_change_proto(), which modifies packet headroom to accommodate
different IP header sizes.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 +++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 25 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 65735a134abb..ee94c281888a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -502,6 +502,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_change_head_tail,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_change_proto"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_change_proto,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index e0b2e8ed0cc5..0a0f371a2dec 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -4,6 +4,7 @@
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
 
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_kfuncs.h"
 
@@ -645,4 +646,28 @@ int helper_skb_change_head_tail(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_change_proto(struct __sk_buff *ctx)
+{
+	int err;
+
+	err = bpf_skb_change_proto(ctx, bpf_htons(ETH_P_IPV6), 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	err = bpf_skb_change_proto(ctx, bpf_htons(ETH_P_IP), 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


