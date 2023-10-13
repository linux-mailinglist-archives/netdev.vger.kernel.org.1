Return-Path: <netdev+bounces-40628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0927C8081
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3110B209F2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79396FB3;
	Fri, 13 Oct 2023 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9663D4
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:38:53 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B43C2;
	Fri, 13 Oct 2023 01:38:51 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vu1XK7x_1697186328;
Received: from 30.221.100.207(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vu1XK7x_1697186328)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 16:38:49 +0800
Message-ID: <1b317491-5995-4277-bcad-455bece62666@linux.alibaba.com>
Date: Fri, 13 Oct 2023 16:38:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
 <f54560ac-03fd-1a91-e38b-0e67b2c7959d@linux.alibaba.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <f54560ac-03fd-1a91-e38b-0e67b2c7959d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/10/13 16:00, Wen Gu wrote:
> 
> 
> On 2023/10/12 20:37, Dust Li wrote:
> 
>> In the smc_listen_work(), if smc_listen_prfx_check() failed,
>> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
>> SMC_CLC_DECL_NOSMCDEV was returned.
>>
>> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
>> the real reason is much friendly for debugging.
>>
>> Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index bacdd971615e..21d4476b937b 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -2361,7 +2361,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>>           smc_find_ism_store_rc(rc, ini);
>>           return (!rc) ? 0 : ini->rc;
>>       }
>> -    return SMC_CLC_DECL_NOSMCDEV;
>> +    return prfx_rc;
>>   }
>>     /* listen worker: finish RDMA setup */
> Inspired by this fix, I am thinking that is it suitable to store the first
> decline reason rather than real decline reason that caused the return of
> smc_listen_find_device()?
> 
> For example, when running SMC between two peers with only RDMA devices. Then
> in smc_listen_find_device():
> 
> 1. call smc_find_ism_v2_device_serv() and find that no ISMv2 can be used.
>    the reason code will be stored as SMC_CLC_DECL_NOSMCD2DEV.
> 
> ...
> 
> 2. call smc_find_rdma_v1_device_serv() and find a RDMA device, but somehow
>    it failed to create buffers. It should inform users that SMC_CLC_DECL_MEM
>    occurs, but now the reason code returned SMC_CLC_DECL_NOSMCD2DEV.
> 
> I think users may be confused that why peer declines with this reason and
> wonder what happens when trying to use SMC-R.

Yes, the reason code here also makes me confused.
I think it is caused by not correctly using the function smc_find_ism_store_rc.
I'm working for the fix.

> 
> 
> Thanks,
> Wen Gu
> 

