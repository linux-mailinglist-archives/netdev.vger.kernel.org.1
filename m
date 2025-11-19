Return-Path: <netdev+bounces-240206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0257C7179F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 641E2349C95
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054331D387;
	Wed, 19 Nov 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpxv6RzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F3314A6D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596655; cv=none; b=rmH2xRa/Czx2veko9bDKnflwLlHt4k//BORdxAnHyCBevYseNMWNMrW3GL1XwtFwzDnSooJk4GKrtpEO+wfT88V2shmvSX7v+NBK8Jof0iQjTKUwAKGooH1N4IhnEyYQmMe0U4N/yxBAjkOxthIo3L5bjv8AzR3HgPgbpn62tzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596655; c=relaxed/simple;
	bh=X+yotTEys5yRDxkacfuPopJqNY+9dlo1oOL60QB//Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLWQxSy0it5gugMjdmrBCn075qaXl8lwaq1oEqBycdZvq3wM/TllbVo0bgak8SHT5pGV69vK2di7XmXcRqArYSbza+rT7UYz3ertz3aCiEFcHB+NWMAdd0kQnbJRhFjsR0Twu16rUhNI4kJYfImHk7YtAfCg9V3pWMDeRHIEFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpxv6RzK; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433100c59dcso1540725ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763596653; x=1764201453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFxaFEpPeplOjITNlqYLkvN1LDqICQYfB4lpiupHV7Q=;
        b=Gpxv6RzKsAtHuzmGIITK2NwgV8ueDNFhTU3+wYMhDxY/eVxhH4gI/Ob/1/Wdx2rcB4
         P09uPCiQ09yXlq7U8fzDW5e+zz1s7G0tP0h+62qNHIJv8SdkKrwlq1r94nvB6R3EJdIo
         jKmBXH0FWZ84u5rBY1PGE6y87rJYC0YxLOeE1LAiStxPtl1UW+RHQeb6yZpZbM5TO5KE
         t0y1b4nxCpOl8klcgvB8B5q7VXlHnP2sUhXUDDs+OAaSAPhLrzu7tahyeLZXZi7ZmHDY
         pgkdma7QlKAraUWywyzbhFkOX6f2xJRzj3UZiBjBzw5dqFDa5kCAccMRNKTqGFfyNf4q
         jnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763596653; x=1764201453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFxaFEpPeplOjITNlqYLkvN1LDqICQYfB4lpiupHV7Q=;
        b=UeWqT7gmwb7sbCtViHJueBVUHoC+iOkqSDlp4V4ARlG1HEKMMxwn3GsO7E1dxWK55U
         23ysMWmxFJ14xlqeGkepHhGFwtvF83iZzoqbg5nAwqM8rqrPQULcndNHYtIGGQGzrlVy
         537rQDFAPi/VVc3QiDto5GYdG03LUIraH2KOWtyZdFJ3pHXEPmvTN0W4NJOfys9o7ssm
         uW40smEo3IP1sT60enZjZcW2YUPUGBeoGc+xn9gibAH3+gBYKwcgR69VPpLaHvBSODm+
         BqCAs7wSovjaigOQyaNDHNjcLffhBHg1Lsgse6Tg0ULFvtgB1JY9tvVMtLjRHCXLsnO8
         OxfA==
X-Forwarded-Encrypted: i=1; AJvYcCVIznVMRNOqOACp2juv+DW1Snsq9ruOONoAPxFRw1KrWujESEL2gtuavHp8JgFka5XdFlzMlfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeT2OPtqiTbeKjSlJqRdA2McAEoYHbIVzF+rv5W5sB7mEqfxli
	gMpBUqe+mJdesaxjiZHlcPW9wwR1BbO1T168TQxzaJRxB9371HIA4R+KNoUDVYO9+mwWSkGSSP9
	yRyJYbk4wTrfQsPRmTNn+QYpciUDXs4w=
X-Gm-Gg: ASbGnctxvwPallKDAxIy229d5qpyo9GHsyjRW1JCXLErkSN5nzaaGH+wXqxFnFCQbJF
	nqRhKAM97EEtym2u0Fdr+fsVazrrnn4ucE7G4Msjh4lJg/OYqpyuqdxWMi0QZCuc9qD2XFaKR4I
	GyGVHxukae1vyLXpXK8/7NU+1zMcG95/rrBQFxkrEb+ryz7Tw+N2YU2OGEtMngNc2nsKE3JHbtV
	f2YNilOxMUYelqLJVR/r/VoExZg4fK7f/iwFvlQTr5WtMAjiB0qHGRdhHTTwl2nsuUhyuohKg==
X-Google-Smtp-Source: AGHT+IGh7c9q+LJ6vMOFrpvoKH4yCAdUk1osC0ZK5zXjaSw54i8mvdFA9V4aE55XnxPD+KAEcyQEo0E/e8qgycFJkzk=
X-Received: by 2002:a05:6e02:b24:b0:433:7b22:c2bd with SMTP id
 e9e14a558f8ab-435a901a69bmr16775825ab.2.1763596653299; Wed, 19 Nov 2025
 15:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118070646.61344-1-kerneljasonxing@gmail.com> <de4ce073-5df8-4d00-ab26-c42ce73a5f48@intel.com>
In-Reply-To: <de4ce073-5df8-4d00-ab26-c42ce73a5f48@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 07:56:57 +0800
X-Gm-Features: AWmQ_bm5Ixwo63ad2Xjf0Zq_Fhec5v0CDzzP5EUFE04XuHD5NRKo44hzJ5G6YiU
Message-ID: <CAL+tcoCyQm0QxAJkJCFzFZK1Q2Zz1v=zQZWcTzq7jY5Nu6QU3A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: adjust conservative values around napi
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:52=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue, 18 Nov 2025 15:06:42 +0800
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This series keeps at least 96 skbs per cpu and frees 32 skbs at one
> > time in conclusion. More initial discussions with Eric can be seen at
> > the link [1].
> >
> > [1]: https://lore.kernel.org/all/CAL+tcoBEEjO=3D-yvE7ZJ4sB2smVBzUht1gJN=
85CenJhOKV2nD7Q@mail.gmail.com/
> >
> > ---
> > Please note that the series is made on top of the recent series:
> > https://lore.kernel.org/all/20251116202717.1542829-1-edumazet@google.co=
m/
> >
> > Jason Xing (4):
> >   net: increase default NAPI_SKB_CACHE_SIZE to 128
> >   net: increase default NAPI_SKB_CACHE_BULK to 32
> >   net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
> >   net: prefetch the next skb in napi_skb_cache_get()
> >
> >  net/core/skbuff.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
>
> For the series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> BTW I picked these numbers of 64 (size), 16 (bulk), 32 (free) when I was
> working on 1G NICs/switches on a 32-bit MIPS board back in 2020. Lots of
> things have changed since then and even back then, these numbers could
> be suboptimal for faster NICs/architectures (and yes, the cache never
> was NUMA aware as the MIPS arch code doesn't support even building the
> kernel in the "NUMA simulation" mode).
>
> I remember clearly that the cache size of 64 was taken to match
> NAPI_POLL_WEIGHT.
> The size of bulk to allocate was conservative, but back then it gave the
> best perf numbers. I believe the bulk allocator has improved a lot for
> the past years (note that let's say cpumap still allocates only 8 skbs
> per bulk, not sure about veth).
>
> Anyway, lots of things around NAPI caches have changed since then,
> especially when it comes to how the kernel now tries to free the skb on
> the same CPU it was allocated on. So I'm glad to see these parameters
> tweaked.

Thanks for sharing the important background :) I believe along with
the fast development of NICs we still have many things to work on in
the kernel.

Thanks,
Jason

