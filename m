Return-Path: <netdev+bounces-229987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BBCBE2CEA
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198ED1A61082
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7190C18C31;
	Thu, 16 Oct 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVldaCdb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBE328630
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610711; cv=none; b=D5BW3V9epswMD6anRzvtlwnuEWfWcsmLJc97iqnZGuiaKBTi4tcitPQ1Y2UrGd7vMFdoJB3xsrduqodB9iLpXhc04NANOVdlbeGDSf2deykGy8oD4jz28R+x7SxYWhYbQ44wcouyCOeHqcIA5dtbfcFyAZVYM52fMIim3jr9Na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610711; c=relaxed/simple;
	bh=ZUVR7J+l2wJURhDTTQeITPX5XiXujXGJz3sikQkFbAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2bijo49eMJLddK4MwAsH5M2ZTRgzZyPCfcFJudXAhCVoDhN61i6TwmShQP+IhR2PbPrs3942h1zoazvmmIiWdyyWJ5lEEMFUQi4aMbsiMBDTqcFwcWz79Q4PB4yJ3dZu1gPCy+EDZm3MDHM6wWtRg7gFLiPMdWZYvLs/UJn4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVldaCdb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88fa5974432so67573685a.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760610708; x=1761215508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktHDHBMW81uWJYY0AzXCnOJdrBE4EreNdqBNUquhhSo=;
        b=BVldaCdbP0fCNwEBRNoED2CDkt25Ds6Px0IR+vtKYeDpY4RwALVRPZVIdVfubH/Lkk
         Ya8PmpAPx5YiS2RakqEVc6vCWB9/H2yfe9w4nnykacf4fWlNAVxk+Ut1bK037KASojsP
         zJJUmqIRlYCD3h8sB1BJvRgewpgOE1bzC24I8WyZ5ukIroUZVv4AU/DvK/Uhyrf881rr
         sDO23L0t/0Jux7usdRrjzBmF0fF3DPIMmbVDBDjjLRTlU5sJT7GLCwjOY+hiovDEPy/f
         gF8JxWjOB3vcnD9zXQrvq82xBW1r3K1nlweBD9kYffWVQgK8bvA/YI6sNFi3tH4XlwMC
         dVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610708; x=1761215508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktHDHBMW81uWJYY0AzXCnOJdrBE4EreNdqBNUquhhSo=;
        b=cWPxK5gzo1H1Zc0+PGsFvh4B0Krs+rFwp5dSEZNtgQbbJjTMd78z8CgwpXqhWcjuhR
         Mr0RjizzTLMXUL2KsUv+wbCoYIClGnab7ZTs7cuCjLFalSWHusIZkl4y317p2Ao4Dzzw
         rMrawFBs9THb+asarPkJ6Uj/xNHZrnWulV1dhmvP+7GP1qeGN/f21HEf8XLYxFmB5x3n
         Qg5OOpRtTXfQm+gmBmkkQC+xZAkWNKSf2tmZuZmVCJKMpCNkm591OupuBjSdIY5EnHey
         8dPIlkp/hH2tZagor0Vpee084nhusy/sd+OwFXnVi421wru8+s4rqotg0ZjYjzKYHqbR
         BADw==
X-Forwarded-Encrypted: i=1; AJvYcCVbjOC0f8nDiLa1ajy9p4AjVIYzyaC6+W76JIASCv+9pfxAZBlVy6aZ3xD6gzQ0ZamRt2/FGGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZoRR0DuswRJ/mD4G3OS73ECH3F4VdVv+akW1x51dspqRv93o
	h//WNWiA7j6Y+zc9OQ72bA0GKuWNLA6OFWik6ZnS5pogJXoD4zT54XsSzGo1e9gElQDqu/hqs1d
	FAs4acCMkyhHCsQAZfcVPO8SzeHL6irmV8vUQw/X/U9EO3lvU4oXM2/bFuF4=
X-Gm-Gg: ASbGncu7T5Nz8Xx7vl+TIxjX8/khPmNGB+pkYJ0+idbhkqOlauskv7YKGB98zFoh8FW
	Q02HIBC+fquCWEfIs21zhZGafiacAHq5Orx4CqZs9uWHMROe5Hc97bcAl2t3bfKEb5DpjAmNWSH
	OKPny3P4/LJiT//PY4p1WFnQ7ZGqwvPWbNoy4zlRDZ3E6pUbFRTZ0Cz2M/lIQee46KYssYXKvin
	A0dna369DVoZqyv8h94tw1qNaIlGtfJlGegQABEHyuCPYbgMSYARE916t+OxhXWXDQ74D1wdf9A
	Y9AZZfGKNP/BKQ==
X-Google-Smtp-Source: AGHT+IH9YSGJpZvEkkqzSlvcLs11WDROu3qpCjt8rDsEt/NZXfNm5fP2uha3xWcHGwNWRrvahKZz9kuGP3eYbUEEvBo=
X-Received: by 2002:a05:622a:1a9d:b0:4e3:25d7:57d4 with SMTP id
 d75a77b69052e-4e6ead754ebmr361873081cf.80.1760610708115; Thu, 16 Oct 2025
 03:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015233801.2977044-1-edumazet@google.com> <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
In-Reply-To: <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 03:31:37 -0700
X-Gm-Features: AS18NWAJGBA57L9qpvg4nwsEgxZnHzl2_c3kSgJli4hcYr8sjcYs_vVdOQcjwTE
Message-ID: <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:20=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 15 Oct 2025 23:38:01 +0000
>
> > Following loop in napi_skb_cache_put() is unrolled by the compiler
> > even if CONFIG_KASAN is not enabled:
> >
> > for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> >       kasan_mempool_unpoison_object(nc->skb_cache[i],
> >                               kmem_cache_size(net_hotdata.skbuff_cache)=
);
> >
> > We have 32 times this sequence, for a total of 384 bytes.
> >
> >       48 8b 3d 00 00 00 00    net_hotdata.skbuff_cache,%rdi
> >       e8 00 00 00 00          call   kmem_cache_size
> >
> > This is because kmem_cache_size() is an extern function,
> > and kasan_unpoison_object_data() is an inline function.
> >
> > Cache kmem_cache_size() result in a temporary variable, and
> > make the loop conditional to CONFIG_KASAN.
> >
> > After this patch, napi_skb_cache_put() is inlined in its callers.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> > ---
> >  net/core/skbuff.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..5a8b48b201843f94b5fdaab=
3241801f642fbd1f0 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1426,10 +1426,13 @@ static void napi_skb_cache_put(struct sk_buff *=
skb)
> >       nc->skb_cache[nc->skb_count++] =3D skb;
> >
> >       if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
> > -             for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; =
i++)
> > -                     kasan_mempool_unpoison_object(nc->skb_cache[i],
> > -                                             kmem_cache_size(net_hotda=
ta.skbuff_cache));
> > +             if (IS_ENABLED(CONFIG_KASAN)) {
> > +                     u32 size =3D kmem_cache_size(net_hotdata.skbuff_c=
ache);
> >
> > +                     for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACH=
E_SIZE; i++)
> > +                             kasan_mempool_unpoison_object(nc->skb_cac=
he[i],
> > +                                                           size);
> > +             }
>
> Very interesting; back when implementing napi_skb_cache*() family and
> someone (most likely Jakub) asked me to add KASAN-related checks here,
> I was comparing the object code and stopped on the current variant, as
> without KASAN, the entire loop got optimized away (but only when
> kmem_cache_size() is *not* a temporary variable).
>
> Or does this patch addresses KASAN-enabled kernels? Either way, if this
> patch really optimizes things:

No, this is when CONFIG_KASAN is _not_ enabled.

(I have not checked when it is enabled, I do not care about the cost
of KASAN as long as it is not too expensive)

Compiler does not know anything about kmem_cache_size()
It could contain some memory cloberring, memory freeing, some kind of
destructive action.

So it has to call it 32 times.

And reload net_hotdata.skbuff_cache 32 times, because the value could
have been changed
by kmem_cache_size() (if kmem_cache_size() wanted to)

Not sure if kmem_cache_size() could be inlined.

Its use has been discouraged so I guess nobody cared.

>
> Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> >               kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_C=
ACHE_HALF,
> >                                    nc->skb_cache + NAPI_SKB_CACHE_HALF)=
;
> >               nc->skb_count =3D NAPI_SKB_CACHE_HALF;
>
> Thanks,
> Olek

