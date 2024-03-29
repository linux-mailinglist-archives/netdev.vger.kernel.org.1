Return-Path: <netdev+bounces-83160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8298911DC
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881E01F21414
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A3383A0;
	Fri, 29 Mar 2024 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kip83uE5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B7364D4
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682212; cv=none; b=PSaBCN3tUv6/0NU5Bn7oViroH1iFcceIa9jGkJZiFGeaTfY3lEiiSyhFxNl3hWwdCup/P1h2F8U6Xm7i6r6nvZFAmeH1ktElqcWGa3rBwbfkmOY0lApa5P7V13QIHpgCr2O1bILEMbHVJ/D065G4xWCWzaTiaIuU+wzMjdgLLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682212; c=relaxed/simple;
	bh=a/VN+mdeggc6CK86VLaGu6ajVMPHLw3pM99GGwm9EuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnjHxEcuEoOhdqXgRNgxndVuPoq68/VRS/7SsM9J+Hy/QAVEyX65eyzQN+z0MR8DUKQU7izPrK/7ZxMfnZDuomWPYPnx3Msf9eq3xDRPU982LAfimlk2AO+C0qVGaQTPYligDvk7MZ1J7uNrlktOeYY6kcHkQqnz6/6Lr9lN3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kip83uE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711682209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35D3mH4G6Kyxe+It17TRBfV5gddJyYbeSD6Ix202fhU=;
	b=Kip83uE5X6QuX5u71aNNQk+hyx1BUlJxRCJO6jmZI9nUjnMT41JLjNTIne5ITZ/f0KJdsR
	zzVD9HjvMuYM+qamKdY7ILvYenHCPqydWAO3Hhv8s5pdcyY7VzPYxbyFk1m/14L0jCkaxZ
	s1cB6IXsNiSy9y+AJQroDv5cGpSfb+o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-mxwe4YT1M3iPs4p1UC81_g-1; Thu, 28 Mar 2024 23:16:47 -0400
X-MC-Unique: mxwe4YT1M3iPs4p1UC81_g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df4ec4304so1447599a91.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682207; x=1712287007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35D3mH4G6Kyxe+It17TRBfV5gddJyYbeSD6Ix202fhU=;
        b=w0mMBPtlUxGX3Ovfnos7ShjPl7+CqZNjtC/VJjjhu3fff4zC2LzJ2dkmdlhHc4VGw+
         kZeQyA2mT3sFxIzLuKbWcmOf7oBFMnZ9DnX9aIKP6BNqW1fexlV8f00+zeqm0XWdQA/A
         5PpPxd36x9NX1DC5v7y8AaZzVlJcgtvZJJH1lR4pRaew1/zgyXarQJmeQuRzPAZv93cI
         XCcPpX5HZMbnBFBaALBhUdHfKgQ6bm6eumf+WbiW1VER/N9B6ogD0lDS0jIRs2FVH3KK
         UIID+5SFs5efV+JaCXv2JZ3IdHNHmdcsn6/hFzb+eTMgUtO3irJRZVPE0gpZdgvYw2NH
         eFuA==
X-Forwarded-Encrypted: i=1; AJvYcCXsEgVoK+qL12gPRRsmAqCpwX5E6aKi+XopdEwWpJOazWnjvaFCQtbjlFbKfutkudGYBpHr9I2N6OQh6I0fFp0So3VqwHfU
X-Gm-Message-State: AOJu0YxZKkUVHnjNrFqji6W1h9w4xdKC/25A5AxKjeRZLLep5vAyaFTW
	E60mhzEaKe5sXZCe5/R/2bW/vhN0GhxJP1HTzuWogcUlU99jlzooY6uLUvCtkFGtBdxMtmxkMdG
	lGOiiLWYZMssyZfv/j9RFNmXB9MLBg+zlZRzW6r4nHodlClnUncYZU1cnEwtjHSpRHNyElzBrGX
	XDG0mxiBB9tL4fEh5AP5E7MGG2cT6G
X-Received: by 2002:a17:90b:438d:b0:29b:95a:baaa with SMTP id in13-20020a17090b438d00b0029b095abaaamr1122300pjb.47.1711682206874;
        Thu, 28 Mar 2024 20:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7MfzA7vL4DFnj2zKalqTY7rUS4dD1nFqOdbO9QfQtKabq9D8jBbHUcOBDHuK3bXvlS9FRDrwFXK37GuogFw=
X-Received: by 2002:a17:90b:438d:b0:29b:95a:baaa with SMTP id
 in13-20020a17090b438d00b0029b095abaaamr1122287pjb.47.1711682206548; Thu, 28
 Mar 2024 20:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-7-xuanzhuo@linux.alibaba.com> <CACGkMEsmnzEUmaffn3ueY1JtbJ4UzLpr9o0s4j1jwoVuO-yy8Q@mail.gmail.com>
 <1711611643.583144-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711611643.583144-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:16:35 +0800
Message-ID: <CACGkMEv08s6vt7r218rQ1_oAppGWRnsMZBzULFX8zMiMi8e6kA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 06/10] virtio_ring: no store dma info when unmap
 is not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 15:06:33 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As discussed:
> > > http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_=
yC21bgGkKZh845w@mail.gmail.com
> > >
> > > When the vq is premapped mode, the driver manages the dma
> > > info is a good way.
> > >
> > > So this commit make the virtio core not to store the dma
> > > info and release the memory which is used to store the dma
> > > info.
> > >
> > > If the use_dma_api is false, the memory is also not allocated.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 120 ++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 97 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 1f7c96543d58..08e4f6e1d722 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -69,23 +69,26 @@
> > >
> > >  struct vring_desc_state_split {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_desc_extra *indir_desc;    /* Indirect descripto=
r, if any. */
> > > +       struct vring_desc_dma *indir_desc;      /* Indirect descripto=
r, if any. */
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_desc_extra *indir_desc; /* Indirect descriptor, =
if any. */
> > > +       struct vring_desc_dma *indir_desc; /* Indirect descriptor, if=
 any. */
> > >         u16 num;                        /* Descriptor list length. */
> > >         u16 last;                       /* The last desc state in a l=
ist. */
> > >  };
> > >
> > >  struct vring_desc_extra {
> > > -       dma_addr_t addr;                /* Descriptor DMA addr. */
> > > -       u32 len;                        /* Descriptor length. */
> > >         u16 flags;                      /* Descriptor flags. */
> > >         u16 next;                       /* The next desc state in a l=
ist. */
> > >  };
> > >
> > > +struct vring_desc_dma {
> > > +       dma_addr_t addr;                /* Descriptor DMA addr. */
> > > +       u32 len;                        /* Descriptor length. */
> >
> > This seems to be odd, flag should be part of dma info.
>
> flags contains F_NEXT, that is used by detach when no dma info.

Right, so it is needed for hardening.

>
> >
> > To reduce the changeset, I would split out next.
>
> Do you mean split this patch set?

No, then this patch looks ok.

Thanks

>
> Thanks
>
>
>
> >
> > Thank
> >
>


