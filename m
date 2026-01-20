Return-Path: <netdev+bounces-251521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPo7K0u9b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:37:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0948AE4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A56397C195B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F844B68D;
	Tue, 20 Jan 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fC5ypsaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D343E4B0
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921289; cv=none; b=SflbwavL0U38AhvScX687CxORpMu49KWaPGlC9P1rpuDCzrCS3g+AhrWlHk87a3XPsc3hrSm4Obbh8q3aYdifHcSNWfv5a8Um5kYPkcFWZv/lF7nEH53+DW+QtotLi4fo/vuvXnU8kb9BIWcC5Z2O8CgS/rzHmBsPoZrXHtRI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921289; c=relaxed/simple;
	bh=e3KIXA5K1BSTDXaN5S3F7j8PM7hZNZ2/owWnE24bZ/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYphNa/unEwQBhU4jZhUDgV1HFr6H1U9hsZbNpsfH55KZUzHDHGxY7PtxeA7ljxsQZwrnehTsfGrTn4leoqHK0WZH/Dh9qosrV9GDz0Ws25876tUTpnhfox2zhbRezBfwwJPHuS7RweckbdRlfLkJrhIsH5OKqToG7Dqe8wWW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fC5ypsaZ; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b870732cce2so831259066b.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768921285; x=1769526085; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYI0gLBKIqxhNhOB7IM8ExaSr/699rjlW1w6qxp7P1A=;
        b=fC5ypsaZsDFQsZ88mcEV6PqE0f66AfimA3K/Yo7OMqf4+47DIxBicb7hiZcm7dKhu1
         u0cp2SevSHnrlBejhvTBWWsaQexcocCQuO/DIpJR5JTHolXIH1V7xnl3if2zrMmqLVKn
         cfQRPEwdnH55vhoJuoRSdHgG2xxCuWLEQ9uSS+p64ICoPX/lrMRVSqShg5pcYQLSmg1p
         B+wcH47AXHTRrD7EI79vjwnK8jc+dx33QmA01cOu3Tn/uveJoCq7oLWCxamXlti/E0u2
         TMj/Hb6si8v9TAVVSfijHmZC2AMOHH6rnKa4lmKPaAMRRx+PRxfZ6nyD1dvPYT1SPFbJ
         5fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921285; x=1769526085;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYI0gLBKIqxhNhOB7IM8ExaSr/699rjlW1w6qxp7P1A=;
        b=LMhTNVyjoNXkZIG5QhpraCSABSWa9cc/jklcxKDISouSJVsn63Kfk+BdlvDbn9IgID
         Fv53oiwpLgjtTGOWyZF+a/HfQM1hwjI6zkd3A5NU3MnlsKlZHANAlcm1Jzxsjv0f3pYw
         EFYqvZPyIV5VrwSAsV8C8D78FYiKyTWYxXt24OB9sKdF//agQyLig8V4P8aUTqS4nOG2
         DoytvGxXEdUE8OvONozVvitsbeWKtZI3MxvsMSAWssxZvgoKLbcqkFrPjp/BsLnCr9gu
         +SHb/DjiXJuanXE6NmO+KsMwTus6M+++FqBZPLtVnFSq3u6WxbUsJINefwodMjUdNXHl
         OyUg==
X-Forwarded-Encrypted: i=1; AJvYcCWWa07R5ERGdowIvlzvVdr18ag7+ZydIMbIbNGb/5f0Y5JsvpcKqqHt/NKXnVKvWR29v53IqSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWFBRriewCCgURPKK9R1hcycDAPVq9wuIAqs99QsFmVmA5Wfj
	aKJ5NcEyv4Mp+EoIzzRB1YNWdcODjU6aoC2HIVyJ/xhtnBa7LRIodVLT3ON+oenrWv0=
X-Gm-Gg: AZuq6aLWIcjlxVt2Kge7Y5QuL0sUq0Y+yV5YnfT0Lg8SG4jVSq96fY90Wol+oWUNfR8
	mFJWIf2JeGq2S85I582zkyqeER3DL1AuzZZs7oqLmQr7DkdWGicty2ibMWcyE21kl6gf+zCBiLu
	+jZeaE+oiCUwURtugRkyPwFkzb9HdKgKHCTUg5i4gY4N1RZ8cbSzXuJDgAmWMGhmFZ19BgmSNop
	AP4oroFmRa5trqnOZI8+XMvUINpXZtFVDSb8u7O3Rd4I95Hyb2Qy/v/ANEcC8B75v0b235aI2b+
	9ilZ+i4Lz6I36yN6cUH+3/sKWcJa7GpdGR+2mK5qPP8byu1PVKQsDuog8SJbvEiqSyioKpxYABU
	R30bgTM+d3vDdqyzRwlZyToIzi4oBYredjUjuuSC55xEo8riuq1+ihb0wIc7hKHMkANxbxC9CEl
	7NFQ4=
X-Received: by 2002:a17:907:e106:b0:b87:f6fc:aea9 with SMTP id a640c23a62f3a-b87f6fcaf6amr234043466b.9.1768921283931;
        Tue, 20 Jan 2026 07:01:23 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c96f4sm1419134966b.40.2026.01.20.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:01:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20260113025121.197535-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 13 Jan 2026 10:50:49 +0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-2-jiayuan.chen@linux.dev>
Date: Tue, 20 Jan 2026 16:01:21 +0100
Message-ID: <875x8wuy4e.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251521-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: 55D0948AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> The issue is that when reading from ingress_msg, we update tp->copied_seq
> by default. However, if the data is not from its own protocol stack,
> tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> native socket, reading from this socket may fail because copied_seq might
> be significantly larger than rcv_nxt.
>
> This fix also addresses the syzkaller-reported bug referenced in the
> Closes tag.
>
> This patch marks the skmsg objects in ingress_msg. When reading, we update
> copied_seq only if the data is from its own protocol stack.
>
>                                                      FD1:read()
>                                                      --  FD1->copied_seq++
>                                                          |  [read data]
>                                                          |
>                                 [enqueue data]           v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/skmsg.h |  2 ++
>  net/core/skmsg.c      | 28 +++++++++++++++++++++++++---
>  net/ipv4/tcp_bpf.c    |  5 +++--
>  3 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 49847888c287..dfdc158ab88c 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -141,6 +141,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  			     struct sk_msg *msg, u32 bytes);
>  int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		   int len, int flags);
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *copied_from_self);
>  bool sk_msg_is_readable(struct sock *sk);
>  
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2ac7731e1e0a..ca22ecdbf192 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -409,22 +409,26 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
>  
> -/* Receive sk_msg from psock->ingress_msg to @msg. */
> -int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> -		   int len, int flags)
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *copied_from_self)
>  {
>  	struct iov_iter *iter = &msg->msg_iter;
>  	int peek = flags & MSG_PEEK;
>  	struct sk_msg *msg_rx;
>  	int i, copied = 0;
> +	bool from_self;
>  
>  	msg_rx = sk_psock_peek_msg(psock);
> +	if (copied_from_self)
> +		*copied_from_self = 0;
> +
>  	while (copied != len) {
>  		struct scatterlist *sge;
>  
>  		if (unlikely(!msg_rx))
>  			break;
>  
> +		from_self = msg_rx->sk == sk;
>  		i = msg_rx->sg.start;
>  		do {
>  			struct page *page;
> @@ -443,6 +447,9 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  			}
>  
>  			copied += copy;
> +			if (from_self && copied_from_self)
> +				*copied_from_self += copy;
> +
>  			if (likely(!peek)) {
>  				sge->offset += copy;
>  				sge->length -= copy;
> @@ -487,6 +494,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  out:
>  	return copied;
>  }
> +EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);

Nit: Sorry, I haven't caught that before. tcp_bpf is a built-in. We
don't need to export this internal helper to modules.

> +
> +/* Receive sk_msg from psock->ingress_msg to @msg. */
> +int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		   int len, int flags)
> +{
> +	return __sk_msg_recvmsg(sk, psock, msg, len, flags, NULL);
> +}
>  EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
>  
>  bool sk_msg_is_readable(struct sock *sk)
> @@ -616,6 +631,12 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>  	if (unlikely(!msg))
>  		return -EAGAIN;
>  	skb_set_owner_r(skb, sk);
> +
> +	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> +	 * data originates from the socket's own protocol stack. No need to
> +	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
> +	 */
> +	msg->sk = sk;
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>  	if (err < 0)
>  		kfree(msg);
> @@ -909,6 +930,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
>  	sk_msg_compute_data_pointers(msg);
>  	msg->sk = sk;
>  	ret = bpf_prog_run_pin_on_cpu(prog, msg);
> +	msg->sk = NULL;
>  	ret = sk_psock_map_verd(ret, msg->sk_redir);
>  	psock->apply_bytes = msg->apply_bytes;
>  	if (ret == __SK_REDIRECT) {
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index a268e1595b22..5c698fd7fbf8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -226,6 +226,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	int peek = flags & MSG_PEEK;
>  	struct sk_psock *psock;
>  	struct tcp_sock *tcp;
> +	int copied_from_self = 0;
>  	int copied = 0;
>  	u32 seq;
>  
> @@ -262,7 +263,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	}
>  
>  msg_bytes_ready:
> -	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> +	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
>  	/* The typical case for EFAULT is the socket was gracefully
>  	 * shutdown with a FIN pkt. So check here the other case is
>  	 * some error on copy_page_to_iter which would be unexpected.
> @@ -277,7 +278,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
>  	}
> -	seq += copied;
> +	seq += copied_from_self;
>  	if (!copied) {
>  		long timeo;
>  		int data;

