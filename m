Return-Path: <netdev+bounces-252587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM6NGqbPcmnKpgAAu9opvQ
	(envelope-from <netdev+bounces-252587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72D6F1B4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5120300F160
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04933EB0C;
	Fri, 23 Jan 2026 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4YvOGpo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC03033C1
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131911; cv=none; b=d3Tj/JEYXfKHwQj8IK0uSIAiTXG2zBEXKzUUGJujAhqlHzNuPvLxjZ9MJYjZ1ueOWM/ZJuEXdixtDUfS5GV0jBac7x8Q2ogfyx6m3ea/LAxRheA+7pKB2AgqMET9mGC0TtILt432jxflr8yzt1PtTaqKEGn4Cl7v3X6CBLB8iHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131911; c=relaxed/simple;
	bh=zX17UP2kY+0o0KWdC5fEZHJV2v+nZF9mikZiuTOCncc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bJoKXRUSicHVcFbHxmhiK7PqW1SYqm+AHC8HVRBm1AuPMjZLRjjoKoCvyyQ031gDOPVYWPqqqoE8Iyw72g9nyHwUxNy5qUQQLCPbr8HwiQxFgAhNw/lEQDBHgt0/b9kerAmkDwHLw/YQ5M9/1SqnAeiTC5aQawaHsnrhWWukCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4YvOGpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06463C116C6;
	Fri, 23 Jan 2026 01:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769131910;
	bh=zX17UP2kY+0o0KWdC5fEZHJV2v+nZF9mikZiuTOCncc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=S4YvOGpoJDNLkLhx8GTtmxsUr9DD7fHhHYbageEFKS9xoNRBxfgAlkctUIDkVKK3O
	 0ibXD5Eh6SDVJpg33ax0s2qLvERsEJDvOZ7/JkHjlrkRMEr7AfE9idxG6/bRWyY8eN
	 zjemvKVXIgfgr3pcB+MEw1VNsvkoYEgu2mnNduven0Cuuz/p4wTr+VBmjoBU1O3xiI
	 3qGEIcxQqoEo4TWJ+ab5ZK8fiAFk3xEuHpJnmHBv4miD9Y5ney4LE3+LuvfX9TbQie
	 hApOsk4pXpnLJB3gQbaQby+l9lPeRCr0Mr+ILEA7xiCcb4tKCLV5D21CCAyCaxjnoS
	 jqg2RofXWXggQ==
Date: Thu, 22 Jan 2026 17:31:49 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    Matthieu Baerts <matttbe@kernel.org>, 
    Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, 
    netdev@vger.kernel.org, eric.dumazet@gmail.com, 
    syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
    Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
In-Reply-To: <6fdf2b6c-2c92-4b74-b746-6c68ed7cdf59@redhat.com>
Message-ID: <681f0f86-fa46-ced3-71c5-f489b67b7fbb@kernel.org>
References: <20260122131306.2119853-1-edumazet@google.com> <CANn89i+wyDiyq13nn4_NkckA0A9z7ybeKRXaC4A-VS0yFc9GQw@mail.gmail.com> <6fdf2b6c-2c92-4b74-b746-6c68ed7cdf59@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1482197408-1769131803=:22265"
Content-ID: <a5e5a57e-743f-c173-4501-1a3d79618f4a@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,linux.dev,strlen.de,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,snu.ac.kr];
	TAGGED_FROM(0.00)[bounces-252587-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martineau@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,snu.ac.kr:email]
X-Rspamd-Queue-Id: AB72D6F1B4
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1482197408-1769131803=:22265
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <58c06c45-9eb4-99f0-16dd-6b0d90cb6935@kernel.org>

On Thu, 22 Jan 2026, Paolo Abeni wrote:

> On 1/22/26 2:54 PM, Eric Dumazet wrote:
>> On Thu, Jan 22, 2026 at 2:13 PM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
>>> and/or mptcp_pm_nl_is_backup()
>>>
>>> Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
>>> which is not RCU ready.
>>>
>>> list_splice_init_rcu() can not be called here while holding pernet->lock
>>> spinlock.
>>>
>>> Many thanks to Eulgyu Kim for providing a repro and testing our patches.
>>>
>>> Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
>>> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
>>> Cc: Geliang Tang <geliang@kernel.org>
>>> ---
>>>  net/mptcp/pm_kernel.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>>> index 57570a44e4185370f531047fe97ce9f9fbd1480b..1a97d0eafa2b0c9e4275b90d4a576f837dc286a9 100644
>>> --- a/net/mptcp/pm_kernel.c
>>> +++ b/net/mptcp/pm_kernel.c
>>> @@ -1294,16 +1294,24 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
>>>  int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
>>>  {
>>>         struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>>> -       LIST_HEAD(free_list);
>>> +       struct list_head free_list;
>>>
>>>         spin_lock_bh(&pernet->lock);
>>> -       list_splice_init(&pernet->endp_list, &free_list);
>>> +
>>> +       free_list = pernet->endp_list;
>>> +       INIT_LIST_HEAD_RCU(&pernet->endp_list);
>>> +
>>>         __reset_counters(pernet);
>>>         pernet->next_id = 1;
>>>         bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>>>         spin_unlock_bh(&pernet->lock);
>>> -       mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
>>>         synchronize_rcu();
>>
>>
>>> +
>>> +       /* Adjust the pointers to free_list instead of pernet->endp_list */
>>> +       free_list.prev->next = &free_list;
>>> +       free_list.next->prev = &free_list;
>>
>>
>> We have to test if the list was empty, and avoid the synchronize_rcu
>> in this case.
>>
>> I will squash in V2, unless someone complains.
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index 1a97d0eafa2b0c9e4275b90d4a576f837dc286a9..af23be6658ded4860133bb9495c7738014815d28
>> 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -1305,6 +1305,10 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff
>> *skb, struct genl_info *info)
>>         pernet->next_id = 1;
>>         bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>>         spin_unlock_bh(&pernet->lock);
>> +
>> +       if (free_list.next == &pernet->endp_list)
>> +               return 0;
>> +
>>         synchronize_rcu();
>>
>>         /* Adjust the pointers to free_list instead of pernet->endp_list */
>>
>
> LGTM, thanks Eric!

Likewise, I think the patch (plus squash) is good, no complaints. I'll 
watch for v2.

>
> Side note: I think is very busy elsewhere and this could go directly via
> the net tree.

I agree, straight to the net tree would be best in this case.


Thanks Eric and Paolo,


- Mat
--0-1482197408-1769131803=:22265--

