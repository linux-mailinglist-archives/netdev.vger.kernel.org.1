Return-Path: <netdev+bounces-214717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354AB2B01A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1843D564482
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66E2D2493;
	Mon, 18 Aug 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whZP111d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF324DD17
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541106; cv=none; b=PfLtpprZ82rpPstu5oEbrO4E07p7B9l/n9vGTo/8y7QRYGISi2Nz1Gu0QIYJN7tLzefy1myKtUFWWmh8og1sxDSTk2b9d2yctHrrkgsEcYbvgT2h1PEhzpSTSJz9u9SHdPT1mejxTj9AaQ5yzZrCLXNr4SAAY/CMol1xLAhAlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541106; c=relaxed/simple;
	bh=MN6cMEgwQsI9LU7L5DTRfKs2G4F7QGv63KzoSuBphFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5g59qi5g+WyLCBdUoydXv52tW7kgBFoyTGk8FoqUdqNZOpbVcucLknXJBPYL68I6TKhUWXwgmybHjnXEIvtyq38WZ9PzudOKBfDwkHtiMGVenjigps3q1p+YdS894jDGSyeCH7YGjb5omG1ZdDBhaqiNbhBo3e+Aud+2acZS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whZP111d; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55cdfd57585so1215e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541103; x=1756145903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWR/SbaxqayRTD44wtFfLeF4GeVcOog9WH0lYeaW0Bk=;
        b=whZP111dGGJjKbnvTu+26xDruGuckzCeh7COcoy+vugK0Xm5ehmvm5SYzgDi+PcQiE
         qUtSkUXQFijFC7C64i5ErUmK3YGC8l0G34PpgHH7UI2mSN1vLWyQvNYCqzX1wAR/AI2v
         lG7HPDoAlXnbqjbWoWyoQSkLssTCvDArhXIlZnn0PeVzjHI005wV24RW2emTnqvghPON
         d6YIFMjeT/yLP/SD4HyAiS4ZquRD8uPHfHQCfoww/Dz5u6vWprZc9H1lgS17CebvYkdk
         1yDGH6n/qnGM3/jsUG2E8Zdz2QuXSroaMjWgWKSNOXaDe5COm5UBb+ZDschVsDFcJivf
         Ys+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541103; x=1756145903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWR/SbaxqayRTD44wtFfLeF4GeVcOog9WH0lYeaW0Bk=;
        b=MVNgKuNfAW7KLhMYbg1x6Q4XBUwn+TZi7Xdv0Fwz6eiGesxdICt/1d1JeoeUpuouQ8
         9JshNcEb0HRVR2bzKD90Yk4pNSGtVFiEjbw8nicYm5usjDHpfDJv/bDvAJWXq5EcVglA
         AoiSPd0+jqByqvQuJUdkE/T1TZHK8PF02rUhxiujB4fjM6MWCsUb7oP4avIUbG9rQgLe
         Z5B70We60VUk40R9D892dgUbs6kdgcTwJAaodf8n1cwGdQ2gQ+YOX4smLg+h+9XjRwsJ
         8HJa8kOTdavzNTJBaeDPJQ4BWTrGHTj5A+CDChA5psFiIlgWSGkF7eGSLkYaCK9zqJB8
         SlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtAwAcLXBMZ05eC4ZZqTlfbhzAkdH+QaXYPUJjd6UTdE98wlHKJ8M1nCvQarcmBr46Z8IiWhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx948qqA5XeWW6+AgRIA9ZnoulI6vt9zY4D4gJvE8jMMnyto5SE
	RRCJikVXEfWvpB6YxCxZcA3bU4/dEyu8JCrU8RQGv0iehpErUKFV51FV6BVjzE6NXTMXOrsUjHf
	p8JXPl0GsgqMcuiSaZI7UOgkr6pHgS3GFCOyQo19i
X-Gm-Gg: ASbGncvZaCNk6CWY2lSFX6DsE9vh/X8tgd/7031RUhbgV2y+9V56lGh5bB6Vvf1VMI/
	rU1tOetP0Dt+v2a/RQLI3/xSybLx85xAVDngAm/jaPTWYentxij4HYj7WIeSfdbWOc/3Ml0JQbS
	ndCg7UZU3GYxCtMaSYfl0odR8NGrKMIe0gzh77xurTSmeU4XimCH1euSQfG+jffE8yoxzImKDe6
	e8xqAq6DDTVtUzr8eSGi6KeHKX9KqLMve2HuOP9tpocemHr
X-Google-Smtp-Source: AGHT+IHs2hDwNnShp2o5vXlAxIJDY3ZyuELs6Qbn9swcDZaVjFbHPjN6aHjnakTgYOX9eOvexrRF6+S71VUKA4qKz/A=
X-Received: by 2002:a05:6512:1c3:b0:55b:9f89:928b with SMTP id
 2adb3069b0e04-55e001125d4mr11794e87.1.1755541102509; Mon, 18 Aug 2025
 11:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-6-dtatulea@nvidia.com>
 <CAHS8izO327v1ZXnpqiyBRyO1ntgycVBG9ZLGMdCv4tg_5wBWng@mail.gmail.com> <jvbtvbmgqspgfc7q2bprtdtigrhdsrjqf3un2wvxnbydngyc7r@y2sgbxgqkdyi>
In-Reply-To: <jvbtvbmgqspgfc7q2bprtdtigrhdsrjqf3un2wvxnbydngyc7r@y2sgbxgqkdyi>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 11:18:10 -0700
X-Gm-Features: Ac12FXyie8zJRkeTDcLtpvBJzFcHj52yCohewjEDLantFzz9m9oBZlFv4CV91bE
Message-ID: <CAHS8izNWStDWNfNro3oX1v5mwyzK_xmA0YfffqSeB0JZwArK7w@mail.gmail.com>
Subject: Re: [RFC net-next v3 4/7] net/mlx5e: add op for getting netdev DMA device
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	cratiu@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Fri, Aug 15, 2025 at 10:37:15AM -0700, Mina Almasry wrote:
> > On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > For zero-copy (devmem, io_uring), the netdev DMA device used
> > > is the parent device of the net device. However that is not
> > > always accurate for mlx5 devices:
> > > - SFs: The parent device is an auxdev.
> > > - Multi-PF netdevs: The DMA device should be determined by
> > >   the queue.
> > >
> > > This change implements the DMA device queue API that returns the DMA
> > > device appropriately for all cases.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++++++=
++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > index 21bb88c5d3dc..0e48065a46eb 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > @@ -5625,12 +5625,36 @@ static int mlx5e_queue_start(struct net_devic=
e *dev, void *newq,
> > >         return 0;
> > >  }
> > >
> > > +static struct device *mlx5e_queue_get_dma_dev(struct net_device *dev=
,
> > > +                                             int queue_index)
> > > +{
> > > +       struct mlx5e_priv *priv =3D netdev_priv(dev);
> > > +       struct mlx5e_channels *channels;
> > > +       struct device *pdev =3D NULL;
> > > +       struct mlx5e_channel *ch;
> > > +
> > > +       channels =3D &priv->channels;
> > > +
> > > +       mutex_lock(&priv->state_lock);
> > > +
> > > +       if (queue_index >=3D channels->num)
> > > +               goto out;
> > > +
> > > +       ch =3D channels->c[queue_index];
> > > +       pdev =3D ch->pdev;
> >
> > This code assumes priv is initialized, and probably that the device is
> > up/running/registered. At first I thought that was fine, but now that
> > I look at the code more closely, netdev_nl_bind_rx_doit checks if the
> > device is present but doesn't seem to check that the device is
> > registered.
> >
> > I wonder if we should have a generic check in netdev_nl_bind_rx_doit
> > for NETDEV_REGISTERED, and if not, does this code handle unregistered
> > netdev correctly (like netdev_priv and priv->channels are valid even
> > for unregistered mlx5 devices)?
> >
> netdev_get_by_index_lock() returns non-NULL only when the device is in
> state NETDEV_REGISTERED or NETREG_UNINITIALIZED. So I think  that this
> check should suffice.
>

Ack, thanks for checking. For the patch:

Reviewed-by: Mina Almasry <almasrymina@google.com>



--=20
Thanks,
Mina

