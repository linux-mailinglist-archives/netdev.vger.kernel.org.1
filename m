Return-Path: <netdev+bounces-100439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F98FAAAF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AF61F231DD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC213D897;
	Tue,  4 Jun 2024 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l/3EhE7M"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7065F;
	Tue,  4 Jun 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482275; cv=none; b=MK0jGWbjcT4QUuSA98hubDCelqspaeTMIW7t+mUxFTcZq04bQaXiZr9REqMTMv6AXTJOFHxsHVzwUQljCvej1BBntiIBM+N+DwqzBT25vj9IFw8b40Y4lw6xg3iPIb2+VFUoMFTpBH2MpnFAOFNpCdITheuC7CTL/Slh5e/owB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482275; c=relaxed/simple;
	bh=p4sDxzHb1i63Q3DbEaEGPZwxCj7DN2Lzc6JSzJfd700=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=MLS1kcG1fAhfMdtkkCaS/KkJ840d4TvstdABos/Sx07hag8QQTeCkGLX58pqOwwGGsRKkmDMeiy0sEnopTdvX3MQaanPeypTCQMJXKaiTPSN/0WIpBNzdf0yFViZDqukJfK/Sbz8G7dhrsz03lPMeXpRobIlAlMCVWMCOpljn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l/3EhE7M; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4546O2F1046223;
	Tue, 4 Jun 2024 01:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717482242;
	bh=4PfyFitsGdAkgl1MpNcDs7QMz8YZYOUgHQQGXhlK6lQ=;
	h=Date:From:Subject:To:CC:References:In-Reply-To;
	b=l/3EhE7MnRRGxMQro003GZ88IJMnTnEaIg60bnDn4CmwDgw5w40jmMkH+wmbbVNbI
	 1atdzkt66or2eAPFwOq6S8vwf14XV5kDtPpH4EjJrstwh/5Z0h/uXHDKl8D2hqilFu
	 /E9g/ZJgHAZ5b53SAlwbwvPfytX5AIcLdidAi6RI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4546O2GI006058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 01:24:02 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 01:24:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 01:24:01 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4546NtpM088843;
	Tue, 4 Jun 2024 01:23:56 -0500
Message-ID: <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
Date: Tue, 4 Jun 2024 11:53:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yojana Mallik <y-mallik@ti.com>
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
Content-Language: en-US
In-Reply-To: <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 6/2/24 22:15, Andrew Lunn wrote:
>> +enum icve_rpmsg_type {
>> +	/* Request types */
>> +	ICVE_REQ_SHM_INFO = 0,
>> +	ICVE_REQ_SET_MAC_ADDR,
>> +
>> +	/* Response types */
>> +	ICVE_RESP_SHM_INFO,
>> +	ICVE_RESP_SET_MAC_ADDR,
>> +
>> +	/* Notification types */
>> +	ICVE_NOTIFY_PORT_UP,
>> +	ICVE_NOTIFY_PORT_DOWN,
>> +	ICVE_NOTIFY_PORT_READY,
>> +	ICVE_NOTIFY_REMOTE_READY,
>> +};
> 
> +struct message_header {
> +       u32 src_id;
> +       u32 msg_type; /* Do not use enum type, as enum size is compiler dependent */
> +} __packed;
> 
> 
> Given how you have defined icve_rpmsg_type, what is the point of
> message_header.msg_type?
> 


+	rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg),
+		   sizeof(common->send_msg));

rpmsg_send in icve_create_send_request is sending message_header.msg_type to R5
core using (void *)(&common->send_msg).
In icve_rpmsg_cb function switch case statements for option msg_type are used
and cases are from enum icve_rpmsg_type.

> It seems like this would make more sense:
> 
> enum icve_rpmsg_request_type {
> 	ICVE_REQ_SHM_INFO = 0,
> 	ICVE_REQ_SET_MAC_ADDR,
> }
> 
> enum icve_rpmsg_response_type {
> 	ICVE_RESP_SHM_INFO,
> 	ICVE_RESP_SET_MAC_ADDR,
> }
> enum icve_rpmsg_notify_type {
> 	ICVE_NOTIFY_PORT_UP,
> 	ICVE_NOTIFY_PORT_DOWN,
> 	ICVE_NOTIFY_PORT_READY,
> 	ICVE_NOTIFY_REMOTE_READY,
> };
> 

Since msg_hdr.msg_type which takes value from enum icve_msg_type is being used
in rpmsg_send and icve_rpmsg_cb, I would prefer to continue with the 2 separate
enums, that is enum icve_msg_type and enum icve_rpmsg_type. However I am always
open to make improvements and would be happy to discuss this further if you
have additional insights.

> Also, why SET_MAC_ADDR? It would be good to document where the MAC
> address are coming from. And what address this is setting.
> 

The interface which is controlled by Linux and interacting with the R5 core is
assigned mac address 00:00:00:00:00:00 by default. To ensure reliable
communication and compliance with network standards a different MAC address is
set for this interface using icve_set_mac_address.

> In fact, please put all the protocol documentation into a .rst
> file. That will help us discuss the protocol independent of the
> implementation. The protocol is an ABI, so needs to be reviewed well.
> 

I will do it.

>> +struct icve_shm_info {
>> +	/* Total shared memory size */
>> +	u32 total_shm_size;
>> +	/* Total number of buffers */
>> +	u32 num_pkt_bufs;
>> +	/* Per buff slot size i.e MTU Size + 4 bytes for magic number + 4 bytes
>> +	 * for Pkt len
>> +	 */
> 
> What is your definition of MTU?
> 
> enp2s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
> 
> Typically, MTU does not include the Ethernet header or checksum. Is
> that what you mean here?
> 

MTU is only the Payload. I have realized the macro names are misleading and I
will change them as
#define ICVE_PACKET_BUFFER_SIZE   1540
#define MAX_MTU   ICVE_PACKET_BUFFER_SIZE - (ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN)
Hence value of max mtu is 1518 bytes.

>> +	u32 buff_slot_size;
>> +	/* Base Address for Tx or Rx shared memory */
>> +	u32 base_addr;
>> +} __packed;
> 
> What do you mean by address here? Virtual address, physical address,
> DMA address? And whos address is this, you have two CPUs here, with no
> guaranteed the shared memory is mapped to the same address in both
> address spaces.
> 
> 	Andrew

The address referred above is physical address. It is the address of Tx and Rx
buffer under the control of Linux operating over A53 core. The check if the
shared memory is mapped to the same address in both address spaces is checked
by the R5 core.

Thanks for the feedback.
Regards
Yojana Mallik

