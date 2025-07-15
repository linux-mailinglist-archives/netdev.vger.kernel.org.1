Return-Path: <netdev+bounces-207000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883FB05267
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A31AA6C57
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88926D4C3;
	Tue, 15 Jul 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MKIN6RW9"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5025341AA;
	Tue, 15 Jul 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563289; cv=none; b=uyE/oEs+E+sC81BNN99BGTrUDaPO7XENELFIYIN/VOXNjWn9jbT9pMHL2+Rcdxdsz2JbKEufE0bNWZFA+UjjFgkjvXCreQ1928J1dPeYyX4s9wXmk5fpOi9sjzFCs5c9HzRXjcS91wkk/5++p84SlDSFWILmTx8fUGQWhMMcfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563289; c=relaxed/simple;
	bh=0oYUaB26Ux5s7e7mZbkOfOPdcsVu/1/Dfeg80QwEZrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VVxgSq8gEea02+KmPZ4a6vShsZp5b0eRtI8vAw+bOZfFmVkgBZBlgrZ2JikWA75HkK1SG+71EEYV90GtSRVM++baLT7gunVH9aAofZDqc1EgYwvOhvTDcDiEOTmsE5Anr6kTWLd6CRx3EfEu8PQiSyyjBbLykN7OPLtbory0844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MKIN6RW9; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F77pLI2835369;
	Tue, 15 Jul 2025 02:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752563271;
	bh=KQzkqrfUSvnBljERKPGdhvxyCebpfiP092MYdAIusq8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MKIN6RW9TRdeFPmiHw71lnX1kTy876Op/9t/NQFwPYM6UFFA9lnauRtaE9WngwFgr
	 7Hyi3/38a/CvPQiy9vcnhKl0HJh//xM37CuYPpH3CMVPcq6y58Wr476q+263x9AQgD
	 S2Aw7bC5lRugyLHJdS26wpyhp/4l7ZvrZKzJD7gU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F77pE04088945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 02:07:51 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 02:07:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 02:07:51 -0500
Received: from [172.24.29.51] (ltpw0g6zld.dhcp.ti.com [172.24.29.51])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F77kSv2459968;
	Tue, 15 Jul 2025 02:07:46 -0500
Message-ID: <b626dc40-e05b-40e0-b300-45ced82d2f97@ti.com>
Date: Tue, 15 Jul 2025 12:37:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
To: Simon Horman <horms@kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, <pratheesh@ti.com>, <prajith@ti.com>
References: <20250710131250.1294278-1-h-mittal1@ti.com>
 <20250711144323.GV721198@horms.kernel.org>
Content-Language: en-US
From: "MITTAL, HIMANSHU" <h-mittal1@ti.com>
In-Reply-To: <20250711144323.GV721198@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/11/2025 8:13 PM, Simon Horman wrote:
> On Thu, Jul 10, 2025 at 06:42:50PM +0530, Himanshu Mittal wrote:
>> Fixes overlapping buffer allocation for ICSSG peripheral
>> used for storing packets to be received/transmitted.
>> There are 3 buffers:
>> 1. Buffer for Locally Injected Packets
>> 2. Buffer for Forwarding Packets
>> 3. Buffer for Host Egress Packets
>>
>> In existing allocation buffers for 2. and 3. are overlapping causing packet
>> corruption.
>>
>> Packet corruption observations:
>> During tcp iperf testing, due to overlapping buffers the received ack
>> packet overwrites the packet to be transmitted. So, we see packets on wire
>> with the ack packet content inside the content of next TCP packet from
>> sender device.
>>
>> Details for AM64x switch mode:
>> -> Allocation by existing driver:
>> +---------+-------------------------------------------------------------+
>> |         |          SLICE 0             |          SLICE 1             |
>> |         +------+--------------+--------+------+--------------+--------+
>> |         | Slot | Base Address | Size   | Slot | Base Address | Size   |
>> |---------+------+--------------+--------+------+--------------+--------+
>> |         | 0    | 70000000     | 0x2000 | 0    | 70010000     | 0x2000 |
>> |         | 1    | 70002000     | 0x2000 | 1    | 70012000     | 0x2000 |
>> |         | 2    | 70004000     | 0x2000 | 2    | 70014000     | 0x2000 |
>> | FWD     | 3    | 70006000     | 0x2000 | 3    | 70016000     | 0x2000 |
>> | Buffers | 4    | 70008000     | 0x2000 | 4    | 70018000     | 0x2000 |
>> |         | 5    | 7000A000     | 0x2000 | 5    | 7001A000     | 0x2000 |
>> |         | 6    | 7000C000     | 0x2000 | 6    | 7001C000     | 0x2000 |
>> |         | 7    | 7000E000     | 0x2000 | 7    | 7001E000     | 0x2000 |
>> +---------+------+--------------+--------+------+--------------+--------+
>> |         | 8    | 70020000     | 0x1000 | 8    | 70028000     | 0x1000 |
>> |         | 9    | 70021000     | 0x1000 | 9    | 70029000     | 0x1000 |
>> |         | 10   | 70022000     | 0x1000 | 10   | 7002A000     | 0x1000 |
>> | Our     | 11   | 70023000     | 0x1000 | 11   | 7002B000     | 0x1000 |
>> | LI      | 12   | 00000000     | 0x0    | 12   | 00000000     | 0x0    |
>> | Buffers | 13   | 00000000     | 0x0    | 13   | 00000000     | 0x0    |
>> |         | 14   | 00000000     | 0x0    | 14   | 00000000     | 0x0    |
>> |         | 15   | 00000000     | 0x0    | 15   | 00000000     | 0x0    |
>> +---------+------+--------------+--------+------+--------------+--------+
>> |         | 16   | 70024000     | 0x1000 | 16   | 7002C000     | 0x1000 |
>> |         | 17   | 70025000     | 0x1000 | 17   | 7002D000     | 0x1000 |
>> |         | 18   | 70026000     | 0x1000 | 18   | 7002E000     | 0x1000 |
>> | Their   | 19   | 70027000     | 0x1000 | 19   | 7002F000     | 0x1000 |
>> | LI      | 20   | 00000000     | 0x0    | 20   | 00000000     | 0x0    |
>> | Buffers | 21   | 00000000     | 0x0    | 21   | 00000000     | 0x0    |
>> |         | 22   | 00000000     | 0x0    | 22   | 00000000     | 0x0    |
>> |         | 23   | 00000000     | 0x0    | 23   | 00000000     | 0x0    |
>> +---------+------+--------------+--------+------+--------------+--------+
>> --> here 16, 17, 18, 19 overlapping with below express buffer
>>
>> +-----+-----------------------------------------------+
>> |     |       SLICE 0       |        SLICE 1          |
>> |     +------------+----------+------------+----------+
>> |     | Start addr | End addr | Start addr | End addr |
>> +-----+------------+----------+------------+----------+
>> | EXP | 70024000   | 70028000 | 7002C000   | 70030000 | <-- Overlapping
> Thanks for the detailed explanation with these tables.
> It is very helpful. I follow both the existing and new mappings
> with their help. Except for one thing.
>
> It's not clear how EXP was set to the values on the line above.
> Probably I'm missing something very obvious.
> Could you help me out here?

The root cause for this issue is that, buffer configuration for Express 
Frames
in function: prueth_fw_offload_buffer_setup() is missing.


Details:
The driver implements two distinct buffer configuration functions that 
are invoked
based on the driver state and ICSSG firmware:- 
prueth_fw_offload_buffer_setup()
- prueth_emac_buffer_setup()

During initialization, the driver creates standard network interfaces 
(netdevs) and
configures buffers via prueth_emac_buffer_setup(). This function 
properly allocates
and configures all required memory regions including:
- LI buffers
- Express packet buffers
- Preemptible packet buffers

However, when the driver transitions to an offload mode (switch/HSR/PRP),
buffer reconfiguration is handled by prueth_fw_offload_buffer_setup().
This function does not reconfigure the buffer regions required for 
Express packets,
leading to incorrect buffer allocation.
>> | PRE | 70030000   | 70033800 | 70034000   | 70037800 |
>> +-----+------------+----------+------------+----------+
>>
>> +---------------------+----------+----------+
>> |                     | SLICE 0  |  SLICE 1 |
>> +---------------------+----------+----------+
>> | Default Drop Offset | 00000000 | 00000000 |     <-- Field not configured
>> +---------------------+----------+----------+
> ...

Thanks,
Himanshu


