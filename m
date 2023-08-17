Return-Path: <netdev+bounces-28586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41D77FE6E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53805282161
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6851805B;
	Thu, 17 Aug 2023 19:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209161643A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:17:59 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC730D1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:17:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-997c4107d62so13041966b.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692299877; x=1692904677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiqA4wdkp8wHPiaXDa/GAUGHyeTadmKOnE888j0+/ak=;
        b=YxMCKafoQE8tyR7rGTA2DofzQD49nndaaqYg9PjBrd5RyRvkNZ+QHvNzO+mroB75RL
         04Z/7bHu9lQZTCJgXpoLVGeKzA0ktmEnn6fZj4Ad3XgcE4KHEOcS0+nd7hdzBlZWaeGR
         6fS7/PmspJb+LABREIVMykUOjTW/6vw2BI084ucWM6NFC1OTBFD41GmqLjNcPd/Xlhvt
         DYUpJdoiTSIgfk5xNFmKAcSXh0Q0TifXLCqLY00wxXISF1co9ubvomWSCiacxjOZ3n0a
         RYcRVe9Vc5arGfaFl4P9PQTlrxuALa8/kbir36C+0E0sVqXEsWqMNyMg2UNiuSIFvgx9
         t9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692299877; x=1692904677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiqA4wdkp8wHPiaXDa/GAUGHyeTadmKOnE888j0+/ak=;
        b=kBCmu2L8sLwsjvcTDi2Yr+OJdL38UGckvu201qSu3a+fjRFdzcaj6NWuqEB9HXlW7H
         TLJsd0Rl3wvDumR0INZzekyltlk/GFPA/IDDRulzNms2Qix2Dz+GqwkpQwsD1RB37dvg
         G15WLVS5s375A5EOMrOA2TXmnWrPkEO0X+vJh9jtc1bulBGNdLeGHdFAoPxAl54kSVgN
         IcJQn5UKxDfXDIEWGBA0W0vHI1bj14/aa7Ldvo6LCcn1U4cFW5VzU+P/ko77VDRXTtZY
         LuL6de7tu2hx8q78js1WlZB0VTbsoWzlN/BuCjyZSv2Gmtf8040Meu/TGcHDGWx8jNjd
         aUNg==
X-Gm-Message-State: AOJu0YwLfSHiNenOULyrddiDGujrXcl0SBRX+DyhR1IaGn2LsfP/oix4
	G1KyeNgaYsk/CtdFW43nGbM=
X-Google-Smtp-Source: AGHT+IFBbHTJGO1vqDxJa5y3quuxoomcpwOKmBXsPezC8QvVXfhb+hKlTBQ1x3XIeyACFdVQ5eysBA==
X-Received: by 2002:a17:906:2255:b0:994:1844:c7d1 with SMTP id 21-20020a170906225500b009941844c7d1mr317383ejr.13.1692299877034;
        Thu, 17 Aug 2023 12:17:57 -0700 (PDT)
Received: from skbuf ([188.25.231.206])
        by smtp.gmail.com with ESMTPSA id uz7-20020a170907118700b0099bd046170fsm110950ejb.104.2023.08.17.12.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 12:17:56 -0700 (PDT)
Date: Thu, 17 Aug 2023 22:17:54 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230817191754.vopvjus6gjkojyjz@skbuf>
References: <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 08:52:12PM +0200, Andrew Lunn wrote:
> > Andrew, I'd argue that the MAC-PHY relationship between the DSA master
> > and the CPU port is equally clear as between 2 arbitrary cascade ports.
> > Which is: not clear at all. The RGMII standard does not talk about the
> > existence of a MAC role and a PHY role, to my knowledge.
> 
> The standard does talk about an optional in band status, placed onto
> the RXD pins during the inter packet gap. For that to work, there
> needs to be some notion of MAC and PHY side.

Well, opening the RGMII standard, it was quite stupid of myself to say
that. It says that the purpose of RGMII is to interconnect the MAC and
the PHY right from the first phrase.

You're also completely right in pointing out that the optional in-band
status is provided by the PHY on RXD[3:0].

Actually, MAC-to-MAC is not explicitly supported anywhere in the standard
(RGMII 2.0, 4/1/2002) that I can find. It simply seems to be a case of:
"whatever the PHY is required by the standard to do is specified in such
a way that when another MAC is put in its place (with RX and TX signals
inverted), the protocol still makes sense".

But, with that stretching of the standard considered, I'm still not
necessarily seeing which side is the MAC and which side is the PHY in a
MAC-to-MAC scenario.

With a bit of imagination, I could actually see 2 back-to-back MAC IPs
which both have logic to provide the optional in-band status (with
hardcoded information) to the link partner's RXD[3:0]. No theory seems
to be broken by this (though I can't point to any real implementation).

So a MAC role would be the side that expects the in-band status to be
present on its RXD[3:0], and a PHY role would be the side that provides
it, and being in the MAC role does not preclude being in the PHY role?

