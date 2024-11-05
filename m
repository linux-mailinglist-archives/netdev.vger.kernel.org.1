Return-Path: <netdev+bounces-141949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3F9BCC46
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0636E28381F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577901D433C;
	Tue,  5 Nov 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YJcOmrSq"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301271420A8;
	Tue,  5 Nov 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808120; cv=none; b=msDuWli4yz0goDUnuxUlA4czdhlufQgAG/TNVArhrysGodX1t0vGR24wqkvvmxdhuOqNK523TT697+soFIbjnZ8dhsSSLxxboZMlLggXTzS2wRMLrUqWaYDiWuUn7vL56zVeawck1iZCW1do68OebG6JaWFy9+xRzNRA0bqqf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808120; c=relaxed/simple;
	bh=TX6sX6x1up/HYFMnp1EPSdB0aCTeIScsn4RhiXQgfc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RHJKVFr6Wih3AlvYwcaZB99KpLyg57CtqO9HEvxKWzRD+oswNMaGZwgclYcRDuKvKK7Ct0LoxcMqLSEQs4+8eVEGi0pKGw0yi6AhyB2Q501dOtQDoLF0dm/HqwkhbY6O6KE798rK/OKxZ6r9dnLCiMsmzCMgrfK/2HYlxA+V6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YJcOmrSq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A5C1KxR073177;
	Tue, 5 Nov 2024 06:01:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730808080;
	bh=I8Ot+L92FMNzAT/dVawQMY/gWiO3L4DG4uE/gA9uMU4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YJcOmrSqnbVxJv3RZnS+O4a2zYBk1oirNEMArSbhYG+TopXlv7wUrfxEt2RI6JGKx
	 OfLuH6P6fQ61TMuaGeuytiWNFJV0jOQlE1FZ7DlIwOgeUhcjacN1VKLJDl+AcI3rIB
	 mEhgAIeNhybc3XEWtCGMyuTG/e6n3xW8GjFhIpvQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A5C1KA1076249
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Nov 2024 06:01:20 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Nov 2024 06:01:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Nov 2024 06:01:20 -0600
Received: from [10.249.139.24] ([10.249.139.24])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A5C1DuV010566;
	Tue, 5 Nov 2024 06:01:14 -0600
Message-ID: <e5c5c9ba-fca1-4fa3-a416-1fc972ebd258@ti.com>
Date: Tue, 5 Nov 2024 17:31:13 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix 1 PPS sync
To: Jakub Kicinski <kuba@kernel.org>
CC: <vigneshr@ti.com>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
References: <20241028111051.1546143-1-m-malladi@ti.com>
 <20241031185905.610c982f@kernel.org>
 <7c3318f4-a2d4-4cbf-8a93-33c6a8afd6c4@ti.com>
 <20241104185031.0c843951@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20241104185031.0c843951@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/5/2024 8:20 AM, Jakub Kicinski wrote:
> On Mon, 4 Nov 2024 16:55:46 +0530 Malladi, Meghana wrote:
>> On 11/1/2024 7:29 AM, Jakub Kicinski wrote:
>>> On Mon, 28 Oct 2024 16:40:52 +0530 Meghana Malladi wrote:
>>>> The first PPS latch time needs to be calculated by the driver
>>>> (in rounded off seconds) and configured as the start time
>>>> offset for the cycle. After synchronizing two PTP clocks
>>>> running as master/slave, missing this would cause master
>>>> and slave to start immediately with some milliseconds
>>>> drift which causes the PPS signal to never synchronize with
>>>> the PTP master.
>>>
>>> You're reading a 64b value in chunks, is it not possible that it'd wrap
>>> in between reads? This can be usually detected by reading high twice and
>>> making sure it didn't change.
>>>
>>> Please fix or explain in the commit message why this is not a problem..
>> Yes I agree that there might be a wrap if the read isn't atomic. As
>> suggested by Andrew I am currently not using custom read where I can
>> implement the logic you suggested
> 
> Right but I think Andrew was commenting on a patch which contained pure
> re-implementation of read low / hi with no extra bells or whistles.
> 
>> (reading high twice and making sure if
>> didn't change). Can you share me some references where this logic is
>> implemented in the kernel, so I can directly use that instead of writing
>> custom functions.
> 
> I think you need to write a custom one. Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/meta/fbnic/fbnic_time.c#n40
Ok thank you. I will add custom function for this and update the patch.

