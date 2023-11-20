Return-Path: <netdev+bounces-49198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6B7F112D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A61F23AF8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9AC125BB;
	Mon, 20 Nov 2023 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OONPdmZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC9B10C
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:01:30 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c87adce180so16691511fa.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700478088; x=1701082888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PPW06YC38erq8SZWtv+ncf66iEcbQv3rHXBqyT0lxI=;
        b=OONPdmZ1Yiv1fuSttkzmSfdEaygm7Oz6P1uEM1iBmrP9C/zMyf+VOuVL2tmNdhcDvX
         K2zY+U2A5aIJ+mngg9/K7fLtmg6vDRgF8KKcDqcPdNSh6epIqvAytnt35JgZchJBnN7z
         UtH3Aisk7IAr1maAbKJGNlx3/52piaq3ButxyH/7bfm3mg445rir59Abx9RieW2eKnxF
         1X4rJijFScvemdVc8eX8fjX5dTS1ei4fPdLsV5FljGDNC1aeJcckhbu1atWvVOdeLDRY
         4pirimsf97CzoxTiS7a+f6f+ZjHSyk0Y3BzAVdw7HlatsHmo1RfhkrYbzQY6F6NkLphf
         /SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478088; x=1701082888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PPW06YC38erq8SZWtv+ncf66iEcbQv3rHXBqyT0lxI=;
        b=cDdJ253gLeJuqB0i5tmM7ce3mTYpru0UBrp+KyccREf9iAKRFkHo8NvPyUkpWb8T/f
         ViYRjipRlBrPtPuSN68ED1BaFWpAd5aXg4Jbc+3VG3beqIXPw2ZZOF4XKbLLiEr8LDq3
         EG4RCa/mtY2rNNoeJ085P5BSjFYAFyvdPYs8LQHPce1lP3yHRmuUgN4y9rwcnvRY/0Wk
         V2glraZ2443tmnAbMgiT0Za6WXvynxLDa4J1QnRZSRHytzx9PzEaB726Iw+WdGKrpkX+
         2jMKHPVJJM3CfmqnXsTqxvkfe8IWRHkN97ovCehcXrGbXMwNFyHq5lDQS5jnohhHP7Pz
         19fQ==
X-Gm-Message-State: AOJu0Ywk1pJ2W4sBAozu4TOjyiVM1HMpQH1I1yRPqOFaoPsIIuEni+za
	wZNmvLYFjj+wOMO68p9APCjsoZTqGXnq9yxTrCQHUw==
X-Google-Smtp-Source: AGHT+IGqrl+BKwsuiltU8GvpE7zptGLvkTub9X/9cMNcMb3F3anQAwtf3Dxg4wx6drjoVWqrc6khwBJvqgi+N0M4OTM=
X-Received: by 2002:a2e:b60c:0:b0:2ba:6519:c50f with SMTP id
 r12-20020a2eb60c000000b002ba6519c50fmr4938095ljn.52.1700478088590; Mon, 20
 Nov 2023 03:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
 <ZVcxmwm/DRTB8QwO@lore-desk> <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
 <ZVssMWXZYxM0eKiY@lore-desk> <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
In-Reply-To: <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Mon, 20 Nov 2023 19:01:16 +0800
Message-ID: <CABKxMyO0oExMvKbZ32_Qh+3ezcY8CK0AYjxL6B2iD3DQ26J_Kg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Toshiaki Makita <toshiaki.makita1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance.com> =E4=BA=8E2023=E5=B9=B411=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 18:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=80 17:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > > > > veth network device will display some error statistical values.
> > > > > The value of tx_idx is reset with each iteration, so even if
> > > > > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > > > > will remain constant. This results in incorrect statistical value=
s.
> > > > > To fix this issue, assign the value of pp_idx to tx_idx.
> > > > >
> > > > > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit=
 accounting")
> > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > ---
> > > > >  drivers/net/veth.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > > > > --- a/drivers/net/veth.c
> > > > > +++ b/drivers/net/veth.c
> > > > > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net=
_device *dev,
> > > > >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> > > > >               const struct veth_rq_stats *rq_stats =3D &rcv_priv-=
>rq[i].stats;
> > > > >               const void *base =3D (void *)&rq_stats->vs;
> > > > > -             unsigned int start, tx_idx =3D idx;
> > > > > +             unsigned int start, tx_idx =3D pp_idx;
> > > > >               size_t offset;
> > > > >
> > > > >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ=
_STATS_LEN;
> > > > > --
> > > > > 2.20.1
> > > > >
> > > >
> > > > Hi Albert,
> > > >
> > > > Can you please provide more details about the issue you are facing?
> > > > In particular, what is the number of configured tx and rx queues fo=
r both
> > > > peers?
> > >
> > > Hi, Lorenzo
> > > I found this because I wanted to add more echo information in ethttoo=
l=EF=BC=88for veth,
> > > but I found that the information was incorrect. That's why I paid
> > > attention here.
> >
> > ack. Could you please share the veth pair tx/rx queue configuration?
> >
>
> dev: tx --->4.  rx--->4
> peer: tx--->1 rx---->1
>
> Could the following code still be problematic? pp_idx not updated correct=
ly.
> page_pool_stats:
> veth_get_page_pool_stats(dev, &data[pp_idx]);

I did the test locally and there is no problem with this place. I
didn't fully understand
this piece of code before
thanks.
BR
Albert.

>
> BR
> Albert
>
> > Rergards,
> > Lorenzo
> >
> > >
> > > > tx_idx is the index of the current (local) tx queue and it must res=
tart from
> > > > idx in each iteration otherwise we will have an issue when
> > > > peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
> > > >
> > > OK. I don't know if this is a known issue.
> > >
> > > BR
> > > Albert
> > >
> > >
> > > > Regards,
> > > > Lorenzo

