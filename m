Return-Path: <netdev+bounces-248683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF936D0D328
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 09:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 949C7300672E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF462DFA2F;
	Sat, 10 Jan 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1aUYk9bM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79362D5936
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033564; cv=none; b=a3YyrPmFBhWIpFh33aRcIFwBi/cVgAl7npxB8+TKCE9dQytLLIdnhHwWq2wTyhuwVeeIi/ZADYjZe1sci81dD3kZAZFmwjktOlcTHOGni8rnacHWIzJOPfmC8U+VFhsLDSbi13i+Sxr5ZZs080O2V8rvV320H0ffDfGGWTGGBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033564; c=relaxed/simple;
	bh=fU9tXtVUuvz++hhVpv6nOf14ncQA9HihGffXc9Blti4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G94l4pSzLXyKZP1PjQvuq0iTceEQhb8y8cOWeM4tdRISpTkm+L9Y5u9Ck0+0a9hd9DDvhG0ebcmgVqgDYGJaACh28m6v7IwVYk8TggHi/Csge1JCC8nzRomOJXCWh2F1pw/zWUi7ngEdexjhi6IePXWm8o9N4blpSnCxm8AC4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1aUYk9bM; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b0530846d3so4371172eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 00:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033560; x=1768638360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZhkoiS2Eo/kq3Cli8CQX1phFsPCl4naA/gjIFzyLV8=;
        b=1aUYk9bMCBtiYbJSy8auWrAI2DyPvbN+xBIkVdWjy+Ppe3JPx1TqgTU1UL0Zz0t2W1
         xXyRSkgXR1uprPKNStP19RBOLEKEolshdB0V3J7HrNPS6gWzXDT03JDuhzBeoWWkW9Qo
         Z9u4XB+b2ZMB+afa0CymDJpgDPjnPVoDZ/ZHM9Az7TAZVFDCLEbw4oF5gM4P2GlrlYwf
         K6yLJRRq2oRqB2T1+6vzG92FaBJ2nxPWY8qG0wUhAZOtvUGleoSo5s5GpA/ILwLWXtaF
         7LZ9TJJrLloXwGIIuy1eDeVflrM/l5VtgoZ8qUVwy4meTDHJ/TqUMm2A1f2JD87xf/fy
         iiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033560; x=1768638360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZhkoiS2Eo/kq3Cli8CQX1phFsPCl4naA/gjIFzyLV8=;
        b=i0QEE6xWoGcJOiDhsku6FnooqZ34VZAgzrvoPwO5gJ9anoXg3sHHJgEvhEtSsQj9Qf
         pujK+rrhEpkvS2jFB7X0VgOCn1QOmQu64nZWClyj6BGPn/gaIFWcYxSPX5XsSI8mCB4W
         /eXafos4TlfInWiIsMX3f7oY87IVlwEhG40lqbFQP5yceAr0Bei94L+Jlug/nZzVC0Wl
         o+NU8e9TVQj+8aIkSdiSSdpCtWichIJHZuyVl2h9KnJCQSlc9txIqDsWmVCU+ej7Ljp1
         gCuI+VRHWkR2x+Xhzv+sNf0rtHDhGi3PaiSzPOA0ypOE3ei3jDFMCSRBJ4ZgvlGoi/AW
         WI4w==
X-Forwarded-Encrypted: i=1; AJvYcCUlbbEqTILj27LyDyB9Q1OwraCCRIgLFN4cL1bp8IpMkC67kRykZC/aPgIwQzkd/WzNHk2sf6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yM/zOB908obSSBoWVA8/82WNOSWXamRRY2SACsVNZg2TUkn2
	Y+iuQhHz/wWayqHHWL4opKIIv6SnYTvW0ry2Egmpq6cqbUWzE+wBw8NK1jB0lXyFlAeo6X0pPfn
	pSkHazM4mjKBZw9gmRGUHJhXk9TIdLA==
X-Google-Smtp-Source: AGHT+IG9YKCSq7wS7f0FWH0qnCPG7v4Hjw/ILCg0+RfetXQsjFo9F+6oxi8SmQfwivw3ZF8EVRkWhSbDDRqzXAdk+xg=
X-Received: from dycog7.prod.google.com ([2002:a05:7301:9a87:b0:2ae:3278:d74f])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e9d9:20b0:2b0:582e:fe51 with SMTP id 5a478bee46e88-2b17d2a841dmr7814723eec.20.1768033560093;
 Sat, 10 Jan 2026 00:26:00 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:52 +0000
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082548.113748-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=samitolvanen@google.com;
 h=from:subject; bh=fU9tXtVUuvz++hhVpv6nOf14ncQA9HihGffXc9Blti4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvHwP4ydbut2RMjnQ9ODCnS2OKqy+lja+XC473u2V/
 rt9QYdSRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZiIziVGho2HN68R23FxSueL
 Hab7bx5u1xBQ2VO556dvY/lcnR5Z72SG/xn92xL+WF+wn8H//Vi40D6OmGk7HFhWpV5am8jbL5f yiQMA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-9-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the target
function. As bpf_testmod_ctx_release() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1c41d03bd5a1..bc07ce9d5477 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -285,6 +285,12 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
 
+__bpf_kfunc void bpf_testmod_ctx_release_dtor(void *ctx)
+{
+	bpf_testmod_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_testmod_ctx_release_dtor);
+
 static struct bpf_testmod_ops3 *st_ops3;
 
 static int bpf_testmod_test_3(void)
@@ -707,7 +713,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
-BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(func, bpf_testmod_ctx_release_dtor)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.52.0.457.g6b5491de43-goog


