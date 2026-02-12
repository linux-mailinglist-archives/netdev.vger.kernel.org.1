Return-Path: <netdev+bounces-258427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHwIIBadjWmD5QAAu9opvQ
	(envelope-from <netdev+bounces-258427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:27:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C412BDC4
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE713033E64
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3D2C029D;
	Thu, 12 Feb 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaxDtjws";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPeGaV01"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736B23717F
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770888466; cv=none; b=eHkw6QhxogclDCnAI/ejhGxbkzMZVWby1O1uDKSKlRS2Bo7VnIx48jZW+FAPSRZsuonnC00s5qUXrfkmOWrEqsJfF4twMCkS5dihweuZLUHi3UdlAffe/PSCFlfHVQ4S3VBsBGS69pMZmag02niCZA5+0q/cKTDKYdbCENHzlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770888466; c=relaxed/simple;
	bh=VwiNXGNiwJENmhHmlDUbGHOwacxCjDJTLWBkIM0+FOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iIQNW6//xom7typkbb8a3zVhxV3U/nZZrmF+eNo4HEcuhsZ4CWOxOwSDkLcMvD1pVqSNy/u89Q8Gpvbzky4u2UPHmrh851zxKxttjYeayQ6Q3VgzgAtDTekqpKvgz7SbMj/fgi4H5n1UW1AsJKc71QTa8M/aN44FA9KsFodnCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaxDtjws; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPeGaV01; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770888463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0HFD9nskeXYlZNYCIR2HI5Z+nsM/lB895NtYFd82K8=;
	b=AaxDtjwsZjyPnc2Is6YUnHR6jB0xi0QRyjwKPx/hwvNUgmQmxP3Scd9W0evY1E2v+hNqSs
	jLAuC/8/e9G15IFjBpb/hhg52fBirvEQeLMQYfjBPYRKF7RTYPjaQtlO1L//K9mBhH5Dnp
	1miQyrU9ERnm8F8Fc2EcTcYH3sGuMiQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Abnrq7EdNK-fTdbi26oqCA-1; Thu, 12 Feb 2026 04:27:41 -0500
X-MC-Unique: Abnrq7EdNK-fTdbi26oqCA-1
X-Mimecast-MFC-AGG-ID: Abnrq7EdNK-fTdbi26oqCA_1770888461
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824a02e4d29so755199b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770888460; x=1771493260; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0HFD9nskeXYlZNYCIR2HI5Z+nsM/lB895NtYFd82K8=;
        b=JPeGaV01LLTP9TWVauBd8vaydyBdoFb6EoFEwu1mE26Fwp34UiaAuxuX3g4jVa2vdA
         9baVUwDUcVHbc1+Ro+O3eNwZkn1gbE1dA7Y1RlbD7LNHdVsqlD8Kgzzd4bPz/qHal59T
         2GS/kpip606lXwNNR1DNOMaEIOZLB26eEToWcLjAYmRc9ahvtrlQ69W7rHPGvDb6kd99
         rfneg7Gxo/VwZKHUzUq9FhutffhFMZrZ1NeETeDVsa4ZiH1y6ADG6pbYK8ctonubznRG
         ubdyH5LGfJFG4hTDy55v9xjpnCXjR+BEOAzwMVcZLhuWn8S0MjSteny3RdO0uePejNrI
         564g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770888460; x=1771493260;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0HFD9nskeXYlZNYCIR2HI5Z+nsM/lB895NtYFd82K8=;
        b=hkROBwBZP8xbV7SIJW46OniJQoq/DxlZ1xk2Ajyamb8XZ3HW3w9Axx5Q9hNtUhO2vO
         axtI0cm5IQwJpyFTLZ11F7OEgU6ZxhjYLbN5+u5S1GjF6iTrikLQK/RbrGrEIXoGIY68
         0arWAm8FozG7g2NITiEXXyZe8QcyvFr51mIplNFGSCVqM0K6maPk6XiTmRP+sXacms5w
         rC2rnvJq/do3MP9+vV0EAa22qwkG3JC641Qh+h8hb7LPVwJDPTKnHXNZjcf/+WIqeTPc
         Zo6pQCVC+UQpGswGCDBkAeOE8km48glYdjhJVl23yIrCrirfDW5+YSK2L4DvFm5WjMsP
         P4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUjAQnqYn36g/Zx9tGvODyOINqm6ZSFrrQQyWgf1EO3/PB971yl26ktkYJpAefooL7sPxVHFS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqgN5IgI4sa41SIhiixPFEpQAtzVtjgOfHjmXQ+jXA2j5oKCf
	hzkUqvHKTcJP0n9VUg3a4wDoLERWQuTlTPM58czhbxsnEvmwWK6fSQCV9pF0YAGb64hJIFrOBGY
	/1M9oohd9d9MSRwRw5roVf7MSI2gPyT8qWgHC1vhFY/2Akn14qvtFX6Ve/3jAykdX0A==
X-Gm-Gg: AZuq6aK25pk+z2mspPT8Nzvqulntmyj1Sy2csVI2Ve7ldIzYvxp3kBVaa0ZhPhnXR1G
	T60EZPkv2/hWmmp8jEBYr0U5WkKrkUgs+2QNw9R2MqnBhqFveWwPrLjMeGLLoEpnP0PmpRjilUP
	QeZJomhlHRgAeTC32bAholHU9FPKMuQg+R12nrABFYPX2w2HdPKaOvNIGDV2RBiKac9dMGD21IA
	vyfn6QuOUVdP6bCfNf/pHKUk4rW99l79gXMC172GI2OK0YmwM3+4WJ+oCIiFMpxidCg1wriA/6o
	bb//BaVLF50NFXLBU5ix3+U5ldlr55bIXF4nQ/RjYjAUY3o9IvhNL4tDm1HpB4TiTsSxYvUUFFo
	H7Sy5p6TPK3H1OsVCHKE=
X-Received: by 2002:a05:6a00:1da5:b0:821:70e7:b10a with SMTP id d2e1a72fcca58-824b03f66d7mr2083318b3a.8.1770888460344;
        Thu, 12 Feb 2026 01:27:40 -0800 (PST)
X-Received: by 2002:a05:6a00:1da5:b0:821:70e7:b10a with SMTP id d2e1a72fcca58-824b03f66d7mr2083297b3a.8.1770888459948;
        Thu, 12 Feb 2026 01:27:39 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e367be5sm4637815b3a.9.2026.02.12.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 01:27:39 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Kuniyuki Iwashima <kuni1840@gmail.com>,
  netdev@vger.kernel.org,
  syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] ipv6: Fix out-of-bound access in
 fib6_add_rt2node().
In-Reply-To: <20260211175133.3657034-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Wed, 11 Feb 2026 17:50:21 +0000")
References: <20260211175133.3657034-1-kuniyu@google.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Feb 2026 18:27:38 +0900
Message-ID: <87ecmqs451.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258427-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[syoshida@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev,707d6a5da1ab9e0c6f9d];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: EA8C412BDC4
X-Rspamd-Action: no action

Kuniyuki Iwashima <kuniyu@google.com> writes:

> syzbot reported out-of-bound read in fib6_add_rt2node(). [0]
>
> When IPv6 route is created with RTA_NH_ID, struct fib6_info
> does not have the trailing struct fib6_nh.
>
> The cited commit started to check !iter->fib6_nh->fib_nh_gw_family
> to ensure that rt6_qualify_for_ecmp() will return false for iter.
>
> If iter->nh is not NULL, rt6_qualify_for_ecmp() returns false anyway.
>
> Let's check iter->nh before reading iter->fib6_nh and avoid OOB read.
>
> [0]:
> BUG: KASAN: slab-out-of-bounds in fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
> Read of size 1 at addr ffff8880384ba6de by task syz.0.18/5500
>
> CPU: 0 UID: 0 PID: 5500 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xba/0x230 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  fib6_add_rt2node+0x349c/0x3500 net/ipv6/ip6_fib.c:1142
>  fib6_add_rt2node_nh net/ipv6/ip6_fib.c:1363 [inline]
>  fib6_add+0x910/0x18c0 net/ipv6/ip6_fib.c:1531
>  __ip6_ins_rt net/ipv6/route.c:1351 [inline]
>  ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3957
>  inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
>  rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>  netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
>  __sys_sendmsg net/socket.c:2678 [inline]
>  __do_sys_sendmsg net/socket.c:2683 [inline]
>  __se_sys_sendmsg net/socket.c:2681 [inline]
>  __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9316b9aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd8809b678 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f9316e15fa0 RCX: 00007f9316b9aeb9
> RDX: 0000000000000000 RSI: 0000200000004380 RDI: 0000000000000003
> RBP: 00007f9316c08c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9316e15fac R14: 00007f9316e15fa0 R15: 00007f9316e15fa0
>  </TASK>
>
> Allocated by task 5499:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __do_kmalloc_node mm/slub.c:5657 [inline]
>  __kmalloc_noprof+0x40c/0x7e0 mm/slub.c:5669
>  kmalloc_noprof include/linux/slab.h:961 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
>  ip6_route_info_create+0x142/0x860 net/ipv6/route.c:3820
>  ip6_route_add+0x49/0x1b0 net/ipv6/route.c:3949
>  inet6_rtm_newroute+0x268/0x19e0 net/ipv6/route.c:5660
>  rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>  netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
>  __sys_sendmsg net/socket.c:2678 [inline]
>  __do_sys_sendmsg net/socket.c:2683 [inline]
>  __se_sys_sendmsg net/socket.c:2681 [inline]
>  __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: bbf4a17ad9ff ("ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF")
> Reported-by: syzbot+707d6a5da1ab9e0c6f9d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/698cbfba.050a0220.2eeac1.009d.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv6/ip6_fib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for catching this.

Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>


