Return-Path: <netdev+bounces-100092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6727D8D7D1B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9820B1C20FBB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D308741C76;
	Mon,  3 Jun 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T3TJ2Ds5"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC6B3209;
	Mon,  3 Jun 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402543; cv=none; b=QaIkv9s/XQ8gxWjFU3qAmiX7ikugrzwMQNSrfidGNgkg0wrGpWgP+Yqq0fBwlBXIJwKYHN231PTowfTRUCn5mSpd/zwt1bPwTm4kgH10HRIMLgM0L3yAuEekLw9r0+xC/aAOMMB1BAubqKMoz8HiJRynPh5P4QY04BEKBDsS6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402543; c=relaxed/simple;
	bh=1eCTuiou3HfcQnMc21I72HS3WKJE0285PhpncV0zcBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sO1mB/2uhw5RlAxP2T8lxSCrx0t4Y5HGleSEn9TyJ2Bwhbrd5TtC8t+u4uD7Su+ecl33ebMz2FBCrBl2jkx72QSBUWOL8w1Q8cq5IW+0hIoiH4Yyha5ca3u8MHc1n+HBcBnaQwMJ8ukNqbFm+OLxu0eP9E/7me92lREv9K9kxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T3TJ2Ds5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4538F2Re078821;
	Mon, 3 Jun 2024 03:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717402502;
	bh=cuyAjV2HDIfTM5xAajcR3acONEE4m9KGW7HlevF+gfQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=T3TJ2Ds5C1J7kH43IYAD2y4MCdcLDB9BduJ3s/Be5V3x8dQyqnsZtyqyW6Lp33NMG
	 D83t9Q/jGL6LQerJh6kqCRm7SuY60fL0eBSMF3jA+x8s56RM0zaLsMnUBqiliewAZd
	 WXf7C+Py3PSU7ddZo/M5GDJoDV/uaRtUSi3hd19M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4538F1MG009107
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 03:15:02 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 03:15:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 03:15:01 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4538EsDi071578;
	Mon, 3 Jun 2024 03:14:55 -0500
Message-ID: <b4256b15-997d-4e10-a6a9-a1b41011c867@ti.com>
Date: Mon, 3 Jun 2024 13:44:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "ERROR: modpost: "icssg_queue_pop" [...] undefined" on arm64
Content-Language: en-US
To: Thorsten Leemhuis <linux@leemhuis.info>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240528113734.379422-1-danishanwar@ti.com>
 <20240528113734.379422-2-danishanwar@ti.com>
 <de980a49-b802-417a-a57e-2c47f67b08e4@leemhuis.info>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <de980a49-b802-417a-a57e-2c47f67b08e4@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Thorsten,

On 03/06/24 12:39 pm, Thorsten Leemhuis wrote:
> On 28.05.24 13:37, MD Danish Anwar wrote:
>> Introduce helper functions to configure firmware FDB tables, VLAN tables
>> and Port VLAN ID settings to aid adding Switch mode support.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Hi! Since Friday I get a compile error in my -next builds for Fedora:
> 
> ERROR: modpost: "icssg_queue_push"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> ERROR: modpost: "icssg_queue_pop"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> 

Before posting the patches I had tested them with defconfig and I didn't
see any ERRORs.

I think in the config that you are using most probably
CONFIG_TI_ICSSG_PRUETH_SR1 is enabled. The patch adds APIs in
icssg_config.c which uses APIs added in icssg_qeueus.c.

Now CONFIG_TI_ICSSG_PRUETH_SR1 also uses icssg_config.c but
icssg_queues.c is not built for SR1 as a result this error is coming.

Fix for this will be to build icssg_queues as well for SR1 driver.

I will test the fix and post it to net-next soon.

> Looks like this problem was found and reported mid May by the kernel
> test robot already, which identified a earlier version of the patch I'm
> replying to to be the cause:
> https://lore.kernel.org/all/202405182038.ncf1mL7Z-lkp@intel.com/
> 
> That and the fact that the patch showed up in -next on Friday makes me
> assume that my problem is caused by this change as well as well. A build
> log can be found here:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-39-aarch64/07523690-next-next-all/builder-live.log.gz
> 
> I don't have the .config at hand, but can provide it when needed.
> 

Yes that would be helpful. If possible just check in the .config what
symbols are enabled related to ICSS. (`cat .config | grep ICSS`)

> Ciao, Thorsten
> 
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_config.c | 170 +++++++++++++++++++
>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  19 +++
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  12 ++
>>  3 files changed, 201 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index 15f2235bf90f..2213374d4d45 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -477,3 +477,173 @@ void icssg_config_set_speed(struct prueth_emac *emac)
>>  

[...]


-- 
Thanks and Regards,
Danish

