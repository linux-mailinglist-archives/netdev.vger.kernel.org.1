Return-Path: <netdev+bounces-103528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0B908719
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BD21F233F6
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5418C32B;
	Fri, 14 Jun 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eNBypqnE"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B018FDA0;
	Fri, 14 Jun 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356145; cv=none; b=HPUlMu9nZBiHKw0aTVeHyOMgV8AVeclE1LHY2UZcm0EIYugMFmkqiK2ky6QwhKr360n6ysDCxjGcxFTaweZo1F/8I0UDOyMfQaboaXKyhYnswzzinUg1PDVR7/+Wz6fg3bd+zaRFIWs9JsK8S4MT+FK0afJ9byGLmr1pRfMcOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356145; c=relaxed/simple;
	bh=300Ghz6NYmdB4lPInOyCX3ALeLqsytBDX+8juht/XBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h29b/Gw5luijOsDmgkPGjl1DVomthuQzWex97XcBgECShSTDXWvjf/vxK8uYDSWldlYWE1jfJkbXCYcwmQt52FO4xgSAuQsvdlHgkHNiKaylrjk9OnQzvFkH/ZRmyp4cxwSPgucxvmTs/CjEZ3pYG652cjnjONNw8WutGmhCwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eNBypqnE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E98Vaj072850;
	Fri, 14 Jun 2024 04:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718356111;
	bh=1X/gFKINVApjWSbUv0b70B/C3Us7zSQW86S+HUnm898=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=eNBypqnE6DwnxCcyepFYbbogWcL+LMo5kJKl5HEouXZtQbfj+7AZDDlwuZ6DNejgv
	 WDHXRuUhyxIRqlyZ1XO1saZoEQuEOfY4HFlXUx0yLTy3tYBYWWohnGzJQLn+YtecWb
	 M4rbMVKStRgMrfuSrA+rTBDWPqybymh3CaTezRNQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E98VC4020605
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 04:08:31 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 04:08:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 04:08:30 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E98P58090352;
	Fri, 14 Jun 2024 04:08:25 -0500
Message-ID: <60bc57a7-732b-4dcb-ae72-158639a635c0@ti.com>
Date: Fri, 14 Jun 2024 14:38:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
To: Andrew Lunn <andrew@lunn.ch>
CC: <schnelle@linux.ibm.com>, <wsa+renesas@sang-engineering.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>, <y-mallik@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
 <f14a554c-555f-4830-8be5-13988ddbf0ba@lunn.ch>
 <b07cfdfe-dce4-484b-b8a8-9d0e49985c60@ti.com>
 <8b4dc94a-0d59-499f-8f28-d503e91f2b27@lunn.ch>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <8b4dc94a-0d59-499f-8f28-d503e91f2b27@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/12/24 20:29, Andrew Lunn wrote:
>> The shared memory address space in AM64x board is 2G and u32 data type for
>> address works to use this address space. In order to make the driver generic,to
>> work with systems that have more than 4G address space, we can change the base
>> addr data type to u64 in the virtual driver code and the corresponding
>> necessary changes have to be made in the firmware.
> 
> You probably need to think about this concept in a more generic
> way. You have a block of memory which is physically shared between two
> CPUs. Does each have its own MMU involved in accesses this memory? Why
> would each see the memory at the same physical address? Why does one
> CPU actually know anything about the memory layout of another CPU, and
> can tell it how to use its own memory? Do not think about your AM64x
> board when answering these questions. Think about an abstract system,
> two CPUs with a block of shared memory. Maybe it is even a CPU and a
> GPU with shared memory, etc. 
> 
>> The shared memory layout is modeled as circular buffer.
>> /*      Shared Memory Layout
>>  *
>>  *	---------------------------	*****************
>>  *	|        MAGIC_NUM        |	 icve_shm_head
>>  *	|          HEAD           |
>>  *	---------------------------	*****************
>>  *	|        MAGIC_NUM        |
>>  *	|        PKT_1_LEN        |
>>  *	|          PKT_1          |
>>  *	---------------------------
>>  *	|        MAGIC_NUM        |
>>  *	|        PKT_2_LEN        |	 icve_shm_buf
>>  *	|          PKT_2          |
>>  *	---------------------------
>>  *	|           .             |
>>  *	|           .             |
>>  *	---------------------------
>>  *	|        MAGIC_NUM        |
>>  *	|        PKT_N_LEN        |
>>  *	|          PKT_N          |
>>  *	---------------------------	****************
>>  *	|        MAGIC_NUM        |      icve_shm_tail
>>  *	|          TAIL           |
>>  *	---------------------------	****************
>>  */
>>
>> Linux retrieves the following info provided in response by R5 core:
>>
>> Tx buffer head address which is stored in port->tx_buffer->head
>>
>> Tx buffer buffer's base address which is stored in port->tx_buffer->buf->base_addr
>>
>> Tx buffer tail address which is stored in port->tx_buffer->tail
>>
>> The number of packets that can be put into Tx buffer which is stored in
>> port->icve_tx_max_buffers
>>
>> Rx buffer head address which is stored in port->rx_buffer->head
>>
>> Rx buffer buffer's base address which is stored in port->rx_buffer->buf->base_addr
>>
>> Rx buffer tail address which is stored in port->rx_buffer->tail
>>
>> The number of packets that are put into Rx buffer which is stored in
>> port->icve_rx_max_buffers
> 
> I think most of these should not be pointers, but offsets from the
> base of the shared memory. It then does not matter if they are mapped
> at different physical addresses on each CPU.
> 
>> Linux trusts these addresses sent by the R5 core to send or receive ethernet
>> packets. By this way both the CPUs map to the same physical address.
> 
> I'm not sure Linux should trust the R5. For a generic implementation,
> the trust should be held to a minimum. There needs to be an agreement
> about how the shared memory is partitioned, but each end needs to
> verify that the memory is in fact valid, that none of the data
> structures point outside of the shared memory etc. Otherwise one
> system can cause memory corruption on the other, and that sort of bug
> is going to be very hard to debug.
> 
> 	Andrew
> 

The Linux Remoteproc driver which initializes remote processor cores carves out
a section from DDR memory as reserved memory for each remote processor on the
SOC. This memory region has been reserved in the Linux device tree file as
reserved-memory. Out of this reserved memory for R5 core some memory is
reserved for shared memory.

The shared memory is divided into two distinct regions:
one for the A53 -> R5 data path (Tx buffer for Linux), and other for R5 -> A53
data path (Rx buffer for Linux).

Four entities total shared memory size, number of packets, buffer slot size and
base address of buffer has been hardcoded into the firmware code for both the
Tx and Rx buffer. These four entities are informed by the R5 core and Linux
retrieves these info from message received using icve_rpmsg_cb.

Using the Base Address for Tx or Rx shared memory received and the value of
number of packets, buffer slot size received, buffer's head address, shared
memory buffer buffer's base address and tail address is calculated in the driver.

Linux driver uses ioremap function to translate these physical addresses
calculated into virtual address. Linux uses these virtual addresses to send
packets to remote cores using icve_start_xmit function.

It has been agreed upon by design that the remote core will use a particular
start address of buffer and Linux will also use it, and it has been harcoded in
the firmware in the remote core. Since this address has been harcoded in the
firmware, it can be hardcoded in the Linux driver code and then a check can be
made if the address received from remote core matches with the address
hardcoded in the Linux driver.

But viewing the driver from a generic perspective, the driver can interact with
different firmware whose start address for the shared memory region will not
match the one hardcoded into the Linux driver.

This is why it has been decided to hardcode the start address in the firmware
and it will be sent by the remote core to Linux and Linux will use it.

Kindly suggest in what other ways can the driver get to know the start address
of the shared memory if not informed by the remote core. Also how to do a check
if the address is valid.

Thanks and regards,
Yojana Mallik

