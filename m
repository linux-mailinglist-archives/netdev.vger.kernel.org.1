Return-Path: <netdev+bounces-31133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD678BCD7
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 04:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34431280F06
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12263A;
	Tue, 29 Aug 2023 02:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F4360
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 02:32:03 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5601A2;
	Mon, 28 Aug 2023 19:32:00 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VqpTdBj_1693276315;
Received: from 30.221.110.25(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VqpTdBj_1693276315)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 10:31:56 +0800
Message-ID: <484c9f62-748c-6193-9c02-c41449b757b4@linux.alibaba.com>
Date: Tue, 29 Aug 2023 10:31:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 net-next 4/6] net/smc: support max connections per
 lgr negotiation
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 kgraul@linux.ibm.com, tonylu@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-5-guangguan.wang@linux.alibaba.com>
 <a7ed9f2d-5c50-b37f-07d4-088ceef6aeac@linux.ibm.com>
 <9f4292c4-4004-b73b-1079-41ce7b1a5750@linux.alibaba.com>
 <2dbf25a0-05a6-d899-3351-598e952a927d@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <2dbf25a0-05a6-d899-3351-598e952a927d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/28 20:54, Wenjia Zhang wrote:
> 
> 
> On 15.08.23 08:31, Guangguan Wang wrote:
>>
>>
>> On 2023/8/10 00:04, Wenjia Zhang wrote:
>>>
>>>
>>> On 07.08.23 08:27, Guangguan Wang wrote:
>>>> Support max connections per lgr negotiation for SMCR v2.1,
>>>> which is one of smc v2.1 features.
>> ...
>>>> @@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>>>>        confllc->link_num = link->link_id;
>>>>        memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
>>>>        confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
>>>> +    if (link->lgr->smc_version == SMC_V2 &&
>>>> +        link->lgr->peer_smc_release >= SMC_RELEASE_1)
>>>> +        confllc->max_conns = link->lgr->max_conns;
>>>>        /* send llc message */
>>>>        rc = smc_wr_tx_send(link, pend);
>>>>    put_out:
>>>
>>> Did I miss the negotiation process somewhere for the following scenario?
>>> (Example 4 in the document)
>>> Client                 Server
>>>      Proposal(max conns(16))
>>>      ----------------------->
>>>
>>>      Accept(max conns(32))
>>>      <-----------------------
>>>
>>>      Confirm(max conns(32))
>>>      ----------------------->
>>
>> Did you mean the accepted max conns is different(not 32) from the Example 4 when the proposal max conns is 16?
>>
>> As described in (https://www.ibm.com/support/pages/node/7009315) page 41:
>> ...
>> 2. Max conns and max links values sent in the CLC Proposal are the client preferred values.
>> 3. The v2.1 values sent in the Accept message are the final values. The client must accept the values or
>> DECLINE the connection.
>> 4. Max conns and links values sent in the CLC Accept are the final values (server dictates). The server can
>> either honor the client’s preferred values or return different (negotiated but final) values.
>> ...
>>
>> If I understand correctly, the server dictates the final value of max conns, but how the server dictates the final
>> value of max conns is not defined in SMC v2.1. In this patch, the server use the minimum value of client preferred
>> value and server preferred value as the final value of max conns. The max links is negotiated with the same logic.
>>
>> Client                 Server
>>       Proposal(max conns(client preferred))
>>       ----------------------->
>>         Accept(max conns(accepted value)) accepted value=min(client preferred, server preferred)
>>       <-----------------------
>>         Confirm(max conns(accepted value))
>>       ----------------------->
>>
>> I also will add this description into commit message for better understanding.
>>
>> Thanks,
>> Guangguan Wang
>>
>>
>>
> 
> Sorry for the late answer, I'm just back from vacation.
> 
> That's true that the protocol does not define how the server decides the final value(s). I'm wondering if there is some reason for you to use the minimum value instead of maximum (corresponding to the examples in the document). If the both prefered values (client's and server's) are in the range of the acceptable value, why not the maximum? Is there any consideration on that?
> 
> Best,
> Wenjia

Since the value of the default preferred max conns is already the maximum value of the range(16-255), I am wondering
whether it makes any sense to use the maximum for decision, where the negotiated result of max conns is always 255.
So does the max links. 

Thanks,
Guangguan

