Return-Path: <netdev+bounces-159259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C79A14F18
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940C518890AB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86801FECBC;
	Fri, 17 Jan 2025 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nsn5Vlz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650521FE45A
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116365; cv=none; b=XvVfpp7nDFvLVsxbHawKLprH6M4EGMyJ3O9cWK8xHOGpsjYK2uovJJe0iAeBkBX1sYnS1vsfFVCeDYJTalPVIIpPXPD5ekItNfP52MNRA4m6vCo0aAyMJwJVBSzi5N8VVVOifI/aOrnPYh1VvIqGNdZsdUagDrCUlYUtjANNors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116365; c=relaxed/simple;
	bh=Ov6RyDvlBV40EYwFXuzQXiVzA/WzwQtDr93JFljbJYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKET/MAeeMI8c5O5Fvlz88EgTDHKIXbIIYct3becZ+TbZkZsCu3yXfcJY2/6Qux5SscA67E6ZKLgjZ3778+RELKnpkANZC9+R7aYxfFoW9hl5/j7+AI4d/wBeufpLXQaH/vuR2NqsHPm4us419QSe6qCtf8WmPRVu06VTiLuD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nsn5Vlz+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385dece873cso1115206f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737116362; x=1737721162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6R97ZJ/eTJmxy+gIbZqfH/ad7ajv9h0FEj5S8dEJik=;
        b=nsn5Vlz+gfyiYtcyqHbAxRfNyBigN+mCvFt7XMzV805Pnw4a4KH7j18wz572eTjy3O
         gSK5eYYmTTzQF1o0lRMpx051Ffjw0Cf/ykh8T41yMEdSH8THvyp7f61WF4eGYYtEKc60
         Maw8/qJM+KEPOAmW2sI3Nb0ydyTvwZFBkwYCA+5MNox4/axmfRPEVjY9EBcl2bxyJMO1
         YBGWSvTa/iU2oFhUijxjr8FRISqdHxqvFzYD5mti0XQVXZC78/IbgjzcqaD3oBdOAMcc
         jBcLqjoALYDOZGJxhfo9u/Dm3CQtJ1MVatsJJN5/P2DZtmSc4TTRrbrafPGeCulIpihU
         /EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116362; x=1737721162;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6R97ZJ/eTJmxy+gIbZqfH/ad7ajv9h0FEj5S8dEJik=;
        b=cvHc4PJ+nzts9RMFMhP5g2zu4CWOs2vSnK6jH+Tl15bmYJn9o7GpTCeb5TcrFeZrRL
         eBERZ6mekjBTfW0fa3aFq1qJWC3+L//UeBgm2Kxf8S8wBa+rY2iL5potP7VsHIib4/Hb
         PxC5e7j+OIQWGWjWn06SD7gN/ks/lD1siXEpXdBPwCZ6B+RLmsCkyPGWtdusnMnXS3z+
         lQUS+8/ca150cxjVkqoU/gufEbTFOyKoKjYYgOnzt85nnsQriVaZ62kmwcqHXaNBtKic
         NmpctJSCbSaU3Zyhy11o7LDPGemvkb7rLPkmWn3ZttSxa6aE80VO9DosRL5HYanDqIaK
         qPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWEVtPNr9qteZrYdrYxJh++PBqUAwxODJ2JqAPVUBCzeGi9MnhEzBMAd0JiU5koQNPVqbUOWZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyng0dq93t9sKswLz0Cy3XYwbTEtS5eKfYmhjOeWZRCd/H8hqI8
	LjjltY8nI3M7WDKueDpsj+rwSpgrs2tBVIfD+JaCX5IQLWH7xPhq+zXOBRoc0CI=
X-Gm-Gg: ASbGncufjC9tgYycsLJdl9tvRtjJmVua12yFzUw3PNVfl1IX0XOlJhj+j7HTh1O6/ou
	WD6wgDARCw9KrsUrOYiPnwQCBsJ71qGBR6m0a4e/yqA1VCG+0oWlQ7iNcP5FZQ2H+6hUAd/TCBB
	QQAP+OLjZ6gohzyV7nqAnwakbszbr4ajRqq7YIo0vmEN9jZ+5ZdQP7qpEMOphJzjzSIoHukrjQl
	XxefsLZGYOpBE87NOnRJdpagGKUS44jIAm4hjEAqMP8GMYoQ5rIKQPx4JszwThOtg==
X-Google-Smtp-Source: AGHT+IFiHsjzhhmivgjSF5VfJ0c3FKWNde2pUo4Vnzewlo1Hnuu5vdVh/ypoJIqfonBn0h5h7oo9dg==
X-Received: by 2002:a5d:4d04:0:b0:385:e429:e59e with SMTP id ffacd0b85a97d-38bf57c9337mr1823143f8f.52.1737116361664;
        Fri, 17 Jan 2025 04:19:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221c25sm2355234f8f.23.2025.01.17.04.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 04:19:21 -0800 (PST)
Message-ID: <3fe00f86-60f3-42a2-9491-7b876531c215@tuxon.dev>
Date: Fri, 17 Jan 2025 14:19:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 3/5] net: Add the possibility to support a
 selected hwtstamp in netdevice
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Alexandra Winter <wintera@linux.ibm.com>
References: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
 <20241212-feature_ptp_netnext-v21-3-2c282a941518@bootlin.com>
 <4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev>
 <20250117130656.23a41605@kmaincent-XPS-13-7390>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250117130656.23a41605@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.01.2025 14:06, Kory Maincent wrote:
> On Fri, 17 Jan 2025 13:57:41 +0200
> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> 
>> Hi, Kory,
>>
>> On 12.12.2024 19:06, Kory Maincent wrote:
>>> Introduce the description of a hwtstamp provider, mainly defined with a
>>> the hwtstamp source and the phydev pointer.
>>>
>>> Add a hwtstamp provider description within the netdev structure to
>>> allow saving the hwtstamp we want to use. This prepares for future
>>> support of an ethtool netlink command to select the desired hwtstamp
>>> provider. By default, the old API that does not support hwtstamp
>>> selectability is used, meaning the hwtstamp provider pointer is unset.
>>>
>>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
>>
>> I'm getting this error when doing suspend/resume on the Renesas RZ/G3S
>> Smarc Module + RZ SMARC Carrier II board:
>>
>> [   39.032969] =============================
>> [   39.032983] WARNING: suspicious RCU usage
>> [   39.033000] 6.13.0-rc7-next-20250116-arm64-renesas-00002-g35245dfdc62c
>> #7 Not tainted
>> [   39.033019] -----------------------------
>> [   39.033033] drivers/net/phy/phy_device.c:2004 suspicious
>> rcu_dereference_protected() usage!
> 
> Thanks for the report.
> Oh so it seems there are cases where phy_detach is not called under RTNL lock!
> 
> This should solve the issue:
> -               hwprov = rtnl_dereference(dev->hwprov);
> +               rcu_read_lock()
> +               hwprov = rcu_dereference(dev->hwprov);
>                 /* Disable timestamp if it is the one selected */
>                 if (hwprov && hwprov->phydev == phydev) {
>                         rcu_assign_pointer(dev->hwprov, NULL);
>                         kfree_rcu(hwprov, rcu_head);
>                 }
> +               rcu_read_unlock();

Just tested. The issue is gone. You can add my:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thank you,
Claudiu

> 
> I will send a patch soon.
> 
> Regards,


