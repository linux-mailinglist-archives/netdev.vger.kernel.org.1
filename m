Return-Path: <netdev+bounces-62158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3F825F5C
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 12:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7392829CC
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19906ADC;
	Sat,  6 Jan 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="UqgcafrM"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A766FA4
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75BBFE0002;
	Sat,  6 Jan 2024 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704541009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1x0Ynd4sswJ7YgErGROhtaCoke2pH7OR8Fni6nTahQ=;
	b=UqgcafrM/0PM75hptmNBcKIftRtQ8ZI289P6bUS3zfPsykmCWRj4C7WpxVFbxp43oSlhhf
	9BK9tx9gKhpz+iVT3WawHkjb6CaI1mAeil3KuWgMt7XDXY96J5g+ktD8OChMhV7Ogyw0Tw
	2T317qXDIODqLup9dUWuaxHfsLo2W20jdld+0c2IMx1bPYvfBIQgELsRFpbA9Po5J43Odt
	SHr9XKqwtefe0YlAE6PfJIiwFm2GdLun3HnhJ+uPQuyoSaktongdgQiAdK52ofvpDHYNAK
	l8BN89O/Mugk7RLqjnSG3EAWsm1sFGhdJt6gMOH71XRHdGYrSEbsrbjhxt1xwQ==
Message-ID: <92fe7016-8c01-4f82-b7ec-a23f52348059@arinc9.com>
Date: Sat, 6 Jan 2024 14:36:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 8/8] Revert "net: dsa: OF-ware slave_mii_bus"
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-9-luizluca@gmail.com>
 <a638d0de-bfb3-4937-969e-13d494b6a2c3@arinc9.com>
 <7385ca39-182e-42c1-80bf-fd2d0c0aabdd@arinc9.com>
Content-Language: en-US
In-Reply-To: <7385ca39-182e-42c1-80bf-fd2d0c0aabdd@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 30.12.2023 18:56, Arınç ÜNAL wrote:
> On 30.12.2023 10:18, Arınç ÜNAL wrote:
>> I think we should do all this in a single patch. I've done it on the MT7530
>> DSA subdriver which I maintain.
> 
> Actually, there's no need to drag this patch further by including the
> improvement of handling the MDIO bus on all relevant subdrivers.
> 
> That said, I'd like to submit this patch myself, if it is OK by everyone
> here.
> 
> Here's the patch log I've prepared:
> 
> net: dsa: do not populate user_mii_bus when switch MDIO bus is described
> 
> The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
> switch is described on the device-tree [1].
> 
> To keep things simple, make [all subdrivers that control switches [with
> MDIO bus] probed on OF] register the bus on the subdriver. This is already
> the case on all of these subdrivers.
> 
> There can be a case where ds->user_mii_bus is not populated, but
> ds_switch_ops.phy_{read,write} is. That would mean the subdriver controls
> switches probed on OF, and it lets the DSA core driver to populate
> ds->user_mii_bus and register the bus. We don't want this to happen.
> Therefore, ds_switch_ops.phy_{read,write} should be only used on the
> subdrivers that control switches probed on platform_data.
> 
> With that, the "!ds->user_mii_bus && ds->ops->phy_read" check under
> dsa_switch_setup() remains in use only for switches probed on
> platform_data. Therefore, remove OF-based registration as it's useless now.
> 
> Currently, none of the subdrivers that control switches [with MDIO bus]
> probed on OF implements ds_switch_ops.phy_{read,write} so no subdriver will
> be affected by this patch.

It looks like this patch will cause the MDIO bus of the switches probed on
OF which are controlled by these subdrivers to only be registered
non-OF-based.

drivers/net/dsa/b53/b53_common.c
drivers/net/dsa/lan9303-core.c
drivers/net/dsa/vitesse-vsc73xx-core.c

These subdrivers let the DSA driver register the bus OF-based or
non-OF-based:
- ds->ops->phy_read() and ds->ops->phy_write() are present.
- ds->user_mii_bus is not populated.

Not being able to register the bus OF-based may cause issues. There is an
example for the switch on the MT7988 SoC which is controlled by the MT7530
DSA subdriver. Being able to reference the PHYs on the switch MDIO bus is
mandatory on MT7988 as calibration data from NVMEM for each PHY is
required.

I suggest that we hold off on this patch until these subdrivers are made to
be capable of registering the MDIO bus as OF-based on their own.

Arınç

