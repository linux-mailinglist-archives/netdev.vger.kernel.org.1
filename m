Return-Path: <netdev+bounces-91083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117018B14F2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1311F2330C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF915696B;
	Wed, 24 Apr 2024 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVwwdTyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79D155358
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992177; cv=none; b=A0FEdHeohiGU1nEBv8dAPCsZCvzmOmgwpsnWTYrG6N/sW3ehFqasMF6EXX1ZMoB+k0YLg8kYfAPkky50lPo+Dl8N01MQdws6i5SZXEvXL0+9xw8yGNTeJg7MMKVwNKRLSnf6q5f9/RjNR0ri7N0BhRfVIpXCls8jM15/qrPAMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992177; c=relaxed/simple;
	bh=+iCNo8wEqxNSi0VLwJqXEKFRxwz/31yI5LSC+VB9wq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQIVSeIA0L5ovGu6x9c48TXBhjyQvegTtsRRchnQMP1+hpmpCCd05QJ1DdxfSUAX9WqVTrRFY7eki/c4DvS52Czs9iQt1TQjtxVccU+xXr6PSAqmW2jFnvRwfDwV12oL9Qic/Tt2DFXTU0cnC5YpMPrprk7m3sh2Ap5M9QgTzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVwwdTyn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so5945a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713992173; x=1714596973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOfk4oxVPJz7HKQD3AtVT4U41hOJGVJ0XSVIEN5LqSY=;
        b=cVwwdTynUwt4EcT1IiYgKm/tDe0AYEkYIfJZeMX7rAL4duowdJ+IOi2OfiWJy6W3vf
         T/4npPiC2WiEv1Vf5XjDx56ah0sTb+aoWEQLEFa4FHJNTFSY93PqiUTLA/tI9lluY+71
         EYXJlNQM4U5DnU0oZVj1QRfsj1xREJ7BXvxw0EWuO0laAhBpxccAtnEUTiw1T48fYgD+
         6hfz1wG0V3uZB6nhNIs6cGAXoD4+shtQ5m5W28l/SnHZC5Cqna54Zg6Rj62BKL/ueC3F
         kxUgWXqsrBhOHXE9k6HLAaqqtId9+/aE6B4EWKNN+ptdfUZEp+I8bWGWwC5GjstLYA8+
         oD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992173; x=1714596973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOfk4oxVPJz7HKQD3AtVT4U41hOJGVJ0XSVIEN5LqSY=;
        b=DZFR0ylH8FFb3zVUGYnqSHrkW6e4NBC58pgK45W687j90lpsuaWttChZTJOFNLDdBq
         dFkutHLBOYp2GsqL5+xUInhXe3ngfP647JTf/HtQ9YNmtr4CoFjhar9l8bNmgLX4r6BJ
         pCT7zxRQ8VsrGctCUWBYNJSM9jTUagSSqCaN0/LWf3UohxR7xWr7IdmpaAJSUHMpNVoW
         kRpiWWapavf19FHzsi31NgEifRkMrwcMHdvcYMhwh5AiJ8HaSFLU6B+ht4M//sAcoKGR
         8J4H88IFbTL/yOTF+pS04QRpvE60zCizogJI5mqW8vo6AIE+vDksuAP5EKPHbmfU3Aas
         La3A==
X-Forwarded-Encrypted: i=1; AJvYcCXiUeI+HoDYGlRYvkC4867TviYYktbl/yOUAwLq78rsIR71N8f5ZpnqDFLqVl7xmSTf3jIsK1mNd+vwzdDTPioubDb9oIUN
X-Gm-Message-State: AOJu0Yw9EpKl3RVGo7oGqfhpv6AsZv4r7Ql4lMuRI692euj2+4ozS6Xa
	IhcMIB0I6TKMUTLDecNmhMHySnzApsMge5jxZe7rQlRvUTbe19UuCMpGUmJjO2D22DqQ6DyxgPn
	SS6EAwigMr8Wqp4ufcQ33pzhBVVPsg0jkw5jj
X-Google-Smtp-Source: AGHT+IHWta722qXS4pvD0xBD/vHuEQUrOoIg5eUS30Y/1JsN9iIwyLrcWTRPXH/gSt9eh2nsnFYdAHZJPpZCkpC02u4=
X-Received: by 2002:aa7:cb54:0:b0:570:49e3:60a8 with SMTP id
 w20-20020aa7cb54000000b0057049e360a8mr3667edt.7.1713992173330; Wed, 24 Apr
 2024 13:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419222328.3231075-1-dwilder@us.ibm.com> <e67ea4ee50b7a5e4774d3e91a1bfb4d14bfa308e.camel@redhat.com>
 <ZilwPJ3QZC-7ideG@hog>
In-Reply-To: <ZilwPJ3QZC-7ideG@hog>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Apr 2024 22:56:02 +0200
Message-ID: <CANn89iKWA=LjMUtLOXUfzRMirYfBa+uAfNsfs_Mpq9z0ngGgmA@mail.gmail.com>
Subject: Re: [RFC PATCH] net: skb: Increasing allocation in __napi_alloc_skb()
 to 2k when needed.
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, David J Wilder <dwilder@us.ibm.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:49=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>
> 2024-04-23, 09:56:33 +0200, Paolo Abeni wrote:
> > On Fri, 2024-04-19 at 15:23 -0700, David J Wilder wrote:
> > > When testing CONFIG_MAX_SKB_FRAGS=3D45 on ppc64le and x86_64 I ran in=
to a
> > > couple of issues.
> > >
> > > __napi_alloc_skb() assumes its smallest fragment allocations will fit=
 in
> > > 1K. When CONFIG_MAX_SKB_FRAGS is increased this may no longer be true
> > > resulting in __napi_alloc_skb() reverting to using page_frag_alloc().
> > > This results in the return of the bug fixed in:
> > > Commit 3226b158e67c ("net: avoid 32 x truesize under-estimation for
> > > tiny skbs")
> > >
> > > That commit insured that "small skb head fragments are kmalloc backed=
,
> > > so that other objects in the slab page can be reused instead of being=
 held
> > > as long as skbs are sitting in socket queues."
> > >
> > > On ppc64le the warning from napi_get_frags_check() is displayed when
> > > CONFIG_MAX_SKB_FRAGS is set to 45. The purpose of the warning is to d=
etect
> > > when an increase of MAX_SKB_FRAGS has reintroduced the aforementioned=
 bug.
> > > Unfortunately on x86_64 this warning is not seen, even though it shou=
ld be.
> > > I found the warning was disabled by:
> > > commit dbae2b062824 ("net: skb: introduce and use a single page frag
> > > cache")
> > >
> > > This RFC patch to __napi_alloc_skb() determines if an skbuff allocati=
on
> > > with a head fragment of size GRO_MAX_HEAD will fit in a 1k allocation=
,
> > > increasing the allocation to 2k if needed.
> > >
> > > I have functionally tested this patch, performance testing is still n=
eeded.
> > >
> > > TBD: Remove the limitation on 4k page size from the single page frag =
cache
> > > allowing ppc64le (64K page size) to benefit from this change.
> > >
> > > TBD: I have not address the warning in napi_get_frags_check() on x86_=
64.
> > > Will the warning still be needed once the other changes are completed=
?
> >
> >
> > Thanks for the detailed analysis.
> >
> > As mentioned by Eric in commit
> > bf9f1baa279f0758dc2297080360c5a616843927, it should be now possible to
> > revert dbae2b062824 without incurring in performance regressions for
> > the relevant use-case. I had that on my todo list since a lot of time,
> > but I was unable to allocate time for that.
> >
> > I think such revert would be preferable. Would you be able to evaluate
> > such option?
>
> I don't think reverting dbae2b062824 would fix David's issue.
>
> The problem is that with MAX_SKB_FRAGS=3D45, skb_shared_info becomes
> huge, so 1024 is not enough for those small packets, and we use a
> pagefrag instead of kmalloc, which makes napi_get_frags_check unhappy.
>

768 bytes is not huge ...

> Even after reverting dbae2b062824, we would still go through the
> pagefrag path and not __alloc_skb.
>
> What about something like this?  (boot-tested on x86 only, but I
> disabled NAPI_HAS_SMALL_PAGE_FRAG. no perf testing at all.)
>
> -------- 8< --------
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f85e6989c36c..88923b7b64fe 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -108,6 +108,8 @@ static struct kmem_cache *skbuff_ext_cache __ro_after=
_init;
>  #define SKB_SMALL_HEAD_HEADROOM                                         =
       \
>         SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
>
> +#define SKB_SMALL_HEAD_THRESHOLD (SKB_SMALL_HEAD_HEADROOM + NET_SKB_PAD =
+ NET_IP_ALIGN)
> +
>  int sysctl_max_skb_frags __read_mostly =3D MAX_SKB_FRAGS;
>  EXPORT_SYMBOL(sysctl_max_skb_frags);
>
> @@ -726,7 +728,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device =
*dev, unsigned int len,
>         /* If requested length is either too small or too big,
>          * we use kmalloc() for skb->head allocation.
>          */
> -       if (len <=3D SKB_WITH_OVERHEAD(1024) ||
> +       if (len <=3D SKB_SMALL_HEAD_THRESHOLD ||
>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
>                 skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_=
NODE);
> @@ -802,7 +804,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *na=
pi, unsigned int len)
>          * When the small frag allocator is available, prefer it over kma=
lloc
>          * for small fragments
>          */
> -       if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1024=
)) ||
> +       if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_SMALL_HEAD_THRESHO=
LD) ||
>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
>                 skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALL=
OC_NAPI,
> -------- 8< --------
>
> (__)napi_alloc_skb extends the GRO_MAX_HEAD size by NET_SKB_PAD +
> NET_IP_ALIGN, so I added them here as well. Mainly this is reusing a
> size that we know if big enough to fit a small header and whatever
> size skb_shared_info is on the current build. Maybe this could be
> max(SKB_WITH_OVERHEAD(1024), <...>) to preserve the current behavior
> on MAX_SKB_FRAGS=3D17, since in that case
> SKB_WITH_OVERHEAD(1024) > SKB_SMALL_HEAD_HEADROOM
>
>

Here we simply use

#define GRO_MAX_HEAD 192

