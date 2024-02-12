Return-Path: <netdev+bounces-70980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64F85174A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE251F2147A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129D3B780;
	Mon, 12 Feb 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="aByGKPNq"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662063B2A2
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749398; cv=none; b=KUcnIQl2gjFo0Ky29ZENGGpmLb1EBOwemCaAzIjpmDfq797WIOCAR9e4Eqv15+D2UsyBgw+HbT6MMsue2TMtICIT+B/yA6dp4PMorEzmW8mjCq+S3AdCKjifXnmx+hV8at9CKJjhnzx/OdHtQIV5bnAf3hxkqlfKYykRr2Txdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749398; c=relaxed/simple;
	bh=98kZm8Ik0qq5Lsryek3aPFX0tvN2TqXrdoU8kZa8zH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WobztTmwtfOc/kRtAPXL6hqwNXcv1U5eUvalN/bGfokXvW1Po74gDQ20JgkCpSuYE6Y+xqVBS1O3/d3MGyzocMEhzVFklT1Xrd6xr7BO28h2woxEzoeKy3uUcdauqBWFsL26PFsbpUwwLYc6dpDqmWcO+2EdpLDeDwjEw29OtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=aByGKPNq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AFB2EA00A5;
	Mon, 12 Feb 2024 15:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=QDKHzOkjMss5TdpeiTno
	I+XqBAmapF1gtF7LQe2sNBA=; b=aByGKPNquqxEHoZ2YX4o2mssPwA5KWoU2DW3
	5Mf4JNh8xpP7586IVq6Hy+dnc2RgQnRj1gaQ+sGOCJVY4eXzMn5+FVo+uXGmCBa4
	V8rEnwfG88T/DnVAD6YY2uye8gDrQc4tazZTJwwAfQPVbDPen1DbRH3mlLr45Xub
	U4JyQWGxT92Kz+rKrqdt123jm6x9D70egEugNZIGttydN2DOVx0dEMHIZpSLkiWc
	CSYNcUQLElcrxldxyR5wNn9qxnQMcBf/ekKuvdeQbTumIfOJzObEf6fZIjWhO5nz
	7aIx3MeJqk2tq8mEaY1mKIuADzuzLOLr5BH4YLNzQ+1Y0E/pYLACDm7YvvydcPVr
	schJFvL3xTYHmdVArLwopAm0hABcix8mdvM2pdOW8Tk7fH/ezUcYERMz2CW1sSsN
	qthcteJ9laNlS7rQBNlPh4bQuDcav+ekToNtE0LWN06iQJVAQ3f14klomRR4M8as
	c4C28rzbK4FTcuvf0hRsKn4nirPNXpBGn1YzHlGPoVY1UX5SN+bqLfEZuY5pf/pU
	o3EMDN1QtKZZ7m1iZeE/U5whYPyroAeAiMy2QtvZ3Uy9CoovfOaLxbFmD4xGoYiO
	lWFQRu6rQZyZ+jk7DTX8X4fyq27kwdCSd2UUSSY6mgg+su9rxSr6/X7B7XrZzlSR
	BE9CtI4=
Message-ID: <a7b8df0b-fc24-441e-b735-7bf319608e99@prolan.hu>
Date: Mon, 12 Feb 2024 15:49:42 +0100
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
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2f855efe-e16f-4fcb-8992-b9f287d4bc22@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55617C60

Hi!

2024. 02. 09. 14:53 keltezéssel, Andrew Lunn írta:
>> @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
>>   	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>>   	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>>   	     ndev->phydev && ndev->phydev->pause)) {
>> -		rcntl |= FEC_ENET_FCE;
>> +		rcntl |= FEC_RCR_FLOWCTL;
> 
> This immediately stood out to me while looking at the diff. Its not
> obvious why this is correct. Looking back, i see you removed
> FEC_ENET_FCE, not renamed it.

What do you mean? I replaced FEC_ENET_FCE with FEC_RCR_FLOWCTL, to make 
it obvious that it represents a bit in RCR (or `rcntl` as it is called 
on this line). How is that not "renaming" it?

> Ideally, you want lots of small patches which are obviously correct.
> This change is not obvious, there is no explanation in the commit
> message etc.
> 
> Please keep this patch about straight, obvious, replacement of bit
> shifts with macros.

So, how should I break it up then? One patch for the ECR bits, one for 
RCR, one for TX watermark register, one for RACC? Or one commit 
introducing the constants, and another replacing usages with these?

> Do all other changes in additional patches. It is much easier to
> review then, both by you before you post, and us when it hits the
> list.
> 
>         Andrew
> 

Thanks,
Bence


