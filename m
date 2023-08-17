Return-Path: <netdev+bounces-28569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3877FDDA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB9D1C21499
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D917AA5;
	Thu, 17 Aug 2023 18:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C491802B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:27:55 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F723591
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:27:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99df11828c6so261854266b.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692296851; x=1692901651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w92DhNqoyOHm156xMR+Hqr8vpxm1PShNyD7smavKX8M=;
        b=gEoMnHaCO1qvg8/n15F0wH40zA39+Ds2dl9oTETbF9ot3hafEhF5LxNOxC3NJh7rc4
         VJBaafULWTkwImuXQbaLnyfBiLDU0pNeekCN+KJcoGsGIH1FIzDN3yzsiec2nOfMAGm9
         oLZsFvDDq/f/+mxyQP+Qa9Tz0wM0e1WHmZpyeT8C1cYPhPGCWWRRHTPrOlOhdQajQhKt
         F+AcRwaqvP5KU/lSuH/Ls57YXaqbg9hprtjsiM//AtT/XkGcSGo0pTl/BDUR8tbZDqIu
         ndOV7TiVFVITd6NVbNSB2qe7C0FXcB0C8HsZKbrIza6mP+dlJW5HBkF/Z6/JgYk135M0
         zLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296851; x=1692901651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w92DhNqoyOHm156xMR+Hqr8vpxm1PShNyD7smavKX8M=;
        b=lFsAElmIBAbZb0RxkTXUuce8DBnjBDnQCewuFct1jzFvJja+hnzyNZCC9JH4sensYD
         /Zkjgh7BWGhFRwma2qHo1J1DURzqJ5Nnx0jPvMgspHdht7syRtHS7/spqd2F+7yzOMt+
         em6VnsrfsMh/7L9GGJdS64Y3gxhU4pvU964gxdQwlxM6+6LQzeCWyVEJMrCr4u2dVa25
         k2VEe3LCdcGijg64tfb2yL+p6hkO4TieegWqT4l41wobg9EGoHgdSAYi0hhVSkVUrAoP
         QsFaLQckgkNKbjhGNN8mkyaIYu1dnwmCDigRHLlD8vfBYeL6hhl3pexKaODwnSfwh6PW
         oRtQ==
X-Gm-Message-State: AOJu0YxxYX617mPXPjGTcf/JpWvkn+Sg8K1TiHqATnerCuv4gt6m6+51
	k6JzPJMve6k4sw0146yIYbU=
X-Google-Smtp-Source: AGHT+IFHUNPrEhMgaWzmY5oegnKzHrbs6HcKkRuLnC3IvUrj6GQnsTZPw7/Rl2K0U/XJ7H0UCV1TAA==
X-Received: by 2002:a17:906:cc0e:b0:99d:fcb7:60db with SMTP id ml14-20020a170906cc0e00b0099dfcb760dbmr238873ejb.16.1692296851421;
        Thu, 17 Aug 2023 11:27:31 -0700 (PDT)
Received: from skbuf ([188.25.231.206])
        by smtp.gmail.com with ESMTPSA id x19-20020a170906299300b00992b66e54e9sm51648eje.214.2023.08.17.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:27:31 -0700 (PDT)
Date: Thu, 17 Aug 2023 21:27:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230817182729.q6rf327t7dfzxiow@skbuf>
References: <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 07:05:19PM +0200, Andrew Lunn wrote:
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:
>                                        switch0port5: port@5 {
>                                                 reg = <5>;
>                                                 label = "dsa";
>                                                 phy-mode = "rgmii-txid";
>                                                 link = <&switch1port6
>                                                         &switch2port9>;
>                                                 fixed-link {
>                                                         speed = <1000>;
>                                                         full-duplex;
>                                                 };
>                                         };
> 
> and the other end of this link:
> 
>                                         switch1port6: port@6 {
>                                                 reg = <6>;
>                                                 label = "dsa";
>                                                 phy-mode = "rgmii-txid";
>                                                 link = <&switch0port5>;
>                                                 fixed-link {
>                                                         speed = <1000>;
>                                                         full-duplex;
>                                                 };
>                                         };
> 
> imx7d-zii-rpu2.dts:
>                                 port@5 {
>                                         reg = <5>;
>                                         label = "cpu";
>                                         ethernet = <&fec1>;
>                                         phy-mode = "rgmii-id";
> 
>                                         fixed-link {
>                                                 speed = <1000>;
>                                                 full-duplex;
>                                         };
>                                 };
> 
> With the 'cpu' case, it is clearly acting like a PHY to the SoCs MAC,
> so it does not seem too unreasonable for it to act upon it. For a DSA
> link there is not a clear MAC-PHY relationship, but we do somehow need
> to specify delays.

Andrew, I'd argue that the MAC-PHY relationship between the DSA master
and the CPU port is equally clear as between 2 arbitrary cascade ports.
Which is: not clear at all. The RGMII standard does not talk about the
existence of a MAC role and a PHY role, to my knowledge. These are 2
MACs back to back, in both cases.

With rx-internal-delay-ps and tx-internal-delay-ps in each MAC node, you
get the freedom of specifying RGMII delays in whichever way is needed,
without baking in any assumption that the port plays the role of a PHY
or not.

