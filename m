Return-Path: <netdev+bounces-90676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060A8AF7A3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC8287DD1
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FE313D510;
	Tue, 23 Apr 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hs0Y7ywp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09B1420B6
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902043; cv=none; b=ctNJay5jGodAdhBkU//8a9H8Gcmh0kjhPJ0IQ62e/OtSYQPfZuCDDBKNdN+6rELXSSZ4nnouAAtpFYvh+0EdzPapCbprlxCYQDNRTqQzeqTcViF+kK3SZm0SXp9re2aHFCxFQOHCvrBs/ptqR+fT5OGaRw9hn1u78wNxPKPh6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902043; c=relaxed/simple;
	bh=Ne8DS/nXj6vCo94gDQXKfFlL92TSrUjPVa7+hdk9RY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDtaWF8jj2GIgd8TdrwRtlVLNA/SjDklgmpyA/zwWxzuFNVgjAqNh/8J7cFDOrDWYXZkSAMTkvschzGt4IKtiuLfN7QqrPwCYvJ7jXOOHbX6CaxFAWACyEHuPuDTUaQW2akWiITdlhrIe8GTOztzouoPtaS093dGIS4MFZFgruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hs0Y7ywp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so325a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713902040; x=1714506840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rwmhVTWMdn7S/cc6XaHlwG87+yFIvhtm5XZI0WD7QU=;
        b=hs0Y7ywpESPHg8lLiDpBZUoGgSg8wIub+PrvUQw0WNu1xxk5buqkYqSXYnumIgfmAG
         /1lKSOmMVDl8/mCL03QNE08p06HWz/Vupc+eXZ2st0uC1TFJDBfhabUHqgVE69kF9EDi
         +4meezfreUeqtyBlpxusdZBpVnBIIVu4KZy2NWLAyipc+KN5z4WFhHw6yK7ziaxQkosN
         MuldhB73fgAd0Ry7uyf+qg+yPgJex6VGPeaY1L07+ZzFcE1E+80AtxnxUxgB14dHmXpe
         raWBqch6+4H5RAyBdXiKRDhHck3aCWj30axsBuBZj0/zzsN4mq4vjf3NCJfDx29daHly
         Mw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713902040; x=1714506840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rwmhVTWMdn7S/cc6XaHlwG87+yFIvhtm5XZI0WD7QU=;
        b=bGyYt88NmoMeLupUnjEcNdp7jT282P5LYK2FYCU3HHpMr2MrIn21AFJwQq8mCxugDQ
         5cK9w8czf3eanFGMirZZ2uw/F+/NubH+YWWAK8SH3vfQfEGwwk2ONeJqI1MRO2Ayl/N5
         1lXK2whpqRVoWzN0CZw1NyajNqI+zS0yxBcT5ZGxBibx2LNxH5LM9xXUydARoqIbF70b
         3uGqgsi9N0ZUhecOHPl92KvaNzedhvdZlguCVe/qQnqzz5ix92nqhbtWUE/PFZxEWjmz
         1hhZ4+lbG6n9H1RfD0r1I8DyAiZDuoEeSa0ZftulMnnllVydZW1g1l4oiRjAuegqE2N7
         hP2A==
X-Forwarded-Encrypted: i=1; AJvYcCVNxecM9nadn2BAK1VLG93V5Owlo0TfQ/432ZmhoT8gSwPe9HO2sGV8kMiVFyCvZKaCgFchDxYPgxrLtwvqmlH+Gthv/NIb
X-Gm-Message-State: AOJu0Yzt1GlcHn2TxqmN8sp1HbrH0sigzpyseU6CLVhR2Jzr/dPJKswg
	Xy37N0myl7qPrkd+6nXOGv+oXSQNk1WkkQDDpQLubGb6bTTaieiP7+LtAoTALWzR+gXxeqIIrCF
	zwrgDLJSIXmf9v4GuC7pYSxC2y7VNWJzrKX+chx76mSLjZO19+/pk
X-Google-Smtp-Source: AGHT+IGTxZsr4XQT1tICM08M1+A0K2qVdTnTkeuA4HbyHKY1REYPRRhCdcwNtYY9cfBQGbEArd9Mh+XGJ7eHaEupAhQ=
X-Received: by 2002:aa7:c302:0:b0:571:d9eb:a345 with SMTP id
 l2-20020aa7c302000000b00571d9eba345mr43787edq.4.1713902039684; Tue, 23 Apr
 2024 12:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415122346.26503-1-fw@strlen.de> <ZieDYD5ibpGjlIRw@gmail.com>
In-Reply-To: <ZieDYD5ibpGjlIRw@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 21:53:45 +0200
Message-ID: <CANn89iJQZd8EPv+uXp4=+fbp4gMxa9d2CDdqmE3LwXV9makaZg@mail.gmail.com>
Subject: Re: [PATCH net-next] ip6_vti: fix memleak on netns dismantle
To: Breno Leitao <leitao@debian.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:46=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello Florian,
>
> On Mon, Apr 15, 2024 at 02:23:44PM +0200, Florian Westphal wrote:
> > kmemleak reports net_device resources are no longer released, restore
> > needs_free_netdev toggle.  Sample backtrace:
> >
> > unreferenced object 0xffff88810874f000 (size 4096): [..]
> >     [<00000000a2b8af8b>] __kmalloc_node+0x209/0x290
> >     [<0000000040b0a1a9>] alloc_netdev_mqs+0x58/0x470
> >     [<00000000b4be1e78>] vti6_init_net+0x94/0x230
> >     [<000000008830c1ea>] ops_init+0x32/0xc0
> >     [<000000006a26fa8f>] setup_net+0x134/0x2e0
> > [..]
> >
> > Cc: Breno Leitao <leitao@debian.org>
> > Fixes: a9b2d55a8f1e ("ip6_vti: Do not use custom stat allocator")
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  net/ipv6/ip6_vti.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> > index 4d68a0777b0c..78344cf3867e 100644
> > --- a/net/ipv6/ip6_vti.c
> > +++ b/net/ipv6/ip6_vti.c
> > @@ -901,6 +901,7 @@ static void vti6_dev_setup(struct net_device *dev)
> >  {
> >       dev->netdev_ops =3D &vti6_netdev_ops;
> >       dev->header_ops =3D &ip_tunnel_header_ops;
> > +     dev->needs_free_netdev =3D true;
>
> Thanks for the fix!
>
> Could you help me to understand how needs_free_netdev will trigger the
> free()here?
>
> I _though_ that any device that is being unregistered would have the stat=
s
> freed.
>
> This is the flow I am reading:
>
> 1) When the device is unregistered, then it is marked as todo:
>
>         unregister_netdevice_many_notify() {
>                 list_for_each_entry(dev, head, unreg_list) {
>                         net_set_todo(dev);
>                 }
>         }
>
> 2) Then, "run_todo" will run later, and it does:
>         netdev_run_todo() {
>                 list_for_each_entry_safe(dev, tmp, &list, todo_list) {
>                 if (unlikely(dev->reg_state !=3D NETREG_UNREGISTERING)) {
>                         netdev_WARN(dev, "run_todo but not unregistering\=
n");
>                         list_del(&dev->todo_list);
>                         continue;
>                 }
>
>                 while (!list_empty(&list)) {
>                         netdev_do_free_pcpu_stats(dev);

The relevant part is missing:

                         if (dev->needs_free_netdev)
                                  free_netdev(dev);

>                 }
>
>         }
>
> Thank you!

I do not think Florian patch has anything to do with free_pcpu_stats()

Please take a look at

git show cf124db566e -- net/ipv6/ip6_vti.c

