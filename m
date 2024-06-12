Return-Path: <netdev+bounces-102858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A79052E8
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573331C21431
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9A172BD7;
	Wed, 12 Jun 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VKPAPZUM"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72584172BC1;
	Wed, 12 Jun 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196585; cv=none; b=a7i6zXqaWgoOWJLvQAFobUogmsIXiFYuWsNs0PiX7UX0gcZX4IRfUk0sRwnBQlIUrkZyt1jc3871XyXzbwQGlykV97Qfgr9D3SK+eR3w/KAyDh++Qu9B7885mPtpYMilLR9RzOxjz3XC29aNQj8sxH4+EalwGOcxg7s2bSXLH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196585; c=relaxed/simple;
	bh=uSLWTgjgrXF4KTlMSmgRqAQLaG/bcDMZuxXhJUdFn74=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=km1zRuvayKpjE+uIq0K3ezh6k2gA4jH6cA4N44WIw0ln5czGWpJ+7PeIli2Pps+Ec/zTHox7hLH8Rg6GmW8F6ixK54ZNsKR1e8cq7Sg2ue21wOiptjaXwBiZMCgpBcPe2fggbOLSYe9p0VEgGqbSR6J9zdaEk5iqV/n3L/Yx8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VKPAPZUM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CCmtiX107744;
	Wed, 12 Jun 2024 07:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718196535;
	bh=sgOfJR6I9HRjTCuw21R8Npr1/hOjg/r1gb3GgfZ6fk8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VKPAPZUMEL6L3Kv98Zetab95Hj8nPOD1qh/8XMeemObWF8Rklau4tNFb662JZIV13
	 eEdg0nsVkBgc0CbJhd2j8xi3YBzrk75l4/4ft82u/FM8enT1vLz4K55958lksjF9cg
	 kB6isUyvtJo2xSVWfhi/AfsHiT3lGtt6AxKMwGW0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CCmtGa010856
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 07:48:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 07:48:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 07:48:55 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CCmn6g128115;
	Wed, 12 Jun 2024 07:48:50 -0500
Message-ID: <02df751a-dd04-4aa5-8c0f-7f8c98d7e01c@ti.com>
Date: Wed, 12 Jun 2024 18:18:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] Introducing Intercore Virtual Ethernet
 (ICVE) driver
To: Andrew Lunn <andrew@lunn.ch>
CC: <schnelle@linux.ibm.com>, <wsa+renesas@sang-engineering.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <y-mallik@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <8f5d2448-bfd7-48a5-be12-fb16cdc4de79@lunn.ch>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <8f5d2448-bfd7-48a5-be12-fb16cdc4de79@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/2/24 21:15, Andrew Lunn wrote:
> On Fri, May 31, 2024 at 12:10:03PM +0530, Yojana Mallik wrote:
>> virtio-net provides a solution for virtual ethernet interface in a
>> virtualized environment.
>>
>> There might be a use-case for traffic tunneling between heterogeneous
>> processors in a non virtualized environment such as TI's AM64x that has
>> Cortex A53 and Cortex R5 where Linux runs on A53 and a flavour of RTOS
>> on R5(FreeRTOS) and the ethernet controller is managed by R5 and needs
>> to pass some low priority data to A53.
>>
>> One solution for such an use case where the ethernet controller does
>> not support DMA for Tx/Rx channel, could be a RPMsg based shared memory
>> ethernet driver.
> 
> virtio-net is very generic and vendor agnostic.
> 
> Looking at icve, what is TI specific? Why not define a generic
> solution which could be used for any heterogeneous system? We are
> seeming more and more such systems, and there is no point everybody
> re-inventing the wheel. So what i would like to see is something
> similar to driver/tty/rpmsg_tty.c, a driver/net/ethernet/rpmsg_eth.c,
> with good documentation of the protocol used, so that others can
> implement it. And since you say you have FreeRTOS on the other end,
> you could also contribute that side to FreeRTOS as well. A complete
> open source solution everybody can use.
> 
> 	Andrew

+static struct rpmsg_device_id icve_rpmsg_id_table[] = {
+	{ .name = "ti.icve" },
+	{},
+};
+MODULE_DEVICE_TABLE(rpmsg, icve_rpmsg_id_table);
+
+static struct rpmsg_driver icve_rpmsg_client = {
+	.drv.name = KBUILD_MODNAME,
+	.id_table = icve_rpmsg_id_table,
+	.probe = icve_rpmsg_probe,
+	.callback = icve_rpmsg_cb,
+	.remove = icve_rpmsg_remove,
+};
+module_rpmsg_driver(icve_rpmsg_client);
+
When the Linux kernel detects an rpmsg device (the communication channel), it
looks for a matching driver that can handle this device with the help of name
string in the icve_rpmsg_id_table in driver structure. I will change the name
string to make the driver generic. Apart from the name string other entities
don't look TI specific.
Thank you for the suggestion to make inter-core virtual ethernet driver generic
like drivers/tty/rpmsg_tty.c for a complete open source solution. I will be
working on it.

Regard,
Yojana Mallik

