Return-Path: <netdev+bounces-258938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGMQLjVdk2kr4AEAu9opvQ
	(envelope-from <netdev+bounces-258938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:08:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB4146E05
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 390FD3003817
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF2025E469;
	Mon, 16 Feb 2026 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZmAXvLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129B2405EC
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265327; cv=none; b=R3kI1/6VeeUsjwM1/O30HOU/IBMoMkgDZlwIRgsHgB3+gSSpe2KhqIRtZqAJqxd4YGlT4dFNcA/T5EwL6CJDxMgV6/xHRZeHtJgBJWFNvCIfslrLV4yOENZTP6r012zIMZWzzPRcD0foFyDECZ9etqDEjYIqZPB06HJL3SGeqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265327; c=relaxed/simple;
	bh=Bd3tmt4M+9ceHw5nqz12aEynN4DJJkIuUZ0fywQuWOo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pAHDk6QfY9iPDHvKZ2td0yFAJHdKqE2elDNoIhPcPZKKL5OqfjLCS6nXuHt6kE0keWxl03IPyEgl4GPO/K/Q7O56Wv9P5VXyfzVBQ9/kZdRdtevx4IDq57N9kbHxFCpATH7BZDLrlJNAoUEVmDoGK1/dELCAC2/w2CaZxHfLunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZmAXvLz; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so3069467d50.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771265325; x=1771870125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yle9sHoigY3mDIzaU7+NK9jhuL1ML3tmrDWjQvZIe3I=;
        b=OZmAXvLzcUI4CzMMhBqfW80PMO5T4qQ6zUnvoYCmHJTIRPHqvgxiPJNZV3fzRt0ac0
         2X9S0MLEGHAjg18Te+2TixaA6lSjqEE6+RVDzghXzWZKb2oeLBxYuo2bmGjw/73tSfTA
         ta7EiYELmsyvR/gj1F/XQ5D/NlIj3BsunEdZnGJFxJ9n/DSvCeML6vq9BK926v5W2cO4
         ZNItdNLP9BZM5MGd+KDhRIoNnwX62sIrhlTH8I/otuSXpao1niOBzzIKo//i/iecJHLg
         kMkmdt9equ6nD1ViNC0xfxq02XD/NonbRjZySLozsl0U2YgCUdtlFLwY8CAM+71iKbtE
         Jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771265325; x=1771870125;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yle9sHoigY3mDIzaU7+NK9jhuL1ML3tmrDWjQvZIe3I=;
        b=LqHL1JOXdB5XnTN3UKCgJ4yFKQtLD48Hz7k0qTZcLe7ju044C+tn8t02uTvQOklTgC
         cDgysW53h6sRLGowN31JYTa1GELG03E4HCSdUSCo8h1c8Pq0339ZmbE0LbwGhqeunzyq
         B+QDqITMjuJC1sTEEweYbbtqY9lmleklfB1AsGLWzm5c5K2QUE2yEjX56ujwiflHaQ2z
         bzWPdfvmF00+qk5m0P00vpExdZSb1bmP9OSkojhYhKDpIgBj3xS0plGNaKyPufm2GtWG
         KvDx9qz7ZHaywN7O4a5PLo0W8z9X2fGve2O762f7lkaYpyi26GSBDDevWS1gzTPAvEy3
         h0Ow==
X-Gm-Message-State: AOJu0Yw95G5jmKFdxD7DdpJZQpnaPRheXeJt5UAY5wBGCRk2zOq46yCN
	KZfqFq5RDoyaFEOPeryPznm6au4i/EKeMl/tYEvVXaAau53oZzXn4mNU
X-Gm-Gg: AZuq6aIobeTqv0aZazWP3/Nh26+5FanhhgoXyRmqqYeKSd90KVxQa3kJ4bLu221tdoN
	3v2ItYwxgGCp0Ji7KBAVgI4DD0Ynv+qu6B+qNW5d5/7GQ0wCgMt4lju1I4SC9zjGQbZOaWcCdg1
	jPprGbu5dzRjSMBRx76EGft4zDyvl7jDaMS/pGj4f8m5B5axDCHrZco+3zL1KTmSjL79wP7UFlR
	sCr4fGsh9Xo+oLrqEV2S0GsgdeVZ7T97+TbhklLcZQizqfimPwBNhlUXZ/dCY/Jc8vnXrLvG5UM
	MXGN9KKbgL44yYeSB6xhpZUn3SerrjhWlSr5b4O17saCwEE+Fd2PYrGBfOmKNZFiDLBPjSPAPyn
	zrbiiAFahj/EQu5xEK4NucIfNq7KB8+mHo7GdXGus85ElBjI4qIDUngCD/8Lb7BBlvWLATaGQm3
	0sdWCMpV7lYQWhIya7TGtLOjTDpMoBzUAIp6zSKlio3f1JGfSsy6TwCHz1AqmecJaHwCc1b14=
X-Received: by 2002:a53:ebc5:0:b0:64a:f0cd:d47 with SMTP id 956f58d0204a3-64c19b59a14mr5709618d50.84.1771265325330;
        Mon, 16 Feb 2026 10:08:45 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64c22eb2059sm3759395d50.10.2026.02.16.10.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:08:44 -0800 (PST)
Date: Mon, 16 Feb 2026 13:08:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.3b597169afaae@gmail.com>
In-Reply-To: <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
 <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,linutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7DB4146E05
X-Rspamd-Action: no action

Vadim Fedorenko wrote:
> On 15/02/2026 18:46, Sebastian Andrzej Siewior wrote:
> > On 2026-02-14 23:05:27 [-0500], Willem de Bruijn wrote:
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -5555,16 +5555,25 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
> >>>   
> >>>   static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
> >>>   {
> >>> -	bool ret;
> >>> +	struct socket *sock;
> >>> +	struct file *file;
> >>>   
> >>>   	if (likely(tsonly || READ_ONCE(sock_net(sk)->core.sysctl_tstamp_allow_data)))
> >>>   		return true;
> >>>   
> >>> -	read_lock_bh(&sk->sk_callback_lock);
> >>> -	ret = sk->sk_socket && sk->sk_socket->file &&
> >>> -	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
> >>> -	read_unlock_bh(&sk->sk_callback_lock);
> >>> -	return ret;
> >>> +	/* The sk pointer remains valid as long as the skb is. The sk_socket and
> >>> +	 * file pointer may become NULL if the socket is closed. Both structures
> >>> +	 * (including file->cred) are RCU freed which means they can be accessed
> >>> +	 * within a RCU read section.
> >>
> >> The fields are not __rcu annotated. Is this common knowledge or is
> >> there clear documentation of this behavior? Not disputing it, just not
> >> familiar with the rules around these fields.
> > 
> > The pointer is not RCU annotated because normally, within a syscall, the
> > file descriptor does not vanish and so the pointer remains valid. The
> > interrupt callback is an exception because we don't hold a reference on
> > the fd. But since the underlying data structures have a RCU lifetime we
> > could use it.
> > 
> > sock_alloc() allocates a struct socket_alloc which contains the struct
> > socket and struct inode (sock_alloc_inode()). This the sk_socket in
> > struct sock. Once you close the socket via the close syscall and the
> > last reference is gone then you end up in __fput(). The invoked
> > ->release() callback is sock_close(). Here socket::file gets NULLed and
> > proto::release should sock_orphan() the sock where sock::sk_socket gets
> > NULLed (I don't see where else and packet_release() does so). The
> > "struct sock" remains around because the skb has a reference on.
> > Otherwise it would go, too.
> > 
> > Once that is done __fput() does dput() -> __dentry_kill() -> iput() ->
> > destroy_inode() which does RCU free the inode.
> > That means if we observe the pointer non-NULL we can use it under the
> > RCU rules because the inode is released via RCU.
> > 
> > ->file. At the end of __fput() there is file_free() which releases the
> > pointer. file goes to filp_cachep which is SLAB_TYPESAFE_BY_RCU. There
> > is a put_cred for file::f_cred before that and it does call_rcu() at the
> > end, too.
> > 
> > This is me reading the code on FRI/ SAT and double checking it with
> > ptp4l. I might have missed something but so far, it makes sense.
> > 
> >> It does seem that updates to sk_socket, in sock_orphan and
> >> sock_graft, are protected by sk_callback_lock.
> >>> +	 */
> >>> +	lockdep_assert_in_rcu_reader();

It will be great to have this additional context in the commit
message.

And a Link: to the original discussion thread.

Btw, the commit states that a few drivers already call this from their
hard interrupt handler. Can you point to one or two?

If this is only for new drivers, it would be vastly preferable if this
can go through net-next.

> >>
> >> This function can be called from process context outside an RCU read
> >> side section, I think.
> >>
> >> Such as a packet socket sending and hitting the __skb_tstamp_tx
> >> SCM_TSTAMP_SCHED at the top of __dev_queue_xmit.
> > 
> > If that is the case, then we could create a RCU read section here.
> 
> well, __dev_queue_xmit() grabs rcu_read_lock_bh() already, we just have
> to move it right before timestamping check:

True. That was just the first example I found though.

I did not check tcp_ack_tstamp, or whether any drivers defer the
operation to a process context kthread without RCU protection.


