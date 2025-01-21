Return-Path: <netdev+bounces-160112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E900A1846E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E8A188C8D8
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D51F5404;
	Tue, 21 Jan 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6XA2rtI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6ED1F55E5
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482759; cv=none; b=NuREJ5jZI+nESrCJStF4Y1RIgyNQGfmTTmOlbAmdphwecdsg/gkT4HaEtjHNV/bDOuNS8xe+Mrx1+Ap6W3v5Fyo0NaNwm0nINuECD0Rl9d4A+gnpzF94y5iZmZzeUmUSLzRBaV6CPhPxL7ZBaGE50EBHb7CuVBXZcpEhQlD7UuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482759; c=relaxed/simple;
	bh=Z/5JpBlY05/+HAh63nWlsxlwvFHUY5Ud7D8gIq2iy60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT5pkhfnf+V08ZoviYdmCxnj5+nprvs4t+A+iUMT6XiFwlvSAkoI34Y1IDlzCsJynumFAZQ08sCIrvgk9Hw4QOKH6JMtrTfcgwmkX6HNiQ5jlwTWE2ZjS8IsX7QsR1JpGBM/XGr/4nJJjxd17we7MAu/20Fsnm5nqkWsC6M/IGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H6XA2rtI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361d5730caso1785e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737482756; x=1738087556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYKhhqcUsfI3HSCwHgCTl8ivXkn9AieqiEzqUfNd8ho=;
        b=H6XA2rtIU0lAohhzf9XVNLN9yWyWgQlyOovz2nI8/kJJxq5hqk/19x5FSz57xUvHm9
         utbdPjk9Xsl+JRqt2JKU02r464VGw68DSfxrlRKnQRv/UvOrgx6QdLNMNl3g5hBC/FF5
         RnbXT1vkDq6dz/FPUIHUuJwM1s3Kq1lryBuDMpZP3PvoFV2OfG5EZ85gtzk3nttp1760
         RsXJD+3VqydM97uH0h8qOCr7pc/CKsnh/2QXa1OFygB9vYl7PBhtiar+BcMskQDq3VDP
         zSU//wy4MUYu5FEsVacU0WW4cDuL1pJqk8HHJ9XbHF8MoiuGdXXz7IlsueQ2DMTehpVA
         9YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482756; x=1738087556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYKhhqcUsfI3HSCwHgCTl8ivXkn9AieqiEzqUfNd8ho=;
        b=GF249n57IxNjAWRa3x4+mpeagKuLYUEQsNsjAzcM9iFyw139miKXxIjjfAq7IXWVjZ
         95QM14EVgji7lgh11Ul/+vXsR86WxKTZSVy4NMQ79imErUqC16Q00TftcyHZEu+5p22N
         MorfvQAy6Sh2yFedMukH+YbHeM9DEk3805A5PRRiDpIMcXQLIwnidDpSyW1r6yV34Rbu
         hgj64k0heJFU47n/FYNWTOtXKwrwT0RjXwfX3/aH2nNmtyCCkdt6dQ/MQ5/ZIfRRtgia
         LBcGxNK6ip0UzcWCQPfwJ9tUU8Q3b50cb/65f909McHOZYgKB6jnQDK2tBAePFnaNqMl
         Bkfg==
X-Forwarded-Encrypted: i=1; AJvYcCWthXgyw2wssoH8KT3Ei2Afu7Nn5Cwh94XykIlULUOgDz5myPm7Oi4JvNwVT7B8E6R4PF/t+8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YEMB9R1I43y+rQ7qJPsdEaGGgu/rHCS7ujestXUmFzXmlrBg
	5YSghFQ+hCna3LFo/1qzlL9pe105XaPSsoHjJSitZR5c45gxHr7rAocQCcxElZ75pslSKALsdiG
	DHGrCg/mOQZ122ov92Q8f9YVXBVO/PXN3JMyZlVsY7JIOPD6Smo09
X-Gm-Gg: ASbGnct1kt+H0sJO5C+ExbGHMLVYyvN2QddTPY6wERUdqnAM7kLFpSG/qpwT+/5fxyD
	6DYqooGSAwrnPNfJUUabT4uO4E2UJU3vzbot/kV/ySoixT9/zWx7UWgouo1i4Yg==
X-Google-Smtp-Source: AGHT+IFNEJOfXjmbAMsQyJDFe0MOI0J2254FZFAb//Px7TpD56bfi5CXTVwD0XmzD2T+X5mbRCEsgF7WvlWwaE/f5nY=
X-Received: by 2002:a05:600c:6d8c:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-438a0f45862mr4051705e9.5.1737482755704; Tue, 21 Jan 2025
 10:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113211139.4137621-1-pkaligineedi@google.com> <20250114180237.33e61fef@kernel.org>
In-Reply-To: <20250114180237.33e61fef@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Tue, 21 Jan 2025 10:05:44 -0800
X-Gm-Features: AbW1kvZN1J19Q9S-mEGPzzPn-sLZKSRTI98gXX7yWj3syun6rZf_UhGp7S5Zx1U
Message-ID: <CAG-FcCP7iJaVwWXwaCPN_N83RMe2Tb5sahhnf6YxRU48gxE1gQ@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: Add RSS cache for non RSS device option scenario
To: Jakub Kicinski <kuba@kernel.org>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, shailend@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, hramamurthy@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 13 Jan 2025 13:11:39 -0800 Praveen Kaligineedi wrote:
> >  static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh=
_param *rxfh,
> >                       struct netlink_ext_ack *extack)
> >  {
> >       struct gve_priv *priv =3D netdev_priv(netdev);
> > +     int err;
> >
> >       if (!priv->rss_key_size || !priv->rss_lut_size)
> >               return -EOPNOTSUPP;
> >
> > -     return gve_adminq_configure_rss(priv, rxfh);
> > +     if (priv->cache_rss_config && !priv->rss_cache_configured) {
> > +             err =3D gve_init_rss_config(priv);
>
> I don't understand why this is here.
> Why are you programming the default config the first time user asks
> to set rxfh? And just to immediately overwrite it.

>
> Shouldn't you be doing this on probe or first open?
Thank you for pointing this out. I will send V2 patch when the window
is open to make it initialize RSS when the driver probe, and remove
the gve_init_rss_config code in the gve_set_rxfh.
>
> Oh and in gve_setup_device_resources() you call gve_init_rss_config()
>
> > +     if (priv->rss_cache_configured) {
>
> so you reset what user wanted to defaults, only if user wanted
> something explicitly _not_ default. Hm.
>
This if check will be removed in the V2 patch too.
> > +             if (err) {
> > +                     dev_err(&priv->pdev->dev, "Fail to init RSS confi=
g\n");
>
> use extack, please
>
Will be updated in the V2 patch
> > +                     return err;
> > +             }
> > +     }
>
> > +int gve_init_rss_config(struct gve_priv *priv)
> > +{
> > +     struct gve_rss_config *rss_config =3D &priv->rss_config;
> > +     struct ethtool_rxfh_param rxfh;
> > +     u16 i;
> > +
> > +     for (i =3D 0; i < priv->rss_lut_size; i++)
> > +             rss_config->hash_lut[i] =3D i % priv->rx_cfg.num_queues;
>
> nit: ethtool_rxfh_indir_default()
>
Will be updated in the V2 patch
> > +
> > +     netdev_rss_key_fill(rss_config->hash_key, priv->rss_key_size);
> > +
> > +     rxfh.hfunc =3D ETH_RSS_HASH_TOP;
> > +
> > +     return gve_adminq_configure_rss(priv, &rxfh);
> > +}
> --
> pw-bot: cr

