Return-Path: <netdev+bounces-126522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D0971AA0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCB71F24EB8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89C1B78F3;
	Mon,  9 Sep 2024 13:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5001779BD;
	Mon,  9 Sep 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887860; cv=none; b=BYML/KjEgfsXwlozMJo6MQX/38lJ5DjQrlTf5DP8f+RQh2mu8hybywd/G1fytxMzTVl8kJzcUNq/2puYQaG7AUXnAK6yCfH5qh4tSPkDaL7nbgvY3eA/XhYYS9Sxnd5IASgM7vOxqNpj1HfmnUfEUYg7Ae8P1nRiDcFkgM/cVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887860; c=relaxed/simple;
	bh=6PsrAnvnUxWxKI+lCEQhwZ2Sv+W5TYz9e52+on0/vxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QDnxzuAXd9K3SUk9YVW5EuQTddSODJMh/UJyu9SOQrE1YdlMYzA2DWnZ4whlBWpZe6g6uchdcRljNj4IcNaDuPqN8VocZ0tLOyrBa/8eNLBUqRJ3+VlDf4PBlfyqJKaGhhqVcZj/VcCfrKgd/8UzRzMOq83Ine3J2XtLq3C6Cw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2S6y3gLCz20nkd;
	Mon,  9 Sep 2024 21:17:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 63B17180041;
	Mon,  9 Sep 2024 21:17:34 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 21:17:33 +0800
Message-ID: <edfb5fc7-ea9a-98bf-0b32-afe67dbc8d8a@huawei.com>
Date: Mon, 9 Sep 2024 21:17:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] net: ethernet: nxp: Fix a possible memory leak in
 lpc_mii_probe()
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <vz@mleia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alexandre.belloni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240909092948.1118381-1-ruanjinjie@huawei.com>
 <0a53ab3c-2643-419d-9b5d-71561c3b50b9@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <0a53ab3c-2643-419d-9b5d-71561c3b50b9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/9 20:54, Andrew Lunn wrote:
> On Mon, Sep 09, 2024 at 05:29:48PM +0800, Jinjie Ruan wrote:
>> of_phy_find_device() calls bus_find_device(), which calls get_device()
>> on the returned struct device * to increment the refcount. The current
>> implementation does not decrement the refcount, which causes memory leak.
>>
>> So add the missing phy_device_free() call to decrement the
>> refcount via put_device() to balance the refcount.
> 
> Why is a device reference counted?
> 
> To stop is disappearing.
> 
>> @@ -768,6 +768,9 @@ static int lpc_mii_probe(struct net_device *ndev)
>>  		return -ENODEV;
>>  	}
>>  
>> +	if (pldat->phy_node)
>> +		phy_device_free(phydev);
>> +
>>  	phydev = phy_connect(ndev, phydev_name(phydev),
>>  			     &lpc_handle_link_change,
>>  			     lpc_phy_interface_mode(&pldat->pdev->dev));
> 
> Think about this code. We use of_phy_find_device to get the device,
> taking a reference on it. While we hold that reference, we know it
> cannot disappear and we passed it to phy_connect(), passing it into
> the phylib layer. Deep down, phy_attach_direct() is called which does
> a get_device() taking a reference on the device. That is the phylib
> layer saying it is using it, it does not want it to disappear.
> 
> Now think about your change. As soon as you new phy_device_free() is
> called, the device can disappear. phylib is then going to use
> something which has gone. Bad things will happen.

Hi, Andrew,
Thank you to share me your a wealth of relevant knowledge. My knowledge
of reference count is relatively shallow.

> 
> So with changes like this, you need to think about lifetimes of things
> being protected by a reference count. When has lpc_mii_probe(), or the
> lpc driver as a whole finished with phydev? There are two obvious
> alternatives i can think of.
> 
> 1) It wants to keep hold of the reference until the driver remove() is
> called, so you should be releasing the reference in
> lpc_eth_drv_remove().
> 
> 2) Once the phydev is passed to the phylib layer for it to manage,
> this driver does not need to care about it any more. So it just needs
> to hold the reference until after phy_connect() returns.

I think this is a good chance to put the device after phy_connect().

> 
> Memory leaks are an annoyance, but generally have little effect,
> especially in probe/remove code which gets called once. Accessing
> something which has gone is going to cause an Opps.
> 
> So, you need to think about the lifetime of objects you are
> manipulating the reference counts on. You want to state in the commit
> message your understanding of these lifetimes so the reviewer can
> sanity check them.>
> FYI: Ignore anything you have learned while fixing device tree
> reference counting bugs. Lifetimes of OF objects is probably very
> broken.
> 
> 	Andrew
> 
> ---
> pw-bot: cr

