Return-Path: <netdev+bounces-163378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFCA2A0D5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AF8164202
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6687FBA2;
	Thu,  6 Feb 2025 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SaO8TYF8"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D24C76;
	Thu,  6 Feb 2025 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822744; cv=none; b=p1OlxKKf8HW3pXmJkjgZkc+jNspIY95DEJ3bqpGaQYH4r1YVbCVORhEWoHE0ShnrScxtAl0pdhAe2cmgEN1WCdyWw2b+teYxPqeIo7COW4Y+uvoSaXmumRuWzeZbBnxPt2NdhI/soYFuaiMEaLzrjq16NBQUmzB/BriKmL1fNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822744; c=relaxed/simple;
	bh=65NOKSzb4RgUpAGuJG4ZIwRp90PqbEeynoqsVgo5Wdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aYC9c1XHSa0tC3IwgZPX3iDExwYaUA0GfKANEnFE3YcxU5zgsjKkT4LoQk5/sgXX0dDzradMTgn+XMnvyEnvD8HjdlieLNJdv7jC6bl4lKbhu5pWPEvLFhWBGY+Ok99TrRH5S1hQs3X32B55m90m7of65uaOwt1B2pL04N0gB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SaO8TYF8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5166IkEp3572168
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 00:18:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738822726;
	bh=y+B1tLhnx490D3c67MYqTu7vOV20MAOWuSnvm+C2xrE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SaO8TYF8dw7KezI6AbasZqvVO9ik5Ojoo/S/K4JnasBMhXn0SV3OcVEFZoenqDISU
	 jppkwGH9MC3C+k+EaZitviyVvU44qviahtGPaVf78JG+h6TCT2/eWjE/7jYngKAwA5
	 4gHjzhlIpg3l5WkMAhaOhvmTdiu+s+PDLdkzALSE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5166IkBQ018652
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Feb 2025 00:18:46 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 00:18:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 00:18:45 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5166IehD056873;
	Thu, 6 Feb 2025 00:18:41 -0600
Message-ID: <cecaf839-c203-43a5-aa11-f428ab0ba4c2@ti.com>
Date: Thu, 6 Feb 2025 11:48:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add support for Timesync Interrupt Router
To: Vignesh Raghavendra <vigneshr@ti.com>, Jason Reeder <jreeder@ti.com>,
        <nm@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thomas Gleixner
	<tglx@linutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <bbbcba04-3e31-4282-a383-fb4daa7c6de3@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <bbbcba04-3e31-4282-a383-fb4daa7c6de3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 06/02/25 10:43, Vignesh Raghavendra wrote:
> 
> 
> On 05/02/25 21:31, Chintan Vankar wrote:
>> Chintan Vankar (2):
>>    irqchip: ti-tsir: Add support for Timesync Interrupt Router
>>    net: ethernet: ti: am65-cpts: Add support to configure GenF signal for
>>      CPTS
>>
>>   drivers/irqchip/Kconfig             |   9 +++
>>   drivers/irqchip/Makefile            |   1 +
>>   drivers/irqchip/ti-timesync-intr.c  | 109 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/ti/am65-cpts.c |  21 ++++++
>>   4 files changed, 140 insertions(+)
>>   create mode 100644 drivers/irqchip/ti-timesync-intr.c
> 
> Where are the device-tree binding updates that need to go with
> individual driver changes?
> 


Hello Vignesh, This series is not specific to any use-case that Timesync
Interrupt Router is implementing. Through this RFC series I am expecting
a feedback on driver implementation so that later on we can make use of
this driver to implement certain functionality.

Regards,
Chintan.

