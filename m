Return-Path: <netdev+bounces-301522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AmOeL8IzO2poSggAu9opvQ
	(envelope-from <netdev+bounces-301522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:32:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 186266BACBA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:32:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iOQ1dmnr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301522-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301522-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C31CE30590AB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F80C220687;
	Wed, 24 Jun 2026 01:32:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627401F30A9
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:32:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264768; cv=none; b=vAs9FSVBWZPaqRha5ZCWubmVz5POZYgFbiHyJb4krBnlBzrQFm3nn9Z3bY0+Ngv4zWeMYRpC1opBxPVDzkhZeqKvHyS8yCh24e1b9hzY1duCe7DsfZ45wSPqV9ZKN0Y+lcZhLwAHlOTz4Vw5DQAefN0ysYguGG6v+Kx/G2ogF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264768; c=relaxed/simple;
	bh=RJsGpGQRVwr+JtNwlB8ZsFkHFjOC72SBkJgXJW5OVMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqw2NHkbP7bfPXrZU9HNp6HUOBUDOmOm4/FPQsT4gett07ySSGH5iOTMmiFGDcZsS04gV0DkmPchrsI3QAjQGb44sDuH6JMGPoVEDO4xgHsaIF37L5MJAa5wFMXgWhDr7TIsJvglMlgAMOsT/Q5C14Ppkze2jqW/opzysYLJ3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iOQ1dmnr; arc=none smtp.client-ip=91.218.175.170
Message-ID: <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782264754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzBFoRi1EjW63O+lDY8B7JDNKdt4cYcrugVV0eKFoqw=;
	b=iOQ1dmnrNcKk5R+/Bwqb99gm9pehbaVHV0XivtkX0NsExbboFt6U8FnQQNlT0iuuCqE9kS
	ZDfE1IbSw7TFIQkMBJHHqCYKUpW3K+gyPWMMEUHDWA3/Q92HgofX6WF0MjCu8bAPGal2pg
	ROKpprz62nAV+pj97AGs2NUHTRnRmC4=
Date: Wed, 24 Jun 2026 09:32:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Amery Hung <ameryhung@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
 <87v7b9ysep.fsf@cloudflare.com>
 <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com>
 <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
 <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301522-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jakub@cloudflare.com,m:ameryhung@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,cloudflare.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 186266BACBA


On 6/24/26 5:26 AM, Alexei Starovoitov wrote:
> On Tue, Jun 23, 2026 at 1:36 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Jun 23, 2026 at 01:22 PM -07, Amery Hung wrote:
>>> On Tue, Jun 23, 2026 at 1:04 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>> On Tue, Jun 23, 2026 at 12:33 PM -07, Alexei Starovoitov wrote:
>>>>> On Tue, Jun 23, 2026 at 12:31 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>>>> On Tue, Jun 23, 2026 at 12:21 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>>>>> On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
>>>>>>>> On Tue, Jun 23, 2026 at 4:20 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>>>>>>> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
>>>>>>>>> completed all code paths related to sockmap-based redirects should be
>>>>>>>>> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
>>>>>>>>> disabling NET_SOCK_MSG. The implementation of sockmap as a container for
>>>>>>>>> socket references would remain under BPF_SYSCALL.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>>>>>>>>> ---
>>>>>>>>> Changes in v2:
>>>>>>>>> - Handle prot->recvmsg being NULL (Sashiko)
>>>>>>>>> - Elaborate on the end goal in description
>>>>>>>>> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com
>>>>>>>>> ---
>>>>>>>>>   net/unix/af_unix.c  | 4 ++--
>>>>>>>>>   net/unix/unix_bpf.c | 6 ++++++
>>>>>>>>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>>>>>>>> index f7a9d55eee8a..84c11c60c75f 100644
>>>>>>>>> --- a/net/unix/af_unix.c
>>>>>>>>> +++ b/net/unix/af_unix.c
>>>>>>>>> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t si
>>>>>>>>>   #ifdef CONFIG_BPF_SYSCALL
>>>>>>>>>          const struct proto *prot = READ_ONCE(sk->sk_prot);
>>>>>>>>>
>>>>>>>>> -       if (prot != &unix_dgram_proto)
>>>>>>>>> +       if (prot->recvmsg)
>>>>>>>> There is no reason to have this dead branch when
>>>>>>>> CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>>>>>>>>
>>>>>>>> Let's compile out all sockmap code when both configs
>>>>>>>> are not enabled.
>>>>>>>>
>>>>>>>> Since AF_UNIX differs from TCP/UDP, it can take the
>>>>>>>> simpler approach.
>>>>>>> Okay, will put the whole file behind hidden config option like so:
>>>>>>>
>>>>>>> --- a/net/unix/Kconfig
>>>>>>> +++ b/net/unix/Kconfig
>>>>>>> @@ -30,3 +30,8 @@ config UNIX_DIAG
>>>>>>>          help
>>>>>>>            Support for UNIX socket monitoring interface used by the ss tool.
>>>>>>>            If unsure, say Y.
>>>>>>> +
>>>>>>> +config UNIX_BPF
>>>>>> Maybe UNIX_BPF_SOCKMAP or something.
>>>>>> bpf_iter is supported without this config.
>>>>> I don't like where it's going.
>>>>> I strongly dislike new config knobs.
>>>>> I'd rather remove existing knobs.
>>>>> What is the motivation?
>>>> The goal is to compile out sockmap bits that use sk_msg.
>>>> NET_SOCK_MSG is natural, exisiting candidate.
>>>> New knob wasn't my idea.
>>> I'm also missing the big picture here.
>>>
>>> sockmap already holds socket references today. You can store and look
>>> up sockets without attaching any verdict/parser program, and no
>>> redirect happens. So if the goal is to use sockmap purely as a socket
>>> container without the sk_msg fast-path overhead, what does a
>>> compile-time NET_SOCK_MSG knob add over the runtime checks?
>> Sure, let me clarify. It's about the maintenance overhead.
>>
>> sockmap-based redirects are a rather niche feature with few users, for
>> which we've been getting quite a few bug reports since AI came along.
>>
>> We're not using it internally at Cloudflare, so I don't really have a
>> good reason to justify time spent on these bug reports.
>>
>> Hence the move to put sockmap-based redirect behind a config option,
>> which you can enable at your own risk. Or which we can deprecate, but
>> that's not really my call.


Hi Alexei and Jakub,

skmsg is actually still pretty useful for gateways.
I started with bpf by integrating skmsg into nginx as a module and envoy 
has something similar.
The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for 
L7, redirecting
between local apps by looking at the payload. So there are real users.


> This is wishful thinking that a config knob will stop
> the bug reports.
> Just disable it for real instead.


About the AI bug reports - yeah, I've seen them too. I think it just 
comes from the complexity
of networking plus how programmable bpf is. Reviewing AI-written patches 
is often painful,
the commit message is frequently wrong, once it took me a whole day just 
to reproduce and
confirm the issue. But I do believe these reports will converge eventually.


>>> I am also not sure if NET_SOCK_MSG is right. It is broader than
>>> "sockmap redirect". It is selected by TLS and {INET,INET6}_ESPINTCP.
>>> Because those select it, it can't be toggled independently.
>> Once the sockmap redirect bits are behind _some_ config option, it will
>> be easy to replace it with a more granular one that depends on
>> NET_SOCK_MSG. But we're not there yet. One step at a time.
> No. That's not workable.
>
>>> Could you share the concrete use case you have in mind, and whether
>>> this came out of an earlier discussion or thread upstream?
>> This is a follow up from discussions at BPF summit with Alexei & John.
> Not quite. The discussion was to disable pieces of sockmap
> that are causing trouble.
> Not to move them under config knobs, but disable them.

Agree, just like we remove skmsg from KTLS which is rarely used.


I think the motivation of this patch - making the boundary between skmsg 
and sockmap clear - is worthwhile.

Hope not have skmsg disabled by default.
I don't work on that upper-layer software anymore, but I really don't 
want my ex-colleagues to
upgrade their kernel some day, find the feature I wrote broken, and come 
curse me :) (selfish)


