Return-Path: <netdev+bounces-80289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4187E239
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 03:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFFF1F21394
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1431BF3F;
	Mon, 18 Mar 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9Y0sbQT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B31DDE9
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729885; cv=none; b=SXNhtNysJn3cnBlDaMIoFFHqoZXljVOdefEJFxI2sMMwG3KDuhFZIlfzBKVNJJ94JkuzYh0mrs8WYu7wdEsybSq19xz/bMXVsvW+3dWXWEnORl/o1w9c0ZBmjyGmFv5hp3dARyC2tFFqD0fLNbAZ6U1DwPAKIg2k1fEVwGdkLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729885; c=relaxed/simple;
	bh=5YrXE2MJsa7bNqse65FNAL1chmFW+14NdHbJj14inso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHfg5+RR25QnukuqrwHQNp5fxhKkFnGXb8Y8LhbjbqAQklsk5aFGrICKjv93N4MbhspEbDMRYthwZqaUMWhnNCERTa5td57HipZfKY55pf3zKB75afMOjyHlQO8BjwJscrLJtmJWOMIqCasU4ZbYnbO3RtnaHxSBMfWYKLWKgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9Y0sbQT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so895770766b.0
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710729882; x=1711334682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2SESJlqbGOYBDnocAiOAdQciPn95Lh/Wfj9+V2UOuU=;
        b=e9Y0sbQTn43StS0T680n87R8KQnX+WxVHiqLFJjZacuARUYq3jn+Gvnc3aPmrIoEs2
         EZL7/zZvJZouZk7RwCk3pN6zqTe7hGqT7bu3cKGuYV9HZJXyAPxRF04HNBm3oXxDJsPi
         QrBqPcCFHsvcLMKF+8/AFCGHgbxtaDqPo2Y+2aRnuGjhJF8u6mNH9BUms9X4joNiA+9j
         Z1skFr1820x9pZRkhbdLsOkxsyY5Zs66F8Comt88YgVeBFV6Cz6HNtW6rt5kVFnkrUqG
         FgnsJ6P69GYjVNjWDmbaByJ7E6Yg60/JfuFnLnEa2pnPhfoMf6yQjRFFSpB7HKJtcfof
         uMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710729882; x=1711334682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2SESJlqbGOYBDnocAiOAdQciPn95Lh/Wfj9+V2UOuU=;
        b=cTNttzcMdD+lzojmo/a6HobUP0cRF07ya7NryJ3vgwHlf3BCG4+EclhxbqaqG3VkCz
         JwphJ/aTQ9KY62GIlZ1MvwT1bYL9Oi+TIT2wyk8r+VWEkuJqbtc1eYMn0NqUGTtSBwSn
         th9ext+RU0TBW2kh7SIi6GGn2rhDLy58VSrrpQs9owmEx9DaENqbKBdKdcQsHtKBpTmj
         DQTxkZlbetyrXEZCBP6wasEMK7elPuswXeBgJMD4rNeX1t75FNH0vg0VG22E3Rbv6pL9
         i275RW75yYikaJwm4QWbHRT6ykc/KL57dbaZK4V/IFOPCdbecnZ2kAMDjyGFwEERnRuT
         MfgA==
X-Gm-Message-State: AOJu0YzWlvFrI0bjpyl0djTBmwDPMmv8cmBlw1L+aI3UW6ZimbAqQc+E
	Ql57yHt0nRmIIQc1j3jwx82brZpS6Fcv1R+/HJRvhmVa+gI3mXVMr8a3IHPHaKphkYlGMtjy1sO
	8UwsKm6jkl6dUidIppMAqrhLQta8=
X-Google-Smtp-Source: AGHT+IGIRXdL7SdCKJJUIWoIyF8WTsr4kI75/0TvH7deaHuX2bI3kehMJoReKtgLUZfcbJnuFjVMBs/Z+BfYlPeicQM=
X-Received: by 2002:a17:906:3c59:b0:a46:83f0:6ca6 with SMTP id
 i25-20020a1709063c5900b00a4683f06ca6mr6777823ejg.33.1710729882337; Sun, 17
 Mar 2024 19:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
In-Reply-To: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 Mar 2024 10:44:05 +0800
Message-ID: <CAL+tcoA=3KNFGNv4DSqnWcUu4LTY3Pz5ex+fRr4LkyS8ZNNKwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:46=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> disable softirqs and put the buffer into cpu local caches.
>
> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,

I suspect that we can stably gain this improvement. The reason why I
ask is because it might be caused by some factor of chance.

> I'd expect the win doubled with rx only benchmarks, as the optimisation
> is for the receive path, but the test spends >55% of CPU doing writes.

I wonder how you did this test? Could you tell us more, please.

>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>
> v2: pass @napi_safe=3Dtrue by using __napi_kfree_skb()
>
>  net/core/skbuff.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b99127712e67..35d37ae70a3d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6995,6 +6995,19 @@ void __skb_ext_put(struct skb_ext *ext)
>  EXPORT_SYMBOL(__skb_ext_put);
>  #endif /* CONFIG_SKB_EXTENSIONS */
>
> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> +{
> +       /* if SKB is a clone, don't handle this case */
> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE) {
> +               __kfree_skb(skb);
> +               return;
> +       }
> +
> +       local_bh_disable();
> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);

__napi_kfree_skb() doesn't care much about why we drop in the rx path,
I think. How about replacing it with SKB_CONSUMED like
napi_skb_finish() does?

Thanks,
Jason

> +       local_bh_enable();
> +}
> +
>  /**
>   * skb_attempt_defer_free - queue skb for remote freeing
>   * @skb: buffer
> @@ -7013,7 +7026,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>         if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
>             !cpu_online(cpu) ||
>             cpu =3D=3D raw_smp_processor_id()) {
> -nodefer:       __kfree_skb(skb);
> +nodefer:       kfree_skb_napi_cache(skb);
>                 return;
>         }
>
> --
> 2.44.0
>
>

