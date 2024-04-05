Return-Path: <netdev+bounces-85225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD0899D2B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940671C20DB8
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23B13C679;
	Fri,  5 Apr 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2od4SJLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44E1DFE4
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320735; cv=none; b=q5IHIXV05M0Lpoc+NvstWq2ayCWnunjl60AOARW5yoVysH8/d0Zz+yj04IPXJAox3FEipqCb9lbWMkKr7zR0kR1W/1DGKain2XRT23IOJrKpa9dqAOMnZjcd94odiudliF5UGNACqGb4uXDov40+H2zQ/793dvAIJa4L4HQ5BBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320735; c=relaxed/simple;
	bh=4sBQePOL1LiM378gs7salRkQNoxE7JQsqbNnKogaLBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG5vv894AbiQlrLpeoWBqiEVzsmvyUQRLbiWoKkFAtXNjRwS+qglfCBNwd2xeAeA5bTb1hD7byGFyxPeqUXkAKft+xw9Rd+BRJx3nnHWVzgYoU4PO+rsEKS58adfCTkybw2EGkKY+byw2XbVJ/rrtGuziuM59tAUG8xKPnOz9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2od4SJLn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso9291a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712320732; x=1712925532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7zKZsKSQ0P/VlyvNkYLkYg2zwHiIhwMf2xSZ3fsFWY=;
        b=2od4SJLnCpcPCNGaU1xuWNFRTBaBspD+Wq1xcB+Gqfh2TED1FI2tNHhooFG/nxktR5
         qWbxvx0bUBkxia5iD2YbpOxasvx704CmUOzmWd4i3gukSYqfD3WhIxFUJuBX01l5PkmM
         p7515cN+SMMaQsdBynhEzHTIvmx0wQUxFtqsHR5hRVZS2bRiHerKxQp9X+bacglq10Ci
         xaoueH6ivIT6OLLZYCXxkjuC97hNbelUMJAe90EEah4F2fozpY0pWvbLwPrdfz3YttfM
         e8vn8rXzmRdBy9WoVpby525lSIF5lSZLsn+guTRWlOzHKbWj7ocl2FWckyClGEduIOTk
         FzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320732; x=1712925532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7zKZsKSQ0P/VlyvNkYLkYg2zwHiIhwMf2xSZ3fsFWY=;
        b=vj9c5DTvBJSiU0w4+BUxt8LZ3/XODMmKHZpay+lqQeKSEZALfIKdvzGhH4EhtBOe5A
         iDKzyAZDe2rwlJ7xI9lpurwlVGGR/tuZ9JBE+y+0/GEcg2f2XGqR6NwQ4q9V3gfU/z0W
         lncDkY2HpCFCOuZSYxUZGIU5SoKlY5J4HXo1nQO6K0+YcAq8ekCgbbxXJeObo8i8MoPt
         BQjS/ezeADLwrKILt3yp3cfFX1E6YB+HYTocLR8pz4NjpZfz7gb24jmnQ0FHkiKOnm5K
         ankJtoe5PH2gkQxosjh3tseJzZI9BOdidJL3WzfJNY3dAKS1MLgW+Alc4ELuzMETlC94
         f+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4zw19YCy57f6gbdHYkZN5NDdq+wC6ZMQYIYX+Bago2dYfmixbqO14RTvxp3xcGvq70OCKpXxt2aUhAxEgyFE/D0+h6gnK
X-Gm-Message-State: AOJu0YzKhTzsvMitbFLtPDVyg9pL1/EeobQr36vAia9LLZ5Lq1uP/ne0
	EWAwxOtzKfd0t2lunxs3XWK1kCQ7vXthOqLDceUGLkOF3mpBRJ/8MDPSey9b7lQzi0JQUF5aWV/
	9HjkyhWQR5KWu4+3NAo1AzyhZ05X5zTrO/pakoPmnsMbyU3sbHA==
X-Google-Smtp-Source: AGHT+IHxNQjdjQf3Ga7cu8MhFlCXJEbqCOfoOPNZ6C72ao2JbQkE7lmVCQisAJQ9Jl8an9sKC/+FmWi0ZpaDBZr7onc=
X-Received: by 2002:aa7:cd05:0:b0:56e:2239:bcbe with SMTP id
 b5-20020aa7cd05000000b0056e2239bcbemr313376edw.2.1712320732328; Fri, 05 Apr
 2024 05:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
 <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com> <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
 <CAL+tcoC4m7wO386UiCoax1rsuAYANgjfHyaqBz7=Usme_2jxuw@mail.gmail.com>
In-Reply-To: <CAL+tcoC4m7wO386UiCoax1rsuAYANgjfHyaqBz7=Usme_2jxuw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 14:38:41 +0200
Message-ID: <CANn89iJ+WXUcXna+s6eVh=-HJf2ExsdLTkXV=CTww9syR2KGVg@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:29=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hello Eric,
>
> On Fri, Apr 5, 2024 at 8:18=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Apr 5, 2024 at 1:55=E2=80=AFPM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> > >
> > > On 4/5/24 09:46, Eric Dumazet wrote:
> > > > On Fri, Apr 5, 2024 at 1:38=E2=80=AFAM Pavel Begunkov <asml.silence=
@gmail.com> wrote:
> > > >>
> > > >> Optimise skb_attempt_defer_free() when run by the same CPU the skb=
 was
> > > >> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> > > >> disable softirqs and put the buffer into cpu local caches.
> > > >>
> > > >> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed =
a 1%
> > > >> throughput increase (392.2 -> 396.4 Krps). Cross checking with pro=
files,
> > > >> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. N=
ote,
> > > >> I'd expect the win doubled with rx only benchmarks, as the optimis=
ation
> > > >> is for the receive path, but the test spends >55% of CPU doing wri=
tes.
> > > >>
> > > >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > >> ---
> > > >>
> > > >> v3: rebased, no changes otherwise
> > > >>
> > > >> v2: pass @napi_safe=3Dtrue by using __napi_kfree_skb()
> > > >>
> > > >>   net/core/skbuff.c | 15 ++++++++++++++-
> > > >>   1 file changed, 14 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > >> index 2a5ce6667bbb..c4d36e462a9a 100644
> > > >> --- a/net/core/skbuff.c
> > > >> +++ b/net/core/skbuff.c
> > > >> @@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
> > > >>   EXPORT_SYMBOL(__skb_ext_put);
> > > >>   #endif /* CONFIG_SKB_EXTENSIONS */
> > > >>
> > > >> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> > > >> +{
> > > >> +       /* if SKB is a clone, don't handle this case */
> > > >> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE) {
> > > >> +               __kfree_skb(skb);
> > > >> +               return;
> > > >> +       }
> > > >> +
> > > >> +       local_bh_disable();
> > > >> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> > > >
> > > > This needs to be SKB_CONSUMED
> > >
> > > Net folks and yourself were previously strictly insisting that
> > > every patch should do only one thing at a time without introducing
> > > unrelated changes. Considering it replaces __kfree_skb, which
> > > passes SKB_DROP_REASON_NOT_SPECIFIED, that should rather be a
> > > separate patch.
> >
> > OK, I will send a patch myself.
> >
> > __kfree_skb(skb) had no drop reason yet.
>
> Can I ask one question: is it meaningless to add reason in this
> internal function since I observed those callers and noticed that
> there are no important reasons?

There are false positives at this moment whenever frag_list are used in rx =
skbs.

(Small MAX_SKB_FRAGS, small MTU, big GRO size)

