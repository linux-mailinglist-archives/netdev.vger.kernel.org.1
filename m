Return-Path: <netdev+bounces-141517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036669BB356
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC63A284FC8
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3041B0F26;
	Mon,  4 Nov 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OOQDsTLK"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA961AF0A6;
	Mon,  4 Nov 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719579; cv=none; b=j5/4MU7+yz1ym/NClMN7Nm8RKgcm6D7TLFR+PNLLRcRk7CgQBuBbOrJbiFYSbY/oKrbDmEpn3I4BPM2KbzAkCgZqUIEGaNX8J7SpsSI/2pM6UonehVjcRrFfuDKQXa7QhvqSZbgJbDYwBNahXTkDbIOVlGyywYqtkLU75Gbde2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719579; c=relaxed/simple;
	bh=L7u8TSr3hsUVl5lbJJeYekyvk5tXBYjfFui3QFFAxXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uMakVXpQBHxVK9AC+F7L6yWdlVkodjobTSuXsIDg0MUOAwhINkI6yQmbrnSA4BPw+XfvVIST2EShMdHeoVtP/dhzP+gv6P01k4jFSc+lvHJVZIEQlnWD7Fle8fb5WG+3daCIuZ7XZ5/2FcAvNGs/+IQMe13HFuAXu4AvRo6az48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OOQDsTLK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A4BPq8f093248;
	Mon, 4 Nov 2024 05:25:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730719553;
	bh=8lCZg7hiaSBMwhl2ZVyK4acZDVshxBaN2CgueTXDG1A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OOQDsTLKapMaRRAeD7RUmMELnmCCHYSMumW68hUPhZxX2zSeSjccYHOZQPUATj8Rf
	 HIZjveUwV4hCmk5WA6iGLvqSb9MHWLrAdE7yByiAfsg5dojK0cHMNsXznECXV2SqxF
	 mquhJziAPs1Sph8dmPnV0I/ivn06gjT04wz92nGU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A4BPq8K020829;
	Mon, 4 Nov 2024 05:25:52 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Nov 2024 05:25:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Nov 2024 05:25:52 -0600
Received: from [10.249.139.24] ([10.249.139.24])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A4BPk51046583;
	Mon, 4 Nov 2024 05:25:47 -0600
Message-ID: <7c3318f4-a2d4-4cbf-8a93-33c6a8afd6c4@ti.com>
Date: Mon, 4 Nov 2024 16:55:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix 1 PPS sync
To: Jakub Kicinski <kuba@kernel.org>
CC: <vigneshr@ti.com>, <grygorii.strashko@ti.com>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
References: <20241028111051.1546143-1-m-malladi@ti.com>
 <20241031185905.610c982f@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20241031185905.610c982f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/1/2024 7:29 AM, Jakub Kicinski wrote:
> On Mon, 28 Oct 2024 16:40:52 +0530 Meghana Malladi wrote:
>> The first PPS latch time needs to be calculated by the driver
>> (in rounded off seconds) and configured as the start time
>> offset for the cycle. After synchronizing two PTP clocks
>> running as master/slave, missing this would cause master
>> and slave to start immediately with some milliseconds
>> drift which causes the PPS signal to never synchronize with
>> the PTP master.
> 
> You're reading a 64b value in chunks, is it not possible that it'd wrap
> in between reads? This can be usually detected by reading high twice and
> making sure it didn't change.
> 
> Please fix or explain in the commit message why this is not a problem..
Yes I agree that there might be a wrap if the read isn't atomic. As 
suggested by Andrew I am currently not using custom read where I can 
implement the logic you suggested (reading high twice and making sure if 
didn't change). Can you share me some references where this logic is 
implemented in the kernel, so I can directly use that instead of writing 
custom functions.

Regards,
Meghana.


