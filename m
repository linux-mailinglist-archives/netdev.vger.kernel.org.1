Return-Path: <netdev+bounces-229191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E5BD90EA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909171925800
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12F30C61D;
	Tue, 14 Oct 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nr04E4ei"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48730BF6B
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441616; cv=none; b=u3wnhq2gIk/NTqi8H+KYCF0DvOdm9C6YxRhTPE6wdloVQEXJzj/5IBjpYfnEggcDVqyS+fsoFgAWCIJZ8GAFgOpcNl/K2gWkBCmcDsf8u8kXgxOfWJDt9pHAstL12u2pZekw5o0WC3nLs2vJW9JC28qAhDLL1gXIWgrzExu/00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441616; c=relaxed/simple;
	bh=EOiBoMq8sLGDd3lfmeBPzgdelZvp0tOnl2eG6FrkpzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/PhxikDTpMNpjdEOQTX0fbQZgPfJooK8m+eNR92VVhpa2Dd/J5ddjEdHupnEj1CYL+AcaWCQcbI//+/GBPtb6EsfvEIJDx8cpMiiLp6Ebmufxv8SZDK96xyOc6tIo2Cl7NzhZy6PBBQhE3lZWdux2yXSo4MFAEGDR9BfkqrIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nr04E4ei; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb93e416-1a6c-4c3c-9621-03deb8bc34aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760441602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCxzBWmpERGaNbcd7P2dfHjWYxDzYzg8wdZKfHQFXKQ=;
	b=nr04E4eiX7LIJzoKhkxJrfJGLTm++4OCq7ELggnOG2SHf1meAouxCgrl1KwLUuQ3ypmAA6
	aNWjBAcNdJZJTWp2QowDUrCpem+qdcVfQ9IN/yz/i3mtm3zZKVqHpWd6CbMHoEVjT42Tcb
	mOI8X88kDZHGVQsLROdUsk62sp0+n0Q=
Date: Tue, 14 Oct 2025 12:33:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 13/14] net: hns3: add hwtstamp_get/hwtstamp_set
 ops
To: Simon Horman <horms@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Igor Russkikh <irusskikh@marvell.com>, Egor Pomozov <epomozov@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Brett Creeley <brett.creeley@amd.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20251013163749.5047-1-vadim.fedorenko@linux.dev>
 <20251013163749.5047-8-vadim.fedorenko@linux.dev>
 <aO4zdkFjMlv5trhB@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aO4zdkFjMlv5trhB@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/10/2025 12:26, Simon Horman wrote:
> On Mon, Oct 13, 2025 at 04:37:48PM +0000, Vadim Fedorenko wrote:
>> And .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks to HNS3 framework
>> to support HW timestamp configuration via netlink.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Hi Vadim,
> 
> This patch adds warnings about the functions it adds being unused.
> 
> I would suggest addressing this by simply squashing this and the following
> patch, which uses these new functions, into one patch. I think the
> resulting patch would still be small, internally consistent, and easy
> enough to review.
> 

Hi Simon!

Thanks for the review. I was thinking about it while writing the code,
but thought it would be clearer to have it split. Apparently, I forgot
about warnings in this case, which is definitely an issue here.
Thanks for flagging, I'll merge these 2 patches in the next version.


