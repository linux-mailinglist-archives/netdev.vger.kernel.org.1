Return-Path: <netdev+bounces-293478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FJ/H0aUHGrEPQkAu9opvQ
	(envelope-from <netdev+bounces-293478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D5E617D6B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA4B43001F95
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEDC33F589;
	Sun, 31 May 2026 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zIHRPB49";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yUEQPlbE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zIHRPB49";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yUEQPlbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44E317145
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257855; cv=none; b=DjmWTSbl9iq++WA229JrGfQi4bzElKT8gvLIGQhbyBNl2LYcS83B99sr2ahlPe2y65Gm9NP4/hh7UKN5uKwdKlHLiGHD1yPLOYkzqmwbjMnHP8Q3a6nvrLZBjgE1x60C12acdQVkncgQPSDdNErRxRSgNCjExDow58TVNikhv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257855; c=relaxed/simple;
	bh=64CxcOwmpGcf9gr+mNINh3vBa67ORf9js0iu6t89DhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePy6DaemXDgYO6FvbRp+BKMZJ5mst3Rqo/OYrn/Ov2p97rvmDM5gwlei0G0kQ4pnMtw0nVhUzfDervEvm9hMr3ZvWgaRs5WUsnaOW4+tTp7mvxB1N8/+GMul5Y6pfT/Z0f/7RaoO/2AGQfgOqsEYnlzQPJgdQRx01LnPhClL1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zIHRPB49; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yUEQPlbE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zIHRPB49; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yUEQPlbE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 452F36B4F4;
	Sun, 31 May 2026 20:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780257852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTRYQWc6xCRDJjKf38hIS/zC0qlPCD6AK5dWO0NF1tQ=;
	b=zIHRPB49GFlivd4V1wr8/VsonJEapKEyCYF9SRWZO3HfJIAHxNKsFXyztJvzMuy+uGWVYK
	lFpIdgLn3cRBrK4Hu2ary96dAPPFDTQ9msrRgqSQZTGoljrwevPiMZI2ksz7w1eB3GZXRf
	LWuL2rqbk1L6PLPbOQIRJuvN6KPE0fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780257852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTRYQWc6xCRDJjKf38hIS/zC0qlPCD6AK5dWO0NF1tQ=;
	b=yUEQPlbECxCnVsCSjm1SR06hLH7ZVvKzILQbfg7G7hHvuCatJdOw+VQvgdcNCAhrju8b0o
	llb+u+PJk7jbeqCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zIHRPB49;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yUEQPlbE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780257852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTRYQWc6xCRDJjKf38hIS/zC0qlPCD6AK5dWO0NF1tQ=;
	b=zIHRPB49GFlivd4V1wr8/VsonJEapKEyCYF9SRWZO3HfJIAHxNKsFXyztJvzMuy+uGWVYK
	lFpIdgLn3cRBrK4Hu2ary96dAPPFDTQ9msrRgqSQZTGoljrwevPiMZI2ksz7w1eB3GZXRf
	LWuL2rqbk1L6PLPbOQIRJuvN6KPE0fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780257852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTRYQWc6xCRDJjKf38hIS/zC0qlPCD6AK5dWO0NF1tQ=;
	b=yUEQPlbECxCnVsCSjm1SR06hLH7ZVvKzILQbfg7G7hHvuCatJdOw+VQvgdcNCAhrju8b0o
	llb+u+PJk7jbeqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1FA2779A7;
	Sun, 31 May 2026 20:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9aOTKDuUHGqLTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 31 May 2026 20:04:11 +0000
Message-ID: <1b4f9e6d-a0f0-4bf9-aec7-fc1aa6983239@suse.de>
Date: Sun, 31 May 2026 22:04:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] hsr: Remove WARN_ONCE() in
 hsr_addr_is_self().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Arvid Brodin <arvid.brodin@alten.se>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzbot+652670cf249077eb498b@syzkaller.appspotmail.com
References: <20260530064300.340793-1-kuniyu@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260530064300.340793-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,alten.se,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-293478-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,652670cf249077eb498b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: 81D5E617D6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/30/26 8:42 AM, Kuniyuki Iwashima wrote:
> syzbot reported the warning [0] in hsr_addr_is_self(),
> whose assumption is simply wrong.
> 
> hsr->self_node is cleared in hsr_del_self_node(), which
> is called from hsr_dellink().
> 
> Since dev->rtnl_link_ops->dellink() is called before
> unregister_netdevice_many(), there is a window when
> user can find the device but without hsr->self_node.
> 
> Let's remove WARN_ONCE() in hsr_addr_is_self().
> 
> [0]:
> HSR: No self node
> WARNING: net/hsr/hsr_framereg.c:39 at hsr_addr_is_self+0x211/0x3f0 net/hsr/hsr_framereg.c:39, CPU#0: syz.4.16848/17220
> Modules linked in:
> CPU: 0 UID: 0 PID: 17220 Comm: syz.4.16848 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> RIP: 0010:hsr_addr_is_self+0x211/0x3f0 net/hsr/hsr_framereg.c:39
> Code: 33 2f 41 0f b7 dd 89 ee 09 de 31 ff e8 c8 b4 c6 f6 09 dd 74 54 e8 0f b0 c6 f6 31 ed eb 53 e8 06 b0 c6 f6 48 8d 3d 2f 50 9c 04 <67> 48 0f b9 3a 31 ed eb 42 e8 c1 13 1f 00 89 c5 31 ff 89 c6 e8 96
> RSP: 0018:ffffc900041c70e0 EFLAGS: 00010283
> RAX: ffffffff8afdc6ca RBX: ffffffff8afdc4e6 RCX: 0000000000080000
> RDX: ffffc90010493000 RSI: 0000000000000948 RDI: ffffffff8f9a1700
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffc900041c71e8 R11: fffff52000838e3f R12: dffffc0000000000
> R13: ffff888041f9e3c0 R14: ffff888086ee3802 R15: 0000000000000000
> FS:  00007f6fe985d6c0(0000) GS:ffff888126176000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f80bd437dac CR3: 0000000025096000 CR4: 00000000003526f0
> DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
> DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   check_local_dest net/hsr/hsr_forward.c:592 [inline]
>   fill_frame_info net/hsr/hsr_forward.c:728 [inline]
>   hsr_forward_skb+0xa11/0x2a80 net/hsr/hsr_forward.c:739
>   hsr_dev_xmit+0x253/0x370 net/hsr/hsr_device.c:236
>   __netdev_start_xmit include/linux/netdevice.h:5368 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5377 [inline]
>   xmit_one net/core/dev.c:3888 [inline]
>   dev_hard_start_xmit+0x2df/0x860 net/core/dev.c:3904
>   __dev_queue_xmit+0x1428/0x3900 net/core/dev.c:4870
>   neigh_output include/net/neighbour.h:556 [inline]
>   ip_finish_output2+0xcec/0x10b0 net/ipv4/ip_output.c:237
>   ip_send_skb net/ipv4/ip_output.c:1510 [inline]
>   ip_push_pending_frames+0x8b/0x110 net/ipv4/ip_output.c:1530
>   raw_sendmsg+0x1547/0x1a50 net/ipv4/raw.c:659
>   sock_sendmsg_nosec net/socket.c:787 [inline]
>   __sock_sendmsg net/socket.c:802 [inline]
>   ____sys_sendmsg+0x7da/0x9c0 net/socket.c:2698
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
>   __sys_sendmsg net/socket.c:2784 [inline]
>   __do_sys_sendmsg net/socket.c:2789 [inline]
>   __se_sys_sendmsg net/socket.c:2787 [inline]
>   __x64_sys_sendmsg+0x1c3/0x2a0 net/socket.c:2787
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6feb62ce59
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6fe985d028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f6feb8a6090 RCX: 00007f6feb62ce59
> RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000004
> RBP: 00007f6feb6c2d6f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f6feb8a6128 R14: 00007f6feb8a6090 R15: 00007ffcf01cc488
>   </TASK>
> 
> Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
> Reported-by: syzbot+652670cf249077eb498b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a1a861e.b111c304.35cd64.0016.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

