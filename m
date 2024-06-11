Return-Path: <netdev+bounces-102618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F121F903F7D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9557C1F22248
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33B1BF53;
	Tue, 11 Jun 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="RS8balMM"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D12628D;
	Tue, 11 Jun 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118175; cv=none; b=HDUTSZ8YogVqAcpyLAFgVEwbgN+7WKrElbQ9EB32UjilxVPZmhk3FPW3JvuCNyA3DUWqHo2ZwoXnZ6R9qTilSSB8OrIixAwFBgmFL3rsstqI8xKhoRatFdoNvSfI4gP+TvhJsnH0uzb1FGxWBcHKooY9uFpvcJw/CbK5n4PCvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118175; c=relaxed/simple;
	bh=+UbdLhSNYQv78MjKDiWzxOsZG+Gz2YXkxyOtDXrPCgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TS+pME7pAa8p31efc1x4edesB4vP+4WwhyK32RMpt5W2KJGYMdslVvupACXshIz5KSKAes6cIPBitG2B9ZB087YSce4h3QBoKvmiJhTp22BaBJ7oUWG4sBDdNwImrnolazC0b3XCAcrpSzi7gsL6VWBcRRKn8eDX7VBFfipiG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=RS8balMM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 196CEA0A9B;
	Tue, 11 Jun 2024 17:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Lfl1G8RKSgEODerdsMc2
	QohfW3q4Aoax5ZnKXqVT58E=; b=RS8balMMGmSzN0u+cqYv75MBVl/svMTc1Tad
	t87iAPcyrWFhi8cb17oaKlqKpC6tSxzTIkWQy76IQnUS0rRcwPO+abI3Y5Fxg0a/
	ToLWg6O+/ADL09pY5h4sb+oVTZB3SZSgdZCr/mkW6TkMLJB+cxAZBoQHmyrrwKcg
	ghZbdja6ACrHy0obFeNwIq+cSXKWuXqh45c8MLe86hWtdV5bDCN+PebnNoJZGTU6
	Zf/UfeM9ju8z5hbIQgcuWxuge1M3i2CTOLYZP/vObxlnMxFPdbCRm3Bb9HA+tAec
	ji78BrgThbTx3IQBWcVmTN+hjM3e6UsSjjrsPSPMTDga8h35utErrahrtxSLfwpy
	tncXh8+SMXYoVaLAycdsYcd/CdF9sjkoHIqWtVFIiG3VlvZiPKFebSGHV359aUf8
	JelA6jRZOn87QnkoRnDEc15k1h8bsITDmmn7+NOXeS/9TYoP1plPfmNuM0mr7T1W
	JyGDbip/IU02oGgf/FVeVGigKGZTL+Y2CW21Fd2fl83KOOFCw2M9fYdD/D3BwnxR
	VvIW9ZexnVqhcSfaYOcb+dfl0VAg1dFGVRjw6/Y0yqk2AX0lnLixkw2pZOg/YwNh
	43j6L2i0MKGOqLbCptdANPFmpiVvJxTOtIpWNAxdiAxUof1c/ZnhsrD6H0jsyty/
	RbfZL7Y=
Message-ID: <7ce6bbf4-738b-4bd4-b842-7d3e97b57583@prolan.hu>
Date: Tue, 11 Jun 2024 17:02:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being
 cleared on link-down
To: Andrew Lunn <andrew@lunn.ch>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
 <46892275-619c-4dfb-9214-3bbb14b78093@lunn.ch>
 <d6d6c080-b001-4911-83bc-4aca7701cdff@prolan.hu>
 <c49a5e28-e030-4fc1-ab30-9afd997f03bc@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <c49a5e28-e030-4fc1-ab30-9afd997f03bc@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627C65

Hi!

On 6/11/24 15:06, Andrew Lunn wrote:
> On Tue, Jun 11, 2024 at 10:04:39AM +0200, Csókás Bence wrote:
>> Hi!
>>
>> On 6/10/24 21:13, Andrew Lunn wrote:
>>> On Fri, Jun 07, 2024 at 10:18:55AM +0200, Csókás, Bence wrote:
>>>> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
>>>> makes all 1588 functionality shut down on link-down. However, some
>>>> functionality needs to be retained (e.g. PPS) even without link.
>>>
>>> I don't know much about PPS. Could you point to some documentation,
>>> list email etc, which indicated PPS without link is expected to work.
>>>
>>> Please also Cc: Richard Cochran for changes like this.
>>>
>>> Thanks
>>> 	Andrew
>>
>> This is what Richard said two years ago on the now-reverted patch:
>>
>> Link: https://lore.kernel.org/netdev/YvRdTwRM4JBc5RuV@hoboy.vegasvil.org
> 
> Thanks.
> 
> So when you have sync, you have a 1Hz clock, synchronised to the grand
> master. When the link is down, or communication with the grand master
> is lost, you get a free running clock of around 1Hz. I presume that if
> the link does up again and communication to the grand master is
> restored, there is a phase shift in the 1Hz clock, and a frequency
> correction? The hardware has to cope with this.

Correct. And PTP4Linux is already capable of re-syncing (or at least it 
would be, if it weren't for the ENET controller reset. We still need to 
restore all the values of ATIME, ATCORR etc. registers, but that'll come 
in a future patch, when I figure out how to get out of the locking hell).

> Thanks
> 
> 	Andrew
> 

Bence


