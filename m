Return-Path: <netdev+bounces-54058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E3A805D12
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B111C21074
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D468B68;
	Tue,  5 Dec 2023 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6kdlGbl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EE18C
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:17:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a195e0145acso703252966b.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 10:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701800260; x=1702405060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fewWLcIG0ZbYaP75VK2ZCA6k50W0RhRcTOzApdHeR84=;
        b=i6kdlGblT6OHj+HDn2Bs+6oDzuAOoTmVtsgSr97/t1ShGnt8SZmxTTk59dyp1bDaLD
         M/+DAfh3hhrf9+pgZu1uZy0NO94bRi0J6JNe5vUIljexiiqJcbFJd6VEYxuktaITM1hg
         bc5zoaVWZJVrB4gQtmFlRvBT8M+TBz4owLrZhA/b+puxo+BioyHf3KkmlKfpxuPcNy9N
         muCSuNZW/i3aLxVAva8m9kvQhMPGTmuYPa3PqGPeJimkb1G9KTFWZq4Xr/rksIm+Iztt
         z18HltKe2YDURebXL50eyqxprBs6GRMR6CT7eaiwohI5iFTrD78ImhTOqW9vUqrMTA+m
         gh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800260; x=1702405060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fewWLcIG0ZbYaP75VK2ZCA6k50W0RhRcTOzApdHeR84=;
        b=epkDAAIxMckpzGGeDPraHuj3u2GKj5l4Eot6fx/19eydc8QsdEpAu7Kosyp+H3VLzd
         52eBaK4NlzIBmbEpk4IxDp6L+1kgPL6h64qw6E+A7Ul5JufBIuNdTvo096YX9Vj+78xl
         6ftNu4R/6rCTxA4NfMc2wt2fggsxcEs7BbuWIjyyqq4/M+gNAGHRwvcMKv+Q41oiDHEJ
         Yuq+NDoMC2WzW04Fn0RDNVzHk1VbeLCkLwW/MlWlPLoOL1lnY1OGB3gn9mGL5sn5+bQB
         BbgR0gv87loOZDG0KMMU/mI2CO/iY/zxUbuhcg4zgjr0LW2hG2DPSdYpVBweD5HKNW14
         dGhw==
X-Gm-Message-State: AOJu0YztAL446/jGFJbePELshajcHssbh90LEiVp0+iNkufiQ4wfipYk
	CTSIsL6uc5C27Y0AznvA33gpknux/IUZmKBU
X-Google-Smtp-Source: AGHT+IE9ACfLUdZZr0SqPTAGk5tBYsCMt3eTePOggfnm5ymUMWn1G0nSXpbnQnHlak+otMwa+pZo8w==
X-Received: by 2002:a17:906:207:b0:a0f:cc19:e579 with SMTP id 7-20020a170906020700b00a0fcc19e579mr579842ejd.1.1701800259602;
        Tue, 05 Dec 2023 10:17:39 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b00a1d11501718sm466840ejl.126.2023.12.05.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:17:38 -0800 (PST)
Date: Tue, 5 Dec 2023 20:17:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205181735.csbtkcy3g256kwxl@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <20231205165540.jnmzuh4pb5xayode@skbuf>
 <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>

On Tue, Dec 05, 2023 at 06:33:18PM +0100, Daniel Danzberger wrote:
> On Tue, 2023-12-05 at 18:55 +0200, Vladimir Oltean wrote:
> > On Tue, Dec 05, 2023 at 09:00:39AM +0100, Daniel Danzberger wrote:
> > > > Is this all that's necessary for instantiating the ksz driver through
> > > > ds->dev->platform_data? I suppose not, so can you post it all, please?
> > > Yes, that NULL pointer was the only issue I encountered.
> > 
> > I was just thinking, the KSZ9477 has internal PHYs on ports 0-4, and an
> > internal MDIO bus registered in ksz_mdio_register(). The bus registration
> > won't work without OF, since it returns early when not finding
> > of_get_child_by_name(dev->dev->of_node, "mdio").
> Interesting, I did not notice that.
> After the NULL pointer issue was fixed the switch just worked.
> > 
> > Don't you need the internal PHY ports to work?
> For now the switch seems to run just fine, with port 0 being the CPU port and 1-4 being used as
> regular switch ports.
> I will do some more testing this week however...

What does "regular switch ports" mean? L2 forwarding between them?
Could you give us an "ip addr" output?

> 
> And probably checkout some DTS files that use that switch to see what other options I might need
> when going the platform_data path.

The platform_data code path has reduced functionality, at some point you
will get some pushback to help kickstart the software node conversion.

