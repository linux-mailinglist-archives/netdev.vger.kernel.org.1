Return-Path: <netdev+bounces-59969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5EC81CF1B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 21:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E45B239FB
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E522E825;
	Fri, 22 Dec 2023 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei1ekEVO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B992E821
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccb778160cso492621fa.3
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703275430; x=1703880230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c/nm/zLCkf+h7897OUvEe28LkzER+jqbqWsEIYYVv/4=;
        b=ei1ekEVOC2PicOzCaw4NI4jrzsgmO5iFoeeymdPvU9mpfEqLrL/RJrr6gCGyzgefSv
         lwOvm4uru/6RNJ7jCom4QbjrNh5hFuza3A4ZerQY3QGnatzaXh7WwXtPH4mALS6T1zPn
         kEDqAuu+Dth5kuHLVEIkMtNDmVVKIxxyL3S63Y8/p3cTqQzyestzjEK1Wf1ypjI8mDlr
         mo8Be2lCKfb0OAE2Ua4HNx5PI97nvM9zGc4pn6bkFmP2Yqw3fBJwdkhll0RtgdEi9qkz
         oVOSbWZUvaDsiTcKbS9FpdiTAViBYVO/sSCI9pforT1Wjda7xib0kwLDtHMtU8YzUyJl
         +XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703275430; x=1703880230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/nm/zLCkf+h7897OUvEe28LkzER+jqbqWsEIYYVv/4=;
        b=A279TJW49is460QslXsjq8Fmj9aMC04wY8HJX2MZjjTunS2/ciZl3BHsPVH6eIEYhv
         Fc2jw4DyuhW/3i0ORMbKeWHGGhQzkX2F614FVoy0d1nMrGE6HNw8cPY3SAtVs23AZWEM
         eG6To+tlR7st/R8EetFkbttNKKd+TmXZeM3J8VKKqCXB9+ve2ddKv3eheA7VmZEr6M5/
         kINTxkUQk2Q5hFVQVXRkASG7QG4mou/RHfP11RMhlW0JAiXCzdkYkDsLnA0LoZuqfx0O
         LpStGx9Shcd3HQgD4KCOjfxCTv0UkgIsqKOL1rdae3D/NCZNYTmUFlAhSBq55yuE5D3w
         mOoQ==
X-Gm-Message-State: AOJu0YwTNusb4F2IDjL2v+YpNzJl7HtrCce1GTY/y92IGFKh2cr2kzN7
	CIGFx+akx/W4dDIhXCXx/cg1Vk7R/9ndPlFZAIVAZEmL8hE=
X-Google-Smtp-Source: AGHT+IFvJcY3PnwnVQbracV4SaLLiwBl4SBLgzjLx96rbRUMC7eTatJ0a/4kDp1BZ4WYdk/SVOsvYZHYBxnh2TFIOdU=
X-Received: by 2002:a2e:9e53:0:b0:2cc:788a:3d4d with SMTP id
 g19-20020a2e9e53000000b002cc788a3d4dmr1042714ljk.51.1703275429569; Fri, 22
 Dec 2023 12:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com> <20231221174746.hylsmr3f7g5byrsi@skbuf>
In-Reply-To: <20231221174746.hylsmr3f7g5byrsi@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 22 Dec 2023 17:03:38 -0300
Message-ID: <CAJq09z5zN86auxMOtfUOqSj9XzU-Vs8_=7UzfY-d=-N9dgAPyA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> Ok. Please trim the quoted text from your replies to just what's relevant.
> It's easy to scroll past the new bits.

OK

>
> > > +int realtek_common_setup_user_mdio(struct dsa_switch *ds)
> > > +{
> > > +       const char *compatible = "realtek,smi-mdio";
> > > +       struct realtek_priv *priv =  ds->priv;
> > > +       struct device_node *phy_node;
> > > +       struct device_node *mdio_np;
> > > +       struct dsa_port *dp;
> > > +       int ret;
> > > +
> > > +       mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
> > > +       if (!mdio_np) {
> > > +               mdio_np = of_get_compatible_child(priv->dev->of_node, compatible);
> > > +               if (!mdio_np) {
> > > +                       dev_err(priv->dev, "no MDIO bus node\n");
> > > +                       return -ENODEV;
> > > +               }
> > > +       }
> >
> > I just kept the code compatible with both realtek-smi and realtek-mdio
> > (that was using the generic "DSA user mii"), even when it might
> > violate the binding docs (for SMI with a node not named "mdio").
> >
> > You suggested using two new compatible strings for this driver
> > ("realtek,rtl8365mb-mdio" and "realtek,rtl8366rb-mdio"). However, it
> > might still not be a good name as it is similar to the MDIO-connected
> > subdriver of each variant. Anyway, if possible, I would like to keep
> > it out of this series as it would first require a change in the
> > bindings before any real code change and it might add some more path
> > cycles.
>
> I suppose what you don't want is to make the code inadvertently accept
> an MDIO bus named "realtek,smi-mdio" on MDIO-controlled switches.

I don't think it would hurt that much. I was just trying to keep the
old code behavior.

> I think it's safe to write a separate commit which just exercises a part
> of the dt-binding that the Linux driver hasn't used thus far: that the
> node name must be "mdio". You don't need to fall back to the search by
> compatible string if there is nothing broken to support, and it's all
> just theoretical (and even then, the theory is not supported by the DT
> binding).

OK. I'll drop the compatible part.

> > > +       priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> > > +       if (!priv->user_mii_bus) {
> > > +               ret = -ENOMEM;
> > > +               goto err_put_node;
> > > +       }
> > > +       priv->user_mii_bus->priv = priv;
> > > +       priv->user_mii_bus->name = "Realtek user MII";
> > > +       priv->user_mii_bus->read = realtek_common_user_mdio_read;
> > > +       priv->user_mii_bus->write = realtek_common_user_mdio_write;
> > > +       snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
> > > +                ds->index);
> > > +       priv->user_mii_bus->parent = priv->dev;
> > > +
> > > +       /* When OF describes the MDIO, connecting ports with phy-handle,
> > > +        * ds->user_mii_bus should not be used *
> > > +        */
> > > +       dsa_switch_for_each_user_port(dp, ds) {
> > > +               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> > > +               of_node_put(phy_node);
> > > +               if (phy_node)
> > > +                       continue;
> > > +
> > > +               dev_warn(priv->dev,
> > > +                        "DS user_mii_bus in use as '%s' is missing phy-handle",
> > > +                        dp->name);
> > > +               ds->user_mii_bus = priv->user_mii_bus;
> > > +               break;
> > > +       }
> >
> > Does this check align with how should ds->user_mii_bus be used (in a
> > first step for phasing it out, at least for this driver)?
>
> No. Thanks for asking.
>
> What I would like to see is a commit which removes the line assigning
> ds->user_mii_bus completely, with the following justification:
>
> ds->user_mii_bus helps when
> (1) the switch probes with platform_data (not on OF), or
> (2) the switch probes on OF but its MDIO bus is not described in OF
>
> Case (1) is eliminated because this driver uses of_device_get_match_data()
> and fails to probe if that returns NULL (which it will, with platform_data).
> So this switch driver only probes on OF.
>
> Case (2) is also eliminated because realtek_smi_setup_mdio() bails out
> if it cannot find the "mdio" node described in OF. So the ds->user_mii_bus
> assignment is only ever executed when the bus has an OF node, aka when
> it is not useful.
>
> Having the MDIO bus described in OF, but no phy-handle to its children
> is a semantically broken device tree, we should make no effort whatsoever
> to support it.

OK. I was trying to keep exactly that setup working. Should I keep the
check and bail out with an error like:

+       dsa_switch_for_each_user_port(dp, ds) {
+               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
+               of_node_put(phy_node);
+               if (phy_node)
+                       continue;
+               dev_err(priv->dev,
+                       "'%s' is missing phy-handle",
+                       dp->name);
+               return -EINVAL;
+       }

or should I simply let it break silently? The device-tree writers
might like some feedback if they are doing it wrong. I guess neither
DSA nor MDIO bus will say a thing about the missing phy-handle.

Regards,

Luiz

