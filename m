Return-Path: <netdev+bounces-69870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57E84CDF4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B627287E86
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4607F7D5;
	Wed,  7 Feb 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKdB/QQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBD7E77F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319585; cv=none; b=inRzOdviKzM/Rlwd/3dVpXyP9/pW0HMqjYw5MJ9tEoUnoIPwRyKSt2nmT0GzF0DDC9R/vxXQTQjilCHaatu3d4X6FJL7suFqplVK063edIENgQX/xzNc3tt/sg3GqK6EDz8immlwJFIGsAUKcb30UYWFN9bSWbgXxIb3rZEojGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319585; c=relaxed/simple;
	bh=Va/2+ynq3e7742APlmvu9+ssVsWN5yBFKR7VOJB6jpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSCeFESAgEudtGynD86ATWHsZhbNc1D4UuE1uClMChaLdNEa0IEx0l6gwlaP3s0/RI3Xr6t7uixpi3kBjKFfs7l+rpyHcjDs4UvptgCbMXqUU/Ky43aZQsLAsNao08LJ2uBTCJYBngU7phWtvWUuu1ynB0D+h1vcwc6RqL1TOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKdB/QQm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so7170a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707319582; x=1707924382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaNC2rtH20E+Mzv4ufm1HK0lNpzfFZ8uT++2UNuoegA=;
        b=LKdB/QQmKtxOm0tHH8QhgEK4DHpJ+DGpHoWcI0yOdxlJjJnmKtsuFOQfwS/l0WcUr6
         cqepklWefKMCKWq99y+UIf7OlkRaMmuGfR0lGxKwJ/e510SQzuTwCCF/eiUvWv389yEv
         EeNoTn8sVP2+0Rn5YjFAhgn11Q2bGpXq0BpWbDhVsY2sDY9ZuQFy6z+LoOJIEaCNjuq/
         BUustZlCRCzHvDe4/hJeGbfrpmaqmgNstFGrUWj2xuTiJXIbWqjo8vnXAjuJGEfg8hCZ
         IbqiQVtog8opaWOaJntFCGmjFtSymYEohJruOf7pFnIajVogQ+6waaNklgdZ8YXEsoJ/
         Zx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319582; x=1707924382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaNC2rtH20E+Mzv4ufm1HK0lNpzfFZ8uT++2UNuoegA=;
        b=XzrZAw+oNcuY9JVz4L0MF9IGS2FTVx8wS/vbbTJud96XFOiF63C6aAdFY1ODC+YOu9
         b/btMjM/LSIUQ1TSc8DpoGOosfcWrlQWhH849zLFiyfJ61C79BSLdFiX+LdoY8SxmV3g
         Nggix3XgGhgvHqiKfTOJP+GbU6CyLRP9cCjdgIC/btmFs5fLQaXb3ZsFTnuZlDW0qwXP
         o2hNBRv27lQMdBCA0tJUWHQPvct4Q1zlsBqCQ/x2BAE3Hkqd1wWFTCUWdQyisAcH623R
         Mb87N7sm7lcgFeTe8mpEo8GFxX8OU9LaPmCY6/j1Ou3plJ9A8FV1gmRy7pPHk2cOfyKU
         ZZDw==
X-Gm-Message-State: AOJu0Yxpq8inf7GVk27M0dzCRaRovH8xV13jcmvPJmu1BDmCZmhdJtEc
	IyVhe1m0sxXvi6TD2EKOEmet/40gNB2+xhy7Y0UWHqkTp8lr05yJnv4n/qShvd/+S5qfXFDrJv9
	UDdPlbH1ThyEAZ7P2m9+WYlCOOKtPzYGxBnC+
X-Google-Smtp-Source: AGHT+IE17+9QP3UqrbECedzlgBguZvZcJEdBT5JEXy4Ab5qrauvYd3bHpQbZ58wnWSGwyQ9MpL9aijY78gMoK+kOZw4=
X-Received: by 2002:aa7:cfc6:0:b0:560:e82e:2cc4 with SMTP id
 r6-20020aa7cfc6000000b00560e82e2cc4mr78681edy.3.1707319582161; Wed, 07 Feb
 2024 07:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b94ee2e65cfd4d2d7f30896ec796f3f9af0a733.1707316651.git.asml.silence@gmail.com>
In-Reply-To: <2b94ee2e65cfd4d2d7f30896ec796f3f9af0a733.1707316651.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Feb 2024 16:26:08 +0100
Message-ID: <CANn89i+tkdGsKVR6hhCSj2Cz8aioBw1xJrwDYLr9fB=Vzb65TQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:42=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> Optimise skb_attempt_defer_free() executed by the CPU the skb was
> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> disable softirqs and put the buffer into cpu local caches.
>
> Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
> showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checking
> with profiles, the total CPU share of skb_attempt_defer_free() dropped by
> 0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
> optimisation is for the receive path, but the test spends >55% of CPU
> doing writes.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/core/skbuff.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index edbbef563d4d..5ac3c353c8a4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6877,6 +6877,20 @@ void __skb_ext_put(struct skb_ext *ext)
>  EXPORT_SYMBOL(__skb_ext_put);
>  #endif /* CONFIG_SKB_EXTENSIONS */
>
> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> +{
> +       /* if SKB is a clone, don't handle this case */
> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE || in_hardirq()) {

skb_attempt_defer_free() can not run from hard irq, please do not add
code suggesting otherwise...

> +               __kfree_skb(skb);
> +               return;
> +       }
> +
> +       local_bh_disable();
> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
> +       napi_skb_cache_put(skb);
> +       local_bh_enable();
> +}
> +

I had a patch adding local per-cpu caches of ~8 skbs, to batch
sd->defer_lock acquisitions,
it seems I forgot to finish it.

