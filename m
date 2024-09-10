Return-Path: <netdev+bounces-127082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C9973FDC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EDAB2482F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F891BF33C;
	Tue, 10 Sep 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3XADfnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575B1BF30B
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989027; cv=none; b=YuAPmfUD9WE3y/zAgxBopq/OkLTX/JApLE1cFQxLUSJuPqCaQwA9wg7kmsX3lD3eOHEWXbzJQaPL+2YZPpR5PDeqLB7rH7OolDegLTqmgqmBCR1DL16Jmk4V1KKU8KvhO7dl3ExRdnOenxyWmDa/ZC/cDPXBJW9xaD4RwjLArEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989027; c=relaxed/simple;
	bh=cwljm74luVO5e4l1ekmKrtc1UWVIFq8KDx2FNieUIok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toLxkTa7fEfbrv+cRtkFs3q2OL0hN2oB/U2YcfU4rFKMebeBHu+8PWvD2vof5zip1mQJAwVVa8pM0YKrIe/Wj+DrmNkftKJPw/Uo+D64ldbQ86P8OjSfvmuVEbdqapj7AUPTvPeO9Ufq62WARSdCIvHE+MbHKaoNYqbvk0n4hg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3XADfnQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso16194066b.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725989024; x=1726593824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGgqOlCUn95hobX0YX6rcgMk2qcy9JjHjUpxhldUGPk=;
        b=c3XADfnQGvSLwsprzznkGCXYJVISVgL24gVDqnjgJ2kb15sStA27N6zbEFqqzM6WsM
         7MNn36Llykj0Jci2MqgOr6ddvDsmrgjjcvDlCkAPpFQ3LoX6VmLIUmGgWrRR5hQMvRKU
         kxxDA2fqe5CekdCrcjWLj6MXF3lJVtLu157twmRLQNpAL4gq+22yOSF0ju1ZuurVmlaF
         D2e6OhIggZPiiB7A5e7FVfbT/bKR+LHzr34NJlaqUSrGr2ZgVWzSMz2YWNW4kQYRoRx9
         nACMLcgZLOFF84cXcGR3+VeXOBr0noWQ5aM9IDSJbPaxMjLHtEa5TcC6lt6e9e5Lln+V
         wJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989024; x=1726593824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGgqOlCUn95hobX0YX6rcgMk2qcy9JjHjUpxhldUGPk=;
        b=uzTEaGPtGkxniU/sIzOK7VpRtRh7RTPN+6XVaHwiGbN5UpVh+SwUK1cVNHvmMJEZRt
         p4RuFjjaMpitAwyiNDMPY3J9ARdz0JZ832zwLXLKxl3WeiUihBzI2evwlvD8ATonw8hc
         vgim2VVNLwbm/fqgbS7DLHt4hJslCimBe9yvxX+zCJ27CK38ITHeKPvF3RPDje5NismJ
         FVylQQd+D/sECptShpUpW3eM7tJPNP/SxFqfWgtYoOGcRdV7Ztp4U5ePwL7NYE1ntfbW
         6LEqBi8NwBjIATlU3ir0hcjZtntA7rrthKKGyfkh++gNqeGZpkiehLIYw2I0ArgXKNkh
         pFDA==
X-Forwarded-Encrypted: i=1; AJvYcCW8TxAvovAfcYPJ/Ha1FHOHcGvTulG8/Eu7BU957eMjj9kUK3KJtaKkw0POSIxg4WGEh3X7NC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4k/u5ZY7MDB/g63h2sbQ5O2H5zOrT297jU2/lblAT997nr8N
	0FYWdokMBUiwr1UMF5zQjuSnYxapdEU/w546O1Aag7o9kf3cQYPyIWO/h/aCEidXT3DwCVzM4Ee
	uYljIMsr/G6mzx6UddQLWRXb+HCNdlLBkVS7s
X-Google-Smtp-Source: AGHT+IF8UdrAEx9jcrmShfHoP/xocZ4z2EyxKqrKVfdtU5YG9dM3CP7WcLiNIc7Had7soIp+4AkGJwiZsoN6njgJlbM=
X-Received: by 2002:a17:907:3682:b0:a86:a866:9e26 with SMTP id
 a640c23a62f3a-a8ffaaa4c30mr215958766b.3.1725989022916; Tue, 10 Sep 2024
 10:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
 <20240821151009.1681151-8-maxime.chevallier@bootlin.com> <CANn89iLQYsyADrdW04PpuxEdAEhBkVQm+uVV8=CDmX_Fswdvrw@mail.gmail.com>
 <20240910192020.5ab9cd16@fedora.home>
In-Reply-To: <20240910192020.5ab9cd16@fedora.home>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 19:23:30 +0200
Message-ID: <CANn89iKRW0WpGAh1tKqY345D8WkYCPm3Y9ym--Si42JZrQAu1g@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	=?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, 
	Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:20=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hello Eric,
>
> On Tue, 10 Sep 2024 18:41:03 +0200
> Eric Dumazet <edumazet@google.com> wrote:
>
> > > +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
> > > +{
> > > +       struct phy_req_info req_info =3D {};
> > > +       struct nlattr **tb =3D info->attrs;
> > > +       struct sk_buff *rskb;
> > > +       void *reply_payload;
> > > +       int reply_len;
> > > +       int ret;
> > > +
> > > +       ret =3D ethnl_parse_header_dev_get(&req_info.base,
> > > +                                        tb[ETHTOOL_A_PHY_HEADER],
> > > +                                        genl_info_net(info), info->e=
xtack,
> > > +                                        true);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       rtnl_lock();
> > > +
> > > +       ret =3D ethnl_phy_parse_request(&req_info.base, tb, info->ext=
ack);
> > > +       if (ret < 0)
> > > +               goto err_unlock_rtnl;
> > > +
> > > +       /* No PHY, return early */
> >
> > I got a syzbot report here.
>
> I seem to have missed the report, sorry about that.
>
> >
> > Should we fix this with :
> >
> > diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> > index 560dd039c6625ac0925a0f28c14ce77cf768b6a5..4ef7c6e32d1087dc71acb46=
7f9cd2ab8faf4dc39
> > 100644
> > --- a/net/ethtool/phy.c
> > +++ b/net/ethtool/phy.c
> > @@ -164,7 +164,7 @@ int ethnl_phy_doit(struct sk_buff *skb, struct
> > genl_info *info)
> >                 goto err_unlock_rtnl;
> >
> >         /* No PHY, return early */
> > -       if (!req_info.pdn->phy)
> > +       if (!req_info.pdn)
> >                 goto err_unlock_rtnl;
> >
> >         ret =3D ethnl_phy_reply_size(&req_info.base, info->extack);
> >
> >
>
> Indeed that's the correct fix. Should I send it ? ( including
> suggested-by/reported-by )

Yes please, go ahead.

>
> Thanks,
>
> Maxime

