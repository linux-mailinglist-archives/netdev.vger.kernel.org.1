Return-Path: <netdev+bounces-70987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FB8517AD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D6B1F23350
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942863BB53;
	Mon, 12 Feb 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="o1tnB5uP"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC193C48D
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750678; cv=none; b=doHB3lC6avsQDFykBLxYIHjmHM8ZJIHviMrXV5kR0C443JLCfv1gUhZRuzNV/Hlmw4m+pXh+vAgxCHCD6Dhrz6DqES6880lCfOXWvXz4sLHOahs1KvFmrH9suvafjJVrcdMe0+qNgu1XakpF8vyIgHLx5cfZnLxw5PzuM/mC1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750678; c=relaxed/simple;
	bh=DtED3LEYTrY/sB71jOmpLk88xOg7XaDLsL0/8PIeafQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q+1HfIrPuVVCF1pifQ7LcHztmVlUtN4Pl76OVIAqwRGABF+G9UMlKmxQSNHFk264wha6/Kw/+Xx23ls+Gr5SoO30oseeJ5As3soIDWYEbb5n2gdsnY5dXWXir7zu9QMcgpfbnEREk20StyPozQCXXrbxvMDp5D6oVTsgduNeiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=o1tnB5uP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5F367A0790;
	Mon, 12 Feb 2024 16:11:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=GYsHxjsibvJGypMC58AP
	msz4w8CiEt0klaNyUyrpL0E=; b=o1tnB5uPuyT1eH91xpcvNTOldKATnG2ucCEi
	4ia6v62ZvoFGlE/1ChvZBa/DFfIyrwI94XD4Zp2nBn4QDN+3ZmaYX1kHJExFbqq4
	/T6/L7T2IaZqH+VQth36YhVaEX5dVTb8IOkCEILy33NJ/Etjn8vOi/DU71zFPE1x
	jop/tjo3v8qCbl91KKAhWtIi1UGWyIVBgXLOxOTtQNDoXD4G2LxzLnCSm+kNUahZ
	h9zvJgzWAPl2F+YwyIkHoKfNU6oYAXZEQtegsXyKpT0i5s0vqxP00xdeqo9LwV0Y
	8SgRAwAI6tYhAMU7ri64JYEptz7JwK4xssroeEOXBAViTCBkG9JwlQJA1VvPr32h
	JQXnh9HUQE3218JItq1M6SS1DnWiT4aSbpDhLcy1G2RUir46AltOp0etGIJr/eMg
	K1qwFd9TjoVdfjfIu3cGMp44DvT4byeI6QyVabxaRK+9lyLC8UM0nforFdOp8ii1
	TCZUSpKyHpYadsSLvW+k9DGdlv0VDKtf2mdy2ZjS4K1+SvdBUPK5yLywt/8hJXEp
	mrroDwU5JQgQo408BnZMChIceY7/onCjwXbgFcag96iuxHMXljqGEdNFauhjWPD4
	L6txYwHrQ8MC2glzjU4ZjpBVkiyhOFBNbaW+SjAeIDHoOadFvhpgQaWzE4TTlrUF
	YGp5gRU=
Message-ID: <41e96e5e-2184-4ac0-886f-2da18b726783@prolan.hu>
Date: Mon, 12 Feb 2024 16:11:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
Content-Language: en-US
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
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <cfc31be3-935d-432f-aa7a-38976c7ca954@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55617C60



2024. 02. 12. 16:04 keltezéssel, Andrew Lunn írta:
> On Mon, Feb 12, 2024 at 03:49:42PM +0100, Csókás Bence wrote:
>> Hi!
>>
>> 2024. 02. 09. 14:53 keltezéssel, Andrew Lunn írta:
>>>> @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
>>>>    	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>>>>    	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>>>>    	     ndev->phydev && ndev->phydev->pause)) {
>>>> -		rcntl |= FEC_ENET_FCE;
>>>> +		rcntl |= FEC_RCR_FLOWCTL;
>>>
>>> This immediately stood out to me while looking at the diff. Its not
>>> obvious why this is correct. Looking back, i see you removed
>>> FEC_ENET_FCE, not renamed it.
>>
>> What do you mean? I replaced FEC_ENET_FCE with FEC_RCR_FLOWCTL, to make it
>> obvious that it represents a bit in RCR (or `rcntl` as it is called on this
>> line). How is that not "renaming" it?
> 
> Going from FEC_NET_ to FEC_RCR_ in itself makes me ask questions. Was
> it wrong before? Is this actually a fix? Is it correct now, or is this
> a cut/paste typo? Looking at the rest of the patch there is no obvious
> answer. As i said, you deleted FEC_ENET_FCE, but there is no
> explanation why.

The name `FEC_ENET_FCE` does not tell us that this is the FCE (Flow 
Control Enable) bit (1 << 5) of the RCR (Receive Control Register). I 
added FEC_RCR_* macros for all RCR bits, and I named BIT(5) 
FEC_RCR_FLOWCTL, a much more descriptive name (in my opinion, at least).

> So what i'm asking for is obviously correct patches. You can add the
> #defines, and replace (1 << X) with one of the new macros, and it
> should be obvious.

I replaced `#define FEC_ENET_FCE (1 << 5)` with `#define FEC_RCR_FLOWCTL 
         BIT(5)`. I thought that was "obviously correct", but I can 
break the patch up more, if it helps readability.

> However, the change above is not obviously correct, so some
> explanation is required. And it is easier to do that in a patch
> dedicated to this change, with a good explanation.

So, a separate patch just for removing FEC_ENET_FCE and replacing all 
usages with FEC_RCR_FLOWCTL? And the rest can stay as-is?

> 
> 	Andrew
> 

Bence


