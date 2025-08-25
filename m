Return-Path: <netdev+bounces-216653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE9B34C3A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B4F7B5B94
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360229AAE3;
	Mon, 25 Aug 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="algnNJqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8429BDB8
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154530; cv=none; b=qqkzKVGYlk9/MopPi8OzPVnCsnk/zrBwwm7ONhNIBZs6hOkET3b9XxOGZ8UE1You1ZsV4PYl2+5O1Uff3sYyHnF8s3K2HIPAwr2arvxZ8XioYWy/iZm8+uGwPJnlhVqXu4/vmsXescWecOx8R7Jw2o7P047Q1w6MrYUFMyCrhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154530; c=relaxed/simple;
	bh=J4sq2HVpzm8ou0LFMByfXyLT3uq1CSFAUpdCkJLN0fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oGYumOkeCQVGCtnvU2gZLaB5QfrGSrr2gk/Pfjg2KFMau6xluz53k5SMxhQFumxr+dnvVrRPaHs7ha4OMinJwOzBJjfHJ6PHPehyFeIIg5VliW0/VaEKECzdqnBun4M4yDMhZ7TFzV5z8Xv4itFQHbakaOMcU1ymIeTfBv35gNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=algnNJqw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324fbd47789so4115908a91.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154528; x=1756759328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UdZkVzjW5oGtGGFKrP9IRh3u4x1tuXdRI3VCIV41aw=;
        b=algnNJqwwOIbZOCrWBM/nVpZOfIkdHc4MYELCqUrKL/pqzVI61Do262YDASuYi7QeP
         H+aHsD7kl7Evghew/L7m+BjjOzour0qle/eS8AscA38YbKDDZDakKHla4B0Vb5JzJj8s
         o0rmHD1aXBiOsNZz6Ixav00iawLAaso3lvGAOVJLzhFr8JceBeNUhdcsFWmQVg9hIn1k
         V9X6IVkQF4pPyoU8n7CHZ1h2QfXCAxuW5TNSN27QsxrK9bFj5M68qyLuN04ElnanW+Xh
         UUiQoZy55hbm27MRoEETqq1NYFh7/QF0dnFMeKu6xV1Ex21ViQGLBPoZwagkYd7GO9eD
         6ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154528; x=1756759328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UdZkVzjW5oGtGGFKrP9IRh3u4x1tuXdRI3VCIV41aw=;
        b=oHADprp9tphL+6eWz8Tmu4+S8CCmnTQlsCQGHMSiem3TSQkWjs+EYNoehftVAEfPrq
         n83lwqd88WyyI+JFqEqnxp8CjhVL4DAsZKTN5hdHaF5RzZ56dd4tv2nPNs8kD/IXKNU9
         qw9LCezOKGlDXWJr3Lp0K77QGFCEixrf8f6SXJH7sYHIS+SgdKCPTIdj/33cy02nv4Wh
         qO8vnq4CBs/JwaUGMksJd9fQi/AK3PveYj/k4uFO2UggrWozIrLDmbptu4qW9K/ACoxM
         BkZbeY/WB0hGh61kMKwuzn/QcRgUxTq+/Ag5nxV2p+iQI0UaKB0lctwN+S4p1xLTVToE
         c63w==
X-Forwarded-Encrypted: i=1; AJvYcCWlvQ/HU8ZiPu/uIO4QMF8Z0RoGRnRgN4v0FWEa4JFBFaHtYVne3+d0zrEuI5jmW62D8a1AfgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57ZNQcvKytgPDSU3QRQ2vNcItoy9X2yB1Sr2YiRvBV1nNjC2g
	6UNrDeOZ0qL6UJPzuEAH0CW0mTOLREE5CzmmZJBZbRsE/dIACG7W/aikvAQQ7ytJdFrFONwRC9G
	SXqmZrQ==
X-Google-Smtp-Source: AGHT+IFXCw3JqKqAP6NeUuK4c91n9d43KxLQoQA2UskYGS6nqsHtcqlZzi3V3FSnC1mitkCd3MPJSSkP2y4=
X-Received: from pjff11.prod.google.com ([2002:a17:90b:562b:b0:31e:cdb5:aa34])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224d:b0:325:322b:7c43
 with SMTP id 98e67ed59e1d1-325322b7d91mr15095767a91.8.1756154528412; Mon, 25
 Aug 2025 13:42:08 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:28 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-6-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 5/8] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_(CREATE|ACCEPT).
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
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..1fa40b4d3d85 100644
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
+static const struct bpf_func_proto bpf_sock_setsockopt_proto = {
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
2.51.0.261.g7ce5a0a67e-goog


