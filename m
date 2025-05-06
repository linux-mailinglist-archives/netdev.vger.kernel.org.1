Return-Path: <netdev+bounces-188489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6F2AAD110
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2081C018EE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0821B1B9;
	Tue,  6 May 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dBxvYUbG"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A85680
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571196; cv=none; b=X1bbIsxBZr4TRuCCmbCCynczQPLHSL8/5nWMerQ3fFWWgxzuIg9PHyfjJOOI2fJmId/HvZwmmUzegQO45t+QZglmOLaRg05PWPNHKQo2Umx5MxnCC7DTEtAtt2UazvIOhCGgmEyIZY8V0n3E3Y5Q6m6ni1LlCt+negp++niGvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571196; c=relaxed/simple;
	bh=9GzFnldB/RPzmJjAClHv/ObE6Ew9kZSOMYJFBVJl3eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDIzc8vwWBtq1hiH0wTuRlt+txMC/IOvFvVuJa/m5csfZPddayH73TyQx1XRUCf8k7LUZ831iJpUKc0cXOtSsbf0wY7OFPAku6rjqmTDaFclpVxWymOcTsJw8btQPosm9VtBhoEDYYUUQHQlE0y9ineOYmBrcjvKnY6xzl+6Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dBxvYUbG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39753b36-adfd-4e00-beea-b58c1e5606e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746571191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGtKCWxeeCvHWwIXpg+TiH0nAUubbBX52QN4JIdpmDA=;
	b=dBxvYUbGFjSvYPErgbn2TcYVIGRVNpmNzM/8TioVlNVuOPAa0Eoy6QGm+QMdUJI1S/c5Kk
	SH90tg7O5nhrD6XwUoh5Kwh5p7UVhNWbyid5ILzAO3KUTRUQVfpGfA+046gTFSNWjxZrFe
	YFaKCJiQNFIjmHFD29gIbGGiKmhAgZ0=
Date: Tue, 6 May 2025 18:39:43 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>,
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Joyce Ooi <joyce.ooi@intel.com>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, UNGLinuxDriver@microchip.com,
 Wei Fang <wei.fang@nxp.com>, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
 <d66ac48c-8fe3-4782-9b36-8506bb1da779@linux.dev>
 <20250506222928.fozoqcxuf7roxur5@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250506222928.fozoqcxuf7roxur5@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/25 18:29, Vladimir Oltean wrote:
> On Tue, May 06, 2025 at 06:20:32PM -0400, Sean Anderson wrote:
>> On 5/6/25 18:18, Vladimir Oltean wrote:
>> > On Tue, May 06, 2025 at 06:03:35PM -0400, Sean Anderson wrote:
>> >> On 5/6/25 17:58, Vladimir Oltean wrote:
>> >> > Hello Sean,
>> >> > 
>> >> > On Tue, Apr 15, 2025 at 03:33:17PM -0400, Sean Anderson wrote:
>> >> >> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
>> >> >> index 23b40e9eacbb..bacba1dd52e2 100644
>> >> >> --- a/drivers/net/pcs/pcs-lynx.c
>> >> >> +++ b/drivers/net/pcs/pcs-lynx.c
>> >> >> @@ -1,11 +1,15 @@
>> >> >> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> >> >> -/* Copyright 2020 NXP
>> >> >> +// SPDX-License-Identifier: GPL-2.0+
>> >> >> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
>> >> >> + * Copyright 2020 NXP
>> >> >>   * Lynx PCS MDIO helpers
>> >> >>   */
>> >> >>  
>> >> >> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
>> >> >> -MODULE_LICENSE("Dual BSD/GPL");
>> >> >> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
>> >> >> +MODULE_LICENSE("GPL");
>> >> > 
>> >> > What's the idea with the license change for this code?
>> >> 
>> >> I would like to license my contributions under the GPL in order to
>> >> ensure that they remain free software.
>> >> 
>> >> --Sean
>> > 
>> > But in the process, you are relicensing code which is not yours.
>> > Do you have agreement from the copyright owners of this file that the
>> > license can be changed?
>> 
>> I'm not relicensing anything. It's already (GPL OR BSD-3-Clause). I'm
>> just choosing not to license my contributions under BSD-3-Clause.
>> 
>> --Sean
> 
> You will need to explain that better, because what I see is that the
> "BSD-3-Clause" portion of the license has disappeared and that applies
> file-wide, not just to your contribution.

But I also have the option to just use the GPL-2.0+ license. When you
have an SPDX like (GPL-2.0+ OR BSD-3-Clause) that means the authors gave
permission to relicense it as

- BSD-3-Clause
- GPL-2.0+
- GPL-2.0+ OR BSD-3-Clause
- GPL-2.0
- GPL-2.0 OR BSD-3-Clause
- GPL-3.0
- GPL-3.0 OR BSD-3-Clause
- GPL-4.0 (if it ever happens)

I want my contributions to remain free software, so I don't want to
allow someone to take the BSD-3-Clause option (without the GPL).

--Sean

