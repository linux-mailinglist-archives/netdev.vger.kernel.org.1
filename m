Return-Path: <netdev+bounces-242093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1018CC8C2E5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00DC63560C3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B37342C8C;
	Wed, 26 Nov 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhMN14/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED02DAFB9
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195454; cv=none; b=ExScfnkwYvm+JsLBLD2P/S2djMFS463uRl8yeBXSCfZbMjHPZWmqzdrbltSf0XsD7BXqgAMxvqL66SP5X43u31rWPw5tDJNlsIIIPHp5HJtwhlV3LDlcMm2T8BJ0hML6fKFFE4OuUWab9vhNYhozvYWYgIrfmRKlPXWr5tRH5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195454; c=relaxed/simple;
	bh=8bdhp/XEyRN6TXsJtRAeA96+8FmS2vgEzQfyVsGO/oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T6C+0REAeh9ktriio64ieYf1lWWXc2qoCYgWAs4CpLlY+3ztf+DUsidAaqjmAW/ez1Y57aoBbjbJlWFVrIJ1u9JuANWxsjBhbYG+wvGzHmziViZ/03+BwJwY9TQDGzD8XSO1ngb2LrOI8exfAnZlaBrXWAuLEeYfJHsTjNHp54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhMN14/b; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so338135a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195452; x=1764800252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMHh1Jv6KIP5NP429fH/fqQBwAKNE3Ze+gaNeawP9DU=;
        b=yhMN14/b85S16kVa31e4O2v6i5zfiObJVc0vE+vuDVo6bmif99DlQdlNqTcOZ9bO3h
         8mXpUYmaoLRPrsesFe5ADx+9ybD5r19eIfylTbA79HTKr/TEja75+ZNcg+eeObVh3tgJ
         Br19bWOD6+dOCGTMcyLcQUReyMK2D27WTVNXppL0p/YUBROJyV6k6G6/2ghpr27DrQXX
         3w+g+tyMZHIF7XzZudV6JxysSgtYNFYvZfSHVs7IWSKn+hozVJAmPlyMJ1+u7sRfPqhs
         1De4njpan0HlfYw+9bzB+rNPT7zDq3TaEb0qtPeqxEJruOxgcl1DT5D44aFW5JsCJeSE
         KFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195452; x=1764800252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMHh1Jv6KIP5NP429fH/fqQBwAKNE3Ze+gaNeawP9DU=;
        b=f4ZpdeYE6nPOrDeqQnM/T5tbcObmWQIaAmZcfFvOeShJPhNgkA8kadUH8BHOBtWdKN
         f68CJFgpaUU1wOBPl7yErShP6eZnllaiFMlA4Q3AYdR56rP+o9tOB+7cUct7tbjZRQsW
         8ZkxGWSb0WQ/LEMnJXg1+VMMB2qhtKhoapvROxwgtF2DzzWvYERXbjWEP4lNbtp2M4DQ
         MVuSj+NxB8ZAZO28gRNiJu/ot6lSPOVedusvLQ3s+jQlkHhc0rxdNRGGxFJGQGk2zBPf
         thC/j+vo/UDb/CoUaTmTw4BYvyVBqLDNvTkUZ6umP4IWpUABxsd80s5rwWLAbMXdpPSS
         oDLA==
X-Forwarded-Encrypted: i=1; AJvYcCVhSlF+SEwwGXpokfvS5g1DEnXM/3yq3pj7oYWtn0aonJtx0ACblfdj+RGQW11KT3ZdL5mg20A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQN/86n7KoF5dGBPcWIQJXzOnu4nZAP8vywYJMJaEYrDLRdP5
	cm3vyviWeUKxW5CggleDGEUKp+3NSpnGmoEOna6dCZzzyX5Vl1v/0XBMkcDoraGpckRQN++D1kt
	BIyPu2cNP4wFXFYXL3+B1v3kbrHOImw==
X-Google-Smtp-Source: AGHT+IEbnKxY9Xeyzuu5MMGLqSobmE20jDIMb11W+9BVqTdpdxRimEZd6sLMSi1ynNQjKwrc5nixFVWYCFDRJlNQr24=
X-Received: from dyjh19.prod.google.com ([2002:a05:7300:5613:b0:2a4:603a:d424])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:50ef:b0:2a4:7fb3:7a96 with SMTP id 5a478bee46e88-2a7192d82b0mr11685916eec.36.1764195452142;
 Wed, 26 Nov 2025 14:17:32 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:26 +0000
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=samitolvanen@google.com;
 h=from:subject; bh=8bdhp/XEyRN6TXsJtRAeA96+8FmS2vgEzQfyVsGO/oE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNaVP9i9t/HFhytmXb8zmFk+40VvNebqHYzfjlp6N4
 lXvbZcEdJSyMIhxMciKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJFBox/C9w3vbcTf5P0JNO
 48lH03xMLUNZdbcUytw452s/+aviy8+MDL2NyjoGRo2Mjzz3S7XccW18qN95K1km4L1DlCbDSeX PTAA=
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 1/4] bpf: crypto: Use the correct destructor kfunc type
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
function. I ran into the following type mismatch when running BPF
self-tests:

  CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
    bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
  Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
  ...

As bpf_crypto_ctx_release() is also used in BPF programs and using
a void pointer as the argument would make the verifier unhappy, add
a simple stub function with the correct type and register it as the
destructor kfunc instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/crypto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 83c4d9943084..1d024fe7248a 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
 		call_rcu(&ctx->rcu, crypto_free_cb);
 }
 
+__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
+{
+	bpf_crypto_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
+
 static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 			    const struct bpf_dynptr_kern *src,
 			    const struct bpf_dynptr_kern *dst,
@@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
-BTF_ID(func, bpf_crypto_ctx_release)
+BTF_ID(func, bpf_crypto_ctx_release_dtor)
 
 static int __init crypto_kfunc_init(void)
 {
-- 
2.52.0.487.g5c8c507ade-goog


