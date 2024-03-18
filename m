Return-Path: <netdev+bounces-80345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101887E6EC
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAF2B222E5
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77A2E642;
	Mon, 18 Mar 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATBHDrAW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F7376E9
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756680; cv=none; b=DwX06O8UDiGT2/xH147xrhA8sUxyMRGLzzcu3Not9Wp3fK6J1sxFBDEvCYXcjuZZQj4r+34cY+SOJngBNH2PX1zV6yrbxj1GaUUnvzxgBEoP2CP18T9OjTUVTIomisbP0JTr+JIDS5hKPf2RbiQgg+AKCHY9HL0eklQ4aGUQ2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756680; c=relaxed/simple;
	bh=G2/1V1K1llxFU38QoyxRH9roq7vlvVLR3LWCUrIoaHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCjeFNiwC3my36tAHkbqNi4cg9h6BXCZ5Fvbpm91n1i6EeHFvjnQc63zzh4pHlibPt7FtPx+/MOWrGyRrGeSeXWriTnpabfCY4Mq8zBRr4eT8m/V7/lQ6DCWDRgdU5hbKA6ubRz7ywaj4Qr9GDFfN+YNsEwlTnIkY9RnTxBYd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATBHDrAW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-568d160155aso6334a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710756677; x=1711361477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VVS/NCiX+LMvmyBvaZjmhHPEe0k29kjMeWXN2mA/uU=;
        b=ATBHDrAWM1FBgjzYocNwnfxwuyhjBWyiyChk5P3v6O1v8ViYTt/DjR4S3nG9SjhlQ8
         3SyF56WT4h/VSgiqtG07xmdUH0L1/dc0I7L8QrfN5WOfOXFQ/OnbmefBzZCNVph0zM4+
         uYWQt0MNNhz4rWznKPzwzffwWBtja98cVYxlSxKZnB3JZJYWyqJRLjqslZomJQk8fHGJ
         8RTdSMlENsSr/+UxEFqUvf1DypZBSF+QT9iFayK601geRU3HfyijH8IB7DhFkJpLq8te
         Zt3ViqjT+0XKkIWQEEYHj3mEbYCC7VBj5bqcBWPspuR0ELJ6dJb9P6VMqbwpFbXf8EAW
         Z+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756677; x=1711361477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VVS/NCiX+LMvmyBvaZjmhHPEe0k29kjMeWXN2mA/uU=;
        b=hZ53fuE8nOvGdLnTEtsdk8RkrBHggMqc1wUADVnQ3SP4C9HMkpF2mkwdMZEO/pT3Tf
         sdGkNtqXB+xpcC+s/acXe1il6Vn2OVZDnEyeK3kbg/wFzeFu30GPjWPzH39DBoMsC3UX
         wQj88oYbFIOeQGIBm7nygWUZXsOHO2dJx1zIO7fIc2vbsu1CCDNsXPjI87oNpOF2bmul
         ywWqH01cnJqdqcz5EzjPsn3iwarDze6/QS6pg2RjmMMcCYbkpef3BdchEihvrirQ9vpq
         6WHN8kfcvCqAGsTnVXwX6wiPIrNqpqbMPkitLHMfT11/zfma3UwcTYnEWhdrNPnqMh+A
         kSeA==
X-Gm-Message-State: AOJu0YyCSazbl+47CKKLlIfhsJMiJVtB9moAoZ6lM/OAaGhOmONKnUm7
	VJBlvpHprMn3p/ug3vWZgcKeiYDtoXMEidhIZU66dALXWLeDaCe22rAgUxpgGPvSPToG2c2nGIR
	GKxtVUVQbF2fGL1lw8fIdJWozlIuP79BMKsKh
X-Google-Smtp-Source: AGHT+IG3ezx7TDBWhcYaPR5FK4/3UHn6cYSbbcE849Eyv0P6FUuc9qhQzcFO6HFMgPN1i3VHUznvJAy1N+5wBmZMUCI=
X-Received: by 2002:aa7:c1c9:0:b0:568:cef7:fe5e with SMTP id
 d9-20020aa7c1c9000000b00568cef7fe5emr140441edp.6.1710756676612; Mon, 18 Mar
 2024 03:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
In-Reply-To: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 11:11:05 +0100
Message-ID: <CANn89iLjH52pLPn5-eWqsgeX2AmwEFHJ9=M40fAvAA-MhJKFpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 1:46=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> disable softirqs and put the buffer into cpu local caches.
>
> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
> I'd expect the win doubled with rx only benchmarks, as the optimisation
> is for the receive path, but the test spends >55% of CPU doing writes.
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

1) net-next is currently closed.
2) No NUMA awareness. SLUB does not guarantee the sk_buff was on the
correct node.
3) Given that many skbs (like TCP ACK) are freed using __kfree_skb(),  I wo=
nder
why trying to cache the sk_buff in this particular path is needed.

Why not change __kfree_skb() instead ?

All these helpers are becoming a maze.

