Return-Path: <netdev+bounces-230730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71DBEE58D
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CAD421346
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C322E974C;
	Sun, 19 Oct 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QNyhKnzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4072E8B78
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877973; cv=none; b=Xnw8lkwNJ6VhAPpQs9+HjCY5u1/ydBxGpQqKAmUIShOG5gQcQoizmQXW4mHbPCSgYaE9LstcvISv+E/K771/aWhWi8tnlbfadxe/NdSmxlqpRufujQjCZSXoUcLtbAs9DB0JLzJEw9O0/QO0THM+aAz6AzdvRw8i1kzkBIc10HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877973; c=relaxed/simple;
	bh=Z6Acauiw5VNlWtHv7oF3ZXGpUNutQOAURn9JnzG5E6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbJG1vCKLauE69RKV+V8xi+6IVcGGd2Dwr3mnCUeWmisxqvhT2dHjTJ8vnkWBKSfJ0/8MqOPPzd7t/+8oMbFgyESuI72AkvY1eTW3ZbuPGIDHxfgH817jbGsWJ94iPbFIPcCfL6J4b2rABzVd90GbxhvKIssaWXwLlUijSGMr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QNyhKnzP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c3429bb88so3329547a12.2
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877969; x=1761482769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGNOtq6edfpdoKT7aMe3lnq3YZWKA20XmMp9oC/vqAc=;
        b=QNyhKnzP3O0khSHBNiLjbDWxgSQN7KiYP3T/lcBvlbDrAod+zbTTMEH1Sya0Runhhv
         TJlEUhkwE8jfXytJOJdWgdGVZPbcCkBEQpRQhWZm3zN8vA6ePPcnKdPk1Uint+8jDwRM
         QdfWz3Q5gxaj9T6SCTuGul0+oy8qy3VJEI5lxtyfFUx5waL+N1NrC/pMQs1XM1fwZgFr
         ajbv1W0P28EQ5C5ACff/ZyiC/vuBjKVvB03I84NYMs6/fPBr7eKIhU9N6wfufnmZlR8i
         TrXbfSfR3bVbaOdi7iZFXSphKywayh5w3r7rl8Wh9wQpuJ442jrqEWaCiQfhj81bhsWu
         nzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877969; x=1761482769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGNOtq6edfpdoKT7aMe3lnq3YZWKA20XmMp9oC/vqAc=;
        b=e4Q+Doua5A1P5FCGSJA+hJKfSPZfDsms286Hb+azzACdjdAT6MO/3foXY38nDU5++4
         eRYl7BX1BFCqrAmPduj9QoKp21JsqM4lT2dicvCedbU4mFx7xh94BMneQYtm2H+fhzc7
         tRwlpCZ9BTpO4vN2FWWeOkqAS4PhKwRV/CiWu7XSeTCCk8IW+rIa3jhgGU7k+SAb2FzS
         VaNo3S+zCelYQ862F40WjKd4YEEBAxZNgLPifcx4KMRLI6GWksosdJAeKFDwWih2UWaJ
         orVtZO4Ic65lOQk1/isNpiirRNxg8+BBvdCYLGCwrMSsrg1TuvMvpgbu8dgzobGYassf
         EosA==
X-Forwarded-Encrypted: i=1; AJvYcCVtHKqZljJGQRJUZt07PkhtowTK7Mhg+j+lAZCxjTRl25mCjqOu0D5TgH0Et2cuaNs4YwDQFmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVoFFrYm0yGUqEibbR24ifGVYqRkDxvvj6eLNkxoYeYmnZhs0
	tfPVCK+Ju8laC+V4RrfQqibi98GnG8SgX4ILhULut2oMP8Hn81j8uljmEq0ppZqbynKJqtHjvlj
	2ItDe
X-Gm-Gg: ASbGncskwj+JrwKhbT5wQPckAr8x30N3xHT4ovZyBlAAmWJVtuJZ0NHj7gEw87xa5nw
	GPp9Jrn0nst845aZiIzHTrybiZmLaQVq5rla+FUcyXJ/WgAREuMJKB09uJSKJnsMSgv63puvb7c
	5BmRpM1AAUQqoMOTYSZuvC6mkUBPOSsPCJSUk+7ib1/tSYx4ShfRGIp+UTpJA8w4L1EaFOgVEM7
	A9drsgNHpa+VgHC0WBaUwkDm0GOXqj9XdlnA2uzNHJCVYDU7uX8YFPgkepBCCKVGqaTj2V7r9Wp
	fAZKM6o2IncX0efkp/DY2Kuy93dsUEq/p/euHh7+Qr/fkk1nSEro8FtNIBeQGuqYeUn1UL3W1OH
	Oy+z+ZX8Vq3ebqfr0IqSVaTAialaAdBoKAFjrYQB86W9SwLqk+sGbNxyV71ajwuXoDL9yZw8g9A
	zs61t77Bj6iXbgSs88lvfW7BldgoLlIqYCJSG2rhfT4bJo1YeeXatKdi1lT6I=
X-Google-Smtp-Source: AGHT+IEm9hlIkjPauXzag3/GcymgnYK9h2G9gzy4CDlrsD27on+NLDcY/a9PAN+OwENFrdNhuuyg5w==
X-Received: by 2002:a05:6402:2742:b0:63c:4bc9:569c with SMTP id 4fb4d7f45d1cf-63c4bc95907mr5230680a12.19.1760877969144;
        Sun, 19 Oct 2025 05:46:09 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a93998sm4091285a12.4.2025.10.19.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:46:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:38 +0200
Subject: [PATCH bpf-next v2 14/15] selftests/bpf: Cover skb metadata access
 after change_head/tail helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-14-f9a58f3eb6d6@cloudflare.com>
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
bpf_skb_change_head() and bpf_skb_change_tail(), which modify packet
headroom/tailroom and can trigger head reallocation.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 05d862e460b5..8880feb84cbf 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -501,6 +501,11 @@ void test_xdp_context_tuntap(void)
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
index e29df7f82a89..30ad4b1d00d5 100644
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


