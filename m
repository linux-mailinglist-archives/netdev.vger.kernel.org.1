Return-Path: <netdev+bounces-54633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FBC807AC2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F6F1F21367
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118347099A;
	Wed,  6 Dec 2023 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLraeujU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE798
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:49:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so26975666b.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701899371; x=1702504171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icAGLF6y2iN4/TdWwfUe2dws+wW8NTNLWr5XhF/ldFE=;
        b=CLraeujUu0wwa/Bki1h+hz5fZPrICqG26MQqEP+bswuJCxoXyAGiyp4D5tD8m6f0lz
         dvkHdbuloh79undSVpcxwUTsz73racAOW1dAz0B5ScR4quLC+Q8WuV08R4ERBk09OhI+
         tGffUweWLQ+bfY3pI32Tqe58s/Bpdso1rrmb2/umUiZkZ8rOycbAqlnsOux8y5tSmfgZ
         4/Owq+Nfmmid9pGyOEvp/lrMbFuGpsO3XzP6UMsXMd2aiLf51gAb6d8P+BxKStW1Wt0e
         fLHH6MOqvd0IFtUYwRkkcslMnjdrmGrqT5BAVS1dZxB/CO8/2tRY9h3rB0ksXPLreUZ1
         EUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899371; x=1702504171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icAGLF6y2iN4/TdWwfUe2dws+wW8NTNLWr5XhF/ldFE=;
        b=OJliRI4N2sqViK6mjDcYwxLr/YWAn9L1nx5+7r4xMcbi+up8k8x1ANsRZYfuiPuShI
         e/vH6n+yezMi785uFBECiim5wY+nBw2BZgaoEs+hAcusOsBRNSdDOH1wAlN/OdPyv3XC
         BLsC/hslCkcNCqa5l4EheJ2KFpW+kW+21qTX6h9Ai4veUEY/7UHzZWelKqA/hX0eeA1H
         C3dmhHItyev40b3wWLCy5k1m36gaZIsZwuulsiJ2X4BXpHTmKA59uuVt0XwuJ/RGNimK
         Eikodl+jUPcGuszwC+DpKtF1FqVINJnvn7BCifbBf4SOaB1i69BCC1nOBDuS5iF3SSFm
         QEOQ==
X-Gm-Message-State: AOJu0Yz+3Jb+gOujmeIlb5BTZ62ahur/wMiKMrYjDa8q4PRHW+sTr2q7
	TFxBGtlT9ibUDPVPKwdv6yA=
X-Google-Smtp-Source: AGHT+IGDaFPTkPlj/iWkSiYl0O5nuuiTgw+X2KiLlTazF2TrYRRsZ2ZffroYHKvzPE0DUxTfRP+T4A==
X-Received: by 2002:a17:906:715:b0:a1c:2eb:3839 with SMTP id y21-20020a170906071500b00a1c02eb3839mr935652ejb.67.1701899370600;
        Wed, 06 Dec 2023 13:49:30 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id b9-20020a170906194900b00a1cbb055575sm435426eje.180.2023.12.06.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:49:30 -0800 (PST)
Date: Wed, 6 Dec 2023 23:49:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Danzberger <dd@embedd.com>, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231206214928.jhx6naeo2o2eonj5@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <20231205165540.jnmzuh4pb5xayode@skbuf>
 <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>
 <20231205181735.csbtkcy3g256kwxl@skbuf>
 <52f88c8bf0897f1b97360fd4f94bdfe2e18f6cc0.camel@embedd.com>
 <20231206003706.w3azftqx7nopn4go@skbuf>
 <19d4d689-a73e-4301-b22c-5ad2dfb4410d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d4d689-a73e-4301-b22c-5ad2dfb4410d@lunn.ch>

On Wed, Dec 06, 2023 at 04:26:52PM +0100, Andrew Lunn wrote:
> > So, surprisingly, there is enough redundancy between DSA mechanisms that
> > platform_data kinda works.
> 
> I have x86 platforms using mv88e6xxx with platform data. Simple
> systems do work, the platforms i have only make use of the internal
> PHYs. This is partially because of history. DSA is older than the
> adoption of DT. The mv88e6xxx driver and DSA used to be purely
> platform data driven, and we have not yet broken that.
> 
> 	Andrew

I'm not saying that platform_data did not have its time and place, but
Device Tree clearly won, and platform_data is a rarely untested minority
nowadays.

We don't have to break platform_data in mv88e6xxx and in the DSA core
all of a sudden. It can coexist with software nodes for a while, as
alternative solutions to the same problem.

