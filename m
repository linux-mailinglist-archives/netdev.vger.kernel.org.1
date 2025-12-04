Return-Path: <netdev+bounces-243575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D5FCA3E52
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 600BE301D63B
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80D23EAA0;
	Thu,  4 Dec 2025 13:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAC22D4C3
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856263; cv=none; b=toFX4Kh8gBcuD7/HlOO3Yc6DfRW452m9ZbfjyghAukUcMJILSCtTfj8r87izLkEAL7f1KpccWlnfoYXHsyAkhgsWZtfhhheUC+KhtrCQeMQaTSWvhhuUjBHfBIx1dm2OY4xbR5hgYkIau8Q32RB7Vv10ttgGwjK4cTnLT7SxAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856263; c=relaxed/simple;
	bh=PkVV9wu01UP40lRAtGhDR/JJ+Wc/tlKZ8AlaXIRvVUk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OZ4T5vOkINg+WB+KpsZ3nAQpe/WyhDgFRmvv23CSlgbuvQstvcmO0PDB9PV63PdsLM/zngphJ8ielg3hhO/q9FCyUXhEZfaZKOjNTfVZLoeOQMImBt8L13irrrvirPJDIeN1VfCII4zL9CqVPPhbmq7+vVX1jNjPNtNNXa4ARUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b73161849e1so197174766b.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 05:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764856260; x=1765461060;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpmUjqa5xR6L6WkySHJlFlvY8Lnq4a+kBI6eqWNSasA=;
        b=wMs3Z4Ljgxd53nx6zDaLnR+hDdD2nza/EvzMCt190mspCqAS6neU8RhgHmqVjS9OfB
         LObFYKfLf+4EQrN35e4XiFjiITZSQRhaPH8PT4hBliIxRYmIAKwgXLJGQslfQtHE4vya
         PPZRgxwODjJFqjQY0QR4PWMy80tInw1d+Ft8OgBwIcnIcxYXqrDqepI0lZfHjg/W+YhK
         lqOT86tWX88wIfk/fxvTAebqPYReB5oZpWQeRnvjpT4jTeww0jgNKo3cjLm++wd0eyaV
         fwezLTAARVUhCc/GV2cgONdWDX+bqx2ag0K+ajm3ZdgVylqYz2u4yPA2PIoyrsCetL+a
         STvg==
X-Forwarded-Encrypted: i=1; AJvYcCUMyWb0t0Og+6Qs24Iucc/179XpXekCST/xP1FiwYlwcMEHZ/0Mjj05f7/XtBQyZXC3PopV2l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/4hhiZy+oSMYmgcKKb3gbcvFtjt5Qvz4hwIdEphGABvGxfnf
	Dn2T5AFHXnifY/c/kxWpKcY6+z4JO6+lR8mZEtzx8PGqtr0SebvOgUhj
X-Gm-Gg: ASbGnctxxtaeizrMA1bjl3Xz+3GeburU19DzmLuJMT/Y8PQ6fTYa4vmdXKTo0e17fhO
	xAV++MKizDCu4VvXEhVR1V/7MzpCoQO3JubR2mepQm9JiXHqPi6s2aYa1zA60pr8meKMRFNJtTu
	ncF9qJ6cJ8zw/CRrl5u1jpOmykOZ+ZduBIifmzDafM8CT1rmJb45LGowHpnY8jCbF/Y/CNjL0Lr
	3w+T1KdjozgXEqH8m61pmnaLldSgWddhbFCmUlHCzLx5wxzMqTpEM/7tAitpXxp04sKwa7auIag
	NKrmhSUTcLF5dd2GhRuE0BuoAsLevqva6w6CPYIst2M+fxSX44gLHnaT+gv+NYP1Qa7E4aFUTnH
	VDBXZxmt+YbwiF1T4TGgnx45uZCKV0XOwTfTB6KDslh+GMhk43C4/hGLAG19l1W4+oK3pxqGbSj
	hZCcgM08s2amZbSUWdwJUSFff9C/TCjuO+lz8No86DM6/0NOnQSwQ=
X-Google-Smtp-Source: AGHT+IH47rbvK5jYhFTjS03o4kQSZuWLQGRUkJ5Uk+DPYGytQ5Arm6ROT06NY8i4IrKQuG63aon0Hg==
X-Received: by 2002:a17:907:1c17:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b79dc777e0cmr657700466b.56.1764856259519;
        Thu, 04 Dec 2025 05:50:59 -0800 (PST)
Received: from [192.168.88.248] (89-24-32-14.nat.epc.tmcz.cz. [89.24.32.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4498947sm134677266b.15.2025.12.04.05.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 05:50:59 -0800 (PST)
Message-ID: <71ec6168-f3ca-4454-8bfb-a8ae43a09159@ovn.org>
Date: Thu, 4 Dec 2025 14:50:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Willy Tarreau <w@1wt.eu>, LePremierHomme <kwqcheii@proton.me>,
 Junvy Yang <zhuque@tencent.com>
Subject: Re: [PATCH net] net: openvswitch: fix middle attribute validation in
 push_nsh() action
To: Eelco Chaudron <echaudro@redhat.com>
References: <20251204105334.900379-1-i.maximets@ovn.org>
 <9A785713-3692-43A7-BD08-652DC1248955@redhat.com>
 <eac68895-5450-41ca-a30e-2273b9787e86@ovn.org>
 <65A94C49-E5B2-46FC-92CC-7BAA4F0B3E7E@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <65A94C49-E5B2-46FC-92CC-7BAA4F0B3E7E@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/25 2:22 PM, Eelco Chaudron wrote:
> 
> 
> On 4 Dec 2025, at 12:36, Ilya Maximets wrote:
> 
>> On 12/4/25 12:03 PM, Eelco Chaudron wrote:
>>>
>>>
>>> On 4 Dec 2025, at 11:53, Ilya Maximets wrote:
>>>
>>>> The push_nsh() action structure looks like this:
>>>>
>>>>  OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...))
>>>>
>>>> The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
>>>> nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost
>>>> OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
>>>> inside nsh_key_put_from_nlattr().  But nothing checks if the attribute
>>>> in the middle is OK.  We don't even check that this attribute is the
>>>> OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data()
>>>> calls - first time directly while calling validate_push_nsh() and the
>>>> second time as part of the nla_for_each_nested() macro, which isn't
>>>> safe, potentially causing invalid memory access if the size of this
>>>> attribute is incorrect.  The failure may not be noticed during
>>>> validation due to larger netlink buffer, but cause trouble later during
>>>> action execution where the buffer is allocated exactly to the size:
>>>>
>>>>  BUG: KASAN: slab-out-of-bounds in nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
>>>>  Read of size 184 at addr ffff88816459a634 by task a.out/22624
>>>>
>>>>  CPU: 8 UID: 0 PID: 22624 6.18.0-rc7+ #115 PREEMPT(voluntary)
>>>>  Call Trace:
>>>>   <TASK>
>>>>   dump_stack_lvl+0x51/0x70
>>>>   print_address_description.constprop.0+0x2c/0x390
>>>>   kasan_report+0xdd/0x110
>>>>   kasan_check_range+0x35/0x1b0
>>>>   __asan_memcpy+0x20/0x60
>>>>   nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
>>>>   push_nsh+0x82/0x120 [openvswitch]
>>>>   do_execute_actions+0x1405/0x2840 [openvswitch]
>>>>   ovs_execute_actions+0xd5/0x3b0 [openvswitch]
>>>>   ovs_packet_cmd_execute+0x949/0xdb0 [openvswitch]
>>>>   genl_family_rcv_msg_doit+0x1d6/0x2b0
>>>>   genl_family_rcv_msg+0x336/0x580
>>>>   genl_rcv_msg+0x9f/0x130
>>>>   netlink_rcv_skb+0x11f/0x370
>>>>   genl_rcv+0x24/0x40
>>>>   netlink_unicast+0x73e/0xaa0
>>>>   netlink_sendmsg+0x744/0xbf0
>>>>   __sys_sendto+0x3d6/0x450
>>>>   do_syscall_64+0x79/0x2c0
>>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>   </TASK>
>>>>
>>>> Let's add some checks that the attribute is properly sized and it's
>>>> the only one attribute inside the action.  Technically, there is no
>>>> real reason for OVS_KEY_ATTR_NSH to be there, as we know that we're
>>>> pushing an NSH header already, it just creates extra nesting, but
>>>> that's how uAPI works today.  So, keeping as it is.
>>>>
>>>> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
>>>> Reported-by: Junvy Yang <zhuque@tencent.com>
>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>>
>>> Thanks, Ilya, for fixing this. One small nit about logging, but overall it looks good to me.
>>>
>>> Acked-by: Eelco Chaudron echaudro@redhat.com
>>>
>>>> ---
>>>>  net/openvswitch/flow_netlink.c | 13 ++++++++++---
>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>>>> index 1cb4f97335d8..2d536901309e 100644
>>>> --- a/net/openvswitch/flow_netlink.c
>>>> +++ b/net/openvswitch/flow_netlink.c
>>>> @@ -2802,13 +2802,20 @@ static int validate_and_copy_set_tun(const struct nlattr *attr,
>>>>  	return err;
>>>>  }
>>>>
>>>> -static bool validate_push_nsh(const struct nlattr *attr, bool log)
>>>> +static bool validate_push_nsh(const struct nlattr *a, bool log)
>>>>  {
>>>> +	struct nlattr *nsh_key = nla_data(a);
>>>>  	struct sw_flow_match match;
>>>>  	struct sw_flow_key key;
>>>>
>>>> +	/* There must be one and only one NSH header. */
>>>> +	if (!nla_ok(nsh_key, nla_len(a)) ||
>>>> +	    nla_total_size(nla_len(nsh_key)) != nla_len(a) ||
>>>> +	    nla_type(nsh_key) != OVS_KEY_ATTR_NSH)
>>>
>>> Should we consider adding some logging based on the log flag here? Not a blocker,
>>> just noticed that nsh_key_put_from_nlattr() logs similar validation cases and
>>> wondered if we want the same consistency.
>>
>> Our logging is not really consistent, we do not log in the same case for the
>> validate_set(), for example.  And I'm not sure if the log here would be useful
>> as it is very unlikely we can hit this condition without manually crafting the
>> attribute to be wrong.  We'll have a log later about garbage trailing data,
>> which should prompt a user to look at what they are sending down.
>>
>> In general, we should convert all the logging here into extack, as logs are
>> very inconvenient and not specific enough in most cases.
>>
>> But I can add something like this, if needed:
>>
>>   OVS_NLERR(log, "push_nsh: Expected a single NSH header");
>>
>> What do you think?
> 
> Reading your feedback, I’m fine with leaving it as is.

OK.  I will not send a v2 for this then, unless there will be some other feedback.

Best regards, Ilya Maximets.

