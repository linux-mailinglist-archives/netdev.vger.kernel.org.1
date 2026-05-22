Return-Path: <netdev+bounces-290706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBPZLd8JEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F385B0287
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E99D302428F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F239061D;
	Fri, 22 May 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dl/2HTwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F93A4F5E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435974; cv=none; b=rNo0MednhtUvenMcj+GX9HOF1zNHYFD9pKXz4IcaCQMDSZoamrX96+mqr/VMyq5Jz0oOIRzDnsVc4hL1BL5sCOaDSV0Uo55zvVpDnpWY9OE+IwwqUVWQUO74vWCnvHa73Vyx+27Y7Et0dEGx8JfPETjGTDVtQOQ5W9IukBW10Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435974; c=relaxed/simple;
	bh=ZyD9AQscuylwqpRs04xemnKsI72mnSLQlWHwuv5SjUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNxyseOFMH+S8kspCIqQDGRXiAznT03EhGEw2SGaXaj3K2yFSrklmCJk4i2/KKQzD1Uz7RO6bCyiupq/f6TWmQYUFE0XLo/3OzYO0oU1atwmABVTgx1lvT5G66/JOC5ZFAD9hl48DIUuu6gaMZjZI2Z2htUkVpbWJmgJ9P+EbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dl/2HTwM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso3129928a12.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435970; x=1780040770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXW60/1sU7ehwE+s4YZIIMUDlvA6FNdHZ/Kq8opfaUQ=;
        b=Dl/2HTwMPnUkG1rrt4Kc88/y0qFr9NeOLFKMRdm+m+mLr7qB8PhmoKpPwoaW/McPPY
         jngdl/zKFppcdA6A/GfgboQpXYcpvKmCmIgdCVGXBSK86D1xbGeF+craYwx8AiZL3ls7
         kF9vf+Y3kyQYlIOrwF/v0vMT/y55POO83lv4pC0/ZH/sdOLOeBvaCHtAM2zsvYm+Rb46
         GXiXy+jBpDkVpZl9HHszG0ewZ6cyPgGcUWVSuscPfyRJIrrHETBYLJ0cZjqvgT/M2wiO
         LeMwoYtgcVfaC4bCxEXSHrw0lKCMWcyhL2BbpS9bFq/Su6Axe7wSsFhevG2UySNwT6J1
         C0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435970; x=1780040770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXW60/1sU7ehwE+s4YZIIMUDlvA6FNdHZ/Kq8opfaUQ=;
        b=EG6zQ167eRKQgK5YEVl9qht1HoS+OgSfNXxjAkLLXLZ/2ksigzCYMSYYtfvWpJeoij
         gX+/YD7lqUbUJCLimjq+bNjkP1O6dtCE4s0VbuHE5XA6pomSHE4sYdFINGR7+XogV/gI
         Sc4Re5rxUEOyjSn1Y1GEsm2APoHifQtImH3J8L8n22RmKdtVIa/EPk9KrP0DBLRlX4UZ
         Emi4ueXku8dBJaF2EQ+8IJlAvYG6sHuGhflAk9ZKC4U4NH6VsSofAM9MqZzVBUzuW7PF
         YBVtt27RAOuQui80Ngogc787OmY/7GBid+yCZmLb6zpaCoUpgRGhZZ1bOrCAigBoA2so
         LceA==
X-Forwarded-Encrypted: i=1; AFNElJ/q6ZslrZE/2X6oV/GO3XMd/cJEQF6rpGTfh7ccuOt6wVu/as+hm9k1g/lyLt/+Msxpz5cu58E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRlMzEnDNPMCS2oud3EiEA4yn4I8EbmTmZAOMH2ouJ0I7mc7F
	gOs1RcQjKFtj6DcVj+HLM5CxvYZYhe8hN7KKsBsuI7VKRDJyZCZ5XTFc2X5RspFRQZ5q0sfRzYi
	ublXOtA==
X-Received: from pfbea10.prod.google.com ([2002:a05:6a00:4c0a:b0:82c:70d1:f303])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391e:b0:837:27f4:ffe5
 with SMTP id d2e1a72fcca58-8415f18266dmr2605287b3a.19.1779435969517; Fri, 22
 May 2026 00:46:09 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:56 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-6-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290706-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.846];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32F385B0287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVQ_CB
to adjust sk->sk_rcvlowat when

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

Let's provide a kfunc to set sk->sk_rcvlowat.

Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.

The wakeup flag is determined based on bpf_sock_ops_kern.skb:

  * For the enqueue hook, skb is always non-NULL, and wakeup is
    set to false because

    * tcp_data_ready() is always called after the hooks in
       tcp_queue_rcv() and tcp_ofo_queue().

    * when tcp_fastopen_add_skb() is called for TFO SYN,
       the socket is not yet accept()ed, and when called
       for TFO SYN+ACK, the socket is woken up by
       sk->sk_state_change() anyway.

  * For the recvmsg() hook, skb is always NULL, and wakeup is set
    to true because tcp_data_ready() is not called in the path.

An alternative would be to support bpf_setsockopt() by adding
BPF_SOCK_OPS_RCVQ_CB to is_locked_tcp_sock_ops().

However, that approach involves excessive conditionals and an
unnecessary memcpy(), costs we do not want to pay for every skb
in the TCP fast path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fa8a7c7d86eb..3608036632a8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12388,6 +12388,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops,
+					      int rcvlowat)
+{
+#ifdef CONFIG_INET
+	if (skops->op != BPF_SOCK_OPS_RCVQ_CB)
+		return -EOPNOTSUPP;
+
+	if (rcvlowat < 0)
+		rcvlowat = INT_MAX;
+
+	return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 					      u64 flags)
 {
@@ -12539,6 +12555,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_sock_ops_tcp_set_rcvlowat)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
-- 
2.54.0.746.g67dd491aae-goog


