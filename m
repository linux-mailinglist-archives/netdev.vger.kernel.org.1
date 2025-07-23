Return-Path: <netdev+bounces-209404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F5B0F81F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1518903D2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AA1F37D4;
	Wed, 23 Jul 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxAcBMmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5941E9906;
	Wed, 23 Jul 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288182; cv=none; b=EZX/IIRHwbhbSn0M5Mp82jjaesD3WTjQlnP4bYZGjgsj615McwzfxQVmESCXOE+XVQIbP7tynYVfQk/zt361U4Hday778hJubNNy96FwgIr06S7MmeYZ+oEgPULww5jusrsYQ/5V8QdhUSMY+Nog2ZnBePzi0jc7piy+Pn0ok1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288182; c=relaxed/simple;
	bh=zLm92mbchqPT/lOQYKbNyGw2oTgg3oNdSA93yfAsOpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUm0q4rjJhU+L96Fk0x19HsMwKZvKjIKdZdRF7Kpk9+EykCckPOo4qAurYldrGrGfxOajmt5TY65OBCQ8/MbSwv++y+cP4XHNQolMyBh7VhkkaqFgpb3KcHW07pkc4w2k/L6KKWU9i/+QrAPVX3DDYqLtiHEEYEeNvFtErNmiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxAcBMmx; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4ecd5e83bf5so12599137.2;
        Wed, 23 Jul 2025 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288180; x=1753892980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcVlvgU7LE3hMre//R1KRwnTu98pdIkL4eaodTxo9H4=;
        b=JxAcBMmxEGww4QS2d5p41YZPor0gsyH/t5jJeA6KIqgJRk4g+gKcMA7GZcH67AX3pe
         /2ujPeL0BDwAxEGeQsVJY2D+a/5/WI0nbw9DauhywgAOauLKjh4EEIy3gd8C+uUQ7od/
         /adceJEvPpzn1RVyI08So8RBJzTUKnyGwWjUQ2Ft2tLtx80h5O6J9xMXKmUwLl67CmJZ
         S1p0CNWpYfjNEENTu3uWmOahzUYK1Elw2z2kQLTJXy9DbSeCK0arSwt19Qia9ZjrSjRi
         tJwQYp4sJffgPZ/F58cacK+vgWFKM1XGipa6saWuOY3XakLxMRcnloDWU1emdqdJpuGV
         mkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288180; x=1753892980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcVlvgU7LE3hMre//R1KRwnTu98pdIkL4eaodTxo9H4=;
        b=amDPZnv0OB75okCp8iYklk1ozOoaTqAFTEm4jJultgRo57MG+RAsWd/qZK9PhOoNfy
         3MrGUV0Lv9DqFViWfNDit+BGl+YYus/TzR2tu/XRVXqN60g1wTmCerAfi/rDAugJZAcm
         XtThb4sKSzes7iGnB5x0lqoL5eqfbr6c7+HKmUU3bLgbWS5jivVfqIsyStyBBezi27F/
         D0yolDp7rtG3LXoQgMD+C9dboXDp3bpuvLv4daeEfMvtHt9N/njC/q/uRqn0A3rq5xXS
         qLSxYg8amMDOdZwx77OeSlhQ9Jd8fTzlia3ZmpE0xrkwj26vApvWdJTB7IDtAD3TUMRo
         wABQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWj1XIzZB3nKJPadkEZLYVtoHX2R2oGEF3FMKjrA/LW+okU1qnVoWFSLvFua1v4XIJU+DdP2JM@vger.kernel.org, AJvYcCVdtcaw2pLkdMXtgUw5DoP/0acGv9IOUK1hBS8yXxBcDU+YsQzpi/BzpQJmcc+mAF5iboGrl2NShmkTtMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLtNjQWduaLALgpXq8kUT1bfsOlu7vA9C9U8Dv0Uuk2TeHrNl
	cShmUa/z6o3H/InUdsKZIbIGh3RO38dkVdUvp6AY1qaG25BqdCMiPBr8L9m/yjKb/204WmOgYhQ
	TfuZNHYvNLN11oWnoXvm250qo2Hff4g==
X-Gm-Gg: ASbGnct4c4o5k5K967KogCyTu2oJUl250xIPMa1D/0Il1w+d/6cd9L7KxtReuQn3qeo
	SSWauDedHh72+sc+5SPGq4901lD4QbM9a45RnRYyKRw+wHuATLpW3LzTqoVvJOzL9go3cf0DH5m
	i+NG+uUKRkrV+s7j9TUE8O9enVfwOsWwcrh1/NgWFQ2cV8otKc/7OILyWebxB2/5F+YkLgb041d
	JJ2j8E=
X-Google-Smtp-Source: AGHT+IGYsJdhLoN1TMLCfgXrDLsU4+CQm+vl7IN/++P/PmI5JeAU0PJ+8riDl6lFQdS6bK30tz/EShnAxwQwnNxNIRM=
X-Received: by 2002:a05:6102:94d:b0:4e5:abe6:b6f6 with SMTP id
 ada2fe7eead31-4fa151a893emr613548137.6.1753288179649; Wed, 23 Jul 2025
 09:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723034105.2939635-1-chenyuan0y@gmail.com> <b33f5cee-d3de-4cbd-8eeb-214ba6b42cb7@linux.dev>
In-Reply-To: <b33f5cee-d3de-4cbd-8eeb-214ba6b42cb7@linux.dev>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 23 Jul 2025 09:29:28 -0700
X-Gm-Features: Ac12FXzq2ALY36NASs3tOjTAH57UeioOZf6VGikCf8aeooUjIt8l4b5gR-QNNlo
Message-ID: <CALGdzuq1BndVib-==ZEHapGsiKuReMxm-f8DB+xFK9qbSpWruQ@mail.gmail.com>
Subject: Re: [PATCH] pch_gbe: Add NULL check for ptp_pdev in pch_gbe_probe()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	mingo@kernel.org, tglx@linutronix.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 2:37=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 23/07/2025 04:41, Chenyuan Yang wrote:
> > Since pci_get_domain_bus_and_slot() can return NULL for PCI_DEVFN(12, 4=
),
> > add NULL check for adapter->ptp_pdev in pch_gbe_probe().
> >
> > This change is similar to the fix implemented in commit 9af152dcf1a0
> > ("drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()").
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > ---
> >   drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/dri=
vers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> > index e5a6f59af0b6..10b8f1fea1a2 100644
> > --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> > +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> > @@ -2515,6 +2515,11 @@ static int pch_gbe_probe(struct pci_dev *pdev,
> >               pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->=
bus),
> >                                           adapter->pdev->bus->number,
> >                                           PCI_DEVFN(12, 4));
> > +     if (!adapter->ptp_pdev) {
> > +             dev_err(&pdev->dev, "PTP device not found\n");
> > +             ret =3D -ENODEV;
> > +             goto err_free_netdev;
> > +     }
>
> Why is this error fatal? I believe the device still can transmit and
> receive packets without PTP device. If this situation is really possible
> I would suggest you to add checks to ioctl function to remove
> timestamping support if there is no PTP device found

Thanks for the prompt reply!
Our static analysis tool found this issue and we made the initial
patch based on the existings checks for pci_get_domain_bus_and_slot()

I've drafted a new version based on your suggestion. It removes the
check from the probe function and instead adds the necessary NULL
checks directly to the timestamping and ioctl functions.

Does the implementation below look correct to you? If so, I will
prepare and send a formal v2 patch.

---
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index e5a6f59af0b6..ccef1b81e13b 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -136,6 +136,8 @@ pch_rx_timestamp(struct pch_gbe_adapter *adapter,
struct sk_buff *skb)

  /* Get ieee1588's dev information */
  pdev =3D adapter->ptp_pdev;
+ if (!pdev)
+ return;

  val =3D pch_ch_event_read(pdev);

@@ -174,6 +176,8 @@ pch_tx_timestamp(struct pch_gbe_adapter *adapter,
struct sk_buff *skb)

  /* Get ieee1588's dev information */
  pdev =3D adapter->ptp_pdev;
+ if (!pdev)
+ return;

  /*
  * This really stinks, but we have to poll for the Tx time stamp.
@@ -210,6 +214,8 @@ static int hwtstamp_ioctl(struct net_device
*netdev, struct ifreq *ifr, int cmd)

  /* Get ieee1588's dev information */
  pdev =3D adapter->ptp_pdev;
+ if (!pdev)
+ return -ENODEV;

  if (cfg.tx_type !=3D HWTSTAMP_TX_OFF && cfg.tx_type !=3D HWTSTAMP_TX_ON)
  return -ERANGE;
--=20


> >
> >       netdev->netdev_ops =3D &pch_gbe_netdev_ops;
> >       netdev->watchdog_timeo =3D PCH_GBE_WATCHDOG_PERIOD;
>

