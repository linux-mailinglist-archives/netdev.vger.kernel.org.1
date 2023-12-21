Return-Path: <netdev+bounces-59665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441AF81BA7B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F336C287A31
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671853A00;
	Thu, 21 Dec 2023 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo8tzaxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B652539F6
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5542ac8b982so642091a12.3
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 07:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703172098; x=1703776898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIV7OpE5vlpQJDAlqfBZxGDcITKCVdruImRYaoEJi+c=;
        b=Zo8tzaxuP0prh9x5gpuumHMf/FtOhp6XCi+X3RwTCHU4V+mH9ROYC3X2MpquuWxk2z
         OPgvXdpWgwhaVIxE3m1MpBUWZINOYA4RsdU6NDvOX+ieF7TB9Mj4fsp0qkOPpxg3T9/z
         dGcMmrGKQrOArNxuKMBlPfttuUw/y+0wAcTXUwnjZ90l0IKz7mup+tkNmyEE6hJWv1FK
         r8GZfiEdgDDhmJK9r030iLMbE6YcbRY9Ecz+TsOdno4O8Nu0yGsMNokHx42vANtZ/Tjz
         +uVdn/dMysICGFdv6tkSAnEMh+er4tSu/yX7TayoSOdXD0r5Fy9ww5Qfqv5n8a/MLmNB
         +SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172098; x=1703776898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIV7OpE5vlpQJDAlqfBZxGDcITKCVdruImRYaoEJi+c=;
        b=dR/zm+FCXpgk9hPrH9JYK8o+G/lOU0vBRodqnaNY4HPhQ8/+6nnP6BGkKCTFcnUTQB
         5B43RSP4Dsj7ODwn7mYEuv88TEMR807HDl//F6ejL3W7BCVbAdGFFzMtATogafDyj1yV
         aY3lIe9E/rfwLuZwOMCkvhI6BSwsq02Xp0hLCgYs/1S222Yki9izTqprVpb2JX4F/5ky
         S7/2QQT7DjKKfWnjkt7jXXrm+QiT1lHsvr53W51oWGGZeWdSDEJWBTjRE0KFw/ANd+v9
         ihr6FF0ef0zaM/VgZOvjOSFoaMsEU+L4ufaLLr7fqtyPXaJLba4QvfH11tb3h4D/VZtX
         +RzQ==
X-Gm-Message-State: AOJu0YwxRNQU/0OMZdCAr5h56nSyXD+nluSG296IKwaWwM98nvpM5aJN
	hd8QZYA12BT76BLtSo1W1B4=
X-Google-Smtp-Source: AGHT+IGksvPr935i8JJfGXGKV2vNTE8BH3POtfbbMSxM8bteud58jV8vSyXi2GR8QvtY1c+yyxWzKw==
X-Received: by 2002:a05:6402:2152:b0:54d:412:c8f4 with SMTP id bq18-20020a056402215200b0054d0412c8f4mr9807081edb.84.1703172097634;
        Thu, 21 Dec 2023 07:21:37 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id p20-20020aa7cc94000000b00553b746e17esm1293898edt.83.2023.12.21.07.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:21:36 -0800 (PST)
Date: Thu, 21 Dec 2023 17:21:33 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 0/7] net: dsa: realtek: variants to drivers,
 interfaces to a common module
Message-ID: <20231221152133.a53rlyiha7kqyk5q@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>

On Wed, Dec 20, 2023 at 01:24:23AM -0300, Luiz Angelo Daros de Luca wrote:
> The current driver consists of two interface modules (SMI and MDIO) and two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO modules serve as the platform and MDIO drivers, respectively, calling functions from the variant modules. In this setup, one interface module can be loaded independently of the other, but both variants must be loaded (if not disabled at build time) for any type of interface. This approach doesn't scale well, especially with the addition of more switch variants (e.g., RTL8366B), leading to loaded but unused modules. Additionally, this also seems to be upside down, as the specific driver code normally depends on the more generic functions and not the other way around.
> 
> The series begins by removing an unused function pointer at realtek_ops->cleanup.
> 
> Each variant module was converted into real drivers, serving as both a platform driver (for switches connected using the SMI interface) and an MDIO driver (for MDIO-connected switches). The relationship between the variant and interface modules is reversed, with the variant module now calling both interface functions (if not disabled at build time). While in most devices only one interface is likely used, the interface code is significantly smaller than a variant module, consuming fewer resources than the previous code. With variant modules now functioning as real drivers, compatible strings are published only in a single variant module, preventing conflicts.
> 
> The patch series introduces a new common module for functions shared by both variants. This module also absorbs the two previous interface modules, as they would always be loaded anyway.
> 
> The series relocates the user MII driver from realtek-smi to common. It is now used by MDIO-connected switches instead of the generic DSA driver. There's a change in how this driver locates the MDIO node. It now searches for either a child named "mdio" (compatible with realtek-mdio and binding docs) or a child with the compatible string (compatible with realtek-smi).
> 
> The dsa_switch in realtek_priv->ds is now embedded in the struct. It is always in use and avoids dynamic memory allocation.
> 
> Testing has been performed with an RTL8367S (rtl8365mb) using MDIO interface and an RTL8366RB (rtl8366) with SMI interface.

Could you please do word wrapping at around 80 characters per line,
so that the cover letter doesn't look horrible when used as the message
for the merge commit? Thanks.

