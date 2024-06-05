Return-Path: <netdev+bounces-101053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA748FD119
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB97B2609D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D12837A;
	Wed,  5 Jun 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tcfuyKhV"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296A125BA;
	Wed,  5 Jun 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598855; cv=none; b=fK2KJS/zGrEqHmY1xh2zP94EnBa5b5cjmdHYb2XBcSbgmFAVlFcca9/C1Y4eXw5fNoWOlt3LzgF3jL0VW1sX3s5QzbB0PW0aj0fmyXaHiAAeQBriX94o6J/fgN/dRB7yrgcH4vL8IBAvLHor5t72PKl2YU3KCs0uW8kWeTZA0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598855; c=relaxed/simple;
	bh=PXB2GCAHy4AXeES+/s42eyr/C+ckbgTV2vZzTuEb1/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sQOQQ99byzt1HFGOgp/u4EFkX0RhheQQz8GxDgL6c007X8ABYAHIyQpC3cMeExK7k3/ay0C4N3e1q7l9XIUTblrL0177AfdRvancAXOZPwc36gfjVnrn86zwMqBYeJhcFKkJiQOyDnkBrHVUwkIjR8abzQNGkSFrHchxp0Rk9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tcfuyKhV; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E87A5A0790;
	Wed,  5 Jun 2024 16:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=yHugVKhDEFMDE/eZEfLI
	Bc5qQ57hrk9iNIoSwhUNJLk=; b=tcfuyKhVcRguuQNo46SAlaD0FlIQvRDrF7ZK
	vIFiROmjYHioynBcUn9Cfy07HvZf/457e1G/sky+RcyneEqP76d0oGDE9qjmC47/
	Rokdx6uAahKDAjhnFPbxXyJO11FGRElI+p7UFaw1GX4rsvqTkzIVlJmGynOTn/kp
	q6Mn4e5puJtbfcgH+N3NC1apXtbrU94OQhlGxOw4aKUf035bgdO0bYR60VwjqJuC
	kBh9VdVCVt+RF6FJO8ObX6pwDWJqnmHcvrqmBdnE7ETp2zbD+TXXJFECrCqt4g0Q
	BddyZyfT0Xs5JgIsGSOzKIxKmjPl3nXWv30fM4SbVgLpj29AKnGx+Gz7bRIlzEl+
	yG7UDiyHzjD6rhOMXcOeZp6aMkCjM2hNhkBpySLcbSrqLo59oHh27C3K3O7dV4S+
	ew/YM5ZpzyE/ad6tlY+og8qBLZlVDleSjeBA25vZrWkw1IQFTNQYicmsHxum4I3w
	eT4fEE/zfIGZZ6VIVc+rwhJGHtGe93ujoWvBsT0Jvra/QlvJd81YQaqadcX0X3BA
	gsaLJV3tdfiereYCQG/acn5NvfvZEj1MDnofbamKcHcqCheAAK4nV3O4kurBB8d4
	FhTKt8Iy/BtkU9eeZFMFjHre41XVicR7anoPEn584rGcX97v+XPLldA1FcU5Lczo
	yDzFzxk=
Message-ID: <52b9e3f4-8dd4-4696-9a47-0dc4eb59c013@prolan.hu>
Date: Wed, 5 Jun 2024 16:47:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] net: include: mii: Refactor: Use BIT() for
 ADVERTISE_* bits
To: Vladimir Oltean <olteanv@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<trivial@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-1-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605121648.69779-2-csokas.bence@prolan.hu>
 <20240605141342.262wgddrf4xjbbeu@skbuf>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20240605141342.262wgddrf4xjbbeu@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627661

Hi!

On 6/5/24 16:13, Vladimir Oltean wrote:
> On Wed, Jun 05, 2024 at 02:16:49PM +0200, Csókás, Bence wrote:
>> Replace hex values with BIT() and GENMASK() for readability
>>
>> Cc: trivial@kernel.org
>>
>> Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
>> ---
> 
> You can't use BIT() and GENMASK() in headers exported to user space.
> 
> I mean you can, but the BIT() and GENMASK() macros themselves aren't
> exported to user space, and you would break any application which used
> values dependent on them.
> 

I thought the vDSO headers (which currently hold the definition for 
`BIT()`) *are* exported. Though `GENMASK()`, and the headers which would 
normally include vdso/bits.h, might not be... But then again, is 
uapi/linux/mii.h itself even exported? And if so, why aren't these 
macros? Is there any reason _not_ to export the entire linux/bits.h?

Bence


