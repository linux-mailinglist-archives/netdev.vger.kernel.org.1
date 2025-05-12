Return-Path: <netdev+bounces-189738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0076AB36CB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7AC1886C44
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599729345E;
	Mon, 12 May 2025 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wkwgEuwd"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2B8BFF
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052081; cv=none; b=fkfMtFv5bK+fLFc2hkNOYyKmvVYCXs/T4J+cDZQlXtJ+bajUpBPl1n5AqoCI+zZIMl/KMVyNe2aCNugnHtbw+c7Sjo6X8uiuK3pfpC7usTjFbMbd9FYdSkzhChs3mFhUeSCVwGfJI4ujEVIAHueeLj2/Bj8BLlwga3sggpfRLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052081; c=relaxed/simple;
	bh=9SGZxg3iu/1rk/YCA0UjZ+r4MNpQ2iWRRmUuKQDbPWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7d+LdiLijt8VfCFqgKvD8VNVQ8wKsXQNSDfM2aNdKVUndrlS/cUzywSvdqx0tH4ASZTHZruXRBWWV2fBK+hHXP0a0fLbuHMs44EJ0Oyv+vH2T/fWaDHSgocMmxITHj0RuRk+3fny324ISqB2v5OuPyn32lCP051FVe22ioDFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wkwgEuwd; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b9d9a5c-b647-4d56-ac04-d1c04a97bc30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747052075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIXcUY/fSCMcDvHSWI4IRhB/8040uy1a8GFVe9KfPlY=;
	b=wkwgEuwdgorTynaAGELwho4Dfk7DDSRlySUulcM0tru1JWDeHzdZsavuVSvUxhdFBpKb1p
	DuzHYHBPzx/9dz5LFKO0irWoBnjbjquskxzpTp6m+duI1eVbWWFkwDU0GTDOoDRiVO+ncd
	dnIvwibYdNaa6FidajdK11ZA1i6jrZo=
Date: Mon, 12 May 2025 13:14:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?K=C3=83=C2=B6ry_Maincent?=
 <kory.maincent@bootlin.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
 <dfb57a6c-8db7-4ab5-9d51-eec40cf8662e@linux.dev>
 <20250512120659.r7dmrugocat7ou3t@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250512120659.r7dmrugocat7ou3t@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/05/2025 13:06, Vladimir Oltean wrote:
> On Thu, May 08, 2025 at 11:45:48PM +0100, Vadim Fedorenko wrote:
>>> The remainder of eth_ioctl() is exactly equivalent to
>>> phy_do_ioctl_running(), so use that.
>>
>> One interesting fact is that phy_do_ioctl_running() will return -ENODEV
>> in case of !netif_running(netdev) while previous code would return
>> -EINVAL. Probably it's ok, but may be it's better to have consistent
>> error path for both options.
>>
>> Otherwise LGTM,
>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Thanks for the review. Indeed, I hadn't noticed the -EINVAL vs -ENODEV
> difference.
> 
> Are you suggesting that I first create a patch which replaces -EINVAL
> with -ENODEV in eth_ioctl(), so that ixp4xx_hwtstamp_get/set() is
> consistent with phy_do_ioctl_running() in returning -ENODEV?

The patch to net to make things consistent would be great, but no strong
opinion as there were no complains I believe.

