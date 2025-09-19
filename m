Return-Path: <netdev+bounces-224676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6FB8802A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5731C3BBEDD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 06:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944729BDA3;
	Fri, 19 Sep 2025 06:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495A34BA52;
	Fri, 19 Sep 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263826; cv=none; b=YFm0lQ1XdRX+I+JuRHwK3HzLOLqWXPAvqmH5amsL/HblXGJZrVXJmJE5vEdJXpgH8cyBQINsnE00FfV2GjGmKMtTAAH7N+cuH1LAsK3429viTR8RoDDW+NbbuRsCGhn2YfJ5fkT5UgGATgEp9cE7jlFOlgxRN/hfhVKn1IrVFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263826; c=relaxed/simple;
	bh=x+9cvtcdYBuNntuuWireZszUfAoEbcWu80X7g6BIyk8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cGn/UfaDnOZfoi86p77pq9wW+eJ9y91Nb9QflQC7WZr188tC1731n67iKxjILm7hw6Vhz+EMlW/7f1tj1j6HwxR+ToiPNFUyXDk2eV9hD5at5+oVuU8w2RWY2EFt0n9YZIDZds6ge9Rg5dWK0MFG5sXVS73aiXBYj2z1SpwVTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cSjPn3vRbz24hxL;
	Fri, 19 Sep 2025 14:33:33 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 60E0B1A0188;
	Fri, 19 Sep 2025 14:37:00 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 14:36:59 +0800
Message-ID: <1e1779f0-def2-4143-8a8c-a11ced956c2a@huawei.com>
Date: Fri, 19 Sep 2025 14:36:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<huangdengdui@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: hns3: fix loopback test of serdes and phy is
 failed if duplex is half
To: Andrew Lunn <andrew@lunn.ch>
References: <20250917122954.1265844-1-shaojijie@huawei.com>
 <20250917122954.1265844-2-shaojijie@huawei.com>
 <a060e5cf-c1cf-4dfa-b534-ddb72e8652f8@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <a060e5cf-c1cf-4dfa-b534-ddb72e8652f8@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/9/18 0:58, Andrew Lunn wrote:
> On Wed, Sep 17, 2025 at 08:29:52PM +0800, Jijie Shao wrote:
>> If duplex setting is half, mac and phy can not transmit and receive data
>> at the same time.
> Lets think about the fundamentals of Ethernet, MII and half duplex.
>
> Is this specific to your MAC/PHY combination, or just generally true?
>
> Should this is solved in phylib, because it is true for every MAC/PHY
> combination? phylib returning -EINAL to phy_loopback() would seem like
> the correct thing to do.
>
> Is it specific to your PHY, but independent of the MAC?  Then the PHY
> should return -EINVAL in its set_loopback() method.

My idea is to prevent customers from seeing command failures,
so I switched from half-duplex to full-duplex for testing.
But it doesn't seem quite appropriate.


>
>> +	hdev->hw.mac.duplex_last = phydev->duplex;
>> +
>> +	ret = phy_set_bits(phydev, MII_BMCR, BMCR_FULLDPLX);
> A MAC driver should not be doing this. What if the PHY is C45 only?
> And Marvell PHYs need a soft reset before such an operation take
> effect.
>
>      Andrew

Thanks for the reminder.

Thanks，
Jijie Shao



