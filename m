Return-Path: <netdev+bounces-237854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D99C50E60
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A20BE4EDE8C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C22C0264;
	Wed, 12 Nov 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMVuL/zZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="McaKno0A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB12BF016
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931899; cv=none; b=G0PaTmRO+hDr/sqJaZEJ7EibFyWoySYCwS1AA3hSmHupBftblLhbXi1771WV5fyObA4e+zzp9tJSh4gtR00MSxQjHaq0Co5MjF01VNX7e3/l+kW2BvTXDgybden39pXdPhR3nP89IC5FqHEiCd/ORbmkICIViRfl9zSwxoROykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931899; c=relaxed/simple;
	bh=l+NV0k7Bp/+YgOf/+PvP9J8DW53va6OQMtA4SQp1YmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN9f61WJNIB7hKP9p8fHXwEUsVp8Slr3qXkBeyFAVqatQs7sBSeufAGZqhXL6s00rHh2HqEzaVTqQ08/3f8ckjEi95nhVmaphQGAqfcH2PaPax/nurcHiKxOodAdPORFTVYo/pJoDYfBb48neqmmFZNphNcgPY16uDV1xKquQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMVuL/zZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=McaKno0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762931896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OQTWc8k6eLNIl1r2U6IKGTRX88Qf57rZqkALXWLQcE=;
	b=GMVuL/zZYJhzTG+dMGxiZzpm6+GOSCSuDbFzIwEnOepnihS3g3iIaoJlHtS1W+uTd2f1jK
	mUt6BDmprt/5hUgNcS30I6z7WI8DNCmu2Bq9GWrAxSDuHPnoGjSYc2lW4LfgqCu9Ji4L4J
	JRgloz7XdMvcNf1pr8EtE/5K4mBKhGA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--4eTCGcUN4esBgK3Vt-dQg-1; Wed, 12 Nov 2025 02:18:15 -0500
X-MC-Unique: -4eTCGcUN4esBgK3Vt-dQg-1
X-Mimecast-MFC-AGG-ID: -4eTCGcUN4esBgK3Vt-dQg_1762931894
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so451606a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 23:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762931894; x=1763536694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OQTWc8k6eLNIl1r2U6IKGTRX88Qf57rZqkALXWLQcE=;
        b=McaKno0AxqBSMDRaZ1E0wtgioE7Ao4+c+LQO9zbl3UJrV2OUpPwRCOcPK712sSU0MA
         I9FGJHo5yMVhTRp5aF9LhyVYVZbG8mEOg8r62TdDIA9iAyO4S69rrvmjQBe/3/VztSYL
         2v593YFMTtZVfmwfTvy0Kbwb1na9OEkLY9PCM1AgP9z5tHF4FL59KEx2epu7wjt+cLE8
         qPzkkwFsDXxYaM5gMiNPW01Pztmsxp5/eEqTMZFdbWHtVxVjPos1dLq22t84qsxPlckc
         pZD4uTwT87gpsTPOgWTgo6tm6lc18PugpNoaTIQxKQNoWjzdMa7PoDF6Vx6ua1NzhY+J
         orFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931894; x=1763536694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OQTWc8k6eLNIl1r2U6IKGTRX88Qf57rZqkALXWLQcE=;
        b=I7qdZzQJyq5RJKW1Z92lSFj70rOEuLAae/nI4OdzT4UuW1uE8FF5Si1F2LiHVjEmsc
         cu9aLBc5ds/5H7vD6iNyVon+YTvAiFyHzhDMPFg78TuvRyMp52Fk5z01CUhgZ53Dv+to
         KKdRFeZ4vaE+1GNfqz8wwKRK/jyRdtYhFJJh7fSZdkg7TMYdltx1Q39MLQCfNVgf65RF
         TKQhMzbbKwALGqv46uMfPBHXmPAPzKeKSDlE/oAp5lplUNaSR8d6PKaoY3HIepz5V9Uk
         EjUKJRlp34eXi+IlfPpzRKASiHmS8gKULzkgXkNyRNeCYyKa0x93Z8fh6tbO/r+y9Iow
         s+mw==
X-Forwarded-Encrypted: i=1; AJvYcCXmMy9VuxEkJd75nCextKjZMt7yAYgi2VJOkG/FospCZQ4ocLIUtYlkIoNEGL7EryxAVjpr3iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCoH0LF+FUGDLiNCVhlCwf3JoU4P0uorxK42B9cDsuMUvcHDPA
	uPLCxkgwxxe4fb5k2pH0oNdSPPA5fkD0R3SnIRSZxWPrJWpAC3st1hOEPsb9ORppo9vBCBEHuff
	6K13DoN5IuG18QkU/mxyL1lq5dkqpT0I85IDTN9GDo4xK/hFcVxX4fK9xObmBxwfpJz7tKI9wkB
	0wSiBxqFZAl7eFANc3/FkSBOjd+5N/RpAM
X-Gm-Gg: ASbGncsySyna3wVoAiHg6kEp3YDtITr8Ap87ngZumzSo3AiYUVhe9FrQsT1vPjztucv
	zjOwczX5tx3EC26DA7S6QeH/vzZPlkfXO5++sIT43SNUf9dLEjprKxWJ/U49HSAnEFsa8wQIRyR
	76ew/oEN2KDJE4YgyvmMuLqrnIZqzvxsXd3/NqEAeyT/XTOqmAIdPtvCQV
X-Received: by 2002:a17:90a:ec8b:b0:340:e103:bfd4 with SMTP id 98e67ed59e1d1-343dddf5290mr2457737a91.2.1762931893997;
        Tue, 11 Nov 2025 23:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiyTtRY6Si4zXAKOZru7EoKpBQTUibKUV8Jrm0qaneiJMYyuUjN+SN/kgXL/nz1Zlqo7mpRrDD+OqPMOc61qU=
X-Received: by 2002:a17:90a:ec8b:b0:340:e103:bfd4 with SMTP id
 98e67ed59e1d1-343dddf5290mr2457700a91.2.1762931893477; Tue, 11 Nov 2025
 23:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041523.1928-1-danielj@nvidia.com> <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com> <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
 <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com> <CACGkMEtMP2XfXFmuhoAkMrcgJD8JiRTc-tuq1i7xxxzA43A4mg@mail.gmail.com>
 <ada8b5c4-2a9e-45d9-a9e1-28fa50afce8d@nvidia.com>
In-Reply-To: <ada8b5c4-2a9e-45d9-a9e1-28fa50afce8d@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Nov 2025 15:18:02 +0800
X-Gm-Features: AWmQ_bnZhIKWSMpkWsQnvAN7AMqno6qxXdnPzDz-AkTZBuWbcERPcd9gvbM-Fys
Message-ID: <CACGkMEvgPyfOquwxXbugukpxenMt9NDevpJJi3QXD1s=0pgWXw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter caps
To: Dan Jurgens <danielj@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com, 
	virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com, 
	yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:16=E2=80=AFPM Dan Jurgens <danielj@nvidia.com> wr=
ote:
>
> On 11/11/25 10:18 PM, Jason Wang wrote:
> > On Wed, Nov 12, 2025 at 11:02=E2=80=AFAM Dan Jurgens <danielj@nvidia.co=
m> wrote:
> >>
> >> On 11/11/25 7:00 PM, Jason Wang wrote:
> >>> On Tue, Nov 11, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> >>>>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> >>>>>       }
> >>>>>       vi->guest_offloads_capable =3D vi->guest_offloads;
> >>>>>
> >>>>> +     /* Initialize flow filters. Not supported is an acceptable an=
d common
> >>>>> +      * return code
> >>>>> +      */
> >>>>> +     err =3D virtnet_ff_init(&vi->ff, vi->vdev);
> >>>>> +     if (err && err !=3D -EOPNOTSUPP) {
> >>>>> +             rtnl_unlock();
> >>>>> +             goto free_unregister_netdev;
> >>>>
> >>>> I'm sorry for not noticing the following earlier, but it looks like =
that
> >>>> the code could error out on ENOMEM even if the feature is not really
> >>>> supported,  when `cap_id_list` allocation fails, which in turn looks=
 a
> >>>> bit bad, as the allocated chunk is not that small (32K if I read
> >>>> correctly).
> >>>>
> >>>> @Jason, @Micheal: WDYT?
> >>>
> >>> I agree. I think virtnet_ff_init() should be only called when the
> >>> feature is negotiated.
> >>>
> >>> Thanks
> >>>
> >>
> >> Are you suggesting we wait to call init until get/set_rxnfc is called?=
 I
> >> don't like that idea. Probe is the right time to do feature discovery.
> >
> > Nope I meant it might be better:
> >
> > 1) embed virtio_admin_cmd_query_cap_id_result in virtnet_info to avoid
> > dynamic allocation
> >
> > Or
> >
> > 2) at least check if there's an adminq before trying to call virtnet_ff=
_init()?
>
> I could do a check like this:
>
>         if (!vdev->config->admin_cmd_exec)
>                 return -EOPNOTSUPP;
>
> Or would you prefer it added to the virtio_admin_command api?
>
> bool virtio_admin_supported(struct virtio_device *vdev);

I prefer 1) but I'm fine for 2) if everyone think it's ok.

Thanks

>
> >
> > Thanks
> >
> >>
> >>
> >>>>
> >>>> /P
> >>>>
> >>>
> >>
> >
>


