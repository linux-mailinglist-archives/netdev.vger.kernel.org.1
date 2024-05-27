Return-Path: <netdev+bounces-98130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1A8CF903
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9FD1C20A93
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F573184E;
	Mon, 27 May 2024 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M0M9pBS3"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019C1754B;
	Mon, 27 May 2024 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791043; cv=none; b=AKOiVmXPsmu1O1nSPpYtXwPXTNS4zf57oWBSJO12ijCjyP7771HLKe89AH7Y48eTdKudTezn9cncmGP4YK7jFq22mVY6A4vPS6pQBu+3+9Pi5CxclEFo34w3OeL4k7olgokftN2xs1NPe8yIaNCNhIBYk87p77o0iAxSFsEBF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791043; c=relaxed/simple;
	bh=8+YVxo2kGT6YpAa4xic3brKZrY19cfhQLO6PhDJglcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AlU8c5xdFiPi6strx2aGXIqLZCYpQ8IP6E+36qDzCYoaZ0zmN+bc0pxzZnL82/OjTljNa5DSCkDbk7ZYCtxc81tjH6MjP47y2BLGOFoOwStvZQB4azokQ9MrdrZjzCSoUCg3T/ILk9QITN6EoIt+sjOSu7sKJ98v5d9/avwns8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M0M9pBS3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44R6NXT8122156;
	Mon, 27 May 2024 01:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716791013;
	bh=R0qf3w3BxE32442q3LOylpbKUQUmq/Vu7B9arBC2fXs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=M0M9pBS3qv3asV/+Q0/tzFCAGgekMZ9xnqiI0KaW6pi5KUaVFdwBvzb2HWqUb5Ypa
	 XoCTwTlzoKhyBpkqso4JvUydbk2Uadh4pLGUDx+saQnCoHbi8l1zllZ7UtYARyozeq
	 uXZpbLtIZJI3/uJTGaKEQRK7AFZXackLBk5YYcpA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44R6NXTN031753
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 01:23:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 01:23:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 01:23:32 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44R6NSAn116043;
	Mon, 27 May 2024 01:23:28 -0500
Message-ID: <520c5c8a-06a8-4ca0-93b1-3203ae210733@ti.com>
Date: Mon, 27 May 2024 11:53:27 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix start counter for ft1
 filter
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Diogo Ivo <diogo.ivo@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240524093719.68353-1-danishanwar@ti.com>
 <bf1f7e35-45f9-4129-a41e-d255ad00c917@gmail.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <bf1f7e35-45f9-4129-a41e-d255ad00c917@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 25/05/24 3:35 am, Florian Fainelli wrote:
> On 5/24/24 02:37, MD Danish Anwar wrote:
>> The start counter for FT1 filter is wrongly set to 0 in the driver.
>> FT1 is used for source address violation (SAV) check and source address
>> starts at Byte 6 not Byte 0. Fix this by changing start counter to 6 in
>> icssg_ft1_set_mac_addr().
>>
>> Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and
>> classification APIs.")
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Would using ETH_ALEN not be a bit clearer here?
> 

Yes that would make more sense. I will change it and post v2.

>> ---
>>   drivers/net/ethernet/ti/icssg/icssg_classifier.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> index 79ba47bb3602..8dee737639b6 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> @@ -455,7 +455,7 @@ void icssg_ft1_set_mac_addr(struct regmap
>> *miig_rt, int slice, u8 *mac_addr)
>>   {
>>       const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
>>   -    rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
>> +    rx_class_ft1_set_start_len(miig_rt, slice, 6, 6);
>>       rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
>>       rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
>>       rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
>>
>> base-commit: 66ad4829ddd0b5540dc0b076ef2818e89c8f720e
> 

-- 
Thanks and Regards,
Danish

