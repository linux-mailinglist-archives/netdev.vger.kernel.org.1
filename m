Return-Path: <netdev+bounces-280251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OX2OSPk52lXCQIAu9opvQ
	(envelope-from <netdev+bounces-280251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:54:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05C43F933
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D29301FA7D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31113DDDC9;
	Tue, 21 Apr 2026 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahZAO4iH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNOspAMU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475536F41C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804872; cv=none; b=sSv4LScoONz1r31PhLt/aSaTxSZSyiz3T5EC/CKYvvEXMMWGuyov6rZBlT1D4aG9YIafxNN6NghrpvQtG/RsjpDkk3S6vhOGFWcStaxSX9EerP6F3mN6dvpX3xRBOIyAoQpwVjN71SlKohyXQ7+JCwWzBCNj2js+V8K6TXGQEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804872; c=relaxed/simple;
	bh=+iwxBFS10Oa2Ps5wpL9vmyKZpPboxzPxNDgymFxb+kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBxCaMVhtIf4K2xjTy7gM2Jr1hwsB2p6a7i/Ko14/fOmcA8d7788d8fSQ2nNgsPbQd9LU6vblLln4KJwclhijwoDv3Eg6ohrfxnjhs5SgQNTQ98iFghrR5XJZ5+dUFMwSkej0V9tlUH0i1htAgVvjbXQ4ETU10BRWQJDkrWhqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahZAO4iH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNOspAMU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776804869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dN0BQafCh2EAgiz4pMaA2+faOxeVr5PvSiGWzhkuLic=;
	b=ahZAO4iHnkY20MNJbdsfyCkm2A3/Ufiig99/XR1qgYyh05Yb5RR1XqtZzfaPOqE1awWKdE
	7sTOVooeOd70XzRSevOUN2QkegAe+ZSCNamNy9kHMxAu58o+WGZ7T+8Jt1MN7YM0xA/aV2
	OEVY1i4sElUsrDvM2y9Ik1RukaUopWY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-nlkZAjqxOfmxly2rdxbbcg-1; Tue, 21 Apr 2026 16:54:27 -0400
X-MC-Unique: nlkZAjqxOfmxly2rdxbbcg-1
X-Mimecast-MFC-AGG-ID: nlkZAjqxOfmxly2rdxbbcg_1776804866
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a548b585cso10092385e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776804866; x=1777409666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dN0BQafCh2EAgiz4pMaA2+faOxeVr5PvSiGWzhkuLic=;
        b=HNOspAMU2ILv+YnLalc8PtsGzkUegFP6LExM/h2sWDXoymzjHgKHO6bgagCYf+Cn+f
         T7+KoLuB7HEErqNzqX60/R4TLKdT6QWtzjgSCnQufERrDHde+8qiKaIQSa9KkXcTtikb
         r3CI3lnWbMjJaJJmeDCoCG4XswtD5WhxuQSymsE/EQlQfYIB2s2T08cKWmgD8XSwVNAD
         JG8d14fQYOuroaEjQsJIzTWxH3Ob4gZkreBnVLdc0KYMPWVemRE/gAdpOP/6CPSmO4qE
         4IX857WmkT81Up5MNay8g8Z0qnqZsNvDEzCsNXzuGdJxYA7FFcGM3Yo5nrImU1L0uLGy
         HNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776804866; x=1777409666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN0BQafCh2EAgiz4pMaA2+faOxeVr5PvSiGWzhkuLic=;
        b=iaZAsizcCxuM3UrX3jq4FBPaEYO4ycfxsAxGK17OGg1XM5/BConUlnEPdUlWAa7wKU
         fLV50G1w8KNd9An7JEpROK/nTkQF/maKECs3XKZc4uTh4u8GpJ43qn6P2pHj7amzNlmi
         e9Ul2jEt4v1XQnpWKXt+R8sCsExBiX2rXPLrmhGvSKX8VOYTaLLm3432ui48rIz88Qsc
         80mURsvvhni/xqe2z+ex4oWN4UKl0kL8eGVkKVxtCqfXmsIAz10hgBLoocEkqaOn1aGb
         OUOQPAOHtEsAJHbr3VpM6KfnOdxPClsqngi4SMHe63AYiaGPSMgFkydtiJtKigrtW9F4
         f96A==
X-Forwarded-Encrypted: i=1; AFNElJ9GRNXfInEyEXOLxl9U/jstEtUJBPbYl0q5ksI45aeGlBZsXZcLWr9Ic9WMgwZYjLoZcXw6CDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJdd+k/D60NO8M+9UV3eOGgr4HfTQAu/zamk28TvPbQHkj4Gk
	j+U5i/qTIP2HLU3CTUJWloxxl/fZVSSjfDKNBMp5Tjo6wzn719pv2NU2DAUoMHZfG96ctJNQ4LO
	x9d0yg4HTE6uXwpxBHMVkYSNuyTDkYyoiNSIeUAzOqRDdfeys8CGPsJ6f3Q==
X-Gm-Gg: AeBDiet62BU5YPHwZ0tDLsFhz3RpSOsjMxmfxG0YF9yXEMOabBDu2/E9C781pxpHb8C
	EQ/u1YoTUr3GT+CxTm2Q6wR1dSPnKJA9nY8woOEg86SXu9oDgQYnxgHIAGcRLSO++1vIue7kQby
	LClPwll6nP+JBpA6tlEXwg9pAR9Lhb1xcgLEik1ztOQjlXVI3qyEPpTGxyodRO8Jy2HGUUzvO8C
	yIMCBHJ61DBWrzl/RJc4Rhru4FTPztWi9QkIuTDyip6uFr2DeVNYPgRFTOP4geO9MlQKWwdaqUK
	k5sQLrHC1IWGA7iTKI5b/qUJmujNab+XasWfYi8WWryEHIrbLUb258eXnbKl45nqKhXaRA9VT2O
	b3MvWtrvOzgY6kvqrdBhssu9MDJgQXUj8lNozh04yo5vdXLXNjf6bGQ==
X-Received: by 2002:a05:600c:3110:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-488fb7389dfmr299321645e9.6.1776804866011;
        Tue, 21 Apr 2026 13:54:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3110:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-488fb7389dfmr299321355e9.6.1776804865356;
        Tue, 21 Apr 2026 13:54:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf696sm122094795e9.32.2026.04.21.13.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:54:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:54:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kohei Enju <kohei@enjuk.jp>
Cc: syzbot <syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] BUG: sleeping function called
 from invalid context in vhost_get_avail_idx
Message-ID: <20260421165358-mutt-send-email-mst@kernel.org>
References: <69e6a414.050a0220.24bfd3.002d.GAE@google.com>
 <aeerTzpq8B-WTKeC@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeerTzpq8B-WTKeC@x1>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7e54da1916e8d11f];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,googlegroups.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-280251-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,6985cb8e543ea90ba8ee];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4C05C43F933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 02:11:01AM +0900, Kohei Enju wrote:
> On 04/20 15:09, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    8541d8f725c6 Merge tag 'mtd/for-7.1' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=136454ce580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7e54da1916e8d11f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6985cb8e543ea90ba8ee
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d264ce580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143ec1ba580000
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8541d8f7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/22dfea2c37c2/vmlinux-8541d8f7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e2f93ad68fe3/bzImage-8541d8f7.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
> > 
> > BUG: sleeping function called from invalid context at drivers/vhost/vhost.c:1527
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6110, name: vhost-6109
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by vhost-6109/6110:
> >  #0: ffff888055624cb0 (&vq->mutex/1){+.+.}-{4:4}, at: handle_tx+0x2d/0x160 drivers/vhost/net.c:971
> >  #1: ffff888055620248 (&vq->mutex){+.+.}-{4:4}, at: vhost_net_busy_poll+0x9c/0x730 drivers/vhost/net.c:554
> > Preemption disabled at:
> > [<ffffffff88f1a006>] vhost_net_busy_poll+0x1c6/0x730 drivers/vhost/net.c:563
> 
> I think the blamed commit may be commit 030881372460 ("vhost_net: basic
> polling support"), since it introduced preempt_{disable,enable}() around
> the busy-poll loop, which calls a sleepable function inside the loop.
> 
> Also, from the changelog of the series,
> 
> https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u
> 
>   Changes from RFC V1:
>   ...
>   - Disable preemption during busy looping to make sure local_clock() was
>     correctly used.
> 
> So my understanding is that preempt_disable() was introduced to keep
> local_clock() based timeout accounting on a single CPU, rather than as a
> requirement of busy polling itself.
> 
> If my understanding is correct, migrate_disable() is sufficient here
> instead of preempt_disable(), avoiding sleepable accesses from a
> preempt-disabled context.
> 
> #syz test
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c6536cad9c4f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>         busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
>                                      tvq->busyloop_timeout;
> 
> -       preempt_disable();
> +       migrate_disable();
>         endtime = busy_clock() + busyloop_timeout;
> 
>         while (vhost_can_busy_poll(endtime)) {
> @@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>                 cpu_relax();
>         }
> 
> -       preempt_enable();
> +       migrate_enable();
> 
>         if (poll_rx || sock_has_rx_data(sock))
>                 vhost_net_busy_poll_try_queue(net, vq);



Makes sense but this stipped up the bot. Try again?

> 
> > CPU: 0 UID: 0 PID: 6110 Comm: vhost-6109 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> >  __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9162
> >  __might_fault+0x8b/0x140 mm/memory.c:7322
> >  vhost_get_avail_idx+0x31c/0x4f0 drivers/vhost/vhost.c:1527
> >  vhost_vq_avail_empty drivers/vhost/vhost.c:3206 [inline]
> >  vhost_vq_avail_empty+0xa9/0xe0 drivers/vhost/vhost.c:3199
> >  vhost_net_busy_poll+0x297/0x730 drivers/vhost/net.c:574
> >  vhost_net_tx_get_vq_desc drivers/vhost/net.c:610 [inline]
> >  get_tx_bufs.constprop.0+0x338/0x600 drivers/vhost/net.c:650
> >  handle_tx_copy+0x28c/0x12e0 drivers/vhost/net.c:778
> >  handle_tx+0x139/0x160 drivers/vhost/net.c:985
> >  vhost_run_work_list+0x183/0x220 drivers/vhost/vhost.c:454
> >  vhost_task_fn+0x156/0x430 kernel/vhost_task.c:49
> >  ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup


