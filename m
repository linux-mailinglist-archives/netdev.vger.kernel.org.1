Return-Path: <netdev+bounces-287058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ/aHfv8AmqrzQEAu9opvQ
	(envelope-from <netdev+bounces-287058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:12:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1E51E522
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2270304CEB4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD914C77AA;
	Tue, 12 May 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aCR5cVer";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNRpbl//"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4B3AC0D3
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580430; cv=none; b=nxIlY+IVweQfj3xefgP4ipNu1Nb6ULYYNTwQp4iZ4B0wuS3s/rF6xH3Qs6dkjSWKNuDkxjwm592xMRwr0lHUs8CqHpnmTlkg38w5hw65DqjrxPSM9P5G/BVB8ia2XBdj77K4+DvuhM5xQNYHf5Gr1GP0QsSyi6qTZo3QnwAMof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580430; c=relaxed/simple;
	bh=h0i4ieS/BkyXiFtwoxy7yihh3Nl6Xo9jU/58MwAo/R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbvJpYrPRkLh/C9g2ZP+d7QuS1hkzgJLNx0BOd5hMs1RFBkwJf2z05kP4ulZQ7H+ksKn+l8i8DLj+yrpHKGjCuUg8RTyIoTqicZxHLSWqFFKR5YthI23YGGnFnu/8T5+jSYp9ypwZdiSgBhZFiPJfSkT1KtLZleVMK/qPNHJYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aCR5cVer; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNRpbl//; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A29667A011F;
	Tue, 12 May 2026 06:07:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 06:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778580426; x=
	1778666826; bh=fvByL/bwiqxIfeftWHoaHQZg8eSZadJNGAhfU4qTq98=; b=a
	CR5cVerUaogJl1xlcSx10/CikMgqf8P8uM/lPwsAU5i0NNSHSJ5QQzbvUxqBDjR9
	/3LemY/e5Xf3g+0jTcWKjXe2cxzTxhw06JzxSwb3b1DTRWqnCfpe2xlsl/jG/AK1
	4f2bgLfafklgGWUtcs7ZO5heCsU7gERUomS9SkT1RPh/1eqtN6H1r1RQXgP4pEL6
	TF+U9aG1iomr+YUJG9u7RQQSjkCa3kOi3omPJe/+s4J2Kd3BM0emjbohtPPyiE+F
	xiKm5/YASpG6lcPpzzdRwLff1nZcMyJLYjM/RZ0plpiTYdPD4k2JqembNO1jUjBJ
	ZjKwIt66KyetXHZ7e/K6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778580426; x=1778666826; bh=fvByL/bwiqxIfeftWHoaHQZg8eSZadJNGAh
	fU4qTq98=; b=eNRpbl//U+XeKYdqgvWJJAWRii0ByUl7B7f2B8wol9cuQmcw6fE
	emgSol+UUvxAnVEtKI6cewZcYRzbsmU4OdjbUZPhkeg/vcFyN2rggnC0Ae3NcAL2
	5j+vopNBIP02+xImPdQIRkT8GJKnrmcBO2L0FkkC/eToZAB8kbCmV3tCl67pu3X3
	z2WC+M8qpyPz7uaQ8RtYzRGJQOCD4rLg5PGmSt3besOsUw+u3s0cwYpX21rqeAGk
	KaN6h6Mw6UmO42kXf0CtfHgEB4hBVV9OzEQB2vNdCk+cVj8B69I3g1V/mqESk+PY
	i5wuL0H5Q46+gWA+obRZR+0cIGwrdNJ2XRA==
X-ME-Sender: <xms:yPsCagl4MVbx52seipINgu0mI1RmNqluYGJutAw3RcumJdZHTce8GA>
    <xme:yPsCanYBxvHlzOJmSeXtILKRIGx63pm3_7lEU_7wz39nOjylFvKPCjdYOCQkcBr6_
    -jvdK9ENTsWnsvTDHFqUvVb3NaVzkbqvsmuS4Z5IxF_xf6uHAYO7w>
X-ME-Received: <xmr:yPsCauStEZ6Jy3R62DmjwaSMd0FDCn-5iaYAUnuxr5O4YTFlW4Fyj1FBp64MJ0Hm0L7JWZxpG4Rq4i_HKTBpawI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehn
    tdehvggtsehliihurdgvughurdgtnhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgt
    phhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:yPsCapVBpen4u053VdJxyjxen5N7Tt5S4vmBJFoBQW8fzn7Lbc0APQ>
    <xmx:yPsCalZS9rP2rZQZR7b7u8ClmHU4DsdOfiet1Y2q25A7iwus3SWgeQ>
    <xmx:yPsCaq6QqEj6yhlVDG27c06IhhDKBVcd3NaDeW0RRt-9WxKYmSQLwg>
    <xmx:yPsCauwJJhz6-goEcT5WdREg0Rsi_qYPOd0cTyOVqASLeBuvqTbVdg>
    <xmx:yvsCauZP0SSJrVhDC-xRzNQkxqtbXI9NU4KWpEPvWyWG0PkzBgqtO9FF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 06:07:04 -0400 (EDT)
Date: Tue, 12 May 2026 12:07:02 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, ronbogo@outlook.com, zylzyl2333@gmail.com
Subject: Re: [PATCH net 1/1] xfrm: espintcp: publish ULP context before entry
 points
Message-ID: <agL7xoDgf7z6nRXX@krikkit>
References: <cover.1778464688.git.zylzyl2333@gmail.com>
 <c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com>
X-Rspamd-Queue-Id: CCF1E51E522
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,gmail.com,lzu.edu.cn,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Action: no action

Thanks for the fix. A small note: IPsec fixes go through the "ipsec"
tree, not "net", so the prefix should be [PATCH ipsec]

Some comments inline:

2026-05-11, 21:40:58 +0800, Ren Wei wrote:
> diff --git a/include/net/espintcp.h b/include/net/espintcp.h
> index c70efd704b6d..034be559786b 100644
> --- a/include/net/espintcp.h
> +++ b/include/net/espintcp.h
> @@ -34,7 +34,16 @@ static inline struct espintcp_ctx *espintcp_getctx(const struct sock *sk)
>  {
>  	const struct inet_connection_sock *icsk = inet_csk(sk);
>  
> -	/* RCU is only needed for diag */
> -	return (__force void *)icsk->icsk_ulp_data;
> +	/*
> +	 * The caller reached an ESP entry point by observing sk_prot,
> +	 * sk_socket->ops, or one of the socket callbacks.  Keep the ctx
> +	 * load after that observation so the caller cannot see the new
> +	 * entry point while still seeing stale icsk_ulp_data.

I don't think this comment is really helpful.

> +	 *
> +	 * Pairs with smp_wmb() in espintcp_init_sk().
> +	 */
> +	smp_rmb();
> +
> +	return (__force void *)READ_ONCE(icsk->icsk_ulp_data);

I think smp_store_release/smp_load_acquire is the "standard spelling"
for this now.


[...]
> @@ -472,34 +476,46 @@ static int espintcp_init_sk(struct sock *sk)
>  
>  	__sk_dst_reset(sk);
>  
> -	strp_check_rcv(&ctx->strp);
>  	skb_queue_head_init(&ctx->ike_queue);
>  	skb_queue_head_init(&ctx->out_queue);
> +	ctx->saved_data_ready = READ_ONCE(sk->sk_data_ready);
> +	ctx->saved_write_space = READ_ONCE(sk->sk_write_space);
> +	ctx->saved_destruct = READ_ONCE(sk->sk_destruct);

If something is changing those while espintcp_init_sk is running,
READ_ONCE won't help us. We'll end up with the wrong saved_*
values. Can this actually happen here?


> +	INIT_WORK(&ctx->work, espintcp_tx_work);
> +
> +	/* avoid using task_frag */
> +	sk->sk_allocation = GFP_ATOMIC;
> +	sk->sk_use_task_frag = false;
>  
>  	if (sk->sk_family == AF_INET) {
> -		sk->sk_prot = &espintcp_prot;
> -		sk->sk_socket->ops = &espintcp_ops;
> +		prot = &espintcp_prot;
> +		ops = &espintcp_ops;
>  	} else {
>  		mutex_lock(&tcpv6_prot_mutex);
>  		if (!espintcp6_prot.recvmsg)
> -			build_protos(&espintcp6_prot, &espintcp6_ops, sk->sk_prot, sk->sk_socket->ops);
> +			build_protos(&espintcp6_prot, &espintcp6_ops,
> +				     READ_ONCE(sk->sk_prot),
> +				     READ_ONCE(sk->sk_socket->ops));

And similar here. Those should always be tcpv6_prot/inet6_stream_ops,
but I wrote it this way to avoid having to use stubs, back when IPv6
could be built as a module. This could now be moved into espintcp_init
like the ipv4 variant of this.

>  		mutex_unlock(&tcpv6_prot_mutex);
>  
> -		sk->sk_prot = &espintcp6_prot;
> -		sk->sk_socket->ops = &espintcp6_ops;
> +		prot = &espintcp6_prot;
> +		ops = &espintcp6_ops;
>  	}

Or just move the whole block to the end, instead of introducing those
temporary variables?

> -	ctx->saved_data_ready = sk->sk_data_ready;
> -	ctx->saved_write_space = sk->sk_write_space;
> -	ctx->saved_destruct = sk->sk_destruct;
> -	sk->sk_data_ready = espintcp_data_ready;
> -	sk->sk_write_space = espintcp_write_space;
> -	sk->sk_destruct = espintcp_destruct;
>  	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
> -	INIT_WORK(&ctx->work, espintcp_tx_work);
>  
> -	/* avoid using task_frag */
> -	sk->sk_allocation = GFP_ATOMIC;
> -	sk->sk_use_task_frag = false;
> +	/*
> +	 * Publish the fully initialized ctx before publishing any entry point
> +	 * that can call espintcp_getctx().  The read barrier there runs after
> +	 * the caller has observed one of these pointers.
> +	 */
> +	smp_wmb();
> +	WRITE_ONCE(sk->sk_prot, prot);
> +	WRITE_ONCE(sk->sk_socket->ops, ops);
> +	WRITE_ONCE(sk->sk_data_ready, espintcp_data_ready);
> +	WRITE_ONCE(sk->sk_write_space, espintcp_write_space);
> +	WRITE_ONCE(sk->sk_destruct, espintcp_destruct);
> +
> +	strp_check_rcv(&ctx->strp);
>  
>  	return 0;
>  
> @@ -530,7 +546,7 @@ static void espintcp_close(struct sock *sk, long timeout)
>  
>  	strp_stop(&ctx->strp);
>  
> -	sk->sk_prot = &tcp_prot;
> +	WRITE_ONCE(sk->sk_prot, &tcp_prot);

Actually this should be the original sk_prot, which could be
tcpv6_prot.

I'm not sure how much the WRITE_ONCE matters here. What is it
protecting against/synchronizing with?

-- 
Sabrina

