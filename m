Return-Path: <netdev+bounces-216159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138FB324F8
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD91B06311
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 22:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C82F39D3;
	Fri, 22 Aug 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCIcx4Nz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ABC2EDD7E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901139; cv=none; b=YhWGT2dMZsR+0ir0Anp1P5y6Dt86F9+8F7HB5V2r7SWnhDl7KRTBs7X1lzx73cAj72QEqMwdKPpbfA0aDqAPGkg9V4y818fHq9G4ZyiO6PiTysXZAuNL45+kIfCkw5ZHsaUPh5qaqQW+TjOHCWaWKTiS2ZvLbHyJv+GH5DmjHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901139; c=relaxed/simple;
	bh=7/Oq2erBAk6csK/VIzaXnMx7IY4nJD9v3mKBHDWXhxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qAVlQnQ1LD0rINzlRLwfj6asQ+RLdYx+ipCGgkdTBetN+NgjsjNIQW8i/iOcMbNbyTtTM68Cdc2ivGP5/2fVgxnr79+lS08nXXfkdfi/+IdTtPT9//g8+vV3WIiKmqeFbElZwGkbMY8RSYWDist7hKKmy7l3JZ0W81SjjkTwMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCIcx4Nz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce388so55927015ad.2
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901137; x=1756505937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwqiRU7Ojbq6F6q8iOkhmJXS3Hjw0P3llz0Lx07X7es=;
        b=TCIcx4Nz5LUCEX3h5BElC9Mlyu1rE9GnhhlVfwRcJlNRqU1zDWA2V1zU2qIFW1qtE3
         8Qa/o5h9Vj7ergUigXpkkJT4t3LJhhC7x5ixW5cgbQM9a1mM0ps97G0lgpW3nN8os07G
         yBRWgwZZ79Dtjt7F6TQtkYV4smeHxZJ7pmQ3z3aL1xBUcn1U8lwvwWj2noC5gU1n0e8a
         nqGlvelD7+doUoxGQ68rLC9e6vKozP9xbUenGbrrN1UKMCa6zh6W2/B7ZFaA/5KGy3Gr
         eu9O79yFh1G4hcK/Tq2/o0BufnIqESKyrqL4VFIVrrFxpkXbcb5vYXNAjp9z2Tj54GJt
         wWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901137; x=1756505937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwqiRU7Ojbq6F6q8iOkhmJXS3Hjw0P3llz0Lx07X7es=;
        b=DX6jR46Wl8Tg2hxWEP83h6RRg08wQvfOEcxDpXzBNmfvSbVQqCH/7HaunWebNdHkO3
         CnHfUzzZLL+f6622gpOVmsfw+vwYO3KEDEnie61NiuK65j4mEx52IFK0yyrgi2X/JHva
         d1SkAvUxZg6leyhxUVSOOAxzxGPa7mp5RFC2BRd0woWEtG5FOweXeXB3Dwt+PsJcf/QG
         8pblVwCPWiRW1GT9a9uJV42Ve+u08rty0cJNEvbWqdhUGJXXSzwU6E0FNPeG0z29O97v
         +MtI5/eFMwj64z+rafu02xhTXsAVtQlchd2HDpD/4B/4Qbwh2ZPILmHPQ/2UViq0No97
         tgkg==
X-Forwarded-Encrypted: i=1; AJvYcCWrFDtRgvf1cMLhib3G5NkARbcl5OpQ4GJP9m/zWYzqfH/ZuwhWBx6MEM8dfWKYHHy4Gdp4WfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qdkRHVz2bxMshhCXZA4guSnNg2pNXQzgEKCDKa4rpTvx+PWu
	ij8dMxbaAm49BbHMGdHElYEBTx/1sQRBVWPLjos/c8lkc6aaJtQxNdsEoYefiFpbOXq9CG+HCm+
	qbdRTqw==
X-Google-Smtp-Source: AGHT+IEzdIUJvBW/HWk+yQGho1eIAJ9q8eHcNiq/AetsuT009/bmdPsgSGLajJei5vstD8SaZbHc+9SagAU=
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:31f:6a10:6ea6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8f:b0:246:2e9:daa4
 with SMTP id d9443c01a7336-2462edeeac7mr68954815ad.6.1755901137131; Fri, 22
 Aug 2025 15:18:57 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:18:00 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-6-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 5/8] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_(CREATE|ACCEPT).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will store a flag in sk->sk_memcg by bpf_setsockopt() during
socket() and accept().

BPF_CGROUP_INET_SOCK_CREATE and BPF_CGROUP_INET_SOCK_ACCEPT are
invoked by __cgroup_bpf_run_filter_sk() that passes a pointer to
struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Let's add new bpf_setsockopt() variants and support them in two
attach types.

Note that __inet_accept() is under lock_sock() but inet_create()
is not.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..aa17c7ed5aed 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5743,6 +5743,40 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sock_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+const struct bpf_func_proto bpf_sock_setsockopt_proto = {
+	.func		= bpf_sock_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return _bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
+	.func		= bpf_unlocked_sock_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 				int optname, const u8 **start)
 {
@@ -8051,6 +8085,15 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_unlocked_sock_setsockopt_proto;
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
+			return &bpf_sock_setsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


