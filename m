Return-Path: <netdev+bounces-193173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D4AC2BAA
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B57D16F60F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDA20FABC;
	Fri, 23 May 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BuhuzyRg"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173520DD51
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038060; cv=none; b=Zdpy1Yy5S0739sbJ8IMPjPXW151dU9xwhsPif0ObpJRwfbxgIlWEGJceEHXItSJDZGFj4xTgyOe433mz7bNx6WE10JCndX73qebX+rPujAzY8Scg61/SEVAEZvQ+Hj1jEy6ifxoJ+dTDD/rlqzPDVEC9IIFAJejWKRtrNZJa46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038060; c=relaxed/simple;
	bh=O2bJdVPV3L8WKiILkE9MT86NxXS7Hxb1SqDmcu52wlg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KDIhFu3QuKTPATac0c4RFvfPTeW6V4VcPd/yycFYYkK5pjCMjTBbRXBjthjW9eUtvkhXIyqGM9Lw3r0kA0mXR7ZA4BKJFfmcHog5AOYbn5ThntFhbpNgpHMDCTiiGdvqXobCRT9AWvHDGwxtp9jwjNME0dh9tkXINT32K7CmHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BuhuzyRg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0bd575b-a01b-418f-9d89-b59398e87a48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748038045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfE5RI8sdHQOC0St9xLTbELvL5dxMr0+2JTXjw9jvzQ=;
	b=BuhuzyRgVIsmybsGsus+f/a+6UDlLTGakNSjft62FozqL+zXw9SAqhaMjtw5DTMlSLgvX+
	zzLw7j0VlyCyvwFJN2lng8C5YyZdwZQeyniLgsj0H6odbyXtxfzWqe8iHQQVL1XRl5b2O6
	btoiUX8zBK4kkB8jrgCxmWo9aqPGxIg=
Date: Fri, 23 May 2025 18:07:16 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO
 driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Lei Wei <quic_leiwei@quicinc.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
 <20250523203339.1993685-6-sean.anderson@linux.dev>
 <a937e728-d911-4fcc-9af1-9ae6130f96c1@gmail.com>
 <3a452864-9d02-4fa7-9d7c-a240b611ee74@linux.dev>
Content-Language: en-US
In-Reply-To: <3a452864-9d02-4fa7-9d7c-a240b611ee74@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/23/25 17:39, Sean Anderson wrote:
> On 5/23/25 17:33, Heiner Kallweit wrote:
>> On 23.05.2025 22:33, Sean Anderson wrote:
>>> This converts the lynx PCS driver to a proper MDIO driver.
>>> This allows using a more conventional driver lifecycle (e.g. with a
>>> probe and remove). It will also make it easier to add interrupt support.
>>> 
>>> The existing helpers are converted to bind the MDIO driver instead of
>>> creating the PCS directly. As lynx_pcs_create_mdiodev creates the PCS
>>> device, we can just set the modalias. For lynx_pcs_create_fwnode, we try
>>> to get the PCS the usual way, and if that fails we edit the devicetree
>>> to add a compatible and reprobe the device.
>>> 
>>> To ensure my contributions remain free software, remove the BSD option
>>> from the license. This is permitted because the SPDX uses "OR".
>>> 
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>> 
>>> Changes in v5:
>>> - Use MDIO_BUS instead of MDIO_DEVICE
>>> 
>>> Changes in v4:
>>> - Add a note about the license
>>> - Convert to dev-less pcs_put
>>> 
>>> Changes in v3:
>>> - Call devm_pcs_register instead of devm_pcs_register_provider
>>> 
>>> Changes in v2:
>>> - Add support for #pcs-cells
>>> - Remove unused variable lynx_properties
>>> 
>>>  drivers/net/dsa/ocelot/Kconfig                |   4 +
>>>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  11 +-
>>>  drivers/net/dsa/ocelot/seville_vsc9953.c      |  11 +-
>>>  drivers/net/ethernet/altera/Kconfig           |   2 +
>>>  drivers/net/ethernet/altera/altera_tse_main.c |   7 +-
>>>  drivers/net/ethernet/freescale/dpaa/Kconfig   |   2 +-
>>>  drivers/net/ethernet/freescale/dpaa2/Kconfig  |   3 +
>>>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  11 +-
>>>  drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
>>>  .../net/ethernet/freescale/enetc/enetc_pf.c   |   8 +-
>>>  .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 -
>>>  .../freescale/enetc/enetc_pf_common.c         |   4 +-
>>>  drivers/net/ethernet/freescale/fman/Kconfig   |   4 +-
>>>  .../net/ethernet/freescale/fman/fman_memac.c  |  25 ++--
>>>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   3 +
>>>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   6 +-
>>>  drivers/net/pcs/Kconfig                       |  11 +-
>>>  drivers/net/pcs/pcs-lynx.c                    | 110 ++++++++++--------
>>>  include/linux/pcs-lynx.h                      |  13 ++-
>>>  19 files changed, 128 insertions(+), 110 deletions(-)
>>> 
>>> diff --git a/drivers/net/dsa/ocelot/Kconfig b/drivers/net/dsa/ocelot/Kconfig
>>> index 081e7a88ea02..907c29d61c14 100644
>>> --- a/drivers/net/dsa/ocelot/Kconfig
>>> +++ b/drivers/net/dsa/ocelot/Kconfig
>>> @@ -42,7 +42,9 @@ config NET_DSA_MSCC_FELIX
>>>  	select NET_DSA_TAG_OCELOT_8021Q
>>>  	select NET_DSA_TAG_OCELOT
>>>  	select FSL_ENETC_MDIO
>>> +	select PCS
>>>  	select PCS_LYNX
>>> +	select MDIO_BUS
>> 
>> This shouldn't be needed. NET_DSA selects PHYLINK, which selects PHYLIB,
>> which selects MDIO_BUS. There are more places in this series where the
>> same comment applies.
> 
> select does not transitively enable dependencies. See the note in
> Documentation/kbuild/kconfig-language.rst for details. Therefore we must
> select the dependencies of things we select in order to ensure we do not
> trip sym_warn_unmet_dep.

OK, I see what you mean here. But of course NET_DSA is missing selects for
PHYLIB and MDIO_BUS. And PHYLINK is also missing a select for MDIO_BUS. Actually,
this bug is really endemic. Maybe we should just get rid of PHYLIB as a config
and just make everything depend on ETHERNET instead.

--Sean


