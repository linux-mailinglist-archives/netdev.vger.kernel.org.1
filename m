Return-Path: <netdev+bounces-258034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEvYDnfWimnrOAAAu9opvQ
	(envelope-from <netdev+bounces-258034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 07:55:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87883117896
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 07:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49EED30056E2
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC4032D0D0;
	Tue, 10 Feb 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WJ5smkqC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AC2DECA8
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706548; cv=none; b=hy14yNiAAMECSDeFvkkZPFqcOWqFtCkAHdk3wQDXMLCUBKTBhNf+D9EvlELYKqFTF0nYr2WjxkKE5ccVHg2HWozG6mu6Ut3jhBxBVK7rhP0zN3lZKO51KE6YUGeIx3qwVtdVsOwP+5sTllnQNGOPqQnBQeLQGbtwv0DXOAkZ7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706548; c=relaxed/simple;
	bh=KO8LeRWdnQ7ue91IOj0rRDJYZAFWjIoKwqELEeGO6cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R50blTnYMc15qqidvRibGtM55qjHsJ/wNX4l9KSMDhbNOV+uyMpITycsjGTxAywMKZpgUP2+SBEIT5yE9m4g8VeJjs7870W22ZVK6FYKJaiZ8zbO+NC1stL7sGyNHluxW+tCXs6ZLEHVf3uep1W716RlERwhz4SwAToVBKzLya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WJ5smkqC; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233b953bebso908007c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 22:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1770706546; x=1771311346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEKhjBqUUwBZ7lofXCvuHTKUFxrtEOLIEsF1dJpnu7c=;
        b=WJ5smkqCAtZX4c6Qu7PP337BJcgvXbHzMQ1ox/AG+707vBaVIPJabvcIIq/UVGGEBL
         DOKiHHoNv/pQJMmsoLWatDJGjeM8BKCWarm1oezMpVIxYqmcmqkCO/EqBaWUmdmLA7cj
         qWk8mCukWMnC7WhQ1/zUi5TNNQfJ4Iy7sFNmylNGBCNfi5PuNCZ0bwtwm5cWMNSm4ymJ
         ldXQGhCEWACVZeWhqPokFzaDz+MaAnshiAANaEWoX59jbX3YV/He+TWQXutGXMSC01RN
         XK6KMN6YNtkQJyaKVZUIDM2XcJsgpA1xDLH4i34qiKxhlfS4Q+8rMu3AqZpKDfrJkTrD
         PknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770706546; x=1771311346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEKhjBqUUwBZ7lofXCvuHTKUFxrtEOLIEsF1dJpnu7c=;
        b=ZoQaW949+SAgHQZTgHzyoTvHY0Mp4a6eapotZXhL7jeDcA1i1lMEF+7yKJ31W6Ljat
         PabdjmMtc6iqo2rBWFRSRa6crkZf6wJTuqnfn9syU6eezd8iEy23iG/f6oi0ZSUQra+M
         yM9ayyzJgV4I9cKoZ/hy/xfp2QwKV87yikVBpWct06xcTuwLCOJ/SKUzkGnNtdHPH67J
         vPflANGZEADou4DYulWzw74grlGJz/ZrrvK8x0vDVCyFLtM0JoHCpl6QBy5sEvtRhB1J
         Nmx4YhP/BiL7D8LrJAIDj4okb+KWHHHLl/iqx6ijCp1lTiBif9nFki7xhSWYV+FQVzPG
         WNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkgkbDfT3CsE+vwJ1hdN7PR1OX5JoNggt+c1KLhsmwRmXvyPmLnpBrdP9dalZJPBg717sTGXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJo9j5pmtG2gxezhgTPMuYzSrkPoEgx6T+5XwOW4DGxIuqyIJz
	P0y2PPZEM+/e9ikzFSq/ES1kZJYQ6knr1NvR0OoPqDd4ij3i9vqzvXdOhpLPXBb5J/A=
X-Gm-Gg: AZuq6aIwoVsb4eTcieQg0rKwom8UqnVfy0eyRb8imwXAYRNJLsZl+zc8kUmY4SngTXf
	CX2n+u3bnnAuSWehwwe49k5qzSLxPBtBu4Q44vQiSxXc5ahUkHwvFxyKIzc7kQM1IZlSm2UWHxV
	uo4ZplvdjzLtvoTPDXog9CxuVWEHnWpQAgyR2rX+dtwLsH3n4PJ0wsG/yFPtzfc3dF/HXCaUbyF
	h06WoCLeTcJTbWv6udkLh4tJmXivKz9VV/acH2r1HMo077oe7e7kMrBQzfCP8dkx4qHH7prAfJR
	KKoF7hdR2hcocS145cBep1mk0Bei4XoEd68CISj0u+B113+kZgAsyHHYSo9oKVZqJPU2+Kh/0df
	0xCZ5Y/jZ/MHh5sytrBCq5IXbDQ/NPKZf01DUMj04tqS+8XWrFXD36MfEce3vwg8G8a1qUbB3bJ
	DX0L87FGxZY8vT+et/Z+UE5ajDO329/kWvy/hJunmw9SJRoheKX025N4o2
X-Received: by 2002:a05:7300:cd99:b0:2b8:711:ae5c with SMTP id 5a478bee46e88-2b85645a39fmr6753095eec.7.1770706546294;
        Mon, 09 Feb 2026 22:55:46 -0800 (PST)
Received: from localhost (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2ba734ed83csm3453139eec.23.2026.02.09.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 22:55:44 -0800 (PST)
Date: Tue, 10 Feb 2026 08:55:41 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: syzbot <syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com>
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bridge?] WARNING in br_multicast_del_pg
Message-ID: <aYrWbRp83MQR1ife@debil>
References: <698aa7bb.050a0220.3b3015.0086.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698aa7bb.050a0220.3b3015.0086.GAE@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258034-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,d5d1b7343531d17bd3c5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 87883117896
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 07:36:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c89477ad7944 inet: RAW sockets using IPPROTO_RAW MUST drop..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f73a5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=d5d1b7343531d17bd3c5
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/277c818ebac6/disk-c89477ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d4e6f0388a87/vmlinux-c89477ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/14eabb9cbd91/bzImage-c89477ad.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> n == 0
> WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline], CPU#0: syz.4.4607/22043
> WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline], CPU#0: syz.4.4607/22043
> WARNING: net/bridge/br_multicast.c:718 at br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825, CPU#0: syz.4.4607/22043
> Modules linked in:

I have an idea how this could happen, I'll prepare a fix.

Cheers,
 Nik

> CPU: 0 UID: 0 PID: 22043 Comm: syz.4.4607 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> RIP: 0010:br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline]
> RIP: 0010:br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline]
> RIP: 0010:br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825
> Code: 41 5f 5d e9 04 7a 48 f7 e8 3f 73 5c f7 90 0f 0b 90 e9 cf fd ff ff e8 31 73 5c f7 90 0f 0b 90 e9 16 fd ff ff e8 23 73 5c f7 90 <0f> 0b 90 e9 60 fd ff ff e8 15 73 5c f7 eb 05 e8 0e 73 5c f7 48 8b
> RSP: 0018:ffffc9000c207220 EFLAGS: 00010293
> RAX: ffffffff8a68042d RBX: ffff88807c6f1800 RCX: ffff888066e90000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff888066e90000 R09: 000000000000000c
> R10: 000000000000000c R11: 0000000000000000 R12: ffff8880303ef800
> R13: dffffc0000000000 R14: ffff888050eb11c4 R15: 1ffff1100a1d6238
> FS:  00007fa45921b6c0(0000) GS:ffff8881256f5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa4591f9ff8 CR3: 0000000081df2000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  br_mdb_flush_pgs net/bridge/br_mdb.c:1525 [inline]
>  br_mdb_flush net/bridge/br_mdb.c:1544 [inline]
>  br_mdb_del_bulk+0x5e2/0xb20 net/bridge/br_mdb.c:1561
>  rtnl_mdb_del+0x48a/0x640 net/core/rtnetlink.c:-1
>  rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:6967
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
> RIP: 0033:0x7fa45839aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa45921b028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fa458615fa0 RCX: 00007fa45839aeb9
> RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000000000000004
> RBP: 00007fa458408c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fa458616038 R14: 00007fa458615fa0 R15: 00007fff0b59fae8
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

