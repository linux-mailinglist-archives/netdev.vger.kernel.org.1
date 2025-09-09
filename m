Return-Path: <netdev+bounces-221411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71737B5075E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B66A1C658B3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484013629A6;
	Tue,  9 Sep 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6cN5dmH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E336206A
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450805; cv=none; b=FN6Us1/BaapFDItAV+7/mPVy9oGT6YdhTeEgd9iEhxp8Ml92jeAhYOsAGzjdHezXSnBV0zEbme7kj+eJvc6D2zNijrl/EmnmIkF98Zl+ekWdsGGylx7tjTZyyh7Qdi+InCixVem8lxIo2kvwOqwGhTR34vUJIVqZOs4pCWBtKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450805; c=relaxed/simple;
	bh=rGkoFu9nkoi5/nIXhQG8fsZVP8xpKsdD3ZK3Uhe0wtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ptq+2HbzpkziGbUnd4ds1bEJt7Cm2/MnIv43YvnvyW1Z6Yqu9YvpnMXmr6GZTbhXMmwkBK7jr970l3GlxwDuSQZTQvWZhlPbAuUKacexZNyzp+R+yNeyu6HXJawjv/9pgq+swbCIvoFORpHufN5nZwSucnQ7MqluJMIXl9wS1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6cN5dmH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77253535b2cso5896038b3a.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450803; x=1758055603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=o6cN5dmHJiig9kGxXGluQl4A3Nh25HTFeyPKFlK6itAl84pLwGGDI67+wOo1ttKJlC
         wCHtHjBTqTRl0Rh7H643Ul51wwT1TYb+X3UJbSvIMzwjN6FqS1TDsqSXYgQ4lEwZRcKQ
         fKnQ9Kutp5mmMOAPuvsiqg4JK0/QykIV29N1es/Hjmxk9kOjGygMY/m9p/2VBg6Pjkv8
         wUl81ld6OT+C0VdKaDsAjaK6Amj7YEvZAkeJsEfltlunhg3ErLpC0lHvx8VTjNWACkpQ
         0N74SRhes2WSoj/e3Nsz1GZbEWvc0hWSUu8f7LN/5LV3HOuRf5D1ZFooTEW1VnRNoNp4
         3XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450803; x=1758055603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=r7QCMj191DSqEzR9d9/yg62zhO3a9Gl0ZBnk7m8BDdoJaMNo+VC6yvZTEkO/X1hTou
         qow/Dl6djtqsJLbwTuImhEzIOGw8VS/wsx18HSLoG0Ic5/RZXBPtmkSu+JPV7opi8Jer
         Va4rjP5R/pYVV73/qgpPJIBfkKN1NTiZIqXok5dJglvRozsXRNhQBxHLBhWvwNjZZDBD
         AiaplEsLt5CNLlbEx1ZfsY30Y23y3AvY5JH1COyPyO8yDiPB5tbIWdPEL1+YtF6FUyYc
         sdjpCtgEPf/5L4NTgqX78J1POpkKfPrbUStrEmRsosEYetdM8CfvPhs/CCe4e5YCUbz8
         wVaA==
X-Forwarded-Encrypted: i=1; AJvYcCVBucPUb36FJRvfwahi0jSl+mYeHmA9iYMEyXe7OaRNNCZ7CpMSPPFVPxbGFbsOEz78GV5iZVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yrgwXGMx9ZgEejcoy0wWZQ7dWuLVun/uv8A32DFEmCC4aSt0
	hrZBOX3DxjgFGlqUtbS7V6LNcFx7nclMJAjfdsQpPIoThAdfcwpEh2RP3vErpEUUYZ4Ydp4adLT
	b4J89mw==
X-Google-Smtp-Source: AGHT+IEEYvGORu/7lz69y0lIWTuznEat8Ngj8+z/6ck8dr83dBDXqa09D5YJA8suClMe+OQvO6EZI4NzKoc=
X-Received: from pgiz3.prod.google.com ([2002:a63:c043:0:b0:b52:122c:6937])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734d:b0:240:1ad8:1821
 with SMTP id adf61e73a8af0-2533e94d11bmr19780982637.19.1757450802646; Tue, 09
 Sep 2025 13:46:42 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:34 +0000
In-Reply-To: <20250909204632.3994767-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909204632.3994767-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-5-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will support flagging SK_MEMCG_EXCLUSIVE via bpf_setsockopt() at
the BPF_CGROUP_INET_SOCK_CREATE hook.

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Also, bpf_getsockopt() will be necessary for a cgroup with multiple
bpf progs running.

Let's add new bpf_setsockopt() and bpf_getsockopt() variants for
BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock() and has the same
semantics with bpf_lsm_unlocked_sockopt_hooks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5: Rename new variants to bpf_sock_create_{get,set}sockopt().
v4:
  * Use __bpf_setsockopt() instead of _bpf_setsockopt()
  * Add getsockopt() for a cgroup with multiple bpf progs running
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..31b259f02ee9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,6 +5723,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
+	.func		= bpf_sock_create_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
+	.func		= bpf_sock_create_getsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
@@ -8051,6 +8085,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.384.g4c02a37b29-goog


