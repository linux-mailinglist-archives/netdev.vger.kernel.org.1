Return-Path: <netdev+bounces-256697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDXsG8JDg2nqkgMAu9opvQ
	(envelope-from <netdev+bounces-256697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:04:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C346FE624F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2164D304CA42
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812FC407571;
	Wed,  4 Feb 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VzthSMxy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xNBTvrVj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VzthSMxy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xNBTvrVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200E156F45
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209959; cv=none; b=JN2jfBYiFNPiZZUfx4aEC3MW9JNcjbl0NQqtPiZy5Q2xHtgQSpTfYiqsAVmFIFqWmGM6H/tnIZSgHm9d8Sq8TSFri4bumEtW/Emrgm+9f1Xo1BpF+iwnrJ5UW+Vhs2j7ZQJo0JpKzc8m4rj2JMumvOq0Ch7CxDnE5/Dynd9ReTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209959; c=relaxed/simple;
	bh=/ki8lpRIV/gW+C4t1dqIM+/sqqcsox11tZ3ng7BvyJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWg/kiIq+B1hyLnDUyne8EAye4wT5XGAdJ2oBj4ott5JrHr2pKN7pG+kDxVeDI2wnRKk6/G/M93+ChYs40K8lnuvKP48cQ2qe5nBklKcbims9DU60XyZ/PvgZQXyUACcSz/37oesjnD4MTYufUpCvXH+cBt8M37Bxkldcpl7W04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VzthSMxy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xNBTvrVj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VzthSMxy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xNBTvrVj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20E2D3E724;
	Wed,  4 Feb 2026 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770209957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZdTKHjTLGMbieTCxIxX01pv2DLb7lcprDb2xP93FGc=;
	b=VzthSMxyyPvwKcTIIUuBm9Q70hMYwAjrl1e9U28xyEy87K7ifpU+Q/Zq/+tFA6eSyu8UEp
	Cm0a7/JK8obtBQh0zj6tlbn9FOrrkiI3EPkTSJXTk0IZf7I+iJHndD/YmsQi7KY+OMMF6L
	EBLRcmzU0gL5FpXUJKZtjNYQvzke9sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770209957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZdTKHjTLGMbieTCxIxX01pv2DLb7lcprDb2xP93FGc=;
	b=xNBTvrVjKCrpz27J/f8x4FAQegBsPamDKUVyw3r8ikG3aNTg03/7Z7Cy9NRl5s166FBUGu
	Nf0DBsYVbq942VAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VzthSMxy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xNBTvrVj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770209957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZdTKHjTLGMbieTCxIxX01pv2DLb7lcprDb2xP93FGc=;
	b=VzthSMxyyPvwKcTIIUuBm9Q70hMYwAjrl1e9U28xyEy87K7ifpU+Q/Zq/+tFA6eSyu8UEp
	Cm0a7/JK8obtBQh0zj6tlbn9FOrrkiI3EPkTSJXTk0IZf7I+iJHndD/YmsQi7KY+OMMF6L
	EBLRcmzU0gL5FpXUJKZtjNYQvzke9sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770209957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZdTKHjTLGMbieTCxIxX01pv2DLb7lcprDb2xP93FGc=;
	b=xNBTvrVjKCrpz27J/f8x4FAQegBsPamDKUVyw3r8ikG3aNTg03/7Z7Cy9NRl5s166FBUGu
	Nf0DBsYVbq942VAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E6D13EA63;
	Wed,  4 Feb 2026 12:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7K/eG6RCg2n+FAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Feb 2026 12:59:16 +0000
Message-ID: <e7d8487b-32aa-4895-91e2-a594a26e4efd@suse.de>
Date: Wed, 4 Feb 2026 13:59:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Fix ECMP sibling count mismatch when clearing
 RTF_ADDRCONF
To: Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
References: <20260204095837.1285552-1-syoshida@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260204095837.1285552-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256697-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cb809def1baaac68ab92];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: C346FE624F
X-Rspamd-Action: no action

On 2/4/26 10:58 AM, Shigeru Yoshida wrote:
> syzbot reported a kernel BUG in fib6_add_rt2node() when adding an IPv6
> route. [0]
> 
> Commit f72514b3c569 ("ipv6: clear RA flags when adding a static
> route") introduced logic to clear RTF_ADDRCONF from existing routes
> when a static route with the same nexthop is added. However, this
> causes a problem when the existing route has a gateway.
> 
> When RTF_ADDRCONF is cleared from a route that has a gateway, that
> route becomes eligible for ECMP, i.e. rt6_qualify_for_ecmp() returns
> true. The issue is that this route was never added to the
> fib6_siblings list.
> 
> This leads to a mismatch between the following counts:
> 
> - The sibling count computed by iterating fib6_next chain, which
>    includes the newly ECMP-eligible route
> 
> - The actual siblings in fib6_siblings list, which does not include
>    that route
> 
> When a subsequent ECMP route is added, fib6_add_rt2node() hits
> BUG_ON(sibling->fib6_nsiblings != rt->fib6_nsiblings) because the
> counts don't match.
> 
> Fix this by only clearing RTF_ADDRCONF when the existing route does
> not have a gateway. Routes without a gateway cannot qualify for ECMP
> anyway (rt6_qualify_for_ecmp() requires fib_nh_gw_family), so clearing
> RTF_ADDRCONF on them is safe and matches the original intent of the
> commit.
> 
> [0]:
> kernel BUG at net/ipv6/ip6_fib.c:1217!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6010 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:fib6_add_rt2node+0x3433/0x3470 net/ipv6/ip6_fib.c:1217
> [...]
> Call Trace:
>   <TASK>
>   fib6_add+0x8da/0x18a0 net/ipv6/ip6_fib.c:1532
>   __ip6_ins_rt net/ipv6/route.c:1351 [inline]
>   ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3946
>   ipv6_route_ioctl+0x35c/0x480 net/ipv6/route.c:4571
>   inet6_ioctl+0x219/0x280 net/ipv6/af_inet6.c:577
>   sock_do_ioctl+0xdc/0x300 net/socket.c:1245
>   sock_ioctl+0x576/0x790 net/socket.c:1366
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: f72514b3c569 ("ipv6: clear RA flags when adding a static route")
> Reported-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cb809def1baaac68ab92
> Tested-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>   net/ipv6/ip6_fib.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for catching this. I got a bash reproducer and will send a 
kselftest for this specific scenario.

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

