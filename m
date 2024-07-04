Return-Path: <netdev+bounces-109157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6909272AA
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4146F1F22CC7
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8CF194C9B;
	Thu,  4 Jul 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4dtROtU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F1748F
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084103; cv=none; b=sX2MwXfK1kuqD7M85Gvp9gF5f34thBWCCUHkOs37NoH9b7j/tlhBN/kY4GXPphGS8k6RibG8E2TCfo0hdbTsnq8D7HinE0VCkdrJ8ge/84wvsLPIPxlwCLhmaGx6bahiiWYu9BXEshtai4qKc5tCkKLwLw9XfNTpYNsPPIhCezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084103; c=relaxed/simple;
	bh=BWEMm4TLSIqjs5u90YR8w2kxxIlVC550VuZJ+aZT7AU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2db+7gWdQUBx5oxes95nBr0FAOghJhQXQTkWasJVo0bO68CIV4VPaG0Y0JdfVYga93XM7taIswNPJxJDPBYkQl0GxF2OMOYcahVI1GPW7+fpX+ESBnR9K7d9/9EGI2AjbzBeBgxmEiPXpnmXQNKrfDe6vI1VrU5duDm2YY9DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4dtROtU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720084100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DKCO9hi0iOHcupl51SjKtPFnD2GhgF5lbrdnfaISLMg=;
	b=J4dtROtUUhPNLxeHBGAdsNTTH3IKwOtVR8pOr/YF0RPYwFLqPLqnJ13Poufna220H1jJRu
	F2WNN2RvVeS6Iz2otpxMqJ9czEWHGPgSbfgj6BYcCh+mTCSyyObASqmAQSfNUX+o6uuHTl
	PRim1g8dPN90qa4o5KXc/bRjClViN2c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ulXehzsEM0Wp3NXHyGs4aA-1; Thu, 04 Jul 2024 05:08:19 -0400
X-MC-Unique: ulXehzsEM0Wp3NXHyGs4aA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36794e8929bso102025f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 02:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084098; x=1720688898;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKCO9hi0iOHcupl51SjKtPFnD2GhgF5lbrdnfaISLMg=;
        b=O8gVlOBlArO/oICAUc/gGGSIi7Xueb9hWq+KVVQu1ja6LZSHrOeiGaXNhxJYHvR/Uj
         qCzJiOiraxoC8OPJNrFu7CYPB6jFJQxrJQxwRim/+z1MYvgkvdPqWAgGPFbQXuqBRbFc
         7GsEfpck5IkwUNNN6pmQwOTfrQP21JDGnceLUuHufQGeY/mBVTKqKyqJJjxmHTs6Rlxy
         ri+20WU2NEW55ECZxP0KZzsbYgjY7DFMs2BIGFeuK2p0rtVG3x6ZJmqKk/lCC8LnEIoZ
         PYEwn1DZRkBRMFulEFW8gpH6dt2QIzP/cM+Wx/Y1mSUiX55okfuJvI2S2wIGX8bf4QJx
         XsSg==
X-Forwarded-Encrypted: i=1; AJvYcCU0377Bp8j2kEqG/a98RXeiUiJM1DBefFp/SZV1WGCMYKsNkDv1jE0HPgEU8sRNuYWnDxqlkw83RCl/Vtwhtr3HZssJnmP8
X-Gm-Message-State: AOJu0Yz0EwztYl1Fmgb8FqX1T5hkagLsMZ6nqdemcbxDvSwxAC15xc/w
	V+NWWgRHEUaw2jNwhA6IeDeGCAgqqq0kuBMk/FqDfXhy5Hhk9WbYnTEk/5e9CtorvsC672ROEBX
	wR1FMSQbHhHX/ddTcFsFcGMt0KMoBWGPiodR/Q+L4He1F+bPkPDRt0A==
X-Received: by 2002:a5d:6da8:0:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3679db7dbdamr780766f8f.0.1720084098242;
        Thu, 04 Jul 2024 02:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA/v0+krCgjtr2DkeouOKwOhto9pzLiK9iadAlEvA7+g6Hf2UtCDMvBvi1+mRl4tRmFdU5Vg==
X-Received: by 2002:a5d:6da8:0:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3679db7dbdamr780751f8f.0.1720084097811;
        Thu, 04 Jul 2024 02:08:17 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510:dd78:6ccd:a776:5943])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367958d8966sm3260236f8f.91.2024.07.04.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:08:17 -0700 (PDT)
Message-ID: <c026a24950813970edab1917c4f85b70db4900b2.camel@redhat.com>
Subject: Re: [PATCH net 1/2] net: ioam6: use "new" dst entry with
 skb_cow_head
From: Paolo Abeni <pabeni@redhat.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2024 11:08:15 +0200
In-Reply-To: <20240702174451.22735-2-justin.iurman@uliege.be>
References: <20240702174451.22735-1-justin.iurman@uliege.be>
	 <20240702174451.22735-2-justin.iurman@uliege.be>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 19:44 +0200, Justin Iurman wrote:
> In ioam6_output(), we call skb_cow_head() with LL_RESERVED_SPACE(). The
> latter uses "dst", which is potentially not the good one anymore. As a
> consequence, there might not be enough headroom, depending on the "new"
> dev (e.g., needed_headroom > 0). Therefore, we first need to get the
> "new" dst entry (from the cache or by calling ip6_route_output()), just
> like seg6 and rpl both do, and only then call skb_cow_head() with
> LL_RESERVED_SPACE() on the "new" dst entry.
>=20
> Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulatio=
n")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/ioam6_iptunnel.c | 65 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 33 deletions(-)
>=20
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index bf7120ecea1e..b08c13550144 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -295,7 +295,7 @@ static int ioam6_do_encap(struct net *net, struct sk_=
buff *skb,
> =20
>  static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff=
 *skb)
>  {
> -	struct dst_entry *dst =3D skb_dst(skb);
> +	struct dst_entry *dst, *orig_dst =3D skb_dst(skb);
>  	struct in6_addr orig_daddr;
>  	struct ioam6_lwt *ilwt;
>  	int err =3D -EINVAL;
> @@ -304,7 +304,7 @@ static int ioam6_output(struct net *net, struct sock =
*sk, struct sk_buff *skb)
>  	if (skb->protocol !=3D htons(ETH_P_IPV6))
>  		goto drop;
> =20
> -	ilwt =3D ioam6_lwt_state(dst->lwtstate);
> +	ilwt =3D ioam6_lwt_state(orig_dst->lwtstate);
> =20
>  	/* Check for insertion frequency (i.e., "k over n" insertions) */
>  	pkt_cnt =3D atomic_fetch_inc(&ilwt->pkt_cnt);
> @@ -346,45 +346,44 @@ static int ioam6_output(struct net *net, struct soc=
k *sk, struct sk_buff *skb)
>  		goto drop;
>  	}
> =20
> -	err =3D skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> -	if (unlikely(err))
> -		goto drop;
> +	local_bh_disable();
> +	dst =3D dst_cache_get(&ilwt->cache);
> +	local_bh_enable();

This makes the dst lookup and cache update unconditional, at best
slowing down ioam6_output(), possibly introducing unintended side
effects.

> +
> +	if (unlikely(!dst)) {
> +		struct ipv6hdr *hdr =3D ipv6_hdr(skb);
> +		struct flowi6 fl6;
> +
> +		memset(&fl6, 0, sizeof(fl6));
> +		fl6.daddr =3D hdr->daddr;
> +		fl6.saddr =3D hdr->saddr;
> +		fl6.flowlabel =3D ip6_flowinfo(hdr);
> +		fl6.flowi6_mark =3D skb->mark;
> +		fl6.flowi6_proto =3D hdr->nexthdr;
> +
> +		dst =3D ip6_route_output(net, NULL, &fl6);
> +		if (dst->error) {
> +			err =3D dst->error;
> +			dst_release(dst);
> +			goto drop;
> +		}
> =20
> -	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
>  		local_bh_disable();
> -		dst =3D dst_cache_get(&ilwt->cache);
> +		dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
>  		local_bh_enable();
> +	}
> =20
> -		if (unlikely(!dst)) {
> -			struct ipv6hdr *hdr =3D ipv6_hdr(skb);
> -			struct flowi6 fl6;
> -
> -			memset(&fl6, 0, sizeof(fl6));
> -			fl6.daddr =3D hdr->daddr;
> -			fl6.saddr =3D hdr->saddr;
> -			fl6.flowlabel =3D ip6_flowinfo(hdr);
> -			fl6.flowi6_mark =3D skb->mark;
> -			fl6.flowi6_proto =3D hdr->nexthdr;
> -
> -			dst =3D ip6_route_output(net, NULL, &fl6);
> -			if (dst->error) {
> -				err =3D dst->error;
> -				dst_release(dst);
> -				goto drop;
> -			}
> -
> -			local_bh_disable();
> -			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
> -			local_bh_enable();
> -		}
> +	skb_dst_drop(skb);
> +	skb_dst_set(skb, dst);
> =20
> -		skb_dst_drop(skb);
> -		skb_dst_set(skb, dst);
> +	err =3D skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> +	if (unlikely(err))
> +		goto drop;

This is quite a bit of code churn, but you just need to postpone the
cow operation after the dst lookup right?

I suggest to simply move the cow there, something alike (completely
untested):=20
---
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index bf7120ecea1e..636480bded0e 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -346,10 +346,6 @@ static int ioam6_output(struct net *net, struct sock *=
sk, struct sk_buff *skb)
 		goto drop;
 	}
=20
-	err =3D skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
 		local_bh_disable();
 		dst =3D dst_cache_get(&ilwt->cache);
@@ -381,9 +377,17 @@ static int ioam6_output(struct net *net, struct sock *=
sk, struct sk_buff *skb)
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
=20
+		err =3D skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
+
 		return dst_output(net, sk, skb);
 	}
 out:
+	err =3D skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+	if (unlikely(err))
+		goto drop;
+
 	return dst->lwtstate->orig_output(net, sk, skb);
 drop:
 	kfree_skb(skb);
---
Thanks,

Paolo


