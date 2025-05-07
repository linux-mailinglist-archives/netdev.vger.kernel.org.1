Return-Path: <netdev+bounces-188681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F27AAE2E4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635CC1C45E3D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215A21858E;
	Wed,  7 May 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9wOBmEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C486199939
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627690; cv=none; b=EgKu0NTtR6vRK5WSR31QIbTxi4SxTm11RaKfbD/YNgJgZQEv7eKamvtFVM6v6tkJyJQ9l0IYMISviUQkAJ1BxMMoYK4ZCOROXL+ieHuA42kjROJmYtzGVcIx2zqV5XpJs3X7XtGfoypGFRSjp8UxysBDJmEre9eQkHvHRNOEmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627690; c=relaxed/simple;
	bh=FW7uWQCbO106I2NUSCrF51lvclKMjZVzm1aRlTAqh9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li3qPB4DBIqKAqNZicv6bLgTHvyoOIVpDL9q8HYsgPyX5FyR7N1LBo4ObYa9hdY8aHjInwww3iewtNeNjFZuJhA145mrreBKqUg5rt1X78MT80pfoOq8+SVA8gK/2BuPKamWprJs3aU5jMT2AkVjXVMcsGe5q+MGOp1ZxSjIigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9wOBmEo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso4664907f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746627687; x=1747232487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F9r7HYQ1VVauM+wAZIECRIXFmgcBteZYHP/JoWwzPPQ=;
        b=j9wOBmEoGxSCLVaxewPT9gLw9Ug2bvmyV/10FHYJ7Wpq6TMofooGvda15SX9vLmLlJ
         DVay1PyVBcL6yKBGkL7ozshBKVxe1sGUpnhUyRxmguJjxpCZqcA1WTliGidrTRjFtMFa
         HIug8mK3YK8/o1mpcIX48YvGVG9fg1zXlr9vtB+NbKOp6KpXy7hbyC3MIl2mMq+VOWnK
         o6hgsfPpzpYpAtBBXHfIeOqoGG0ze7pOfUp9Rm5vM93z4wS7u624DBvGuaXZJlFt1nHd
         mBoN1Eo4p2i//NY4yFGFJueP/qVZ6nDwDp4s0NUJTkS7PdK+FANvL2+JzaU+kbvejY12
         i2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627687; x=1747232487;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9r7HYQ1VVauM+wAZIECRIXFmgcBteZYHP/JoWwzPPQ=;
        b=bA/kHoAP13OPaV91do2whvxEAqWQH3FuZpRzyVxSzDOQZB6yerkBpIhxdQSo7Qj/Hg
         eJZwZY6m2XP7II0/tr2H6gMz/kToZszVhV9b5zsXv23Ch40KOtb9nQlvXRBYIw3eP8Fh
         7N+k7MMMYnPma6TS2M6Zf6DwRD+rXlzi63mEShA7gJTAPLbU5KiV+7jnoBy+caZJbjPD
         8KBLyDtJoOY4kyokJ0MWzonWYADwDoj3nqjD4Arp7hI/AkQkdIr1C7ymIce04jLpiKjY
         mMbxE4avS13rGRDRa5xvOdAeew9R2bqKizVxfhSWGRGa09t28zcWblOZlRXoHO6p9fOP
         7uEw==
X-Forwarded-Encrypted: i=1; AJvYcCUUkGGsAWPQFcgsQvgm+S3DAZds8O5Ju9qfmTi29Ik/5CuiMw2MSILpUJ4LodMpiDaRXcwhk28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvjR4SqDlfmnbgcisMvVSp6jkkKrjXG2PcogcDbh2r8Ez349Z
	SpbqJzDwjPFt9vsaX9W7aM5dxb2gU/WGWmmT3sLd5JrB6m2PItPm
X-Gm-Gg: ASbGncvC0mdY+l5HE5kp3rznpJsCKmN51Ne8/Nw6zOwgcv5aAGdgEQ+2AGMBwE6DC6j
	RvRzQx42zOw1S0F1SXjQAa/nhKTJvE6VD9p/vvFtOA95qQcHVyHVcaFaLq1JeQXi1yraW1tPnpG
	NBmSL2aYJ2ZjAWL3GQVW0XoXN08w7L8vTN1lK8FR5R6ntAV1yt5q/Dn+oDyRYH/Onnjdsxc0CUu
	hXCaQrn8vXRaqE+9gcii0UMC6w+c/TlHv9ELccGiEchGRTVPMUeOI5XLcwmV2lyjZaYC5ujj5hm
	BJv+/LP4h/+Z4iHOQ9ajtQdCTY4/8KMloshE/qUqU3Y/ChE7aljjHRT0GHwloiKRgi/Q148va9O
	QcTBzkwDd6cNwEluRM7zNckcIy2gbZoVM97ccJhM5uyzQsc5Nka+cdizodeGymDnDyeLAgGbTpM
	5S2TNW
X-Google-Smtp-Source: AGHT+IGrGUtLi/GxaoIqVKTervWou+9CXQerMNFx8ciR5b+xlrtmmJZSfNfDvpFV5hZgqauAIg6Q1Q==
X-Received: by 2002:a5d:64cf:0:b0:3a0:b455:a1fd with SMTP id ffacd0b85a97d-3a0b4a1c6f0mr2979411f8f.32.1746627686507;
        Wed, 07 May 2025 07:21:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2d:8d00:5478:a4b7:c64c:2aa7? (p200300ea8f2d8d005478a4b7c64c2aa7.dip0.t-ipconnect.de. [2003:ea:8f2d:8d00:5478:a4b7:c64c:2aa7])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442cd34bde2sm2564465e9.19.2025.05.07.07.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:21:26 -0700 (PDT)
Message-ID: <fbe1e3e7-cd44-4e13-8cae-9b128d896a0e@gmail.com>
Date: Wed, 7 May 2025 16:21:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, imx@lists.linux.dev
References: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
 <aBs58BUtVAHeMPip@shell.armlinux.org.uk>
 <5ecf2ece-683b-4c7b-a648-aca82d5843ed@lunn.ch>
 <aBtYdq2NurrTIcJi@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <aBtYdq2NurrTIcJi@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.05.2025 14:56, Russell King (Oracle) wrote:
> On Wed, May 07, 2025 at 02:49:05PM +0200, Andrew Lunn wrote:
>> On Wed, May 07, 2025 at 11:46:08AM +0100, Russell King (Oracle) wrote:
>>> On Wed, May 07, 2025 at 08:17:17AM +0200, Heiner Kallweit wrote:
>>>> MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
>>>> select MDIO_DEVRES. So we can remove this symbol.
>>>
>>> Does it make sense for mdio_devres to be a separate module from libphy?
>>
>> I _think_ Broadcom have one MDIO bus master which is not used for
>> PHYs/Switches but regulators or GPIOs or something. In theory, you
>> could build a kernel without networking, but still use those
>> regulators or GPIOs. But given that Broadcom SoCs are all about
>> networking, it does seem like a very unlikely situation.
> 
> I'm pointing out that:
> 
> libphy-y                        := phy.o phy-c45.o phy-core.o phy_device.o \
>                                    linkmode.o phy_link_topology.o \
>                                    phy_package.o phy_caps.o mdio_bus_provider.o
> 
> mdio_bus_provider.o provides at least some of the functions used by
> mdio_devres.
> 
> obj-$(CONFIG_PHYLIB)            += mdio_devres.o
> obj-$(CONFIG_PHYLIB)            += libphy.o
> 
> So, when PHYLIB=m, we end up with mdio_devres and libphy as two separate
> loadable modules. I'm questioning whether this makes any sense, or
> whether making mdio_devres part of libphy would be more sensible.
> 
I was asking myself the same question. If mdio_devres is a separate module,
then it won't be loaded if no active phylib user requires the devres
functionality, saving a little bit of memory. However mdio_devres is quite
small and we don't gain much.

For now I decided to keep the current behavior of mdio_devres being a
separate module. However if consensus is that we better make it part of
phylib, fine with me.


> Maybe the only case is if mdio_devres adds dependencies we don't want
> libphy to have, but I think that needs to be spelt out in the commit.
> 
> 


