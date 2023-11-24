Return-Path: <netdev+bounces-50858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E1F7F7550
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50767281FBD
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81B28E17;
	Fri, 24 Nov 2023 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2521FF9;
	Fri, 24 Nov 2023 05:34:48 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vx1k3KH_1700832884;
Received: from 30.221.129.111(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vx1k3KH_1700832884)
          by smtp.aliyun-inc.com;
          Fri, 24 Nov 2023 21:34:46 +0800
Message-ID: <83d3784e-1fed-36b6-22a8-52995fac429e@linux.alibaba.com>
Date: Fri, 24 Nov 2023 21:34:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 0/7] net/smc: implement SMCv2.1 virtual ISM
 device support
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
 <30b53b21-40ad-407a-bef7-ddc28f8978e2@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <30b53b21-40ad-407a-bef7-ddc28f8978e2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/11/24 21:11, Wenjia Zhang wrote:
> 
> 
> On 19.11.23 14:57, Wen Gu wrote:
>> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
>> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
>> OS or hypervisor software, comparable to IBM ISM which is based on platform
>> firmware or hardware.
>>
>> With the introduction of virtual ISM, SMCv2.1 makes some updates:
>>
>> - Introduce feature bitmask to indicate supplemental features.
>> - Reserve a range of CHIDs for virtual ISM.
>> - Support extended GIDs (128 bits) in CLC handshake.
>>
>> So this patch set aims to implement these updates in Linux kernel. And it
>> acts as the first part of the new version of [1].
>>
>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>>
>> Wen Gu (7):
>>    net/smc: Rename some variable 'fce' to 'fce_v2x' for clarity
>>    net/smc: support SMCv2.x supplemental features negotiation
>>    net/smc: introduce virtual ISM device support feature
>>    net/smc: define a reserved CHID range for virtual ISM devices
>>    net/smc: compatible with 128-bits extend GID of virtual ISM device
>>    net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>>    net/smc: manage system EID in SMC stack instead of ISM driver
>>
>>   drivers/s390/net/ism.h     |  6 ---
>>   drivers/s390/net/ism_drv.c | 54 +++++++--------------------
>>   include/linux/ism.h        |  1 -
>>   include/net/smc.h          | 16 +++++---
>>   net/smc/af_smc.c           | 68 ++++++++++++++++++++++++++-------
>>   net/smc/smc.h              |  7 ++++
>>   net/smc/smc_clc.c          | 93 ++++++++++++++++++++++++++++++++--------------
>>   net/smc/smc_clc.h          | 22 +++++++----
>>   net/smc/smc_core.c         | 30 ++++++++++-----
>>   net/smc/smc_core.h         |  8 ++--
>>   net/smc/smc_diag.c         |  7 +++-
>>   net/smc/smc_ism.c          | 57 ++++++++++++++++++++--------
>>   net/smc/smc_ism.h          | 31 +++++++++++++++-
>>   net/smc/smc_pnet.c         |  4 +-
>>   14 files changed, 269 insertions(+), 135 deletions(-)
>>
> 
> Hi Wen Gu,
> 
> Just FYI, the review is still on going and some tests on our plateform still need to do. I'll give you my comments as 
> soon as the testing is done. I think it would be at the beginning of next week.
> 
> Thanks,
> Wenjia

Hi Wenjian,

Thank you very much. I appreciate that you help to test them on your platform since I can only test
them with loopback-ism.

And I am going to send a new version which is rebased to the latest net-next and fix two existing
comments. If the current tests have not started yet, could you please test based on my upcoming v2 ?

Thanks and regards,
Wen Gu

