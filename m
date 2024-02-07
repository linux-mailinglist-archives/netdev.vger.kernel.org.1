Return-Path: <netdev+bounces-69879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DC84CE72
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91364289FCD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE227FBD9;
	Wed,  7 Feb 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwXsSBPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6071B1804F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321386; cv=none; b=gmsDtdI+1b+FSOFCIQKPWlYdchQ475sY9D8Ztd0ot6GJy2+oHkNi6GDylyy5/+7L1L6GFrcDfKgV4Vlnkouw6G7hkuufH1soIx1nL/gtw7lPgKi8G6VqPTlbBUhGM+ijsuwOb1av5LNgXcaO85j/odVen9m58VcfJqvPHhD3Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321386; c=relaxed/simple;
	bh=c57O0xzQSC69RFAAQQGPhtyRzFBExzqZpz1rZF+NA2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJwN1e3B/Hgn4DaU2c41xfbNsnMW8Sd0rSHaTIqXy5guF/FeSKVL2Bww70VfEtkfgrPAYOV8EupFBNvde87jydPgw8PeJrkCULMTa7QYPV8oDim/YKIInyIx7QlJEgdFvEj5VyWEzfR5z+qB86VrHaZtvmAdAnl8Wzw4Cuii588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwXsSBPD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so7609a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707321382; x=1707926182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW0IVqn1+JNASW956m9gNOL1dSs6dEOrXlQVTQsx8LQ=;
        b=XwXsSBPDeb1VB+E8OCFwCi3MgfRdnRtUOWovDxZLCkB6nNMvvfrwKR0EAQ7m5sOxGr
         P2/KVc1T0GN5ZNMLXHXxBNZCBqP/hjAuiiPLWv77qD8Vjbccg5C/mPvkouF2rK5x/UIf
         q5JFsgXj+SuBGwA2eEuxr4HCUfr4bC0MXjoUsZ8H6flxfHZFf2KswgnL3WbXYTDC211+
         aeYNaQH/+2qi3fPclroVkFXgx5+Z/y0vQoAogKX7r4gOotjXJPPdCJ1XWVIRKzVSCL2d
         cq3k2WL6SAG+v+U7JYA6murSsu0n9vlLHDu2XXLhzGoV81/Fv3UQFweq+SEee637zXpG
         HaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321382; x=1707926182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW0IVqn1+JNASW956m9gNOL1dSs6dEOrXlQVTQsx8LQ=;
        b=e9ymdZ7PMxARwMwG7zSSCUOUogOe0Q//FjtxJ0mVVVh+33r1PapcObkF4s1nwa2XvC
         oCIi1ocQ2nz7KwJgTMAfeSywG6pxuktTZQCkPJOtQUsg5OLostcF9MNzz+NFfd3+4fbj
         8VJ5fLI7ZEdnk18DPBXQLgvRntSy0cbepsGN6iWcgpi1Lu17wGTecHsv/it6EWtt8/PW
         e1kR+e36tGLERHXVtrS5et0YICnGZzF6w8E7JYFocz808WTGF1OEh8Go9vWXL9dK+cEs
         jVCRIKX4hdxCFVluhmbQ12buxE5p5Yb3PW/uutz+YlYagSTo2hMDDqrfSGU5tLOwZ7G9
         Q9yw==
X-Gm-Message-State: AOJu0YzOmA35n1Ut5VvSOSMgCFxwaqNs/8DidpjbCMPfIOk/qSwPheme
	+teTEzPce3eFzb1GgWeY0ZI7my+/FuM45+Yup9Y1C0wURnTUvO4i80lbExmO9knIizFSBjCFFBp
	sSp4rqoDC5rpqcwZKQcYM7xPH0+oAolqE1375
X-Google-Smtp-Source: AGHT+IEOV7qg64Rfn5iHWmMGW6iKxunSkgNYKR6/HWSlAMg53AdmcjDS+uUzLur3XwxL/FOA177N72L/g48dT2cue3k=
X-Received: by 2002:a50:bb29:0:b0:560:4895:6f38 with SMTP id
 y38-20020a50bb29000000b0056048956f38mr126100ede.1.1707321380606; Wed, 07 Feb
 2024 07:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b94ee2e65cfd4d2d7f30896ec796f3f9af0a733.1707316651.git.asml.silence@gmail.com>
 <CANn89i+tkdGsKVR6hhCSj2Cz8aioBw1xJrwDYLr9fB=Vzb65TQ@mail.gmail.com> <8de1d5d4-ec9e-4684-827b-92db59a3a173@gmail.com>
In-Reply-To: <8de1d5d4-ec9e-4684-827b-92db59a3a173@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 16:56:07 +0100
Message-ID: <CANn89iKyg6ryhCnUxsGdjjRrpqWzP9MpZtzttjNXXpB1jXn5sA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:50=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 2/7/24 15:26, Eric Dumazet wrote:
> > On Wed, Feb 7, 2024 at 3:42=E2=80=AFPM Pavel Begunkov <asml.silence@gma=
il.com> wrote:
> >>
> >> Optimise skb_attempt_defer_free() executed by the CPU the skb was
> >> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> >> disable softirqs and put the buffer into cpu local caches.
> >>
> >> Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
> >> showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checki=
ng
> >> with profiles, the total CPU share of skb_attempt_defer_free() dropped=
 by
> >> 0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
> >> optimisation is for the receive path, but the test spends >55% of CPU
> >> doing writes.
> >>
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>   net/core/skbuff.c | 16 +++++++++++++++-
> >>   1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index edbbef563d4d..5ac3c353c8a4 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -6877,6 +6877,20 @@ void __skb_ext_put(struct skb_ext *ext)
> >>   EXPORT_SYMBOL(__skb_ext_put);
> >>   #endif /* CONFIG_SKB_EXTENSIONS */
> >>
> >> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> >> +{
> >> +       /* if SKB is a clone, don't handle this case */
> >> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE || in_hardirq()) {
> >
> > skb_attempt_defer_free() can not run from hard irq, please do not add
> > code suggesting otherwise...
>
> I'll add the change, thanks
>
> >> +               __kfree_skb(skb);
> >> +               return;
> >> +       }
> >> +
> >> +       local_bh_disable();
> >> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
> >> +       napi_skb_cache_put(skb);
> >> +       local_bh_enable();
> >> +}
> >> +
> >
> > I had a patch adding local per-cpu caches of ~8 skbs, to batch
> > sd->defer_lock acquisitions,
> > it seems I forgot to finish it.
>
> I played with some naive batching approaches there before but couldn't
> get anything out of it. From my observations,  skb_attempt_defer_free was
> rarely getting SKBs targeting the same CPU, but there are probably irq
> affinity configurations where it'd make more sense.

Well, you mentioned a high cost in cpu profiles for skb_attempt_defer_free(=
)

This is what my patch was trying to reduce. Reducing false sharing
(acquiring remote spinlocks) was the goal.


>
> Just to note that this patch is targeting cases with perfect affinity, so
> it's orthogonal or complimentary to defer batching.
>
> --
> Pavel Begunkov

