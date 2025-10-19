Return-Path: <netdev+bounces-230731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40FBEE590
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13812421963
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E12EAB72;
	Sun, 19 Oct 2025 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OE3Gki4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E72E973C
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877974; cv=none; b=umanXIjCL2Q2iU6g9K/nURdaMI0jBGFFapEqRu4IQI9mQ6Ieh071z9VcIIzvHdDVOu1L0iIzN2stlf7wc7iwNGS5pt3E8aTPfBUSOt4zCVqumevu3KaapDFgzu4zd2VHhNAWwXzA7IJjodaZJD4CftI3XgcRE8MHM4Y+LUPideU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877974; c=relaxed/simple;
	bh=YHy9xHMIb4yPr7wULSwsiYknsP7ln6RhfLiqyDd6n6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyOKvIySUkCAd5jYs3yW0x3hxIz4cQ5WiAKzfOAloWr2LnWg55SBSFhLMwf8Ch6O9hoofMCHbsEmZvCot2hUCGLrD1Ff8o7nn3t7E14dPVPcqJC2xLvy0gLuspPAxe032ixR0RyOvCjBsIiw/CdNoLFacrXZxI1IIIjJbx8Cnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OE3Gki4S; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso3167476a12.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877971; x=1761482771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmhrtKbFOuYR/bZCr0kTJtzEL+ndRJ/n7qpkLkm0d34=;
        b=OE3Gki4SRzL4h4IkAc0nlnF+xris8u5W+k6RkFYckNuy87GGNYZvFg+NUeYtm1B41F
         xgWKn5veO7y7aM94NsrhXhuTYzTkHhvwuEBYOCDtnqxr6RA4SNdJTPGQg3SNkLH2rMBK
         9PjVBGExhaovRYxTAdNvfkmewuEsvDaR3rvN8TehQMag2n1XQC3h8tSqvzdCG1edLaj8
         S+rZbEzn4KYd2HhUYmabeJY7vtvhqhHMaU6TwC7M7mhEK4KEfpN6V2vF/Ss1TG69Gd0M
         t0o1256TPrjkH4UspnqsdLE8m0GGiXMgma/qR21VVrO4v6RbX0N73yW04zACApLnrTHN
         ZsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877971; x=1761482771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmhrtKbFOuYR/bZCr0kTJtzEL+ndRJ/n7qpkLkm0d34=;
        b=hHAtDL43fd0oeDLCJuD6arfJwWCilIPke0K7C8iY0eBEjxnG56Lv+wffEw82H+rf0c
         NPQiJ+/UmRV2g/aFFiL+q72chcjN/zDPleokYaIW0d7p7FdsB8Sm7ewm/a2IHgX5icV4
         GbOLXVqd6DFkJ554FA8/y9FEQMsGZ8xYFJbDjOgRoCc5gCPUQVapGtvDIGbYVaah4ds6
         4XLeBGP4nQJpNnUO1vYA79+Y4O080bHYdtmVZ8xBHnMeUez2MmcHWtcL9K64tAO1cIRp
         wI19msIN/nmNlpDUkmRMWKYtvEK4dF3CwFKlUVyK3kOUcfYLzoYpL2Gc4uI9Ntv4yD5Q
         /gsA==
X-Forwarded-Encrypted: i=1; AJvYcCW46lHGyJG1Ff3JrnrNz4DDYpJ1VS9CFdbnX1aPFASzurXRr7Vr4evd7iFNIes6peLx2eUitvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+2YyBvZEJ8eoSgPM5gJvP4y1pTsonhNsqjyOZn+BA/J130CG
	i5v157p80tqjh11sLwmDut03/lV/ZvO/0+LLahO5AzNGlxaPe0GFCZOi/ha0NoLlyDK+HRcTVun
	JK9C1
X-Gm-Gg: ASbGnctJ3JTvd8dXqnSxCbTZ5nREHyixBMTjIPVXlmb1Ngx6DI62idKY/v7TgrR7HCt
	DE8/Kit4S/csa0yrJ3XWL/j1KnlYGmIL0yeNu2cFO0VlpUgYh499BwuHOHqix68gcvkASPUhB/a
	AxwYdChS1qkiCm381BHYYrXEyy3JKHXfHvAdXbgRmkaH25/ZKSf9fityjtBenmWOoN6pbqw7d6L
	7ctXusJPFOjyrSXeVvMVtA78XDpGNeToz757+Q72q2BE90vSQX0VLeqNJw5UNw+4LTAD7eV/WHK
	qPkFGFkyxd432g3l7huurq3lcNMrl4hqpVytFd4D2huJqXqk/UWLcUfhRuZl4fEHlIkzpg1g8m4
	LB24vmYZEWC/G+Ea4MeiQb9LnCLtwFoMjPDbLM+dWiHlf+OfamcEdlNOmJy+XLlbKmUJM3eYa2F
	A+4XZSXRsNVzGYJ88f0Xj1fn7ZUjrSQ3J8u1eo3H65HclXrT5/
X-Google-Smtp-Source: AGHT+IEVT1XLwp7GU591cSJDVF20RqDyC+AqhaMHKO08eKKyCbozzhN9a7ZNM8oCKN0SRLEhux4Uzg==
X-Received: by 2002:a05:6402:518b:b0:63b:6b46:a494 with SMTP id 4fb4d7f45d1cf-63c1f645584mr9302179a12.14.1760877970780;
        Sun, 19 Oct 2025 05:46:10 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm498321866b.56.2025.10.19.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:39 +0200
Subject: [PATCH bpf-next v2 15/15] selftests/bpf: Cover skb metadata access
 after bpf_skb_change_proto
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-15-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
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
index 8880feb84cbf..6272d0451d23 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -506,6 +506,11 @@ void test_xdp_context_tuntap(void)
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
index 30ad4b1d00d5..6e4abac63e68 100644
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


