Return-Path: <netdev+bounces-114953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71A944CD0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3941C25DA0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FEE1A38C5;
	Thu,  1 Aug 2024 13:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0A19F487;
	Thu,  1 Aug 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517576; cv=none; b=fDoRKOsVRwSFPh4x7cTY1//uTcUxbc7nIBxEEMW3CAprPqz9kTkznI3XrP60ePaV4WbyD1ey6CRidxqdY1nntYYUKxzaxeVdyMa51DGeUlA5wAA8XgxT5kZMxDp/tGLtT5bvSIxnlmkKCbXy+pyoYnYICCn/3f5zn7Lj0e9EI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517576; c=relaxed/simple;
	bh=SH7rwzo4ZFJASqSKifqUGkj+ROVLOCz9teszX56+Tto=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sIedd8IHUB0qVFslmbvlAsyKShSBoZAy2osuqNmQ06gDG4xHXKIScGgW3NHRd+V/gtYoYHdli2wZ12CDAUJBVJYpHqkxwP0bgFRNZ88nVIIWwl5HtQbB6oluetMZXnmOhXPxcPKh4QdHodisgS4LyxfC2yLUkt9w++kYucCmhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZTc85ymDzyPTd;
	Thu,  1 Aug 2024 21:01:12 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E90918009B;
	Thu,  1 Aug 2024 21:06:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 21:06:11 +0800
Message-ID: <199c085b-a2ed-4d76-bdc6-0f8dde80036d@huawei.com>
Date: Thu, 1 Aug 2024 21:06:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 08/10] net: hibmcge: Implement workqueue and
 some ethtool_ops functions
To: Andrew Lunn <andrew@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-9-shaojijie@huawei.com>
 <b20b5d68-2dab-403c-b37b-084218e001bc@lunn.ch>
 <c44a5759-855a-4a8c-a4d3-d37e16fdebdc@huawei.com>
 <f54fcc51-3a38-49b6-be14-24a7cdcfdada@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <f54fcc51-3a38-49b6-be14-24a7cdcfdada@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/1 20:26, Andrew Lunn wrote:
>>> Why do you need this? phylib will poll the PHY once per second and
>>> call the adjust_link callback whenever the link changes state.
>> However, we hope that the network port can be linked only when
>> the PHY and MAC are linked.
>> The adjust_link callback can ensure that the PHY status is normal,
>> but cannot ensure that the MAC address is linked.
> So why would the SGMII link be down? My experience with SGMII is that
> the link comes up as soon as both ends have power. You are also not
> using in-band signalling, you configure the MAC based on the
> adjust_link callback.
>
> Basically, whenever you do something which no other driver does, you
> need to explain why. Do you see any other MAC driver using SGMII doing
> this?
>
> 	Andrew

Yes, it was my mistake, I should explain why.


If the network port is linked, but the link fails between the SGMII and PHY,
is there any method to find out the cause?

I've had a problem with phy link but SGMII no link due to poor contact.
In this case, the network port no link. Therefore, we can quickly find and analyze the cause.

Or maybe we shouldn't think about the case. because the link is up but packets cannot be received or sent.

Thanks

Jijie Shao


