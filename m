Return-Path: <netdev+bounces-217619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E698B394C6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F506855A3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D52EB85E;
	Thu, 28 Aug 2025 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vrC87pxx"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E32ED141;
	Thu, 28 Aug 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364984; cv=none; b=r4l/HkptwptWXeBBsOfnRX/e4P5f3+66YjoNbUx5qYfZpsaOkZO9Vam+piNqohhjT5pWN34a0FQR3S5yklhHnvaoouF/QZZDwuBr8wt9uwqStYtw1vrNxGRchWC44WV28uHv+4eGmxPHTAKqM8U+Yj/0uHkSKnmHf+1zzL0O300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364984; c=relaxed/simple;
	bh=SPpp1RH7FHS64BgwJSfDV6et5//09GHoAwf6X9+I1DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Abz8pDUG0x7mzoN1Y83+ugiZPmTn5PcOAT0Yw0kH1TfyufHNNJxzOTC/NccwNdM2nyCup6MZnrzwmZz8/K9nzx5x7n7eezadUSVvgzsNhxUj4a2wZKeNo4LGLJYdPtXpBh5oAD6x79SfinmKrUpPP9cNriL7CPbW0E7QJVKhOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vrC87pxx; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S78ocR1469076;
	Thu, 28 Aug 2025 02:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756364930;
	bh=ihg1BqVIXwVeX9/5XhJYutDohKn1RcCO31Zmkb28TWc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vrC87pxxwnmX9RRUWlyB+u8ioWabgUci7PEOqwdSoGj0irRa8c/0JtiI+yVNgUh0/
	 YGX8K+ShW9zZVi0OUwNGG9g9F97Ihp5HHxTjRXl020k7MwXfY3/7F8uxDmb7IjyIf6
	 aXsl/3I7QOJ973cI8RD2HXZXzxo/Z+X6/B9++OAI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S78od32715100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 02:08:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 02:08:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 02:08:50 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S78hLu209555;
	Thu, 28 Aug 2025 02:08:44 -0500
Message-ID: <da2a0a37-8334-477a-8468-c4baebadf6df@ti.com>
Date: Thu, 28 Aug 2025 12:38:43 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for
 RPMSG-ETH Driver
To: Andrew Lunn <andrew@lunn.ch>
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
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <0a002a5b-9f1a-4972-8e1c-fa9244cec180@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 24/07/25 10:07 pm, Andrew Lunn wrote:
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

Sure. I will make this change in v2.

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

I will drop all these pointers and use a offset based approach in v2.

Thanks for the feedback.

-- 
Thanks and Regards,
Danish


