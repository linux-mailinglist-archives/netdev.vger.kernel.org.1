Return-Path: <netdev+bounces-297228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KEJQBetbKGrRCgMAu9opvQ
	(envelope-from <netdev+bounces-297228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:31:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11239663556
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:31:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RawhVVrO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297228-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3166D3079900
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE84C6F08;
	Tue,  9 Jun 2026 18:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF774ADDA4
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029317; cv=none; b=A0GZCLRHDqbjzTAYnfFaQEdBKu2QaKiRFD0I0b1ciItkHy2uxaA+Goo/JAlEP4kg7vhxzDXuQapVY068Q5hpiE/cEgTlDPDhqr/UC6rtp95iMq3eC7C1VKDler3yFEE0cpfNrS1vQcSp9KIvYmEATrKGPWJIMN0RQsF/IVpb5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029317; c=relaxed/simple;
	bh=MDqw6E1NFQvJRAPqDEem1t57vShB0cBoV13q5Qxc330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqhBFnLXAGPyHVzJTQFhozIJcyWhNVKitEqbyRgqwhp/31cvA27JdBsTZoRPRcolc7DpAGCXFl3+NWtp9o3+blfJLMic5XuG9tQKp65g+2HKZmAOqNvVkAOqGBU/LpsB2mFkC0swXSQKHmr5MdgdbU1YDFYpitlCagJGnqZV2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RawhVVrO; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5522055a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029315; x=1781634115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcqjUQA9kv2/3qirEOddNlpBhe6IWcklo76jpxd9AfA=;
        b=RawhVVrOg/OQSQo4NeNprd+5IGEaO6LrXYvqyLhcdMI1qX8tsw7ujp20lc2/evpMFv
         Af8HzSQKo5wbE5yP7giG040BEh4VsgoXFF5eyBu4zctf8fAOhNwpIIxI30vPOFtPyapG
         OyDEV0ezgmRmVDj671vbbzmMxRqVUx9Gd39OmT0WU7DktyUqDpwYfg5YxnB1wssIDQv+
         UxynomBMz4uqNJVG7IUY/a4hcuq2MhA04fHbVfaIfJrv8kLPMzWizLpGxGl3KMtEEShJ
         sPl/5n2gRaSB5r/RTQ0DloP8xmbxrB9IYTTQ7zC068rdwk/Gz0MkaHq/Rex9jobGNBIJ
         1TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029315; x=1781634115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcqjUQA9kv2/3qirEOddNlpBhe6IWcklo76jpxd9AfA=;
        b=oxggTmhltLCekvptZo5suYI4T0ovqQqosWQj1jJzh5oxIbXj/qU4O/O429w+w5ZHFV
         pBguwlJHR2uyg9oAG/6lLivZyPmco1II3ajdoTLiRb/GmNIC2aS0y0b381Ww2vsALMn8
         tI5KeNavRORbbxz1xgIXyfqz7wbB4CHfRtF1TLZgS2pkSN+r2WnTKcQXc93KGkAjglF8
         ub2c1h0tM1CPHWFQD/UoJ4E6ckkVmKu7SeOtpFrQQDHTysex1o/uKPGnGBwypP5XmLWK
         JHdXKZUOabBxPhkPeebfxNc5ZkZeHVE6mDjOoHavEUoVpo/vJEL6Ce0fYjrWwzG6SqcZ
         ztYw==
X-Forwarded-Encrypted: i=1; AFNElJ8pF0QZuySl+p66DGKetMiKzS99RDHlF8bj3fcCqeswVb522OSM+z+8PhOxXdo/PXHCktjGlYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRAbrBBKSzd5K96uws/B4F8Om4vDMnf276uxHwQx2CtcU3t0P
	jCdykOIA6UZ47CAjSt6az+uvTIjySs6A4AJ/DIf6tCH8ol7kvMZagZ5E
X-Gm-Gg: Acq92OEu6d2pROEx764pS3FH4sc4gkgXy6PWXMwz6Xjl3glYzp9m8mYRs3ze2VXmcYj
	D+ntlfBug7u0pv7FwqBkpCTr6qswiyK7WSLz9noL8qnETGJNBunorDuTq3Xs9sE8scBLIJTbF0P
	B3LKL1L9f9wOwzKgWE/gNvPFY2Erz4PNmqtcJ/RQ14rFR9WL9KugXEbH8MWqA5fziZ6wrkP5iEy
	VHeBIi6DrYWuCGOn2IcPicegRv7ForvxF5XbU8Y3fCG8pN0AYtWZTo7afKXsFbvX9MMcjn1mAwG
	F2FhT7gmkrFSxgmrvXv6QkUXABPzckWMlAN39SOMJkTovfNpwSNLzp4muRmI7ffA26ZWjZVUfK/
	5Z/5vuihgD7TcevrVJpl+nU+61Kx8XMO+4p54Ez0GzgAHb8nCkL0i0VcBlw52JrWyRFa6C/mdXL
	LC8Ll6fwyDO6nfTz9wupS5w/jfjYhkRpuPvTwa5sL/NmUz6DsapK0Vq4kPN297IjQl
X-Received: by 2002:a17:90b:5109:b0:372:94b9:76d8 with SMTP id 98e67ed59e1d1-37294b97715mr15579831a91.6.1781029314769;
        Tue, 09 Jun 2026 11:21:54 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa072asm218684505ad.34.2026.06.09.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:21:54 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:21:52 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <aihZtYXz8CbxRo0L@devvm29614.prn0.facebook.com>
References: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11239663556

On Tue, Jun 09, 2026 at 11:23:03AM +0000, Sechang Lim wrote:
> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program to
> find the length of the next message. strparser assembles a message out of
> several received skbs by chaining them onto the head's frag_list and recording
> where to append the next one in strp->skb_nextp:
> 
> 	*strp->skb_nextp = skb;
> 	strp->skb_nextp = &skb->next;
> 
> and then calls the parser on the head:
> 
> 	len = (*strp->cb.parse_msg)(strp, head);
> 
> The parser is only meant to inspect the skb, but the program may call
> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB. Once the
> head carries a frag_list these go
> 
> 	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
> 
> and __pskb_pull_tail() frees the frag_list skbs that strparser still tracks
> through skb_nextp:
> 
> 	while ((list = skb_shinfo(skb)->frag_list) != insp) {
> 		skb_shinfo(skb)->frag_list = list->next;
> 		consume_skb(list);
> 	}
> 
> strp->skb_nextp now points into a freed sk_buff. The next segment of the same
> message arrives in __strp_recv(), which links it with *strp->skb_nextp = skb,
> an 8-byte write into the freed skb. The free and the write happen in different
> __strp_recv() calls, so the message has to span at least three segments before
> it triggers.
> 
>   BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
>   Write of size 8 at addr ffff88810db86140 by task repro/349
> 
>   Call Trace:
>    <IRQ>
>    __strp_recv+0x447/0xda0
>    __tcp_read_sock+0x13d/0x590
>    tcp_bpf_strp_read_sock+0x195/0x320
>    strp_data_ready+0x267/0x340
>    sk_psock_strp_data_ready+0x1ce/0x350
>    tcp_data_queue+0x1364/0x2fd0
>    tcp_rcv_established+0xe07/0x1640
>    [...]
> 
>   Allocated by task 349:
>    skb_clone+0x17b/0x210
>    __strp_recv+0x2c3/0xda0
>    __tcp_read_sock+0x13d/0x590
>    [...]
> 
>   Freed by task 349:
>    kmem_cache_free+0x150/0x570
>    __pskb_pull_tail+0x57b/0xc20
>    skb_ensure_writable+0x236/0x260
>    __bpf_skb_change_tail+0x1d4/0x590
>    sk_skb_change_tail+0x2a/0x40
>    bpf_prog_1b285dcd6c41373e+0x27/0x30
>    bpf_prog_run_pin_on_cpu+0xf3/0x260
>    sk_psock_strp_parse+0x118/0x1e0
>    __strp_recv+0x4f6/0xda0
>    [...]
> 
> The same resize also leaves the head's length inconsistent with its frags, so
> a later __pskb_pull_tail() can instead hit the BUG_ON(skb_copy_bits(...)) in
> net/core/skbuff.c.
> 
> Run the parser on a private clone of the head whenever the message spans more
> than one skb, so a resizing helper can only touch the clone and strparser's
> head and skb_nextp stay valid. Single-skb messages have no frag_list and are
> still parsed in place.
> 
> Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/skmsg.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71..d5b10f9b0ba8 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1146,14 +1146,30 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>  	struct bpf_prog *prog;
>  	int ret = skb->len;
>  
> -	rcu_read_lock();
> +	guard(rcu)();

I'd probably not mix this rcu change into this patch, though I
understand it drops an unlock() call in the new err return.

>  	prog = READ_ONCE(psock->progs.stream_parser);
>  	if (likely(prog)) {
> -		skb->sk = psock->sk;
> -		ret = bpf_prog_run_pin_on_cpu(prog, skb);
> -		skb->sk = NULL;
> +		struct sk_buff *parse_skb = skb;
> +
> +		/*
> +		 * strparser chains the message skbs through skb->frag_list and
> +		 * keeps a pointer into that list in strp->skb_nextp.  The parser
> +		 * program may call bpf_skb_change_tail() and friends, which go
> +		 * through __pskb_pull_tail() and free the frag_list skbs that
> +		 * strparser still tracks.  Run the program on a clone when a
> +		 * frag_list is present so it cannot drop frags strparser owns.
> +		 */
> +		if (skb_has_frag_list(skb)) {
> +			parse_skb = skb_clone(skb, GFP_ATOMIC);
> +			if (!parse_skb)
> +				return -ENOMEM;

I wonder if this could be further gated by prog->aux->changes_pkt_data?

One possible issue with adding an allocation here and returning -ENOMEM
is that this will shutdown stream parsing permanently for this sk when
under memory pressure, which is new behavior. Maybe, if we return 0, it
looks like the caller's accounting stays true by taking the "needs more
header" path, and then we can try again from the same place on the next
data_ready, and so be resilient even under memory pressure? I guess the
trade-off being that their may not come another data_ready to cause
progress... not sure which is better. Maybe strp_start_timer could be
used here too?

Best,
Bobby

