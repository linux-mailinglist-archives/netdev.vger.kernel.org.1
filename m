Return-Path: <netdev+bounces-199450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194FAE059C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE1E17D31E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4ED252912;
	Thu, 19 Jun 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlBKSp4w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33224339D
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335790; cv=none; b=UCBCqvtAtsiEGFWMmz9mvafq/ZW18v/bB9abLchMQ0A68gkOHU1RrkPliXmCxXtTw2+DWehGAGJE56PhKxIVT9kywcaDt20kQiFBJrtavqJFgjHFdIgKnuHOZZQ3nYBsDS02c48iMJZQtdrz/il7YMmM40LPmyrjYuTpE5e95dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335790; c=relaxed/simple;
	bh=MIKtY0BvtPRI4kc9quUsIW7X5PfhYEFyxPZ0dKgQPX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPW7Lzhq9cpH8sNXWNI1bsZ+cpxHwRnID94PguOk/o41AAtF/m3NbhBGoKIuHRBHGmbru8Jh1LjLKXjd6Smxazcy5upEpZf9V6GWRrCmsYbKiGuNxz02MeWLUcVWP9lLiS814KAPFAVXMD5RRx6LLuFH+JQfexSAAHTdC92TANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlBKSp4w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750335787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KpYzqUd7ABNQiXSwViTJe4TJ5xM7gccbgQGODhfMxA=;
	b=SlBKSp4wrNUTe5eeTS9eRuBzpRhkfD9/YMEDp0LhjKz45T/KzsceAVuLg/wnkrbMxhhrKW
	u+3A91//9jd5KHqISLkNRKCupc1XtJM5D3a8hl9/cSCjRMPkrGFpbVz2rljyBSRUOUeAL2
	XBnyALmiMElIrd9pIEh1V+PabCKrKj4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-lKz8PBCgPra4gGsie5e3ig-1; Thu, 19 Jun 2025 08:23:04 -0400
X-MC-Unique: lKz8PBCgPra4gGsie5e3ig-1
X-Mimecast-MFC-AGG-ID: lKz8PBCgPra4gGsie5e3ig_1750335783
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade6db50b9cso67903166b.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335783; x=1750940583;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KpYzqUd7ABNQiXSwViTJe4TJ5xM7gccbgQGODhfMxA=;
        b=lT6IIfHcz8CevUn4kaE4bf/nudLFNOSqWtpPLgIE3rnIjpZJIpK8iDIXBrXzmdOBbM
         0B5IZvndTfB8XGZKWp0UQe1D2kZZUYPbv85xovpWF22/qc9VJn/qL7SmLWeSvgjwsDoV
         8K8sEznI5XSsdmKmRKPesez+uBleocwFSFExy00kafiFlzRZOE/i40N6lbbS38EphGor
         2l62Aw52iO912pr0UB4/zMicpndnhyB8Ev9S86Ww7rIjsvyYnr/8clGCrD+9iBEHq4u2
         xPJ3fr4r2wN5vO2hqk9T/Vsbh60yNL2Bugirk8mp2sWZKmdisfcsS+nfI9U30y23pRHG
         Q5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdALjWwI65cw77XIVJvgk7a7qY+cHcT/rbDlG8qHSNhLAfwDWH2uMDEpaKMIywweKLVzi/mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+m/UakGYcZRGJP01ylceDO3mdrpBa4U0N490ndd2eLbS0crnC
	dvrrdmNUf2DQH3dbbhjQ3HCcq6MIanMHPwKDZAd2TE119NJgKDFbEZQWK+T+ZFwELR8YNv4GHit
	Os9dNGLOjCCtxQGcd3Yt24bFZ903UL6cOlNomqi1w5tyiJH5Xf29N86SlRw==
X-Gm-Gg: ASbGnctHyxvjICnerLBYCO4BDa03snwqbI5996PgzZS35uUzHpbom6bVurgqa6n2Bdf
	PZply+dFCT20YAkk8Ijc6phr03bukaNYje0+FZByUUMCUGEaS6YIjU9mS4MB+zD/YmyKVNQBALK
	pb5r28hfJfpCPAY8vhjy4mx6bxPn6M3DavrLaNpOtwi5FWMnIDmuCCCm1zjLNF1ZIgACLk9urJa
	YOePM009Mnr/dQNys6ssL8p9+aLMYJj71g4KSh9LVk4OU9oJ1KT+CyUffQNt+N6tPLRh7Ikm6jG
	k1egwAEiQLg5eVhqBg4=
X-Received: by 2002:a17:907:6088:b0:ad5:5302:4023 with SMTP id a640c23a62f3a-adfad5a09f1mr1950021266b.44.1750335783141;
        Thu, 19 Jun 2025 05:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdUZpMZoEiEL3xKFyHM/vo4NfGyuSlw67YC11LIaoKw4eni2OhhMoNfujt2lmufd+7RzEBsw==
X-Received: by 2002:a17:907:6088:b0:ad5:5302:4023 with SMTP id a640c23a62f3a-adfad5a09f1mr1950017166b.44.1750335782611;
        Thu, 19 Jun 2025 05:23:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf60967c9csm1104353166b.33.2025.06.19.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:23:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0EBC01B3727C; Thu, 19 Jun 2025 14:23:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Willem Ferguson
 <wferguson@cloudflare.com>, Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: Performance impact of disabling VLAN offload [was: Re: [PATCH
 bpf-next V1 7/7] net: xdp: update documentation for xdp-rx-metadata.rst]
In-Reply-To: <cd4f2982-00ff-4e7b-88e1-6f6697da2c2f@kernel.org>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk> <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch> <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch> <aFBI6msJQn4-LZsH@lore-desk>
 <87h60e4meo.fsf@toke.dk> <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
 <875xgu4d6a.fsf@toke.dk> <cd4f2982-00ff-4e7b-88e1-6f6697da2c2f@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 19 Jun 2025 14:23:01 +0200
Message-ID: <87cyazc44a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 17/06/2025 17.10, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Later we will look at using the vlan tag. Today we have disabled HW
>>> vlan-offloading, because XDP originally didn't support accessing HW vlan
>>> tags.
>>=20
>> Side note (with changed subject to disambiguate): Do you have any data
>> on the performance impact of disabling VLAN offload that you can share?
>> I've been sort of wondering whether saving those couple of bytes has any
>> measurable impact on real workloads (where you end up looking at the
>> headers anyway, so saving the cache miss doesn't matter so much)?
>>=20
>
> Our production setup have two different VLAN IDs, one for INTERNAL-ID
> and one for EXTERNAL-ID (Internet) traffic.  On (many) servers this is
> on the same physical net_device.
>
> Our Unimog XDP load-balancer *only* handles EXTERNAL-ID.  Thus, the very
> first thing Unimog does is checking the VLAN ID.  If this doesn't match
> EXTERNAL-ID it returns XDP_PASS.  This is the first time packet data
> area is read which (due to our AMD-CPUs) will be a cache-miss.
>
> If this were INTERNAL-ID then we have caused a cache-miss earlier than
> needed.  The NIC driver have already started a net_prefetch.  Thus, if
> we can return XDP_PASS without touching packet data, then we can
> (latency) hide part of the cache-miss (behind SKB-zero-ing). (We could
> also CPUMAP redirect the INTERNAL-ID to a remote CPU for further gains).
>   Using the kfunc (bpf_xdp_metadata_rx_vlan_tag[1]) for reading VLAN ID
> doesn't touch/read packet data.
>
> I hope this makes it clear why reading the HW offloaded VLAN tag from
> the RX-descriptor is a performance benefit?

Right, I can certainly see the argument, but I was hoping you'd have
some data to quantify exactly how much of a difference this makes? :)

Also, I guess this XDP-based early demux is a bit special as far as this
use case is concerned? For regular net-stack usage of the VLAN field,
we'll already have touched the packet data while building the skb; so
the difference will be less, as it shouldn't be a cache miss. Which
doesn't invalidate your use case, of course, it just makes it different...

-Toke


