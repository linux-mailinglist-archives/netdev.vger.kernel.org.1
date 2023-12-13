Return-Path: <netdev+bounces-56778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE4810D26
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FB72814E6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E381EB58;
	Wed, 13 Dec 2023 09:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 921 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 01:16:01 PST
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114C112
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 01:16:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SqqDL3yBXz1Q6MS;
	Wed, 13 Dec 2023 16:59:30 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 51EA71A0192;
	Wed, 13 Dec 2023 17:00:38 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 17:00:37 +0800
Message-ID: <1fbd6b74-1080-923a-01c1-689c3d65f880@huawei.com>
Date: Wed, 13 Dec 2023 17:00:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [question] smc: how to enable SMC_LO feature
From: shaozhengchao <shaozhengchao@huawei.com>
To: Wen Gu <guwen@linux.alibaba.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, yuehaibing
	<yuehaibing@huawei.com>, "Libin (Huawei)" <huawei.libin@huawei.com>, Dust Li
	<dust.li@linux.alibaba.com>, tonylu_linux <tonylu@linux.alibaba.com>, "D.
 Wythe" <alibuda@linux.alibaba.com>
References: <8ac15e20beb54acfae1a35d1603c1827@huawei.com>
 <ad29f704-ae79-4c4b-2227-d0fa9a1ceee2@linux.alibaba.com>
 <a6b4b010-ffca-50ea-1296-3e01eacb4f53@huawei.com>
 <9eb58434-922e-c9e4-6a38-4c29ba0e88f6@huawei.com>
 <2d138d78-1ebb-92b0-c6c5-9e43b5ee941b@linux.alibaba.com>
 <488311be-5673-552c-d932-26f87e863777@huawei.com>
 <c7b3f24e-6f25-08a5-bbe4-a32dc3d31adf@huawei.com>
In-Reply-To: <c7b3f24e-6f25-08a5-bbe4-a32dc3d31adf@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2023/12/5 14:45, shaozhengchao wrote:
> 
> 
> On 2023/12/4 12:06, shaozhengchao wrote:
>>
>>
>> On 2023/12/4 11:52, Wen Gu wrote:
>>>
>>> On 2023/12/4 11:22, shaozhengchao wrote:
>>>>
>>>>
>>>> On 2023/11/23 14:15, shaozhengchao wrote:
>>>>>
>>>>>
>>>>> On 2023/11/23 10:21, Wen Gu wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/11/21 20:14, shaozhengchao wrote:
>>>>>>> Hi Wen Gu:
>>>>>>> Currently, I am interested in the SMC_LOOPBACK feature proposed
>>>>>>> by you. Therefore, I use your patchset[1] to test the SMC_LO 
>>>>>>> feature on
>>>>>>> my x86_64 environment and kernel is based on linux-next, commit: 
>>>>>>> 5ba73bec5e7b.
>>>>>>> The test result shows that the smc_lo feature cannot be enabled. 
>>>>>>> Here's
>>>>>>> my analysis:
>>>>>>>
>>>>>>> 1. Run the following command to perform the test, and then capture
>>>>>>> packets on the lo device.
>>>>>>> - serv:  smc_run taskset -c <cpu> sockperf sr --tcp
>>>>>>> - clnt:  smc_run taskset -c <cpu> sockperf  tp --tcp 
>>>>>>> --msg-size=64000 -i 127.0.0.1 -t 30
>>>>>>>
>>>>>>> 2. Use Wireshark to open packets. It is found that the VCE port 
>>>>>>> replies with
>>>>>>> SMC-R-Deline packets.
>>>>>>> [cid:image001.png@01DA1CB4.F1052C30]
>>>>>>>
>>>>>>> 3. Rx
>>>>>>> When smc_listen_work invokes smc_listen_v2_check, the VCE port 
>>>>>>> returns
>>>>>>> a Decline packet because eid_cnt and flag.seid in the received 
>>>>>>> packet are both 0.
>>>>>>>
>>>>>>> 4. Tx
>>>>>>> In smc_clc_send_proposal,
>>>>>>> v2_ext->hdr.eid_cnt = smc_clc_eid_table.ueid_cnt;
>>>>>>> v2_ext->hdr.flag.seid = smc_clc_eid_table.seid_enabled;
>>>>>>>
>>>>>>> When smc_clc_init, ueid_cnt=0, and in the x86_64 environment, 
>>>>>>> seid_enabled is
>>>>>>> always equal to 0.
>>>>>>>
>>>>>>> So, I must call smc_clc_ueid_add function to increase ueid count?
>>>>>>> But I don't see where operations can be added, may I missed 
>>>>>>> something?
>>>>>>>
>>>>>>
>>>>>> Hi Zhengchao Shao,
>>>>>>
>>>>>> Yes. When using SMC-D in non-s390 architecture (like x86 here), A 
>>>>>> common
>>>>>> UEID should be set. It can be set by following steps:
>>>>>>
>>>>>> - Install smc-tools[1].
>>>>>>
>>>>>> - Run # smcd ueid add <ueid> in loopback test environment.
>>>>>>
>>>>>>    EID works as an ID to indicate the max communication space of 
>>>>>> SMC. When SEID is
>>>>>>    unavailable, an UEID is required.
>>>>>>
>>>>> Hi Wen Gu:
>>>>>      Thank you for your reply. This is very useful for me. And I will
>>>>> be happy to learn from it.
>>>>>
>>>>> Thanks
>>>>>
>>>>> Zhengchao Shao
>>>>>> - Then run the test.
>>>>>>
>>>>>> Hope this works for you :)
>>>>>>
>>>>>> [1] https://github.com/ibm-s390-linux/smc-tools
>>>>>>
>>>>>> Regards,
>>>>>> Wen Gu
>>>>>>
>>>>>>> Could you give me some advice? Thanks very much.
>>>>>>>
>>>>>>> Zhengchao Shao
>>>>>>>
>>>>>>>
>>>>>>> [1]link: 
>>>>>>> https://patchwork.kernel.org/project/netdevbpf/cover/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>> Hi Wen Gu:
>>>>      I have test as following, but the performance is really
>>>> degraded. Now I have no idea.
>>>> 1. add ueid
>>>> run: smcd ueid add 16
>>>> kernel message:
>>>> [ 5252.009133] NET: Registered PF_SMC protocol family
>>>> [ 5252.009233] smc: adding smcd device smc_lo with pnetid
>>>> 2. start server
>>>> smc_run taskset -c 1 sockperf sr --tcp
>>>> 3. start client
>>>> smc_run taskset -c 3 sockperf tp  --tcp --msg-size=64000 -i 
>>>> 127.0.0.1 -t 30
>>>>
>>>> The test results are as follows:
>>>>                TCP                  SMC-lo
>>>> Bandwidth(MBps)         1890.56               1300.41(-31.22%)
>>>>
>>>> I didn't find a better direction when I initially positioned it. No
>>>> error is recorded in the kernel log, and the smcd statistics are 
>>>> normal.
>>>> [root@localhost smc-tools]# smcd stats
>>>> SMC-D Connections Summary
>>>>    Total connections handled             2
>>>>    SMC connections                       2
>>>>    Handshake errors                      0
>>>>    Avg requests per SMC conn       1277462.0
>>>>    TCP fallback                          0
>>>>
>>>> RX Stats
>>>>    Data transmitted (Bytes)    40907328000 (40.91G)
>>>>    Total requests                  1277190
>>>>    Buffer full                          45 (0.00%)
>>>>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  
>>>> >512KB
>>>>    Bufs        0       0       0       2       0       0       
>>>> 0       0
>>>>    Reqs   638.0K       0       0  639.2K       0       0       
>>>> 0       0
>>>>
>>>> TX Stats
>>>>    Data transmitted (Bytes)    40907328000 (40.91G)
>>>>    Total requests                  1277734
>>>>    Buffer full                      638239 (49.95%)
>>>>    Buffer full (remote)                  0 (0.00%)
>>>>    Buffer too small                      0 (0.00%)
>>>>    Buffer too small (remote)             0 (0.00%)
>>>>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  
>>>> >512KB
>>>>    Bufs        0       0       0       0       0       0       
>>>> 0       0
>>>>    Reqs        0       0       0  1.278M       0       0       
>>>> 0       0
>>>>
>>>> Extras
>>>>    Special socket calls                  1
>>>>
>>>> I captured the perf information and found that the percentage of
>>>> rep_movs_alternative and _raw_spin_unlock_irqrestore functions was high
>>>> during tx and rx.
>>>> 36.12%  [kernel]         [k]rep_movs_alternative
>>>> 14.23%  [kernel]         [k]_raw_spin_unlock_irqrestore
>>>>
>>>> I've attached the flame map. Could you help analyze it? What I missed?
>>>> Thanks.
>>>
>>> Hi Zhengchao Shao,
>>>
>>> Since sndbuf and RMB in SMC are pre-alloced ringbuf and won't grow 
>>> dynamically
>>> like TCP, it is necessary to appropriately increase the default value 
>>> of smc
>>> sk_sndbuf and sk_rcvbuf before testing throughput.
>>>
>>> Set this and try again:
>>>
>>> # sysctl -w net.smc.wmem=1048576
>>> # sysctl -w net.smc.rmem=1048576
>>>
>>> (The initial value of wmem and rmem are 64K)
>>>
>>> Regards,
>>> Wen Gu
>>>
>>>>
>>>> Zhengchao Shao
>> Hi Wen Gu:
>>      It solves the issue. Thank you very much.
>>
>> Zhengchao Shao
>>
> Hi Wen Gu:
>    I've tested all the performance test items in the patchset. The
> performance improvement is to be expected, except for nignx.
> My VM is configured with 48 cores and 32 GB memory. Therefore, run
> the following command:
> <smc_run> nignx
> <smc_run>./wrk -t 96 -c 1000 -d 30 http://127.0.0.1:80
> 
> The test results are as follows:
>                          TCP                         SMC_lo
> Requests/s           309425.42               135547.25(-56.19%)
> The performance decreases by 56.19%.
> 
> I capture packets and find that wrk can perform HTTP GET after each
> connect when smc_loopback is disabled.
> However, when smc_loopback is enabled, there is no HTTP GET behavior.
> I wonder if there is some compatibility problem with the SMC protocol 
> when encapsulate packet? Could you give me some advice?
> In the attachment, I captured some of the packets.
> nosmc_nginx.pcap is for SMC disabled and smc_nginx.pcap is for SMC
> enabled.
> Thank you very much.
> 
> Zhengchao Shao
> 
> 
> 
Hi Wen Gu:
	When the VM is configured with 8 cores and 16 GB memory, run
the following command:
<smc_run> nignx
<smc_run>./wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
the test data is as follows:
	     TCP          SMC_lo
Requests/s  66056.66    94526.66(43.10%)

But When the VM is configured with 48 cores and 32 GB memory, run
the following command:
<smc_run> nignx
<smc_run>./wrk -t 96 -c 1000 -d 30 http://127.0.0.1:80
the test data is as follows:
	     TCP          SMC_lo
Requests/s  309425.42     135547.25(-56.19%)

It seems that in the scenario with a large number of CPU cores,
performance is not optimized, but performance deteriorates. What I
missed?
Thank you.

Zhengchao Shao

