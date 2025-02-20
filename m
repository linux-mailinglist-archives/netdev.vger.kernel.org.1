Return-Path: <netdev+bounces-167959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C78A3CF75
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FB81893996
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02311D514E;
	Thu, 20 Feb 2025 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KEBBTN/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A363A9
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019675; cv=none; b=nWrgqtZP0gK9Tc7JbNSr7hpU4Ix5KMzNV3WCY2EasCvIKrMCFAHyRXHip0je4KV8RRQd4pz7ifPfr9GI8AHk/0UUGry9Ddg0sYoL+g58V+LnYLZsFR1eryXLD0pgBWKXs4hbFt9/GGZtcs+XJ2p3GpeC5Fmry0TB2WH9QdmD6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019675; c=relaxed/simple;
	bh=2VvfnmXlr34dHXG/P3XG6letow4wupZdh48hZ5+IiwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2CQ7pkCm6kuO7HQB5g5tsVQ6zGWRNy1eIR+Q2WWNdKhwNsroxJ6EktsUq42vSUQIvNRtL5ASepdo/Sv63JDfMYUQBVwkz1buFkZX+PdmfyVvdFLc4O0h7rzEHycUb3N63bMRiieh5xHWpLUXaJRgxWTYmZiG8BZaZkhjbzW9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KEBBTN/Z; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fb2a6360efso3268527b3.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 18:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1740019673; x=1740624473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvp9vC0eMH1pKGCb8lxYuIWBY9DYcdV7nU72B3skZ6Y=;
        b=KEBBTN/ZusaqxikmKmtLJnqMTtn4ks+InMoAoMQoSXfjcWbUXEJWrU71azbGzZWIKt
         XkxJGZxDgXnPNNwQP9/EuSU/snNUOLtpzB+9tCAkQ+4GFC225CyN6utG2wrGMV24iswW
         XImPoWeHp6qpJiQREq151HSEkhFC14g783qHwlmmPgiMiU/EjvsGEsWodP1iOs0r7H6U
         S/3wfzsHWRA3G+vaCMIk/RPDZnr0xNAd+tJslrX0DZZJdFDewokMsIhH5KeS4WEbJjbk
         wncznDiIyLMq8wnBb2GlAdgEnz/vPoNIXlOF+aU7/aOCjiFteuvOXKW45a6794TkHWCF
         /I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740019673; x=1740624473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvp9vC0eMH1pKGCb8lxYuIWBY9DYcdV7nU72B3skZ6Y=;
        b=wcs4ycJbAGJ34WWm1IAow+sGH4XpObAVIx412noomzeARjbYQoE7dAaMsLmSfwnyKn
         2u0W4JHe27zAdtyamijtdYRIxL0EWSmG19WKF4AMecsyWtXgipf4Nu7vTTf64zlkcbCO
         dP92brk0lTd9GXENNkczU0M95wjAXFWZnhvml+yRohSIVd7gPFTHFJzaZVp+IhqwJw7Y
         MDUgFwUl1EWw/ckb3/NYJruW59nZWi8Ix9/XJ3hCvxp43csdwcjmhveFwpFWg4+vHJJz
         Y/Ct3ww5LgToIDFrSztlCG03lEJEs2YL7+H8Op5DDFuzNl/O7ej/uZ4g/EXwWtjpbXQ0
         jLww==
X-Forwarded-Encrypted: i=1; AJvYcCVZrPCLFOoky2LHm1ibVAteqxAPSEKWqJ9jmYc6sB16h4Df5IzbPo2CAeW+uuZVmf3lvRxvS2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+KEJhsH/D1JPSmljJmxiS/ZiHj2DZCDGHkW/LzzdiKRVJqxx
	bl9MkmdxkvSEZndVO0QVLjgZKDBoLLxoP1bv9DHCoGUetgSPc8Ti/6sKrlBiAtqEiWZ1QEAQpxS
	UtuarkQRsOZaZ242AT6DMNV/tA60IGd+zi0wooVdMPGAKn8kamFUSCw==
X-Gm-Gg: ASbGncsaZpHxj6jO4Hos3BcL++bMW3r1QBvsT0xa/1UhErnFij+KvzRTcQb4jOX1ujY
	Z9OYKMmgP+wGInLwJ1H5BsE3NH1ZEVvzDinR+sp9TveSyWQcGj7+rXsOPrX/7oPXkYS9ryDkj5B
	Y=
X-Google-Smtp-Source: AGHT+IHpbcrdwizdZDEB2LKzf3t7N+L1gh7l/lSw8IgK31mOcpbcfuefgyvG7Eg9yB90MSd4D8fYOSrYNFEZa4g738Y=
X-Received: by 2002:a05:690c:64c8:b0:6f7:ac3f:d589 with SMTP id
 00721157ae682-6fbbb7eafa8mr5012217b3.36.1740019672877; Wed, 19 Feb 2025
 18:47:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217055843.19799-1-nick.hu@sifive.com> <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
In-Reply-To: <889918c4-51ae-4216-9374-510e4cbdc3f1@intel.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 20 Feb 2025 10:47:40 +0800
X-Gm-Features: AWEUYZmjzhqzQbHmf9_A5Yil9YBABlCV2QtiQWGg09MoFGZlPCm-Nzx5MY3mUGU
Message-ID: <CAKddAkBZWZqY+-TERah+Q+WUfkqzcpFMA=ySSuTxxBjfP7tKZg@mail.gmail.com>
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Russell King <linux@armlinux.org.uk>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacob

On Thu, Feb 20, 2025 at 7:29=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 2/16/2025 9:58 PM, Nick Hu wrote:
> Nit: subject should include the "net" prefix since this is clearly a bug
> fix.
>
I've added the 'net' prefix to the subject 'net: axienet: Set
mac_managed_pm'. Is there something I'm missing?

> > The external PHY will undergo a soft reset twice during the resume proc=
ess
> > when it wake up from suspend. The first reset occurs when the axienet
> > driver calls phylink_of_phy_connect(), and the second occurs when
> > mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of t=
he
> > external PHY does not reinitialize the internal PHY, which causes issue=
s
> > with the internal PHY, resulting in the PHY link being down. To prevent
> > this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
> > function.
> >
> > Fixes: a129b41fe0a8 ("Revert "net: phy: dp83867: perform soft reset and=
 retain established link"")
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
>
> Otherwise, the fix seems correct to me.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/driver=
s/net/ethernet/xilinx/xilinx_axienet_main.c
> > index 2ffaad0b0477..2deeb982bf6b 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > @@ -3078,6 +3078,7 @@ static int axienet_probe(struct platform_device *=
pdev)
> >
> >       lp->phylink_config.dev =3D &ndev->dev;
> >       lp->phylink_config.type =3D PHYLINK_NETDEV;
> > +     lp->phylink_config.mac_managed_pm =3D true;
> >       lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE | MAC_ASYM_=
PAUSE |
> >               MAC_10FD | MAC_100FD | MAC_1000FD;
> >
>

Regards,
Nick

