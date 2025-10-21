Return-Path: <netdev+bounces-231242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E8BF666D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FD419A36B5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2162F260B;
	Tue, 21 Oct 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBRLNBfV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CD355026
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049199; cv=none; b=kw+LgIqRNYEcIPB3BWyI/75upaYcJ3JRdl7m4PFU0LphFbag5i3Nybq+7eoZ3UHPTHoRGmryud1bOi48WzHY8Zn37iq90C9Q1y7qXVcWo5Xgui1sfPf0QpESa5OUIGbm96jaf8gBsVZoHvYC5pwwyODazffAknuYgQdijQBKFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049199; c=relaxed/simple;
	bh=04jig4Ew32PJE27e851+YpkrUpXPpXriHzMbwYtti64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noBgRF3CeKwEBDY9oGehaFVtW3/UpBq3MowVceJXTdaCucF3kLu6myqMmIKBRsBNwDZ6zYBNr7Q4Yt5QVgZnYc/3Mu+Qz12WvTVVk3Xb400HN5lyS4wiaYv/m6236AGSsqRO8kq7zVrijk1b7epmDKn6hp9EJ8J9b3v1k2D0A8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBRLNBfV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VytZNZiW26mdO2fPKatgW8HrREZWu6cP3h0tgc9fJDg=;
	b=fBRLNBfVZZaXK2qyoYYh0/Cvl4JxKoei2cTlL2ghHfODrAEyr2VcB8pv4LP6+8rUUzbHKG
	DU3oAqLfQTij2M7sWCNNUxRJ9zfMotLSdlvG3jWdBP6Bzcb6yBzDsT+0SgtkbFm72GO1Y/
	5a01qVnWEh0MAJIpCMaUhytM2g1I/9U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-exVhzDi9N4yNWnXbJtiGwg-1; Tue, 21 Oct 2025 08:19:54 -0400
X-MC-Unique: exVhzDi9N4yNWnXbJtiGwg-1
X-Mimecast-MFC-AGG-ID: exVhzDi9N4yNWnXbJtiGwg_1761049194
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-336b646768eso6253331a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 05:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049193; x=1761653993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VytZNZiW26mdO2fPKatgW8HrREZWu6cP3h0tgc9fJDg=;
        b=rojx7Qld8c48ENCnUBbRgEY7Vkmx6vW6vw96ccIOsJl2Q1RKq7v3TC4+1v4+8p6g3V
         awQkPtuUT1OJRX4RwRht5yPZTRuCC8iMaaNzKy+UOfkLkJiH6iyfXd2Z9mvvs6CZWlo3
         hkHYKyL4GtQs7SCYpdUxgfAGRZLvxbVfHsopyIASi7v4gVCsKJaOmkzw3Gt41eK03sFd
         /emFGRunV4Mb3bkVVpG1rqVOQ5KeHo1jOEae0vsAt8Blu7Il8qh5XcNRwJ6E6ldzQLgF
         cCkJGwT+5SsR7LKrWkh+eSD2WaMgrbTITHy5QLdExnWuLhVC4lohnXALmyBd7Z7bFOdS
         n38Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKnfvxk59qutUMOnSm3P9LN1dcZhv82t6OC4oqwpvIsqWRQE9Tu3d6NbcYexy1E8aJ6ie1Vv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvQ5o/VCTTGwV7a3ELX/oT6dZmg67UVtzDANODH4QUBmTT9V2
	SFewSAkc1sB3bcAjZTUWHXV0kcU7ZKnqQXCbCuUUqp8xTGmeWhzmmqP/mKkVaGjdcIkIYERCtXm
	SQth6dJBAQuedN4nfEA3sOplKY7YQkX+JMEVshJ7Hqwh+CXSzduLvKHH8FndF55C1v0nJfYieoH
	bdAXFGSEPBUlA6yAf7aR2NOOuXG7qfbs7b
X-Gm-Gg: ASbGncuQq2yDVQefzmG8RNBUDjmby7rOley10FvKDr+4txPA6CPRf+E04FoE2I/D/UD
	Tbx+Iv7VcF5n7xzkMopxO8u7LuRgqmM37zMwVtpoJy05yQaP3E/Juw3qsKftVnFFmo2+iDyCMlA
	FIahGXlP41NWkKYraQUjvQM9h7JXYiNngY8ssNLvg8O5KriTXD22OZiVk=
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b9 with SMTP id 98e67ed59e1d1-33bcf8e61admr23670252a91.17.1761049192752;
        Tue, 21 Oct 2025 05:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmSXfUc0iO36yPnQ88RId8W3XGa+y2OOF1seQkx56qIphJkyoHALzCc4N+WH3586fhrgaivgyyWSAowI99uuA=
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b9 with SMTP id
 98e67ed59e1d1-33bcf8e61admr23670216a91.17.1761049192186; Tue, 21 Oct 2025
 05:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com> <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
 <CAGxU2F5y+kdByEwAq-t15fyrfrgQGpmapmLgkmDmY4xH4TJSDw@mail.gmail.com>
In-Reply-To: <CAGxU2F5y+kdByEwAq-t15fyrfrgQGpmapmLgkmDmY4xH4TJSDw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 14:19:40 +0200
X-Gm-Features: AS18NWDqKAs-Kz2GQH31Gp4VrZ2zildQDUJ-O-_PmOWtbzzb8xRFvXlqFAxJHao
Message-ID: <CAGxU2F6KaqmmK7qP55Rs8YHLOX62HyT77wY-RU1qPFpjhgV4jg@mail.gmail.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>, 
	Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 12:48, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, 21 Oct 2025 at 10:27, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > Hi Michal,
> >
> > On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
> > >Hello,
> > >
> > >syzbot found the following issue on:
> > >
> > >HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
> > >git tree:       upstream
> > >console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
> > >kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
> > >dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
> > >compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
> > >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000
> > >
> > >Downloadable assets:
> > >disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
> > >vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
> > >kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz
> > >
> > >IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
> > >
> > >======================================================
> > >WARNING: possible circular locking dependency detected
> > >syzkaller #0 Not tainted
> > >------------------------------------------------------
> > >syz.0.17/6098 is trying to acquire lock:
> > >ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
> > >ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
> >
> > Could this be related to our recent work on linger in vsock?
> >
> > >
> > >but task is already holding lock:
> > >ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
> > >
> > >which lock already depends on the new lock.
> > >
> > >
> > >the existing dependency chain (in reverse order) is:
> > >
> > >-> #1 (vsock_register_mutex){+.+.}-{4:4}:
> > >       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
> > >       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
> > >       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]
> >
> > Ah, no maybe this is related to commit 209fd720838a ("vsock:
> > Fix transport_{g2h,h2g} TOCTOU") where we added locking in
> > vsock_find_cid().
> >
> > Maybe we can just move the checks on top of __vsock_bind() to the
> > caller. I mean:
> >
> >         /* First ensure this socket isn't already bound. */
> >         if (vsock_addr_bound(&vsk->local_addr))
> >                 return -EINVAL;
> >
> >         /* Now bind to the provided address or select appropriate values if
> >          * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
> >          * like AF_INET prevents binding to a non-local IP address (in most
> >          * cases), we only allow binding to a local CID.
> >          */
> >         if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
> >                 return -EADDRNOTAVAIL;
> >
> > We have 2 callers: vsock_auto_bind() and vsock_bind().
> >
> > vsock_auto_bind() is already checking if the socket is already bound,
> > if not is setting VMADDR_CID_ANY, so we can skip those checks.
> >
> > In vsock_bind() we can do the checks before lock_sock(sk), at least the
> > checks on vm_addr, calling vsock_find_cid().
> >
> > I'm preparing a patch to do this.
>
> mmm, no, this is more related to vsock_linger() where sk_wait_event()
> releases and locks again the sk_lock.
> So, it should be related to commit 687aa0c5581b ("vsock: Fix
> transport_* TOCTOU") where we take vsock_register_mutex in
> vsock_assign_transport() while calling vsk->transport->release().
>
> So, maybe we need to move the release and vsock_deassign_transport()
> after unlocking vsock_register_mutex.

I implemented this here:
https://lore.kernel.org/netdev/20251021121718.137668-1-sgarzare@redhat.com/

sysbot successfully tested it.

Stefano


