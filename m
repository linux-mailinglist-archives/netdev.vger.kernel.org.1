Return-Path: <netdev+bounces-189036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1EAAFFC0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A486F188F893
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857B27A127;
	Thu,  8 May 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJPdaR3F"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBF279915
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719879; cv=none; b=RhnZO1oZny09gTeELr0ZSwZOMS4NV88CH+4SG8+ev72H6fnuaPIA+gusH8ZsEf7Kt9WLdBebeqe/QV8C1i+PjdG9qmuNJqzCAuDQMm7Jo+YFAehH8OHdhtkZQomsZbjNwkcJp/8+GMRCkvgGxVMHBLa1qyJqfp3+EvH5yacWwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719879; c=relaxed/simple;
	bh=mv6+AFQbMjS0ePIASEYb6FmIlCpd2gcgZiCc/i2a2Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXpEWtQ34IgimH0EhRrY6Yr11Jd5IOJwu8GjayShs54YUThIsKrWpQFgPD3iJ+1HBvBWak6ZLDR2HppYYYaCtVNBK+HqivU9OrqHUPAzz4Lr8DjKMOtOeOuSHxdYWvpWzdeDumzY+AuBkQ9R1jGSC0G9DA7vxZirEReXc99/Xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJPdaR3F; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4b662cc-7b56-4e96-b3d1-7d19e2663cb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746719874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCf3z7hOXG7UGs2boSQYoGffK4tgAQHTQeG/mcAB+UQ=;
	b=lJPdaR3Fu+V9MjBKhXVqjM5ARaeWWWBzH7gr12dEMCD3CyGBvWqwd2190MaRx7p69jMmIS
	me9Q+Sv/63NVqHv5s6kUGxzTe24eHPO6Fi/A8TEbUJ//ht6I79MVTUFYi9LC30wv9H4eY/
	baAF+k0hlVlEkJfa+yDCdl8n+4ngxXg=
Date: Thu, 8 May 2025 11:57:46 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Joyce Ooi <joyce.ooi@intel.com>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, UNGLinuxDriver@microchip.com,
 Wei Fang <wei.fang@nxp.com>, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
 <d66ac48c-8fe3-4782-9b36-8506bb1da779@linux.dev>
 <20250506222928.fozoqcxuf7roxur5@skbuf>
 <39753b36-adfd-4e00-beea-b58c1e5606e3@linux.dev>
 <90b2af4e-6c6e-41b9-be5b-ead443cd85b2@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <90b2af4e-6c6e-41b9-be5b-ead443cd85b2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

On 5/6/25 20:19, Andrew Lunn wrote:
>> > You will need to explain that better, because what I see is that the
>> > "BSD-3-Clause" portion of the license has disappeared and that applies
>> > file-wide, not just to your contribution.
>> 
>> But I also have the option to just use the GPL-2.0+ license. When you
>> have an SPDX like (GPL-2.0+ OR BSD-3-Clause) that means the authors gave
>> permission to relicense it as
>> 
>> - BSD-3-Clause
>> - GPL-2.0+
>> - GPL-2.0+ OR BSD-3-Clause
>> - GPL-2.0
>> - GPL-2.0 OR BSD-3-Clause
>> - GPL-3.0
>> - GPL-3.0 OR BSD-3-Clause
>> - GPL-4.0 (if it ever happens)
>> 
>> I want my contributions to remain free software, so I don't want to
>> allow someone to take the BSD-3-Clause option (without the GPL).
> 
> Please can you give us a summary of the licenses of this file over its
> complete history. Maybe it started out as GPL, and somebody wanted
> their parts to be under BSD, and so added the BSD parts?

This is the original license added in commit 0da4c3d393e4 ("net: phy:
add Lynx PCS module").

--Sean

