Return-Path: <netdev+bounces-16492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A530D74DA09
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF08628127D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79312B73;
	Mon, 10 Jul 2023 15:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172E12B72
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:38:32 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6CD1
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:38:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso20647395e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689003510; x=1691595510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wREW++oWpby3r1yXKBr7qrEicoT80iezBlxuTJgdE40=;
        b=XxEX3n+pMtdahG06DbT3jd6+IkPMky4r7o4Nw8lxX9Jy0iDwo81Y8hRO5gnPiVCdIE
         JETQorEAFUY9WdCS20Fykz1WYiG+Tlz/P+tJF0DqQMmjpHKoFD7/Brr82emy6WX3yGq7
         jpTPIF/APly7Uwa55kYGJZ9SsOX9xig+bKcqBwjdPfXnVfs/L3Yblj5kdUa89ZdOhMhD
         yVsLnKjEWzstP4nvQ2q+qoKqjmVnZ8o2pKtd+zbnm/KJdrdrivG7EitbgWseW64bzFgZ
         04Z4VQMtRCpROwCQq3IJKDcrU9gX4vuMTlqQPcEe/xrSxacPmbjP4vxBlOqaEQjS1zud
         mR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689003510; x=1691595510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wREW++oWpby3r1yXKBr7qrEicoT80iezBlxuTJgdE40=;
        b=LQ+skHMv7g8xjoT9dGATmIso5Yk1gZxfCePobP8A1twXmIP93ub+8yrrkJ7GKRDQfS
         bNzQAPzufHAuwpfoHJZg/leXMnht6knUD+c+OdJC/Andu4BtNOIDH/vR/8+DLF/DkeHP
         qkEBvx3+u1eAA7dfTW2q9pSN0QI0R2tmJd46hTQ25xO1HtGHbQdEkWBW7gI8/2DAWILE
         0YD//XCW64x3aaLYOV5I5llKDcNAJzmmqEEFT2s1HkTk1fPSWFSQAygYCleikcVoYwAO
         bgThroPSqer/D2PMz4rhEDBjt+zmEDoA/sxiO+sM0gByjqYbqmX95+ZyTn04/PwMRst6
         I5qQ==
X-Gm-Message-State: ABy/qLZ0SDG/C8cYgN85vhw+ool6ymQ5CbxtRgSCYOxy/F4hydSUnIRF
	/6WDS6ZIvWbe+EvDQZb4JqI=
X-Google-Smtp-Source: APBJJlHWeH97qc0uGgrrOx9IjF7ZdBAyWBieOLYKwtExK8k33U7XV08ww3pzhOGsMJt5C4gPCkSH7A==
X-Received: by 2002:a7b:ce11:0:b0:3f7:f584:5796 with SMTP id m17-20020a7bce11000000b003f7f5845796mr12278348wmc.2.1689003509512;
        Mon, 10 Jul 2023 08:38:29 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003fb739d27aesm10544969wmj.35.2023.07.10.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:38:29 -0700 (PDT)
Date: Mon, 10 Jul 2023 18:38:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <20230710153827.jhdbl5xh3stslz3u@skbuf>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
 <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 05:35:35PM +0300, Sergei Antonov wrote:
> On Mon, 10 Jul 2023 at 15:35, Vladimir Oltean <olteanv@gmail.com> wrote:
> > > +static void mv88e6060_get_caps(struct dsa_switch *ds, int port,
> > > +                              struct phylink_config *config)
> > > +{
> > > +       __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
> > > +       __set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
> >
> > This is enough to fix phylink generic validation on the front-facing
> > ports with internal PHYs. But it is possible (and encouraged) to use
> > phylink on the CPU port too (rev-mii, rev-rmii); currently that's not
> > enforced for mv88e6060 because it's in the dsa_switches_apply_workarounds[]
> > array.
> >
> > Could you please modify your device tree to add a fixed-link and
> > phy-mode property on your CPU port so that phylink does get used
> 
> I already have fixed-link and phy-mode on CPU port. See below.

And with PHY_INTERFACE_MODE_MII missing from supported_interfaces, how
did phylink_generic_validate() not fail for the CPU port?

... goes to check dsa_port_phylink_validate() ...

ah, the call to phylink_generic_validate() is skipped because you're not
setting config->mac_capabilities in your mini implementation.
Please also set that - take other drivers as a model. But for
config->legacy_pre_march2020, I guess you don't have to explicitly set
that to false, because dsa_port_phylink_create() doesn't set it to true,
either.

> > , and
> > populate supported_interfaces and mac_capabilities properly on the MII
> > ports (4 and 5) as well (so that it doesn't fail validation)?
> 
> By setting bits in .phylink_get_caps function?

Yes, depending on which port it is and how it is configured to be used.

> Should I remove mv88e6060 from dsa_switches_apply_workarounds too?

If the device tree doesn't have fixed-link and phy-mode on the CPU port,
a phylink instance will fail to be created there, and the switch will
fail to probe. The presence in dsa_switches_apply_workarounds[] allows
phylink to be skipped for the CPU port.

I won't oppose to mv88e6060 getting removed from that array, but if
there exist production device trees with the above characteristics,
it would be unwise to break them.

That being said, given the kind of bugs I've seen uncovered in this
driver recently, I'd say it would be ridiculous to play pretend - you're
probably one of its only users. You can probably be a bit aggressive,
remove support for incomplete device trees, see if anyone complains, and
they do, revert the removal.

> &mdio1 {
>         status = "okay";
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         switch@10 {
>                 compatible = "marvell,mv88e6060";
>                 reg = <0x10>;
> 
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         port@0 {
>                                 reg = <0>;
>                                 label = "lan2";
>                         };
> 
>                         port@1 {
>                                 reg = <1>;
>                                 label = "lan3";
>                         };
> 
>                         port@2 {
>                                 reg = <2>;
>                                 label = "lan1";
>                         };
> 
>                         port@5 {
>                                 reg = <5>;
>                                 label = "cpu";
>                                 ethernet = <&mac1>;
>                                 phy-mode = "mii";

I think we have phy-mode = "rev-mii" for "MAC acting as MII PHY", rather
than "mii" which is "MAC acting as MII MAC".

> 
>                                 fixed-link {
>                                         speed = <100>;
>                                         full-duplex;
>                                 };
>                         };
>                 };
>         };
> };

