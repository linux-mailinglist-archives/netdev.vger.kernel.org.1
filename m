Return-Path: <netdev+bounces-289100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAc8DgkuC2plEQUAu9opvQ
	(envelope-from <netdev+bounces-289100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:19:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DE56FC9B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F4130303FE2E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76433A718;
	Mon, 18 May 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="gkcBv69a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87672F8E90
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116391; cv=none; b=tavUMWwcd8Z+oQg3qc/odfT9OgCh5tdxJDyqtBXFOGP4XUQUTfmHQBVaf/lsv5oPOD0wg4LTOnLEX+yfOi0TkJbi8O7DmOBY6sJD4t/nzF6B5HcCeBbC/z+5DHSiVkSvJzWDuYwxhlJCm+iSnBAqQFkU084iLrz8nd7i1jJxC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116391; c=relaxed/simple;
	bh=q5XjFVsg+wspXS1sy3GAW2RwWv7+/Bq5enFbkQl7p2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHn161YqjctgQMR+x7yu5+P0MBWok6WbjFIgETLBzCF2r3kfJH38xcvBAQbOzFc2z/O2dEdrn5SNFiHWu/F9ucsBCAulAI2pbidD9P0a6ggN2a8mLzlIoxgsBTmQah7hSluFGpaASHNrMHbO4BsXdnDlTqn/tespHT58GVtysUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gkcBv69a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48fe7a40e51so2326685e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779116385; x=1779721185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vEWJGaCfr5moVa77HgCo0qOe0dfMae5hZJol18Jq5qo=;
        b=gkcBv69aqEtaBfZIhAqzwk6MhCvg9sxndlPNwSU0oSXzwKpw2m/eYtV47Rc8+boIjq
         9TnUur6JbYwXGCbbLIhWbfGnWDTxGWv2pcnzgbp6qFGc9sXH080s5eWWgiCSP9KDqbNZ
         m7s2OcPExK77YyUpoHB42qs0YXl1wkFLg+smYHAv9Pjt7VNHy6VNsZuXPGwWcmeAAmXh
         1VJipWGgVgmX9crrW0ZYz5P0zcSt05srdJw0+l1YgPGI125eKF7lw/irOqnf0H2f+zQx
         nVBG5+9389LQfbAVWrADJUZEGp3225MzUyVzDTjyDAVkDXrzOwRXgXHpx2JoFJcl8Zg6
         /Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116386; x=1779721186;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEWJGaCfr5moVa77HgCo0qOe0dfMae5hZJol18Jq5qo=;
        b=FgksljfeUtTuL8UP2NnaaRTXj4rGXrRSk39/If4QMiAGbVadd7p6cmEj/+mP01WyNb
         QoXuxfZvTie9scayPsT0UsDXOcY4fwBCFWwQZYlfuhNvGm7adg+RJpSPKTHXFbt4suBM
         kvchhCeQOxOzX9Tojad/LE3QnalwmVzCnEXYKdhlJnR2A0nHVV/HNHWMPAKUmwsGC5Nf
         m9Mdn2CoFyrmRPi/LFYXeWoyFhQ+rlV5zAZplvtInHB4QlpRaXjpnZegTGAwZnMGCTqG
         hDOObYJ/ltt2BtGc4g5APEQGWz66VjfqAlJoLvV+NKcAqL5oyhBk5FL4f2SA5/HHa6QI
         aKkQ==
X-Gm-Message-State: AOJu0YxFL2q4NP86Rb9MrO35ialzgZ000zO+mDtXi9078EHQqpeOuV+b
	4MjwN2dh8a5kdyhzWxROv2hxuBxkbjUrsBhSpvrnKnkSc8HMQjcCzqFEr0VYKozSLNc=
X-Gm-Gg: Acq92OFZeJ5tUn4/AaMT9JeUG0ngthZVnnZK31oUFqETeMxYdecy+IJpdXVS9xyx27R
	gDBycFsnyg1FnNA8kNulPDpnnssPLk0o5AdMrvWRpJgggCLqzAgKEmTGnYlOdSZlNYVdYkc5joX
	ZD9ALNEz5OpYJ1AATh6mJdRk2CJ1e1rrMsk3pbzOWKeuF5nyTs5axnt1z+GqdHCDvJtNN78c149
	+//sqY8ENGuRsPwhaOE1k0NvSYP7IYJxDf2LoVeUqBQ9zyMG83fS36IhgmOElAHET04cKFBBf/c
	+MYVOkWUJBRZNOMFCbXgGqopnh/npbgqUWc6wKH/Ga+APDmFndvYYEGcPcvpSGm2X0kpROGPZl9
	oZdMPOb1XpgH83A7siar8wWIehn3IK1iHhuv4cSgc7UkT1jXN5GpQqxG1s0RxIpwoLIlRnkY8Jz
	r/j1Sx+YxOBfYMBSp3P6DkiOzImL0dCDwwndwuNClE/b3VyNtpaetanXWjipkt+CB9H4DW1mXKk
	HzX
X-Received: by 2002:a05:600c:4455:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-48fe5fcb2dfmr120670715e9.2.1779116385579;
        Mon, 18 May 2026 07:59:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm36952961f8f.19.2026.05.18.07.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:59:45 -0700 (PDT)
Message-ID: <b88ae398-ead3-4cca-83f3-92f29891b4a1@6wind.com>
Date: Mon, 18 May 2026 16:59:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
To: Ilya Maximets <i.maximets@ovn.org>, Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Matteo Perin <matteo.perin@canonical.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-2-i.maximets@ovn.org>
 <20260518082138.37522db0@griffin>
 <8aa4e92d-0498-4335-b3b1-dabd7e507ed7@ovn.org>
 <5d4467d5-f081-4f7e-ac3c-9134ee8ddc6e@6wind.com>
 <30599c3d-66b5-4787-9ead-53ab716ba338@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <30599c3d-66b5-4787-9ead-53ab716ba338@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-289100-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[6wind.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com]
X-Rspamd-Queue-Id: 292DE56FC9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 18/05/2026 à 15:55, Ilya Maximets a écrit :
> On 5/18/26 2:46 PM, Nicolas Dichtel wrote:
>> Le 18/05/2026 à 14:11, Ilya Maximets a écrit :
>>> On 5/18/26 8:21 AM, Jiri Benc wrote:
>>>> Hi Ilya,
>>>
>>> Hi, Jiri.  Thanks for your thoughts on the matter!
>>>
>>>>
>>>> IIRC this was added because Open vSwitch needed it. I'd expect most
>>>> users that need to deal with cross-namespace detection to just switch
>>>> to the given netns prior to issuing RTM_GETLINK; at least, that's what
>>>> I'm doing in the tools I wrote.
>>>
>>> Yeah, that's also what other projects like FRR are doing.  It's a bit
>>> of a hustle for multi-threaded applications, as AFAIK, there is no way
>>> to just move one thread into a different namespace, so if many threads
>>> are doing something with the network and you suddenly need to check
>>> something in a different namespace, you can't really do that without
>>> pausing all other threads first.  But that's a separate thing, unrelated
>>> to the series.  I'm just ranting. :) 
>> Hmm, not sure to understand. setns() is per thread (see man setns()).
> 
> Hmm, I got my wires crossed here with something else, I suppose.
> Though CAP_SYS_ADMIN requirement may be an even higher barrier.
> 
>>
>>>
>>>>
>>>> On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
>>>>> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
>>>>> requests.  For some reason the code checks if the original device
>>>>> and the link are in the same namespace and not if the querier's
>>>>> namespace is the same as the link's.  So the logic becomes:
>>>>>
>>>>> - if NSID is not reported, then the link is in the same namespace
>>>>>   as the queried device.
>>>>> - if NSID is reported, then the link is not in the same namespace
>>>>>   with the queried device.
>>>>
>>>> I'm not sure I would call this a bug; the original idea was to use
>>>> IFLA_IF_NETNSID to switch to the point of view of that netns but
>>>> without actually switching to that netns. Hence, the netnsid is
>>>> relative to the caller's netns but otherwise, you get the same reply as
>>>> you would if you switched to that netns. If you think about it that
>>>> way, the current reply is consistent.
>>>
>>> It makes some sense, but the fact that all-nsid notification and the
>>> cross-namespace RTM_GETLINK provide different IDs makes it inconsistent
>>> in my brain.  We have:
>>>
>>> 1. nsenter(target) + getlink(local) = target-to-link nsid.
>>> 2. getlink(target) = caller-to-target nsid  + caller-to-link nsid.
>>> 3. all-nsid-notiication = cmsg(caller-to-target nsid) + target-to-link nsid.
>>
>> all-nsid-notification appears before cross-getlink.
>> The goal, for all-nsid-notification, was to be able to receive netlink messages
>> of a subset of netns in one socket. So these messages are provided as-is, ie
>> like if they were sent on a netlink socket opened in the corresponding netns.
>> It's generic, there is no need to patch every subsystem.
>>
>> cross-get*() have been added later. The chosen behavior is friendlier at the
>> cost of patching every subsystem that is supported.
> 
> That's exactly my point.  If we're creating a special patch for a subsystem, we
> don't need to adhere to the exact structure of the original message, since the
> data reported changes anyway.
Sure, but only for this special path then (ie cross-get). My understanding is
that you are interested by the all-nsid-notification path.

> 
> IMO, not reporting nsid that is the same as the caller's nsid is more friendlier.
> But that's, again, just a difference in opinion at this point, I'll not insist.
The problem is changing the netlink API. As you said, a new flag would be needed
for this.

Regards,
Nicolas

