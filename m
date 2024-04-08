Return-Path: <netdev+bounces-85574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374289B70C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 07:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA22E1F21E7F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2F6FC5;
	Mon,  8 Apr 2024 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtR6I2rU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4376FC3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712552533; cv=none; b=h70wQBGTFP6g4RAPId/hR5yfNFqo80CdbSZO+PblQ9mXp2ZRxqOvi+WTesXUNtzbv6Xw3Ivqw+ZGZb80hq9Nxi4sYzO1TXyXe2S54xP0xKkgS/csPjty7B6uLtcqSf6pg13NYSbUEwz5FbDB68YqLI9Qi6DGPzSLK7QWqa4/zGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712552533; c=relaxed/simple;
	bh=fFakGqFXb7miUasdd8JwQHDshvxwKUJPropsziDPXJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpgGDpRTkcJKK3JGWzJSzikRETkh286muQLPH1hREzY5UE4EW4wsvLqHL8HokdY8Vhs2QfSaPkxfo+gXeqcjkOCV8SpHAEa9RQvAL8fNEenv0UIgd+yPVVYTkM93bb7Mrk68krat1MEmFSbNAYCjvTHWzVJ+RvyX8W5sZtR5oY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtR6I2rU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712552530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFakGqFXb7miUasdd8JwQHDshvxwKUJPropsziDPXJY=;
	b=AtR6I2rUKH97IuEpdsvr5EbuDSQC/pi1vdTkBkUYfPu7hfQjOIkM2XhSTvuWvLvYbzx1cB
	1Rjv9btBHI4nyH7QVhHUcgBCdhI+VzLzY2mHkmu5wff5GetuNRGlJBdpBBSaUaWFcvZP3n
	clL9c371QMlM4tMwJ9dg5vz3eFzZKC0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-rZtTPtmhOYyiMoyG-cKG7w-1; Mon, 08 Apr 2024 01:02:09 -0400
X-MC-Unique: rZtTPtmhOYyiMoyG-cKG7w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2e0a51adfso3608962a91.0
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 22:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712552528; x=1713157328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFakGqFXb7miUasdd8JwQHDshvxwKUJPropsziDPXJY=;
        b=jrlZwagorjCqB9yAZsWYAjQtquosrIYXEH2g1rutCB8Lwpby8G8FNDa1Jq+3tnjWuz
         Q9g2Cgsc0XzyXZSWMxQ6rurrMO1OfkSCAy0aGHVDsgwQwwXl6TnqAMocYH3KD623Rjzr
         OWcplu9iQeWWleLmdC50djDrloTF20rdO4k0Qr3HryBmbE2XJpTVutbkN685YgM9/8W6
         48ZwwXq5M8kjURY7wOQczW6n8vLFfEhUFPLESR//QLM2fPsZPyMI90nV9RbQ2m+cVeBS
         oygBgUa0P0xEfhDPziCetKHkmRZjGpeuZVTWp2i1mUwwEZRYdTXp5AXqAsbq0r492/uu
         Rp5A==
X-Forwarded-Encrypted: i=1; AJvYcCV534gI21SD+U6hHFTZnazyQsDD7KTuG2bEGALF2LKEbAXmWHj8uYFFl8d3jXJgUBy7nzpnw7dG066EJga4kCq/SmOBIDbL
X-Gm-Message-State: AOJu0YzTnMG21XGJvEBQ7Mm0HmXjXWOjSXdvFGrzQXp/qJGtUIMnkCC8
	hvcAc+xu6YABV3HCt1oqY/F2dST0FDYQoCxPiwQcWjy5jRA1ODKaWY8QV/q4LRJsPuzOkEAJ6x8
	wNESm7FFzYx/XyrlyhhOiNsRpNRWkwaiPMpMR57OYhN7tep97tuk5+SLCAD0JxhxnLn0xuRMpu9
	1njv1MxSZ6tPAV9RbxSDa/CKaI931y
X-Received: by 2002:a17:90b:3ec1:b0:2a0:7758:31ac with SMTP id rm1-20020a17090b3ec100b002a0775831acmr6916456pjb.25.1712552527936;
        Sun, 07 Apr 2024 22:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbUCi6nAyv+gjv7m0lJyKJn2JoWGQlaDDt1AgepdxKDzzRtg0lSIxzBtaHwPEz0YASujEtj62UQK7o5fpC8Fo=
X-Received: by 2002:a17:90b:3ec1:b0:2a0:7758:31ac with SMTP id
 rm1-20020a17090b3ec100b002a0775831acmr6916444pjb.25.1712552527605; Sun, 07
 Apr 2024 22:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com> <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com> <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
 <1711935607.4691076-1-xuanzhuo@linux.alibaba.com> <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvPZKa-au=2XaXrjT4t1vpPF4mPRNYNZ6uTPNyUpT8dfA@mail.gmail.com> <1712469641.4145665-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1712469641.4145665-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 13:01:56 +0800
Message-ID: <CACGkMEvPy+5_x24MCn8xbSyEkhFG8iz=XQ9gpoHO5y49ORsQKA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 2:03=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Sun, 7 Apr 2024 12:24:00 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Mon, Apr 1, 2024 at 11:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Mon, 1 Apr 2024 09:40:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> > > > On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > Now, the virtio core can set the premapped mode by find_vqs=
().
> > > > > > > > If the premapped can be enabled, the dma array will not be
> > > > > > > > allocated. So virtio-net use the api of find_vqs to enable =
the
> > > > > > > > premapped.
> > > > > > > >
> > > > > > > > Judge the premapped mode by the vq->premapped instead of sa=
ving
> > > > > > > > local variable.
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > I wonder what's the reason to keep a fallback when premapped =
is not enabled?
> > > > > >
> > > > > > Rethink this.
> > > > > >
> > > > > > I think you are right. We can remove the fallback.
> > > > > >
> > > > > > Because we have the virtio dma apis that wrap all the cases.
> > > > > > So I will remove the fallback from the virtio-net in next versi=
on.
> > > > >
> > > > > Ok.
> > > > >
> > > > > >
> > > > > > But we still need to export the premapped to the drivers.
> > > > > > Because we can enable the AF_XDP only when premapped is true.
> > > > >
> > > > > I may miss something but it should work like
> > > > >
> > > > > enable AF_XDP -> enable remapping
> > > > >
> > > > > So can we fail during remapping enablement?
> > > >
> > > >
> > > > YES.
> > > >
> > > > Enabling the premapped mode may fail, then we must stop to enable A=
F_XDP.
> > > >
> > > > AF-XDP requires that we export the dma dev to the af-xdp.
> > > > We can do that only when the virtio core works with use_dma_api.
> > > > Other other side, if we support the page-pool in future, we may hav=
e the
> > > > same requirement.
> > >
> > > Rethink this.
> > >
> > > Enable premapped MUST NOT fail. No care the use_dma_api is true or no=
t, because
> > > we have the DMA APIs for virtio. Then the virtio-net rx will work wit=
h
> > > premapped (I will make the big mode work with premapped mode)
> >
> > Just to make sure we're at the same page. Rx will always work in the
> > mode or pre mapping. So we can easily fail the probe if we fail to
> > enable RX premapping?
>
>
> NO, enabling premapped mode can not fail. So the rx will always work
> in the premapping mode.

Ok, kind of my understanding.

>
>
> >
> > >
> > > AF_XDP checks the virtqueue_dma_dev() when enabling.
> > >
> > > But disabling premapped mode may fail, because that virtio ring need =
to
> > > allocate memory for dma.
> >
> > That's kind of too tricky, what if we just allocate the memory for dma
> > unconditionally?
>
> It's ok, but we waste the memory.

Probably, but the point is to reduce the complexity of the codes for symmet=
ry:

We don't need to have and maintain codes for fallback mode when we
fail to disable premapping.

Thanks

>
> Thanks.
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > >
> > > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > THanks
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


