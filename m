Return-Path: <netdev+bounces-131756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16798F71A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A92AB20CF6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FE11ABEBB;
	Thu,  3 Oct 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTXOYDq+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB91A727F;
	Thu,  3 Oct 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984153; cv=none; b=rgZFnXlzShfhShTMlgL081TTzVo2L92ZQowQelmGgf1EaHPv88++zKL2zDX3B16CFfx9XD87REH9IakS6zyWn7gy007CrgqkLGx5vcZ3Fm8X5kWuHOllMFIa1T7WSxb6f6ZK/w1fAMxyOa37MTWFhldJlOY5wVsf04Gohs44FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984153; c=relaxed/simple;
	bh=nw8b1tPBPz7v246gmleo7xI5fYf3J2h/oIP8wKRmjww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYpsX1TcQqGMwtQWV8BmDjms6I2h5Dg4KLh+78iYrr1kd05nZuaOJ4W+YesWSzgP9LkFRnWqlA8mr1rfyo7CJton00PMVxqh7+POFKO5LkP0w9sehD5yiZ4NY5avuW2fCR118Wsl/JGFbFsFCwYWF4qdiVo3+up+qs9TIidGQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTXOYDq+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so1636743e87.1;
        Thu, 03 Oct 2024 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727984149; x=1728588949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0vG9Hv+uZYhhzWHDYoK5X+OOspMiS+Ux6peObsn32k=;
        b=hTXOYDq+Yyi8uq1WfnqKYK/vGiSTUaMrVnqE6Stt8N6vLZ4mJsE5u9RgesXo9WG5nF
         F9g9Xk2CJ/90HiKOG+ZlCq1faZo3FuCMEXt/EaefeNwGySCbHGaQQexYF35JX+ZOXQvR
         1g2+DHtiaw5UFR+4ZjJ/1Byo/GwklaZtFp9Mzgdc+fKxHMHIRCSMjkCTs3Y78uyQ/m9H
         mCP4OJ/MROQopN3ohKwRJndMyY1vsUOYSDbDAH7luHtmzDtxy0gOME1JaX+oMTx6fx6y
         n8J0z+WZb5Q1tefTunR50y3JAt5LPPtZrhWWqKIP+0vY4w7Bt/a1CNe57AxKfW98Qy6Z
         kRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984149; x=1728588949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0vG9Hv+uZYhhzWHDYoK5X+OOspMiS+Ux6peObsn32k=;
        b=wd+EBQskFmc/CMuW4qyAatFYosdAVda7kfVo+Qbp8ztjOOmFQPsrsggtTUo6BNvkDL
         pZDL3ud4OO+V2vMmiTDOcAQqdtuFxuctNe1RzncUv5HoVepgCE+mU5vrZYhbm7oBUjdb
         17vU5UE+ikmVH0/HQQplWIHGp1FtzvM5qxSFEvdt7yvOkHJgUD3tZKojIkHTLX//bi8A
         oQz/MEVM8VbTtti0NssoBAe7kJz0HzRv7gTQAn6E79hDYabHPNCwQEQgVenmKrMtKwfA
         E5ecjMBFliqnDbD/lnoWRLhPwgJOI9d6Amy0ISz+ehsa+/RCAwEAnUczTQapdEDSY1DK
         gc0A==
X-Forwarded-Encrypted: i=1; AJvYcCUGTxfYJr+lKp8CWP1svwB8AP5Y6Cyo/W8HAvj4gujSc3t6Wruk6kNqfYKNnxttASXd8qCh9rGZCUA=@vger.kernel.org, AJvYcCWSF/bq8ZIvPjfhOVRAyTi8EAowvIrfr48+3L1BJiL5uVTuaDLm2yptStzkZ1R4fEwwf8u8lUks@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqd8KYit9rkL5iWWpN1seUZkbtzUoXDXfb8mNRmz3VtdoUkCNI
	eGXYr1WxTj+T81t0kYDmNgfzEtpZzKAZmIpMOlgiShq4VhEBvwNxo8zw89hM12O/sThSKVyzgpv
	Z2WoohpyfHD38sfClTiZd1KX+R0E=
X-Google-Smtp-Source: AGHT+IFHx276JF6dEPNEZxIhzJ8OGEiEi9kpw1aQDCEv69JFAE2LD8/+cOMO0dLQhABrP6ZQ4zJAWV2DPO/qlu8Enj8=
X-Received: by 2002:a05:6512:3b90:b0:52c:e17c:3741 with SMTP id
 2adb3069b0e04-539ab84a281mr278818e87.5.1727984149054; Thu, 03 Oct 2024
 12:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-7-ap420073@gmail.com>
 <CAHS8izMjxvgMwh5MzwDKDw1wy7b_Eyua=LOrB1Kn6wFhcxE5bg@mail.gmail.com>
In-Reply-To: <CAHS8izMjxvgMwh5MzwDKDw1wy7b_Eyua=LOrB1Kn6wFhcxE5bg@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 04:35:37 +0900
Message-ID: <CAMArcTUoWisnZnY-AVCtT7W661f+Gd7RfKZ2MMwOTCktSQFhVw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] net: ethtool: add ring parameter filtering
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

On Fri, Oct 4, 2024 at 3:33=E2=80=AFAM Mina Almasry <almasrymina@google.com=
> wrote:
>
> On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> >
> > While the devmem is running, the tcp-data-split and
> > tcp-data-split-thresh configuration should not be changed.
> > If user tries to change tcp-data-split and threshold value while the
> > devmem is running, it fails and shows extack message.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> >  - Patch added
> >
> >  net/ethtool/common.h |  1 +
> >  net/ethtool/rings.c  | 15 ++++++++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> > index d55d5201b085..beebd4db3e10 100644
> > --- a/net/ethtool/common.h
> > +++ b/net/ethtool/common.h
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/netdevice.h>
> >  #include <linux/ethtool.h>
> > +#include <net/netdev_rx_queue.h>
> >
> >  #define ETHTOOL_DEV_FEATURE_WORDS      DIV_ROUND_UP(NETDEV_FEATURE_COU=
NT, 32)
> >
> > diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> > index c7824515857f..0afc6b29a229 100644
> > --- a/net/ethtool/rings.c
> > +++ b/net/ethtool/rings.c
> > @@ -216,7 +216,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, st=
ruct genl_info *info)
> >         bool mod =3D false, thresh_mod =3D false;
> >         struct nlattr **tb =3D info->attrs;
> >         const struct nlattr *err_attr;
> > -       int ret;
> > +       struct netdev_rx_queue *rxq;
> > +       int ret, i;
> >
> >         dev->ethtool_ops->get_ringparam(dev, &ringparam,
> >                                         &kernel_ringparam, info->extack=
);
> > @@ -263,6 +264,18 @@ ethnl_set_rings(struct ethnl_req_info *req_info, s=
truct genl_info *info)
> >                 return -EINVAL;
> >         }
> >
> > +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED ||
> > +           kernel_ringparam.tcp_data_split_thresh) {
> > +               for (i =3D 0; i < dev->real_num_rx_queues; i++) {
> > +                       rxq =3D __netif_get_rx_queue(dev, i);
> > +                       if (rxq->mp_params.mp_priv) {
> > +                               NL_SET_ERR_MSG(info->extack,
> > +                                              "tcp-header-data-split i=
s disabled or threshold is not zero");
> > +                               return -EINVAL;
> > +                       }
>
> Probably worth adding a helper for this. I think the same loop is
> checked in a few places.
>
> Other than that, yes, this looks good to me.

Thanks, I will add a helper function for this in a v4 patch.

Thanks a lot,
Taehee Yoo

>
>
> --
> Thanks,
> Mina

