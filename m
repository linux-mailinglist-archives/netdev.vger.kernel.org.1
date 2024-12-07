Return-Path: <netdev+bounces-149895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FE9E7FC8
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 13:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F68616532B
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D426146596;
	Sat,  7 Dec 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2WuIifk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B08289A;
	Sat,  7 Dec 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733573491; cv=none; b=d5oyZ6vPaCoMJKR9JRBL8L3FM14zJNP9PuztLA5wyQdamFYsFN5gZwceKUtUmN9h5crPiE+lVXuRL5h026yGnkNzFaUfqgTu8Btr7/9+7JgpSCehNhyMzqPcwnmw8hVaCBTQ8HiMb1nYafff3MnkxYAjxxjobYen1NxYtWRNhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733573491; c=relaxed/simple;
	bh=WQFRlQ40wu3po75SrB4B914xc9S1o7XdNAc3D2h4fe8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2V7Jbbw4VoRAlPYQCkgptEykrry6Q8JO/aVMdB6deFnk+oOVjV30cfbRbKym56rsDEsV2kx24EWP/mahDHsrDE7TzI9WcQ3EAPk8bktTzZblLeKc6WrnHerOzPaKXya2Sp/6a7toRRZGSvzdbH4L/Ohx8/nZy+jk3Ls+kCjMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2WuIifk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so18963655e9.2;
        Sat, 07 Dec 2024 04:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733573488; x=1734178288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MORvaT+pWKtn1cwQqnuWOdhU3VjTsfcB27db/IuY4zk=;
        b=L2WuIifkWs6FoPybmCqB4ITgjmcc10x7Bkntp6AWsDQd/TjcOIEeOBfxWLEls/GBP0
         CLIk9VKav4HgCNGkpHbiFxZFq5AhxMhomXPayfPg5UKha81UP14E52gi+ifhWZ1T/ll2
         g6ySm8Pz2ZQGs6f00y/VoErs5zh/DTFwNCDDcg/lgqBPQY/bBarsvM/qBcoEoJYpO5ev
         gcovN6kvozYkgG9PzSdLs7HkDT7uW6LcuoDgywUe+v2Jkm9j0COBHHnXxp6tbGfrpNNE
         d/H8oIeqjy7UcmRYI8yZ4vvphMGEQRlt4K9SToGQTinqad1aVS/QglTF6YoPTUebauUH
         7ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733573488; x=1734178288;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MORvaT+pWKtn1cwQqnuWOdhU3VjTsfcB27db/IuY4zk=;
        b=D9rjN06/32qVx/2eV8nbB4pV13ClCzRNesGcz4VCBftxzkMkWHBogNuJE+j/2b/LTd
         9qGJT29wlzqUT2exUxJwpEpH5SHbrwjvxCjC85GqIAh3XQ6cHpnW5d7W6QMdHHD/g2Wk
         wWlO75FiEc4jxPephftuMrrFfYoMyvr1Abt40XczLkDaOZwJE54YSG1X92FCpN9Uwj85
         GZxc1roIxb3CuWX167s80jFtz57zdPm8CVR2KvbHoEAByb4/SQZPa/vtIriEowQMBVsg
         6EY4VhVM2sXKM9R4qfhiIUa2v9UoyWt45WOmrmPzCXAB1flXI3LCWX8ih9zMB65GPNdJ
         hdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf2WROfzLoXmq7wWfopd7s7JQ3eTjucdaWKjBCiStGhhMJbUTQ0iSp6Kesi3ufGQXJd8HbzIkJBrHH@vger.kernel.org, AJvYcCUo+YsruOWcSVyQZd9gGSnqUR4woC2JHJB//5IDlit5qhYedlRh9joPXJtnet8lspVKcfvk5TML@vger.kernel.org, AJvYcCVjsk2dMLetr5Ab6sbMoCuiLNzt4Ejs1pvu0Q3UkzlUJ28a/tn8dSZ5Y6ETSQXNPcfI0uVzA97Woe97jRbL@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwJ0UEENfnaoYOwRofiXsVa+FLoR+E+e3WQ0dn9tH6sRlMJLB
	jVNzFBbKPyBB/V2eMM2zbWhgnYvVTpgJsovA+XpthEtr7dc8Ixsi
X-Gm-Gg: ASbGncvlM7/zcxMi7t+RtL7gROxVSxTdsqeWsWgf4YnKOFhQrA1rCG0Wtz2lCAjUI8S
	Ge2R33hopqO9NgFN3ryEuUSu9vQzDlZStBNaUzMXAIK0hBO4vGzTPl0xFG6eOqzTYL0sID1Sjlo
	67mmY8C9Q7AWBmsDPweEb5eZYf+VfSr4IFZeosieafpecFY0we2fMw/54KS7O6SslR23kEy7wSS
	GJ1Hohu6rFZA1wI65CGzBPy7QlRIBLB4qkWHkqPpjBZKW3nTIEJKXbwaSSv9bWj7RMiDa3890ba
	dCW6bA==
X-Google-Smtp-Source: AGHT+IG33Fm+ZyGkThOkfC16QMazqsaLxNexJ9hkTK4zh70vD9SlLmtgBzspwk1FpP3/KlDXYVA1fg==
X-Received: by 2002:a5d:64a2:0:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-3862b33504dmr4201986f8f.7.1733573487595;
        Sat, 07 Dec 2024 04:11:27 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fc514fcsm7212695f8f.48.2024.12.07.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 04:11:27 -0800 (PST)
Message-ID: <67543b6f.df0a0220.3bd32.6d5d@mx.google.com>
X-Google-Original-Message-ID: <Z1Q7ay_pKE16yj-L@Ansuel-XPS.>
Date: Sat, 7 Dec 2024 13:11:23 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
 <6751f125.5d0a0220.255b79.7be0@mx.google.com>
 <20241205185037.g6cqejgad5jamj7r@skbuf>
 <675200c3.7b0a0220.236ac3.9edf@mx.google.com>
 <20241205235709.pa5shi7mh26cnjhn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205235709.pa5shi7mh26cnjhn@skbuf>

On Fri, Dec 06, 2024 at 01:57:09AM +0200, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 08:36:30PM +0100, Christian Marangi wrote:
> > > I guess the non-hack solution would be to permit MDIO buses to have
> > > #size-cells = 1, and MDIO devices to acquire a range of the address
> > > space, rather than just one address. Though take this with a grain of
> > > salt, I have a lot more to learn.
> > 
> > I remember this was an idea when PHY Package API were proposed and was
> > rejected as we wanted PHY to be single reg.
> 
> Would that effort have helped with MDIO devices, in the way it was proposed?
> Why did it die out?
> 
> > > If neither of those are options, in principle the hack with just
> > > selecting, randomly, one of the N internal PHY addresses as the central
> > > MDIO address should work equally fine regardless of whether we are
> > > talking about the DSA switch's MDIO address here, or the MFD device's
> > > MDIO address.
> > > 
> > > With MFD you still have the option of creating a fake MDIO controller
> > > child device, which has mdio-parent-bus = <&host_bus>, and redirecting
> > > all user port phy-handles to children of this bus. Since all regmap I/O
> > > of this fake MDIO bus goes to the MFD driver, you can implement there
> > > your hacks with page switching etc etc, and it should be equally
> > > safe.
> > 
> > I wonder if a node like this would be more consistent and descriptive?
> > 
> > mdio_bus: mdio-bus {
> >     #address-cells = <1>;
> >     #size-cells = <0>;
> > 
> >     ...
> > 
> >     mfd@1 {
> >             compatible = "airoha,an8855-mfd";
> >             reg = <1>;
> > 
> >             nvmem_node {
> >                     ...
> >             };
> > 
> >             switch_node {
> >                 ports {
> >                         port@0 {
> >                                 phy-handle = <&phy>;
> >                         };
> > 
> >                         port@1 {
> >                                 phy-handle = <&phy_2>;
> >                         }
> >                 };
> >             };
> > 
> >             phy: phy_node {
> > 
> >             };
> >     };
> > 
> >     phy_2: phy@2 {
> >         reg = <2>;
> >     }
> > 
> >     phy@3 {
> >         reg = <3>;
> >     }
> > 
> >     ..
> > };
> > 
> > No idea how to register that single phy in mfd... I guess a fake mdio is
> > needed anyway... What do you think of this node example? Or not worth it
> > and better have the fake MDIO with all the switch PHY in it?
> 
> Could you work with something like this? dtc seems to swallow it without
> any warnings...
> 
> mdio_bus: mdio {
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         soc@1 {
>                 compatible = "airoha,an8855";
>                 reg = <1>, <2>, <3>, <4>;
>                 reg-names = "phy0", "phy1", "phy2", "phy3";
> 
>                 nvmem {
>                         compatible = "airoha,an8855-nvmem";
>                 };
> 
>                 ethernet-switch {
>                         compatible = "airoha,an8855-switch";
> 
>                         ethernet-ports {
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> 
>                                 ethernet-port@0 {
>                                         reg = <0>;
>                                         phy-handle = <&phy0>;
>                                         phy-mode = "internal";
>                                 };
> 
>                                 ethernet-port@1 {
>                                         reg = <1>;
>                                         phy-handle = <&phy1>;
>                                         phy-mode = "internal";
>                                 };
> 
>                                 ethernet-port@2 {
>                                         reg = <2>;
>                                         phy-handle = <&phy2>;
>                                         phy-mode = "internal";
>                                 };
> 
>                                 ethernet-port@3 {
>                                         reg = <3>;
>                                         phy-handle = <&phy3>;
>                                         phy-mode = "internal";
>                                 };
>                         };
>                 };
> 
>                 mdio {
>                         compatible = "airoha,an8855-mdio";
>                         mdio-parent-bus = <&host_mdio>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         phy0: ethernet-phy@1 {
>                                 reg = <1>;
>                         };
> 
>                         phy1: ethernet-phy@2 {
>                                 reg = <2>;
>                         };
> 
>                         phy2: ethernet-phy@3 {
>                                 reg = <3>;
>                         };
> 
>                         phy3: ethernet-phy@4 {
>                                 reg = <4>;
>                         };
>                 };
>         };
> };

I finished testing and this works, I'm not using mdio-parent-bus tho as
the mdio-mux driver seems overkill for the task and problematic for PAGE
handling. (mdio-mux doesn't provide a way to give the current addr that
is being accessed)

My big concern is dt_binding_check and how Rob might take this
implementation. We recently had another case with a MFD node and Rob
found some problems in having subnode with compatible but maybe for this
particular complex case it will be O.K.

Still have to check if it's ok to have multiple reg in the mfd root node
(for mdio schema)

-- 
	Ansuel

