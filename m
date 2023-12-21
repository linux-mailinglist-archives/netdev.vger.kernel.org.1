Return-Path: <netdev+bounces-59708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A7281BD94
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499AC285729
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D662814;
	Thu, 21 Dec 2023 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxzzJkDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9973BA2F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a234dc0984fso121415266b.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 09:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703180870; x=1703785670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IU07aYLNHckjzHR23ClSeEkSPrp9AQKmHgtIjVEUWkU=;
        b=CxzzJkDR2CyyFnTiABeBhmgSQV6ISLNilpmdKpPPkCjnksk2+luUJ5OSTj4wjxOrqB
         7IhUNZQzGX6aBOKsKFfUt5vrZdlEVOW1ef/qahKxjhGSeDHJNgsWSYUOG896K3A2SyM4
         ocvsJE5tgEKIxeKT7sNGmP+snNwhcQT+bH2Hs5UbTLWSzaODB8WBSajItiYzAlswURqV
         IFcgN77gteICUZq4t+A8SbDUx6xTZZLtFkFgizR6049QnM2JknVdoH80ZZ+3r9z7f9TE
         M2My/uvoHTFoi+6unyf04tD2Ne8Vvq2Gsg4284OsB/cp+y5+oqfkHNwV6hgGsV9SS4a6
         6+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180870; x=1703785670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU07aYLNHckjzHR23ClSeEkSPrp9AQKmHgtIjVEUWkU=;
        b=pdYqVasjznJsNeRfbfm1fS70W3oII+tZquLck5R2j2O0lPD8tlnDGV4HXWrlXw29Hr
         k0zW1QWwYRIpKPMTjhu4qqdwLqbuS8apqswCI9PCRidZHlzGpr/lRBTNlD3buEUTMVSM
         qDgbOcUrbY4PUKA/OZLXEPFGDxV5ZyLbsscmdo78SvIuNgK0wf3DVdmWXn3hUWMy5err
         vkvIhMg5WpPr605bRX10aOw6MWS22/eeTTTQdVfvGfJEO8aW5cWvhFwlwa6QAWE1nG6a
         9y09AG/0MJuvbLTkKP7PSTOkPHLcUYLxewvCl0jUelMt0/UXUsaLnoSfGGU2hHYVGxgm
         UVIA==
X-Gm-Message-State: AOJu0YwjzWaxEQa44wmX8wqaVPM5Cs/krHEzWGShcHZyTCp2Y5aGLohi
	ysVhuzvuTLlJQNcaVkx/818=
X-Google-Smtp-Source: AGHT+IHCrZ08xRsBtj9PGO9dpvM4KHDOUJIdXanrtXvb4BfZPi/uZgvd54SWuGbAvMRnjE2EVXFclg==
X-Received: by 2002:a17:906:6954:b0:a26:97dc:67d9 with SMTP id c20-20020a170906695400b00a2697dc67d9mr86867ejs.68.1703180869748;
        Thu, 21 Dec 2023 09:47:49 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id az3-20020a170907904300b00a26ae3a93aesm420249ejc.66.2023.12.21.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:47:48 -0800 (PST)
Date: Thu, 21 Dec 2023 19:47:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Message-ID: <20231221174746.hylsmr3f7g5byrsi@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>

On Wed, Dec 20, 2023 at 01:51:01AM -0300, Luiz Angelo Daros de Luca wrote:
> Hello Vladimir,
> 
> I'm sorry to bother you again but I would like your attention for two
> points that I'm not completely sure about.

Ok. Please trim the quoted text from your replies to just what's relevant.
It's easy to scroll past the new bits.

> > +int realtek_common_setup_user_mdio(struct dsa_switch *ds)
> > +{
> > +       const char *compatible = "realtek,smi-mdio";
> > +       struct realtek_priv *priv =  ds->priv;
> > +       struct device_node *phy_node;
> > +       struct device_node *mdio_np;
> > +       struct dsa_port *dp;
> > +       int ret;
> > +
> > +       mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> > +       if (!mdio_np) {
> > +               mdio_np = of_get_compatible_child(priv->dev->of_node, compatible);
> > +               if (!mdio_np) {
> > +                       dev_err(priv->dev, "no MDIO bus node\n");
> > +                       return -ENODEV;
> > +               }
> > +       }
> 
> I just kept the code compatible with both realtek-smi and realtek-mdio
> (that was using the generic "DSA user mii"), even when it might
> violate the binding docs (for SMI with a node not named "mdio").
> 
> You suggested using two new compatible strings for this driver
> ("realtek,rtl8365mb-mdio" and "realtek,rtl8366rb-mdio"). However, it
> might still not be a good name as it is similar to the MDIO-connected
> subdriver of each variant. Anyway, if possible, I would like to keep
> it out of this series as it would first require a change in the
> bindings before any real code change and it might add some more path
> cycles.

I suppose what you don't want is to make the code inadvertently accept
an MDIO bus named "realtek,smi-mdio" on MDIO-controlled switches.

I think it's safe to write a separate commit which just exercises a part
of the dt-binding that the Linux driver hasn't used thus far: that the
node name must be "mdio". You don't need to fall back to the search by
compatible string if there is nothing broken to support, and it's all
just theoretical (and even then, the theory is not supported by the DT
binding).

> > +       priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> > +       if (!priv->user_mii_bus) {
> > +               ret = -ENOMEM;
> > +               goto err_put_node;
> > +       }
> > +       priv->user_mii_bus->priv = priv;
> > +       priv->user_mii_bus->name = "Realtek user MII";
> > +       priv->user_mii_bus->read = realtek_common_user_mdio_read;
> > +       priv->user_mii_bus->write = realtek_common_user_mdio_write;
> > +       snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
> > +                ds->index);
> > +       priv->user_mii_bus->parent = priv->dev;
> > +
> > +       /* When OF describes the MDIO, connecting ports with phy-handle,
> > +        * ds->user_mii_bus should not be used *
> > +        */
> > +       dsa_switch_for_each_user_port(dp, ds) {
> > +               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> > +               of_node_put(phy_node);
> > +               if (phy_node)
> > +                       continue;
> > +
> > +               dev_warn(priv->dev,
> > +                        "DS user_mii_bus in use as '%s' is missing phy-handle",
> > +                        dp->name);
> > +               ds->user_mii_bus = priv->user_mii_bus;
> > +               break;
> > +       }
> 
> Does this check align with how should ds->user_mii_bus be used (in a
> first step for phasing it out, at least for this driver)?

No. Thanks for asking.

What I would like to see is a commit which removes the line assigning
ds->user_mii_bus completely, with the following justification:

ds->user_mii_bus helps when
(1) the switch probes with platform_data (not on OF), or
(2) the switch probes on OF but its MDIO bus is not described in OF

Case (1) is eliminated because this driver uses of_device_get_match_data()
and fails to probe if that returns NULL (which it will, with platform_data).
So this switch driver only probes on OF.

Case (2) is also eliminated because realtek_smi_setup_mdio() bails out
if it cannot find the "mdio" node described in OF. So the ds->user_mii_bus
assignment is only ever executed when the bus has an OF node, aka when
it is not useful.

Having the MDIO bus described in OF, but no phy-handle to its children
is a semantically broken device tree, we should make no effort whatsoever
to support it.

Thus, because the dsa_user_phy_connect() behavior given by the DSA core
through ds->user_mii_bus does not help in any valid circumstance, let's
deactivate that possible code path and simplify the interaction between
the driver and DSA.

And then go on with the driver cleanup as if ds->user_mii_bus didn't exist.

Makes sense? Parsing "phy-handle" is just absurdly complicated.

> > +
> > +       ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
> > +       if (ret) {
> > +               dev_err(priv->dev, "unable to register MDIO bus %s\n",
> > +                       priv->user_mii_bus->id);
> > +               goto err_put_node;
> > +       }
> > +
> > +       return 0;
> > +
> > +err_put_node:
> > +       of_node_put(mdio_np);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(realtek_common_setup_user_mdio);

