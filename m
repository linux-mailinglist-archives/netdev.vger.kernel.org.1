Return-Path: <netdev+bounces-49019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3A7F06B7
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F971C203B4
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1A1118B;
	Sun, 19 Nov 2023 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F8E6;
	Sun, 19 Nov 2023 06:04:37 -0800 (PST)
X-UUID: fd166c3e721240ddbd62ef20f841775c-20231119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:73491798-38e8-4b57-91e5-290706a0f642,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:73491798-38e8-4b57-91e5-290706a0f642,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:ce9fd172-1bd3-4f48-b671-ada88705968c,B
	ulkID:23111801152865C88OMS,BulkQuantity:3,Recheck:0,SF:19|44|64|66|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: fd166c3e721240ddbd62ef20f841775c-20231119
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1059029858; Sun, 19 Nov 2023 22:04:19 +0800
Message-ID: <d827c4a5-96f9-4d11-a731-03721f51e539@kylinos.cn>
Date: Sun, 19 Nov 2023 22:04:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: Correct/silence an endian warning in
 __ip_do_redirect
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231117152728.2286551-1-chentao@kylinos.cn>
 <CANn89iLHd9oxO6yXmZMfO5cTsnSzqa==ZBCnNEySKpiH86q54Q@mail.gmail.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CANn89iLHd9oxO6yXmZMfO5cTsnSzqa==ZBCnNEySKpiH86q54Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric,
Thank you so much for taking the time to guide me, I'm a rookie who 
really wants to do my part for the kernel, and I can't get started, so I 
thought about eliminating some of the sparse warnings. I've looked at 
some other commits and thought I could resolve the alert this way, sorry 
for the trouble.
Follow your suggestion:
1. I will add a 'Fixes' tag as follows:
'Fixes: 969447f226b4 ("ipv4: use new_gw for redirect neigh lookup")'

2. Refer to the modification method of commit 
3c42b2019863b327caa233072c50739d4144dd16, and modify the patch to:
'n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw); '

On 2023/11/18 01:15, Eric Dumazet wrote:
> On Fri, Nov 17, 2023 at 6:07 PM Kunwu Chan <chentao@kylinos.cn> wrote:
>>
>> net/ipv4/route.c:783:46: warning: incorrect type in argument 2 (different base types)
>> net/ipv4/route.c:783:46:    expected unsigned int [usertype] key
>> net/ipv4/route.c:783:46:    got restricted __be32 [usertype] new_gw
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> We need Fixes: tag for networking patches.
> 
>> ---
>>   net/ipv4/route.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
>> index 3290a4442b4a..e8a542c6b031 100644
>> --- a/net/ipv4/route.c
>> +++ b/net/ipv4/route.c
>> @@ -780,7 +780,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
>>                          goto reject_redirect;
>>          }
>>
>> -       n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
>> +       n = __ipv4_neigh_lookup(rt->dst.dev, be32_to_cpu(new_gw));
>>          if (!n)
>>                  n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
>>          if (!IS_ERR(n)) {
>> --
>> 2.34.1
>>
> 
> How was this patch tested ?
> 
> You are 'fixing' sparse warnings by replacing them with real bugs.
> 
> be32_to_cpu() is going to swap bytes on x86, so the lookup will fail horribly.
> 
> Here, if you must silence sparse, you want (__force u32)new_gw
> 
> Look at this commit for a template.
> 
> commit 3c42b2019863b327caa233072c50739d4144dd16

