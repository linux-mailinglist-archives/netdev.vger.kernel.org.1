Return-Path: <netdev+bounces-253576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG5IIWa/d2mokgEAu9opvQ
	(envelope-from <netdev+bounces-253576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:24:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E18C846
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C34930238E2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF2283FFB;
	Mon, 26 Jan 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdIZyyha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43427877D
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455436; cv=none; b=C8IblD/1BTvyW2CMX9hiWKfwSBK+0yqAf4c14tqfWwrsNdZz0KY1s8giAjjP3JCfnYwo525UWYWoWZdZO5T/b2LWX346LTf74gXBpqSmC48IMGwYg7vkvyF9oKkhhElU/aX7SYl/kWXCXnHbF50oHl1bWgUa3m6LxwQLi2Mz2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455436; c=relaxed/simple;
	bh=LMsrRNat173JG+q7tHaBWy1vryS9nSZpUbgPkLfXYBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQWxAO4myZjsa4Uxgo4qbPBTRc3uE6yBlKlZbU8Qs0sXMrdkF1oLv6nCpO2IpS1SaYcR1ldz+J8h00IuSvW0gDDB2lX5wMwyfw7WekIwRH4OOFpuIzdxpFzbGcxy6nxQgW93I7gtyN6ETC5sa4kkmUvxZJkWJJIg0nhI+svLo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdIZyyha; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so37517375e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769455433; x=1770060233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZLBnN5OFx0/ZZ+2vMemqH33ywlcMfVR0hiVpOye37c=;
        b=MdIZyyha0l3natPKkfkDOrg6tUFVLCx0CNGt+HdZDwDIsb7IQRDepHePU1diXR3lc4
         EuxXd8cJnUde6MXTFAi/zymhtJPq35seNvNmf/zjIfpiFIL6eZf/NcrBs06z8T7TROve
         Id4jjVoFUUC9dDdv546pgGCaXeDyLgNClW6AxkY+IJmCPhI2CtciIQawWYeU7YVmk3OF
         BDAllA0IwaquV5QFSBA9pWuvAkOFpE61Zd5CeuRy6z/OdBiHCnxBglDFzh6NHGqhrBJm
         c5LkRYE1yzUv7cg8HH3v3fW1sYN2m0Qdeuz1r6uXX9MtaVnzCNJLuaN77kkj1MW6p19v
         DBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769455433; x=1770060233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZLBnN5OFx0/ZZ+2vMemqH33ywlcMfVR0hiVpOye37c=;
        b=sUSM+IqDWR1x+dAsYsyH+bB3ji3PRaaxxEMMfJRx30LKUJWvW90FDLnjtkGVmMzOEj
         Ifcosn2BhXgFfwFNtCq6PYK3wmimj0t03wjZBKszPQmud/r18FskVrJPOk5naK0iwRCf
         Xjb2jpnAAEK7y6D/yFXwXa7XFbuLBfsujNR81UdcvIq36gRYAojXXYQ6bWfbHvmDB2Kk
         DBwIDti06dm/4p6cBW6nRp5pd5USy4WqJhhcYpL1uoawyKMXXHvhHutNph8ZLJVyv6oK
         7hNl1NofrzK7YOkm4ooQDwgRq/LY1FtNTw10RFkzdKtXw70cg6FKgbtriCyEywKFAuKe
         ciFw==
X-Forwarded-Encrypted: i=1; AJvYcCWgT4AMFxxYfM7hInuhlMXHRyPjS2rvHFsfBk9TXMvpS9HUpVn6JUFdTwNB6fBWwP3Pauzg6Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNQx+eDGGX51I8ZEGN5c4USWvubySepljqbm9hz3hxbNpXpXJ
	b+uwJPI+lv5kLL4h1HTVPx8YsAO6AXka2grh+3GLmwWdw5vHbNHG7Ypj
X-Gm-Gg: AZuq6aJIDEMp5k3iEp9f5mlGhX5GfgJ6Ogsto89Hngj8/SNbIFYrdgQlYaS20kVXX7O
	VEE5Bhvy8gB8Gb60fmdtXVRo6DVL8zxzi2AfdHXNYoQGWsoxn7w8y7DWxUkZAr48Bwsi4tO+/4C
	wL2xhrEGWI6sRzZaexGgiDqFa9Z9Mo9qlWNE5F3o3MAOkZfzzd2M3U8IhHuBGuuUo1ZpXFKr54N
	ebeIJfKo4kjP4w5TXSXZZbpyqdRF+W3zta9MQr2Yir3XsGGbzPmDlP/UMpOHbAVl53TanG0kJPc
	x1yy12iurY2ch3qkmhNPQ4OZv89tPA0G4GaK8He6g1DmgkQ1x0va0nziFJlXXHdQTeAw5Y8eVss
	qKupQL0o212hLnAhIL/qclbWBuf8yK175OZAW2L1zRp8HwID3lmxJLi7wVne+9UZTY1z8PvUU02
	a8F5Dec3iZoguC6mCf7BEr9SlewwTTQ6Z33xXfcPw0UMSFu5lXztIFP8s0WD2pzhJjRQ==
X-Received: by 2002:a05:600c:3b9d:b0:47e:de23:dd6f with SMTP id 5b1f17b1804b1-4805ce42a6dmr91880355e9.12.1769455432989;
        Mon, 26 Jan 2026 11:23:52 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:8344:7d7e:8067:4516? ([2a02:a03f:a75e:9a00:8344:7d7e:8067:4516])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbd8696sm112714955e9.8.2026.01.26.11.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 11:23:52 -0800 (PST)
Message-ID: <db979c8f-8ee9-4717-9cd3-c3125e33580b@gmail.com>
Date: Mon, 26 Jan 2026 20:23:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/7] ipv6: Enforce Extension Header ordering
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
References: <20260121214925.112604-1-tom@herbertland.com>
 <20260121214925.112604-7-tom@herbertland.com>
 <5dca897a-700f-41da-afa4-37a497346f97@gmail.com>
 <CALx6S37q84Ou+iD7y4fXjBbKabeJYJaU8iQs_fzLMTD8zwJkEg@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <CALx6S37q84Ou+iD7y4fXjBbKabeJYJaU8iQs_fzLMTD8zwJkEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url]
X-Rspamd-Queue-Id: AE1E18C846
X-Rspamd-Action: no action

On 1/26/26 17:56, Tom Herbert wrote:
> On Fri, Jan 23, 2026 at 1:35 PM Justin Iurman <justin.iurman@gmail.com> wrote:
>>
>> On 1/21/26 22:49, Tom Herbert wrote:
>>> RFC8200 highly recommends that different Extension Headers be send in
>>> a prescibed order and all Extension Header types occur at most once
>>> in a packet with the expection of Destination Options that may
>>> occur twice. This patch enforces the ordering be folowed in received
>>> packets. It also disregrards Destination Options before the Routing
>>> Header as those are unused in deployment asnd there is a proposal
>>> to deprecate them in draft-herbert-deprecate-destops-before-rh.
>>
>> I'll have to pushback on this specifically, at least as long as
>> draft-herbert-deprecate-destops-before-rh is not adopted and published
>> (to be clear, I'm not against it, just that it's still an individual
>> draft right now and there is no consensus). We're already at the edge of
>> remaining compliant with RFC8200 with this series (which is fine
>> considering its security gaps), so let's not rush by removing the
>> DestOps before the Routing header. It can be done later, this series
>> already mitigates DoS attacks quite well.
> 
> Justin,
> 
> If we need to wait for permission from IETF then pretty much most of
> this patch set isn't viable. For instance
> draft-iurman-6man-eh-occurrences is also not adopted and published
> either, and if we enforce the number of occurrences in implementation
> then we are non-conformant with RFC8200. But I think it is justified
> to protect users from an obvious DoS attack.

Hi Tom,

This is why I mentioned that, with this series, we're on the edge 
regarding RFC8200 compliance. However, the text in Sec. 4.6 is somewhat 
ambiguous and does not use normative language. Therefore, this series 
does not actually violate RFC8200 compliance.

On the other hand, removing the DestOpt before RH would completely 
violate RFC8200 and, IMO, is not necessary at the moment (because this 
series already mitigates quite well DoS attacks).

> As for Destination Options before the Routing header, _no_one_ is
> using this. There is no deployment of that. The only routing header
> being deployed is SRv6 and the header has its own options, no routers
> support Destination Options before the Routing Header. But, if by some
> miracle someone is using them in their network, then they can simply
> set the sysctl to not enforce EH ordering. IMO, this approach is
> better than adding additional complexity to the stack just to detect a
> case that nobody cares about and a code path that is never exercised.

What if I want to enforce EH ordering in my network *AND* use the 
DestOpt before RH? I don't think we should make it an exclusive 
condition. And, as discussed offline, draft-bonica-6man-crh-helper-opt 
defines a DestOpt before RH. Therefore, we have at least one use case 
(still a draft, though) in limited domains. Let's wait and see if this 
draft progresses, or if draft-herbert-deprecate-destops-before-rh gets 
consensus.

Justin

> Tom
> 
>>
>> FWIW, the rest of this patch makes sense.
>>
>>> The allowed order of Extension Headers is:
>>>
>>>       IPv6 header
>>>       Hop-by-Hop Options header
>>>       Routing header
>>>       Fragment header
>>>       Authentication header
>>>       Encapsulating Security Payload header
>>>       Destination Options header
>>>       Upper-Layer header
>>>
>>> Each Extension Header may be present only once in a packet.
>>>
>>> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
>>> enforcement of xtension Header order. If it is set to zero then
>>> Extension Header order and number of occurences is not checked
>>> in receive processeing (except for Hop-by-Hop Options that
>>> must be the first Extension Header and can only occur once in
>>> a packet.
>>>
>>> Signed-off-by: Tom Herbert <tom@herbertland.com>
>>> ---
>>>    include/net/netns/ipv6.h   |  1 +
>>>    include/net/protocol.h     | 16 ++++++++++++++++
>>>    net/ipv6/af_inet6.c        |  1 +
>>>    net/ipv6/exthdrs.c         |  2 ++
>>>    net/ipv6/ip6_input.c       | 14 ++++++++++++++
>>>    net/ipv6/reassembly.c      |  1 +
>>>    net/ipv6/sysctl_net_ipv6.c |  7 +++++++
>>>    net/ipv6/xfrm6_protocol.c  |  2 ++
>>>    8 files changed, 44 insertions(+)
>>>
>>> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
>>> index 34bdb1308e8f..2db56718ea60 100644
>>> --- a/include/net/netns/ipv6.h
>>> +++ b/include/net/netns/ipv6.h
>>> @@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
>>>        u8 fib_notify_on_flag_change;
>>>        u8 icmpv6_error_anycast_as_unicast;
>>>        u8 icmpv6_errors_extension_mask;
>>> +     u8 enforce_ext_hdr_order;
>>>    };
>>>
>>>    struct netns_ipv6 {
>>> diff --git a/include/net/protocol.h b/include/net/protocol.h
>>> index b2499f88f8f8..70cc2d0fdc0c 100644
>>> --- a/include/net/protocol.h
>>> +++ b/include/net/protocol.h
>>> @@ -50,6 +50,21 @@ struct net_protocol {
>>>    };
>>>
>>>    #if IS_ENABLED(CONFIG_IPV6)
>>> +
>>> +/* Order of extension headers as prescribed in RFC8200. The ordering and
>>> + * number of extension headers in a packet can be enforced in IPv6 receive
>>> + * processing. Destination Options before the Routing Header is not included
>>> + * in the list as they are unused in deployment and it has been proposed that
>>> + * they be deprecated. See:
>>> + * www.ietf.org/archive/id/draft-herbert-deprecate-destops-before-rh-01.txt
>>> + */
>>> +#define IPV6_EXT_HDR_ORDER_HOP               BIT(0)
>>> +#define IPV6_EXT_HDR_ORDER_ROUTING   BIT(1)
>>> +#define IPV6_EXT_HDR_ORDER_FRAGMENT  BIT(2)
>>> +#define IPV6_EXT_HDR_ORDER_AUTH              BIT(3)
>>> +#define IPV6_EXT_HDR_ORDER_ESP               BIT(4)
>>> +#define IPV6_EXT_HDR_ORDER_DEST              BIT(5)
>>> +
>>>    struct inet6_protocol {
>>>        int     (*handler)(struct sk_buff *skb);
>>>
>>> @@ -61,6 +76,7 @@ struct inet6_protocol {
>>>
>>>        unsigned int    flags;  /* INET6_PROTO_xxx */
>>>        u32             secret;
>>> +     u32             ext_hdr_order;
>>>    };
>>>
>>>    #define INET6_PROTO_NOPOLICY        0x1
>>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>>> index bd29840659f3..43097360ce64 100644
>>> --- a/net/ipv6/af_inet6.c
>>> +++ b/net/ipv6/af_inet6.c
>>> @@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *net)
>>>        net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
>>>        net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
>>>        net->ipv6.sysctl.fib_notify_on_flag_change = 0;
>>> +     net->ipv6.sysctl.enforce_ext_hdr_order = 1;
>>>        atomic_set(&net->ipv6.fib6_sernum, 1);
>>>
>>>        net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
>>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>>> index 394e3397e4d4..2af16694db46 100644
>>> --- a/net/ipv6/exthdrs.c
>>> +++ b/net/ipv6/exthdrs.c
>>> @@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>>>    static const struct inet6_protocol rthdr_protocol = {
>>>        .handler        =       ipv6_rthdr_rcv,
>>>        .flags          =       INET6_PROTO_NOPOLICY,
>>> +     .ext_hdr_order  =       IPV6_EXT_HDR_ORDER_ROUTING,
>>>    };
>>>
>>>    static const struct inet6_protocol destopt_protocol = {
>>>        .handler        =       ipv6_destopt_rcv,
>>>        .flags          =       INET6_PROTO_NOPOLICY,
>>> +     .ext_hdr_order  =       IPV6_EXT_HDR_ORDER_DEST,
>>>    };
>>>
>>>    static const struct inet6_protocol nodata_protocol = {
>>> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
>>> index 168ec07e31cc..5254ead5c226 100644
>>> --- a/net/ipv6/ip6_input.c
>>> +++ b/net/ipv6/ip6_input.c
>>> @@ -366,6 +366,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>>>        const struct inet6_protocol *ipprot;
>>>        struct inet6_dev *idev;
>>>        unsigned int nhoff;
>>> +     u32 ext_hdrs = 0;
>>>        SKB_DR(reason);
>>>        bool raw;
>>>
>>> @@ -427,6 +428,19 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>>>                                goto discard;
>>>                        }
>>>                }
>>> +
>>> +             if (ipprot->ext_hdr_order &&
>>> +                 READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) {
>>> +                     /* The protocol is an extension header and EH ordering
>>> +                      * is being enforced. Discard packet if we've already
>>> +                      * seen this EH or one that is lower in the order list
>>> +                      */
>>> +                     if (ipprot->ext_hdr_order <= ext_hdrs)
>>> +                             goto discard;
>>> +
>>> +                     ext_hdrs |= ipprot->ext_hdr_order;
>>> +             }
>>> +
>>>                if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
>>>                        if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
>>>                                SKB_DR_SET(reason, XFRM_POLICY);
>>> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
>>> index 25ec8001898d..91dba72c5a3c 100644
>>> --- a/net/ipv6/reassembly.c
>>> +++ b/net/ipv6/reassembly.c
>>> @@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>>>    static const struct inet6_protocol frag_protocol = {
>>>        .handler        =       ipv6_frag_rcv,
>>>        .flags          =       INET6_PROTO_NOPOLICY,
>>> +     .ext_hdr_order  =       IPV6_EXT_HDR_ORDER_FRAGMENT,
>>>    };
>>>
>>>    #ifdef CONFIG_SYSCTL
>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>> index d2cd33e2698d..543b6acdb11d 100644
>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>> @@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] = {
>>>                .proc_handler   = proc_doulongvec_minmax,
>>>                .extra2         = &ioam6_id_wide_max,
>>>        },
>>> +     {
>>> +             .procname       = "enforce_ext_hdr_order",
>>> +             .data           = &init_net.ipv6.sysctl.enforce_ext_hdr_order,
>>> +             .maxlen         = sizeof(u8),
>>> +             .mode           = 0644,
>>> +             .proc_handler   = proc_dou8vec_minmax,
>>> +     },
>>>    };
>>>
>>>    static struct ctl_table ipv6_rotable[] = {
>>> diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
>>> index ea2f805d3b01..5826edf67f64 100644
>>> --- a/net/ipv6/xfrm6_protocol.c
>>> +++ b/net/ipv6/xfrm6_protocol.c
>>> @@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protocol = {
>>>        .handler        =       xfrm6_esp_rcv,
>>>        .err_handler    =       xfrm6_esp_err,
>>>        .flags          =       INET6_PROTO_NOPOLICY,
>>> +     .ext_hdr_order  =       IPV6_EXT_HDR_ORDER_ESP,
>>>    };
>>>
>>>    static const struct inet6_protocol ah6_protocol = {
>>>        .handler        =       xfrm6_ah_rcv,
>>>        .err_handler    =       xfrm6_ah_err,
>>>        .flags          =       INET6_PROTO_NOPOLICY,
>>> +     .ext_hdr_order  =       IPV6_EXT_HDR_ORDER_AUTH
>>>    };
>>>
>>>    static const struct inet6_protocol ipcomp6_protocol = {
>>


