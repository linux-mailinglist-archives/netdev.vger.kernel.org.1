Return-Path: <netdev+bounces-254181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IELQMRffeWnI0QEAu9opvQ
	(envelope-from <netdev+bounces-254181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:04:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4609F316
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15CC30514A9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F892D7DE2;
	Wed, 28 Jan 2026 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sjd96eby"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4282C11E9
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594551; cv=none; b=bIIocPDzbJVgMndGrWCu06CqSETLkUNVZrtVmBZlHvBOG26UC6oVT2QmqS2WFTmHG+gYYBKtw/HMop9C5DT2SUyyDzBHn9ojSJ47cFKpkEKhNybBzB3qV7vmYQv5dsOwC+us3vvP1ce6hfTYiDvHrFhjMhlkS/KQ46QWsjM4HJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594551; c=relaxed/simple;
	bh=F72nBXVKIDY5tpWLPUxBk5sHSnJn/wGfp9bj9IxOdwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fry8HQKU9OxgYBTBB7Ly+hRmZg2nBfMYBPrgaqaHlWwH1pXSMdPC9lWcZCcADyiSXKDonUu/HswI7MZK2AHIaCY3FhBRnWZ/OAb5T6Uz+Bq+hjM8yCzg1MC83BAXoAGkILk1Gf6SykcI5R2gZDGe3CCJGbWo+P8o0VC+ezNcX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sjd96eby; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C2D29C211E3;
	Wed, 28 Jan 2026 10:02:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49F6E6071A;
	Wed, 28 Jan 2026 10:02:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17E2C119A8805;
	Wed, 28 Jan 2026 11:02:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769594538; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jl/qUj03yO9xDW1xqUwBwXsZCnYBNJNRMPOW11zOe6Y=;
	b=sjd96ebyrvCGdPERJq6YfDm4tCFtKy+a7g8m54wbglfV7iboWOEwY5SJmSfnInyV4QPBlY
	LzDO5YFZ1j+mGCmYTk8GCQjQy9wpAUCtaXmm2EfayCmHll9JgibdqvDTgkHpGSQQrFLAEO
	CdvX1tkRhD9D9Zhg56BJ+XIv+QG0dBdqwlApnNO4alZVBO14eCXTwOiZ9FI37MWwCfDwBc
	hU1eeKF1lmnHZw4ow541st0frBdOYlTx4xsD1wZe2NjwlKoRSebHvWKqYoGARtcvb2PH77
	wupAyD/u1Edg7tK/FRyQjMJiFOJ/RriyV7US/aExvrfKYduY1o7agjt9LkGX7A==
Message-ID: <fd4bb158-5138-4fc9-ad1f-d0002ec0fee4@bootlin.com>
Date: Wed, 28 Jan 2026 11:02:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
To: Wei Fang <wei.fang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260126081544.983517-1-wei.fang@nxp.com>
 <13f1599a-afd7-4350-a395-83c57ab91f18@bootlin.com>
 <AM9PR04MB8505744A93921B488AD9505C8891A@AM9PR04MB8505.eurprd04.prod.outlook.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <AM9PR04MB8505744A93921B488AD9505C8891A@AM9PR04MB8505.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254181-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 3F4609F316
X-Rspamd-Action: no action



On 28/01/2026 10:36, Wei Fang wrote:
>> On 26/01/2026 09:15, Wei Fang wrote:
>>> Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
>>> external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
>>> by phy_driver::resume() and disabled by phy_driver::suspend(). However,
>>> devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
>>> will automatically be disabled when the device is unbound from the bus.
>>> Therefore, this could cause the clock to be disabled twice, resulting
>>> in clk driver warnings.
>>>
>>> For example, this issue can be reproduced on i.MX6ULL platform, and we
>>> can see the following logs when removing the FEC MAC drivers.
>>>
>>> $ echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind
>>> $ echo 20b4000.ethernet > /sys/bus/platform/drivers/fec/unbind
>>> [  109.758207] ------------[ cut here ]------------
>>> [  109.758240] WARNING: drivers/clk/clk.c:1188 at
>> clk_core_disable+0xb4/0xd0, CPU#0: sh/639
>>> [  109.771011] enet2_ref already disabled
>>> [  109.793359] Call trace:
>>> [  109.822006]  clk_core_disable from clk_disable+0x28/0x34
>>> [  109.827340]  clk_disable from clk_disable_unprepare+0xc/0x18
>>> [  109.833029]  clk_disable_unprepare from devm_clk_release+0x1c/0x28
>>> [  109.839241]  devm_clk_release from devres_release_all+0x98/0x100
>>> [  109.845278]  devres_release_all from device_unbind_cleanup+0xc/0x70
>>> [  109.851571]  device_unbind_cleanup from
>> device_release_driver_internal+0x1a4/0x1f4
>>> [  109.859170]  device_release_driver_internal from
>> bus_remove_device+0xbc/0xe4
>>> [  109.866243]  bus_remove_device from device_del+0x140/0x458
>>> [  109.871757]  device_del from phy_mdio_device_remove+0xc/0x24
>>> [  109.877452]  phy_mdio_device_remove from
>> mdiobus_unregister+0x40/0xac
>>> [  109.883918]  mdiobus_unregister from
>> fec_enet_mii_remove+0x40/0x78
>>> [  109.890125]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
>>> [  109.896076]  fec_drv_remove from
>> device_release_driver_internal+0x17c/0x1f4
>>> [  109.962748] WARNING: drivers/clk/clk.c:1047 at
>> clk_core_unprepare+0xfc/0x13c, CPU#0: sh/639
>>> [  109.975805] enet2_ref already unprepared
>>> [  110.002866] Call trace:
>>> [  110.031758]  clk_core_unprepare from clk_unprepare+0x24/0x2c
>>> [  110.037440]  clk_unprepare from devm_clk_release+0x1c/0x28
>>> [  110.042957]  devm_clk_release from devres_release_all+0x98/0x100
>>> [  110.048989]  devres_release_all from device_unbind_cleanup+0xc/0x70
>>> [  110.055280]  device_unbind_cleanup from
>> device_release_driver_internal+0x1a4/0x1f4
>>> [  110.062877]  device_release_driver_internal from
>> bus_remove_device+0xbc/0xe4
>>> [  110.069950]  bus_remove_device from device_del+0x140/0x458
>>> [  110.075469]  device_del from phy_mdio_device_remove+0xc/0x24
>>> [  110.081165]  phy_mdio_device_remove from
>> mdiobus_unregister+0x40/0xac
>>> [  110.087632]  mdiobus_unregister from
>> fec_enet_mii_remove+0x40/0x78
>>> [  110.093836]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
>>> [  110.099782]  fec_drv_remove from
>> device_release_driver_internal+0x17c/0x1f4
>>>
>>> After analyzing the process of removing the FEC driver, as shown below,
>>> it can be seen that the clock was disabled twice by the PHY driver.
>>>
>>> fec_drv_remove()
>>>   --> fec_enet_close()
>>>     --> phy_stop()
>>>       --> phy_suspend()
>>>         --> kszphy_suspend() #1 The clock is disabled
>>>   --> fec_enet_mii_remove()
>>>     --> mdiobus_unregister()
>>>       --> phy_mdio_device_remove()
>>>         --> device_del()
>>>           --> devm_clk_release() #2 The clock is disabled again
>>>
>>> Therefore, devm_clk_get_optional() is used to fix the above issue. And
>>> to avoid the issue mentioned by the commit 985329462723 ("net: phy:
>>> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
>>> clock is enabled by clk_prepare_enable() to get the correct clock rate.
>>>
>>> Fixes: 25c6a5ab151f ("net: phy: micrel: Dynamically control external clock of
>> KSZ PHY")
>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>>
>> This should fix the issue indeed. The dance of enabling/disabling then
>> re-enabling at resume() again feels odd, but at least it's balanced.
>>
>> We may be able to avoid that entirely by dealing with the ref_mii_clk
>> selection only in the .resume() path, as it's also called no long after
>> config_init(). That would mean reading the clock rate in
>> kszphy_config_reset(), then performing the kszphy_rmii_clk_sel()
>> accordingly.
>>
> 
> It seems rather strange to get the clock rate every time the .resume()
> is called. Otherwise, we would need to add some additional logic to 
> kszphy_rmii_clk_sel() to ensure that the clock rate is only obtained
> once. IMO, it would be more reasonable to only get the clock rate in
> the .probe() during the lifetime of the PHY driver.
> 
> Furthermore, this seems to break the previous logic: when the clock
> rate is incorrect, the .probe() will return an error, meaning the PHY
> driver will not be loaded.
> 

Makes sense to validate it early indeed :) All in all, this seems ok then.

Maxime


