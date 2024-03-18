Return-Path: <netdev+bounces-80430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05587EB10
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3C71C20B46
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F74D9E0;
	Mon, 18 Mar 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6AWSOCR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E04BA88
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772403; cv=none; b=bF/sXOempVfbrTbp+2fS7kdieL2JwZuYxEBuuorBabPIPm230fVr5Rfkfp0JKkxB99JzuGCKvOcLOX59732L6VrJvAHVwLQHAkmFKX5FH0RSy1bLXJhvG8VyVeWLVCq0k1HRXpG50ScDHoaLV6Suv63Ra1V17TRQaC6lD1nZtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772403; c=relaxed/simple;
	bh=WXr66y0IRZ9LF8+OoRXDFAkJLbi3XbYssy6fI674TcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOSG9bq78i0S7o66Rp2jF/IpzgZJnlbswjRrr85mHnq4sxxWFQmom8kFt2bcEettrM8UQXrUpwCfC3BqDX++3dq3SJoclwsWhl0GwGXMmrBjA+EnlisUF8SowIvK8aH46ayGs6GmV5SU+SHjzYQyw3evKEOfUORF03lk2SEVnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6AWSOCR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-568d160155aso9927a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710772400; x=1711377200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKPJBkT7vHK5F26FuywpjB7QWF5SDGPkTvJFbxZr+d8=;
        b=r6AWSOCRJXVnWjpdNHeRdST+sfKDtXzdP9iYSip+GOW0wBlBADaEJsPP8kJOWX9DKO
         u+HjAZErzRzxFrpbV7S+p+9OeIBIFx3MB52MnY6d4CJXd+hqsQ+0PfVDD1s6tJl6ZZak
         hGeVED61LGuoo1sUgsUsBYZvf6BYz7yrhPDX0nIOdFmXlnCS9e0r/68hnOY6HHOOWoFm
         KuOOMxcCjBwSl1mmtFtTPLg7fcJmZfpD7X7i6dBf5ORWVd3uS1/UWhEsdbtIrbjvpQYM
         aWXdIeH1lcYzi07FVl3BG6gHd7rEgThoZ02UX6VQwYvMoEAjXNp64ZI9Jpv2F4wpLiu0
         v2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772400; x=1711377200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKPJBkT7vHK5F26FuywpjB7QWF5SDGPkTvJFbxZr+d8=;
        b=vNQ9x28Hc3cXw6ye3KFtgVpgA/KUfAN/KfEFLFPQH5+BVdKJJ0Yp38kazIchPVG1fC
         cjuQXFCeVAEbR3PrGECfRLzBoHCrjuodBZQrYBjbMHNIppmzXcBuTfAgyXM2wn5pSF1Q
         2QGwQEHNvU7a08Nup+H/9HiUBUGsVeznyQm+FKb6pekOjiPBiQDXSk+e9TW0Jeb5sq2D
         G+2ec6s1vNWiWYACFYxJDZIYG230zk0WsMGUYhlUNkKuP3ubvD3j81SKzsdW0qicWd9K
         Vi8ExkgdWoZNr6PWaNtNyaPqvqgjoueMPL3BbGdabwRoXlV9QqM+6kPEmxCqhLT1DrPY
         PkkA==
X-Gm-Message-State: AOJu0YzwCQ8tfYMa08MynlmhEazfcmHUuKwVu/uuDrDgNg4lqWw5RkKz
	bIyviuLS19oudr8XkYjoU4J5Dj2PmC2MUGqWdMHO4J/BAkrhLOKYJNNdpPci88TrV1MReV4CKV/
	G5BZVpcIchuRqrYxZ+/FeirIefGq3xLaPLTLf
X-Google-Smtp-Source: AGHT+IHYBmpOrEp5ltlVolbjMnaKjg0L/iec/VlynN5JUE121MmtM+pDkpiJRrw+6QfmcgU2a1/+Ltc4EsBFF8LzfoM=
X-Received: by 2002:aa7:d684:0:b0:568:797f:f529 with SMTP id
 d4-20020aa7d684000000b00568797ff529mr257184edr.2.1710772399608; Mon, 18 Mar
 2024 07:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
 <CANn89iLjH52pLPn5-eWqsgeX2AmwEFHJ9=M40fAvAA-MhJKFpQ@mail.gmail.com> <ca2a217e-d8a0-4280-8d53-4b6cea4ba34c@gmail.com>
In-Reply-To: <ca2a217e-d8a0-4280-8d53-4b6cea4ba34c@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 15:33:05 +0100
Message-ID: <CANn89iKV+P1yCoXHF0DZLjiZK6JL37+4KzAcYcvJgXu7hpEJiA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 12:43=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 3/18/24 10:11, Eric Dumazet wrote:
> > On Mon, Mar 18, 2024 at 1:46=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
> >> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> >> disable softirqs and put the buffer into cpu local caches.
> >>
> >> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
> >> throughput increase (392.2 -> 396.4 Krps). Cross checking with profile=
s,
> >> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
> >> I'd expect the win doubled with rx only benchmarks, as the optimisatio=
n
> >> is for the receive path, but the test spends >55% of CPU doing writes.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>
> >> v2: pass @napi_safe=3Dtrue by using __napi_kfree_skb()
> >>
> >>   net/core/skbuff.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index b99127712e67..35d37ae70a3d 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -6995,6 +6995,19 @@ void __skb_ext_put(struct skb_ext *ext)
> >>   EXPORT_SYMBOL(__skb_ext_put);
> >>   #endif /* CONFIG_SKB_EXTENSIONS */
> >>
> >> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> >> +{
> >> +       /* if SKB is a clone, don't handle this case */
> >> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE) {
> >> +               __kfree_skb(skb);
> >> +               return;
> >> +       }
> >> +
> >> +       local_bh_disable();
> >> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> >> +       local_bh_enable();
> >> +}
> >> +
> >>   /**
> >>    * skb_attempt_defer_free - queue skb for remote freeing
> >>    * @skb: buffer
> >> @@ -7013,7 +7026,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
> >>          if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> >>              !cpu_online(cpu) ||
> >>              cpu =3D=3D raw_smp_processor_id()) {
> >> -nodefer:       __kfree_skb(skb);
> >> +nodefer:       kfree_skb_napi_cache(skb);
> >>                  return;
> >>          }
> >>
> >> --
> >> 2.44.0
> >>
> >
> > 1) net-next is currently closed.
>
> Ok
>
> > 2) No NUMA awareness. SLUB does not guarantee the sk_buff was on the
> > correct node.
>
> Let me see if I read you right. You're saying that SLUB can
> allocate an skb from a different node, so skb->alloc_cpu
> might be not indicative of the node, and so we might locally
> cache an skb of a foreign numa node?
>
> If that's the case I don't see how it's different from the
> cpu !=3D raw_smp_processor_id() path, which will transfer the
> skb to another cpu and still put it in the local cache in
> softirq.

The big win for skb_attempt_defer_free() is for the many pages that are att=
ached
to TCP incoming GRO packets.

A typical GRO packet can have 45 page fragments.

Pages are not recycled by a NIC if the NUMA node does not match.

If the win was only for sk_buff itself, I think we should have asked
SLUB maintainers
why SLUB needs another cache to optimize SLUB fast cache !


>
>
> > 3) Given that many skbs (like TCP ACK) are freed using __kfree_skb(),  =
I wonder
> > why trying to cache the sk_buff in this particular path is needed.
> >
> > Why not change __kfree_skb() instead ?
>
> IIRC kfree_skb() can be called from any context including irqoff,
> it's convenient to have a function that just does the job without
> too much of extra care. Theoretically it can have a separate path
> inside based on irqs_disabled(), but that would be ugly.

Well, adding one case here, another here, and another here is also ugly.

