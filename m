Return-Path: <netdev+bounces-122562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C78961B9C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59781F247C2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE542067;
	Wed, 28 Aug 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV2gQsyH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975D3BBEF
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809976; cv=none; b=d+nzrcMYkKLlbkuU2k25+X8c1wUIGeTH1piBnTrTO16XdzvnSEnNaU+/V8AtZ1xHsf1Q9L7Xx9bMSIN3KtyH0HsXjhdwbikuXAIICsZ8WUL+ikUig+/btn3zZYw0hI5WjNZUMth2PiCPL4hkzQBy9yPLZvN9817bx3F68SNWLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809976; c=relaxed/simple;
	bh=CRar9WZIfyaGhyQ5AaPWKz0Q/05MgwL6ZvuPnpv6hGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc5tcw8ZFB+PurGTwsYuR4gDBZUvzzPvGA1forYv6jiU9HI7q7j5lRJBjkxhrNn1s6wED1ri1aXV1LkklZdPI3pCTnPecSR3XuKORp6ociPEjUaW4Eehpx0gpxMOFDCVmDAGMiNDY5RFXR4ZqIc6BtkikQffPcriZU7znCkr1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KV2gQsyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724809973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWve6JE+0NypiSakiytBRnv/JlBTqmmXFs55kVgYTbU=;
	b=KV2gQsyHztuuMIxEV1Uc5N8wNpTTr9mZzAXQ/O3aZTqhAdiqVloWEU7VRNFi1+/X+oZ1+K
	lC51kFTnr3N/cyOHyxgYZtRm6soFHrApYI4Id5HcZYfqNyTryIbozo8//KUkTgdedAotgc
	85sNCv2XJG1eGQOW6Cska5E/bNTs4eY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-5A1wusGnNSqXJbBMEzB6bw-1; Tue, 27 Aug 2024 21:52:52 -0400
X-MC-Unique: 5A1wusGnNSqXJbBMEzB6bw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3c0088813so6319812a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724809971; x=1725414771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWve6JE+0NypiSakiytBRnv/JlBTqmmXFs55kVgYTbU=;
        b=rUAVHIvSsrGC/Bjhq9gPs95eW8wg6iNcHRZWSxU9Av2IbxJ3mEndGspPYRkd5lR2fc
         AWpVMBS6c23ELAFNwgT3EDdM2kZOJocQJ7o5SpeubTuViAWdtfXmz3vS1uarMAK0le2a
         ov7zrpMlI8KpDdJcwDY/iOHGHoIzc7RuK1lxx2qIua+K0bOZGFZeDIeISEW330aHkk1Z
         ES0hDDxaDk4SeoQKMYzKZlfUieBxX/5OJaj/oXlS2duFkXKB34HaENvRjtauk/VdkeHF
         rOEBmPpl30xSG6WCOtBs50h4SCwH8fBCYaaGzmPOJzQyx+dtQ+8DnZfhRQk6MA05TDfc
         /q5A==
X-Forwarded-Encrypted: i=1; AJvYcCX7IMKq25eapA74+DcWDxSiZdkY3lwgu4XepvgYb2Ah9iM2d5mSRgVzFvI7xGhM9xdlogzaaBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN59vY4bWLCYVhwHRKStF6VjR3YezOFYUpuIen+F73h5m07aNY
	/hcmWPLyAsYhmXJLApFXkHT5FTlDI0DSmcgzR+puF0mgHcwff1280z8pbh2homjG/2l7WmiqXdd
	7iYkY2CQtjGI1L0BcytOowvnGTCrz+vrsVgaBcus3Knb82vxSwRZkncMpBfD6q18F+4/e10tjCG
	P5Af7ek7zrV/lDHhMTeLVKb5HbCsYn
X-Received: by 2002:a17:90a:ea98:b0:2d3:cb10:ca20 with SMTP id 98e67ed59e1d1-2d8441dd433mr574480a91.42.1724809971168;
        Tue, 27 Aug 2024 18:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2WaxTQnck0F64/2Byf20IaMxKhRaCFgCZwbA5SnsjM2N5t2pQkjRTImPTJ5eVtBvKRqTzoXEmmHP+0WAM8Is=
X-Received: by 2002:a17:90a:ea98:b0:2d3:cb10:ca20 with SMTP id
 98e67ed59e1d1-2d8441dd433mr574455a91.42.1724809970678; Tue, 27 Aug 2024
 18:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com> <fd8ad1d9-81a0-4155-abf5-627ef08afa9e@lunn.ch>
 <24dbecec-d114-4150-87df-33dfbacaec54@nvidia.com> <CACGkMEsKSUs77biUTF14vENM+AfrLUOHMVe4nitd9CQ-obXuCA@mail.gmail.com>
 <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
In-Reply-To: <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Aug 2024 09:52:39 +0800
Message-ID: <CACGkMEvUeHTKu8+=sPLz-ddr3xb7dD29bwNex=xvyRdK1gBrgw@mail.gmail.com>
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Carlos Bilbao <cbilbao@digitalocean.com>, mst@redhat.com, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:55=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
>
>
> On 27.08.24 04:03, Jason Wang wrote:
> > On Tue, Aug 27, 2024 at 12:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> >>
> >>
> >> On 26.08.24 16:24, Andrew Lunn wrote:
> >>> On Mon, Aug 26, 2024 at 11:06:09AM +0200, Dragos Tatulea wrote:
> >>>>
> >>>>
> >>>> On 23.08.24 18:54, Carlos Bilbao wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
> >>>>> configuration, I noticed that it's running in half duplex mode:
> >>>>>
> >>>>> Configuration data (24 bytes):
> >>>>>   MAC address: (Mac address)
> >>>>>   Status: 0x0001
> >>>>>   Max virtqueue pairs: 8
> >>>>>   MTU: 1500
> >>>>>   Speed: 0 Mb
> >>>>>   Duplex: Half Duplex
> >>>>>   RSS max key size: 0
> >>>>>   RSS max indirection table length: 0
> >>>>>   Supported hash types: 0x00000000
> >>>>>
> >>>>> I believe this might be contributing to the underperformance of vDP=
A.
> >>>> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SP=
EED_DUPLEX
> >>>> feature which reports speed and duplex. You can check the state on t=
he
> >>>> PF.
> >>>
> >>> Then it should probably report DUPLEX_UNKNOWN.
> >>>
> >>> The speed of 0 also suggests SPEED_UNKNOWN is not being returned. So
> >>> this just looks buggy in general.
> >>>
> >> The virtio spec doesn't mention what those values should be when
> >> VIRTIO_NET_F_SPEED_DUPLEX is not supported.
> >>
> >> Jason, should vdpa_dev_net_config_fill() initialize the speed/duplex
> >> fields to SPEED/DUPLEX_UNKNOWN instead of 0?
> >
> > Spec said
> >
> > """
> > The following two fields, speed and duplex, only exist if
> > VIRTIO_NET_F_SPEED_DUPLEX is set.
> > """
> >
> > So my understanding is that it is undefined behaviour, and those
> > fields seems useless before feature negotiation. For safety, it might
> > be better to initialize them as UNKOWN.
> >
> After a closer look my statement doesn't make sense: the device will copy
> the virtio_net_config bytes on top.
>
> The solution is to initialize these fields to UNKNOWN in the driver. Will=
 send
> a patch to fix this.
>

For "driver", I guess you meant virtio-net?

Thanks

> Thanks,
> Dragos
>


