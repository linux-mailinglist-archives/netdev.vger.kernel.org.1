Return-Path: <netdev+bounces-102864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A69052FD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C62B1C24313
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA44175552;
	Wed, 12 Jun 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xuDmoKQ/"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75716F0D0;
	Wed, 12 Jun 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196775; cv=none; b=ion5NfTpRin/fU2xDg6YypcHthjlXfKYCyVG1WsT8rW3MNa7PsbOjQ4LB2LIeY7qhh6awzskmp6PXqdGA6w2O784iu06cOEt8g6zbbhgWZMfJpqJTVHS8xZ7RZbmdF3OImQqzHQIC2vo/8gdlbUGyJ4wS2ZKvLJunMS/PeOibeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196775; c=relaxed/simple;
	bh=w26ka1EJKTaO+NQzaxi2BDDrZVop7CXOo67LRzv5iWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HjzML9zQaIjuu6JEejV3lkDSLFK83eQjcW6ncgj9B8X+EFB20YuFkRcAKDCHIGPiqUJMJqJmJc6JK2C7Z+2WqrRVIsiJERl0V88jDIh0jE9fAkpIXRJtwmeXLAHTo/13nCl1ImXgH7tOZGifLw6g3vfwX1pTkAVrKQVhYRcUpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xuDmoKQ/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CCqadx048161;
	Wed, 12 Jun 2024 07:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718196756;
	bh=v7t3TttkXANOwbhOTBniOuJ6CwP2x6L1P30MBjQfJIU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xuDmoKQ/vSo4UGpn99RJyqbNwZhqs8mZNmqphtoGj5tEi5B1PRB/O8LkKxu18TMMe
	 yqYwiKhFWMfWfXLKzompcxx1nwTQjdl70bZ7kRJ/LMzrqBw/nUm/GK+F5YTfQXHY1h
	 QfwaG0U52LfmJ4bsYzWvz++7eozNmibYgLCRimMs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CCqZvk072612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 07:52:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 07:52:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 07:52:35 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CCqT2S004025;
	Wed, 12 Jun 2024 07:52:30 -0500
Message-ID: <b07cfdfe-dce4-484b-b8a8-9d0e49985c60@ti.com>
Date: Wed, 12 Jun 2024 18:22:29 +0530
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
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <f14a554c-555f-4830-8be5-13988ddbf0ba@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/4/24 18:24, Andrew Lunn wrote:
>>>> +	u32 buff_slot_size;
>>>> +	/* Base Address for Tx or Rx shared memory */
>>>> +	u32 base_addr;
>>>> +} __packed;
>>>
>>> What do you mean by address here? Virtual address, physical address,
>>> DMA address? And whos address is this, you have two CPUs here, with no
>>> guaranteed the shared memory is mapped to the same address in both
>>> address spaces.
>>>
>>> 	Andrew
>>
>> The address referred above is physical address. It is the address of Tx and Rx
>> buffer under the control of Linux operating over A53 core. The check if the
>> shared memory is mapped to the same address in both address spaces is checked
>> by the R5 core.
> 
> u32 is too small for a physical address. I'm sure there are systems
> with more than 4G of address space. Also, i would not assume both CPUs
> map the memory to the same physical address.
> 
> 	Andrew

The shared memory address space in AM64x board is 2G and u32 data type for
address works to use this address space. In order to make the driver generic,to
work with systems that have more than 4G address space, we can change the base
addr data type to u64 in the virtual driver code and the corresponding
necessary changes have to be made in the firmware.

During handshake between Linux and remote core, the remote core advertises Tx
and Rx shared memory info to Linux using rpmsg framework. Linux retrieves the
info related to shared memory from the response received using icve_rpmsg_cb
function.

+		case ICVE_RESP_SHM_INFO:
+			/* Retrieve Tx and Rx shared memory info from msg */
+			port->tx_buffer->head =
+				ioremap(msg->resp_msg.shm_info.shm_info_tx.base_addr,
+					sizeof(*port->tx_buffer->head));
+
+			port->tx_buffer->buf->base_addr =
+				ioremap((msg->resp_msg.shm_info.shm_info_tx.base_addr +
+					sizeof(*port->tx_buffer->head)),
+					(msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs *
+					 msg->resp_msg.shm_info.shm_info_tx.buff_slot_size));
+
+			port->tx_buffer->tail =
+				ioremap(msg->resp_msg.shm_info.shm_info_tx.base_addr +
+					sizeof(*port->tx_buffer->head) +
+					(msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs *
+					msg->resp_msg.shm_info.shm_info_tx.buff_slot_size),
+					sizeof(*port->tx_buffer->tail));
+
+

	
The shared memory layout is modeled as circular buffer.
/*      Shared Memory Layout
 *
 *	---------------------------	*****************
 *	|        MAGIC_NUM        |	 icve_shm_head
 *	|          HEAD           |
 *	---------------------------	*****************
 *	|        MAGIC_NUM        |
 *	|        PKT_1_LEN        |
 *	|          PKT_1          |
 *	---------------------------
 *	|        MAGIC_NUM        |
 *	|        PKT_2_LEN        |	 icve_shm_buf
 *	|          PKT_2          |
 *	---------------------------
 *	|           .             |
 *	|           .             |
 *	---------------------------
 *	|        MAGIC_NUM        |
 *	|        PKT_N_LEN        |
 *	|          PKT_N          |
 *	---------------------------	****************
 *	|        MAGIC_NUM        |      icve_shm_tail
 *	|          TAIL           |
 *	---------------------------	****************
 */

Linux retrieves the following info provided in response by R5 core:

Tx buffer head address which is stored in port->tx_buffer->head

Tx buffer buffer's base address which is stored in port->tx_buffer->buf->base_addr

Tx buffer tail address which is stored in port->tx_buffer->tail

The number of packets that can be put into Tx buffer which is stored in
port->icve_tx_max_buffers

Rx buffer head address which is stored in port->rx_buffer->head

Rx buffer buffer's base address which is stored in port->rx_buffer->buf->base_addr

Rx buffer tail address which is stored in port->rx_buffer->tail

The number of packets that are put into Rx buffer which is stored in
port->icve_rx_max_buffers

Linux trusts these addresses sent by the R5 core to send or receive ethernet
packets. By this way both the CPUs map to the same physical address.

Regards,
Yojana Mallik

