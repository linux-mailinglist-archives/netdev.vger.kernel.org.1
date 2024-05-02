Return-Path: <netdev+bounces-93075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C548B9ED7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3871F22805
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8438A168B17;
	Thu,  2 May 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mv3RmWdW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818028FC
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668425; cv=none; b=lB7YgxcQM80xW5q6ToD8FFiKX3XwURopz3+/DavL2zunatEZypqbue29ln9lN975YprHEvjb7EgDY8UkSRuy6gZAbyukAwFE8n24O90/HDpBI2f51UgtSUh9UbeBiIUJPsTISwP6aGDO/YtTnJqU0D+ZyWOIspYinamo4IIaFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668425; c=relaxed/simple;
	bh=oDNk5qYgD7yVHSbKSWXn2mwGCstw1JQ1dk6/xoHpdsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCUAsuNCN/q/zparxE0nIaHZxTN/tcq7v8nmN4+CyRp7V4ILwHV3aIuHAr7Gem4OPGK39hWZWD4YrihYqX84vD6BZXQJYlo9pabd+/G1tK8xW2qZM05XzI+bSHpMkYpGO5D2eE/0XjDOPYOQ2wm89+nApnl7oLGASP7Q0BU/9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mv3RmWdW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so1785874e87.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714668422; x=1715273222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4td1hFwD729pZEeJiz87l0enKAUDFyw43vwN5ZwJtuE=;
        b=Mv3RmWdWRQs/0rdaOlmaWOVU74oAoDC9eHcSOqmYvSR+EqkEQtN3l0i5OHfyqG4HfA
         SoAxqu0HXUZJx4Ve4nwSxiLxFO4jYrL49O7rMX/W7tVo1OQys+6n63uiE1QVaT/RQtyX
         Qssrgd+At/RXwp3SaUdx2gsZHWYFcECOb8+QrNFTAIO1+mLJ91k+Lvc7rKMJm1Fd0MRG
         lEd/ZBy6QZ8eco1V2D7yYOCKzv0yWvw6ppGgrG/HiM8gfpvstVDqej5Ir0VFoDNWCo9k
         +SQkerFip6cTQ3OnE5SCe6LIOmpeoKxuievIk3eHyHy/9ClC2E13PePAopjRAxlkoLGM
         dEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714668422; x=1715273222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4td1hFwD729pZEeJiz87l0enKAUDFyw43vwN5ZwJtuE=;
        b=dUydZB6UBU8ZkFOMVsCK0t89ph+gSbwkSV7l1ze2qK0/zdYzxsXwE06WtGmoMeIfR8
         xtQvLORkY2138ZQifxj5aF6HpenWeUfwCFqTsnZgWktuABn2IN337ojXYZnGejH1DWzv
         csUYDWR3E89tZn/Mt1HH4tzdTkpNRUqMHz09OanmecuP6fYNN42LVtDGp8VfurmDjyWd
         3lAKFLozTXBWTxcXHFjGC4LFl5vBORl3hg5LBTrlQ6Uvf9isDjvE0jafTfYZfVXKae0Z
         noab/l1ayM7S578/c8T8qHIIU7tEUK7VqAwNpUhIcgsBYDMUCZQ1UaTbICgEyZVB6Uy0
         mKEA==
X-Gm-Message-State: AOJu0YzlbnkJfFtsFs5v9juLtUzor0z1n/xBDCRIoAbL7EtnckaUMZVX
	oHrFYDPwHr/2ihVruRgDHDEzrEVpjOLGtN62lDTQjKV3MfJFfqXTa/VIyRi4i3/YKZyk9Jn+zrc
	N7H/b4x7a3Xk3EaEycK7uI1DoRxB5JuhfCVOi
X-Google-Smtp-Source: AGHT+IGyDm/bdxPXxsUyf7pcPCRHAuj+vtA9AbHNO60ovCi5aO45do2l7JtJWPbXmxXUOM/+nLzxcgAL8AfYYknsvB0=
X-Received: by 2002:a05:6512:36cf:b0:51d:4c8a:bbdb with SMTP id
 e15-20020a05651236cf00b0051d4c8abbdbmr293643lfs.3.1714668421622; Thu, 02 May
 2024 09:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010732.666512-1-dw@davidwei.uk> <20240430010732.666512-4-dw@davidwei.uk>
 <CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com> <5f81eccd-bc14-47a5-bc65-b159c79ce422@davidwei.uk>
In-Reply-To: <5f81eccd-bc14-47a5-bc65-b159c79ce422@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 2 May 2024 09:46:46 -0700
Message-ID: <CAHS8izMzakPfORQ9FX8nh0u0V7awtjUufswCc0Gf3fxxXWX0WA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 3/3] netdev: add netdev_rx_queue_restart()
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 6:04=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-04-30 11:15 am, Mina Almasry wrote:
> > On Mon, Apr 29, 2024 at 6:07=E2=80=AFPM David Wei <dw@davidwei.uk> wrot=
e:
> >>
> >> +err_start_queue:
> >> +       /* Restarting the queue with old_mem should be successful as w=
e haven't
> >> +        * changed any of the queue configuration, and there is not mu=
ch we can
> >> +        * do to recover from a failure here.
> >> +        *
> >> +        * WARN if the we fail to recover the old rx queue, and at lea=
st free
> >> +        * old_mem so we don't also leak that.
> >> +        */
> >> +       if (dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, old_mem)) {
> >> +               WARN(1,
> >> +                    "Failed to restart old queue in error path. RX qu=
eue %d may be unhealthy.",
> >> +                    rxq);
> >> +               dev->queue_mgmt_ops->ndo_queue_mem_free(dev, &old_mem)=
;
> >> +       }
> >> +
> >> +err_free_new_mem:
> >> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
> >> +       rtnl_unlock();
> >> +
> >> +       return err;
> >> +}
> >> +EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);
> >
> > Does stuff outside of core need this? I don't think so, right? I think
> > you can drop EXPORT_SYMBOL_GPL.
>
> Not sure, we intend to call this from within io_uring. Does that require
> exporting or not?
>

I don't this this requires exporting, no.

> Later on I'll want to add something like
> netdev_rx_queue_set_memory_provider() which then calls
> netdev_rx_queue_restart(). When that happens I can remove the
> EXPORT_SYMBOL_GPL.
>

Sorry, I think if we don't need the EXPORT, then I think don't export
in the first place. Removing an EXPORT is, AFAIU, tricky. Because if
something is exported and then you unexport it could break an out of
tree module/driver that developed a dependency on it. Not sure how
much of a concern it really is.


> >
> > At that point the compiler may complain about an unused function, I
> > think, so maybe  __attribute__((unused)) would help there.
> >
> > I also think it's fine for this patch series to only add the ndos and
> > to leave it to the devmem series to introduce this function, but I'm
> > fine either way.
> >
>
> I'd like to agree on the netdev public API and merge alongside the queue
> api changes, separate to TCP devmem. Then that's one fewer deps between
> our main patchsets.

Ah, OK, sounds good.

I was thinking both efforts would use the ndos, but I think you're
thinking both efforts would use the netdev_rx_queue_restart. Yes, that
sounds reasonable.


--
Thanks,
Mina

