Return-Path: <netdev+bounces-286996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ByhFCjhAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-286996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBED51C842
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E97E3024141
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392848C405;
	Tue, 12 May 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LEhYBAlD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573248C3FB
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573373; cv=none; b=Z+CSS/cIEtl+llvZjfA1Zwd/bZM09rOwg/LPubzV99/wCkHnnUU71imuYa+aao1TR2MlBuUFJ1WXD9mcKGkdHqzEmNcGiwTlP6HE16zYph6lkKrMoFDmwDYKqvmpn8cIEYj50stG0ZTcSla1lJtqDEp5cWw9T4eOyY67B4zR5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573373; c=relaxed/simple;
	bh=ZUTCCkwuqNmfBsfY6jp+rxUYWDMdjLQhQlLeBUQUQ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMCPLPSKRzjjWt9OijiWOCGi3n02ZyB9E9ZhT8zJHvwn1AXJCFYyiKi2V8D6aFzAYIsYrk5Iahs0mi6QZNf6G7jHmxzVbTkZgcwrFOGFea32T00WqWhhZGuJkAtwcNoM/LBOeO6IQJ3HjOzl6OOppxfgsx44OZFromDERCeUdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LEhYBAlD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so29776355e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778573369; x=1779178169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HLRH4qz571roLdHI5gJO49x2xeNTOoHtjZq1yE+EvM=;
        b=LEhYBAlD8bzJujf8pFJD2EANXlfT95/BbA7RS/kstjXDe2s3vdfGLZJ9jLXzAm8wLs
         IwlIzXD9JnKelwBeRyA4Q5WvlwwzWA0VRoGuV0uIQO7/9tvhkO6zNXos6r5+mgj+HIJQ
         RoQPSSHNuCyP7KinXn199P/7C26TMLpWgqkXrTGgbVEnB9Wvzno7PVNELXbPx11HGUC1
         mI1bydMhyV+ebgbKFcJKUjusfHGr/9zXJrxfPQibQ74NoxEleMyMpwDmrfEyMJ3uSgtT
         vE0Mr24BZF88UijzAdFNc2kzC44Vuyy82WoIOKeJJ5KFl920cHFu7gS0wwsJkj3EEu2r
         cCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573369; x=1779178169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HLRH4qz571roLdHI5gJO49x2xeNTOoHtjZq1yE+EvM=;
        b=IKtfhvzKjlBhpNR84j9zpdmx0nixwxi1gQNlW5/U20KpG7jVfh0hbstPhfGOMb7HyT
         atFfHamRjaAmwCaWf7CzwXx1MPEuiHeSvZsd6EWn842AHMthyd82rt4lUXZ1JgRTPPRX
         2lvT0U8v5estOssnZ3zQ0SRL+AfPMFBWFCGTlqgi9yX/bEGI8zBR2U2jN25ij9XjJmDt
         p9Szt9UINCdFvJyU5XIBgbGlMwT+iv6URJosr2BPsilDaDj7O0rajcaEat/+THbOS2cw
         bLvvuB8nI3yh8pZNKyOL5/ciNJgvyW3aV2jPqjqrkDVtj4M8b0DzfhfUisySY8Vb/mr1
         Rmfg==
X-Forwarded-Encrypted: i=1; AFNElJ9j5/aXVJ22RS687YnfmMWg2mOwBtAzKYufiVjXZSILgYsoT7t9uSR+oYRXWaTEcVUQDcjjEIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DUFrNmnw3H2S0Met2R+1A1iIMsYmy5iFzicM2OONuOTgB0rG
	gCMQRCP+dkB90Lj+QNOUvPjRxIcOzjbO8qfg+3SCNJojRIcPk4DnVmGCdH+XxqXdUYg=
X-Gm-Gg: Acq92OEafPqdetyI8KNW6Y7z+e2vEM12oR4vfIXxZJ8E2bN0Z5iEq/MIdKcJafmmq4x
	YTuaFbKWN0eKDQ1pllHpsjdFXjkvYKG0nlXSy1mgzsla5ah0q+d7t9/S7xmYSXtPPUJM/Zg1rp8
	fa4KUHbacwAcwRtoPQwBbjBBMTuFs9366fkqNxeMWAaGaeN7VsM3iInlEBXmonV5A2jBnVwqNe3
	RJfWqk2ahN8Fg5TfmJGNmiXsDOcGA1UNMf+Z3Jb3GVKDUXiNUoDaeLb8ToMywTRGjXbxeozJA1e
	HMMLoIJqmB1RpTvdaYFhANaS/sr81kqc29qCTVJA7xEuJ4EHKcfBL4S5jFHOijPNIpuUhTqpgH+
	THOJQ2KQTQ4+F/jhQJPD2Nmig48O/jqp10FOCOWoFKg7um+41aUewskejlEkvB/wIjhPYR6OXWN
	6r+PdbQGjXF1HeU77dDKQRtqvfzmJSDQnP1X9p4Bcl6Y/2df0hzwUobA==
X-Received: by 2002:a05:600c:34c9:b0:48e:75fd:9f9e with SMTP id 5b1f17b1804b1-48e8fe7ca80mr29746505e9.20.1778573368095;
        Tue, 12 May 2026 01:09:28 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90681760sm28982565e9.12.2026.05.12.01.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:09:27 -0700 (PDT)
Message-ID: <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
Date: Tue, 12 May 2026 11:09:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
To: Yilin Zhu <zylzyl2333@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, horatiu.vultur@microchip.com,
 kuba@kernel.org, henrik.bjoernlund@microchip.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 ronbogo@outlook.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
 <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7EBED51C842
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lzu.edu.cn,lists.linux.dev,vger.kernel.org,nvidia.com,microchip.com,kernel.org,gmail.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,blackwall.org:email,blackwall.org:mid,blackwall.org:dkim]
X-Rspamd-Action: no action

On 12/05/2026 08:21, Yilin Zhu wrote:
> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
>>> On 10/05/2026 12:15, Ren Wei wrote:
>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>>>
>>>> CFM registers a bridge frame handler when the first MEP is created and
>>>> unregisters it when the last MEP is deleted. The registered object also
>>>> contains the hlist_node used by the bridge-local frame_type_list.
>>>>
>>>> The CFM frame type is currently global, so enabling CFM on multiple
>>>> bridges links the same hlist_node into multiple bridge-local lists. A
>>>> later unregister on one bridge can then operate on list state belonging
>>>> to another bridge.
>>>>
>>>> Move the CFM frame type into struct net_bridge and register/unregister
>>>> the bridge-owned object. This keeps frame handler list membership local
>>>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>>>
>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
>>>> frame RX added.")
>>>> Cc: stable@kernel.org
>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>>> ---
>>>>    net/bridge/br_cfm.c     | 14 ++++++--------
>>>>    net/bridge/br_private.h | 18 +++++++++++-------
>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
>>>>
>>>
>>> I think MRP suffers from the same bug, but I also think we can contain the
>>> fix within the packet type structure instead of making the already huge
>>> struct net_bridge even bigger. Also, linking a struct within net_bridge
>>> to a list within the same net_bridge looks weird.
>>>
>>> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
>>> dynamically and link it, then br_del_frame should take a type instead of a ptr
>>> and remove that frame type and free it with kfree_rcu. That would require
>>> br_add_frame return value to be checked in the respective cfm/mrp functions.
>>> Warnings for already existing types on add or missing types on del should be
>>> added.
>>>
>>
>> Actually I have a better idea since these handlers can be added only once per
>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
>> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
>> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
>> not compiled in. Would you like me to prepare it or do you want to give it a go?
>>
> 
> Hi Nik,
> 
> Thanks for the suggestion.
> 
> I'll give it a go. IIUC, the idea is to remove the shared
> br_frame_type list entries for CFM/MRP, track their per-bridge enable
> state with bridge option bits, and dispatch the CFM/MRP handlers directly
> from the receive path when the corresponding EtherType and option bit
> match.
> 
> I'll include MRP in v2.
> 
> Thanks,
> Yilin
> 

Great, thank you. That should simplify the code and give us 8 bytes of Rx hot
cache line back. The important point is that there haven't been any new
handlers since these were added back in 2020, and also these are not
common, so making their impact on the fast-path as small as possible
while fixing the bug sounds good.

A quick & dirty sketch of the fixes gives me:
5 files changed, 47 insertions(+), 66 deletions(-)

That can probably be improved (i.e. more deletions).

Just please make sure that if CFM/MRP are not enabled in .config, they
would not affect the fast-path at all.

Cheers,
  Nik

>>> Would you please take care of MRP as well?
>>>
>>> Cheers,
>>>    Nik
>>>
>>>> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
>>>> index 118c7ea48c35..547c7415c0ea 100644
>>>> --- a/net/bridge/br_cfm.c
>>>> +++ b/net/bridge/br_cfm.c
>>>> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port,
>>>> struct sk_buff *skb)
>>>>        return 1;
>>>>    }
>>>> -static struct br_frame_type cfm_frame_type __read_mostly = {
>>>> -    .type = cpu_to_be16(ETH_P_CFM),
>>>> -    .frame_handler = br_cfm_frame_rx,
>>>> -};
>>>> -
>>>>    int br_cfm_mep_create(struct net_bridge *br,
>>>>                  const u32 instance,
>>>>                  struct br_cfm_mep_create *const create,
>>>> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
>>>>        INIT_HLIST_HEAD(&mep->peer_mep_list);
>>>>        INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>>>> -    if (hlist_empty(&br->mep_list))
>>>> -        br_add_frame(br, &cfm_frame_type);
>>>> +    if (hlist_empty(&br->mep_list)) {
>>>> +        br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
>>>> +        br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
>>>> +        br_add_frame(br, &br->cfm_frame_type);
>>>> +    }
>>>>        hlist_add_tail_rcu(&mep->head, &br->mep_list);
>>>> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>>>>        kfree_rcu(mep, rcu);
>>>>        if (hlist_empty(&br->mep_list))
>>>> -        br_del_frame(br, &cfm_frame_type);
>>>> +        br_del_frame(br, &br->cfm_frame_type);
>>>>    }
>>>>    int br_cfm_mep_delete(struct net_bridge *br,
>>>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>>>> index bed1b1d9b282..a3ed9ee826f5 100644
>>>> --- a/net/bridge/br_private.h
>>>> +++ b/net/bridge/br_private.h
>>>> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
>>>>    typedef struct mac_addr mac_addr;
>>>>    typedef __u16 port_id;
>>>> +struct net_bridge_port;
>>>> +struct sk_buff;
>>>> +
>>>>    struct bridge_id {
>>>>        unsigned char    prio[2];
>>>>        unsigned char    addr[ETH_ALEN];
>>>> @@ -70,6 +73,13 @@ struct mac_addr {
>>>>        unsigned char    addr[ETH_ALEN];
>>>>    };
>>>> +struct br_frame_type {
>>>> +    __be16            type;
>>>> +    int            (*frame_handler)(struct net_bridge_port *port,
>>>> +                         struct sk_buff *skb);
>>>> +    struct hlist_node    list;
>>>> +};
>>>> +
>>>>    #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>>>    /* our own querier */
>>>>    struct bridge_mcast_own_query {
>>>> @@ -585,6 +595,7 @@ struct net_bridge {
>>>>        struct hlist_head        mrp_list;
>>>>    #endif
>>>>    #if IS_ENABLED(CONFIG_BRIDGE_CFM)
>>>> +    struct br_frame_type    cfm_frame_type;
>>>>        struct hlist_head        mep_list;
>>>>    #endif
>>>>    };
>>>> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct
>>>> net_device *backup_dev);
>>>>    int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff
>>>> *skb);
>>>>    rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>>>> -struct br_frame_type {
>>>> -    __be16            type;
>>>> -    int            (*frame_handler)(struct net_bridge_port *port,
>>>> -                         struct sk_buff *skb);
>>>> -    struct hlist_node    list;
>>>> -};
>>>> -
>>>>    void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
>>>>    void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
>>>
>>


