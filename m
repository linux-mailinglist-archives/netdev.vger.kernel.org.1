Return-Path: <netdev+bounces-252898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD10KiGrc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:08:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556178CE4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BACD5304C7E7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F402C029C;
	Fri, 23 Jan 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EMsksjct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734A42A80
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187951; cv=none; b=eNrzoh4POsuYK6jgAYC41vYzZKb+wYXXFVmlnO+UGekF6CfMKoJnV7lC6LRqY1gG1O6olgrqyDfxByEYwS/o4ObVyrQWmZ6Sm9OwXKzyNsaBsUTB+gKKItKxbaUQc62F5ejNE81WFWJtkLbKYNwqBKzewSHk4HlFBGdWUSMtv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187951; c=relaxed/simple;
	bh=gvMdbX+icg3dbCnUJIuH0NKGuBkPVhNimUGLo6psQUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFQjMQ8SWlZUoDoyJwDf3PkKyLn61z+vZy+xiwEJlVq+eJpCNv37vWOSo6Nr+mGGkzHkEzWiig6waauVDQOy8l3eZFEz7J97yIzUVoJBb360jRhDJx18fwcoESPuJr5/7FV/0UzmEspqZjM6JbnQdG90ZQE04qIqZTVNhdLWSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EMsksjct; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso3771315a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187937; x=1769792737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfhpj3sesnQM8iPrv156X7I9lkAuKOzp/WiXCsy1IVQ=;
        b=EMsksjctoQqgLu685d4nuKSEJniJM1INUwuh9/4x5lcEe9XGFyjifdv+2bMKeMyzza
         JjxBXgIdiMIhrAx7vf0pEimHhbOBXsxwNQhHgfiEKK/9EEM8yt1MIhLDB/PVs6x99z8d
         eYyvBBTUqFFP+BiLoU52Bydkr9QvGrpaEdK+tOMx7TgOmCwtX5WkNWE5+Tt2K2SAJEwZ
         XhZJGyGwNjpK/6e9cFQeyFu0qKjFvhqq9P/I92dWG9bZ5/8vkt/s6hV+cpH+laJGj943
         Kdy2P1/hbaY4UaNXN+aXjj5kg3xlBOtnSYSeAqebu9pQofN36gnMafjrJvZM0AsYLUo+
         /47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187937; x=1769792737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfhpj3sesnQM8iPrv156X7I9lkAuKOzp/WiXCsy1IVQ=;
        b=NdDJpFH0lkeOto3RK90WLo0W6ReHEVe0fTQrzvwdBg/ZJhK/Qx3lDzXswVeXAjKAi9
         TGQqNOS/RxP3QN/5lCEipGMPWBIpiGyOuW3yzZ+PB/FnLu4dfDgOaW4xyZ8Ak3xJOpFp
         sHnabKBoiDbf+vyDEcmJwJFjKOc7SI8mqadPMUeFSczcObh8f5UoA1nllbABGIRKkH+M
         qMsNQd1M741OewscdXyHYOEMFvn3yaYNE0IAngWGF90LIZiKv8jtY3RogUsaQ7ruGNOH
         mL8oZNfvKp6WDaaq1gC2I3Xx+kUZKKzNrIaNWIXcKhMmj45K9Guxq17l5t8jM6ODmgEz
         NM7w==
X-Forwarded-Encrypted: i=1; AJvYcCWvJGq7RWo64Pn8Fu9JsDBMkhmn6sS60JE/ZzTb9hHL5x2tvJR5Bfo4ZEc1dL3U47GhFARg8RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzgbWkIbSPEAJfSpkSK+eIyyJEmUwHQiKH8nZuIYg0u1b2ajTh
	tz5jGIuDVfiQ+Y2Np2CXT/HMNOBWtfa1jEZAZh99PtbcRT4e6hVNAuh6sFA71feTnZE=
X-Gm-Gg: AZuq6aK9rKPZQeO6RqiXZTjtLOEZ+jJ7xOCLap+Qgla0vNcy7Nz++2y1MseCoV6rl6X
	1XqYwvVKtbs7WdYE0RBu8eV8OaDrOjq3ewMuSmi4cReVjWUimhk3aadu5YWVDSvzpkqDFbJFKlY
	L9tcJavklKkuaRJMC5YICeEys0nZ+KDNGHLqQUkCUeARttBxkFETRjrv0FDRWgMG5SkAVc47mVj
	+OZsNpQVfy8nywHdSxsSHgtQ84LZw6DW6r7kusEDYMtiFOk54fdtYxp0DJyGSWn2gTr0m9WhJhL
	egGCzlzDcfUow8qxUfqdeZLvrAMiJHRnxv8Eviy+CO6UHetmNn4DHH/AmtH2lf2LjzCgP7Rq7Gg
	ukia1uJdO1ZSciWhVHFUwFUM3Q5CMgWj+SZYc4yddXinDFasdschkEPZe82CVedBK7RRD1HrcjG
	VTEgCgYdfDB0+t98kCLgnJtPhCTXH4t57gfpJaLEY9dSp5hrM1zKk=
X-Received: by 2002:a17:906:4796:b0:b87:2780:1b2d with SMTP id a640c23a62f3a-b885ae9e6dbmr264270966b.56.1769187936849;
        Fri, 23 Jan 2026 09:05:36 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b418494sm137107866b.21.2026.01.23.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:36 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:21 +0100
Subject: [PATCH bpf-next v2 4/4] bpf: Remove kfunc support in prologue and
 epilogue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-4-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252898-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: 5556178CE4
X-Rspamd-Action: no action

Remove add_kfunc_in_insns() and its call sites in convert_ctx_accesses().
This function was used to register kfuncs found in prologue and epilogue
instructions, but is no longer needed now that we use direct helper calls
via BPF_EMIT_CALL instead.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b4feedc14c9..41ff0c459a66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3543,21 +3543,6 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 	return res ? &res->func_model : NULL;
 }
 
-static int add_kfunc_in_insns(struct bpf_verifier_env *env,
-			      struct bpf_insn *insn, int cnt)
-{
-	int i, ret;
-
-	for (i = 0; i < cnt; i++, insn++) {
-		if (bpf_pseudo_kfunc_call(insn)) {
-			ret = add_kfunc_call(env, insn->imm, insn->off);
-			if (ret < 0)
-				return ret;
-		}
-	}
-	return 0;
-}
-
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
@@ -22223,7 +22208,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
+	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
@@ -22252,10 +22237,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				return -ENOMEM;
 			env->prog = new_prog;
 			delta += cnt - 1;
-
-			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
-			if (ret < 0)
-				return ret;
 		}
 	}
 
@@ -22277,10 +22258,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog = new_prog;
 			delta += cnt - 1;
 
-			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
-			if (ret < 0)
-				return ret;
-
 			mark_helper_calls_finalized(env, 0, cnt - 1);
 		}
 	}

-- 
2.43.0


