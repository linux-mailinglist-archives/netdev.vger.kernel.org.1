Return-Path: <netdev+bounces-91807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0E8B3FB0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F78A1C208C6
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDDD63AE;
	Fri, 26 Apr 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqHE2Osu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503BB642
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157467; cv=none; b=XjiDlTTejcex3UtNNGCSlokf8G5yTNEYVGKvSRil+BT+lpWV3YthQgPXctnwOPC7srrO250oP61Vq7y/wGnVAa1NIK1FRpnCVQMBY2JpacAqJIUwscxzF0GJ66iANKN1pu6EG13+c9WoeOFM5iMFXP7Mgee0Vjr0v30dy6ohHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157467; c=relaxed/simple;
	bh=hrIASCd7r+2VChJR71kpwzXMDqHt4MqRWSo/ELRHcOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxcluOQXsFg0U4HupXeMa+uLA7cnIMRQTjOFlBZSaHFwhsHJ+GcSu4BGY5D1ecGlmrUZSGDukZMVy6BFNsWOOKNE4MW/mre/pOZ3vjH0Nt8ZF+sc0/Q5EO9Z1D8/iEi6LKu840+4or5Y7IaEFKeqMunQExiposUY15KBMTxgc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqHE2Osu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so2045a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714157464; x=1714762264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/DrgVYw2DGtJQuPu+lb1a9exWjZHmEorPQyruqtH0M=;
        b=JqHE2OsuzrgJJ+/Es/UDSY7gL4qlJmz7BtKU2BiR3hhV9DkcLkQ/Bk0QlloW75n1Oo
         QvXp4wsKNFRQWGLCE9e/IWgN+gzf/MqBYCZYFDEhgGiUo90Pf623n5jID5aMPWCyvk31
         uEVvo/sftbo5MWd+0TGRzMoau+cCkEHbLy2D+9xJ92WBoeWWVPzaPY7BJYXMndwUD0W+
         vGIoZ1qLr22J2zH9lCcKQ/qPRy8tLLigiOdx6lFlF7YhvzNLbRffj2lVgCIgamklfwOC
         BiLm3+Bj0jK3+334iRhbVmTnv+xWwahTr0/DQmZuuyz9jVEEuFOiImyaUUPut7cubhXY
         vBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714157464; x=1714762264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/DrgVYw2DGtJQuPu+lb1a9exWjZHmEorPQyruqtH0M=;
        b=HaQf9QAHYAiWY247LTwgp0G0uWUhM3KPmEWdLMK9mZyBZHbVN8452e7JNSvWT/2peO
         d/BCY2FBxBwJzKhu9ea1vhz3yQLM115AsJnWViTBA9R5zbrG+HvjkRvyk/BKQptFiq26
         3wF8qI5AfBoNfpdUekBCA+JcRuv7BLHXTPd04knIFFl3MchxFcCJTPyeZu2Z+lnnCcz1
         ed03nzs5fzyzl3fq2SkuXetag1V1l4QW/aBkjbwNc/UztOtsCowtR/0DVKFLpEbaSEMR
         QmV2xO6SYDC/U7nK1ZpIQIBhVQc9ikDTaXx+Ey7ftSxx7EFFU/TZCiXLIrU7UORAVeX6
         5hsA==
X-Forwarded-Encrypted: i=1; AJvYcCVOnsU9zAFofCTL2IDF7OclmQf3AkmG2LPLPhlmYWoB6nl2pRUa7wFTCn9yr1GiVd39I8zN/kvRUIOokRaIiJxorzPBCk3E
X-Gm-Message-State: AOJu0YwuCWfqb7JHEBGFTFYReCPsHCJKLTh2+9P/bpci1HJ7oMo39t8S
	McnLue7Rm+NlzZBmufPJendnHTBz3cZywY01d7fdDqqgovoFhXHxTASv5L671rnQnE7hqdh+IgG
	HeYYcEX/D+WRndCRLjGPrA2QKoShF+rpLmBQXnnzxlHaZP5MWrw39
X-Google-Smtp-Source: AGHT+IFhgUShs+txwkogbNLzp5ICFvHWYsz2KVlTRUS5jZVGfVHJgNwGlZ3xRsZipn+CPhYYm4LswxZSC7GcFGj3CAM=
X-Received: by 2002:aa7:d594:0:b0:572:25e4:26eb with SMTP id
 r20-20020aa7d594000000b0057225e426ebmr15637edq.7.1714157463740; Fri, 26 Apr
 2024 11:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKWA=LjMUtLOXUfzRMirYfBa+uAfNsfs_Mpq9z0ngGgmA@mail.gmail.com>
 <20240426182559.3836970-1-dwilder@us.ibm.com>
In-Reply-To: <20240426182559.3836970-1-dwilder@us.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 20:50:49 +0200
Message-ID: <CANn89i+FqsMw4M-xo1hGbvqHfYG9gK06tBK3i53hQO_LGpmbew@mail.gmail.com>
Subject: Re: [RFC PATCH] net: skb: Increasing allocation in __napi_alloc_skb()
 to 2k when needed.
To: David J Wilder <dwilder@us.ibm.com>
Cc: dwilder@linux.ibm.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, wilder@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:28=E2=80=AFPM David J Wilder <dwilder@us.ibm.com>=
 wrote:
>
> On Wed, Apr 24, 2024 at 10:49=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.=
net> wrote:
> >>
> >> 2024-04-23, 09:56:33 +0200, Paolo Abeni wrote:
> >> > On Fri, 2024-04-19 at 15:23 -0700, David J Wilder wrote:
> >> > > When testing CONFIG_MAX_SKB_FRAGS=3D45 on ppc64le and x86_64 I ran=
 into a
> >> > > couple of issues.
> >> > >
> >> > > __napi_alloc_skb() assumes its smallest fragment allocations will =
fit in
> >> > > 1K. When CONFIG_MAX_SKB_FRAGS is increased this may no longer be t=
rue
> >> > > resulting in __napi_alloc_skb() reverting to using page_frag_alloc=
().
> >> > > This results in the return of the bug fixed in:
> >> > > Commit 3226b158e67c ("net: avoid 32 x truesize under-estimation fo=
r
> >> > > tiny skbs")
> >> > >
> >> > > That commit insured that "small skb head fragments are kmalloc bac=
ked,
> >> > > so that other objects in the slab page can be reused instead of be=
ing held
> >> > > as long as skbs are sitting in socket queues."
> >> > >
> >> > > On ppc64le the warning from napi_get_frags_check() is displayed wh=
en
> >> > > CONFIG_MAX_SKB_FRAGS is set to 45. The purpose of the warning is t=
o detect
> >> > > when an increase of MAX_SKB_FRAGS has reintroduced the aforementio=
ned bug.
> >> > > Unfortunately on x86_64 this warning is not seen, even though it s=
hould be.
> >> > > I found the warning was disabled by:
> >> > > commit dbae2b062824 ("net: skb: introduce and use a single page fr=
ag
> >> > > cache")
> >> > >
> >> > > This RFC patch to __napi_alloc_skb() determines if an skbuff alloc=
ation
> >> > > with a head fragment of size GRO_MAX_HEAD will fit in a 1k allocat=
ion,
> >> > > increasing the allocation to 2k if needed.
> >> > >
> >> > > I have functionally tested this patch, performance testing is stil=
l needed.
> >> > >
> >> > > TBD: Remove the limitation on 4k page size from the single page fr=
ag cache
> >> > > allowing ppc64le (64K page size) to benefit from this change.
> >> > >
> >> > > TBD: I have not address the warning in napi_get_frags_check() on x=
86_64.
> >> > > Will the warning still be needed once the other changes are comple=
ted?
> >> >
> >> >
> >> > Thanks for the detailed analysis.
> >> >
> >> > As mentioned by Eric in commit
> >> > bf9f1baa279f0758dc2297080360c5a616843927, it should be now possible =
to
> >> > revert dbae2b062824 without incurring in performance regressions for
> >> > the relevant use-case. I had that on my todo list since a lot of tim=
e,
> >> > but I was unable to allocate time for that.
> >> >
> >> > I think such revert would be preferable. Would you be able to evalua=
te
> >> > such option?
>
> Thanks Paolo,  yes, I can evaluate removing dbae2b062824.
>
> >>
> >> I don't think reverting dbae2b062824 would fix David's issue.
> >>
> >> The problem is that with MAX_SKB_FRAGS=3D45, skb_shared_info becomes
> >> huge, so 1024 is not enough for those small packets, and we use a
> >> pagefrag instead of kmalloc, which makes napi_get_frags_check unhappy.
> >>
> >
> > 768 bytes is not huge ...
> >
> >> Even after reverting dbae2b062824, we would still go through the
> >> pagefrag path and not __alloc_skb.
> >>
> >> What about something like this?  (boot-tested on x86 only, but I
> >> disabled NAPI_HAS_SMALL_PAGE_FRAG. no perf testing at all.)
> >>
> >> -------- 8< --------
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index f85e6989c36c..88923b7b64fe 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -108,6 +108,8 @@ static struct kmem_cache *skbuff_ext_cache __ro_af=
ter_init;
> >>  #define SKB_SMALL_HEAD_HEADROOM                                      =
          \
> >>         SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
> >>
> >> +#define SKB_SMALL_HEAD_THRESHOLD (SKB_SMALL_HEAD_HEADROOM + NET_SKB_P=
AD + NET_IP_ALIGN)
> >> +
> >>  int sysctl_max_skb_frags __read_mostly =3D MAX_SKB_FRAGS;
> >>  EXPORT_SYMBOL(sysctl_max_skb_frags);
> >>
> >> @@ -726,7 +728,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_devi=
ce *dev, unsigned int len,
> >>         /* If requested length is either too small or too big,
> >>          * we use kmalloc() for skb->head allocation.
> >>          */
> >> -       if (len <=3D SKB_WITH_OVERHEAD(1024) ||
> >> +       if (len <=3D SKB_SMALL_HEAD_THRESHOLD ||
> >>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
> >>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
> >>                 skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_=
NO_NODE);
> >> @@ -802,7 +804,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct =
*napi, unsigned int len)
> >>          * When the small frag allocator is available, prefer it over =
kmalloc
> >>          * for small fragments
> >>          */
> >> -       if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_WITH_OVERHEAD(1=
024)) ||
> >> +       if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <=3D SKB_SMALL_HEAD_THRE=
SHOLD) ||
> >>             len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
> >>             (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
> >>                 skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_=
ALLOC_NAPI,
> >> -------- 8< --------
> >>
> >> (__)napi_alloc_skb extends the GRO_MAX_HEAD size by NET_SKB_PAD +
> >> NET_IP_ALIGN, so I added them here as well. Mainly this is reusing a
> >> size that we know if big enough to fit a small header and whatever
> >> size skb_shared_info is on the current build. Maybe this could be
> >> max(SKB_WITH_OVERHEAD(1024), <...>) to preserve the current behavior
> >> on MAX_SKB_FRAGS=3D17, since in that case
> >> SKB_WITH_OVERHEAD(1024) > SKB_SMALL_HEAD_HEADROOM
> >>
> >>
>
> Thanks for the suggestion Sabrina, I will incorporate it.
>
> >
> > Here we simply use
> >
> > #define GRO_MAX_HEAD 192
>
> Sorry Eric, where did 192 come from?

99.9999 % of packets have a total header size smaller than 192 bytes.

Current linux definition is too big IMO

#define GRO_MAX_HEAD (MAX_HEADER + 128)

Depending on various CONFIG options, MAX_HEADER can be 176, and final
GRO_MAX_HEAD can be 304

