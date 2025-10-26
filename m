Return-Path: <netdev+bounces-232983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEEEC0A987
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED24D4EA480
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40C2EC0AB;
	Sun, 26 Oct 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SCi3Z3Uc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14512EBBBD
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488341; cv=none; b=AVUW9rzYeVfmg36pzmzrzTf1RWrATk6Bchr/E7xAKs4Nfs9ORN/mjkUvCTDPwjzzH/eBxD2aaSLwoPrkjlS8Rt9uTckgr9H6L70HbSVrPmeBlYWRhJ8GY1HhGmmmjGApXwL4NEIeP5fPr0s2geQinTdZAgx4NJ4MrbphkjP4Oqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488341; c=relaxed/simple;
	bh=rZB0D5lU4hPSx7eOKffaSxhoQpW9i+v4/2uc4+gKerM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfAy85xb+4C/eKbomDYYGviy8byoeOBzoFHqkhtktnaaG0kGbxHhU4hjxs2W9vKcn+alj++tduBohLrqNZgLMrxkwkarp03d2zpc69IauEvy4sFW399v75RaCKgX30yGNSJs7pFPWyZjzUW64sVxmca/BOrGp/Y4EwXQKeSjvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SCi3Z3Uc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d83bf1077so327913966b.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488338; x=1762093138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTW2Nhp6r5vZi19YO345NcsgOGp3VdDovRh/l2yqd2A=;
        b=SCi3Z3UchV8slNkpQqmcU8HL0Uysw4Vh4Ucyk44uGDXQOsy4si65KODh8FktMDH6Rx
         iFqERCMZsilRRN77dvVp9NqLX43fymq53AZafj7cAh62KfP51HRHcYIMHbc54TPTaetX
         +HtDfTEF9uBJWl7upu0J81WjgwyoWCPaJCeSymcav5HiWwpNmGqdGYhD99P0Qigby3bC
         /DaujVoxbkgiqvbTIE9COQuu7R+v9KVtktaPOE/eEbGQTHmYe2wwkmaNmzD2MPJOjWLO
         hNXqU05u84Adwqpdnollc6J4fxQVLrU+FjZlqTaS9q+Bh48xhmpDDCS21aeVn8BZLt+C
         ZvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488338; x=1762093138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTW2Nhp6r5vZi19YO345NcsgOGp3VdDovRh/l2yqd2A=;
        b=Wxux92/+9crlg1NhXSft1oF/8p+S8SVSZWCj5lIlPjT2CHKdwTDAYr/Z1UtrY8dp3M
         t0FK1dFevC9PkwnEACT5goiMpnflnBbnGGw3R2D8aropjgQBZIt2wSfrBhD+cLpKUHfa
         U5HJzI44gRkYmCA/BEAL83JEDpHjibUvAejJxweqPhdvWqTG2OlX4Nk8bzHe2k5bU5Wp
         /AISgarmrVfzC4p6+iuJeQstimK1Z+eXVQvhOClK9kBDLqWXp7kufxgkwMExY18JkFFC
         nnT+iLxuXozuFyHyQtuxKFZ7Fw60AtxU6UQkUmAlhkJ6XaqF+Fmb2PFc2xYqLhRy5mzj
         6deg==
X-Forwarded-Encrypted: i=1; AJvYcCXP6d8OCs6CxHpWB13djzZGMl6jcA8BZiEkP+Rtg/hjtVyP5qb61J3/c/Dc4fT00ih82VeIerE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjCNNF9JcxGU8VsM62BndjD77LgMmnG0SDUPZXfW+Ai4rCNPR
	BfjY1mwiWduMdRnsuTQaIkKbZD+QUSiaHX4ADMxLJCErnNBgVuckwekvB2buaRFSB0Y=
X-Gm-Gg: ASbGncvdqD//VCI7mPkSsJyJDO0yUYtvFKNMIPcSQEsjxNs6kd3e2SQ6580+ZvvcXVe
	NsVmkMuc5PaDiE8AZjvmr1llxYL3kJ/L8EVGjp0X4xWysvgQCWa28p2YyHXs8JaDHyh3iUIbm6W
	77JM5t1n6mb9ZS5PoVuWsr8803iuMovDNG8c3sV7Z8mnuTU8kQAgYH9Td0jXSs01oY7EOLjxE22
	LO2GvvA1o8Sf2UXZyL2TFOs+sD0MfstrTdmrUxFrDeWKSUo/H5xVFuZVaOn00MZ6KUmumnmdCcK
	zrdsnfTSdhbTR18+0r98xmCibIFt6JvBKDuZDXS9m7sBqe+ZHa+V2bt6tT5McfhFUGau0fuoIch
	NUtajXMf4LDMaUE8bNGU+YkwP6LRQK3GndjBq6J0ly1nNjb6Wq0m3WsIKmLOx1qLnGVwpsnjxBw
	ub8lu0cRR9rYCwpJEKTvUznPsr0oj5YVHyB9uVLXjSl+7vTSMNw/udJKyk
X-Google-Smtp-Source: AGHT+IEEbFr0V/GE6v2r0lg3Q9QrsOpLTkFBWMuQRCwpPocKiOv3FzGIIkvZXbu1DlMUSzaVY3ME+Q==
X-Received: by 2002:a17:907:a03:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b647453ff17mr3849029766b.60.1761488338045;
        Sun, 26 Oct 2025 07:18:58 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853edc87sm475912466b.46.2025.10.26.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:35 +0100
Subject: [PATCH bpf-next v3 15/16] selftests/bpf: Cover skb metadata access
 after change_head/tail helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-15-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
bpf_skb_change_head() and bpf_skb_change_tail(), which modify packet
headroom/tailroom and can trigger head reallocation.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a3b82cf2f9e9..65735a134abb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -497,6 +497,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_adjust_room,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_change_head_tail"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_change_head_tail,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 29fe4aa9ec76..2fd95b80c3ef 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -611,4 +611,38 @@ int helper_skb_adjust_room(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_change_head_tail(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* Reserve 1 extra in the front for packet data */
+	err = bpf_skb_change_head(ctx, 1, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Reserve 256 extra bytes in the front to trigger head reallocation */
+	err = bpf_skb_change_head(ctx, 256, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Reserve 4k extra bytes in the back to trigger head reallocation */
+	err = bpf_skb_change_tail(ctx, ctx->len + 4096, 0);
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


