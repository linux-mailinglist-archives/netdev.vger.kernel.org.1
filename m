Return-Path: <netdev+bounces-301162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7n74JWFgOWpDrQcAu9opvQ
	(envelope-from <netdev+bounces-301162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7476B113A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LQz0b6Y4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D01E9304A927
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323273CB2F0;
	Mon, 22 Jun 2026 16:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD03148D0
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:12:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144745; cv=none; b=s5NBbREdmIbQGZD1Qyc/zAw9rm0+JF7WQJfJQrh+4mvVp3jNI2uM3j4PadfYuOBtqoT/X/vIDlFpTqir3xE4jdO/yKuErOoVdchatWAEsVjwKEw/a85ibrcZaq2i94Kdns2UMj2vUQC6p9Of5Cb0OLX3qYE8ZBmJVXKtUB40P4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144745; c=relaxed/simple;
	bh=rnpGHcRT/uDU1Bh3FfjKGETbbXNtClx+wKFf7+M0tc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DfRRqv2G8zQwgP3SRrIbINTl9UkkRYZzolaZqk3veNysn1mMkqfi+li9LnANQp+Z2VooA3k7WeHZWFrghE5fsBr8GDaOn4cRpOAvOWXVgVf5oc7wD8+JMqukQ7EDbKfuFLD9lFU7wv1oRaWYSTQzZGTOjP2eKX0f3vofRQJA0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQz0b6Y4; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so2878873a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782144742; x=1782749542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvWly0L6srT0V376JtE+3+EfepszO+XEtHPredUzn5c=;
        b=LQz0b6Y4jauQRQHV+b0wdZiEX6TU/FSyjkpxr3Gu+Eag3iiv0S64dSxSYMNj8PIyw4
         u2pob4GuKCtZqEiYrqANvfOU/OPOsfyKWQSTJSMudcQAqOb4UQcd70C5Cth/mC+UZFtG
         Js5A+8dJj8j+WETfGI+ARNsAjBDKabsmB39F/8M5x0zCUwEgcb3rXorS9fUml7BanWmg
         E8dAODMBcr7rCEkBqv3MWrUOiAccsRrWizzQueTv+gV90Zsig7Bo1L/4CHDshDgLG+Qs
         NhnmuHoodvxZLATZyqLiBnf6dmjZcSKRtCcnAYy//M/rsyVMAoWtfalXzSggge7/PJ9d
         jyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144742; x=1782749542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvWly0L6srT0V376JtE+3+EfepszO+XEtHPredUzn5c=;
        b=f4yJUBuI0GsR//OfvqmTR09PvktFTT494WgiwZyWPM4nYR5nYQrzNjm5JBoOFEa46H
         qS4cjh5mh8RU4wqvSLSNRoiEYwl8tV7MeltaCqxxqkBHt3hWLrE6CuHNB67+Oo+IUiAF
         cbbiXKMy0ZeDwd14cGQkSK1K0QwlgNIcaU7M/QoOA1rKbxt49bu7MC4oIm+8dzMigWLn
         8849nn++qNNS9vV9jPbKR6QBAwN4kNjKTkSaLHl00CFXS7EpbR6TkPAnQqqPzMvWUQqQ
         +ekoVka9ALsGM0OWAYONjs3qe2g40d31eksEvJmWxXR4Wo4c4mPYQy+EDA49eQO5a7U6
         T67g==
X-Forwarded-Encrypted: i=1; AHgh+RoyDO6gKJRhAmoeX8HvNHzZYPkY6pMEYNIc4Bp44Hp66q0ZINeno53hjHeyVb5x7uELw+WwYzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvtx2paq1ULq+1H8ZD/tJMBOFw6x9wVr3Qcaydnm8RYNoVHKD
	XantHtrSKslpzX0ifbEfmxftU99/iyipuLcqTulq0iowNXVGzaoSrO+EngYQyAOXN32IjC7+SvP
	wFSRkHw==
X-Received: from pjbgb21.prod.google.com ([2002:a17:90b:615:b0:37d:833c:fe41])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3911:b0:37c:9bad:f6b7
 with SMTP id 98e67ed59e1d1-37d160728b7mr13874467a91.11.1782144741968; Mon, 22
 Jun 2026 09:12:21 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:11:40 +0000
In-Reply-To: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622161221.1742161-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jakub@cloudflare.com
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	jiayuan.chen@linux.dev, john.fastabend@gmail.com, kernel-team@cloudflare.com, 
	kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301162-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:kernel-team@cloudflare.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7476B113A

From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 22 Jun 2026 14:58:34 +0200
> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/unix/unix_bpf.c | 6 ++++++

AFAIU, everyhing in this file is for BPF_SYSCALL && NET_SOCK_MSG,
or am I missing something ?

I feel that it would be cleaner to add a new Kconfig that depends
on BPF_SYSCALL and NET_SOCK_MSG, change Makefile obj-$(CONFIG_XXX),
and guard .psock_update_sk_prot in af_unix.c


>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index f86ff19e9764..5289a04b4993 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -7,6 +7,7 @@
>  
>  #include "af_unix.h"
>  
> +#ifdef CONFIG_NET_SOCK_MSG
>  #define unix_sk_has_data(__sk, __psock)					\
>  		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
>  			!skb_queue_empty(&__psock->ingress_skb) ||	\
> @@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>  	sk_psock_put(sk, psock);
>  	return copied;
>  }
> +#endif /* CONFIG_NET_SOCK_MSG */
>  
>  static struct proto *unix_dgram_prot_saved __read_mostly;
>  static DEFINE_SPINLOCK(unix_dgram_prot_lock);
> @@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
>  {
>  	*prot        = *base;
>  	prot->close  = sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>  	prot->recvmsg = unix_bpf_recvmsg;
>  	prot->sock_is_readable = sk_msg_is_readable;
> +#endif
>  }
>  
>  static void unix_stream_bpf_rebuild_protos(struct proto *prot,
> @@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct proto *prot,
>  {
>  	*prot        = *base;
>  	prot->close  = sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>  	prot->recvmsg = unix_bpf_recvmsg;
>  	prot->sock_is_readable = sk_msg_is_readable;
> +#endif
>  	prot->unhash  = sock_map_unhash;
>  }
>  
> 

