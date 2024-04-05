Return-Path: <netdev+bounces-85211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A867E899CBE
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C6283C6F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7A16D32F;
	Fri,  5 Apr 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZwMpFhU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAC16C878
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319512; cv=none; b=d+NRjG+J7ng1vaapP3I2HZL4t5WwUiRiemO3AHLR0TOB3wgLop749q6aJgP1CAJXwyzm5zwwhKeC1FaRWV1v/W23eKZzILyfcOqvmmH8h3oPx2P9DufZN6SMvASNkRM78C9unFtbVe3GYqtDwplhLl3TRHG0VBur2mlE4KP/2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319512; c=relaxed/simple;
	bh=udUxXEZqr7ZvZXYZK4DkmP6qmn431zipOt1V3yiuVAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpzGmG+C6v+pHegVK26iWln4nswYy9RU8jVfdscHobJvdFXPjSPuPp0T3l/5m2UKXjMtIHPXVxWABuMkNpxIFUKs5PBoWyXYtQ27IIO7+wxUpM18qY+QY3GMgX6xIXPcCH+lKspeI5Z7TrOkk0Ym+SN3Cw/14euGTqzBrmFSR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZwMpFhU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso9101a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712319502; x=1712924302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tfsi1juHChnxscvc1BunWqnmn0THRUV5sR+hJYTSHQs=;
        b=GZwMpFhUT4kZX7DPv12ktsxX/c8hz0CfM5YljIJgao40YrRnpVKxkJ3LZphM94JpP4
         gTe797yjWUR/8yFG1FCeRenrVvviV50X1WLDXkCRY+6g1XzVn9QhZAmpSmQVBDl8IkaQ
         rPZXJIhHPnw87Q7jWPU+Yw9HhYGYqVfrmcak5Gg467A5MtsARRZLuk83B1M5mniKfyVX
         VPCnkRkn1eWcwQ48YgoW+wr/tD+rlzZJPk1gT6OzsVaRiWv/Nq2N2gUsuszLshvgh+Ll
         p16j00ATlb7vRRfp1mhubFs2LNFRMo/N95kaD9f9cWMxBHIOy6QYEQ3KBvnEUwBHUJl7
         r9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319502; x=1712924302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfsi1juHChnxscvc1BunWqnmn0THRUV5sR+hJYTSHQs=;
        b=XHZpSCK4ttxNJsi4FzUOtx7nuRQc0n5qNUe9/zjEqZlT7Q1r/G0mKbeEb1pkDCH0Ho
         QnuUSKnJulduBubW0JkYYB6+y2SqeTQw3RQKNAb9bF7cOwfxPgIbftWliJNFDXrLpQ/z
         e9KnMpJfiMA4KqDITyTHxKFLZGMQArJrCDqoZgFGDBgZGLafSvN4cfudKFx1wGpIsYWU
         ygPB7s1HEQSHHVNqUv7JQ3AdWNptQXIM/8lHkJM9nw977QmMmQJ7qkp7+xCb1PoC/0EF
         Hbw/nIagkzY4tA9bsvWSZI8g1HC8/M8hXmXSHa17xdu1TSiXqbsOLsiKZ20AuoKQ9ihV
         C+jw==
X-Gm-Message-State: AOJu0YyIJ+FpCh+rWytGCUQ9UBQxf2yCD2D9dz7c0jEBxarya2g7m23V
	zqkVQgjD0iAFqrgsrBq6XUZOg86TD+UG7+eDOzM1zNsJ+6ImDEqhFIM41g5H1gBtLNxCOrPH9fe
	xOW/PCZoW9aG9UvS5ASQMPFo26q0Wtk2Zy6zu
X-Google-Smtp-Source: AGHT+IG8HsUuvrxJXgZX5iVHspSlUXfelkhRpJvkmhGXo3+gZCOK2okXIts9fuV2g/nImuABj0RX0DwaQ1btQmAp99I=
X-Received: by 2002:aa7:c40c:0:b0:56d:e27:369c with SMTP id
 j12-20020aa7c40c000000b0056d0e27369cmr300320edq.3.1712319501857; Fri, 05 Apr
 2024 05:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com> <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com>
In-Reply-To: <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 14:18:09 +0200
Message-ID: <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:55=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 4/5/24 09:46, Eric Dumazet wrote:
> > On Fri, Apr 5, 2024 at 1:38=E2=80=AFAM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
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
> >> v3: rebased, no changes otherwise
> >>
> >> v2: pass @napi_safe=3Dtrue by using __napi_kfree_skb()
> >>
> >>   net/core/skbuff.c | 15 ++++++++++++++-
> >>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 2a5ce6667bbb..c4d36e462a9a 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
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
> >
> > This needs to be SKB_CONSUMED
>
> Net folks and yourself were previously strictly insisting that
> every patch should do only one thing at a time without introducing
> unrelated changes. Considering it replaces __kfree_skb, which
> passes SKB_DROP_REASON_NOT_SPECIFIED, that should rather be a
> separate patch.

OK, I will send a patch myself.

__kfree_skb(skb) had no drop reason yet.

Here you are explicitly adding one wrong reason, this is why I gave feedbac=
k.

