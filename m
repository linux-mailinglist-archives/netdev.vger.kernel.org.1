Return-Path: <netdev+bounces-273718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCjOBgQLzGnGNgYAu9opvQ
	(envelope-from <netdev+bounces-273718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0736F872
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E0DB3032078
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEDE3D5666;
	Tue, 31 Mar 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aTEFYccr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dvHs7KxO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aTEFYccr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dvHs7KxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B736655B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978857; cv=none; b=FCgLTPGj/A5xvnG6YXczqtaaYKgKbn2iPmFBF3FIcoN1f8R9G9qmfc9WgVgVm15tnLIsgB47TRlkJagLUPAWnJZ3nRN5476MuMN4lGUxKeYK7lbGNbVENkLtbluqWhVL9Ej2WUoQmOzQCCGoRDRspLekrDpp4biRd9ICR0A505U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978857; c=relaxed/simple;
	bh=zApUfZOs4IfK6A5pxCMHm/inGFYpdQpPdkT4sKwvP88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7GM20jrsNmvmFw9pdDYXfOdnn+5cM/3IUHmauu5sZ4UaW0G6pfZeXDeHF44HZaJXFnFVZeZ2x69FsI6D44U7wHG8f9D6fEyxieMU5vkO/y1t+CBOFFruDHyXamDHYRhBd6pHKtVieAVyYLhUAgJxW7meYOoRnSQzLmSCGtlt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aTEFYccr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dvHs7KxO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aTEFYccr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dvHs7KxO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 857DC4D278;
	Tue, 31 Mar 2026 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774978854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AG8bHsyGxKRd1G2AawuDzyrAX8pPKxUZnRw6+hpjCYM=;
	b=aTEFYccr42M7v+Imuw0GRKPMNU9dLalmHpoJ4Y1atLN6iBF8xwq/4Fdu7/ypZVYt3ue330
	cgbv63xxYZr8GvkeaebouVv0Q5KEolxokQVku7wmHKix+QWuFG1MvYGHFwBVqgAeo79mNP
	uPG/4/HjuFtR2lscjIbeiouYVDIdBw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774978854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AG8bHsyGxKRd1G2AawuDzyrAX8pPKxUZnRw6+hpjCYM=;
	b=dvHs7KxOGmG2wRxenP4e2XOu0vEOf6BAi/fz3xJNRxykwfkRn5dtcMzQt9ZIBYmtreBGhh
	mlTVhxmawauK1oDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774978854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AG8bHsyGxKRd1G2AawuDzyrAX8pPKxUZnRw6+hpjCYM=;
	b=aTEFYccr42M7v+Imuw0GRKPMNU9dLalmHpoJ4Y1atLN6iBF8xwq/4Fdu7/ypZVYt3ue330
	cgbv63xxYZr8GvkeaebouVv0Q5KEolxokQVku7wmHKix+QWuFG1MvYGHFwBVqgAeo79mNP
	uPG/4/HjuFtR2lscjIbeiouYVDIdBw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774978854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AG8bHsyGxKRd1G2AawuDzyrAX8pPKxUZnRw6+hpjCYM=;
	b=dvHs7KxOGmG2wRxenP4e2XOu0vEOf6BAi/fz3xJNRxykwfkRn5dtcMzQt9ZIBYmtreBGhh
	mlTVhxmawauK1oDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0118D4A0A2;
	Tue, 31 Mar 2026 17:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KNobOCUHzGmiYgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 31 Mar 2026 17:40:53 +0000
Message-ID: <3025cc67-ddbf-43f6-a313-602193979ace@suse.de>
Date: Tue, 31 Mar 2026 19:40:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 Yiming Qian <yimingqian591@gmail.com>
References: <20260331115943.10404-1-fmancera@suse.de>
 <20260331103538.103e3778@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260331103538.103e3778@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
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
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273718-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid,router_mpath_seed.sh:url]
X-Rspamd-Queue-Id: 67C0736F872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 7:35 PM, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 13:59:43 +0200 Fernando Fernandez Mancera wrote:
>> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
>> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
>> single nexthops and small Equal-Cost Multi-Path groups, this fixed
>> allocation fails for large nexthop groups like 512+ nexthops.
> 
> router_mpath_seed.sh says:
> 
> [    9.366434] WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x181/0x1b0, CPU#0: ip/342
> [    9.366490] Modules linked in: vrf veth
> [    9.366519] CPU: 0 UID: 0 PID: 342 Comm: ip Not tainted 7.0.0-rc5-virtme #1 PREEMPT(lazy)
> [    9.366567] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [    9.366610] RIP: 0010:rtm_get_nexthop+0x181/0x1b0
> [    9.366649] Code: 25 a7 ee ff eb 80 48 c7 c7 a0 ee af ae e8 57 30 f5 ff 4d 85 ed 74 08 49 c7 45 00 a0 ee af ae b8 ea ff ff ff e9 5d ff ff ff 90 <0f> 0b 90 ba 02 00 00 00 4c 89 ee 31 ff e8 2d 84 eb ff b8 a6 ff ff
> [    9.366754] RSP: 0018:ff5db175808bf9d8 EFLAGS: 00010286
> [    9.366790] RAX: 00000000ffffffa6 RBX: ff3c7cb941dab700 RCX: 0000000000000000
> [    9.366835] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ff3c7cb94404a300
> [    9.366872] RBP: ff3c7cb94404a400 R08: ff3c7cb9413f25a8 R09: ff3c7cb94196cb40
> [    9.366916] R10: ff3c7cb94196ca00 R11: 000000000000000e R12: ffffffffaf8df6c0
> [    9.366967] R13: ff3c7cb94404a300 R14: ff3c7cb94525e180 R15: ff3c7cb94404a400
> [    9.367018] FS:  00007fa1f5261440(0000) GS:ff3c7cb9cf3fb000(0000) knlGS:0000000000000000
> [    9.367064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.367102] CR2: 000000000044f720 CR3: 000000000573f001 CR4: 0000000000771ef0
> [    9.367149] PKRU: 55555554
> [    9.367165] Call Trace:
> [    9.367183]  <TASK>
> [    9.367201]  rtnetlink_rcv_msg+0x13a/0x3e0
> [    9.367227]  ? get_page_from_freelist+0x1109/0x16c0
> [    9.367259]  ? rtnl_calcit.isra.0+0x120/0x120
> [    9.367286]  netlink_rcv_skb+0x59/0x100
> [    9.367310]  netlink_unicast+0x255/0x380
> [    9.367333]  netlink_sendmsg+0x1cc/0x3e0
> [    9.367356]  ____sys_sendmsg+0x164/0x260
> [    9.367390]  ___sys_sendmsg+0x99/0xe0
> [    9.367415]  __sys_sendmsg+0x8a/0xe0
> [    9.367441]  do_syscall_64+0x101/0xfc0
> [    9.367466]  ? exc_page_fault+0x6e/0x170
> [    9.367493]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    9.367528] RIP: 0033:0x7fa1f53bbc5e
> [    9.367550] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
> [    9.367653] RSP: 002b:00007ffc00947ff0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> [    9.367700] RAX: ffffffffffffffda RBX: 000000000048ba90 RCX: 00007fa1f53bbc5e
> [    9.367744] RDX: 0000000000000000 RSI: 00007ffc009480b0 RDI: 0000000000000005
> [    9.367787] RBP: 00007ffc00948000 R08: 0000000000000000 R09: 0000000000000000
> [    9.367835] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000049d620
> [    9.367889] R13: 0000000069cbe823 R14: 0000000000000004 R15: 000000000049d620
> 
> decoded:
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/582821/vm-crash-thr4-1

Hi Jakub,

thanks for sharing. As I replied to Eric this is the main reason why a 
V2 is needed. There is also another bug I discovered while fixing this.
When dumping the stats NHA_HW_STATS_ENABLE is being included twice per 
group. I am fixing that in another patch that will be included on the V2 
series.

Thanks,
Fernando.

