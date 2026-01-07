Return-Path: <netdev+bounces-247776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC9CFFE8F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 21:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 863983008742
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2A34D93D;
	Wed,  7 Jan 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XE2X5kxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7034CFCD
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796107; cv=none; b=f6i1eDrW7tw25DkTQ6sXM/wJllNRK9+2b6SdF+UrH8XSFZHBZWRqDjjjx3EkiubA+TAgUpuIO0S6LrSxDn+v4YV1Dxtha3SHM/Pya9nAU81DvuE72aPf/I1hMkU8pK8PeJZiKHAfRKahVav51d6IKnmCJ9C3ZU37fS/lVwf7D/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796107; c=relaxed/simple;
	bh=l6RcmO3Gls8j+2vSUi+GZOL/ReACnjE2hP7L8Y/srPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjjUCzA19leqSJDiI1cK27WCEYPwP372sHdlLybcP0cLs+hEbU8O5xIhBd2jb4kg/YUrtq0a209tgiod2uf6D9HvZKpYrGp6x8VEUAxVwV5HRJhbdd/uLLC+44AwKmpHFeKcVn2/bG4sTj4MIlfykkBU+l5jyH4aSkQg0lOUxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XE2X5kxJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7277324054so375117266b.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796104; x=1768400904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heRVIssMddPtSafwXJcHFhk3bxkqAgYAFQ1TklhGvPM=;
        b=XE2X5kxJoyBn6er/t0YLuiwCUMAOfo1Hvb7iex3NSdXPqz9xgzrJChwbOw//f8M4GF
         zPkuJB335I+pSi8/aICY5FajJw89z0y/uBUYoyHTVvVEWF33suAwry93xyBNqW/fiHxv
         bxe5i7KV/Y/esnk2xVgcuz7Qqk3P/JYNPWGeyORxdCuAX6u/g+cuBmCLHMGk6jGl/NET
         YolC3TJlmkL9TMXHIwnz8lJFgfvyBonmav5X+EMCVA5ZCNleZXWlJgyQkyHCPbb6BYNd
         xpZQVmqiRqRHIdKAZ/DNIJh1XfqSe0A39T3hwO23TYjB3wuztw+htknm2aDyv264y16M
         uRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796104; x=1768400904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=heRVIssMddPtSafwXJcHFhk3bxkqAgYAFQ1TklhGvPM=;
        b=ZDP0aE//a8/zkOoEcaEwnNEI9ZZiNEddXNvOE4zRV54a1IcCcw6CWFTAnN70sgxv6m
         3zh3AXDPEYaTGKjDoKuypcvuUXd8G+mSkMCYPW6jMNXJhJahpfz0GwphCl67PX/lG9Gr
         gy/LJlqlbjtnQMFkAondxnobV6nAeT0SAAki0ibDK/BZKKR31Zk0g/yTggb+1b+IKK6u
         GdNR/1QxMHuMhkdrmQ217jh45v2Tjl6zco0ib1x8tX7FGMsKti2k6Ew1dxNGGeqe4KdS
         3CtVPlVV8caAWWOd+WT/FH4JXYM3gOJukApatDxuFhwuTt3nXe7erAbtjPWKukuCjRGJ
         Evzg==
X-Gm-Message-State: AOJu0YySE29Kb3BHSE5ZvH3lSs9sbdUYL+yt0TXs31dlZShumcnCmpLs
	zNgxJ2XY9GZ4sLogkOuZBGmaSmGYJOSWbosowRCI/9f4ypgGHKPNwyEUF88610Z9MS0=
X-Gm-Gg: AY/fxX5mmgk0sJ3Ry3o4oIc9mft+3qvs4hyz6wABBpUz+osJk9XmY/AHRbjH9WzwExq
	MOccKxqQ6wSz0boFzH3sQgVYis130rdv+90wSm+W3y0T2KbetUYQewfxchKUqQfycXpoKyppH5Z
	KfwKV8nQnmDZ0olupMUIlp35yt0OKYAK4VW0oa2LeFChFfDsu5jg2YHuTWeZSbG36QQeL7sulf8
	naU9szlAOiRcKMBzBYEoN7FzzxJyNCFatYWusUNIci8pfHo8uuLOtvvUtPaM14Kwu/icvcC8Ysl
	aQymEi0DuBtlYoQ8rhHMQ4Dx0bcPqcoeetZJNReNQQ9VS/m2CTR1uYDot1+eTN/Luk85KHHh9Fj
	/jPZKhWZmHVpFuLKk6lrft6Z1Uk5N3s6UT1QoxRYnkhf5rbmk8403awa5YdXiPFZSkynWGx1cxc
	vLpHx9bL6tYm3Z+n+6OZ8Uz56Po4RwvR0YRASlow3vd/Kmql8lB1kL6rdtPQ0=
X-Google-Smtp-Source: AGHT+IEHxyKBs9BtZiY7RQMsSy9mGqYXG25pbHUi9IrtneaaJqypau87QfGhS476lbMtkfWCEQHcfA==
X-Received: by 2002:a17:907:3e0f:b0:b73:42df:29a with SMTP id a640c23a62f3a-b84453b3f02mr256782866b.59.1767796103997;
        Wed, 07 Jan 2026 06:28:23 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56db21sm510933566b.71.2026.01.07.06.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:12 +0100
Subject: [PATCH bpf-next v3 12/17] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-12-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
in preparation for tracking additional packet access patterns.

No functional change.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/verifier.c        | 11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..c8397ae51880 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -647,6 +647,10 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+enum packet_access_flags {
+	PA_F_DIRECT_WRITE = BIT(0),
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
@@ -773,7 +777,7 @@ struct bpf_verifier_env {
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
-	bool seen_direct_write;
+	u8 seen_packet_access;	/* combination of enum packet_access_flags */
 	bool seen_exception;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1158c7764a34..95818a7eedff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7714,7 +7714,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					value_regno);
 				return -EACCES;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 		err = check_packet_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
@@ -13895,7 +13895,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -21768,6 +21768,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21795,13 +21796,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (ops->gen_prologue || env->seen_direct_write) {
+	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
+	if (ops->gen_prologue || seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog);
+		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;

-- 
2.43.0


