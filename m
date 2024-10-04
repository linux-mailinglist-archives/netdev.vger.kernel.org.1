Return-Path: <netdev+bounces-131870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D818398FC97
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 05:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA29283C29
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 03:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62543D982;
	Fri,  4 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUmrGfaU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088FC1876;
	Fri,  4 Oct 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014285; cv=none; b=FM4FQLCfJQpiXm+6SL1CD4e7QxseRXB9Sc+5srq/1O/9vKmjK6aPjYCyA+/1XBRPbVY4Ix0Zpd/2hQGkkTNrm56jgif1x6OYrI8qYRscw78sGvYCt/KqCa4JARElsdhfPzgRaPonfOjmVLwBjlhw1bhq2ZeylHuE6ocRPDs+Mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014285; c=relaxed/simple;
	bh=AwSGznrR3WC2D1TsXQBXBds+683tpB7Pik4CHBLfs2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9pYSkf9JXHTiZCWZQ6o0KzmRTxSPYnPSS4w43pO4UReObyTuvEfnJ1i6tMOZhlYeXHW2t32+JQCw1qVAQD3fGGD64NQjiNZLeB9nqr487yQLfhyLj6r56RBqzE10xpYtzfMeQZmB7WxfQKobDGiaEUiGg44icTV9f46jAXmQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUmrGfaU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so2794899a12.1;
        Thu, 03 Oct 2024 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728014282; x=1728619082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBl4ky6od+/pL5FKy6uBonSrJk3T+eK4daQjsHg2Fwc=;
        b=QUmrGfaUWDQSWUtq5b1GPe+bS+PWUbgBuYFDAobpjELDyQmiK4b5q7uw+Ev322oQ8r
         uUjrdYcy/hFJC2LvKyiV+6/+hUYyP7im3Q4CQgYA6uHBFlSARvwMjv85WjgGHaCNT+hx
         oHkg1r1SNuVZcbyz4rO7bAqa7uBRkOJ5D+3TKM35ZxPMaIVa2XBQYZuPDnu2vTGxN4mt
         5vc6UV7TAO4pxwZPNJpaPPo0DQVr/j7diQ6G48HcJccyzHM+Xy8loDjS0tFO9CDEGwty
         KezcaPO9kzOsSpA27cAy20McujgFOG+KDiXmRkZsPYBe7FvrFMFKyJzHUWXnamu4nAaU
         hmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728014282; x=1728619082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBl4ky6od+/pL5FKy6uBonSrJk3T+eK4daQjsHg2Fwc=;
        b=FloY8HC2YOq3SmnMJV//qNs0NxtSw6DFzAxH/RYFPUSea6mYFZBnkcp4piQ9Ilz6nO
         kl3I264SAbFJrJRGnxGAX81wDrlyE6+1gXCWgvqsmUK/Thzhrl9d5CSspwREskPjKvHJ
         VgAcpaSouV+qHpGQAh75xbJaW2ClipPkapbuGTgxVw1roANpymLSc/zmfsA2sL7PMAZd
         qLGx8MAc1XW3lNg1lS/npNQbcd7DJnasry75TueGnrcu8j3eSA5vJutN8cuIQa4+99Oh
         FZE1Yj8QsDoK0e1NCXdbd8sAXOFh+/Z2zNC+t2TV4EoBtFMN6Zmv0ejHaJGfcIPFkTVi
         WGGw==
X-Forwarded-Encrypted: i=1; AJvYcCVEMQEsbBVO2OqTv6dkRVv5xyHP+XrgjB3DW0q7xcKK2bWQhz7TmQoAQjkQiELvgwGYo4cBnNL3@vger.kernel.org, AJvYcCXgKSKl684NVVmEeRKPthH7opImuXiHfdP78nBDv2/TCkZHfLWDK2eJtV8GBrIHpXU15yVKq9vtU5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOOXBNLnLGJ+a1erczZ861xAS6upWXplikbqATnYpH6leUboTp
	k+aon1v7ie+w1ezZZlQN4BKKb0LLhQheDo26ghDATE2ywaecB/toJ6/DxGYMeRsEq4901AwJgCM
	rnScZld34JE0mKTbZZEUaUonXD30=
X-Google-Smtp-Source: AGHT+IHciwcWEFRS2qe2KxhQISTUJvfOitpn4Zr4fd5jigXxJ4Bts/6yrlkhTIkQK4wTp1NeFq8dWWnqlh59wCxdiFI=
X-Received: by 2002:a05:6402:13cb:b0:5c4:1c0c:cc6d with SMTP id
 4fb4d7f45d1cf-5c8c08d3e64mr5843321a12.0.1728014281879; Thu, 03 Oct 2024
 20:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-6-ap420073@gmail.com>
 <CAHS8izNwnBnZf6P0WtAcg+MjmaxXDZ++kYit8_Ac8r6y=cDMAQ@mail.gmail.com>
In-Reply-To: <CAHS8izNwnBnZf6P0WtAcg+MjmaxXDZ++kYit8_Ac8r6y=cDMAQ@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 12:57:50 +0900
Message-ID: <CAMArcTWP8KNWiYt7xf=yj=e45fJuqg8ENi8CowtfBLy0DEMUYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] net: devmem: add ring parameter filtering
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:29=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>

Hi Mina,
Thanks a lot for the review!

> On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > If driver doesn't support ring parameter or tcp-data-split configuratio=
n
> > is not sufficient, the devmem should not be set up.
> > Before setup the devmem, tcp-data-split should be ON and
> > tcp-data-split-thresh value should be 0.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> >  - Patch added.
> >
> >  net/core/devmem.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 11b91c12ee11..a9e9b15028e0 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -8,6 +8,8 @@
> >   */
> >
> >  #include <linux/dma-buf.h>
> > +#include <linux/ethtool.h>
> > +#include <linux/ethtool_netlink.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/mm.h>
> >  #include <linux/netdevice.h>
> > @@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_devi=
ce *dev, u32 rxq_idx,
> >                                     struct net_devmem_dmabuf_binding *b=
inding,
> >                                     struct netlink_ext_ack *extack)
> >  {
> > +       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> > +       struct ethtool_ringparam ringparam =3D {};
> >         struct netdev_rx_queue *rxq;
> >         u32 xa_idx;
> >         int err;
> > @@ -146,6 +150,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_dev=
ice *dev, u32 rxq_idx,
> >                 return -EEXIST;
> >         }
> >
> > +       if (!dev->ethtool_ops->get_ringparam) {
> > +               NL_SET_ERR_MSG(extack, "can't get ringparam");
> > +               return -EINVAL;
> > +       }
> > +
> > +       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> > +                                       &kernel_ringparam, extack);
> > +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED ||
>
> The way I had set this up is that the driver checks whether header
> split is enabled, and only sets PP_FLAG_ALLOW_UNREADABLE_NETMEM if it
> is. Then core detects that the driver did not allow unreadable netmem
> and it fails that way.
>
> This check is redundant with that. I'm not 100% opposed to redundant
> checks. Maybe they will add some reliability, but also maybe they will
> be confusing to check the same thing essentially in 2 places.
>
> Is the PP_FLAG_ALLOW_UNREADABLE_NETMEM trick not sufficient for you?

Ah okay, I understand.
It looks like it's already validated enough based on
PP_FLAG_ALLOW_UNREADABLE_NETMEM.
I tested how you guided it, and it works as you intended.
It's a duplicated validation indeed, so I will drop this patch in a v4.

Thanks a lot!
Taehee Yoo

>
> > +           kernel_ringparam.tcp_data_split_thresh) {
> > +               NL_SET_ERR_MSG(extack,
> > +                              "tcp-header-data-split is disabled or th=
reshold is not zero");
> > +               return -EINVAL;
> > +       }
> > +
> >  #ifdef CONFIG_XDP_SOCKETS
> >         if (rxq->pool) {
> >                 NL_SET_ERR_MSG(extack, "designated queue already in use=
 by AF_XDP");
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> Mina

