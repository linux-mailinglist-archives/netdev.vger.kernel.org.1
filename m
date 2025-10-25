Return-Path: <netdev+bounces-232911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB6C09E7D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED8974E159E
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DC3016E1;
	Sat, 25 Oct 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvI63dUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5B2F60A7
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417868; cv=none; b=lbb4oLw5Ac+HaQV0Pn7T+4aM3nO4ZFTCB6rsP8NoMmGr5CZoU6fTYyDQ8yqfMXI5yp4k0opGXESbuzjIoDXLxLzcWwcTamM/52OmoRP1OF8qaxQyXEAXP+4j+TS0w+/2gAL06+zi8GeLQyW3N9eTgutzudixxnM6LzbVcSy593w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417868; c=relaxed/simple;
	bh=/cyEYA10fgQiu09txk5WwdgqTqeNROD+BVF14d0FISM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D7asSWakTk2hLKVNw3rzUemhqgrkduXz3DtjIAL9q4kKg0eNZ5Iu9OD91HKFRjFI61Asdm6Psj2CF/l3JBq8ud60FT3nqShSAjCCFHbKg9U0RpNQX4kJXTabwCBhwNjXftNEPv4VxDxjR3qskcdxggydZUNl33/7MdfmBErQ2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvI63dUE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471131d6121so23915685e9.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761417865; x=1762022665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dbr82cKNa64aNKIuLx8KwwTVN7eSIBuccWOqj3I0+EI=;
        b=OvI63dUEbkXkRuBfAuzIJiQH5ZwC/wUMJ1a67tryvXIS6Toqou19n9ntTpqgBdDYFd
         /mfd/SBADqs2trvaD4RE5BWPNS5yGpalHiWVwOSdgK4YnXNYBXGeLpV+FedkkNgex3Y2
         cYiRzS8DXSogo+hFr65U7eMIn/sq6yOsrYJW1Yu2Z+iYZleRXhIptxPgUCY5xxbQLqIc
         s9QvAp7fYwLeaWrEhSbbLWcdh6KtrVs+kjKezWLIotd0K5P2cFPnH7X7IOPka8iaQfnX
         le75GduhBgEAopajtmGjBlvNSW7H5H/TrVnW1hkz/voKX5LZ2TEsBHAVXBWpIlyTguHw
         YM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761417865; x=1762022665;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbr82cKNa64aNKIuLx8KwwTVN7eSIBuccWOqj3I0+EI=;
        b=GaDeVb4lSba6Nab289BnL8QTai6TCQzPTsmA79kW4Cwo/7nY44Dxa3iPN0G6rRZ4e2
         BJ6mcCaROOEvM/Etp3KUSGRXCWvoTm/cceZITx0e0dObwrIDHYnS+efIQZSigLQXY+XL
         +nM7ZAPDrpZxu0XsFeY2O4m1mnPgzeSFeYLVQ2K4GE6F/Ceh1M1ApZM/j/ktkTM4tcqI
         u2+JFKo7lxHfavbAqWhmmFUvQvHrEVtdxMJ7Tc25RpKpQJNIodQtkF6XrxksJa/kI4HX
         hPwZArdU7GaUyUwQEg3dSnDpmp93owstc15LiQL6gcWy79aESIHIZn17yG7I36a6DSK7
         HWkQ==
X-Gm-Message-State: AOJu0Yx8d1e93EhuCl3NT5cS0wlr2bMzHZ/IAhhoDjnqecAWJSkbk9Xb
	mBMJVgzroCpFKRX00eW3q9VM75s+vPR6O/yJCliq7tc9j3d8EjoCgDy7
X-Gm-Gg: ASbGnctfo9r1Qt/iekDjLu1O27Sv4CFJC7kZ/o13gY3TwcmovIxRkmr8Vb+6dtobpCx
	/5COudgaDpInFTUdPGjs2kxk1b4TAl0+O4CaqZWatAIDY8FQWMI3M2i1wNLti1Jg6i1WgieCaZE
	V4VXH0vX/V0p8IQwP/eli87OLJvIiNVvlhJl07me0ZSyAZD5mz81qEJKBQ2OWXNzQXuStwuFOSn
	DldQkhD022+/uslG3QEwk1pxd4PbVTnJvrHhGpcjL5gLKDvp5xe0iVNFcy/Za4md326EaZOBDuh
	BRDgYQi6stN0drwdxHNSuA3GqCdkMZG3FG2o4/xCSDUWcVgcVyMDHIsut2pbwUKoqK89GGcLDtA
	nyWfEfCJQm7aO0Peo0U+DwqULi1x3l6oeXBD+Fhi4EcHz+16SqfnDI6S35lMI9J5LAxUruEzlf0
	nION+cT4TnEX71R4oa9RbKMZjStZI9wT9KawxpYnuX+OaFWkQNMmuAXoUAC4++vg3lBr5pl74Lh
	LAe2si1XAFdJoVJp2UH/DkUjsLtwJqp2wX3lkIILwopP7d5gh4+eA==
X-Google-Smtp-Source: AGHT+IHS0sY82htnysm/29xctr3oax86b635hIkQzKNsnmch9I765g0cmtTSLQtEcDTk6L02Kt82IQ==
X-Received: by 2002:a05:600c:8286:b0:477:bb0:5e0e with SMTP id 5b1f17b1804b1-4770bb05ee9mr3158685e9.20.1761417864696;
        Sat, 25 Oct 2025 11:44:24 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db9c6sm5079902f8f.36.2025.10.25.11.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:44:23 -0700 (PDT)
Message-ID: <d56e15cd-900f-4cf6-86c1-2e8000d66f3c@gmail.com>
Date: Sat, 25 Oct 2025 20:44:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 0/4] net: phy: add iterator
 mdiobus_for_each_phy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, imx@lists.linux.dev,
 linux-omap@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
References: <9c6aeec5-f651-4cf0-8cca-d2455048e89e@gmail.com>
Content-Language: en-US
In-Reply-To: <9c6aeec5-f651-4cf0-8cca-d2455048e89e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/2025 10:20 PM, Heiner Kallweit wrote:
> Add and use an iterator for all PHY's on a MII bus, and phy_find_next()
> as a prerequisite.
> 
> v2:
> - rename iterator to mdiobus_for_each_phy
> 
> Heiner Kallweit (4):
>   net: phy: add iterator mdiobus_for_each_phy
>   net: fec: use new iterator mdiobus_for_each_phy
>   net: davinci_mdio: use new iterator mdiobus_for_each_phy
>   net: phy: use new iterator mdiobus_for_each_phy in
>     mdiobus_prevent_c45_scan
> 
>  drivers/net/ethernet/freescale/fec_main.c |  8 ++------
>  drivers/net/ethernet/ti/davinci_mdio.c    | 14 +++++---------
>  drivers/net/phy/mdio_bus_provider.c       | 13 ++++---------
>  drivers/net/phy/phy_device.c              | 14 +++++++-------
>  include/linux/phy.h                       | 11 ++++++++++-
>  5 files changed, 28 insertions(+), 32 deletions(-)
> 
Because of the needed v3:

--
pw-bot: cr

