Return-Path: <netdev+bounces-80862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204668815A9
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6A4282F4F
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433F5579F;
	Wed, 20 Mar 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6r73Ipx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EABB5579A
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952217; cv=none; b=eyc3PA3evzrurxKMBMfs/5r3F2HG2MBqVecHSaXg8qlbJTjDJQqH1QVSY2CcXSFhyy6tPv0Il+qjwkXwmnpvDcrP/fyRI9fPpxMaWRvl1GfkJKUIU2Hjvdrg5+QrSruHQFozzAwm+5M95YMcmv03FEPCbLHj2shduM7X5cG4gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952217; c=relaxed/simple;
	bh=qNnsYh7Y68Rjw/N7fSgyOG5ZuO8x+F08Ajb4ys1zsbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK8pO0v+M6EtOGgorBJ6eKTuyJwrWN0RflZ/VrnKVKDhIF1Fm+qe/HVAU1ThHFsqvRRBBnPijRmYltSIygbDe0315aOk1asVmrujH8vMyUUF7OfyrtxBXq0XhRQ4LtDJx2iAyNuIGL7DVf9R6SSrHJU6Pk0mNmVqKM0vMSmPdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6r73Ipx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27905C433C7
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710952217;
	bh=qNnsYh7Y68Rjw/N7fSgyOG5ZuO8x+F08Ajb4ys1zsbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E6r73IpxnE+MivxnWLa2S7xSVq/po6dZt7nSik9IWCcneK9K3nDPSjevSYVp+yLqv
	 erT58Mk2Gd4XvBwAOWG17nc0vbfvW8BxH3ZvgiAEKS9AFdP1CNWDg/ItOof9lT2BPS
	 8+TNTzmZVUy6Ld0lCJN6b3Jj991A7ZHxIu1AemLpiZqpQxxijRKQck/JfPzlgVhLbc
	 TDlzZRie3gOvKehQQbyJrMN06qlOZ0j+6jmyW/Hb1S4YsGkNWiMDMo+f1KITtI1CJp
	 /Vb2zxxyfUENOQBUY61y+GyOzrvLN95T45py3ch1PNHERA2L9Z3Agh8vR+H/KQwKq3
	 Pfrr3sw3fuopQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e39226efso68563e87.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:30:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnNN5ptw7VzM2PJApr5yx3/bmU+xk7vswP+bgjQxIGLQ0i+tbAWdULsRe37TLA4juKzDgEusc2gRqUtwx2juMhn6mavCsE
X-Gm-Message-State: AOJu0YxdG3YcfkZap9gzhVYnxIS4vsjC8vi1NjO0vVYV/1TNDCgH4InL
	FDnKO/Y4RJtGIElHJPq9Im52lJ7pfcUC7G+l8gkAXUrpJRwJ/a3MZlCtduLOGQffv7mv3NBDZMG
	aZoEiySowoG8diNGNQdhFQ5mxIw==
X-Google-Smtp-Source: AGHT+IE26y+BcFSBLQawYWlyO9wRRWO1a1dvrlPvlHWMEhVeXIMrgD0ydvKYbJW/6SdHCIzahkIlvXtYB7fvrRLk7y8=
X-Received: by 2002:a05:6512:102a:b0:512:e00b:8da4 with SMTP id
 r10-20020a056512102a00b00512e00b8da4mr11822875lfr.53.1710952215507; Wed, 20
 Mar 2024 09:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41c3ea1df1af4f03b2c66728af6812fb@terma.com> <20240320115433.GT185808@kernel.org>
 <342875f8-e209-456c-bbac-032a5b7de057@moroto.mountain>
In-Reply-To: <342875f8-e209-456c-bbac-032a5b7de057@moroto.mountain>
From: Rob Herring <robh@kernel.org>
Date: Wed, 20 Mar 2024 11:30:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLep6DDecq-HonMd8HF0hD7xGB_ucbZrYUYJSx8t28fFQ@mail.gmail.com>
Message-ID: <CAL_JsqLep6DDecq-HonMd8HF0hD7xGB_ucbZrYUYJSx8t28fFQ@mail.gmail.com>
Subject: Re: [PATCH] net: ll_temac: platform_get_resource replaced by wrong function
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Horman <horms@kernel.org>, Claus Hansen Ries <chr@terma.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Alex Elder <elder@linaro.org>, Wei Fang <wei.fang@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Wang Hai <wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:13=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, Mar 20, 2024 at 11:54:33AM +0000, Simon Horman wrote:
> > > ---
> > >  drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/ne=
t/ethernet/xilinx/ll_temac_main.c
> > > index 9df39cf8b097..1072e2210aed 100644
> > > --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> > > +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> > > @@ -1443,7 +1443,7 @@ static int temac_probe(struct platform_device *=
pdev)
> > >         }
> > >           /* map device registers */
> > > -       lp->regs =3D devm_platform_ioremap_resource_byname(pdev, 0);
> > > +       lp->regs =3D devm_platform_ioremap_resource(pdev, 0);
>
> This should have triggered a Sparse warning "warning: Using plain
> integer as NULL pointer" but the problem is that this file does not have
> correct endian annotations and after a certain number of warnings Sparse
> gives up.

It did[1] along with linker errors on s390. Just no one was CC'ed
other than the author. I guess 0-day gave up after a while.

Rob

[1] https://lore.kernel.org/all/202008070052.yH1Em3c1%25lkp@intel.com/

