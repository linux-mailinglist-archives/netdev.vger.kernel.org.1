Return-Path: <netdev+bounces-102861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943089052F2
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CAB1F21D93
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB1178374;
	Wed, 12 Jun 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TYah2kgW"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9316FF58;
	Wed, 12 Jun 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196622; cv=none; b=QXazN8IiBh0ckuufc/9raYj3nBIKkAjVcCaS+ntS7pYeqSxSnB+tUBF3uvFOqZEeDiYkpSnehnx5RXGXTCbq9Xd+ZhER5Fe90cAQ+orQiHwgo8TnvqJIGvMsb/1uHebOw/782NbsOD+DAaXLzpmw8Sqd0kD5v+92musVm0zX0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196622; c=relaxed/simple;
	bh=Ocd1OGxk13e+XeNRdvppEE9kpAFsXCx13kIRhLidbgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nlgc8I6afDFFvM/Joq4ui0gLC/jGluk7lgQHzn555YjkiAfzR5GitiDRpQnduVVhTVbBPjLvhj8RD11FJXtHVeMLIvK8MYV96fTY+9LezZ7RwAZZZpoIZn9hUwmsCRaEJ9nk3M3dWbVi6yBWp6QihMTQRFGXdbSLSYPTrzg0bNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TYah2kgW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CCo0h8047566;
	Wed, 12 Jun 2024 07:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718196600;
	bh=NBy9aidXY14XRoizuH0H+R15hxKNwJmLtlXdY1m5LQk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TYah2kgWfiz028trBCS3B+oT+dIxotPqc9fp5ZzlzxH3Mhum1E3NahTbJSEML+XNG
	 KYghOXKPLTxXw2z/NlcHOrNwL65vaCs3nWuoVn1LguT5o6TkrZhzn+7z5tRlmESSJD
	 pntm0dqy4ADg9EesgUI1GWtQCgg6BTQwz1lPSVks=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CCo0Ab041802
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 07:50:00 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 07:50:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 07:49:59 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CCnsZF129213;
	Wed, 12 Jun 2024 07:49:55 -0500
Message-ID: <ebbd1bcc-ecc4-4bbe-aefb-39256abeed21@ti.com>
Date: Wed, 12 Jun 2024 18:19:53 +0530
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
 <bad12a9c-533e-47c3-9aa7-1a4d71eb6d87@lunn.ch>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <bad12a9c-533e-47c3-9aa7-1a4d71eb6d87@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/4/24 18:30, Andrew Lunn wrote:
>>> Also, why SET_MAC_ADDR? It would be good to document where the MAC
>>> address are coming from. And what address this is setting.
>>>
>>
>> The interface which is controlled by Linux and interacting with the R5 core is
>> assigned mac address 00:00:00:00:00:00 by default. To ensure reliable
>> communication and compliance with network standards a different MAC address is
>> set for this interface using icve_set_mac_address.
> 
> So this is the peer telling the Linux machine what MAC address to use?
> As i said, it is not clear what direction this message is flowing. Or
> even if it can be used the other way around. Can Linux tell the peer
> what address it should use?
> 

No, RTOS the peer is not telling the Linux machine what MAC address to use. The
user can add a unicast mac address to the virtual network interface using the
following steps:

Steps to add MAC Address
# Bring down the virtual port interface
$ ifconfig eth1 down
# Set MAC address for the virtual port interface, ex 01:02:03:04:05:06
$ ifconfig eth1 hw ether 01:02:03:04:05:06
# Bring the interface up
$ ifconfig eth1 up

These commands will call the net_device_ops
.ndo_stop = icve_ndo_stop
.ndo_set_mac_address = icve_set_mac_address
.ndo_open = icve_ndo_open,

While adidng the mac address, ndo ops will call set_mac_address which will call
create_send_request which will create a request with command add mac address
and send a rpmsg to R5 core.


> Also, what is the big picture here. Is this purely a point to point
> link? There is no intention that one or both ends could bridge packets
> to another network? Does this link always carrier IP? If so, why do
> you need the Ethernet header? Why not just do the same as SLIP, PPP,
> other point to point network protocols.
> 
> 	Andrew

We want the shared memory to be accessed by 2 cores only. So the inter-core
virtual ethernet driver is indeed a point to point link. There is a bridging
application in R5 core. If there is a cluster of cores like multiple A53 cores
and R5 cores, and one A53 core has to send packets to another A53 core then the
A53 core can send packets to R5 core using a icve a virtual driver and R5 core
can transmit these packets to the other A53 core using another instance of icve
virtual driver. Multiple instances of virtual driver are used by the bridging
application but the virtual driver by itself is a point to point link.

The goal of the inter-core virtual ethernet driver is network traffic
tunneling between heterogeneous processors. R5 core will send ethernet packets
to Linux because R5 core wants Linux to process the ethernet packets further.
It is intended that R5 core should use resources for other processes and A53
core should use resources to take actions on the Ethernet packet. How A53 core
handles the ethernet packets depends on the ethernet header. Hence it is
necessary for the A53 core to receive ethernet header.

Regards,
Yojana Mallik


