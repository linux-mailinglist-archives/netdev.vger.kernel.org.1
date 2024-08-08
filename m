Return-Path: <netdev+bounces-117010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A742494C599
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 22:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEAB280E92
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5D156250;
	Thu,  8 Aug 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYncLnNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900B15534E;
	Thu,  8 Aug 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148501; cv=none; b=Ixh3ma98N5dJsiAThw4Oj0TGdc+AqBGViJ2Vs7eu58o41fqeklyGeOma8boYV9n0KMm+LdoMxfcXKxp69tD/Fnke2A+iDaSWaRY7nxdmBiR65GXuZlCdD2BFIJdNpbgXRMysojLSslVAbqzrdYt3bcxQ8z7TLIVgrLm8FF0Yuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148501; c=relaxed/simple;
	bh=ulSh7AmtkBM9yddz7RYR8V3T1DjbU7clScPfSgShZY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbc17XqFhx4TgYP0ZC/Kuo+eoWi0fHzVw6SmrLnob//K/GvaODGitXxumWEwbt5uStF0f+3z8m2V9PVn6LHgBuuCGctBrnGavTW6kAtrJFn47qT9GZwxzl3oJl3SqWJF4EojAUJQQXeMLw/P8roCB4bpndgFLVE+dT3e+itoQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYncLnNW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690e9001e01so14162397b3.3;
        Thu, 08 Aug 2024 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723148498; x=1723753298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6xdS7bzEVOCuR9cOi9wKUV7nBc7NnnlRdFXvp48F9E=;
        b=nYncLnNWbwXhg4CShQvk1jG9TmGN1h0D4ckG2gFkv02oDuMWfLqFADTpOg/fbmem1c
         lrG8ucjfdvLfWz3Y0SZ5Flx+50zhTieenFfkD+73y1i8gjugeqUeVvhEID5p12xTNQ8N
         qK7HrTQqqmzxVOdWN0vrCxGY+XzzU1fX725amDzdYgbHLRhfGUWfDouCMqighfQo+XI4
         VFNis9rqzZJYqj+G+bne3+ymepBs+NgEyz3O7xsaK+rxjv2vHOhkpGJXdSQSvgvv84Dx
         VlBshOlksgnO+OeXGzrhWiIJTzDngl8Jr2Z4wwXdMvmFtQ9yZDLMxHTSW8BsB/Exvlf2
         4vEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148498; x=1723753298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6xdS7bzEVOCuR9cOi9wKUV7nBc7NnnlRdFXvp48F9E=;
        b=cJcC6DuFsR/Pqa60K1do07JvST8fcUkTLKYjcPhcVsEUtGhnIC91g5ICgN5Rby9LAO
         gxhLr/3nnN0aZbd5/D33YXriwgILedeJYGmleLtdbwAb3Jqhccim0ya7IkEPcxW97SaP
         O1fVHELS9PqK+poDy2IZ6IK7RTUNEZUfiGpr53GcATe5n7wL5uE7/zO2CEuacX9OLB/P
         RcdPXjOvs9AqKEvjjB5ESUCYUVDmahdzHRf6hQdSycds8HzanSsE6n8Op4+XMhye0tYB
         bqK5zozevFY4gh+/3s9i62rldsAPLq1ItkaEq3mEV4LqstgGsPuawKEzwVdio+cznkE7
         sCmg==
X-Forwarded-Encrypted: i=1; AJvYcCUC0gIugNJtppV5SrOEGtGIvcaCWameDZ7odFLMGMm6ZFbtLAtsbTvOKaEVXjL+Pdz8qzex/T21NzoHzidRuMPiHcB6S5a6T4BlUCSn
X-Gm-Message-State: AOJu0Yz0weKx9xrB/gyQYnmR0aVHhtrqjvR/nzK5C3Sr9m/z2TuIysqo
	kXvdoYxp7w6Hgc9UXYCGME0rmhV2TD+pLJNfycG6hg362yN/yKWqot4a8jZ7seEVe10UMT8Wpxw
	Y7xTo10x/cfW/k8ey5qtPshWNklLssF7a
X-Google-Smtp-Source: AGHT+IECnvIxIQ3ftZOgsj1eDP/P0RZPNJl5MIWsxIG4ZUOjkI7fzrnQb+wb0HqD1rw9kYxeppODNAiRLKkI1Bs5vOw=
X-Received: by 2002:a05:690c:60ca:b0:64b:75d8:5002 with SMTP id
 00721157ae682-69bf7355798mr39263347b3.9.1723148498572; Thu, 08 Aug 2024
 13:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808040425.5833-1-rosenp@gmail.com> <acb8e8cc-ebc1-4542-a880-8bb081e1a4c7@wanadoo.fr>
In-Reply-To: <acb8e8cc-ebc1-4542-a880-8bb081e1a4c7@wanadoo.fr>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 8 Aug 2024 13:21:27 -0700
Message-ID: <CAKxU2N9qEDyEQUgk33AEWA=gxYZ7EN4n9aosQ0=675QDdWjONg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: moxart_ether: use devm in probe
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: netdev@vger.kernel.org, u.kleine-koenig@pengutronix.de, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:18=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 08/08/2024 =C3=A0 06:03, Rosen Penev a =C3=A9crit :
> > alloc_etherdev and kmalloc_array are called first and destroyed last.
> > Safe to use devm to remove frees.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> Hi,
>
> using dmam_alloc_coherent() would go even one step further I think.
> It would remove moxart_mac_free_memory() completely.
>
> Then IIUC, using devm_register_netdev() would keep things ordered and
> moxart_remove() could also be removed completely.
>
> (by inspection only)
Right and that's the issue. I don't have hardware to test this on.
Limiting this to alloc_etherdev and kmalloc_array is safe as they are
the last to go.
>
> CJ
>
>
> >   drivers/net/ethernet/moxa/moxart_ether.c | 19 ++++++-------------
> >   1 file changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/eth=
ernet/moxa/moxart_ether.c
> > index 96dc69e7141f..06c632c90494 100644
> > --- a/drivers/net/ethernet/moxa/moxart_ether.c
> > +++ b/drivers/net/ethernet/moxa/moxart_ether.c
> > @@ -81,9 +81,6 @@ static void moxart_mac_free_memory(struct net_device =
*ndev)
> >               dma_free_coherent(&priv->pdev->dev,
> >                                 RX_REG_DESC_SIZE * RX_DESC_NUM,
> >                                 priv->rx_desc_base, priv->rx_base);
> > -
> > -     kfree(priv->tx_buf_base);
> > -     kfree(priv->rx_buf_base);
> >   }
> >
> >   static void moxart_mac_reset(struct net_device *ndev)
> > @@ -461,15 +458,14 @@ static int moxart_mac_probe(struct platform_devic=
e *pdev)
> >       unsigned int irq;
> >       int ret;
> >
> > -     ndev =3D alloc_etherdev(sizeof(struct moxart_mac_priv_t));
> > +     ndev =3D devm_alloc_etherdev(p_dev, sizeof(struct moxart_mac_priv=
_t));
> >       if (!ndev)
> >               return -ENOMEM;
> >
> >       irq =3D irq_of_parse_and_map(node, 0);
> >       if (irq <=3D 0) {
> >               netdev_err(ndev, "irq_of_parse_and_map failed\n");
> > -             ret =3D -EINVAL;
> > -             goto irq_map_fail;
> > +             return -EINVAL;
> >       }
> >
> >       priv =3D netdev_priv(ndev);
> > @@ -511,15 +507,15 @@ static int moxart_mac_probe(struct platform_devic=
e *pdev)
> >               goto init_fail;
> >       }
> >
> > -     priv->tx_buf_base =3D kmalloc_array(priv->tx_buf_size, TX_DESC_NU=
M,
> > -                                       GFP_KERNEL);
> > +     priv->tx_buf_base =3D devm_kmalloc_array(p_dev, priv->tx_buf_size=
,
> > +                                            TX_DESC_NUM, GFP_KERNEL);
> >       if (!priv->tx_buf_base) {
> >               ret =3D -ENOMEM;
> >               goto init_fail;
> >       }
> >
> > -     priv->rx_buf_base =3D kmalloc_array(priv->rx_buf_size, RX_DESC_NU=
M,
> > -                                       GFP_KERNEL);
> > +     priv->rx_buf_base =3D devm_kmalloc_array(p_dev, priv->rx_buf_size=
,
> > +                                            RX_DESC_NUM, GFP_KERNEL);
> >       if (!priv->rx_buf_base) {
> >               ret =3D -ENOMEM;
> >               goto init_fail;
> > @@ -553,8 +549,6 @@ static int moxart_mac_probe(struct platform_device =
*pdev)
> >   init_fail:
> >       netdev_err(ndev, "init failed\n");
> >       moxart_mac_free_memory(ndev);
> > -irq_map_fail:
> > -     free_netdev(ndev);
> >       return ret;
> >   }
> >
> > @@ -565,7 +559,6 @@ static void moxart_remove(struct platform_device *p=
dev)
> >       unregister_netdev(ndev);
> >       devm_free_irq(&pdev->dev, ndev->irq, ndev);
> >       moxart_mac_free_memory(ndev);
> > -     free_netdev(ndev);
> >   }
> >
> >   static const struct of_device_id moxart_mac_match[] =3D {
>

