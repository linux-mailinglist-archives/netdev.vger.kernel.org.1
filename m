Return-Path: <netdev+bounces-49204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590297F1193
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D921C20BB8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE46FBE;
	Mon, 20 Nov 2023 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9F10E4;
	Mon, 20 Nov 2023 03:16:10 -0800 (PST)
X-UUID: beef4f8ad89d4ec4931d5c243f55d868-20231120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:412260c0-b0b1-4902-84f2-0ed738ad25c1,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:412260c0-b0b1-4902-84f2-0ed738ad25c1,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:e38adb72-1bd3-4f48-b671-ada88705968c,B
	ulkID:231120180427G1WW4E38,BulkQuantity:4,Recheck:0,SF:24|17|19|44|64|66|3
	8|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: beef4f8ad89d4ec4931d5c243f55d868-20231120
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2086711540; Mon, 20 Nov 2023 19:15:59 +0800
Message-ID: <69a4bc75-d1a7-482d-9848-26fdc1de78b4@kylinos.cn>
Date: Mon, 20 Nov 2023 19:15:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231117093110.1842011-1-chentao@kylinos.cn>
 <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>
 <20231120100417.GM186930@vergenet.net>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20231120100417.GM186930@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

Thanks for your reply.
For a lot of newcomers who aren't proficient in this part of the code, 
like me, it might be confusing what is the  correct endien and width of 
a protocol.

In response to your question, I wonder if it is necessary to implement a 
unified checking mechanism with a strict parameter validation for all 
invocation parameters?

For example, add an input parameter to the 'tcf_proto_create' to 
represent the endien and width of the protocol, and check the validity 
of the input parameter at the beginning of the function.

I don't have a good idea of how to make sure that the right type is used 
in the call path.
This is just my personal opinion, welcome to discuss.

On 2023/11/20 18:04, Simon Horman wrote:
> On Fri, Nov 17, 2023 at 09:06:45AM -0300, Pedro Tammela wrote:
>> On 17/11/2023 06:31, Kunwu Chan wrote:
>>> net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
>>> net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
>>> net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol
>>>
>>> Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>    net/sched/cls_api.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>>> index 1976bd163986..f73f39f61f66 100644
>>> --- a/net/sched/cls_api.c
>>> +++ b/net/sched/cls_api.c
>>> @@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
>>>    		goto errout;
>>>    	}
>>>    	tp->classify = tp->ops->classify;
>>> -	tp->protocol = protocol;
>>> +	tp->protocol = cpu_to_be16(protocol);
>>>    	tp->prio = prio;
>>>    	tp->chain = chain;
>>>    	spin_lock_init(&tp->lock);
>> I don't believe there's something to fix here either
> 
> Hi Pedro and Kunwu,
> 
> I suspect that updating the byte order of protocol isn't correct
> here - else I'd assume we would have seen a user-visible bug on
> little-endian systems buy now.
> 
> But nonetheless I think there is a problem, which is that the appropriate
> types aren't being used, which means the tooling isn't helping us wrt any
> bugs that might subsequently be added or already lurking. So I think an
> appropriate question is, what is the endien and width of protocol, and how
> can we use an appropriate type throughout the call-path?

