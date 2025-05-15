Return-Path: <netdev+bounces-190678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD6AB8460
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BE1189766D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24190297B8E;
	Thu, 15 May 2025 10:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DC2918F3;
	Thu, 15 May 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306319; cv=none; b=QJ5zhL4lz3XFfSmtviZlbX5/jLm+wk7PDIzLlr5nY0lk4gH+pQTzUi19dbiqU5tWnVNK8c1ReNneRZNEugIkJRk6GMp0Hf8pM5Bnm3qeSC3EGP2rXdw+PSl/4qN4q7kYmHRdaAIlxcUvYmfwZFKIK2jqP21oatr1CcE8WuLhN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306319; c=relaxed/simple;
	bh=rx3+JJqp4MLgy7PImSuLwHbfQSyVYK4T+tNucNa77no=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vC9/S1uvUjJDPoYI/bxBx1lcXt5rNmCY86pBwx0cGqdZKs/Oq49xLp/ulqYpqAqixMYurbkyChPCUAw0KiKUJ4hQ6D5ELZt+UbIwB66deyjcaToWyjG2sVWfPUBrX1kWUlGa+A2t44bRmNGrwWtiBiwofIyuTLQoZy9CgT2hX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zyn6m4vYxz1DKYn;
	Thu, 15 May 2025 18:50:24 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E9DA1402EA;
	Thu, 15 May 2025 18:51:52 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 18:51:51 +0800
Message-ID: <5b8d45e2-27bb-4294-9e89-b8d4866cb295@huawei.com>
Date: Thu, 15 May 2025 18:51:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hibmcge: fix wrong ndo.open() after reset
 fail issue.
To: Jakub Kicinski <kuba@kernel.org>
References: <20250430093127.2400813-1-shaojijie@huawei.com>
 <20250430093127.2400813-3-shaojijie@huawei.com>
 <20250501072329.39c6304a@kernel.org>
 <743a78cc-10d4-45f0-9c46-f021258b577d@huawei.com>
 <20250514090808.2ae43183@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250514090808.2ae43183@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/5/15 0:08, Jakub Kicinski wrote:
> On Wed, 14 May 2025 10:40:26 +0800 Jijie Shao wrote:
>> on 2025/5/1 22:23, Jakub Kicinski wrote:
>>> On Wed, 30 Apr 2025 17:31:27 +0800 Jijie Shao wrote:
>>>> If the driver reset fails, it may not work properly.
>>>> Therefore, the ndo.open() operation should be rejected.
>>> Why not call netif_device_detach() if the reset failed and let the core
>>> code handle blocking the callbacks?
>> If driver call netif_device_detach() after reset failed,
>> The network port cannot be operated. and I can't re-do the reset.
>> So how does the core code handle blocking callbacks?
>> Is there a good time to call netif_device_attach()?
>>
>> Or I need to implement pci_error_handlers.resume()?
>>
>>
>> [root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
>> ETHTOOL_RESET 0xffff
>> Cannot issue ETHTOOL_RESET: Device or resource busy
>> [root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
>> ETHTOOL_RESET 0xffff
>> Cannot issue ETHTOOL_RESET: No such device
>> [root@localhost sjj]# ifconfig enp132s0f1 up
>> SIOCSIFFLAGS: No such device
> netdev APIs may not be the right path to recover the device after reset
> failure. Can you use a PCI reset (via sysfs) or devlink ?

PCI reset (via sysfs) can be used:
[root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
ETHTOOL_RESET 0xffff
Cannot issue ETHTOOL_RESET: No such device
[root@localhost sjj]# echo 1 > /sys/bus/pci/devices/0000\:84\:00.1/reset
[200643.771030] hibmcge 0000:84:00.1: reset done
[root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
ETHTOOL_RESET 0xffff
Cannot issue ETHTOOL_RESET: No such device

So, I need call netif_device_attach() in pci_error_handlers.reset_done() ?

In this scenario, only PCI reset can be used, which imposes significant restrictions on users.

Thanks,
Jijie Shao

  


