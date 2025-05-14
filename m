Return-Path: <netdev+bounces-190324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B3AB63D8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA63D4A468E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AD203706;
	Wed, 14 May 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaDtT3UC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626E1DB363
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206773; cv=none; b=tFXNMIJyx5kec7WxyNRiI7I7UnixB28Yl64A7YppdUwdxtta6fWO8i8Ek463WMF10s9KRgq0urwHGso1wk55c+PaDGrOxJQgIqvEFTTeuDY/2v6mZ7XNtBeozCI9H3ts56iUXh+ZEjjYjNDGqau5mrFWCSFjPYW8QNjd47A/Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206773; c=relaxed/simple;
	bh=seP4BbTFLOdZQv+ePaPkiK3ztl86jsTZu2vwskGm1Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deVx1x+kfOnYYhOSSckcVRk6shVKvHbOWeVSnrRl8zYz3082uvjgja7vv8CpUnqba4Ykfhq4GafXC1jsn5FYhSZbLnrXCqqtIAwrzAONEOyR3JM4DkHRkks5EmgGci4tRF4L197QeLtzzSa/hvPM6wu3hLP8ZocDoROWUsOKfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JaDtT3UC; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da785e3f90so38326685ab.2
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747206771; x=1747811571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjMFQzsW8Gry9Hq92/gFT0YkS+5JWAyK+/6Z+2QWQ+Y=;
        b=JaDtT3UCV2lvv74pnlJbHSzk9EobFiyYrlKmzf4D1SeIRawR1iLtDY6GGfPHMLu0dT
         33nXprR+iahJdZnI8EtupbzpsT8tLVwewzSf+VhdTOAhS0ygEgc7zc4ww15JvqIeVKE6
         E0IzES8y6lZldMO7HsfTRRwyrQw+CzPIp7WKMPqRlxch165/o3v6oE0eH11BY+QsJyE1
         xIHdgP4Jkfbbvq2no2jvhbnnk7zAxNtkbI+sadp/TPhZeRZpSDh0SBWEYDqjHLmK1OX+
         z9hWA9TBgvLBmjc3A/P35TP093le6hLg0kgo0xolFfSVI85+t8gF1T4aL6n9Qy/GRwGY
         VjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747206771; x=1747811571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjMFQzsW8Gry9Hq92/gFT0YkS+5JWAyK+/6Z+2QWQ+Y=;
        b=q3vqsX7BC39rHeYZM+IMvsR889oOsjD2yfMiNEN3VLtcLB0mz/n1n7Wtmu8nksPKXU
         uQD7mEmUnCjfkoKuDZoZIQz4bN/25pqXMcueZ+3r/6UgQPdd8oYYLPL97rA42ieaUYSq
         rJf7EyoL1hcaaUsaCbPAzgrwX3cMyA3bGYW/UtCpffIwNmf8mW5ZQ1g3IzgvR222PvEM
         uexoHRtKaTlKwIbgM0vvLqnglH8Pl4zok+vvu2O6W8o6D3wVNTwv1p6lnvglE6Tnf50O
         s8rOsgCW+09HJ7P4K/9Bp51S531Ati4rTcvZDr307J3zx47qJeQSmT3auD8af8wkSjri
         akmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVODRsk+yAzoRRXofIncRGMd8vSTlXPx88CvcdLH/4nKdsm2PLhpCebkHu4TNaCurLHfAlFIZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELtubzYdAwvR2slUqlBVx4QNNKvJLIcXw3RI5PXo6MBBXX5mX
	h6njC7EYqK90Jk6c8JQqB6lqYrxYG89RQ4QDLy6d5qdyz3ytAa25L5o9ZCERqserOMrqf+yN76p
	DqPYcDmzhicoH/GIjbzR2pBzNNVkjK/YKKXKtTn2XFscAZY40AFre
X-Gm-Gg: ASbGncsAQ6xMz5cPQIPWoLA+6boUsJG22WiKBeg30PiINQqOLm6ego/ObZXz3Mz1yOj
	COoYbYXm4GTGq/O0UuDTqUpYM7vO3rpOBdXgxlernFkWgb5OK8EbhWT6xAo0Lyu/CmJA/EaJmgf
	kKDDFhrb69Gq4lGF8McgEg6eCJhU2YHujq
X-Google-Smtp-Source: AGHT+IFpTFiInpVx/XhpGCCn5yY4ZScNu3ZrSvJalOE7xq7jKxhSLbKDTdApVZNOfqKZdtuFzFUgtfEd2C/uPJWfPqw=
X-Received: by 2002:a05:622a:4c13:b0:494:7976:348e with SMTP id
 d75a77b69052e-49495c64b96mr41372841cf.1.1747206759735; Wed, 14 May 2025
 00:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
In-Reply-To: <20250430085741.5108-2-aaptel@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 May 2025 00:12:28 -0700
X-Gm-Features: AX0GCFsuKEnHR04FTvqSAVZ08Xj_h-2AZjziHyzDpVs1MANsenOZbg87rqhebn8
Message-ID: <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 1:58=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> =
wrote:
>
> From: Boris Pismenny <borisp@nvidia.com>
>
> This commit introduces direct data placement (DDP) offload for TCP.
>
> The motivation is saving compute resources/cycles that are spent
> to copy data from SKBs to the block layer buffers and CRC
> calculation/verification for received PDUs (Protocol Data Units).
>
> The DDP capability is accompanied by new net_device operations that
> configure hardware contexts.
>
> There is a context per socket, and a context per DDP operation.
> Additionally, a resynchronization routine is used to assist
> hardware handle TCP OOO, and continue the offload. Furthermore,
> we let the offloading driver advertise what is the max hw
> sectors/segments.
>
> The interface includes the following net-device ddp operations:
>
>  1. sk_add - add offload for the queue represented by socket+config pair
>  2. sk_del - remove the offload for the socket/queue
>  3. ddp_setup - request copy offload for buffers associated with an IO
>  4. ddp_teardown - release offload resources for that IO
>  5. limits - query NIC driver for quirks and limitations (e.g.
>              max number of scatter gather entries per IO)
>  6. set_caps - request ULP DDP capabilities enablement
>  7. get_caps - request current ULP DDP capabilities
>  8. get_stats - query NIC driver for ULP DDP stats
>
> Using this interface, the NIC hardware will scatter TCP payload
> directly to the BIO pages according to the command_id.
>
> To maintain the correctness of the network stack, the driver is
> expected to construct SKBs that point to the BIO pages.
>
> The SKB passed to the network stack from the driver represents
> data as it is on the wire, while it is pointing directly to data
> in destination buffers.
>
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->no_condense bit.
> In addition, the skb->ulp_crc will be used by the upper layers to
> determine if CRC re-calculation is required. The two separated skb
> indications are needed to avoid false positives GRO flushing events.
>
> Follow-up patches will use this interface for DDP in NVMe-TCP.
>
> Capability bits stored in net_device allow drivers to report which
> ULP DDP capabilities a device supports. Control over these
> capabilities will be exposed to userspace in later patches.
>
>
>

>  /**
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index beb084ee4f4d..38b800f2593d 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -851,6 +851,8 @@ enum skb_tstamp_type {
>   *     @slow_gro: state present at GRO time, slower prepare step require=
d
>   *     @tstamp_type: When set, skb->tstamp has the
>   *             delivery_time clock base of skb->tstamp.
> + *     @no_condense: When set, don't condense fragments (DDP offloaded)
> + *     @ulp_crc: CRC offloaded
>   *     @napi_id: id of the NAPI struct this skb came from
>   *     @sender_cpu: (aka @napi_id) source CPU in XPS
>   *     @alloc_cpu: CPU which did the skb allocation.
> @@ -1028,6 +1030,10 @@ struct sk_buff {
>         __u8                    csum_not_inet:1;
>  #endif
>         __u8                    unreadable:1;
> +#ifdef CONFIG_ULP_DDP
> +       __u8                    no_condense:1;
> +       __u8                    ulp_crc:1;
> +#endif

Sorry for the late review.

I do not think you need a precious bit for no_condense feature.

After all, the driver knows it deals with DDP, and can make sure to
place the headers right before skb_shinfo() so that skb_tailroom() is
zero.


If you really must prevent any pull from a page frag to skb->head
(preventing skb->head realloc), skb->unreadable should work just fine
?

