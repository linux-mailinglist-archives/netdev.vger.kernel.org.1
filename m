Return-Path: <netdev+bounces-146002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8969D1A31
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934B32822D8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1B1E5728;
	Mon, 18 Nov 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyulvbLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B017BA3;
	Mon, 18 Nov 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964375; cv=none; b=tnOFwKBxmUcBKp5qSN3NQnZVBKY3kCgOeUx4qngDJCc0gacRX3p4NuKGEYOHQseVRS2MiBn8urlUaqYZUWCjesyMiReRA8UbGIvMhMHJlIBo7nxSJTMmxliAaMzigQg0riiXHGQmELHhmr1+hLvl7+LssHeAfdkWR/k/VorPg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964375; c=relaxed/simple;
	bh=ewVz1DZRIan1+fIM/YCeXPojoypG4/zDKJX3MFb9ZiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcTtf6n66yS4vet3bQA3Vakjgj6ZZfeI+gyVntzsBGmqxnxtQV6tuFcMrj1HQ8LsMc/q9pdvjv3+jNM5JtjjitCAd8KQxMkruPmIdNGQAxHyeqkm36FfIYKxK8B21XSyhx6zsNCzuXecrjQW3TmIEGEQ6IzkaD3bV+TtLG2JTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyulvbLm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ee7a48377cso19134247b3.3;
        Mon, 18 Nov 2024 13:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731964372; x=1732569172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R12jaGMpif5tldA6kYnqRJJmWOjT1vpwH1bhpFgMaQs=;
        b=NyulvbLmzjbviCVYyHVsafLzmGv4/lJCAIGxxXtRemLSTZuDyu2Ccm+mGHCfOrngr8
         xZQA7Xy4jlOgaz3KalXj/1vzyvyMLyKfZq9MnlXI0hXbDSL+3TVRZS+NXswv7JKKPodl
         cQPwRD0PT4rtXbIik1h46Vl4lX+rk1DiAh3D70wWrWRfc+5HnBaI82X2OVMV9XS4jxDS
         KWIcz1yGzKZB325jmHAeFILY68CnS+eSJqDhH8bReaQkVLUENK6HddmMFOwlE3YL9rdr
         z80jX7LxP2Y25A3nUn0qbifAJHJM7T3JZtZtR5wWEbDEk8w/aIyCIN4kNrRVKBpCxYre
         SgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731964372; x=1732569172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R12jaGMpif5tldA6kYnqRJJmWOjT1vpwH1bhpFgMaQs=;
        b=dDXwOsruzH+sjE9sE07OaHTCqSdofkN3lfO+jeLhBtTGbfpPUauJf5ySwkJVedd+ab
         nG4nrTAqQcmuqE0Y7kvD548CBre0uxtGb/eOjCRS4RXZ7cUpeb378srwO9amLnXWm3cM
         1eWr8ORMKNhyQsn+VqyiBS7oEtm8BRXReq00VKJDjcpT2tXXZlklVslmAnYZgofzSEoc
         +WDzcryw/oc1RFYE8kq0h0JR5z6qpVhjiZ/cHxbBQV50ACVyuYyj/6zoW1LK2e9Pf4VS
         tA138iwSpnv8dgLk++blwlG4fhV+AY/efR6+jOZnurDVUOJwBv7n4CK1GyRFbPf2MV1U
         Bs+w==
X-Forwarded-Encrypted: i=1; AJvYcCWAbO70ZK0ThrhyvT536gMTC7lPVK4H+rqN0wbm+r1sAMTHnYtsC/qgOQQZ+HdYo+YqMgPFELkv@vger.kernel.org, AJvYcCXx5rmb8ALpo6LIYaBTm4UkE+lEONPr+KxE/xhRXrejQ3up0xMKJe8JRQS0G8HtQS/I5Ga4qKqfkESr/c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNAGmo2mi92daE54W8bNXuoV09U+CbgYWm9/Gc6qzF35UwW7N
	HuMRIJbDe1Pr7FJQmVAXsJElLw2FfptjVCOh8IidWjCX5WO+cbRtUg8juR46ecR9JkHt3JsU67b
	rkWVAXs0G6nEFgaf5hrzNaPUqyMs=
X-Google-Smtp-Source: AGHT+IEfvJf633/zOvn315pGpDgQUPTDb6+hOwu/aB/EQi8qfuSLINEZ0P/LvU+5Dnvq80dyofLl/0NvWf1e/UO11A8=
X-Received: by 2002:a05:690c:6f05:b0:6de:2ae:811f with SMTP id
 00721157ae682-6ee55c75d58mr145016327b3.35.1731964372494; Mon, 18 Nov 2024
 13:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117212827.13763-1-rosenp@gmail.com> <5562cf54-d1bd-4235-b232-33f5cca40b85@quicinc.com>
 <ZzskoS2jwC6eLlmD@shell.armlinux.org.uk>
In-Reply-To: <ZzskoS2jwC6eLlmD@shell.armlinux.org.uk>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 18 Nov 2024 13:12:41 -0800
Message-ID: <CAKxU2N_zcNB-0gBKPnPo3kjZ7mZpzbiB63JFGVZ5jd1U-LjxSA@mail.gmail.com>
Subject: Re: [PATCH net] net: mdio-ipq4019: fix wrong NULL check
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jie Luo <quic_luoj@quicinc.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:27=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Nov 18, 2024 at 06:26:27PM +0800, Jie Luo wrote:
> > On 11/18/2024 5:28 AM, Rosen Penev wrote:
> > > devm_ioremap_resource returns a PTR_ERR when it fails, not NULL. OTOH
> > > this is conditionally set to either a PTR_ERR or a valid pointer. Use
> > > !IS_ERR_OR_NULL to check if we can use this.
> > >
> > > Fixes: 23a890d493 ("net: mdio: Add the reset function for IPQ MDIO dr=
iver")
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >   drivers/net/mdio/mdio-ipq4019.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-=
ipq4019.c
> > > index dd3ed2d6430b..859302b0d38c 100644
> > > --- a/drivers/net/mdio/mdio-ipq4019.c
> > > +++ b/drivers/net/mdio/mdio-ipq4019.c
> > > @@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
> > >     /* To indicate CMN_PLL that ethernet_ldo has been ready if platfo=
rm resource 1
> > >      * is specified in the device tree.
> > >      */
> > > -   if (priv->eth_ldo_rdy) {
> > > +   if (!IS_ERR_OR_NULL(priv->eth_ldo_rdy)) {
> > >             val =3D readl(priv->eth_ldo_rdy);
> > >             val |=3D BIT(0);
> > >             writel(val, priv->eth_ldo_rdy);
> >
> > Reviewed-by: Luo Jie <quic_luoj@quicinc.com>
>
> Looking at the setup of this:
>
>         /* The platform resource is provided on the chipset IPQ5018 */
>         /* This resource is optional */
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         if (res)
>                 priv->eth_ldo_rdy =3D devm_ioremap_resource(&pdev->dev, r=
es);
>
> While this is optional, surely the optional part is whether resource 1
> is provided or not. If the resource is provided, but we fail to ioremap
> it, isn't that an error which should be propagated? In that situation,
> isn't the firmware saying "we have a second resource" but failing to
> map it should be an error?

Another way to look at it is, if we convert this to

devm_platform_get_and_ioremap_resource(pdev, 1, &res);

it seems to only write to res if platform_get_resource succeeds and
otherwise doesn't care. The only real way to check if found is
!IS_ERR().

Actually the more appropriate function here is
devm_platform_ioremap_resource , which doesn't write to a struct
resource.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

