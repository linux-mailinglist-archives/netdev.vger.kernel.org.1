Return-Path: <netdev+bounces-285690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EHGAG6S/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:36:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1704F3130
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111F5305B984
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59261347506;
	Fri,  8 May 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6Z55Ff9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1A37B003
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225661; cv=none; b=tgLW3tXQM0tRxX4Vc2qHWaAotB7DwoXo0SUGEcxh/Eo0Yus2Zca5ZlWGiQK/BMk18vE8MDJTG+8BTy+hXVPde1NUp/EVdaO5fi5X4YnQ3fSoznK/IWgL2xwsHclgq/J+xdukRcsuVmXjMuAaWQNCAf8mMWGN0o61pLS6qbEZPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225661; c=relaxed/simple;
	bh=26gn+M4pY38Nt/IYcQ1MvzQNTcsML7huVSIiWFPsGYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f5HnWQk62ODfd9YY3jPkDEm1kE4vxSQrsCm7S35xCt33QONk4qEcZBAYeOGrtNuq/htlSdCX2bPixu8MoSt/p26JihBo4fzrcXXrBuytouV7VV1BdR6vfmQXYPLv8aRm/VfdsRSpe3tvMuTIRBlY9kylCwKOVDc1MD/W/bbyDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6Z55Ff9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa366fb79so1796736b3a.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225659; x=1778830459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwlSPJSVpKQDjKE55hD8gfU2VDN+huaExAB4xtPp1vg=;
        b=n6Z55Ff9+yzq2CCsK52w8J3b5CGgFm5hxIwwsoIedRQ+TcjcffHgm3cgrgp4kD3tSV
         PXMCrHKU6p2r1tfTXVRcKssh2PDc3ZrOZbG6ytHYGyWKpqXL0gnXb2ZmVTXaxYmg/6lJ
         h8wMneG1ZjhWgnIEEvFvnEUNLbF0TuND+Feb9quou+WQ+WuvCFAABUZbu5/weeGTU/8S
         rXGENYqoSocxBrgu864WnbStsoCLtH5Vvw3MYradMzWOEYGit9QUEWnN57PmbpKdz3JX
         xmVFgByeyWZePZbSH7oT8KNFvqx+lqAokGOiLpTtD4/iR+Ls0/uBzyNllpG8zNNQIYjM
         Yptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225659; x=1778830459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwlSPJSVpKQDjKE55hD8gfU2VDN+huaExAB4xtPp1vg=;
        b=OuzYYI1rqZYiGfmzpv0RVC71zBxDgbOnz4txF7SsczmOWHxej/cLdR/pl9/63Nx0PR
         0qZ5ugYXFAs4Xu09Ioj7CbJBP8dAHp2g/0hf0E3sLDcH9Pn//1RUX0NPrNEy+yikpe8z
         sEGntHOJ7BkuVCQdZF2+ZXzEf2Ikw9Z8s3fvVQLuRxVYZ/RXdLXngY/hwMbltQyMFwGq
         +3hMRamyixWKX/qdlidoNjC3hHaKpKqiWVznrB8FyzCciYFIrASXnGJ0WBPMM76r83PH
         JUNJtiyBwFVeu+asW8Acqv0oiFvSE7dLG1kBqIE4YkoZaSjSM/pHmIc9yuyNFXDOYw8P
         cBQA==
X-Forwarded-Encrypted: i=1; AFNElJ9oY8lvtArZd9NxHV1kWmXAXF/tqbQYJgbhwZpCgRG+qWidMzLB9ebKEhxq48I5c98pS3ym1Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYkL4FAbc02xsS6HEgs4/+HNNepxo1Zp0+Wn2NL4SZYiMcv3D
	5VYDyE5SjfRRt6OC2qk6SmxRJ5/qFjvcDmfpjuyYUV34suTJLWA9jsPbOGMwtOujnXdn/2uwHI8
	wfl2cgA==
X-Received: from pfcj19.prod.google.com ([2002:a05:6a00:1753:b0:837:e800:7c2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a21b:b0:82d:5da9:adc9
 with SMTP id d2e1a72fcca58-83a5c2be03dmr11803194b3a.12.1778225659127; Fri, 08
 May 2026 00:34:19 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:26 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-6-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 5/8] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
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
X-Rspamd-Queue-Id: AC1704F3130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVLOWAT_CB
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
BPF_SOCK_OPS_RCVLOWAT_CB to is_locked_tcp_sock_ops().

However, that approach involves excessive conditionals and an
unnecessary memcpy(), costs we do not want to pay for every skb
in the TCP fast path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 94d07a15b2ab..9c4cd27c6d4e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12346,6 +12346,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops,
+					      int rcvlowat)
+{
+#ifdef CONFIG_INET
+	if (skops->op != BPF_SOCK_OPS_RCVLOWAT_CB)
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
@@ -12497,6 +12513,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_sock_ops_tcp_set_rcvlowat)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
-- 
2.54.0.563.g4f69b47b94-goog


