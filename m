Return-Path: <netdev+bounces-258150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIIdOC6Di2lDVAAAu9opvQ
	(envelope-from <netdev+bounces-258150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:12:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9D11E8A7
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58ECD3018D5A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2B2C0F72;
	Tue, 10 Feb 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZmzkexb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QZ8S1g3G"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A61F03EF;
	Tue, 10 Feb 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750312; cv=none; b=tLVqa10SaXdmLvnqi+t0YKQyI83OaS0Tkt6haTJJzkSLSPH45hQlx6qfDexW61oV3alRB8M3GC7zIGVVBaypGxJmLh9aNO1UZrzQnxgluBgf+CwK8HyDEvZBZMpZsd+NWq55LkyU2Y+s1BlJ6PBLR3yUbOF6qCFt08maqSLagDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750312; c=relaxed/simple;
	bh=uAQeNvq2S/zOIDS61fTcoTI+5nqJk66WGCWaL9YZkSk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RcZUbCgnoa8L9th0rrtchhz8kBUg3fDv9YSvGbcnhWLTAQaQxwGGN5mXcEm/2e18Mh1oARobsE+QieldsQ/B37p/Ziqk0X9cwPzOmnPDEUFXDFUwozMyAisU677VI8xkxY5E7zf+HYM0dXbkaU/YNJZm62aa8i4qD7MR6E9sUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZmzkexb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QZ8S1g3G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770750309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L44lAvKjRKzDItcFt08IjbXmB2nzfCPl3DoIoZgdsM=;
	b=TZmzkexbKAghOjJxe2F/dr1fXWKo63oVJnEIBqpo44Wc7683pC1bjSupuKTtKsYuV0GvHV
	KT0BYXTDkwJYXeRhDWxj9TLTacEKo3y6ieb0U+cwDXFeUJCe1nSO1j9ik+F5t6LaIKyC9P
	Npp9Yx/wrxoHDZDJ5UqaFjLLd5TrcVFEppGzXwqE/dFo5OpvsArqqCdHBy11cIBzziGuxj
	y9oOTXaX6uCYK8kKBk4oXa0v0GNJy4mM7dQCX75UcyIgUvXbtLcsJCQ94K58NLWF7+nEv/
	7BWi184gxZr+SLJcdabK77UdGD2j8oo3u+Si9Mm8OXMsk40XLJychS90XWviWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770750309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+L44lAvKjRKzDItcFt08IjbXmB2nzfCPl3DoIoZgdsM=;
	b=QZ8S1g3GZJSXXxLCI5w1NdNduVzmCSsmdkghsp88hFAHFrzUkI1mJzFMU2ILYwckS5TGRX
	JtGRztjxs2CcFSAA==
To: syzbot <syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, horms@kernel.org, hpa@zytor.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __schedule (5)
In-Reply-To: <698a28f5.a00a0220.34fa92.004a.GAE@google.com>
References: <698a28f5.a00a0220.34fa92.004a.GAE@google.com>
Date: Tue, 10 Feb 2026 20:05:06 +0100
Message-ID: <87ldh0a07x.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=df890e720d1bb80];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,linutronix.de:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,28bdcfc1dab2ffa279a5];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 3FD9D11E8A7
X-Rspamd-Action: no action

On Mon, Feb 09 2026 at 10:35, syzbot wrote:

> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    05f7e89ab973 Linux 6.19
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17daf65a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df890e720d1bb80
> dashboard link: https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1029533a580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ea9f39c5175d/disk-05f7e89a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/734edeebfa32/vmlinux-05f7e89a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a2cb36d849f0/bzImage-05f7e89a.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+28bdcfc1dab2ffa279a5@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: slab-use-after-free in membarrier_switch_mm kernel/sched/sched.h:3666 [inline]
> BUG: KASAN: slab-use-after-free in context_switch kernel/sched/core.c:5230 [inline]
> BUG: KASAN: slab-use-after-free in __schedule+0xc56/0x5fa0 kernel/sched/core.c:6867
> Read of size 4 at addr ffff88801db4e2c0 by task kworker/u8:1/13

That's most likely the same issue as with the futex report. Caused by a
double mmdrop() in do_procmap_query(). The reproducer fiddles with
that...

See https://lore.kernel.org/all/20260129215340.3742283-1-andrii@kernel.org/T/#m5250c5bf0612d19c7991b6454f309e41776982be

Thanks,

        tglx


