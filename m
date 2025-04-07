Return-Path: <netdev+bounces-179496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8CBA7D1BA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 03:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A6D16A3AB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DCF20F093;
	Mon,  7 Apr 2025 01:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595002C9A;
	Mon,  7 Apr 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743989105; cv=none; b=sUks0856uTP59YbM+FZIV8BCyP8CXYFW2yT9ggxi2JHngHEkHWpREGUehSh2y0mUzoBmsXadB59XHivHYDWmqRK4vHhcoRIJvcC4DKmFnoz9o9mufMMyEhr++q6N6QdlkIh0EOe6RtsoFiLymASVo9pi9CIpcP8XyKVVxLhwkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743989105; c=relaxed/simple;
	bh=JIEoReQEctUrAkJXeAkaQVuUdCXPKX03hBBCmh5fqj0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qCxwJ25XU7uUDK3moD4I0ro0xMouxMlyOEs2y8njX2GtdG58MRkOo8nspkU1qFN1fJz7n6plKS6BppgGZ5w+SkIzhpQMhqBHd2cVbjWIFHjatWnzyiiCRcEYOukfOOdFkNaJcMUsIQopaQSXrjpaZnAcxgrDyP4XVLR4Hd1gnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZW9y56kFNz13L9W;
	Mon,  7 Apr 2025 09:06:05 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B422C140121;
	Mon,  7 Apr 2025 09:06:43 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Apr 2025 09:06:42 +0800
Message-ID: <b3aafd85-cb58-4046-88df-2b3566e2497d@huawei.com>
Date: Mon, 7 Apr 2025 09:06:42 +0800
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
Subject: Re: [PATCH net v2 6/7] net: hibmcge: fix not restore rx pause mac
 addr after reset issue
To: Jakub Kicinski <kuba@kernel.org>
References: <20250403135311.545633-1-shaojijie@huawei.com>
 <20250403135311.545633-7-shaojijie@huawei.com>
 <20250404075804.42ccf6f0@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250404075804.42ccf6f0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/4/4 22:58, Jakub Kicinski wrote:
> On Thu, 3 Apr 2025 21:53:10 +0800 Jijie Shao wrote:
>> In normal cases, the driver must ensure that the value
>> of rx pause mac addr is the same as the MAC address of
>> the network port. This ensures that the driver can
>> receive pause frames whose destination address is
>> the MAC address of the network port.
> I thought "in normal cases" pause frames use 01:80:C2:00:00:01
> as the destination address!?

No, the address set in .ndo_set_mac_address() is used.
01:80:C2:00:00:01 is supported by default. No additional configuration is required.

>
> Are you sure this patch is not a misunderstanding, and the issue
> is already fixed by patch 2?

It's a different issue. This patch is used to solve the problem that
the configuration is lost after reset.

>
>> Currently, the rx pause addr does not restored after reset.

Here.

>>
>> The index of the MAC address of the host is always 0.
>> Therefore, this patch sets rx pause addr to
>> the MAC address with index 0.

