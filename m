Return-Path: <netdev+bounces-78644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2FC875FA5
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 09:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B120F1C20849
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427001D69E;
	Fri,  8 Mar 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MG+D7zb2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1E1CAB2
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887042; cv=none; b=E/GMNUlLCMS7l9IaA7fy7/8qxHs73ZK9OkrG2CF0RZl5JYeBFt0h1UGiCqdOtapj9w5TlzEubX+bDms5Zh092wg5hQGMgVYayQVFMsJZ40TPAnZJT0QLMzKRmFEfPtmJBKY2jyiodcpH0zEqRkPNI7cG/Ug4rBHFDYRYrqj4QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887042; c=relaxed/simple;
	bh=KTwjNGGzgiVVHGnB0UREQGQXxL0HQmJlaol9VV9Hrpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tN8CxUjZABhwBPY8lw/C7nG7+gYxNm1Cm6iBuMpQTsScyFpEkEfNdGTXsYGhLsHYthQsGL0oKsnKXgb/VXQz9JmsfsWoVD1W/MoLauJeHO7RnwPgjjs2NPbQZylxpDW7llTUdxhbeloRXojTHZ3/nLIU3n5baib/vPlGa2R+DY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MG+D7zb2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709887039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7yo1bqFg+iRahSty9JwYoQ5pLBP9w3tsLSmZ+O8dKRY=;
	b=MG+D7zb20PpGU498yKWXrUeiEUslw5J7/aITzCunemFg1pvL81MlcKOC81lXTmlghlDKBA
	KMrFEwuEFPxdm0nFVL+Gf28c4JYRZq4bhIEnhciF5998HfQ6HkAi0liNVM/eVFmCIobKXw
	v5kWxMebHkwNAF0g7HoM92mFvPMyBtk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-HoAiqx75NQKirpkk8OKNEA-1; Fri, 08 Mar 2024 03:37:17 -0500
X-MC-Unique: HoAiqx75NQKirpkk8OKNEA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41306d66ed8so3785045e9.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 00:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709887036; x=1710491836;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yo1bqFg+iRahSty9JwYoQ5pLBP9w3tsLSmZ+O8dKRY=;
        b=uKIhiBy3CzIc+B+OBmEGsHN9JJnHZjQmW4LVn4u3oDMA52//ADtH4Pu1104Jtwvho+
         pAP3NZlpvOO8Ool+cTscO7PN9ikL5pHEORqD31g0IwT0HjNP9Tag7amIx5faLbaIQw25
         EZNfilIxP5NNaF8aNz6+slc3KVI03WcmLPqUks9ux/dWJnqbGET/9c2C7TTEVerOp5aF
         B+46wnUCVr/arJqpXGq23/okTzkLhf3B3A9dZ/HtJyhRCpUybxj6Ez727V4YY/hEJvg4
         l/H/q0DKPyRX+DJw1rXejOe0fsuZPL6vgOc2c/59vOPB5+UBbskhjavAd24vDFhG6VM7
         kEXg==
X-Gm-Message-State: AOJu0YwXrXSPCLv/lrcQEyvBZ2hsOmLWQTbkAeHlQu1USI9Kn/4l9iWu
	phcIWInY4xTkSQACAOuZLY09JWi6MGfSYAYGrTyXNCHD9TzRo095B3paoqEgpENX4Lek3idGSs5
	gp/R/ZaxAWf/MWqCq1DFpzxaC0VGs45xeP2tLa4mLUks7ZAmefbFAew==
X-Received: by 2002:adf:ed83:0:b0:33e:1ee0:a686 with SMTP id c3-20020adfed83000000b0033e1ee0a686mr968169wro.4.1709887036589;
        Fri, 08 Mar 2024 00:37:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG06sQ1jITvQEqhLGBhqCoGB46tJG43eu0tCk1eci2DmkJWqk2eK/IgnFJtknkAtbUodHRopQ==
X-Received: by 2002:adf:ed83:0:b0:33e:1ee0:a686 with SMTP id c3-20020adfed83000000b0033e1ee0a686mr968151wro.4.1709887036230;
        Fri, 08 Mar 2024 00:37:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-226-193.dyn.eolo.it. [146.241.226.193])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e22341942sm19754972wrb.78.2024.03.08.00.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:37:15 -0800 (PST)
Message-ID: <d149f4511c39f39fa6dc8e7c7324962434ae82e9.camel@redhat.com>
Subject: Re: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early
 demux
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Martin KaFai Lau
	 <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>, Alexei Starovoitov
	 <ast@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima
	 <kuniyu@amazon.com>
Date: Fri, 08 Mar 2024 09:37:14 +0100
In-Reply-To: <20240307220016.3147666-1-edumazet@google.com>
References: <20240307220016.3147666-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-07 at 22:00 +0000, Eric Dumazet wrote:
> After commits ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
> and 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
> UDP early demux no longer need to grab a refcount on the UDP socket.
>=20
> This save two atomic operations per incoming packet for connected
> sockets.

This reminds me of a old series:

https://lore.kernel.org/netdev/cover.1506114055.git.pabeni@redhat.com/

and I'm wondering if we could reconsider such option.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Joe Stringer <joe@wand.net.nz>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/udp.c | 5 +++--
>  net/ipv6/udp.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..e43ad1d846bdc2ddf5767606b=
78bbd055f692aa8 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2570,11 +2570,12 @@ int udp_v4_early_demux(struct sk_buff *skb)
>  					     uh->source, iph->saddr, dif, sdif);
>  	}
> =20
> -	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
> +	if (!sk)
>  		return 0;
> =20
>  	skb->sk =3D sk;
> -	skb->destructor =3D sock_efree;
> +	DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
> +	skb->destructor =3D sock_pfree;

I *think* that the skb may escape the current rcu section if e.g. if
matches a nf dup target in the input tables.

Back then I tried to implement some debug infra to track such accesses:

https://lore.kernel.org/lkml/cover.1507294365.git.pabeni@redhat.com/

which was buggy (prone to false negative). I think it can be improved
to something more reliable, perhaps I should revamp it?

I'm also wondering if the DEBUG_NET_WARN_ON_ONCE is worthy?!? the sk is
an hashed UDP socket so is a full sock and has the bit SOCK_RCU_FREE
set.

Perhaps we could use a simple 'noop' destructor as in:

https://lore.kernel.org/netdev/b16163e3a4fa4d772edeabd8743acb4a07206bb9.150=
6114055.git.pabeni@redhat.com/


Thanks!

Paolo


