Return-Path: <netdev+bounces-64629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05C83612F
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62701F22318
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B73D985;
	Mon, 22 Jan 2024 11:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDB3D555
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921843; cv=none; b=iJJeBMfNimlPDmz/Yxfx7YUxxPuDrIbui6Z7FUYugtHRUynSXDeBqW43W16nIsefJBJfS0HfZ9qX6oq1dN4cG0nfTdj+2DbhKMB8o8xlLT7iMSY0UoNigbhV79N1s0igY/ZlaB5JQgs+O6ilnCmYgAqwe5lQm2BfAUQJAxhvSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921843; c=relaxed/simple;
	bh=jqAQ0aocwD2yzdNRcT8AmKlPYGaNwbKZ6wXASU55qZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BNtcBA+P/LxuueNg+WJedg57+lN5iIVvvdCRJPWpffvANnrNLJdRo+WHbr8MqVuFNKe2md5fz0igUx1FPD/VDZrcBGiej1D7xcBtspxzmDxhyNqB8sYD0qMqKkLZw2qPRKWs1AzWY4yqlFOqylDuQGhvYBMgnq5A6OsQG4mLhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJSCC5ZWsz29kbW;
	Mon, 22 Jan 2024 19:08:55 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 5707E1400CC;
	Mon, 22 Jan 2024 19:10:38 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 19:10:37 +0800
Message-ID: <1451d316-a4ff-354b-e57b-00ef85fba43a@huawei.com>
Date: Mon, 22 Jan 2024 19:10:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v4] netlink: fix potential sleeping issue in
 mqueue_flush_file
To: Pablo Neira Ayuso <pablo@netfilter.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<anjali.k.kulkarni@oracle.com>, <kuniyu@amazon.com>, <fw@strlen.de>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240122011807.2110357-1-shaozhengchao@huawei.com>
 <Za4t110BCZAnlf1o@calendula>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <Za4t110BCZAnlf1o@calendula>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/22 16:56, Pablo Neira Ayuso wrote:
> On Mon, Jan 22, 2024 at 09:18:07AM +0800, Zhengchao Shao wrote:
>> I analyze the potential sleeping issue of the following processes:
>> Thread A                                Thread B
>> ...                                     netlink_create  //ref = 1
>> do_mq_notify                            ...
>>    sock = netlink_getsockbyfilp          ...     //ref = 2
>>    info->notify_sock = sock;             ...
>> ...                                     netlink_sendmsg
>> ...                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
>> ...                                       netlink_unicast
>> ...                                         sk = netlink_getsockbyportid //ref = 3
>> ...                                         netlink_sendskb
>> ...                                           __netlink_sendskb
>> ...                                             skb_queue_tail //put skb to sk_receive_queue
>> ...                                         sock_put //ref = 2
>> ...                                     ...
>> ...                                     netlink_release
>> ...                                       deferred_put_nlk_sk //ref = 1
>> mqueue_flush_file
>>    spin_lock
>>    remove_notification
>>      netlink_sendskb
>>        sock_put  //ref = 0
>>          sk_free
>>            ...
>>            __sk_destruct
>>              netlink_sock_destruct
>>                skb_queue_purge  //get skb from sk_receive_queue
>>                  ...
>>                  __skb_queue_purge_reason
>>                    kfree_skb_reason
>>                      __kfree_skb
>>                      ...
>>                      skb_release_all
>>                        skb_release_head_state
>>                          netlink_skb_destructor
>>                            vfree(skb->head)  //sleeping while holding spinlock
>>
>> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
>> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
>> When the mqueue executes flush, the sleeping bug will occur. Use
>> vfree_atomic instead of vfree in netlink_skb_destructor to solve the issue.
> 
> mqueue notification is of NOTIFY_COOKIE_LEN size:
> 
> static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
> {
>          [...]
>                  if (notification->sigev_notify == SIGEV_THREAD) {
>                          long timeo;
> 
>                          /* create the notify skb */
>                          nc = alloc_skb(NOTIFY_COOKIE_LEN, GFP_KERNEL);
>                          if (!nc)
>                                  return -ENOMEM;
> 
> Do you have a reproducer?
Hi Pablo:
	I donot have reproducer. I found the issue when running syz on
the 5.10 stable branch, but it only happened once. Then I analyzed the
mainline code and found the same issue.
	The sock can be obtained from the value of sigev_signo
transferred by the user in do_mq_notify. And the sock may be of type
netlink, and it is possible to allocate the head area using vmalloc.
Not only release the skb allocated in do_mq_notify, but also release
the skb allocated in netlink_sendmsg when put sock mqueue_flush_file.
What I missed?
Thank you.

Zhengchao Shao

