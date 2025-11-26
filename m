Return-Path: <netdev+bounces-242095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D79DDC8C300
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E01D53553E8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F734572F;
	Wed, 26 Nov 2025 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z57xFgng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A9344053
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195458; cv=none; b=TVchoWtW1lAGUzckvAS/lmiFg309gXqqJb7lDEGzQ0Zeh5+heaq7ae97V+4VBg9r7pnxT3cCHNSem3IlrwC2oE90SSqQanfgR4PQDiGYvMs9QeSbAFx0EnYF3mL2Oe4hrGWXeNdCQWK2FxfyHWiXdW4NSo1zH2MJ76MWItC0SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195458; c=relaxed/simple;
	bh=ZJPohzGvoQ1v18uU33SR3JA9T9m8SmUDZDW0IUlOvGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Py7+w/tlboEm53iBul2jSjHLuXOGr5vYLJP6DYKnKdaU6xMs+FTrgzmTJhPJ63S5p7qCWoL1E01ps08z4vVMh2CtzVSfPP0h4pINZ/+hF6GtrDKUBD6Qv/ExyDRwpjOPdY8vHCkXJNC1W0/mHKAiqr2lE/SHCRKQwrM14O6YWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z57xFgng; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7be3d08f863so277597b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195456; x=1764800256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkopYgjW0ZhNI0/DMyFsBAutmxIPpQBDxr/HiAwk2qY=;
        b=z57xFgngqfX/56oyqbGs2no5IooBJd38Lx4yXCeIG9x9q3qeWh6GHf2kOXgNBUmqL2
         +BG6EoU9wFuYXdZfDYQL8SLnOTdCo0h1WXgOTT2Sqk5w3ERji+aYPBuOeJlq2+DbbsRE
         J8kHoOkJjMbo+Kr6gyJgtUdYPeEsmXlwe9aPooMYvD/tx8/UVZDBRuDeQkC4X1dBOe5i
         TefB6HLPLYmCBkC6yU1kOiGCnCOhppe+9lcb75bSLMFLQJLQqBYr07S15GC41xsMR1lt
         tEJ0ddz9y6Vc+C7TBpB0y01jopYChGwi2n2WLrYQHqrYx/D0tB/KM76jEnn+UTShBJ1T
         ciDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195456; x=1764800256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkopYgjW0ZhNI0/DMyFsBAutmxIPpQBDxr/HiAwk2qY=;
        b=fWGC8/Oi9tS4FiWf6iLg0BXtSNfEgX3W3sFdK7M+ewbmN41LBqd1tIN4zvGQbaWo4g
         kyv5Z1cStck9Vm2iTSwSiAPm67CajEUSfIvzQmXboj+QVS89Py+eWcVkjmmdIZWD5Ei6
         EPyZdB7PpK+ZCKfSc3pzTvZsrrpPOly1bVUouPaMSJO9yJ4BTqIZmNIV+mrr9ahR7Pxo
         +guTReWBbHjwU3P3S3QDRbsFdbzZYTSM1uDf4LxZaGEqjWQqnx0eVmYm3lqulFHBMCDb
         qvxgTScRc0FEw7EYSFIsyf5x5lWqRlqCu5aF439sDAC8MS1kTMCuJrI0FJkN8ERXWBUj
         5FNw==
X-Forwarded-Encrypted: i=1; AJvYcCXps8BNchQ1h2f0ThB6EqIQHC2WXRmUkb1BP29klvfRHqfNJY6JEU2KNxGGbAJ/+D/K332lp3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQtF+1eMvjfYWF6KP4nnfD9DWRsuAuaL5+s7At4FSbS7U0VYb
	byR8QWT3kagPG1iGUVD9aoVFpeue5DQvvozrRFAVDu7VoXt11mxJUK9h3Z8B6fx6KH+f4c4tE8o
	fg1My4bqzQLXliZALbhK7hsWbe2smFQ==
X-Google-Smtp-Source: AGHT+IFZn7eSu6wdNc8Ge7MB3eF2N+Mv0sgT8A6mAc5qcFvErPDUFWdieE2xKOS8McVUJNg4kQwiENNTWfkv312xEyA=
X-Received: from dlaf9.prod.google.com ([2002:a05:701b:2409:b0:11a:1004:5049])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4424:b0:11b:9386:a3cc with SMTP id a92af1059eb24-11c9d872af1mr12462901c88.45.1764195455574;
 Wed, 26 Nov 2025 14:17:35 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:28 +0000
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=samitolvanen@google.com;
 h=from:subject; bh=ZJPohzGvoQ1v18uU33SR3JA9T9m8SmUDZDW0IUlOvGo=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNWU71RW4oh/Ju1zeLfbB/VPtwyxvLmYVXWfDlVPmy
 9yPYI7tKGVhEONikBVTZGn5unrr7u9Oqa8+F0nAzGFlAhnCwMUpABPxdGb4nz5nXuxhvW/OP4Mm
 v8qpmHM80L+527V12jvnb/Nkvjr6yjEyXIwR0Lp543yfWF1TzhxDjn2LU063Fuxl63vqd2jF81J FXgA=
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-9-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Use the correct destructor
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
index ed0a4721d8fd..bf8f6b2591c1 100644
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
2.52.0.487.g5c8c507ade-goog


