Return-Path: <netdev+bounces-258789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLgyKsIpkmkOrgEAu9opvQ
	(envelope-from <netdev+bounces-258789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:17:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E013F9CE
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D437300829B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8D27603A;
	Sun, 15 Feb 2026 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTvnypwF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8D22424C
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186618; cv=none; b=NFZIR6co6bI98yDsuCuG3utzyHuc1n60pnFlSy51B5I9okWmgnOfOZVz6XMfztkrXOgL+/qDJIZCi0WzwYDQlsLTjYisETQ68Sbb3AqdJvSa4WzJv3yVUFXq2iDJrPZGBWEgsWZ7NyABdc+Sf439/o2nu8jGwHK630HOxy+PBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186618; c=relaxed/simple;
	bh=8vOpxQYcDwjoib7XolTxj1TkqhQYGCQEnw0A1F1yoOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIU9sPQQ8EV8i4OSmSNCtz8eAbo3AWfjc3ete4egukQnakV8yoOPeKx/8BDeoY5DoBm4qIoYVQdeN3xS3QoC4WcJYwwe/YaOGvIPewuIi6SVbGFJVS/c413A05ZKmy2tdFtSQVfpaJUiXTEfuMOMmzs5tb2/6P800IJLv46B0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KTvnypwF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7701b6353so32678665ad.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771186615; x=1771791415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4u+Ax07Z5ARPxF3ldiDaVCcwM0hpHGJwhoYmX2p8sD4=;
        b=KTvnypwFtPohxoFLB3cgJYv90AtPRA3vR489+qzi0QbvB5i7NAAJzRtlacw1hFm2WV
         ISMm6lxmf9yPq1729tSgu5F4rMAQZ2ZFGHM0aWCM8YzHVCcC36f18ZD9ONDglVPDEaJb
         RmwO0TvqeFBjodkZh+x+8K+i3OfIDic8iSG2kRFC4OBREVJe1quhI3CLdYApfKiJuRax
         5YLTGV7f/toumBzUpRPo18Qt0CEl2mBXzfuVU3+QlqoQ7u1djpxYDyV28BDP/kDspfEc
         RhXK8RN/3fYbQ4jzitKWhCs2m60uVPGWPllll9zOxDJQCtsI40x5qTCpf92ZudFZR7Yp
         MfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186615; x=1771791415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4u+Ax07Z5ARPxF3ldiDaVCcwM0hpHGJwhoYmX2p8sD4=;
        b=EloFPbtzi5Tgsz14ubIG4J9xLxI81AjgcBKhnu2NQATAI15nw4MgGXfF5nw5J2Dugk
         1DyYfnRQUo1HAkUvtNlsEtv/8NYuucuK6qEdO4T+m1FPDcdVTlQ5afOi7u5gGAKmG2YZ
         Yo+uOGvfZV27vaXK/kH4CHCCqHok5OZajh4yyzp5A3aNOIk91lAlyQ8sZJAV72PhbeOi
         35lDhHJEmaTDazXJ0HzcYSQRByp6beMvxv/98NrvDSSOmQ9try5cJZvN33EINODb9PGk
         iwLZL0fToeeOFxVWVnPoE+M/kfjSR1PtAkSlbVXr9elqTOIGOupMZzvIRue7EV7XUh7W
         IytQ==
X-Forwarded-Encrypted: i=1; AJvYcCViYFK5pna8VUQQCW7GVCtluD83F95Y5LKZAtALiNNaJO4kvej5dFt7yWQh18sCTcTULxakGFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlvaJ8rBdFTtz8XgWFCHjr4SqNG9rVz4qIKUNivm5rT2ujO2N
	pxAZ12zsk7RHt/QzuJxM9iL+/ukkms+vYqmPTsYCyW9IEWNxLUcn/u/PAVUvrpMQsuqKq0EhqR7
	jvhRZ4Q==
X-Received: from pjvf6.prod.google.com ([2002:a17:90a:da86:b0:340:ad90:c946])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c5:b0:2aa:e570:6e6d
 with SMTP id d9443c01a7336-2ad175347c5mr70209085ad.40.1771186615156; Sun, 15
 Feb 2026 12:16:55 -0800 (PST)
Date: Sun, 15 Feb 2026 20:16:28 +0000
In-Reply-To: <pacq5eqmgrceli6anhy2fiz3zhen4ox3hir7z6tcdnc4ghca5d@yr7zb5lauovb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pacq5eqmgrceli6anhy2fiz3zhen4ox3hir7z6tcdnc4ghca5d@yr7zb5lauovb>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215201653.3545146-1-kuniyu@google.com>
Subject: Re: [syzbot] [net?] WARNING in inet_sock_destruct (6)
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=22c34f040954bbd1];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258789-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,cloudflare.com,gmail.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 2E4E013F9CE
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Sat, 14 Feb 2026 13:46:38 +0800
> On Fri, Feb 13, 2026 at 12:08:38PM +0800, syzbot wrote:
> 
> I identified this issue and submitted a fix before this syzbot report:
> https://lore.kernel.org/bpf/20250508062423.51978-1-jiayuan.chen@linux.dev/
> Unfortunately the patch was not accepted at the time.

The fix is not sufficient since sk->sk_forward_alloc is
still modified locklessly.

I'm releasing other related reports and going to send fix
shortly.


> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    192c0159402e Merge tag 'powerpc-7.0-1' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17b8cc02580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=22c34f040954bbd1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1316a15a580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14140ffa580000
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-192c0159.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d1c911c7a5b8/vmlinux-192c0159.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/f9d4cfbb614a/bzImage-192c0159.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > sk->sk_forward_alloc
> > WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x653/0x800 net/ipv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:inet_sock_destruct+0x653/0x800 net/ipv4/af_inet.c:157
> > Code: b4 4f ff e9 06 fd ff ff e8 aa 25 10 f8 90 0f 0b 90 e9 35 fe ff ff e8 9c 25 10 f8 90 0f 0b 90 e9 c5 fe ff ff e8 8e 25 10 f8 90 <0f> 0b 90 e9 04 ff ff ff e8 80 25 10 f8 90 0f 0b 90 e9 65 fe ff ff
> > RSP: 0018:ffffc90000127bb0 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffff888100796300 RCX: ffffffff89f71e97
> > RDX: ffff88801dec4900 RSI: ffffffff89f71f92 RDI: ffff88801dec4900
> > RBP: 0000000000000090 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000090 R11: 00000000000075f9 R12: ffff888100796300
> > R13: ffff888100796390 R14: ffffffff81ed1d7d R15: 0000000000000004
> > FS:  0000000000000000(0000) GS:ffff8880d65b3000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffe39b75ff4 CR3: 000000000e396000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  __sk_destruct+0x85/0xbb0 net/core/sock.c:2350
> >  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
> >  rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2869
> >  handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
> >  run_ksoftirqd kernel/softirq.c:1063 [inline]
> >  run_ksoftirqd+0x38/0x60 kernel/softirq.c:1055
> >  smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
> >  kthread+0x370/0x450 kernel/kthread.c:467
> >  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> > 

