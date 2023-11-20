Return-Path: <netdev+bounces-49165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419437F0FAF
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F189A281A17
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953CD125A5;
	Mon, 20 Nov 2023 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KdwCFp2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3416CEB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:03:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50906f941so56693181fa.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700474579; x=1701079379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg4iUdv1qOzfMKdHlqA4NidrBnEmUd5kiYhnaCQ/qFE=;
        b=KdwCFp2Qk1NKZqF5AMMZHjE+sb51l7I0A4A0OeciwZeHKeb4e88pPteF8WD3IrhpIp
         Tim5edihXx2AI61W/BSbj+SPvAJC4cEAoyUHvmzrdXopPSP8wDwxRyHJF1MhfzeAvDTw
         0fUyHcpPX4Gt4WvfuwV4RjPtgjxAbnlZQ0vJFtIq+oO01Jyuua7+E9rJPfz5/mVqiT4i
         xkcjHWmKxWmqA3L7bK8vIXXZUNfcOuDsgc1A3OrewMCMmOecqRGvqSx+QF0KJjYJB8Gv
         aOmNEwWZqN7sAW/h4YS70+fnCa2jAeYbKspzVPHsyuOSeAsTSrzqJTOZKaK71+SD8VD7
         6efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474579; x=1701079379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg4iUdv1qOzfMKdHlqA4NidrBnEmUd5kiYhnaCQ/qFE=;
        b=QA4j9NBn5wTybW1vLbtRsJSTvLBO23kKVVbvD6FVhNuYPf1TPYtNfTgoqTUj2otZ6g
         gKf0QCqejLAJFEQgSaAwnq9EN9L8aijYweIG9wnDzCpyZAI0x3hy1bsB0w7whSbgn6RR
         zurkLfXZT3WO8LxfAFu3JWUiyvazYHmzcbXrJCxnLkTt9VJMxqE6LA15t4s6cAGKnzq8
         qrJAsc4KLtcDnxip7FpX3sLmlpVdplH6diZJl6WAysyCovSVIT3Gbd/pkBP6ZB7XEpqU
         zSpZK+OqcRILpTviHYfiXXaNHTgWZ9QsB49xBcakxEvGI2G7X2sqSj6AyeE2jbB17CuN
         pTrw==
X-Gm-Message-State: AOJu0Yya/8JRCIg83QhMk6+2xoBJpt1o6YLfcAbYqYVHaZpf3R0ZDrJy
	wCG37l56B9AH/9uPWsygVKGEn6IiUd7aHFCZqrOo+Q==
X-Google-Smtp-Source: AGHT+IGOGzsxb9JzoTvfjQfhK63XDXa5QAto8SzapsM1POYVzgQm+Sd10mobBmXLkGcgr1PH4L1jqpTpPPL6XWlXN4E=
X-Received: by 2002:a2e:8e32:0:b0:2c8:7665:9ede with SMTP id
 r18-20020a2e8e32000000b002c876659edemr3437930ljk.19.1700474579085; Mon, 20
 Nov 2023 02:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
 <ZVcxmwm/DRTB8QwO@lore-desk> <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
 <ZVssMWXZYxM0eKiY@lore-desk>
In-Reply-To: <ZVssMWXZYxM0eKiY@lore-desk>
From: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date: Mon, 20 Nov 2023 18:02:47 +0800
Message-ID: <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Toshiaki Makita <toshiaki.makita1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=80 17:52=E5=86=99=E9=81=93=EF=BC=9A
>
> > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=88=
17=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > > > veth network device will display some error statistical values.
> > > > The value of tx_idx is reset with each iteration, so even if
> > > > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > > > will remain constant. This results in incorrect statistical values.
> > > > To fix this issue, assign the value of pp_idx to tx_idx.
> > > >
> > > > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit a=
ccounting")
> > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > ---
> > > >  drivers/net/veth.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > > > --- a/drivers/net/veth.c
> > > > +++ b/drivers/net/veth.c
> > > > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_d=
evice *dev,
> > > >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> > > >               const struct veth_rq_stats *rq_stats =3D &rcv_priv->r=
q[i].stats;
> > > >               const void *base =3D (void *)&rq_stats->vs;
> > > > -             unsigned int start, tx_idx =3D idx;
> > > > +             unsigned int start, tx_idx =3D pp_idx;
> > > >               size_t offset;
> > > >
> > > >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ_S=
TATS_LEN;
> > > > --
> > > > 2.20.1
> > > >
> > >
> > > Hi Albert,
> > >
> > > Can you please provide more details about the issue you are facing?
> > > In particular, what is the number of configured tx and rx queues for =
both
> > > peers?
> >
> > Hi, Lorenzo
> > I found this because I wanted to add more echo information in ethttool=
=EF=BC=88for veth,
> > but I found that the information was incorrect. That's why I paid
> > attention here.
>
> ack. Could you please share the veth pair tx/rx queue configuration?
>

dev: tx --->4.  rx--->4
peer: tx--->1 rx---->1

Could the following code still be problematic? pp_idx not updated correctly=
.
page_pool_stats:
veth_get_page_pool_stats(dev, &data[pp_idx]);

BR
Albert

> Rergards,
> Lorenzo
>
> >
> > > tx_idx is the index of the current (local) tx queue and it must resta=
rt from
> > > idx in each iteration otherwise we will have an issue when
> > > peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
> > >
> > OK. I don't know if this is a known issue.
> >
> > BR
> > Albert
> >
> >
> > > Regards,
> > > Lorenzo

