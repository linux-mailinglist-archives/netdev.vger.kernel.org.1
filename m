Return-Path: <netdev+bounces-209966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16FCB118DA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BA53AF282
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDCD29116E;
	Fri, 25 Jul 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CtlUW4ab"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883626B2D2;
	Fri, 25 Jul 2025 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427159; cv=none; b=ThsRR9+hnybr7jAMpxx8JGNVXCn+c3rYqjGM4H8x7f+tB+SNsr9Ou55lyf0/SKPAT5Ha+qN4gNzwxw9LVFzEuv3PF1lZN2hNI6POI00p4BteQbrZWOhq80n/ZhoPNQ7YM0dE8NSi5HQdLtMuxhgQJ6ZzuQ6ijuqb8OoUe8gu/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427159; c=relaxed/simple;
	bh=8hIMs3ZEOP3Z6QueK3O5hCjpoXAv8CcTKFQN2eyxiA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dwqo1DFsBVDnl5FxW8EPns0HTlVliltZclLmMrQIe2+naM49Dh/YjoA1PLZfegJoeeLkSrR2NOG1/4LZn3Q8pU5PBlgb2mOtOiE4FDGID3OewMYIMnA406olcZn0Vi34HkRto7WB/aD5aElAt4ZDYL1S7rkTKjtdV5B1S66lw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CtlUW4ab; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56P751ta2148376;
	Fri, 25 Jul 2025 02:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753427101;
	bh=5umDMOElVV8cL1bR0QgVIsqKX3kPBo5aB7b5JD6dzss=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CtlUW4abTvXwyfN9d75WseHjhD57Nq+m3x57auv7IM1Aj9SJHXIaD2nWajLw8Fccs
	 j8U/T0ohPlrJWUT4XcQ1pY3PsLMqwoJlwNAHIwA/cyfQG8LJECPU2R7KEJZm263Blq
	 RDJdSB+ujm8/Oko9lDsKQp/B2zOgYqJHiVJWKmH4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56P750WX3669322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 25 Jul 2025 02:05:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 25
 Jul 2025 02:05:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 25 Jul 2025 02:05:00 -0500
Received: from [172.24.21.105] (lt5cd151g4ty.dhcp.ti.com [172.24.21.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56P74sYO1371214;
	Fri, 25 Jul 2025 02:04:54 -0500
Message-ID: <d856807f-dead-4e93-bef6-0d25744cc041@ti.com>
Date: Fri, 25 Jul 2025 12:34:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
To: Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Fan Gong <gongfan1@huawei.com>, Lee Trager
	<lee@trager.us>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
 <81273487-a450-4b28-abcc-c97273ca7b32@lunn.ch>
 <b61181e5-0872-402c-b91b-3626302deaeb@ti.com>
 <0a002a5b-9f1a-4972-8e1c-fa9244cec180@lunn.ch>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <0a002a5b-9f1a-4972-8e1c-fa9244cec180@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 7/24/2025 10:07 PM, Andrew Lunn wrote:
>> Linux first send a rpmsg request with msg type = RPMSG_ETH_REQ_SHM_INFO
>> i.e. requesting for the shared memory info.
>>
>> Once firmware recieves this request it sends response with below fields,
>>
>> 	num_pkt_bufs, buff_slot_size, base_addr, tx_offset, rx_offset
>>
>> In the device tree, while reserving the shared memory for rpmsg_eth
>> driver, the base address and the size of the shared memory block is
>> mentioned. I have mentioned that in the documentation as well
> 
> If it is in device tree, why should Linux ask for the base address and
> length? That just seems like a source of errors, and added complexity.
> 
> In general, we just trust DT. It is a source of truth. So i would
> delete all this backwards and forwards and just use the values from
> DT. Just check the magic numbers are in place.
> 

Sure, I will not check the base_addr and trust the info we get from
device tree. Just check the offsets we are getting from firmware is
within the shared memory block or not (using base_addr + size)

>> The same `base_addr` is used by firmware for the shared memory. During
>> the rpmsg callback, firmware shares this `base_addr` and during
>> rpmsg_eth_validate_handshake() driver checks if the base_addr shared by
>> firmware is same as the one described in DT or not. Driver only proceeds
>> if it's same.
> 
> So there is a big assumption here. That both are sharing the same MMU,
> or maybe IOMMU. Or both CPUs have configured their MMU/IOMMU so that
> the pages appear at the same physical address. I think this is a
> problem, and the design should avoid anything which makes this
> assumptions. The data structures within the share memory should only
> refer to offsets from the base of the shared memory, not absolute
> values. Or an index into the table of buffers, 0..N.
> 

Sure I will try to do the same.

>>>> +2. **HEAD Pointer**:
>>>> +
>>>> +   - Tracks the start of the buffer for packet transmission or reception.
>>>> +   - Updated by the producer (host or remote processor) after writing a packet.
>>>
>>> Is this a pointer, or an offset from the base address? Pointers get
>>> messy when you have multiple address spaces involved. An offset is
>>> simpler to work with. Given that the buffers are fixed size, it could
>>> even be an index.
>>>
>>
>> Below are the structure definitions.
>>
>> struct rpmsg_eth_shared_mem {
>> 	struct rpmsg_eth_shm_index *head;
>> 	struct rpmsg_eth_shm_buf *buf;
>> 	struct rpmsg_eth_shm_index *tail;
>> } __packed;
>>
>> struct rpmsg_eth_shm_index {
>> 	u32 magic_num;
>> 	u32 index;
>> }  __packed;
> 
> So index is the index into the array of fixed size buffers. That is
> fine, it is not a pointer, so you don't need to worry about address
> spaces. However, head and tail are pointers, so for those you do need
> to worry about address spaces. But why do you even need them? Just put
> the indexes directly into rpmsg_eth_shared_mem. The four index values
> can be in the first few words of the shared memory, fixed offset from
> the beginning, KISS.
> 

Sure I will try to move everything to offsets and not use pointers.

> 	Andrew

-- 
Thanks and Regards,
Md Danish Anwar


