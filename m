Return-Path: <netdev+bounces-286282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKGjGcFuAGqvIwEAu9opvQ
	(envelope-from <netdev+bounces-286282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C542A503D0A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 474C230160F6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66D3815CC;
	Sun, 10 May 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hGEtmydo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1E3815C2
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778413222; cv=none; b=uMS4ntiGE4W6D2wvB/o5ai6ifbYEqyGAR/DZhvMUXD1uABuOeL/V2XpK0U3b5k67HOXWLuadsc3B3SkZ2ydRlZFNY1hAsJq4u6kUBFyyb4ewQk/MUhedsrxcUVAh6SrHZRL7b6PuwnNSHOhd7p0+p9YW04zd5JxzYtNbdNOoWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778413222; c=relaxed/simple;
	bh=/Wo3+PBXbAXUlTotZqvdk9KEBPgZ8FLOpMFS4dkqvGk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lWplaa01zWa4Eh0V4IrZzlbWBK4O341GZhUvHuwqVsr4+Ye9rEnNFUcu+gPJyWvV0qwMDqLd6Ak9SiR55m2gJb6fnL4lJMLrqAEA014O6wockzvtBcSrhCkJJKjy3qWVoTmVK9dHur8gZhbKWRMqHnuc3ISSVnPYE1SdQCMR5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hGEtmydo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e1860558fso2169244f8f.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778413219; x=1779018019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MU0V5qtLR9exTpcGnpIFJuqzegnzuD5wERdsIC6ROXI=;
        b=hGEtmydokSC9+RiKTGQ9zSd3VK9Q3nPBjqmCIx4rLRM6zSpTqAZFHMqlZkQJcqlt8D
         lWMzq/EACsB8OgRI0ZyliOTg7fRlYADf+0WvVnsGGg3W4rMl7nHziK5uX+ezQrF2aW+I
         7nsaC5lC+/U+5EEGscUzZ0bYYjBxAIu9fbLMA1ywSyNKu9qqmmKgPjwrsl+1eIdjI8ud
         hVqDXIDMpQ+rF3ZZjm42Ifj+ck3JATZeLERfGmcMCiAMm10vnzhnvt7r+ub36nG87eHp
         CKlZUT8LFd6YDx9z6gSv5aHRu40vtM5x1FNZBkfoDwPsOL5S5y+FKBq9DqVcpBqQfcjz
         Ddcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778413219; x=1779018019;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MU0V5qtLR9exTpcGnpIFJuqzegnzuD5wERdsIC6ROXI=;
        b=kzeMNfAOxIYpEli2/k2iRZ1HSX8mXwXxcFE8nEGS6jg7aTK3vIsybmj8x9CU9kPzT5
         j+rgt6nerKnu1e+6M+dxKLRO1vfnsuxME+NiDgV3dXd37f5BneOhv+PllnkWfxTWPMwa
         bc9moulgHkEoa3q2zUFCkAUAjDY5afHrZaPybhVbSSXzAyxXyX0i252LTE8M1gp8k9UZ
         g4cKZdlshWaEaB043PVKe1ovdYGUpaf/PgQKKBQ29stOO63XdyB2Y7C4g+NLRmCrROU7
         V10xQxVO87XWuhntc1m2pGGXSB0T9wur5u5t7BboMI6yDCxiIBB6MvgU1QXzkdDzOPAq
         wGDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XUGEkZLlNfl2LPHOjGg9vCmRy/ieazQOXk8tw14lW0wg3B5PmY8uZcKf4Gag3i+i/jJkxSi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXxLd4RL4XxmPGDhQvBU6MfwX1YBF4OeL+v0NinsLnOg6oowQ
	XwcreWe+4vW4WWftQqIyhQJu+tF0o17u8jyrCTtVeBFc3Ld0nM+O+kzi/vmcJPoJ1no=
X-Gm-Gg: Acq92OErratIBZcIh56AJyd5s0h1VH9M0Xmkf5soBGp6rVXFVEPdQLERUs4MbtoYsoY
	vtSjCbPomFCzi5Tus4yeGyW2szOxygqaVpCz5WTulBQbw5hfVMsOO/ZkdTf1YdDH7q2BaIdB+fc
	Kp5Y6nMN2ALzujxiRj5FnPypk50Sg5kuItkXMN6dtQN/t4yWfXAF/7Z+RIu6jHb2ju7UUQNjhTL
	SXusi06W7bVIEUfNE73RWTJbTqB7GjFkqSI8yVn6A3s8lVGoDkd1dWAlMC5rYEfpeUiXXIBxE1g
	3hJXJSTjUC/xQ5Nha1KGtSm5/eJ8eHwjTs/N2Ev6st6LDQCt4/qpsCV2nnPy0WqvVEQ8Xrmi4M7
	YBxNtuFon2zMuw5Mr5jeeTkHvR7omxQu/YGVYsd+a4xoRXbxDdDnVCKlKm7cdsYei1Q2Q8OlGmu
	/ev3Ulxa1v21OtmGXfzIdEpJ0u959xbudZjWIy67uhq644tmNk5ycV3Q==
X-Received: by 2002:a05:6000:26cf:b0:44e:902f:e341 with SMTP id ffacd0b85a97d-45462c342a3mr15284725f8f.20.1778413218879;
        Sun, 10 May 2026 04:40:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm18054698f8f.18.2026.05.10.04.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 04:40:18 -0700 (PDT)
Message-ID: <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
Date: Sun, 10 May 2026 14:40:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, horatiu.vultur@microchip.com, kuba@kernel.org,
 henrik.bjoernlund@microchip.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com,
 zylzyl2333@gmail.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
In-Reply-To: <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C542A503D0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286282-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,microchip.com,kernel.org,gmail.com,lzu.edu.cn,outlook.com];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
> On 10/05/2026 12:15, Ren Wei wrote:
>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>
>> CFM registers a bridge frame handler when the first MEP is created and
>> unregisters it when the last MEP is deleted. The registered object also
>> contains the hlist_node used by the bridge-local frame_type_list.
>>
>> The CFM frame type is currently global, so enabling CFM on multiple
>> bridges links the same hlist_node into multiple bridge-local lists. A
>> later unregister on one bridge can then operate on list state belonging
>> to another bridge.
>>
>> Move the CFM frame type into struct net_bridge and register/unregister
>> the bridge-owned object. This keeps frame handler list membership local
>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>
>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM 
>> frame RX added.")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>   net/bridge/br_cfm.c     | 14 ++++++--------
>>   net/bridge/br_private.h | 18 +++++++++++-------
>>   2 files changed, 17 insertions(+), 15 deletions(-)
>>
> 
> I think MRP suffers from the same bug, but I also think we can contain the
> fix within the packet type structure instead of making the already huge
> struct net_bridge even bigger. Also, linking a struct within net_bridge
> to a list within the same net_bridge looks weird.
> 
> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
> dynamically and link it, then br_del_frame should take a type instead of a ptr
> and remove that frame type and free it with kfree_rcu. That would require
> br_add_frame return value to be checked in the respective cfm/mrp functions.
> Warnings for already existing types on add or missing types on del should be
> added.
> 

Actually I have a better idea since these handlers can be added only once per
bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
which is in a Rx hot cache line) and even reduce net_bridge size while fixing
these bugs, and also remove a conditional from the fast-path when CFM/MRP are
not compiled in. Would you like me to prepare it or do you want to give it a go?

> Would you please take care of MRP as well?
> 
> Cheers,
>   Nik
> 
>> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
>> index 118c7ea48c35..547c7415c0ea 100644
>> --- a/net/bridge/br_cfm.c
>> +++ b/net/bridge/br_cfm.c
>> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, 
>> struct sk_buff *skb)
>>       return 1;
>>   }
>> -static struct br_frame_type cfm_frame_type __read_mostly = {
>> -    .type = cpu_to_be16(ETH_P_CFM),
>> -    .frame_handler = br_cfm_frame_rx,
>> -};
>> -
>>   int br_cfm_mep_create(struct net_bridge *br,
>>                 const u32 instance,
>>                 struct br_cfm_mep_create *const create,
>> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
>>       INIT_HLIST_HEAD(&mep->peer_mep_list);
>>       INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>> -    if (hlist_empty(&br->mep_list))
>> -        br_add_frame(br, &cfm_frame_type);
>> +    if (hlist_empty(&br->mep_list)) {
>> +        br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
>> +        br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
>> +        br_add_frame(br, &br->cfm_frame_type);
>> +    }
>>       hlist_add_tail_rcu(&mep->head, &br->mep_list);
>> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>>       kfree_rcu(mep, rcu);
>>       if (hlist_empty(&br->mep_list))
>> -        br_del_frame(br, &cfm_frame_type);
>> +        br_del_frame(br, &br->cfm_frame_type);
>>   }
>>   int br_cfm_mep_delete(struct net_bridge *br,
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index bed1b1d9b282..a3ed9ee826f5 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
>>   typedef struct mac_addr mac_addr;
>>   typedef __u16 port_id;
>> +struct net_bridge_port;
>> +struct sk_buff;
>> +
>>   struct bridge_id {
>>       unsigned char    prio[2];
>>       unsigned char    addr[ETH_ALEN];
>> @@ -70,6 +73,13 @@ struct mac_addr {
>>       unsigned char    addr[ETH_ALEN];
>>   };
>> +struct br_frame_type {
>> +    __be16            type;
>> +    int            (*frame_handler)(struct net_bridge_port *port,
>> +                         struct sk_buff *skb);
>> +    struct hlist_node    list;
>> +};
>> +
>>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>   /* our own querier */
>>   struct bridge_mcast_own_query {
>> @@ -585,6 +595,7 @@ struct net_bridge {
>>       struct hlist_head        mrp_list;
>>   #endif
>>   #if IS_ENABLED(CONFIG_BRIDGE_CFM)
>> +    struct br_frame_type    cfm_frame_type;
>>       struct hlist_head        mep_list;
>>   #endif
>>   };
>> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct 
>> net_device *backup_dev);
>>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff 
>> *skb);
>>   rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>> -struct br_frame_type {
>> -    __be16            type;
>> -    int            (*frame_handler)(struct net_bridge_port *port,
>> -                         struct sk_buff *skb);
>> -    struct hlist_node    list;
>> -};
>> -
>>   void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
>>   void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
> 


