Return-Path: <netdev+bounces-141183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E49B9D7F
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 07:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE910B21FF8
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4706614A4FB;
	Sat,  2 Nov 2024 06:44:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCC154420;
	Sat,  2 Nov 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730529841; cv=none; b=sE/SxTGUoL4sEIVgfN67E7v2OmFvvLmba0RE44Ny2//xGDuArCOwGC/P9lB1YUzQKt9tpzRHSAZUwp+gQatcPzrdplTF7Q5TGnplSsQ8MKBSr+F8E5oYVt6xhtqCmL8l+GOaG7bMflnGbkVoF8rosNDSoJLUJALw+ENAv61oTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730529841; c=relaxed/simple;
	bh=CEPiZmlaOgfiy1fI/76QvlTTEvCqNeS0OgAx6cSUIn4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FonYSMBleYXdpBb9kpgKRgtWKuzeCBI2IsNH5ztEz5wVZuO/hl7BHkLIZobuc9pqCyOWxajH96AO7KrkC0miqftuhxLreby8U/6EDLA/ibbaz+UuPTnROU5jeL33oxXc2tT4skOIp0giWqe90NLFAI8uIs5F/R+PJd67w7RMaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XgSph1xxDz20rHh;
	Sat,  2 Nov 2024 14:42:52 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id A67671A0188;
	Sat,  2 Nov 2024 14:43:54 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 2 Nov
 2024 14:43:53 +0800
Subject: Re: [PATCH net-next] net/smc: Optimize the search method of reused
 buf_desc
To: <dust.li@linux.alibaba.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <kuba@kernel.org>
References: <20241101082342.1254-1-liqiang64@huawei.com>
 <20241101105253.GG101007@linux.alibaba.com>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <fa7dc8fc-fc6a-5ee1-94a2-b4ad62624834@huawei.com>
Date: Sat, 2 Nov 2024 14:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241101105253.GG101007@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf200001.china.huawei.com (7.202.181.227)



�� 2024/11/1 18:52, Dust Li д��:
> On 2024-11-01 16:23:42, liqiang wrote:
>> connections based on redis-benchmark (test in smc loopback-ism mode):
> 
> I think you can run test wrk/nginx test with short-lived connection.
> For example:
> 
> ```
> # client
> wrk -H "Connection: close" http://$serverIp
> 
> # server
> nginx
> ```

I tested with nginx, the test command is:
# server
smc_run nginx

# client
smc_run wrk -t <2,4,8,16,32,64> -c 200 -H "Connection: close" http://127.0.0.1

Requests/sec
--------+---------------+---------------+
req/s	| without patch	| apply patch	|
--------+---------------+---------------+
-t 2	|6924.18	|7456.54	|
--------+---------------+---------------+
-t 4	|8731.68	|9660.33	|
--------+---------------+---------------+
-t 8	|11363.22	|13802.08	|
--------+---------------+---------------+
-t 16	|12040.12	|18666.69	|
--------+---------------+---------------+
-t 32	|11460.82	|17017.28	|
--------+---------------+---------------+
-t 64	|11018.65	|14974.80	|
--------+---------------+---------------+

Transfer/sec
--------+---------------+---------------+
trans/s	| without patch	| apply patch	|
--------+---------------+---------------+
-t 2	|24.72MB	|26.62MB	|
--------+---------------+---------------+
-t 4	|31.18MB	|34.49MB	|
--------+---------------+---------------+
-t 8	|40.57MB	|49.28MB	|
--------+---------------+---------------+
-t 16	|42.99MB	|66.65MB	|
--------+---------------+---------------+
-t 32	|40.92MB	|60.76MB	|
--------+---------------+---------------+
-t 64	|39.34MB	|53.47MB	|
--------+---------------+---------------+

> 
>>
>>    1. On the current version:
>>        [x.832733] smc_buf_get_slot cost:602 ns, walk 10 buf_descs
>>        [x.832860] smc_buf_get_slot cost:329 ns, walk 12 buf_descs
>>        [x.832999] smc_buf_get_slot cost:479 ns, walk 17 buf_descs
>>        [x.833157] smc_buf_get_slot cost:679 ns, walk 13 buf_descs
>>        ...
>>        [x.045240] smc_buf_get_slot cost:5528 ns, walk 196 buf_descs
>>        [x.045389] smc_buf_get_slot cost:4721 ns, walk 197 buf_descs
>>        [x.045537] smc_buf_get_slot cost:4075 ns, walk 198 buf_descs
>>        [x.046010] smc_buf_get_slot cost:6476 ns, walk 199 buf_descs
>>
>>    2. Apply this patch:
>>        [x.180857] smc_buf_get_slot_free cost:75 ns
>>        [x.181001] smc_buf_get_slot_free cost:147 ns
>>        [x.181128] smc_buf_get_slot_free cost:97 ns
>>        [x.181282] smc_buf_get_slot_free cost:132 ns
>>        [x.181451] smc_buf_get_slot_free cost:74 ns
>>
>> It can be seen from the data that it takes about 5~6us to traverse 200 
> 
> Based on your data, I'm afraid the short-lived connection
> test won't show much benificial. Since the time to complete a
> SMC-R connection should be several orders of magnitude larger
> than 100ns.

Sorry, I didn't explain my test data well before.

The main optimized functions of this patch are as follows:

```
struct smc_buf_desc *smc_buf_get_slot(...)
{
	struct smc_buf_desc *buf_slot;
        down_read(lock);
        list_for_each_entry(buf_slot, buf_list, list) {
                if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
                        up_read(lock);
                        return buf_slot;
                }
        }
        up_read(lock);
        return NULL;
}
```
The above data is the time-consuming data of this function.
If the current system has 200 active links, then during the
process of establishing a new SMC connection, this function
must traverse all 200 active links, which will take 5~6us.
If there are already 1,000 for active links, it takes about 30us.

After optimization, this function takes <100ns, it has nothing
to do with the number of active links.

Moreover, the lock has been removed, which is firendly to multi-thread
parallel scenarios.

The optimized code is as follows:

```
static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
{
        struct smc_buf_desc *buf_free;
        struct llist_node *llnode;

        if (llist_empty(buf_llist))
                return NULL;
        // lock-less link list don't need an lock
        llnode = llist_del_first(buf_llist);
        buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
        WRITE_ONCE(buf_free->used, 1);
        return buf_free;
}
```

-- 
Cheers,
Li Qiang

