Return-Path: <netdev+bounces-71389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E465A85325E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69001B21E01
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7FF56473;
	Tue, 13 Feb 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTx2qmCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A975788F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832416; cv=none; b=gsTcuircjfUTq1xt8VUjpcvFakEhAl/kbe8HYFT676LrxIEsyfEbixukihfd/3K/xX25zpr7qAadBEjQmL9Ht9XzRLWfef0lvjpoSIn1+mPMHnBeyveD0z44S8uooqPBwBmeH0f5d+je/KA2snoYrGBNuMKxLSFd1ayW6Ikfg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832416; c=relaxed/simple;
	bh=0CrljcqtVRzZTI/jVqVbhsiGLm3381fO4G1A1hbmfXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtR68Dcu3KVla3tRRVXY7we1quWHQlQfYseDBsbWFCJx/fZc/RstzPUzGbs6NXRVLYtnhyljUpPHzYe92T/Czhb3csthSVoRVlrYPAkhHHuO6AthksYOzip2NXDa/P24UCh7w0zQ1eyDiGKm13b2dsMuouETNgFicclS2p21O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTx2qmCs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so9860a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707832413; x=1708437213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrO+YnIFkgF9NlE+LQjUHlXp7lm2XiC2sB4ipd7NOWk=;
        b=dTx2qmCsLSf0M1KI7amDvug6UH6AyHvThDt8C/UsnKRrcnJRq059Xpctg3OAZpISIq
         qNCjry4MBeorVIN/LTWT8+oMwUyG9498oh8R/1A7SYKCs25hkf61XKLQLRuE7zvJMiV3
         +v/689VTrWZQntD47ahp9yAL6rJiJkHy0usEXR/aySu3FglHnnj+oezY3J4ZuGjP/7OG
         9a+RwSSbt8mehCLA5v8rPcx/GraT+fdGg4ZAhSDtLviWFC3CrM14bC5HLqXnph5OCAHH
         XaFT5pxRCR7o+W6/iUxdGi9Z+9PrHoWOLxVl3GhssSNhLA4A2kOJYkdxU6oLfw07iHZB
         7ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832413; x=1708437213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrO+YnIFkgF9NlE+LQjUHlXp7lm2XiC2sB4ipd7NOWk=;
        b=qnMXThP4vANjUcDMX9tS9L54YdHFexmetZ6XRL29TY5R9m4CS11EwmCcyT1LMriAxv
         eQG8pG7kC3nGvdcs/zD0El+yKR3q+35CGjEKwlMmDwj6diF2Ze64s3iTPiDG6wLg4a7c
         +klfUGqy/NC1YTPniv2WVkb4RXnO9l1VOGwEaBiGPBWCA1OzCRUxZr4JlX1TaHrTAm3W
         IFONdNEHub/ivhPsIUDtvFwNmNDtUW1inkvdRtfhUCV7fQGsBCPBXgapHgu4DgZfV+F5
         lbGHQZXdG7M1NJfhVVtRY5nQ4fOSYkOt3zOa3qSHtPgbqJqjO5xcTGlr9Et3KpsXhFGw
         uZ+Q==
X-Gm-Message-State: AOJu0YxyJaX2Ox1++70WtuvEDWZnfffGi5ii23xtQEb6VcqXB/F5y1cR
	BXqivDUzVGRNVJUl9WuBh0U5b8f+/ZNU6ucEiGLZuOUPL3t9eUwviBqVIkfai2m/gl/1XqumDWW
	gwCYkda5h/xbqgvAwXcrrpjP5EAaFd/x1zwow
X-Google-Smtp-Source: AGHT+IFKY3jo65VhnQiMfVWV0uM4XplODINoQHv6hAf3ndYpdQYiHvmdZHI0JKaxgxKpfmHxPRgqIfnyylqT/CQ2qec=
X-Received: by 2002:a50:ab5c:0:b0:560:f37e:2d5d with SMTP id
 t28-20020a50ab5c000000b00560f37e2d5dmr114638edc.5.1707832413081; Tue, 13 Feb
 2024 05:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
In-Reply-To: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 14:53:19 +0100
Message-ID: <CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com>
Subject: Re: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:42=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
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
>
> v2: remove in_hardirq()
>
>  net/core/skbuff.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9b790994da0c..f32f358ef1d8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6947,6 +6947,20 @@ void __skb_ext_put(struct skb_ext *ext)
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
> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);

I am trying to understand why we use false instead of true here ?
Or if you prefer:
local_bh_disable();
__napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
local_bh_enable();


> +       napi_skb_cache_put(skb);
> +       local_bh_enable();
> +}
> +
>  /**
>   * skb_attempt_defer_free - queue skb for remote freeing
>   * @skb: buffer
> @@ -6965,7 +6979,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>         if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
>             !cpu_online(cpu) ||
>             cpu =3D=3D raw_smp_processor_id()) {
> -nodefer:       __kfree_skb(skb);
> +nodefer:       kfree_skb_napi_cache(skb);
>                 return;
>         }
>
> --
> 2.43.0
>

