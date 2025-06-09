Return-Path: <netdev+bounces-195607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BCBAD1690
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 03:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7FB18860C4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66664145348;
	Mon,  9 Jun 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHAZ3FaO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942B3A1DB
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749433786; cv=none; b=ahgawzOJBSewjrZRF1KuOGXDrdcnimv2GT4wSofHV7MFQyRkv+/uMTknLcLlzMcn1n6L27MTMgjdQGQYuDgxEIusD4RBndcp5704F7dtPbpiZ9OsaEPLDim839kTIcZlWHSGUjVfqy3oNnXYqEA9CNZFxic9Es+i34DM3JCajP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749433786; c=relaxed/simple;
	bh=KXhIOFrx3vWc3Fcq4T0jSCKHYqxF2bnPpsFgAZZjqbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYD79JKH3sLDHzGCWl/7Wy8yasWrm20PfmisTvtocjxompAaQzBAj+MITcmgqzNfsdR/qk6beR+WGRdl9wUjsmPHDiOdWLUIUe3tPoqrDM65YAzctdHwH0JMCHNHC8R6YCcTicCcPFZoLerc/vnK5H0G6NMgZmjbwj2RK5NTVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHAZ3FaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749433783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXhIOFrx3vWc3Fcq4T0jSCKHYqxF2bnPpsFgAZZjqbs=;
	b=HHAZ3FaOltYSWUxjK0PDteRwFz3g24G9YTk7k1uHh2HjZDeqFYQVrEH2+J71CkwZ6rdSfp
	VtlBuxD84eq9kIrh0BzTsN7NEfAu522NcXLAxDuaMwxyIpUC6cwL+AHCpdHvc1Vf1u1N38
	s36AfekDXcjUX1DS2ER+No9fspO7kCg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Rz5YLHSzO4Gl-OAEXVCOGg-1; Sun, 08 Jun 2025 21:49:42 -0400
X-MC-Unique: Rz5YLHSzO4Gl-OAEXVCOGg-1
X-Mimecast-MFC-AGG-ID: Rz5YLHSzO4Gl-OAEXVCOGg_1749433781
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-54d65701a94so1925256e87.0
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 18:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749433779; x=1750038579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXhIOFrx3vWc3Fcq4T0jSCKHYqxF2bnPpsFgAZZjqbs=;
        b=iOtpBGIPXansKUC5WIm1o/XW7gnT8JWWh+GdlaD0Ddo8UeRlEXOR+4kkV6iYiPMf3W
         t/GObS1KTZXK7IzYm7PmewpcQC141UlSZqsx8YDFn1RB85fquEOexXo7BuRvjdDSYFQq
         ZVA7kZhSYvfS2GULy1JYZ2AhoSUrcuV20As1I/j+1RrZFnpcS0MeUY6gPzbOfCcfQSgn
         38rqLyiCpTYsp7MeOEq4umfwhM/3JE0rcUfuAOs6EPLr7H7SZBJgdsjsyllz1o128ckH
         zgzDPy3rSh4B6W2jcI+FP3D28ZrQffH/iytdffjCww/5MUVCdq91UmXHk6yCZApsN2n7
         Y0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9LS3QtbxWeNQfFO6yfZCdPu/KCqpnNkvZ8si4WwyucxqcMZ1LlzPtrDIbb+b/Y5ttQJsdTc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/Ioo1nBhEhcchQiNxHDhwawG6q6zd00MPqVF9bMzoXfR5ZCv
	8E5sjYJLIxg/puP2U0g3JDCUdck0uE0SqZECPC9MZ+OQpk/4P6bEy9Y6q3D0YBZJE3lNaXK6Cgg
	8GKPO4j6fJU85lsmuOGOmcWRdrfgh1I4yqM9JNGQA0txvE5w0/HuQCp+BIwaV1KGTtpKdkXnX4/
	YyBt9YKzcfUr5V+bV2QQ8ZO8EexxD0rfFUer2HLCgrg3g=
X-Gm-Gg: ASbGncucB3duaJgxwyU+wXOKHkhbAPSvA8fCt9TGSMamcOMeGgm6WturjBPVX45sUgN
	43rIVUmTQjhkRGRUBnVmxvwxWHPTNbcEgt+jfW61shpxoRzfyw7hJ9LWzfFymWz4yAHwAQBOD/f
	pxZPMUfudI8iOjepWKJp4zdNXPgL2lYUEf1/9T/w==
X-Received: by 2002:a05:6512:3089:b0:545:8f0:e1a4 with SMTP id 2adb3069b0e04-55366c365fdmr2633619e87.45.1749433779515;
        Sun, 08 Jun 2025 18:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfNwt/Fdhee+MMgVrbbbGoawo+KdN6xrs4P3/qqKW5OdykwRxeZMMwEan4KykfI5EDnvSbPeiuEYxjNZr5/U8=
X-Received: by 2002:a05:6512:3089:b0:545:8f0:e1a4 with SMTP id
 2adb3069b0e04-55366c365fdmr2633613e87.45.1749433779096; Sun, 08 Jun 2025
 18:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com>
 <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
 <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com>
 <CAK-6q+iY02szz_EdxESDZDEaCfSjF0e3BTskZr1YWhXpei+qHg@mail.gmail.com> <CAK8U23brCSGZSVKZC=DcHMGKYPyG3SHOd9AoX0MdhbyfroTkWQ@mail.gmail.com>
In-Reply-To: <CAK8U23brCSGZSVKZC=DcHMGKYPyG3SHOd9AoX0MdhbyfroTkWQ@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 8 Jun 2025 21:49:28 -0400
X-Gm-Features: AX0GCFuZa3U1ri2yAkD3r0XY18bDGjMKa3k4OIzi1n49a0ZBB-bCif_XXkyW1qY
Message-ID: <CAK-6q+g-A4T4RBg_BiRxR+G2k0_=Ma9nPZ1y=H=-F2FYDCUTMw@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 7, 2025 at 5:00=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> > There is a generic way by using netem qdisc and using AF_PACKET
> without PACKET_QDISC_BYPASS, should do something like that.
> If you really want to do something else there or only act on 802.15.4
> fields and you hit the limitations of netem then this is something
> netem needs to be extended.
>
> Let=E2=80=99s say I=E2=80=99m quite familiar with netem - netem is indeed=
 well-known
> and has been used extensively with tc/ifb. However, it is primarily
> suited for 1-to-1 communication scenarios.
> In 1-to-n topologies, such as when node 0 communicates with both node
> 1 and node 2, it becomes unclear which peer should serve as the
> reference for applying delay, loss, or latency.

That's why there exist addresses.

> This limitation makes netem unsuitable for scenarios where
> link-specific behavior is required, such as in ad hoc networks.
> In such cases, a more precise per-link control - as provided by
> wmediumd - becomes necessary.
>

Teach netem to deal with addresses on a generic filter hook.
Maybe you can ask at batman project how they test things because they
use 80211 mesh functionality?

> > With that being said, however there are so few users of 802.15.4 in
> Linux and adding your specific stuff, I might add it if this helps you
> currently... but I think there are better ways to accomplish your use
> cases by using existing generic infrastructure and don't add handling
> for that into hwsim.
>
> Back in 2016, mac80211_hwsim had relatively few users. Today, I
> maintain a community of approximately 1,000 users worldwide who rely
> on mac80211_hwsim for their research - industry and academy.
> The need for a realistic experimental platform is not a personal
> requirement, but rather a broader gap in the ecosystem. Addressing
> this gap has the potential to significantly advance research on IEEE
> 802.15.4.
>
> > but I think there are better ways to accomplish your use
> cases by using existing generic infrastructure and don't add handling
> for that into hwsim.
>
> Honestly, based on my experience so far, there=E2=80=99s no better approa=
ch
> available. Well - there is one: integrating all the wmediumd
> functionality directly into the kernel module itself. But I fully
> agree - that would be both unrealistic and impractical.
>

I looked more closely at the patches and there are a lot of question
marks coming up, for example why there is virtio handling, when this
patch should not do anything with virtio?
Why do we introduce a second data structure to keep registered hwsim phys?
Why do we have a lot of wording of "wmediumd" when this is the
project/process part in user space?

- Alex


