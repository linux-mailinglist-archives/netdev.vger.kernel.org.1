Return-Path: <netdev+bounces-175982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE838A68300
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 03:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA913B5384
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 02:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFEA204851;
	Wed, 19 Mar 2025 02:07:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8643F9D5;
	Wed, 19 Mar 2025 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350031; cv=none; b=WIGAf+IsbwfORwtSqNZgM3vveZn6ZypCo4H0KsP9OuT8aNpEoocKDwhMUuoxH8pA8EqNjWpRyKfYPg9yyiRBI9npoQHwB4tdPP7C5Mc2Z75A+HHiONEuYfBZnOypz4fMKcOReCk3vjNiV7o36ZyapdcmFH/JZgJB6nHBzQZYlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350031; c=relaxed/simple;
	bh=X+3lwp0TioQS/WtgVVfz0yNFE2zM8IMo4P7+1y1JrSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dKQrIqya31wLNWnG8am4xudUyF+4sorWrAmBf4+UyJUQ+ow9+ST2Jomr91buswYHtmfW8ALp1k+Jl54sepaCWVFI81XuKhNGrxS5vWNJv+3qzNudrJHCUcye/mdIVoRNNUae/A4MIrr9yRQzngJXJFEuix2VnxI9U/oVzQdQCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZHXC02ltRz13KfL;
	Wed, 19 Mar 2025 10:06:52 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9788C1402C3;
	Wed, 19 Mar 2025 10:07:05 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 10:07:04 +0800
Message-ID: <94a34aa3-a823-4550-b16a-179e6f6d6292@huawei.com>
Date: Wed, 19 Mar 2025 10:07:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix NULL pointer dereference in l3mdev_l3_rcv
To: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <fw@strlen.de>, <daniel@iogearbox.net>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250313012713.748006-1-wangliang74@huawei.com>
 <20250318143800.GA688833@kernel.org>
 <e8da7ce4-c76c-488e-80cb-dff95bf00fe0@kernel.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <e8da7ce4-c76c-488e-80cb-dff95bf00fe0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/18 23:02, David Ahern 写道:
> On 3/18/25 3:38 PM, Simon Horman wrote:
>> On Thu, Mar 13, 2025 at 09:27:13AM +0800, Wang Liang wrote:
>>> When delete l3s ipvlan:
>>>
>>>      ip link del link eth0 ipvlan1 type ipvlan mode l3s
>>>
>>> This may cause a null pointer dereference:
>>>
>>>      Call trace:
>>>       ip_rcv_finish+0x48/0xd0
>>>       ip_rcv+0x5c/0x100
>>>       __netif_receive_skb_one_core+0x64/0xb0
>>>       __netif_receive_skb+0x20/0x80
>>>       process_backlog+0xb4/0x204
>>>       napi_poll+0xe8/0x294
>>>       net_rx_action+0xd8/0x22c
>>>       __do_softirq+0x12c/0x354
>>>
>>> This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
>>> ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
>>> like this:
>>>
>>>      (CPU1)                     | (CPU2)
>>>      l3mdev_l3_rcv()            |
>>>        check dev->priv_flags:   |
>>>          master = skb->dev;     |
>>>                                 |
>>>                                 | ipvlan_l3s_unregister()
>>>                                 |   set dev->priv_flags
>>>                                 |   dev->l3mdev_ops = NULL;
>>>                                 |
>>>        visit master->l3mdev_ops |
>>>
>>> Add lock for dev->priv_flags and dev->l3mdev_ops is too expensive. Resolve
>>> this issue by add check for master->l3mdev_ops.
>> Hi Wang Liang,
>>
>> It seems to me that checking master->l3mdev_ops like this is racy.
> vrf device leaves the l3mdev ops set; that is probably the better way to go.

Thanks.

Only l3s ipvlan set the dev->l3mdev_ops to NULL at present, I will delete
'dev->l3mdev_ops = NULL' in ipvlan_l3s_unregister(), is that ok?


