Return-Path: <netdev+bounces-103498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758590858C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818381C2211A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18532157A43;
	Fri, 14 Jun 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="NVpPFKIm"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8C183091;
	Fri, 14 Jun 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351968; cv=none; b=M/hHx4Q5P3/L+rZLcC7DUel7I1RU/dZoG8GSi1Z/CZHLvrjm9D84OqPVZbFYPXE0hFRpJKB2ab8XlDXNngZj6d3f2dvrLcHR+nfw5Y01mL+PDdgc4cSawIr7vQqVpwOum4FKeAyXOOuGrqT37D3/Q+DiLCazdMTGfwV/4SoZWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351968; c=relaxed/simple;
	bh=WLsQLfSBgdrbdcbL23bGEE1GXt0r8cyRHZPC0kRFL0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZA/dlE74pLPC46v4Tu7do5vGGNDuMurJ6L2iCFfr4nv93WSiL3K+tzaBmaKmspd2PQqFAT0RdiCgWXA4zq/EHR06zMAMpHo582/SzIx2pTz5AD4M6gXPH0iSUPtoOJ7jTrBdNi9UeNchQvyaEdlXPZQT3Jbi8o2oA+SSmq8jtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=NVpPFKIm; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5B1F0A0B23;
	Fri, 14 Jun 2024 09:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=X48ANnpZpKQn6FVdiODA
	epUqBqw7Ho8W5zl8HyAQNVc=; b=NVpPFKImG4zlvpc1bIohpS/M7Xqwa8TSwhOw
	gNVjxwUFXZ47igNHo3g9dBEKYZvfJ0FFAHVsIv0UNEl3SKcnj6FMh7l5AzC/z9Yj
	PWyEnh6AhgOpUQFB1PxzQmmn1GMulv0Dp+6gA1hp+HCnutYaiAIHiKhJCHPZq/da
	Vac1yBJexCezUxn5Zfnp/WBVzH4/nRc17FzNfZZ6CFjKJa9ss2I2bKG54V2QCtO7
	bQ6Hvj7J5t3eRy1oMcw2JGOOmsPMFlsMHMb/ax4qB8l315qwz5ej6TN2n58LmunO
	jBrpuepeu3kpPMbTHmCxyVyUB83lRgu5rpGIRMNa1oaLASg2+pJfJ+EVQgAIB/ov
	CPhGrb5BpQnK/8awvkLPoxyy3DixzcKMgpvB3CRguL9WPAsMEzDlcRfnAGUXBREK
	NzOIrYuWfZy1WD498MizZUCRZXsjBL7wdySb270PGa4yrARS1zjJ2y/+7ZzYlyCV
	EGvWm+0XppGCTObxgVEOBKaDkJrKgkDNjJJ8s8pcYPop2e27sI8oKyJyKtcifY3+
	XNJhFPjWy9HWyiF4UuJl4IvmgnkYROKYZ0XUUQjGk52J9Sk7FupsLhkouE/9DQFg
	6YwL4E8anHC7CioF2OF5AxSua96H39aBNC8dLmTIQgpJl5Tko+qp97tdqDZUdgns
	nl0+MoM=
Message-ID: <0f315501-e8cb-4904-8c43-d9721fdef846@prolan.hu>
Date: Fri, 14 Jun 2024 09:59:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resubmit 2] net: fec: Fix FEC_ECR_EN1588 being cleared on
 link-down
To: Jakub Kicinski <kuba@kernel.org>
CC: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>
References: <20240611080405.673431-1-csokas.bence@prolan.hu>
 <20240613081233.6ff570cd@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20240613081233.6ff570cd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576D776B

On 6/13/24 17:12, Jakub Kicinski wrote:
> On Tue, 11 Jun 2024 10:04:05 +0200 Csókás, Bence wrote:
>> +	if (fep->bufdesc_ex) {
>> +		val = readl(fep->hwp + FEC_ECNTRL);
>> +		val |= FEC_ECR_EN1588;
>> +		writel(val, fep->hwp + FEC_ECNTRL);
> 
> FEC_ECNTRL gets written multiple times in this function,
> including with 0, and then you RMW it to add this flag.
> 
> Is this intentional? It really seems like you should be
> adding this flag more consistently or making sure its
> not cleared, rather than appending "add it back" at the
> end of the function...

It only writes 0 if WOL is disabled AND the device has the MULTI_QUEUES 
quirk. Otherwise, we either write FEC_ECR_RESET, which resets the device 
(and the HW changes ECNTRL to its reset value), OR we RMW set the WOL 
sleep bits. And then, if some more quirks are set, we set ETHEREN.

So I think RMW is the safest route here, instead of trying to keep track 
of all these different branches, re-read ECNTRL after reset etc.

Bence


