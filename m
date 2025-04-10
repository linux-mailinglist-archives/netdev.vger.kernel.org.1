Return-Path: <netdev+bounces-180979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE49A83563
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B5E16E7A1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107660B8A;
	Thu, 10 Apr 2025 01:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F393C13B;
	Thu, 10 Apr 2025 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247257; cv=none; b=ugBydd+g5QVSnat+y/4VIgLT2xIW6KFAjH+QXlcljn0Re4Z8bbSdreE6z+pnHyzqPY6G/Ju4TmlrJAU72jrCm78rIM78jYhq4MXXp+rBJ0rNT2n5Hvs4toJvsJo0sicBEMVOT8Lj7u4cpNOS2PQMjAva5A5u6Vp/Bol5U2tq6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247257; c=relaxed/simple;
	bh=7UkjdxUMmusq4YhAnPcj2YeRtLktLoMfSHH2RWgoajM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jjl9Yx/VAeQ5eEZz0y70sqRM6L+Vx9t05TmT6NmOpg5gOsoyIr/P5e3sA3ycMWgx632wPPllJdhWSn8fRV85Z+R0gM2Bjoru1TY4luOOZ7P8OuG4l68JqAelQW/iMXjzHzAmFvRof3roy8THJVuyMTyeecClCgxHLa1ReFDJVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZY1kW4cZSz2TS60;
	Thu, 10 Apr 2025 09:02:27 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A84BF1A0188;
	Thu, 10 Apr 2025 09:07:25 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 09:07:24 +0800
Message-ID: <7ff44c86-6366-4362-be9a-bde195aa671e@huawei.com>
Date: Thu, 10 Apr 2025 09:07:23 +0800
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
 <b3aafd85-cb58-4046-88df-2b3566e2497d@huawei.com>
 <20250407101129.48048623@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250407101129.48048623@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/4/8 1:11, Jakub Kicinski wrote:
> On Mon, 7 Apr 2025 09:06:42 +0800 Jijie Shao wrote:
>> on 2025/4/4 22:58, Jakub Kicinski wrote:
>>> On Thu, 3 Apr 2025 21:53:10 +0800 Jijie Shao wrote:
>>>> In normal cases, the driver must ensure that the value
>>>> of rx pause mac addr is the same as the MAC address of
>>>> the network port. This ensures that the driver can
>>>> receive pause frames whose destination address is
>>>> the MAC address of the network port.
>>> I thought "in normal cases" pause frames use 01:80:C2:00:00:01
>>> as the destination address!?
>> No, the address set in .ndo_set_mac_address() is used.
>> 01:80:C2:00:00:01 is supported by default. No additional configuration is required.
> Are you talking about source or destination?
> How does the sender learn the receiver's address? Via LLDP?
> You need to explain all this much better in the commit message.
> It is not "normal" for a switched Ethernet network.


ok,

Thanks
Jijie Shao


