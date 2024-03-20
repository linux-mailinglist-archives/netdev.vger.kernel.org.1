Return-Path: <netdev+bounces-80853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E79881523
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED541F22B5A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866153E1B;
	Wed, 20 Mar 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i4dFCifV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFC52F65
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950638; cv=none; b=AQmxzzIyeVNEGgHSfmJAKIAI5OAIQPIN0obcwnXLGM+k7uy/SYnSJS4uehp716gwpoW/iaFK4lWiIqHUoTi03bl/7PJZz5yFyWpe7Iqe5xld/DiDrVUJjInN3q25ZYkV/gFEnAIqe1QbyFPSrUG8VRIbaMBhpXRe9H0mZAudDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950638; c=relaxed/simple;
	bh=BRq0vD38Q8/NqcZsoLjZKmB/M4TbYXvbHK9ZHfQGKzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1UaucHI8zToZMhcapKsv9MTxAd3N4EfNzWttI3nYzFwZkAhFCJK5lo+IIt0OCShumBn5VOL0kUVj7JPa+j1SUHcAmXhUbZe66SdDlLEWC6yrhCGr6pUs4BaQyQNuppAY5Hz9doevKnvZr4OwcMfFRxwFMMgAJN4z/Cg/5y3t64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i4dFCifV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41467d697a2so12217425e9.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710950634; x=1711555434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bY7A1wk7zs5QU73cPdyC/1c/eIVosZrGHL12QRvkwE=;
        b=i4dFCifVTQ+W2fDA/oqHJh9rjpkN3iP1PIbJYPsqyIrs0zw3+t1N69IhR7+tzHxNWK
         6FMUhuicwpSYUzLxx1kmvBvpaWiLgs6IeL80z/qcj+kWzzTitoE4v9p1ZaBoyhSu8oNM
         Sl3E2Bg+eIJbsKoq54O5XJqRZxJ72yEQmIWBp2OnrmIRgyNe0YrA8qZVRvD/JF9Ldu+w
         UdOflBQHs7oE+osUAfps4TzI97vrZ0D3g2j+1pWc2kmvZqjWcephyBp8tg5ATZ8u970X
         bsJJZNFFZdqG4Qiy9brEuyxJqIaBteOSRpCZk6PdHoeaSEpbrSz0spVCvBCgyQRHQxWL
         ZtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950634; x=1711555434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bY7A1wk7zs5QU73cPdyC/1c/eIVosZrGHL12QRvkwE=;
        b=pNNt1DWSmC784CAr8Ll9O5iDmIH5YQ5uZiQoFrl1vV4vZPUkoSCBusAYQyVuZytbMV
         AkufCNbUtv/QVqqHBSJHS4AR/+sIcaahhQ6HtoEESFFcRe3s/KeBnu0ImCr9G2euuR2O
         28+JcWqJB3/A929Ob9idRxodMsstBTg0hCYvIgGLUy16UlgaRo3Ls0n5YG3/aHzwIxtK
         sWwYZvW8z+q8ON7cZ+dVKAzBdQ5V3+xn6oxqlM1N6RiornO/tuOhdRpn/9BYDuJshxKl
         StTmpYyXUHQjV3iuPtDZypjmlBY4U3ekLV6Qr2fmdkrLvLdV0w4WOf9zxkRaOv+ZQ9ok
         L0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBc+FTIn2bml7UruCnyGuH1+fFmCeajc0XvHbuPgQuFcVAewDtFFrn9Tf5ofgLsNsiA+iIxNrnRmH/++4CLeogOtYUbW3Q
X-Gm-Message-State: AOJu0Yxsqkc97n5roQd+ly3dYaRnhKswZOar5GEb3w82+GP7p65Z5p5c
	sk+rcTAeSsGo+usC+hVHy7P/LhwKo3u2dGWHqCHHRdbW9EkSZsm8XKe/dnnYlzk=
X-Google-Smtp-Source: AGHT+IHVLCW9hEgC4AANx8BDyvyzUp/cFivCz3and6RGVbJjntidh2kLf/mQ/yH/roDT762MISxzxw==
X-Received: by 2002:a05:600c:5494:b0:414:6909:f65f with SMTP id iv20-20020a05600c549400b004146909f65fmr2940495wmb.6.1710950633810;
        Wed, 20 Mar 2024 09:03:53 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b004146bce65f4sm2551509wmb.13.2024.03.20.09.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:03:53 -0700 (PDT)
Date: Wed, 20 Mar 2024 17:03:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Message-ID: <ZfsI57371KtaRV4a@nanopsycho>
References: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>

Wed, Mar 20, 2024 at 03:33:24PM CET, josua@solid-run.com wrote:
>Am 20.03.24 um 15:09 schrieb Jiri Pirko:
>> Wed, Mar 20, 2024 at 02:48:55PM CET, josua@solid-run.com wrote:
>>> mv88e6xxx supports multiple mdio buses as children, e.g. to model both
>>> internal and external phys. If the child buses mdio ids are truncated,
>>> they might collide which each other leading to an obscure error from
>>> kobject_add.
>>>
>>> The maximum length of bus id is currently defined as 61
>>> (MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
>>> names and multiple levels before the parent bus on whiich the dsa switch
>> s/whiich/which/
>>
>>
>>> sits such as on CN9130 [1].
>>>
>>> Test whether the return value of snprintf exceeds the maximum bus id
>>> length and print a warning.
>>>
>>> [1]
>>> [    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
>>> [    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>>> [    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>>> [    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
>>> [    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
>>> [    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
>>> [    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
>>> [    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
>>> [    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22
>>>
>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> This is not bug fix, assume you target net-next. Please:
>> 1) Next time, indicate that in the patch subject like this:
>>    [patch net-next] xxx
>> 2) net-next is currently closed, repost next week.
>Correct, thanks - will do.
>Just for future reference for those occasional contributors -
>is there such a thing as an lkml calendar?
>>
>>> ---
>>> drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>>> index 614cabb5c1b0..1c40f7631ab1 100644
>>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>>> @@ -3731,10 +3731,12 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
>>>
>>> 	if (np) {
>>> 		bus->name = np->full_name;
>>> -		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
>>> +		if (snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np) >= MII_BUS_ID_SIZE)
>>> +			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
>> How about instead of warn&fail fallback to some different name in this
>> case?
>Duplicate could be avoided by truncating from the start,
>however I don't know if that is a good idea.
>It affects naming of paths in sysfs, and the root cause is
>difficult to spot.
>>> 	} else {
>>> 		bus->name = "mv88e6xxx SMI";
>>> -		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
>>> +		if (snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++) >= MII_BUS_ID_SIZE)
>> How exactly this may happen?
>It can happen on switch nodes at deep levels in the device-tree,

Read again, my question is about the else branch.


>while describing both internal and external mdio buses of a switch.
>E.g. Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
>
>On CN9130 platform device-tree looks like this:
>
>/ {
>    cp0 {
>        config-space@f2000000 {
>            mdio@12a200 {
>                ethernet-switch@4 {
>                    mdio { ... };
>                    mdio-external { ... };
>                };
>            };
>        };
>    };
>};
>
>For mdio-external child all the names alone, without separators,
>make up 66 characters, exceeding: MII_BUS_ID_SIZE:
>cp0config-space@f2000000mdio@12a200ethernet-switch@4mdio-external
>
>With separators ('!') we have:
>cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio
>cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external
>Truncated to MII_BUS_ID_SIZE:
>cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi
>cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi
>They become duplicates.
>
>>> +			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
>Another option (imo) is to force the issue and return error code.
>Then the only way out would be increase of MII_BUS_ID_SIZE.
>>> 	}
>>>
>>> 	bus->read = mv88e6xxx_mdio_read;
>>>
>>> ---
>>> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
>>> change-id: 20240320-mv88e6xxx-truncate-busid-34a1d2769bbf
>>>
>>> Sincerely,
>>> -- 
>>> Josua Mayer <josua@solid-run.com>
>>>
>>>

