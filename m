Return-Path: <netdev+bounces-59732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5745481BE51
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 19:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AD62852F4
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF828C1A;
	Thu, 21 Dec 2023 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="gTD8Y8y2"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56673190
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDD8D20007;
	Thu, 21 Dec 2023 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703183699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvC3ADsYzh5V9qGmbzZ4J7Zs6G4JTwambi8QefRY9aY=;
	b=gTD8Y8y2Ay6bZodfXQUBKWIGMrCIhuYVMU0ScoskjNRZRMfSvUy+0ADWZfiAPGZcRzWPhp
	AdZEMzLuQ2Edx8mgWyKNMFlXaFSBZpt4+91P3YjnobuzNO0kvskoYTD3ewiLlttRiSrFC0
	rI40qUivFciMISR/QR8ufcqbN4YFyndCqhSe4ikifV77DFJjgWtwNm3g3bEFoqqqpgXZnu
	QgqSjwmDn0FXGEMvJ1MkHzV6c/8TKcbq2q5mXdEnucTmtp37ptjKnVszyG/perhPPrzvfR
	1HEtskUx/K2CnrzyyN3fNvygRiEHaEt6lLNVvJZ0xHa2VupCAAczC1jz5Qh0IQ==
Message-ID: <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
Date: Thu, 21 Dec 2023 21:34:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231221174746.hylsmr3f7g5byrsi@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 21.12.2023 20:47, Vladimir Oltean wrote:
> On Wed, Dec 20, 2023 at 01:51:01AM -0300, Luiz Angelo Daros de Luca wrote:
>>> +       priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
>>> +       if (!priv->user_mii_bus) {
>>> +               ret = -ENOMEM;
>>> +               goto err_put_node;
>>> +       }
>>> +       priv->user_mii_bus->priv = priv;
>>> +       priv->user_mii_bus->name = "Realtek user MII";
>>> +       priv->user_mii_bus->read = realtek_common_user_mdio_read;
>>> +       priv->user_mii_bus->write = realtek_common_user_mdio_write;
>>> +       snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
>>> +                ds->index);
>>> +       priv->user_mii_bus->parent = priv->dev;
>>> +
>>> +       /* When OF describes the MDIO, connecting ports with phy-handle,
>>> +        * ds->user_mii_bus should not be used *
>>> +        */
>>> +       dsa_switch_for_each_user_port(dp, ds) {
>>> +               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
>>> +               of_node_put(phy_node);
>>> +               if (phy_node)
>>> +                       continue;
>>> +
>>> +               dev_warn(priv->dev,
>>> +                        "DS user_mii_bus in use as '%s' is missing phy-handle",
>>> +                        dp->name);
>>> +               ds->user_mii_bus = priv->user_mii_bus;
>>> +               break;
>>> +       }
>>
>> Does this check align with how should ds->user_mii_bus be used (in a
>> first step for phasing it out, at least for this driver)?
> 
> No. Thanks for asking.
> 
> What I would like to see is a commit which removes the line assigning
> ds->user_mii_bus completely, with the following justification:
> 
> ds->user_mii_bus helps when
> (1) the switch probes with platform_data (not on OF), or
> (2) the switch probes on OF but its MDIO bus is not described in OF
> 
> Case (1) is eliminated because this driver uses of_device_get_match_data()
> and fails to probe if that returns NULL (which it will, with platform_data).
> So this switch driver only probes on OF.
> 
> Case (2) is also eliminated because realtek_smi_setup_mdio() bails out
> if it cannot find the "mdio" node described in OF. So the ds->user_mii_bus
> assignment is only ever executed when the bus has an OF node, aka when
> it is not useful.
> 
> Having the MDIO bus described in OF, but no phy-handle to its children
> is a semantically broken device tree, we should make no effort whatsoever
> to support it.
> 
> Thus, because the dsa_user_phy_connect() behavior given by the DSA core
> through ds->user_mii_bus does not help in any valid circumstance, let's
> deactivate that possible code path and simplify the interaction between
> the driver and DSA.
> 
> And then go on with the driver cleanup as if ds->user_mii_bus didn't exist.
> 
> Makes sense? Parsing "phy-handle" is just absurdly complicated.

I don't like the fact that the driver bails out if it doesn't find the
"mdio" child node. This basically forces the hardware design to use the
MDIO bus of the switch. Hardware designs which don't use the MDIO bus of
the switch are perfectly valid.

It looks to me that, to make all types of hardware designs work, we must
not use ds->user_mii_bus for switch probes on OF. Case (2) is one of the
cases of the ethernet controller lacking link definitions in OF so we
should enforce link definitions on ethernet controllers. This way, we make
sure all types of hardware designs work and are described in OF properly.

Arınç

