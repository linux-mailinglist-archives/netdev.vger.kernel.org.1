Return-Path: <netdev+bounces-246738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F3BCF0CE7
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 745883000E98
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8B27FD56;
	Sun,  4 Jan 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pbhhV190"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEF27FB3E
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522590; cv=none; b=lgOMBfN7oHFq8JTpuyuUOYlhCL/zf6A5esSM2lPzF6oJj0R3vkPbmrPCA8r7soPuU8X/G0zRjV9EPGt23hGBZHmEsp4k2UpyvrzZmRf+y1rDMDN+KEhC6Os5r0yNHLO3xTM/GAGPoAW1XenBRE9ryImN3upPO57bMFbxM2mF20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522590; c=relaxed/simple;
	bh=Mvvit+d4BvijoMQKqR0H8HpTJFUH94G3hJg3sO9ScU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyUZgnTzU/9kA0xY1pIWh18iv91gOeavArPn5JJiY3ZgA8Eztj09ZdW4zLcDIa1xAdwZZa6Or5LpEHVJ68KdoFB2kc9q0g60xpE0uhPyWlPbLGRDtUrwPYqPhDpkRLJdw6LLOSWXrd1oxUAgijRPVOzLrLnDcGCimqgsJBaYXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pbhhV190; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1814efa2-0b4c-42a5-a18a-eca5638cdd43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767522576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OGZWrSK/pBZyPvguxbiLvLVKORor8gaxhxXKMup7zw=;
	b=pbhhV1905EQt9JEVAb1+D7LOOo/2UGmxJ3nRvamrlQZNFtu2Kl314pfwqXRKJW6gEZFSWw
	Z4LiNBz2zgBM+bpN4YfKbfMTRQfBZLD1zteV9yywb2W7MTI/nnIM02LqU2Q/DKt11lmZ46
	qSAncGxEYUxMMoEn+e47fddbx1rmjSc=
Date: Sun, 4 Jan 2026 10:29:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: mediatek: add null pointer check for hardware
 offloading
To: Andrew Lunn <andrew@lunn.ch>,
 Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>,
 Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
References: <20260103005008.438081-1-Sebastian.Wolf@pace-systems.de>
 <6491ccf8-0318-421e-ba44-1565875e374c@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <6491ccf8-0318-421e-ba44-1565875e374c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/01/2026 08:30, Andrew Lunn wrote:
> On Sat, Jan 03, 2026 at 01:50:08AM +0100, Sebastian Roland Wolf wrote:
>> From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
>>
>> Add a null pointer check to prevent kernel crashes when hardware
>> offloading is active on MediaTek devices.
>>
>> In some edge cases, the ethernet pointer or its associated netdev
>> element can be NULL. Checking these pointers before access is
>> mandatory to avoid segmentation faults and kernel oops.
> 
> Would it make sense to return EOPNOTSUPP, or maybe ENODEV? This does
> seem like an error case.

The if condition checks for single device only, while the code was added
with introduction of multiple PPEs. I believe we have to check multiple
devices from eth[], but the author may know better (CCed Elad Yifee)

> 
>       Andrew


