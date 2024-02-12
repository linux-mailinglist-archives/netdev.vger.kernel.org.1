Return-Path: <netdev+bounces-71012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124F8519B3
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E7F285B4E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64773D3BC;
	Mon, 12 Feb 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ck6lAKQI"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324947A40
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755657; cv=none; b=nM9P/v1MoAo6jbR24uWrH2meCe8bfq67IjiCf/Yz++UiVHqTwC2V1Qzroi21FvwhDh+poceEgc914tkmuIaZ+KdxG0OYOHuowPAblv8QOCzfAX0mLFmo/sxXfONmoSucYd9/KfH4+HPS57fz1Muaop363Phxa0kEAhT8UEpaM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755657; c=relaxed/simple;
	bh=BxbxiX5Z4B4emBlTWSv1BLfOn/Bm4gDoRaY6VTeOBD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u9pB4xA4S+TOYSGFoh84dTNsO7/4LeH/Vq+Q87cWX6W0x0Q2aKs6FhkCzMhTdXVtFBmp78nEsch30obGFpWLEf7gnpR0sZnkEjYO6P1MotFChJ3ohUGJEn6L/caCHXm0QJVjzA1FMRKJDp043zsXKzwjWmb9mwo6sFI69/R2crk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ck6lAKQI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BB0C6A09B8;
	Mon, 12 Feb 2024 17:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=YBxjNHb5d/ogrH521rU/
	ba9e0xlX1ujGUZuTGdC5Y70=; b=Ck6lAKQIadQ/gAYyi06DwCvtu7coM8DHk/kx
	xviRJdXU+XE4y3aou8rH24QUYWn5YGA37Fz09hNYNTSEMrWJY7lopnVoSnes2bOv
	uawQM2tfs/4m0EKSbeFj34SrUpmYpZe7BbOk5MvOib9DQNwSkGEsRCYHM5WSKPGq
	cSleyJuYG3/BSlHVpn14O+//13MJnR2vRgraUs+JeBKo404vjNe/WF5AP8GbXIyi
	MX0IF23o8a043oAqdXrdAXJFSWDuMewxbgFCb6Zapd88PXurVeV5k6NTv9QJquV9
	DreR+6gLbWsQCK8+K09P20xA+xTDr0dNlGmBdAMn0sm+UyvGEJE/ICqSGfF8x750
	fdaaAw8R4pHkxxrE7Xqp7XY6ysAmqtbthDNaaxeEQZYC380PWSQcz6I6fazZ8qEi
	TkJN8pZRKEMk+2w0iDo4TXXEjmjKLgC+tBRszONT+cA3YmGQS5slj51148nri0pz
	ICvKwT/ih7sUWMAbPPRhExJ+jJhLEMDlMdUxT1uD4IE8ejTa7lX5QDnrfQut7dmj
	14Uamwp4O7Ycx8FHmnbW95UCCCBd+H18Vgacowhxbtwus9/voNNRHibj6wGa1QzP
	8YzcRsPSJ1rY1gCFiTXzKHM7TaYygUlVmGc2cAWDrC//hjpZX0wBfM1khbz5yCTb
	btjYyuQ=
Message-ID: <5a14a872-4d53-4804-b1ec-c60fcf438e09@prolan.hu>
Date: Mon, 12 Feb 2024 17:34:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
References: <20240209091100.5341-1-csokas.bence@prolan.hu>
 <2f855efe-e16f-4fcb-8992-b9f287d4bc22@lunn.ch>
 <a7b8df0b-fc24-441e-b735-7bf319608e99@prolan.hu>
 <cfc31be3-935d-432f-aa7a-38976c7ca954@lunn.ch>
 <41e96e5e-2184-4ac0-886f-2da18b726783@prolan.hu>
 <2880cd18-a0a8-473e-b21a-0dba043302ea@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2880cd18-a0a8-473e-b21a-0dba043302ea@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55617C60

2024. 02. 12. 17:03 keltezéssel, Andrew Lunn írta:
> On Mon, Feb 12, 2024 at 04:11:10PM +0100, Csókás Bence wrote:
>>
>>
>> 2024. 02. 12. 16:04 keltezéssel, Andrew Lunn írta:
>>> On Mon, Feb 12, 2024 at 03:49:42PM +0100, Csókás Bence wrote:
>>>> Hi!
>>>>
>>>> 2024. 02. 09. 14:53 keltezéssel, Andrew Lunn írta:
>>>>>> @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
>>>>>>     	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>>>>>>     	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>>>>>>     	     ndev->phydev && ndev->phydev->pause)) {
>>>>>> -		rcntl |= FEC_ENET_FCE;
>>>>>> +		rcntl |= FEC_RCR_FLOWCTL;
>>>>>
>>>>> This immediately stood out to me while looking at the diff. Its not
>>>>> obvious why this is correct. Looking back, i see you removed
>>>>> FEC_ENET_FCE, not renamed it.
>>>>
>>>> What do you mean? I replaced FEC_ENET_FCE with FEC_RCR_FLOWCTL, to make it
>>>> obvious that it represents a bit in RCR (or `rcntl` as it is called on this
>>>> line). How is that not "renaming" it?
>>>
>>> Going from FEC_NET_ to FEC_RCR_ in itself makes me ask questions. Was
>>> it wrong before? Is this actually a fix? Is it correct now, or is this
>>> a cut/paste typo? Looking at the rest of the patch there is no obvious
>>> answer. As i said, you deleted FEC_ENET_FCE, but there is no
>>> explanation why.
>>
>> The name `FEC_ENET_FCE` does not tell us that this is the FCE (Flow Control
>> Enable) bit (1 << 5) of the RCR (Receive Control Register). I added
>> FEC_RCR_* macros for all RCR bits, and I named BIT(5) FEC_RCR_FLOWCTL, a
>> much more descriptive name (in my opinion, at least).
> 
> Some form of that would be good in the commit message. It explains the
> 'Why?' of the change.

Ok. I split that change into a separate patch with a quick summary of 
this, in v4 of this patch. Hopefully it is more clear now.

>> So, a separate patch just for removing FEC_ENET_FCE and replacing all usages
>> with FEC_RCR_FLOWCTL? And the rest can stay as-is?
> 
> A few others made review comments as well. It could be addressing
> those comments also requires more small patches. Sometimes you can
> avoid review comments by thinking, what are reviewers going to ask,
> and putting the answer to those questions in the commit message. This
> might all seam like a lot of hassle now, but it will help getting your
> future patchsets merged if you follow this advice.
> 
>        Andrew

I believe I addressed all other comments already, but do enlighten me if 
that is not the case:
* removed the "fix FEC_ECR_EN1588 being cleared on link-down" half of 
the patch (v2) - your feedback
* removed `u32 ecntl` from `fec_stop()` (v3) - requested by Marc
* added net-next subject-prefix (v3) - suggested by Denis
* factored out the removal of FEC_ENET_FCE (v4) - your feedback

Did I miss something?

Bence


