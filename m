Return-Path: <netdev+bounces-273661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG+0EwHdy2lHMAYAu9opvQ
	(envelope-from <netdev+bounces-273661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B881836B188
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713C6301FFB6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6BA3FADEE;
	Tue, 31 Mar 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XwUhkOdZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WnMibm53";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XwUhkOdZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WnMibm53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F2329E4B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967964; cv=none; b=mURrmABcpnhSMOAMXIUv+gDy0wtungLwe6XtCZ7rdA3+jfKt3yv7Jf8tspsRwuVFP0R18Zk3MGuBWT8bySCHspfXCBDjGJMlC/4cA2jZ6DQWA6t39zIT/GsxKV1/O+BXe24XFAfU0VQIrqP/+GUpB0gDOaBacrXNOy7P8gwr+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967964; c=relaxed/simple;
	bh=nYSH9MkaaTNcNc94mQTrQGunfMJBSEPzU9S8G+sNEGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPugMO51csUkoVGxH3RoGjN9Mdj7gGFJ6N0CVbYT3hUMFof7dOC0QLyxoMzcjDiZVNBltnOwTRwEfIGC/uPJSnYspjLHLcIqQMw2j+Le4fRQ6rBcl/qZ+T+crp8w3A7/VYr2Ilg/gNavOEl57FuyklejzNbqn07SGksEG745LZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XwUhkOdZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WnMibm53; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XwUhkOdZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WnMibm53; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CA294D262;
	Tue, 31 Mar 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774967961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9UuZmrX8aFUW4CFjuaRiSTZT5Jbr0Ud9L0ld34/jR8=;
	b=XwUhkOdZLNgwFgd9gquHU5ixmY9hAYkN+Jl2tTXJwRy0DApMeRcwVC+XVMZX+oPxAYBBhi
	p0aC0n4LuV+6KwS56P+KxUgtjsLdyfTty6IOyqwYWJSGOtHmQBOewHfyPgd3cuAlbGJLbZ
	4fWXr8aneAcyObuKX+5nA34AzKmkLjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774967961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9UuZmrX8aFUW4CFjuaRiSTZT5Jbr0Ud9L0ld34/jR8=;
	b=WnMibm53ZU1zFmAK60YPwJ1w/i1HAyksDhV8jM8laTbIcCdNUjZrT9KR6kORNFJKqhVPSV
	/YD6hNDChqD7/VBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XwUhkOdZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WnMibm53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774967961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9UuZmrX8aFUW4CFjuaRiSTZT5Jbr0Ud9L0ld34/jR8=;
	b=XwUhkOdZLNgwFgd9gquHU5ixmY9hAYkN+Jl2tTXJwRy0DApMeRcwVC+XVMZX+oPxAYBBhi
	p0aC0n4LuV+6KwS56P+KxUgtjsLdyfTty6IOyqwYWJSGOtHmQBOewHfyPgd3cuAlbGJLbZ
	4fWXr8aneAcyObuKX+5nA34AzKmkLjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774967961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9UuZmrX8aFUW4CFjuaRiSTZT5Jbr0Ud9L0ld34/jR8=;
	b=WnMibm53ZU1zFmAK60YPwJ1w/i1HAyksDhV8jM8laTbIcCdNUjZrT9KR6kORNFJKqhVPSV
	/YD6hNDChqD7/VBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E163E4A0A2;
	Tue, 31 Mar 2026 14:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ddX+M5jcy2lJJQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 31 Mar 2026 14:39:20 +0000
Message-ID: <23b3a8b0-b294-4179-9336-49a65e70c6a8@suse.de>
Date: Tue, 31 Mar 2026 16:38:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 Yiming Qian <yimingqian591@gmail.com>
References: <20260331115943.10404-1-fmancera@suse.de>
 <CANn89iLJUi+cA4fFr7XQESkT+5ckY6+MGg7QEM-G123RzuD5RQ@mail.gmail.com>
 <9aaf6dc6-3c21-4cec-9f16-5d76cb40dc80@suse.de>
 <CANn89iJ12g+AEr-9o1xbFEcSoTMYYYB4yXQW7pNRH0tei=KZug@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89iJ12g+AEr-9o1xbFEcSoTMYYYB4yXQW7pNRH0tei=KZug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273661-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B881836B188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/26 3:38 PM, Eric Dumazet wrote:
> On Tue, Mar 31, 2026 at 5:50 AM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>> On 3/31/26 2:13 PM, Eric Dumazet wrote:
>>> On Tue, Mar 31, 2026 at 5:00 AM Fernando Fernandez Mancera
>>> <fmancera@suse.de> wrote:
>>>>
>>>> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
>>>> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
>>>> single nexthops and small Equal-Cost Multi-Path groups, this fixed
>>>> allocation fails for large nexthop groups like 512+ nexthops.
>>>>
>>>> This results in the following warning splat:
>>>>
>>>>    WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#19: rep/9282
>>>>    [...]
>>>>    RIP: 0010:rtm_get_nexthop+0x176/0x1c0
>>>>    [...]
>>>>    Call Trace:
>>>>     <TASK>
>>>>     rtnetlink_rcv_msg+0x168/0x670
>>>>     netlink_rcv_skb+0x5c/0x110
>>>>     netlink_unicast+0x203/0x2e0
>>>>     netlink_sendmsg+0x222/0x460
>>>>     ____sys_sendmsg+0x35a/0x380
>>>>     ___sys_sendmsg+0x99/0xe0
>>>>     __sys_sendmsg+0x8a/0xf0
>>>>     do_syscall_64+0x12f/0x1590
>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>     </TASK>
>>>
>>> I find these stack traces without symbols not very useful.
>>
>> Hi Eric,
>>
>> sure, here is the decoded trace:
>>
>>    WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0,
>> CPU#20: rep/4608
>>    RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395 (discriminator 2))
>>    Call Trace:
>>     <TASK>
>>     rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
>>     netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>>     netlink_unicast (net/netlink/af_netlink.c:1319
>> net/netlink/af_netlink.c:1344)
>>     netlink_sendmsg (net/netlink/af_netlink.c:1894)
>>     ____sys_sendmsg (net/socket.c:721 (discriminator 16) net/socket.c:736
>> (discriminator 16) net/socket.c:2585 (discriminator 16))
>>     ___sys_sendmsg (net/socket.c:2641)
>>     __sys_sendmsg (net/socket.c:2671 (discriminator 1))
>>     do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1)
>> arch/x86/entry/syscall_64.c:94 (discriminator 1))
>>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>>     </TASK>
>>
>>>
>>> Any reason you have not used scripts/decode_stacktrace.sh ?
>>>
>>
>> Not really, in the past I checked other commits with `git log --grep
>> "Call Trace"` and found out that most of the traces did not have symbols
>> so I decided to attach the raw trace.
>>
>> I do not really have a personal preference here. If trace with symbols
>> is preferred I will do it like that in the future. I could also send a
>> V2 of this patch if needed.
> 
> Please send a V2 (after the ~24 hours delay) as we prefer this
> whenever possible.
> 

Yes, in addition nh_nlmsg_size() isn't accounting the bytes for stats 
dump so this needs a v2 anyway.

Thanks,
Fernando.


