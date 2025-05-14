Return-Path: <netdev+bounces-190290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BBAB60C4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F091463B49
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF51E1DE9;
	Wed, 14 May 2025 02:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C914A0BC;
	Wed, 14 May 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747190433; cv=none; b=iJqrkEWIZO/i1O42LaZFuJ/VW4joeXvdBZlob1KH5fS4MbQCYB2qoN1kbINdh66LVkCMSwPzYjeBpn25PyjoXW6xgRzkyY2D0g8DqIylx7cwSZUXnjr87HpzeCTGZoM49yV6Uqxml8wBufEMhlPoJWhPhHOmz4Eq4Ped7OC3NQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747190433; c=relaxed/simple;
	bh=siBTiJR8JTOtN0Y2baIAG0QCsYrBHYMS9E4vzC5W5wc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BNr57OeuU5u1Fx6JwKR7996PgJunxYK4quDsLQvesgDqvEfetl/Tn+qZjUxvrEKKGZMcr5+kKEd4/T8HSRlWzrN3N41P9Ru72I5dAof+LRMx2atnTZN1epX9bC12MszW7h72cV0AnbkkN/KzBBnkD0XWDMO64lZI9HLd21lcVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZxyH44gFmzsSdH;
	Wed, 14 May 2025 10:39:44 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5995F1A016C;
	Wed, 14 May 2025 10:40:28 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 10:40:27 +0800
Message-ID: <743a78cc-10d4-45f0-9c46-f021258b577d@huawei.com>
Date: Wed, 14 May 2025 10:40:26 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250501072329.39c6304a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/5/1 22:23, Jakub Kicinski wrote:
> On Wed, 30 Apr 2025 17:31:27 +0800 Jijie Shao wrote:
>> If the driver reset fails, it may not work properly.
>> Therefore, the ndo.open() operation should be rejected.
> Why not call netif_device_detach() if the reset failed and let the core
> code handle blocking the callbacks?

Hi:

If driver call netif_device_detach() after reset failed,
The network port cannot be operated. and I can't re-do the reset.
So how does the core code handle blocking callbacks?
Is there a good time to call netif_device_attach()?

Or I need to implement pci_error_handlers.resume()?


[root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
ETHTOOL_RESET 0xffff
Cannot issue ETHTOOL_RESET: Device or resource busy
[root@localhost sjj]# ethtool --reset enp132s0f1 dedicated
ETHTOOL_RESET 0xffff
Cannot issue ETHTOOL_RESET: No such device
[root@localhost sjj]# ifconfig enp132s0f1 up
SIOCSIFFLAGS: No such device

Thanks,
Jijie Shao


