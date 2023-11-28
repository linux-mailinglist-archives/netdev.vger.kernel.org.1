Return-Path: <netdev+bounces-51632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0FB7FB7F8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE62C1C21230
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58812B7F;
	Tue, 28 Nov 2023 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btzT3ZKs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E230219AB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701167702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUINC5In7VLgCGEEsir3sJSmOoPhchWXEwxWfS2e2Ok=;
	b=btzT3ZKsbtJnv7lT7D7Gd3V2EksSth0c3zMee0alI/M54Ke8jl8+QEQJkpr56UsCSeqRSi
	hPj4WNYYf6ojeZbhE8/+7dAzmkm3BoS//ou7r9YVp9j6F2Soo9fdgkqxfdoQVtwbb9Mh47
	IL3NjAOLPtyDKaJRBOVcALtONnlHHpg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-jK24jRBGMoqTwMJtM14eyA-1; Tue, 28 Nov 2023 05:34:59 -0500
X-MC-Unique: jK24jRBGMoqTwMJtM14eyA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a114c906c08so26176866b.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701167698; x=1701772498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUINC5In7VLgCGEEsir3sJSmOoPhchWXEwxWfS2e2Ok=;
        b=lRUYapDCM/fwqtF0Rauu6FFKaOgfMsov+lUayzH+3YQfT0Q30AI3xqVr82xF9vRbL6
         BBwm8lkTy05axQABYXZUyymSh8C9q0MyvDkKBE4wDhhzLZ9BtJY5MPHN6UAlQeZmzfYG
         5MZ4qlGQEGNoJItgg8/4BJN/F23f8oH9acOzzzeHdlgEELZikZ7uLWtgo3vksyc4SmE8
         Muyx1hHBffKoVZww0qdv8tzeuGz/txoaCS8R4Uf+8HogOOIdEwVKfWTMGRcOtRDTNJj1
         6UtbFs1XptcajY3dXBBAwV3waT5xc5tFcxQl3OpdyQwfrXrMVe4DBt2WjOvNFBFfuVVW
         bN2A==
X-Gm-Message-State: AOJu0Yxv5RDBudJKgGp9d4BJI3gaWEgOir2qF9S3j6TJ1NHPkRhKvmv8
	feO+dFBAiJQtfDgIlJK85TeaP1iQFAEn3b03//0TrWH1ke0bEP0Tn8S9kKbJyb/L05hKpz+mAd6
	5ePOI+tTnexwgatD8
X-Received: by 2002:a17:906:eb01:b0:a00:1acf:6fe5 with SMTP id mb1-20020a170906eb0100b00a001acf6fe5mr9349578ejb.1.1701167698632;
        Tue, 28 Nov 2023 02:34:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAgfgNyqRl51J39YfJnedSEPIkT9/1+7MwQoxlCNcVccN2ZvcpQFOZcDFulUzQzD9cg51GcA==
X-Received: by 2002:a17:906:eb01:b0:a00:1acf:6fe5 with SMTP id mb1-20020a170906eb0100b00a001acf6fe5mr9349569ejb.1.1701167698241;
        Tue, 28 Nov 2023 02:34:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id jt13-20020a170906ca0d00b0099c53c4407dsm6619669ejb.78.2023.11.28.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:34:57 -0800 (PST)
Message-ID: <c656e270bec67c2d7c99c42249b8cc890bec22f9.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 8/8] tcp: Factorise cookie-dependent fields
 initialisation in cookie_v[46]_check()
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
  netdev@vger.kernel.org
Date: Tue, 28 Nov 2023 11:34:56 +0100
In-Reply-To: <20231125011638.72056-9-kuniyu@amazon.com>
References: <20231125011638.72056-1-kuniyu@amazon.com>
	 <20231125011638.72056-9-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2023-11-24 at 17:16 -0800, Kuniyuki Iwashima wrote:
> We will support arbitrary SYN Cookie with BPF, and then kfunc at
> TC will preallocate reqsk and initialise some fields that should
> not be overwritten later by cookie_v[46]_check().
>=20
> To simplify the flow in cookie_v[46]_check(), we move such fields'
> initialisation to cookie_tcp_reqsk_alloc() and factorise non-BPF
> SYN Cookie handling into cookie_tcp_check(), where we validate the
> cookie and allocate reqsk, as done by kfunc later.
>=20
> Note that we set ireq->ecn_ok in two steps, the latter of which will
> be shared by the BPF case.  As cookie_ecn_ok() is one-liner, now
> it's inlined.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/tcp.h     |  13 ++++--
>  net/ipv4/syncookies.c | 106 +++++++++++++++++++++++-------------------
>  net/ipv6/syncookies.c |  61 ++++++++++++------------
>  3 files changed, 99 insertions(+), 81 deletions(-)
>=20
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d4d0e9763175..973555cb1d3f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -494,7 +494,10 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, st=
ruct sk_buff *skb,
>  int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
>  struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
>  struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_op=
s *ops,
> -					    struct sock *sk, struct sk_buff *skb);
> +					    struct sock *sk, struct sk_buff *skb,
> +					    struct tcp_options_received *tcp_opt,
> +					    int mss, u32 tsoff);
> +
>  #ifdef CONFIG_SYN_COOKIES
> =20
>  /* Syncookies use a monotonic timer which increments every 60 seconds.
> @@ -580,8 +583,12 @@ __u32 cookie_v4_init_sequence(const struct sk_buff *=
skb, __u16 *mss);
>  u64 cookie_init_timestamp(struct request_sock *req, u64 now);
>  bool cookie_timestamp_decode(const struct net *net,
>  			     struct tcp_options_received *opt);
> -bool cookie_ecn_ok(const struct tcp_options_received *opt,
> -		   const struct net *net, const struct dst_entry *dst);
> +
> +static inline bool cookie_ecn_ok(const struct net *net, const struct dst=
_entry *dst)
> +{
> +	return READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
> +		dst_feature(dst, RTAX_FEATURE_ECN);
> +}
> =20
>  /* From net/ipv6/syncookies.c */
>  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th=
);
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index f4bcd4822fe0..5be12f186c26 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -270,21 +270,6 @@ bool cookie_timestamp_decode(const struct net *net,
>  }
>  EXPORT_SYMBOL(cookie_timestamp_decode);
> =20
> -bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
> -		   const struct net *net, const struct dst_entry *dst)
> -{
> -	bool ecn_ok =3D tcp_opt->rcv_tsecr & TS_OPT_ECN;
> -
> -	if (!ecn_ok)
> -		return false;
> -
> -	if (READ_ONCE(net->ipv4.sysctl_tcp_ecn))
> -		return true;
> -
> -	return dst_feature(dst, RTAX_FEATURE_ECN);
> -}
> -EXPORT_SYMBOL(cookie_ecn_ok);
> -
>  static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
>  				 struct request_sock *req)
>  {
> @@ -320,8 +305,12 @@ static int cookie_tcp_reqsk_init(struct sock *sk, st=
ruct sk_buff *skb,
>  }
> =20
>  struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_op=
s *ops,
> -					    struct sock *sk, struct sk_buff *skb)
> +					    struct sock *sk, struct sk_buff *skb,
> +					    struct tcp_options_received *tcp_opt,
> +					    int mss, u32 tsoff)
>  {
> +	struct inet_request_sock *ireq;
> +	struct tcp_request_sock *treq;
>  	struct request_sock *req;
> =20
>  	if (sk_is_mptcp(sk))
> @@ -337,40 +326,36 @@ struct request_sock *cookie_tcp_reqsk_alloc(const s=
truct request_sock_ops *ops,
>  		return NULL;
>  	}
> =20
> +	ireq =3D inet_rsk(req);
> +	treq =3D tcp_rsk(req);
> +
> +	req->mss =3D mss;
> +	req->ts_recent =3D tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
> +
> +	ireq->snd_wscale =3D tcp_opt->snd_wscale;
> +	ireq->tstamp_ok =3D tcp_opt->saw_tstamp;
> +	ireq->sack_ok =3D tcp_opt->sack_ok;
> +	ireq->wscale_ok =3D tcp_opt->wscale_ok;
> +	ireq->ecn_ok =3D tcp_opt->rcv_tsecr & TS_OPT_ECN;
> +
> +	treq->ts_off =3D tsoff;
> +
>  	return req;
>  }
>  EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
> =20
> -/* On input, sk is a listener.
> - * Output is listener if incoming packet would not create a child
> - *           NULL if memory could not be allocated.
> - */
> -struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> +static struct request_sock *cookie_tcp_check(struct net *net, struct soc=
k *sk,
> +					     struct sk_buff *skb)
>  {
> -	struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
> -	const struct tcphdr *th =3D tcp_hdr(skb);
>  	struct tcp_options_received tcp_opt;
> -	struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct inet_request_sock *ireq;
> -	struct net *net =3D sock_net(sk);
> -	struct tcp_request_sock *treq;
> -	struct request_sock *req;
> -	struct sock *ret =3D sk;
> -	int full_space, mss;
> -	struct flowi4 fl4;
> -	struct rtable *rt;
> -	__u8 rcv_wscale;
>  	u32 tsoff =3D 0;
> -
> -	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> -	    !th->ack || th->rst)
> -		goto out;
> +	int mss;
> =20
>  	if (tcp_synq_no_recent_overflow(sk))
>  		goto out;
> =20
> -	mss =3D __cookie_v4_check(ip_hdr(skb), th);
> -	if (mss =3D=3D 0) {
> +	mss =3D __cookie_v4_check(ip_hdr(skb), tcp_hdr(skb));
> +	if (!mss) {
>  		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
>  		goto out;
>  	}
> @@ -391,21 +376,44 @@ struct sock *cookie_v4_check(struct sock *sk, struc=
t sk_buff *skb)
>  	if (!cookie_timestamp_decode(net, &tcp_opt))
>  		goto out;
> =20
> -	req =3D cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb);
> +	return cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb,
> +				      &tcp_opt, mss, tsoff);
> +out:
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +/* On input, sk is a listener.
> + * Output is listener if incoming packet would not create a child
> + *           NULL if memory could not be allocated.
> + */
> +struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct inet_request_sock *ireq;
> +	struct net *net =3D sock_net(sk);
> +	struct request_sock *req;
> +	struct sock *ret =3D sk;
> +	struct flowi4 fl4;
> +	struct rtable *rt;
> +	__u8 rcv_wscale;
> +	int full_space;
> +
> +	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> +	    !th->ack || th->rst)
> +		goto out;
> +
> +	req =3D cookie_tcp_check(net, sk, skb);
> +	if (IS_ERR(req))
> +		goto out;
>  	if (!req)
>  		goto out_drop;
> =20
>  	ireq =3D inet_rsk(req);
> -	treq =3D tcp_rsk(req);
> -	treq->ts_off		=3D tsoff;
> -	req->mss		=3D mss;
> +
>  	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
>  	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
> -	ireq->snd_wscale	=3D tcp_opt.snd_wscale;
> -	ireq->sack_ok		=3D tcp_opt.sack_ok;
> -	ireq->wscale_ok		=3D tcp_opt.wscale_ok;
> -	ireq->tstamp_ok		=3D tcp_opt.saw_tstamp;
> -	req->ts_recent		=3D tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
> =20
>  	/* We throwed the options of the initial SYN away, so we hope
>  	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
> @@ -447,7 +455,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>  				  dst_metric(&rt->dst, RTAX_INITRWND));
> =20
>  	ireq->rcv_wscale  =3D rcv_wscale;
> -	ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, net, &rt->dst);
> +	ireq->ecn_ok &=3D cookie_ecn_ok(net, &rt->dst);
> =20
>  	ret =3D tcp_get_cookie_sock(sk, skb, req, &rt->dst);
>  	/* ip_queue_xmit() depends on our flow being setup
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index e0a9220d1536..c8d2ca27220c 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -127,31 +127,18 @@ int __cookie_v6_check(const struct ipv6hdr *iph, co=
nst struct tcphdr *th)
>  }
>  EXPORT_SYMBOL_GPL(__cookie_v6_check);
> =20
> -struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
> +static struct request_sock *cookie_tcp_check(struct net *net, struct soc=
k *sk,
> +					     struct sk_buff *skb)
>  {
> -	const struct tcphdr *th =3D tcp_hdr(skb);
> -	struct ipv6_pinfo *np =3D inet6_sk(sk);
>  	struct tcp_options_received tcp_opt;
> -	struct tcp_sock *tp =3D tcp_sk(sk);
> -	struct inet_request_sock *ireq;
> -	struct net *net =3D sock_net(sk);
> -	struct tcp_request_sock *treq;
> -	struct request_sock *req;
> -	struct dst_entry *dst;
> -	struct sock *ret =3D sk;
> -	int full_space, mss;
> -	__u8 rcv_wscale;
>  	u32 tsoff =3D 0;
> -
> -	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> -	    !th->ack || th->rst)
> -		goto out;
> +	int mss;
> =20
>  	if (tcp_synq_no_recent_overflow(sk))
>  		goto out;
> =20
> -	mss =3D __cookie_v6_check(ipv6_hdr(skb), th);
> -	if (mss =3D=3D 0) {
> +	mss =3D __cookie_v6_check(ipv6_hdr(skb), tcp_hdr(skb));
> +	if (!mss) {
>  		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
>  		goto out;
>  	}
> @@ -172,14 +159,37 @@ struct sock *cookie_v6_check(struct sock *sk, struc=
t sk_buff *skb)
>  	if (!cookie_timestamp_decode(net, &tcp_opt))
>  		goto out;
> =20
> -	req =3D cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb);
> +	return cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb,
> +				      &tcp_opt, mss, tsoff);
> +out:
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
> +{
> +	const struct tcphdr *th =3D tcp_hdr(skb);
> +	struct ipv6_pinfo *np =3D inet6_sk(sk);
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> +	struct inet_request_sock *ireq;
> +	struct net *net =3D sock_net(sk);
> +	struct request_sock *req;
> +	struct dst_entry *dst;
> +	struct sock *ret =3D sk;
> +	__u8 rcv_wscale;
> +	int full_space;
> +
> +	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
> +	    !th->ack || th->rst)
> +		goto out;
> +
> +	req =3D cookie_tcp_check(net, sk, skb);
> +	if (IS_ERR(req))
> +		goto out;
>  	if (!req)
>  		goto out_drop;
> =20
>  	ireq =3D inet_rsk(req);
> -	treq =3D tcp_rsk(req);
> =20
> -	req->mss =3D mss;
>  	ireq->ir_v6_rmt_addr =3D ipv6_hdr(skb)->saddr;
>  	ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
> =20
> @@ -198,13 +208,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct=
 sk_buff *skb)
>  	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
>  		ireq->ir_iif =3D tcp_v6_iif(skb);
> =20
> -	ireq->snd_wscale	=3D tcp_opt.snd_wscale;
> -	ireq->sack_ok		=3D tcp_opt.sack_ok;
> -	ireq->wscale_ok		=3D tcp_opt.wscale_ok;
> -	ireq->tstamp_ok		=3D tcp_opt.saw_tstamp;
> -	req->ts_recent		=3D tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
> -	treq->ts_off =3D tsoff;
> -
>  	tcp_ao_syncookie(sk, skb, req, AF_INET6);
> =20
>  	/*
> @@ -245,7 +248,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>  				  dst_metric(dst, RTAX_INITRWND));
> =20
>  	ireq->rcv_wscale =3D rcv_wscale;
> -	ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, net, dst);
> +	ireq->ecn_ok &=3D cookie_ecn_ok(net, dst);

Nice cleanup! IMHO looks very good. But deserves Eric's explicit ack, I
think ;)

The only question I have (out of sheer curiosity, no change requested
here) is:

have you considered leaving the 'ecn_ok' initialization unchanged
(looks a little cleaner as a single step init)? Is that for later's
patch sake? (I haven't looked at them yet).

Cheers,

Paolo


