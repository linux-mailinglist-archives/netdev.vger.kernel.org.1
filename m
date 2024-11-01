Return-Path: <netdev+bounces-141089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468169B971D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4861B214B3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5196B1CDFAC;
	Fri,  1 Nov 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo5m7Obc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231214F132;
	Fri,  1 Nov 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484513; cv=none; b=SfW4KRX/dNXDqLwcP8dukazqkxj2Ih5I78CfNDSIg77imSZDKSzDHywo5CU32l+UNt8R3p3BCN8MnwornMDabg0NzvtsWXeJ+MNxMKqY25MMwLjQk25Wf6wp+EmgA8bYoZUtqOvcJLvvkLBl3WyTky0S2wAs0WMMSyrS70oVQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484513; c=relaxed/simple;
	bh=kUlkaiEAbITpS5libgwOHCPxndGIP44TyCYpqXX2sCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLwHaSmKPZllour4ncTjFOUlMofOc7kc3yArcmBSsrfGr7Al6hBFkD6373NyrkjkYs5omEjUK4GSzDmkNG3qvfD1mEiowHMK6Ha6OGCxAtHem6ZGov7lt7IRJJotMx9yidHO10EiHifUZm5i9vTRE6rNQ2lslpRvQROEEjh1YiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo5m7Obc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so155772266b.3;
        Fri, 01 Nov 2024 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484510; x=1731089310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCtfL4LKHT16bIcd7QMas0zSxNmGktKU2W/PiR+cLdA=;
        b=jo5m7Obcq+O7EZwiP/XUFW7vZgq6Qu/b1D+OuoUmveJl2CqwRY1sckShFrDGFQW9ZH
         DJeHXTFoQHMBuiuL25d8BjvAwS1jDyzLVDlWa8Z2l8XwpbWH/5xW+dVcvL8da7OkGCx7
         TDGK+qUfFDetDygw7DcUE7Lf9xxl6P1pJgNxK21GGMv44Dy/c5h02/v0+dq8yB2uAUuh
         qhoz/qKpO6Ks3PSVjW5GJs2EJlqR1tqxvzYX6/2CNnp0BWb8idfgKwaxMFecUogXaamp
         O85u2/WfLiYsyId0WJ0EV+sRLUxOhyG2u4h45L9oSQNNPwj/tC9IyvFIQS/oIX5P3Fi4
         D5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484510; x=1731089310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCtfL4LKHT16bIcd7QMas0zSxNmGktKU2W/PiR+cLdA=;
        b=Xfo05r1LtBuIAYYKyRu3m8uc5NWNXWf5NF13zNOlJzJ69mXHzS7OjYF7BdRaRSZ4aE
         dgeAsLvwZ1uWE8bfYWJVlBu5Qc0O3k3aAqZkOxpnzMWoJ+YUu/Rnmg1ic1rguIbDNFCA
         RneUKctxhbWwNbQncCFdQOdeVJ72ozzqCOzi3g6PvffadnW0KJC9KO3vb9xHsrs8jISe
         lWnbT4euHMartLTk3GJc1ybgXvPd78kwkr5xeRw0/Tkh6Do8dqFQPv6WmgL30KerssvV
         Vjj8THIQ4W6ZlP4jQR+ekBgrka+JYYjWTvPeaS4UUgoCcgWOayyqVma06fAgaxean7RW
         8RDA==
X-Forwarded-Encrypted: i=1; AJvYcCUZe+ueiQu8YaFJfv8altbvCPtXGBB4kAVnDD+1/PKK4sapQ26NVH7uwxZNgMhEZBFCPd8qZ22S@vger.kernel.org, AJvYcCVwjimj7VubaC70Mp+8gD0L9djDJ54B3v0Oj3qQugVtGYMC/+VfcmKBANXvD/H+1V+1zY3ayPuNqC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuX+rZpIhd1/tjYx+58JJta13/RsC5kUcHRRNZpN2D+mhkocHc
	BBX3pmCWqk3/l760lEtAl+0H6jRBoVFZfj8MuLNHB178NBZim+8BW+EAiA0oMwwP3akhMJHUFz0
	U4qvxuselx4uWYzmsIoAl/uuBjho=
X-Google-Smtp-Source: AGHT+IHsQJRWuTtNCKMdaamaYNellvKQy+MGvR0wU3bd0Udn5YV99dp3SCMg6+sdMqCBWuD+vOxqtsHpUCD/03Lpc2E=
X-Received: by 2002:a05:6402:524b:b0:5ce:afba:f48a with SMTP id
 4fb4d7f45d1cf-5ceb935bbc3mr4809875a12.27.1730484509256; Fri, 01 Nov 2024
 11:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-7-ap420073@gmail.com>
 <CAHS8izMingYgf_ZuGWZMFNb3QGGkqKFjYwWvFpdbLW5yBWvvng@mail.gmail.com>
In-Reply-To: <CAHS8izMingYgf_ZuGWZMFNb3QGGkqKFjYwWvFpdbLW5yBWvvng@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 2 Nov 2024 03:08:17 +0900
Message-ID: <CAMArcTXzTQJuA2q26i61OFgOSrnAvOyNWKFbW59V+h4WqBt_3g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/8] net: ethtool: add ring parameter filtering
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 11:35=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Oct 22, 2024 at 9:25=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > While the devmem is running, the tcp-data-split and
> > header-data-split-thresh configuration should not be changed.
> > If user tries to change tcp-data-split and threshold value while the
> > devmem is running, it fails and shows extack message.
> >
> > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v4:
> >  - Add netdev_devmem_enabled() helper.
> >  - Add Test tag from Stanislav.
> >
> > v3:
> >  - Patch added
> >
> >  include/net/netdev_rx_queue.h | 14 ++++++++++++++
> >  net/ethtool/common.h          |  1 +
> >  net/ethtool/rings.c           | 13 +++++++++++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queu=
e.h
> > index 596836abf7bf..7fbb64ce8d89 100644
> > --- a/include/net/netdev_rx_queue.h
> > +++ b/include/net/netdev_rx_queue.h
> > @@ -55,6 +55,20 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *qu=
eue)
> >         return index;
> >  }
> >
> > +static inline bool netdev_devmem_enabled(struct net_device *dev)
>
> Mega nit: netdev_memory_provider_enabled().
>
> This is actually not devmem specific, and there is already an io_uring
> provider in the works.
>
> But, also, we already have dev_get_min_mp_channel_count() defined in
> linux/netdevice.h. Lets re-use that one instead of adding another
> helper that does almost the same thing. Sorry, I should have
> remembered we already have this helper in the last iteration.

Ah, I didn't catch it too.
I will use dev_get_min_mp_channel_count() instead.
Thanks a lot!

>
> Other than that, looks fine to me.
>
> > +{
> > +       struct netdev_rx_queue *queue;
> > +       int i;
> > +
> > +       for (i =3D 0; i < dev->real_num_rx_queues; i++) {
> > +               queue =3D __netif_get_rx_queue(dev, i);
> > +               if (queue->mp_params.mp_priv)
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> >
> >  #endif
> > diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> > index 4a2de3ce7354..5b8e5847ba3c 100644
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
> > index e1fd82a91014..ca313c301081 100644
> > --- a/net/ethtool/rings.c
> > +++ b/net/ethtool/rings.c
> > @@ -258,6 +258,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, s=
truct genl_info *info)
> >                 return -ERANGE;
> >         }
> >
> > +       if (netdev_devmem_enabled(dev)) {
> > +               if (kernel_ringparam.tcp_data_split !=3D
> > +                   ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
> > +                       NL_SET_ERR_MSG(info->extack,
> > +                                      "tcp-data-split should be enable=
d while devmem is running");
>
> Maybe: "can't disable tcp-data-split while device has memory provider ena=
bled"

Thanks! I will use it!

>
> > +                       return -EINVAL;
> > +               } else if (kernel_ringparam.hds_thresh) {
> > +                       NL_SET_ERR_MSG(info->extack,
> > +                                      "header-data-split-thresh should=
 be zero while devmem is running");
>
> Maybe: "can't set non-zero hds_thresh while device is memory provider ena=
bled".

Thanks, I will use it too.

Thanks a lot!
Taehee Yoo

>
>
> --
> Thanks,
> Mina

