Return-Path: <netdev+bounces-133987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABC9979F5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426371C212C0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B695179A3;
	Thu, 10 Oct 2024 01:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25CC153;
	Thu, 10 Oct 2024 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522298; cv=none; b=nTRjINVnAQ30Z0vFdKCdnhvGBd5GXDjDvh6W2WZwjXF6dTGzHwtK8M2+GPmv3lkq0hS7MldGSqeS2mZw0lErphJbwF2xJAaWUb4SAcgwcEWDS23wncsiB2v0bQ/VHHxIeIh4s38fLeg1V6AKqbm9paOiMEU9E5N8+qumi+gYXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522298; c=relaxed/simple;
	bh=kwol1wPpXs2AKwn9h1QYs2yysuRiBCgE9Goka29iThM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H6PEqSggt0uJcVE7S8TLde0pTOL6Vf8DvhHoHn8PQVcf5LeN6/hxEkQr7bvmSQU5ANAQo9WT11BnspAtBmOQ6dN/mHW5eywisuYBkkQmpx9x69L18FJNjDAAcDbxViQ6vW7VIaPEBN9KpGrVdjPbHjYXLiHGBwM9SOKmUPZ6zLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XPBNb0lPmz20q46;
	Thu, 10 Oct 2024 09:04:15 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 47F861A0170;
	Thu, 10 Oct 2024 09:04:52 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 09:04:51 +0800
Message-ID: <7bdbdb85-8fb9-4086-ac25-f815804a870a@huawei.com>
Date: Thu, 10 Oct 2024 09:04:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>
Subject: Re: [PATCH V11 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Joe Damato <jdamato@fastly.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
	<horms@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<christophe.jaillet@wanadoo.fr>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-8-shaojijie@huawei.com> <Zwb3PvG_EjwqMT4v@LQ3V64L9R2>
 <Zwb4vlznjquet3DT@LQ3V64L9R2>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <Zwb4vlznjquet3DT@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/10 5:42, Joe Damato wrote:
> On Wed, Oct 09, 2024 at 02:35:58PM -0700, Joe Damato wrote:
>> On Tue, Oct 08, 2024 at 10:23:55AM +0800, Jijie Shao wrote:
>>> +
>>> +	if (likely(packet_done < budget &&
>>> +		   napi_complete_done(napi, packet_done)))
>>> +		hbg_hw_irq_enable(priv, HBG_INT_MSK_RX_B, true);
>> I am not sure this is correct.
>>
>> napi_complete_done might return false if napi_defer_hard_irqs is
>> being used [1].
>>
>> In that case you'd probably want to avoid re-enabling IRQs even
>> though (packet_done < budget) is true.
> Err, sorry. I read the code wrong. The implementation you have looks
> right to me, my mistake.

It's okay. Thank you for reviewing the code.


Jijie Shao.



