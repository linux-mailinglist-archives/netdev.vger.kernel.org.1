Return-Path: <netdev+bounces-63889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586782FEEE
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179791F25A3F
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 02:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5FEBE;
	Wed, 17 Jan 2024 02:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663817F5
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459739; cv=none; b=lmSuYXnZaxtKqmxPZ1ilhibM27xCrBiDlUvib/z9UrYk6r+okp7M+bez7izvTkqPxnagFuhsSXkkkCg/Nex6KP6Tgu/lfApUAJYvYqbD4BOLRuIG6bUMSXsFNgEHb94D1TA1jRphldoUTAaLnJJoQqrQgrki5/HZB1/kVwtAyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459739; c=relaxed/simple;
	bh=n6Jb3ozWTbJqkOaAaCMbRWrZPHdd0Aa6g8/BVN69Rco=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=IwZEJx2HLTjVl0wFBt1wRnASw+RaA3/ATZHSnBSO0/Us4iZzjtm6H003QZyvp1OXGRHGNCra2Uzf65zCDQYjpmWF1X9Aqs+/wIZ/Pxm1u9g9jhll97xg8FGxwNlxVSrhhe29tgBdOFjYAM2+nrk7D3Qtojhoc/WCfJUnFhbtnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TF9Fh5KrSz1FJQG;
	Wed, 17 Jan 2024 10:44:40 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 626C71800A9;
	Wed, 17 Jan 2024 10:48:54 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:48:53 +0800
Message-ID: <a0adea69-aea1-d35a-6a34-e1544a7ce1a5@huawei.com>
Date: Wed, 17 Jan 2024 10:48:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] tcp: make sure init the accept_queue's spinlocks
 once
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <hkchu@google.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240113030739.3446338-1-shaozhengchao@huawei.com>
 <CANn89i+nmdm5aRNC0mvuVufyRq+fzvKMU9KtSdBMXjMBosgxTA@mail.gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CANn89i+nmdm5aRNC0mvuVufyRq+fzvKMU9KtSdBMXjMBosgxTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/16 18:38, Eric Dumazet wrote:
> On Sat, Jan 13, 2024 at 3:57 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>>
>> When I run syz's reproduction C program locally, it causes the following
>> issue:
>> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
>> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
>> Ha
> 
> 
>> When the socket receives the ACK packet during the three-way handshake,
>> it will hold spinlock. And then the user actively shutdowns the socket
>> and listens to the socket immediately, the spinlock will be initialized.
>> When the socket is going to release the spinlock, a warning is generated.
>> Also the same issue to fastopenq.lock.
>>
>> Add 'init_done' to make sure init the accept_queue's spinlocks once.
>>
>> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
>> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
>> ---
>>   include/net/request_sock.h | 1 +
>>   net/core/request_sock.c    | 7 +++++--
>>   net/ipv4/tcp.c             | 1 +
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
>> index 144c39db9898..0054746fe92d 100644
>> --- a/include/net/request_sock.h
>> +++ b/include/net/request_sock.h
>> @@ -175,6 +175,7 @@ struct fastopen_queue {
>>   struct request_sock_queue {
>>          spinlock_t              rskq_lock;
>>          u8                      rskq_defer_accept;
>> +       bool                    init_done;
>>
> 
> No, we should not add a new field for this.
> The idea of having a conditional  spin_lock_init() is not very nice
> for code readability.
> 
> Just always init request_sock_queue spinlocks for all inet sockets at
> socket() and accept() time,
> not at listen() time.
> 
> This structure is not dynamically allocated, and part of 'struct
> inet_connection_sock'...
Hi Eric:
	It looks good to me. I will send V3.
Thank you.

Zhengchao Shao

