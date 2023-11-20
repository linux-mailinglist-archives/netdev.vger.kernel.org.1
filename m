Return-Path: <netdev+bounces-49157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB127F0F51
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AEC2813B7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C011CA0;
	Mon, 20 Nov 2023 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="em0LFo0+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E00295
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 01:46:01 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso54490091fa.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 01:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700473559; x=1701078359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkX770QsciZgmyIjGlD/aDGrwKJCqahJAwyCfq7+gms=;
        b=em0LFo0+cNdIwjHui+KvAJqhsgPFIryudKSw7lvCaZkfx5RO7o8Mqc7OrgvX6AyGuH
         PhkeM8C5Us3U6x/f1oeEjd5/4IW98UwJK0lzs0fM5/5LMwfluNFD6GHv14CXje6Vw92m
         oXuWl7mhIf2tp2bD9maiczdrRXQtRVjNRDQucBbBQIiJ2SbGgZGsgvHFtqMQhgl0qxoP
         zXeAub3ZG6LY8bFr1tI/FZQtylF+Xz9ryw/lVGpKRgYQbQskQJg+Wfst3Vswdk2zRde5
         C9sXJQY8Kl3n1wC8/tJloR9et6V7DOoQrXvJzOoGeG5tuwqVJV3JUF98qYMLZgHz35fY
         wQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473559; x=1701078359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkX770QsciZgmyIjGlD/aDGrwKJCqahJAwyCfq7+gms=;
        b=ssMCdrUmVsW64MwNGXVbahtENFLPx+o5Q+QwP8haJVOJNjjEfucs/KA3YESUuruFsj
         xoRzzw2cDnrSiW5dNwhEpwRnvM31VHFgDOxOpB2qYeTitOpZneosyb/X16Ra/79pBcxz
         5KN9POZrYI4mQevCbETo5onBl/aGmOnh6YhCt6GjqLOYCQGteElLJ7vkNbEtPNAOOBtE
         925y+euQWhNNKhjXy/kp1k0gn5yS7vdnUGiOP1BVlvMVuyfOU5GhArW6zBQ3DOi+egI7
         tGIDSXXjjF4PTC3slt9Em+rWRE3tSHj9PIB2YzQE4xChl06rXLuasfFY9BBV3jJthCJ5
         qanw==
X-Gm-Message-State: AOJu0YzSZCeo4TsonJ+GkxiBVEtORsoqscQMgClej3+QzxacbbIItvj3
	/RvDcmhILcIN6G18g4LY5HtZkI/HmEAFEmrtafMOxy1PpDORYFDNNqoxyLc4
X-Google-Smtp-Source: AGHT+IEXtmIeiiZFXoFRKaKbc0qrn9hxoDeZVP3wrl6QX3VQYn1t47LiuGEcBE/xagf4bs0P7gMKS4so7X7kWUS/TJM=
X-Received: by 2002:a2e:8e38:0:b0:2c6:ed5e:bbf0 with SMTP id
 r24-20020a2e8e38000000b002c6ed5ebbf0mr4711811ljk.34.1700473559467; Mon, 20
 Nov 2023 01:45:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116114150.48639-1-huangjie.albert@bytedance.com> <ZVcxmwm/DRTB8QwO@lore-desk>
In-Reply-To: <ZVcxmwm/DRTB8QwO@lore-desk>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Mon, 20 Nov 2023 17:45:47 +0800
Message-ID: <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Toshiaki Makita <toshiaki.makita1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
>
> > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > veth network device will display some error statistical values.
> > The value of tx_idx is reset with each iteration, so even if
> > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > will remain constant. This results in incorrect statistical values.
> > To fix this issue, assign the value of pp_idx to tx_idx.
> >
> > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit accou=
nting")
> > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > ---
> >  drivers/net/veth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_devic=
e *dev,
> >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> >               const struct veth_rq_stats *rq_stats =3D &rcv_priv->rq[i]=
.stats;
> >               const void *base =3D (void *)&rq_stats->vs;
> > -             unsigned int start, tx_idx =3D idx;
> > +             unsigned int start, tx_idx =3D pp_idx;
> >               size_t offset;
> >
> >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ_STATS=
_LEN;
> > --
> > 2.20.1
> >
>
> Hi Albert,
>
> Can you please provide more details about the issue you are facing?
> In particular, what is the number of configured tx and rx queues for both
> peers?

Hi, Lorenzo
I found this because I wanted to add more echo information in ethttool=EF=
=BC=88for veth,
but I found that the information was incorrect. That's why I paid
attention here.

> tx_idx is the index of the current (local) tx queue and it must restart f=
rom
> idx in each iteration otherwise we will have an issue when
> peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
>
OK. I don't know if this is a known issue.

BR
Albert


> Regards,
> Lorenzo

