Return-Path: <netdev+bounces-217043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F8B37260
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859291B682E6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2128371EBF;
	Tue, 26 Aug 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT1ZEcQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7E37059F
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233610; cv=none; b=tVl7KOQ36JmoqVc5840/oibjPJzbJAwBxZ2BU526daYOj7nEq9q8oKG4WoiRTzguZ7TdFQHt5yWFgJ96hTJyvxlZ6tXD3Hi6bH689c+MKV6q8kOOGyewkk++rAONSeouzdg9I/2KOsdtNd4G/iFIQQIogVfRFOkMbe7OhC/3Z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233610; c=relaxed/simple;
	bh=gvLsmO4dGlj9dBHWIL4aYjHz5DUKMz7fscL7ce/U8rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0j8gw9ScjT94G1nYgIlN546F9LLtzUZgadR2jvAzBgY1Q082DWqfffx90/aDBClktHByDd0U80G8TozRgdPpZclaVBUJRIbDjNtrW2PAPF1W5GUHAxyasiG/ILzVMJLraBRi//iOnFxxuktOZQLoD6w3wn4k3hxO031rlMrN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HT1ZEcQu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2465bc6da05so54331435ad.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233608; x=1756838408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtucGp73XmcwhOeOUKXRwIuCG0YOFdYXRQJODEa9Q3s=;
        b=HT1ZEcQuFK8aBXB0Z6SqZL4g8mq8yPSVvBZiQUFw8dXkz5IpF4c8vJ7+Tcos1wdwiZ
         mR7NFdOU5qe1xVgLUHQIcOEElHbKPI+gJeWkvD9OfYifpxInv+DUaAjSEpab9flmdsV0
         EzTyY2I2ft9Ipzat1h3X9MQ8mdotYwBiAxGJcXQ9g1SScFn1Q926rUN/qlySZdN3ipWU
         2cAXvT8Ti8Uk95M3q5n2REszMfRxCTNbJDVwoD+oaCXv7SD1bbta5lGKNMdV4n2b6qoJ
         H4Ho/lYyqQJE++xFmpeXf7KNi00XgEfgNcx8k2chCv1vk6FJn2PIbCMu3jyS/U2K6/fx
         qVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233608; x=1756838408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtucGp73XmcwhOeOUKXRwIuCG0YOFdYXRQJODEa9Q3s=;
        b=RoxqfHx/aG4+vtKXNwD1Trsu5ruOclcN+VJOMRkPKX2qNsx4ItcwsB2vH5qG5B8AO/
         BKpyGI7rBJ+z5OmQ4hyGf2jnU6AmNj1zFCKAjKf8kI2XGysm0GEVMGpZ1npFKhfQghxZ
         AdwVnaVmEVh2va90QR4DmjKHG0mMMvvQzpfOrY+VJUVI8zOnlvKnPOBIvaOUgMr4gOka
         X0NSDVr239cAv40EetN43stM7f2DVyxvYXtO4Jpi45isR6PCuwJXCHGjvK2RIgz/xPDP
         WWovZCvO5J9cuFrghdaPFeesChMCCxCetiJnCIzW9ejxkrG68WbKj/1yti4WzwTG8N+g
         hXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWST1PwITeLsJRDrra1bhGY1pz3M63Fxk5SedyCKFQCqkLs/ZwWXoHizkxn5QRAe33jaUcFGIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5g/+xS1it7n4kC70t1i4gTyncd/vrWAbskKEztIAFHFhdueY
	WVPio+mh63hce57uv8cxzi2Fm4kURInUAuS+UaIGTJRnef4uCSenv7yiAPq0OLKUNZmEL6AJckc
	00c6sWQ==
X-Google-Smtp-Source: AGHT+IEvZoUP+itkoaSLL6x3NpfurtGZIu0D//EaIT4VeY9gbjonY7+lFIHpfUtVCzbp6W+QXS5PdBUNOlU=
X-Received: from pjbqc7.prod.google.com ([2002:a17:90b:2887:b0:31e:eff2:4575])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4c:b0:321:b975:abe5
 with SMTP id 98e67ed59e1d1-32515df1b9emr21082385a91.0.1756233608424; Tue, 26
 Aug 2025 11:40:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:38:08 +0000
In-Reply-To: <20250826183940.3310118-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826183940.3310118-3-kuniyu@google.com>
Subject: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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
socket() or before sk->sk_memcg is set in accept().

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..443d12b7d3b2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5743,6 +5743,23 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return _bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
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
@@ -8051,6 +8068,13 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_unlocked_sock_setsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.318.gd7df087d1a-goog


