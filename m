Return-Path: <netdev+bounces-49022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4187F06EA
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA1C1C203BF
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB179F9;
	Sun, 19 Nov 2023 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943C0128;
	Sun, 19 Nov 2023 06:35:25 -0800 (PST)
X-UUID: 2098c2fc7b834aada21791e7475b1b85-20231119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ec71fa2b-9dec-46e1-a8de-a4f5c23d635d,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:ec71fa2b-9dec-46e1-a8de-a4f5c23d635d,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:9b363a60-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:231118012929Q096TJVV,BulkQuantity:3,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2098c2fc7b834aada21791e7475b1b85-20231119
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 516458896; Sun, 19 Nov 2023 22:35:20 +0800
Message-ID: <26295fac-2617-4219-a2d5-5f009223e655@kylinos.cn>
Date: Sun, 19 Nov 2023 22:35:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231117154831.2518110-1-chentao@kylinos.cn>
 <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric,
Thank you very much for the suggestion, I have modified and resent the 
patch as suggested.

On 2023/11/18 01:29, Eric Dumazet wrote:
> On Fri, Nov 17, 2023 at 6:06 PM Kunwu Chan <chentao@kylinos.cn> wrote:
>>
>> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
>> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
>> net/ipv6/route.c:2332:39:    got restricted __be32
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Same remark, we need a Fixes: tag
> 
>> ---
>>   net/ipv6/route.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index b132feae3393..692c811eb786 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -2329,7 +2329,7 @@ static void ip6_multipath_l3_keys(const struct sk_buff *skb,
>>          } else {
>>                  keys->addrs.v6addrs.src = key_iph->saddr;
>>                  keys->addrs.v6addrs.dst = key_iph->daddr;
>> -               keys->tags.flow_label = ip6_flowlabel(key_iph);
>> +               keys->tags.flow_label = be32_to_cpu(ip6_flowlabel(key_iph));
>>                  keys->basic.ip_proto = key_iph->nexthdr;
>>          }
> 
> This is not consistent with line 2541 doing:
> 
> hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);

