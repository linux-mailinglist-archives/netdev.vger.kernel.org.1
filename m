Return-Path: <netdev+bounces-82385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAA88D810
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 08:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1031C26100
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136F2C6A7;
	Wed, 27 Mar 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e29rVE4D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD92E651
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525833; cv=none; b=f3QFbRmyQpCQFapucgTfrZYjssZaFV0EhTWj99oefdLmND/BrkJWA0b4rpPK6tg5XTbGq7Y7qpcQTHMgoOx5VbhjCtCCtq3XrEu7/hofhx6BxtkeKcO0LNJNmYIE4fHFOJ0sQc+jRKK7QY2h/N0hd/m/AAtL9pQZGqoLF+xCPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525833; c=relaxed/simple;
	bh=G4gBxI9rnfFMlIO3v/jwuSxookG3kaOjTJgRf/Y/wfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUGnyLx17aJmr8Ki2MD7ik0QtLph63KE9hUr2NYMyoGG/mj1RiNOUD8VWu4FGVvoUZqNeIHBdkEQ5r6uNMKJT9+AmBcon10RD2MvCMVZ9CF28B4rxnmGHg50tVG9IQM57yH1ndzUF9p7xDBPcyKO4M9aJvf68gfo0OLFfc4G3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e29rVE4D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711525830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leNaeVEeegZNAyCWujLBBYSGN9KTxodCNVdWyzvOBB0=;
	b=e29rVE4DGAsb8gx/2KGhx9Oo8fLRIGKyUObm4nN7d3QWaCWk0XkplDCyeu19BA9vFDXitO
	8MEdiPdK20Qs8fgBRDReHAr5OSLBjlg52lhAxeAO3VHtGQlomH05lPjtW7BrTyNay7M/vj
	orliHBt3CMngdZzfHyAVNN2uVMV+rBo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-7JhTJexPOSq7pfCg5VpGVw-1; Wed, 27 Mar 2024 03:50:29 -0400
X-MC-Unique: 7JhTJexPOSq7pfCg5VpGVw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e6cbb27964so3891119a34.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 00:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525828; x=1712130628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leNaeVEeegZNAyCWujLBBYSGN9KTxodCNVdWyzvOBB0=;
        b=NZmPwUqeOpe9NWQPmSB3To4BDwBvDa8R1ItW/Udm3NyPAckYHv2Ja2l5e8U/vKy70t
         j9zpFRPaeeswaSjpr635vzsTZcFNmrUKDWtIMIugg70Z6WKDF3atPpHEQv1EMtE71Mlu
         eovcv+TPGjys5FfT8f1o82mXwHUg8ZsPVlSB8tHa0En4LITNEK5ETQtdGv0CfwMbfcLV
         TKoYTgdDCSM1HxKFPbr3Gt6i9OVzgyyMFPW2Us5IARYsKsu33RgP0ZnEliALwqi2zFwF
         NUqriK7pqa1TOcSxEfMyUJd2Ylxvk9/6sm4riufyG1Ebk0JvjX1Sfh+snT/9Y8n/rI5l
         Bs7w==
X-Forwarded-Encrypted: i=1; AJvYcCULOS9idVo5tCNI03WOnzPvufl4BcwOcKgJMG01wpNmim4Gzp8brGMBHMvaeJpv0GbWRdAA5U8vPDr5k1qTTuwoN+lLO6nk
X-Gm-Message-State: AOJu0Yx3nK0311dXA5s/HwXaee1fmtbpnDi8xN2ImHtUNBqhv6/PMeA6
	OZVXLDoQEUX7SLDFDpiVuobHMwTCSGcoI5GEWox98SZyOns1cfEFO4Q4YLQXxi2EZA/KOSIu07c
	8Eubbs2NmpNa3Wg9HYbw92/wUxrTWyXqDbiOU19q2s3wyKGc6J43IA6PQidiM8XYZtJFw+FFx9+
	ljwejwblB2rSSFsqj4tKm119lke56SnQakR51dF3w=
X-Received: by 2002:a05:6808:3a1b:b0:3c3:d459:d849 with SMTP id gr27-20020a0568083a1b00b003c3d459d849mr2463789oib.27.1711525828306;
        Wed, 27 Mar 2024 00:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIwlaV3wv9ZkE1tKICeIHrGUIEjqVJum9I6Gwneza/2HcRBp/yllRKFNMqZogdirZl+9w0LsR5VG9mSD4vDXQ=
X-Received: by 2002:a05:6808:3a1b:b0:3c3:d459:d849 with SMTP id
 gr27-20020a0568083a1b00b003c3d459d849mr2463778oib.27.1711525828020; Wed, 27
 Mar 2024 00:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com> <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 15:50:17 +0800
Message-ID: <CACGkMEvzMKyYTNwCwept1HJKLM8FZBa2FZq1oyQ0tFVL2TvMeQ@mail.gmail.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 26 Mar 2024 14:35:21 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As discussed:
> > >
> > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3=
rHYqRZxYg@mail.gmail.com
> > >
> > > If the virtio is premapped mode, the driver should manage the dma inf=
o by self.
> > > So the virtio core should not store the dma info. We can release the =
memory used
> > > to store the dma info.
> > >
> > > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > > the virtio-net must allocate too much memory(19 * queue_size for per-=
queue), so
> > > we do not plan to make the virtio-net to maintain the dma info by def=
ault. The
> > > virtio-net xmit queue only maintain the dma info when premapped mode =
is enable
> > > (such as AF_XDP is enable).
> > >
> > > So this patch set try to do:
> > >
> > > 1. make the virtio core to do not store the dma info when driver can =
do that
> > >     - But if the desc_extra has not dma info, we face a new question,
> > >       it is hard to get the dma info of the desc with indirect flag.
> > >       For split mode, that is easy from desc, but for the packed mode=
,
> > >       it is hard to get the dma info from the desc. And hardening
> > >       the dma unmap is safe, we should store the dma info of indirect
> > >       descs when the virtio core does not store the bufer dma info.
> > >
> > >       The follow patches to this:
> > >          * virtio_ring: packed: structure the indirect desc table
> > >          * virtio_ring: split: structure the indirect desc table
> > >
> > >     - On the other side, in the umap handle, we mix the indirect desc=
s with
> > >       other descs. That make things too complex. I found if we we dis=
tinguish
> > >       the descs with VRING_DESC_F_INDIRECT before unmap, thing will b=
e clearer.
> > >
> > >       The follow patches do this.
> > >          * virtio_ring: packed: remove double check of the unmap ops
> > >          * virtio_ring: split: structure the indirect desc table
> > >
> > > 2. make the virtio core to enable premapped mode by find_vqs() params
> > >     - Because the find_vqs() will try to allocate memory for the dma =
info.
> > >       If we set the premapped mode after find_vqs() and release the
> > >       dma info, that is odd.
> > >
> > >
> > > Please review.
> > >
> > > Thanks
> >
> > This doesn't apply cleany on vhost.git linux-next branch.
> >
> > Which tree is this based on?
>
>
> Sorry. That is on the top of "[PATCH vhost v5 0/6] refactor the params of
> find_vqs()".
>
> Lore-URL: http://lore.kernel.org/all/20240325090419.33677-1-xuanzhuo@linu=
x.alibaba.com
>
> Thanks.

I've tried that but it doesn't work:

% git am ~/Downloads/\[PATCH\ vhost\ v5\ 01_10\]\ virtio_ring_\
introduce\ vring_need_unmap_buffer.eml
Applying: virtio_ring: introduce vring_need_unmap_buffer
error: patch failed: drivers/virtio/virtio_ring.c:2080
error: drivers/virtio/virtio_ring.c: patch does not apply
Patch failed at 0001 virtio_ring: introduce vring_need_unmap_buffer
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I'm using vhost.git linux-next branch, HEAD is

commit 56e71885b0349241c07631a7b979b61e81afab6a
Author: Maxime Coquelin <maxime.coquelin@redhat.com>
Date:   Tue Jan 9 12:10:24 2024 +0100

    vduse: Temporarily fail if control queue feature requested

Thanks

>
> >
> > Thanks
> >
>


