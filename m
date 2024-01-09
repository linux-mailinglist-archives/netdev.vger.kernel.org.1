Return-Path: <netdev+bounces-62581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29114827F6D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 08:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A021F26EC1
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F99BA38;
	Tue,  9 Jan 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH8SpXPL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF604BA22
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704785093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TN+FctB9950vxlisZTXdEBlFNjFQp6e/aOwgr8ebnTg=;
	b=KH8SpXPLYvFez94Wv24DZvVVQTS6GXuM7UVjZ/rThmyGBvr8lKkkmxWu/9wGYCQ/fhzHUH
	ZnSxOK4zcUc/VurMQtfwmUwtA/sprivyvWjW2DjQSBdQ3cAUUA55lVdrp5u22M3favsr96
	nOeIFypc/Za3nqIaFrPnlYO6WTpFaxM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-t8NP1iZyMe29axnwGFhPrg-1; Tue, 09 Jan 2024 02:24:52 -0500
X-MC-Unique: t8NP1iZyMe29axnwGFhPrg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a29de6a12adso47821166b.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 23:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704785091; x=1705389891;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TN+FctB9950vxlisZTXdEBlFNjFQp6e/aOwgr8ebnTg=;
        b=sQiBt1AsLHuPCsZ7Rf5DFROq3jepRKB2S9/t4RxK/qzdk/OyJ54JrojHr3F9sdseAb
         fYYMEL8dYFvO94R5NhIV6oesuBTanF73xmb/dEdl2lmyDLPPeHtsBAq2MvBGLrX61mRd
         LNEZtogwyLOwGT1IoWc+OqvmwfVzXx00M6WXwEfxS9qJZN6OneoMOAp8o7BoeMQssXTR
         H8dcCDLBc+0yR+XOrt6JSMuAlB1UfcH4bw+uw/XtshJIl1zYVdthbgL3ww3oDuZpV5aG
         bTPbx+3/OzIM9h5eHwyCcP3Vtcu7h1f3MI2APCznFigjjPmbU1TuuDvCR+I946UvjV4T
         I1mA==
X-Gm-Message-State: AOJu0YzdHPsT7OkSRyhDBQYr22XFu7pwQI269AwlgM3gZ+sj9W5CIAfj
	N0dvw5eRwS/hthnMJjITYUvkQrH+cSa6F2wGmayPyjEL3cdQ4IFTdC/8RQtcbgdAIssrl6Q5CjO
	Eh7N9whDCO5+vMF5woWZ0LlSI
X-Received: by 2002:a17:906:4fc5:b0:a2b:1e1a:ac45 with SMTP id i5-20020a1709064fc500b00a2b1e1aac45mr1623510ejw.5.1704785091231;
        Mon, 08 Jan 2024 23:24:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKHiFiYEqxHVZ2osLxUnhMdsr1ruBnxARJlKSAqjxQpM1+3uXEnJ01V+xjO1WVbrKLRJlkYw==
X-Received: by 2002:a17:906:4fc5:b0:a2b:1e1a:ac45 with SMTP id i5-20020a1709064fc500b00a2b1e1aac45mr1623491ejw.5.1704785090804;
        Mon, 08 Jan 2024 23:24:50 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-40.dyn.eolo.it. [146.241.252.40])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b00a26b44ac54dsm711972ejb.68.2024.01.08.23.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:24:50 -0800 (PST)
Message-ID: <72f54aa95c3fad328b00b8196ca7f878c5d0a627.camel@redhat.com>
Subject: Re: [net-next] tcp: Avoid sending an erroneous RST due to RCU race
From: Paolo Abeni <pabeni@redhat.com>
To: Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc: edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Date: Tue, 09 Jan 2024 08:24:48 +0100
In-Reply-To: <20240108231349.9919-1-jmaxwell37@gmail.com>
References: <20240108231349.9919-1-jmaxwell37@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 10:13 +1100, Jon Maxwell wrote:
> There are 2 cases where a socket lookup races due to RCU and finds a=20
> LISTEN socket instead of an ESTABLISHED or a TIME-WAIT socket. As the ACK=
 flag=20
> is set this will generate an erroneous RST.=20
>=20
> There are 2 scenarios, one where 2 ACKs (one for the 3 way handshake and=
=20
> another with the same sequence number carrying data) are sent with a very=
=20
> small time interval between them. In this case the 2 ACKs can race while =
being
> processed on different CPUs and the latter may find the LISTEN socket ins=
tead=20
> of the ESTABLISHED socket. That will make the one end of the TCP connecti=
on=20
> out of sync with the other and cause a break in communications. The other=
=20
> scenario is a "FIN ACK" racing with an ACK which may also find the LISTEN=
=20
> socket instead of the TIME_WAIT socket. Instead of getting ignored that=
=20
> generates an invalid RST.=20
>=20
> Instead of the next connection attempt succeeding. The client then gets a=
n=20
> ECONNREFUSED error on the next connection attempt when it finds a socket =
in=20
> the FIN_WAIT_2 state as discussed here:=20
>=20
> https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.com=
/=20
>=20
> Modeled on Erics idea, introduce __inet_lookup_skb_locked() and
> __inet6_lookup_skb_locked()  to fix this by doing a locked lookup only fo=
r=20
> these rare cases to avoid finding the LISTEN socket.=C2=A0

I think Eric's idea was to keep the bucket lock held after such lookup,
to avoid possibly re-acquiring it for time-wait sockets.

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 93e9193df54461b25c61089bd5db4dd33c32dab6..ef9c0b5462bd0a85ebf350f53=
b4f3e6f6d394282 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -535,6 +535,55 @@ struct sock *__inet_lookup_established(struct net *n=
et,
>  }
>  EXPORT_SYMBOL_GPL(__inet_lookup_established);
> =20
> +struct sock *__inet_lookup_established_locked(struct net *net,
> +					      struct inet_hashinfo *hashinfo,
> +					      const __be32 saddr, const __be16 sport,
> +					      const __be32 daddr, const u16 hnum,
> +					      const int dif, const int sdif)
> +{
> +	INET_ADDR_COOKIE(acookie, saddr, daddr);
> +	const __portpair ports =3D INET_COMBINED_PORTS(sport, hnum);
> +	struct sock *sk;
> +	const struct hlist_nulls_node *node;
> +	/* Optimize here for direct hit, only listening connections can
> +	 * have wildcards anyways.
> +	 */
> +	unsigned int hash =3D inet_ehashfn(net, daddr, hnum, saddr, sport);
> +	unsigned int slot =3D hash & hashinfo->ehash_mask;
> +	struct inet_ehash_bucket *head =3D &hashinfo->ehash[slot];
> +	spinlock_t *lock =3D inet_ehash_lockp(hashinfo, hash);
> +
> +	spin_lock(lock);
> +begin:
> +	sk_nulls_for_each(sk, node, &head->chain) {
> +		if (sk->sk_hash !=3D hash)
> +			continue;
> +		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> +			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +				goto out;
> +			if (unlikely(!inet_match(net, sk, acookie,
> +						 ports, dif, sdif))) {
> +				sock_gen_put(sk);
> +				goto begin;
> +			}
> +			goto found;
> +		}

Since the bucket is locked, I think refcount_inc() would suffice. The
double match and the additional looping should not be needed.


Cheers,

Paolo


