Return-Path: <netdev+bounces-205570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DCAFF509
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D390C1C40A26
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBF238C1B;
	Wed,  9 Jul 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY0a4vPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64071FF1C4
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101792; cv=none; b=PR76l829fVbp01ik3enVippmoSuHuetrwX6GpWG8fUOkgIstlzZGrjgq+0Yl3aHo+fFaLEjPqf8bgb8m1SdL3iMOEUzX7x0a5Qs4aWR3WqWEtCgnJjXk2BdeHZMFBd+hZTN07XyuiUivCHhS0ygnUFJufWOEWF1mKJQJu3b1t5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101792; c=relaxed/simple;
	bh=n9O063liQXJSgV2rV5XFUPRQVKrP0E98SbyoZ9cMOK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6eT3KwpZf/ODlbLQUO+QHFGeAjRncOIRuHJbdWyrVAzS7+Sa2s03AbpcLwhhPZ/gC61EGQUcfafXhmjDws8rQQNOwl1wq0yOz2c3u/OjwQZmjZUZUQFRd+dUDu57uZt60boYZb6NbotNXfo9gXr7jBHO2YCCgHh8zJPmOkNGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PY0a4vPm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2357c61cda7so31895ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752101790; x=1752706590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psTNSOzBn8OXtmmYI+qHnBQfX9pvC9szIAAFuognR9c=;
        b=PY0a4vPmHEXvh7gHoasn45CxLns63iH9QshE/XJXTROkT2cwy105Q5vZL9sUT+rt/S
         /erM7tPvmxdiUTPslWNcK3tIOhjWsYYzy0gumCna+TVVT3oidUTt3weWfJts7igljro1
         yl4dlqLhjNE8laOhCD4Q/h9APd8dEyA9XWstGmdKsWozXtQDBHCS+kpnzU9S03F3JgPL
         96v+oeowxtgCKtcTZYuNEe8IYD3Nka7Bsdwf1ZW3S4wS5j9XvFCH63z/EkACOsi7mOlW
         MZbY6oWo/byr+lJ61L1crlSe0wPi41awdqvE6nlrm35YO9ESw2UDt2sC+uKExMWZIYKt
         y7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101790; x=1752706590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psTNSOzBn8OXtmmYI+qHnBQfX9pvC9szIAAFuognR9c=;
        b=brou47NXj7cjpVZycXihQNlDZcWz9V8kNN9eWHu2fQMdl1oD2fC9cWP95yO/0vF2lR
         ATrIQ+BVpAvkksd50bcjp4uU3BWzW8mQK3cKyS/V233LUsmv7s+7m/Wdjy7cJnIHZmJs
         IgPgv/isVxaiadAEuOWGqSlcONQChTzCaWzv6kMv8RbDpei+yqh9WzLNB/T+9xkGESzw
         CTq6dfjwpnOtvzC12Yyper8NoSkqrg1jcJwX/9iKs+ibyptRlelIJWTJ0BByQL12rJJ/
         ijVwgV2QDOs1RaoOrLsIga+wJvXUlXI/P15K/PbI3DZkhgkgUE5x7c9Vcte6FuitYn2f
         BagQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXAyPHNFBGlsxhO+xyyJaGdUdMaCHHsLIVYo2R9BmCuSGLPohSFCaxh0nALmMvF/lSUadYFf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHZ/WHyPrvg8Ys5ZdpMC7AoAnRZ5Eamviv/ZtafJSJNENy437
	7lh7Gxax2hrfwSWEH6mkgk0NXGH+4Dr74CH89e78NLJReZx34AwQ7iMjvpDxyR8F6j82j6xQBBd
	4AXE8rM7YJUur9P5S04/MBXCcBM55mMRltq+6p91J
X-Gm-Gg: ASbGncvEzy/1ceXEwk+xpVnrGcOD0VNBIAdXCAWqKDk9u7W5Mq00gSr1qjzIvGaan2Z
	W1+CFE6/4DxKVCeyazaEj0sx7+bLX1gsf7dAGHL3C3GHM1UWbF0zSBZdtAwEcOfI+q6ymTPfAhn
	eoMpwofeuWs+174fCNteGEmTSuPmguAVrT73Lkp0S8c3R9MNPUPy1ipGLG3Cc3Z4f0KKyM215aj
	AsB7qYP6pM=
X-Google-Smtp-Source: AGHT+IGtnLZ7OWHggJ8+2pbK2Dk9UkhgmWPzA/1oDMJkDWju6K2XZ1R85Sq8cs803uGk0p6vBbGfH8ZG8DM1tLDCaZ8=
X-Received: by 2002:a17:903:3b8e:b0:234:c37:85a with SMTP id
 d9443c01a7336-23de38106e0mr1297665ad.24.1752101789722; Wed, 09 Jul 2025
 15:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709124059.516095-2-dtatulea@nvidia.com> <CAHS8izNHXvtXF+Xftocvi+1E2hZ0v9FiTWBxaY7NWhemhPy-hQ@mail.gmail.com>
 <bm4uszrqfszm5sgigrtmo2piowoaxzsprwxuezfze4lgbt22ki@rn2w2sncivv3>
In-Reply-To: <bm4uszrqfszm5sgigrtmo2piowoaxzsprwxuezfze4lgbt22ki@rn2w2sncivv3>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Jul 2025 15:56:16 -0700
X-Gm-Features: Ac12FXwgXd9rszuQDYsn2GNHGMXg5QVxNUDYVkWuGeps_H3DDEY13GPvqZBPpZI
Message-ID: <CAHS8izP18q7s8=fGCjknrEu3uJE5xnQCKceB8u1VvTV5GxTTTg@mail.gmail.com>
Subject: Re: [PATCH net] net: Allow non parent devices to be used for ZC DMA
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, cratiu@nvidia.com, 
	parav@nvidia.com, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:54=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Wed, Jul 09, 2025 at 12:29:22PM -0700, Mina Almasry wrote:
> > On Wed, Jul 9, 2025 at 5:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > For zerocopy (io_uring, devmem), there is an assumption that the
> > > parent device can do DMA. However that is not always the case:
> > > ScalableFunction devices have the DMA device in the grandparent.
> > >
> > > This patch adds a helper for getting the DMA device for a netdev from
> > > its parent or grandparent if necessary. The NULL case is handled in t=
he
> > > callers.
> > >
> > > devmem and io_uring are updated accordingly to use this helper instea=
d
> > > of directly using the parent.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> >
> > nit: This doesn't seem like a fix? The current code supports all
> > devices that are not SF well enough, right? And in the case of SF
> > devices, I expect net_devmem_bind_dmabuf() to fail gracefully as the
> > dma mapping of a device that doesn't support it, I think, would fail
> > gracefully. So to me this seems like an improvement rather than a bug
> > fix.
> >
> dma_buf_map_attachment_unlocked() will return a sg_table with 0 nents.
> That is graceful. However this will result in page_pools that will
> always be returning errors further down the line which is very confusing
> regarding the motives that caused it.
>
> I am also fine to not make it a fix btw. Especially since the mlx5
> devmem code was just accepted.
>

If you submit another version I'd rather it be a non-fix, especially
since applying the io_uring hunk will be challenging when backporting
this patch, but I assume hunk can be dropped while backporting, so I'm
fine either way.

> > > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > > Changes in v1:
> > > - Upgraded from RFC status.
> > > - Dropped driver specific bits for generic solution.
> > > - Implemented single patch as a fix as requested in RFC.
> > > - Handling of multi-PF netdevs will be handled in a subsequent patch
> > >   series.
> > >
> > > RFC: https://lore.kernel.org/all/20250702172433.1738947-2-dtatulea@nv=
idia.com/
> > > ---
> > >  include/linux/netdevice.h | 14 ++++++++++++++
> > >  io_uring/zcrx.c           |  2 +-
> > >  net/core/devmem.c         | 10 +++++++++-
> > >  3 files changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 5847c20994d3..1cbde7193c4d 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -5560,4 +5560,18 @@ extern struct net_device *blackhole_netdev;
> > >                 atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
> > >  #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__=
##FIELD)
> > >
> > > +static inline struct device *netdev_get_dma_dev(const struct net_dev=
ice *dev)
> > > +{
> > > +       struct device *dma_dev =3D dev->dev.parent;
> > > +
> > > +       if (!dma_dev)
> > > +               return NULL;
> > > +
> > > +       /* Some devices (e.g. SFs) have the dma device as a grandpare=
nt. */
> > > +       if (!dma_dev->dma_mask)
> >
> > I was able to confirm that !dev->dma_mask means "this device doesn't
> > support dma". Multiple existing places in the code seem to use this
> > check.
> >
> Ack. That was my understanding as well.
>
> > > +               dma_dev =3D dma_dev->parent;
> > > +
> > > +       return (dma_dev && dma_dev->dma_mask) ? dma_dev : NULL;
> >
> > This may be a noob question, but are we sure that !dma_dev->dma_mask
> > && dma_dev->parent->dma_mask !=3D NULL means that the parent is the
> > dma-device that we should use? I understand SF devices work that way
> > but it's not immediately obvious to me that this is generically true.
> >
> This is what I gathered from Parav's answer.
>
> > For example pavel came up with the case where for veth,
> > netdev->dev.parent =3D=3D NULL , I wonder if there are weird devices in
> > the wild where netdev->dev.parent->dma_mask =3D=3D NULL but that doesn'=
t
> > necessarily mean that the grandparent is the dma-device that we should
> > use.
> >
> Yep.
>
> > I guess to keep my long question short: what makes you think this is
> > generically safe to do? Or is it not, but we think most devices behave
> > this way and we're going to handle more edge cases in follow up
> > patches?
> >
> It is just what we know so far about SFs. See end of mail.
>

I see. OK, even though this is 'just what we know so far', I'm still
in favor of this simple approach, but I would say it would be good to
communicate in the comments that this is a best-effort dma-device
finding and doesn't handle every case under the sun. Something like
(untested):

static inline struct device *netdev_get_dma_dev(const struct net_device *de=
v)
{
       struct device *parent =3D dev->dev.parent;

       if (!parent)
               return NULL;

       /* For most netdevs, the parent supports dma and is the correct
        * dma-device
        */
       if (parent->dma_mask)
               return parent;

       /* For SF devices, the parent doesn't support dma, but the grandpare=
nt
        * does, and is the correct dma-device to use (link to docs that exp=
lain
        * this if any).
        */
       if (parent->parent && parent->parent->dma_mask)
               return parent->parent;

       /* If neither the parent nor grandparent support dma, then we're not
        * sure what dma-device to use. Error out. Special handling for new
        * netdevs may need to be added in the future.
        */
       return NULL;
}

With some comments explaining the logic a bit, you can add:

Reviewed-by: Mina Almasry <almasrymina@google.com>

And let's see if Jakub likes this. If not, we can always do the future
proof approach with the queue API giving the driver the ability to
tell us what exactly is the dma-device to use (or whatever approach he
prefers).

--=20
Thanks,
Mina

