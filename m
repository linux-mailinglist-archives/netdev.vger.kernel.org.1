Return-Path: <netdev+bounces-48673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF67EF2E0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94BF281238
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BB519463;
	Fri, 17 Nov 2023 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FFD52;
	Fri, 17 Nov 2023 04:43:06 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwZqNA0_1700224983;
Received: from 192.168.50.70(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VwZqNA0_1700224983)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 20:43:04 +0800
Message-ID: <6ebbb7ab-f053-d212-6d88-7eb6754f12a6@linux.alibaba.com>
Date: Fri, 17 Nov 2023 20:43:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v2] net/smc: avoid data corruption caused by decline
Content-Language: en-US
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1700197181-83136-1-git-send-email-alibuda@linux.alibaba.com>
 <7fe3a213-3d2e-42d5-b44b-bbd761a01bba@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <7fe3a213-3d2e-42d5-b44b-bbd761a01bba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/17/23 8:35 PM, Wenjia Zhang wrote:
>
>
> On 17.11.23 05:59, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> We found a data corruption issue during testing of SMC-R on Redis
>> applications.
>>
>> The benchmark has a low probability of reporting a strange error as
>> shown below.
>>
>> "Error: Protocol error, got "\xe2" as reply type byte"
>>
>> Finally, we found that the retrieved error data was as follows:
>>
>> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
>> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
>>
>> It is quite obvious that this is a SMC DECLINE message, which means that
>> the applications received SMC protocol message.
>> We found that this was caused by the following situations:
>>
>> client            server
>>        proposal
>>     ------------->
>>        accept
>>     <-------------
>>        confirm
>>     ------------->
>> wait confirm
>>
>>      failed llc confirm
>>         x------
>> (after 2s)timeout
>>             wait rsp
>>
>> wait decline
>>
>> (after 1s) timeout
>>             (after 2s) timeout
>>         decline
>>     -------------->
>>         decline
>>     <--------------
>>
>> As a result, a decline message was sent in the implementation, and this
>> message was read from TCP by the already-fallback connection.
>>
>> This patch double the client timeout as 2x of the server value,
>> With this simple change, the Decline messages should never cross or
>> collide (during Confirm link timeout).
>>
>> This issue requires an immediate solution, since the protocol updates
>> involve a more long-term solution.
>>
>
> Hi D.Wythe,
>
> I think you understood me wrong. I mean we don't need sysctl. I like 
> the first version more, where you just need to add some comments in 
> the code.
>

😅, ok that. I understood it with wrong way. I will resend the first 
version with comments.

> Thanks,
> Wenjia


