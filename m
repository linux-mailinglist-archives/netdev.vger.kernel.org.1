Return-Path: <netdev+bounces-212018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E954B1D418
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59EA188D31A
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B242459D2;
	Thu,  7 Aug 2025 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dDDGVCXu"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91F242D8C;
	Thu,  7 Aug 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554370; cv=none; b=kAnAYM8WQKExtrG7azeyZm4QNi6FJ0NsV6zw0x+J6uMaXtfFn/2GA1+JT40VA1UFd+HpMjIbvmp/Ir+f9QjWV+96nl7oDh9Jj0z4+v+R2GcSV/Zy2s5q9PfGpTDDTAZ9QhraPvOhBWr8T3J8xjNa4pA/CFMjgP1LkYGwWj7beLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554370; c=relaxed/simple;
	bh=7EdlOcRR0NwYJwD8hYbF7warJbChcL56i1E37eWEx/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hEd4Bo0kjT5yHQKMDVPuSS5SaCNExHOOFNft93f+bgg1N2yHQDdOQIg0+w0faF93ev3+OGdBtYmuY1uVp+GqXzIdmsfPqLFrGGtYafLJgiATHaNRp8iBJDfK7Bx/v/GJHGR1yGfv9rzryT9grk1Pg7N1+3siBnzsJnS2G0whrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dDDGVCXu; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 38C56A037B;
	Thu,  7 Aug 2025 10:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=UuRqPb6SX7syB2TiesZJ
	ExxNgF2tJCZyFOUHLCx1+As=; b=dDDGVCXu8G/3AJDBLLZ5h5sPkNz/9EgA0A/3
	CKUPObCBjSpfp0U0g6abhE451Xe5OZnECt+8WIFGVcTZ0XhOxKc/ObBab7SXRICX
	In/ct3ZKdYcW1XJoM66ptAcGCmg9dqIoNTIpB457vmv5lwC9J9EVZz1kryg7kTU2
	sXlqV6tIJzV+4dGb6d0rxps/102kAmL+7X1o8Zg1ryho45VeXkkgMODkVDss3r4L
	fB1J9OAw0rBi8q9bnaTDFa8X9lP4YwHDvAmD4xlRt6ujq26d3js6SWyZE5gFAzMw
	u481iug4I+HAFAIv+lT+TUmnBYBxAiAt7DDnNyLWrtqGEiN8TJDDVBAztjNLzQLF
	TsJfbu+t+abdExZaWnLkT3vILeaKqy+12EUpXqZoPXzzS+eUUD/h/KzDUclNViKE
	ZjnoJ4Dci7iLrProypXcenQv8RC1ca5nPS6BH2grbXVUTvgvlJDYvif9rYgFt9Qg
	I749EWTcmiMvbSj2Ds9ACwecMJkIUL7wulwqEPqjaHcZcNQO71BNbsAjJoHxYPnL
	x6ywM9UBq/Rbg4AVkHpj+lHrg9HIK5mwywslaioW2Psx71rdi29gL4LGg8J0BwkO
	pEB/2+qf8FpxLR1NT4Jaqg1iZPB31RPgyrZtexVwpT8kbplKgSBHM3t7VaGpnyvk
	63LwwKI=
Message-ID: <5600f2ea-eaa2-4a8d-8092-e9f3d3cb42d1@prolan.hu>
Date: Thu, 7 Aug 2025 10:12:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Sergei Shtylyov
	<sergei.shtylyov@cogentembedded.com>, "David S. Miller"
	<davem@davemloft.net>, Rob Herring <robh@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Csaba Buday <buday.csaba@prolan.hu>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Mark Brown <broonie@kernel.org>
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
 <20250730181645.6d818d6a@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250730181645.6d818d6a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E66706B

Hi,

On 2025. 07. 31. 3:16, Jakub Kicinski wrote:
> On Mon, 28 Jul 2025 17:34:55 +0200 Bence Csókás wrote:
>> Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
>> devm_gpiod_get_optional() in favor of the non-devres managed
>> fwnode_get_named_gpiod(). When it was kind-of reverted by commit
>> 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
>> functionality was not reinstated. Nor was the GPIO unclaimed on device
>> remove. This leads to the GPIO being claimed indefinitely, even when the
>> device and/or the driver gets removed.
>>
>> Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
>> Fixes: 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()")
>> Cc: Csaba Buday <buday.csaba@prolan.hu>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> Looks like this is a v2 / rewrite of
> https://lore.kernel.org/all/20250709133222.48802-3-buday.csaba@prolan.hu/
> ? Please try to include more of a change log / history of the changes
> (under the --- marker)

I talked with Csaba, and now I realize I shouldn't have modified the 
original. I will resubmit that instead.

Bence


