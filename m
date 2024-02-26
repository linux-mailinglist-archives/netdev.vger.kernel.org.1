Return-Path: <netdev+bounces-74884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E88672C1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB62B304BD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF51CA8A;
	Mon, 26 Feb 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="LD9y0C60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC556746
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943441; cv=none; b=ZzKS0VwsTlEeJQgn7g+3CSC0s7CBp6OrC3faPs3DF3y3cHi8+33+kgk9XSxUnEmDMUood8XxBQkgN5FFENB9di27Wz/ZuATbRe43x/HXdOQIPxoRCqcvXC4nXoWooDyKGLrJ/k6PpvguzKrApQuAZiK7VpUNeAtYXACyDHmp7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943441; c=relaxed/simple;
	bh=3AEg61c9t2RdSbrA3SOYlabwim+w14UVA/dDDZpqvZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oILfmONbvBMM5qlkG559FweClga5dpoH1P8ExCszkrN+jEYa2ZN4qhtGGCRrCRZ+nYmKtSyPbuNDulF4YVGTb3euVnrN5BANIjEoMYBrHX1mBz0gFqIJHFDs5v74CNIcWBx00zwkgAMZAjs3SUe5jNU2vsbITDhMwZBo2bRU4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=LD9y0C60; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so301860866b.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708943438; x=1709548238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz6b+eCtgnaUFENSuU3KdIVlMwnoCTOF+cGcVtN0DkI=;
        b=LD9y0C60HOh1RKDhvMKmtT2nQe+qq2hbqV2q0nc9XCGhJ2wEJ5KveN6fMOpovGmq5C
         i5dPH6raI2NaBnEG5ymEiHTsrVbSf7bQ0w5lW/VMxst3jZy6alVWpyyCvnpsXHeSJukD
         hV6TjnjL/fm3eRWGZ8dR+lkgiqzKZOUBDjBhxtQiEXGrV8MOcfgB/ho5m/jsYSa+8cI5
         nhycQDBOFyooPAbnZhyh9XFncW367sg5bBjf1ByZRWloVxIsa6V8+iGs0tAnMJ+hs4IY
         0HJ0uAxdsG2TrwXvoDeuvAKIITjPlKU5AMALDEttgL9162t+u7ptmm5Q9ewpGa7Ebpgv
         TrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943438; x=1709548238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz6b+eCtgnaUFENSuU3KdIVlMwnoCTOF+cGcVtN0DkI=;
        b=er09tm8lrgiORZ28OCnwxEWHUCsCB7hmD96WsNJrs+FRkBVUKvwwn1GEDMZFpLCkiy
         K8ObwjzWzm7WjXfnoxsnwh9/c2V1z9Im84sXViLC4Ene14kB+EFU5Etj4bvGdfOeVkDZ
         NdUF9GdzD5m6lgIThL8MDtK5Cb8JYeSoRWFMsL6+Qfiui8F67E/V++RPX1deZlcr1aUF
         kmjEJquKRfMJkQu1lFSzz+QLOo+JvunrCvb49aMA9qQ6sPdySG4NVJbknYA411bmWvPR
         8Fuj4m5ayjlL81OPd//ZgRz8zuiOpQ94QDWEqSM7yxMTtVPuj63W/NfQn4+mj9vmS2ru
         iPXw==
X-Forwarded-Encrypted: i=1; AJvYcCVvLv3bZK2QOeMHNSaU0zaUGMwVWWgXkgev7cRILdQ3GZ1ypWFthdJ9XCrEFfKRlrQ7aVTM2wgYlQs5LrQs9dIVfLjFVTjy
X-Gm-Message-State: AOJu0Yx8UKhBhT+GtJHAD96njLVA5zLQGsUYhFgSKHL/8acUVAzCe+1t
	1oDTcApZhVsbm7h33pB2hngesc2mrEK6+lr1NwEvf3bgpQWAe7uGc5npM+Eo+JCOjj8Hn6mql+W
	dj0ZYqNRlbxD3Lul0r5GQoIUmwfYhUXOWctPXJA==
X-Google-Smtp-Source: AGHT+IFRPov8/cpih2mq251F4b8kRlFyC5NNX1J7o+YMmyopd5NzNTlRC1I0AnsNzV9tfVe1KWjRjh446NXfYck2paE=
X-Received: by 2002:a17:906:68d2:b0:a3e:5b7f:6d31 with SMTP id
 y18-20020a17090668d200b00a3e5b7f6d31mr3616604ejr.5.1708943437867; Mon, 26 Feb
 2024 02:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com> <20240115172837-mutt-send-email-mst@kernel.org>
 <20240222150212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240222150212-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 26 Feb 2024 12:30:27 +0200
Message-ID: <CABcq3pEtW4j60n3jJgkSUDy=VbcfzAbS_4eYMHpEPR2bYU9aww@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
Ok, let me prepare a new patch v2, where I'll write a
description/analysis of the issue in the commit message.

On Thu, Feb 22, 2024 at 10:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jan 15, 2024 at 05:32:25PM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > > When the Qemu launched with vhost but without tap vnet_hdr,
> > > vhost tries to copy vnet_hdr from socket iter with size 0
> > > to the page that may contain some trash.
> > > That trash can be interpreted as unpredictable values for
> > > vnet_hdr.
> > > That leads to dropping some packets and in some cases to
> > > stalling vhost routine when the vhost_net tries to process
> > > packets and fails in a loop.
> > >
> > > Qemu options:
> > >   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
> > >
> > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > ---
> > >  drivers/vhost/net.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index f2ed7167c848..57411ac2d08b 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_v=
irtqueue *nvq,
> > >     hdr =3D buf;
> > >     gso =3D &hdr->gso;
> > >
> > > +   if (!sock_hlen)
> > > +           memset(buf, 0, pad);
> > > +
> > >     if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> > >         vhost16_to_cpu(vq, gso->csum_start) +
> > >         vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> >
> >
> > Hmm need to analyse it to make sure there are no cases where we leak
> > some data to guest here in case where sock_hlen is set ...
>
>
> Could you post this analysis pls?
>
> > > --
> > > 2.43.0
>

