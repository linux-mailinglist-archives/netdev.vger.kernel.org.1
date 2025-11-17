Return-Path: <netdev+bounces-239067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463FC63629
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF313B0C03
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1713271EE;
	Mon, 17 Nov 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZUqKwsO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbAzanKn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F4328241
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373458; cv=none; b=uvPjSHZGxEgB/03KxqhU+Ygy8O9x/U4h+uXax63gzSlIjY5Gwk/wFp1nd1Ju5V2fTvoKjEQyaQRWj3vKLf317JU1BjoYQ9OaE9mVPpQBLVW6IUV2YoKJBKUGcn94BpFm/wKeYb4aCoSl2SyDGC8+zNqPwUhAz5L0jEB4if9aWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373458; c=relaxed/simple;
	bh=28pFU7amwJNudkLV4ASV8uVjtueADNX6pTrvQXgsL8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRoK1iVKG/KgPa7CJ1dXycMX1HwA5fSyv7QEOEeOM+/oKuZiDi1Q+wqIOnBX7Pl+2EWh7/kwoblRGGGNVlNsheal6iy1gsWVbC+wQtLkNY1eWM+b7BK1BScsYC0icRBMmfev2w7GhuRL0pYuBPP9M38hesLVwagDyMuF8wDUjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZUqKwsO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbAzanKn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763373454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXL+8AkvBN5xmyuybLdZ8RubjN7nYDtLBw5DrAt1WDc=;
	b=FZUqKwsOjjRGyUhI2FZErRn+CJe6HiaZJWMK0D7g31zjx/XUVcuUP0JQRgYFqQcl5Nst6Y
	DBcado5LAUhmOJ6fXOUvY/DaFwBCk4UMvaWBggwDXzwMPWGoZw3pVAVeNYu6TB8jwBEwvC
	9jPp+2VLb4jW0iDAoVHLNRZMYIlJ1Jk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-rHJWG-D6P4eI6Z_IxJuULw-1; Mon, 17 Nov 2025 04:57:32 -0500
X-MC-Unique: rHJWG-D6P4eI6Z_IxJuULw-1
X-Mimecast-MFC-AGG-ID: rHJWG-D6P4eI6Z_IxJuULw_1763373452
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so14772335e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763373450; x=1763978250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXL+8AkvBN5xmyuybLdZ8RubjN7nYDtLBw5DrAt1WDc=;
        b=HbAzanKn3RzICkToQFeXOi/R8nuxVh824AjMl3G6pU1347PoPkaFDTZ99rDaYeC4mh
         upx5xCyKwFEZsW46uJ2LzMdnZF8yXzX0OWmia5xu82eXe82BX0AYjEWkABgkiG6GNpQG
         mMYrcpIYEOaYWyOZNy0jh+oq4FoHk6gNNWo7gE9807SGiN3Fn+6Y+QiF2h1Ul1Liku+8
         6Qkx5k9D/tt6ALFhP+0r2KfnCsPO8qWAhTCCHQn+09DpH0cC6R1ReequF6vpvuBcjHW2
         pLdoi6FWD0JXdQDYe4MnCQxX8sylYsA9ylUxgRxjbrM44JqprR0VYCeJbqOiB/Lle4+G
         UcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373450; x=1763978250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXL+8AkvBN5xmyuybLdZ8RubjN7nYDtLBw5DrAt1WDc=;
        b=Qxt0/2cn66/bwjBxBKsG4DS+dUOJDC9zORw7Em1wqWzC0MaHXxWrnftR5hypzgQfmH
         6B2Xf3n8MVQA4luTlQSr3COg00tUw3YLSAnIzaLCfogTVJfWsSuO2m6jU2Pw8oX37Dw4
         mSP4VYr7wQAbX+N+tQZad4t8HkhU84e5Ma/Ga4jd1FwJh1fQAtq3LS8E7tF8/iyH3nmc
         CW8FrhSlAZrv5XSuhrrslhUqluCT8dH2QIMhX+R5ITCUiUwDwEbiCXF6HMuOpdDTjQxD
         Vww/zMEloGy1ztM8QqIySjtO/CE3+p2WeeBdaGZqS66lTEj2lUTID2HKd6FXSLWH5Eu2
         zGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4PjcTEmu68PPlvHk/c152zRzlo05FHWOJIH7ckxjkHlvafsnj3UsTya2U7nRYOPosk3w5BrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiywxR6nvzJNXI61KisWvmM/Lj2B7sxQiLb3iNpJ1DTNhF56N
	vJgDJIqB0464iJGQIi5dd1mTaXbPTpk9+dcUKvyk6HTugoQj0HAhBbjHPNi8JXfiz5GeG5g2cBO
	f5445avy+SJL3a21oSuv6hGaWDldFWoOIxCHjVk3KA5Z3Yna/RQi7vbx8/g==
X-Gm-Gg: ASbGncsLHzlJJagLALSd9Yc/VDDj4hG0oFqgB0BRZBG3WzIVAzfwQi3keh1iJoJHQf/
	miL7CsrqQp4gbPnEyoOOpO+GNhgXdYt3R6Mwq9KkNlaDb/uPpjqED07V/m2yLU7FPikB1g4b43u
	9locdGAKsky7XGHpqSW8yeRBkkXNznABvsP4lvUVqDRA4QU3u0LLcMyi/v2rhOidGHUNz46GuJl
	NOZdK0McZ8PhoQp4fehw1+QKIR82tmiHN4aDt3xwhOlyn3Gf8djbqNSxIZZNpGXvu7RgaP2GG6M
	K4VScaiM6wTVN5GhQl3Fnlk/1Pb29simogb9qdDD7yNTIOeh4y5HMR6Ndm59MpeK1StKF/wkOhh
	FU4kFmcEwI0kG0ZXICPbOs1w6bZWvSYwBG1pUKZxp19ETUXzTE60=
X-Received: by 2002:a05:600c:4c14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-4779d88318amr36265105e9.0.1763373449836;
        Mon, 17 Nov 2025 01:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ4w6NACEVONq7vBMQgMk6jVaCUQPhHegE9Q9L5O4oMC+7xXcdXI7Bcs+2joXwdJwTRVfM0A==
X-Received: by 2002:a05:600c:4c14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-4779d88318amr36264835e9.0.1763373449311;
        Mon, 17 Nov 2025 01:57:29 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47799768409sm129895385e9.3.2025.11.17.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:57:28 -0800 (PST)
Date: Mon, 17 Nov 2025 10:57:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <awg7m76nw234dqgbe5e3tzuwpr6aznj6htvypwoulg5sjwax36@z6wqmopayakt>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
 <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
 <CAGxU2F5y+kdByEwAq-t15fyrfrgQGpmapmLgkmDmY4xH4TJSDw@mail.gmail.com>
 <CAGxU2F6KaqmmK7qP55Rs8YHLOX62HyT77wY-RU1qPFpjhgV4jg@mail.gmail.com>
 <60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co>

On Sat, Nov 15, 2025 at 05:00:28PM +0100, Michal Luczaj wrote:
>On 10/21/25 14:19, Stefano Garzarella wrote:
>> On Tue, 21 Oct 2025 at 12:48, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>
>>> On Tue, 21 Oct 2025 at 10:27, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>
>>>> Hi Michal,
>>>>
>>>> On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>>>>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
>>>>>
>>>>> ======================================================
>>>>> WARNING: possible circular locking dependency detected
>>>>> syzkaller #0 Not tainted
>>>>> ------------------------------------------------------
>>>>> syz.0.17/6098 is trying to acquire lock:
>>>>> ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>>>>> ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
>>>>
>>>> Could this be related to our recent work on linger in vsock?
>>>>
>>>>>
>>>>> but task is already holding lock:
>>>>> ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
>>>>>
>>>>> which lock already depends on the new lock.
>>>>>
>>>>>
>>>>> the existing dependency chain (in reverse order) is:
>>>>>
>>>>> -> #1 (vsock_register_mutex){+.+.}-{4:4}:
>>>>>       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>>>>>       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>>>>>       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]
>>>>
>>>> Ah, no maybe this is related to commit 209fd720838a ("vsock:
>>>> Fix transport_{g2h,h2g} TOCTOU") where we added locking in
>>>> vsock_find_cid().
>>>>
>>>> Maybe we can just move the checks on top of __vsock_bind() to the
>>>> caller. I mean:
>>>>
>>>>         /* First ensure this socket isn't already bound. */
>>>>         if (vsock_addr_bound(&vsk->local_addr))
>>>>                 return -EINVAL;
>>>>
>>>>         /* Now bind to the provided address or select appropriate values if
>>>>          * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
>>>>          * like AF_INET prevents binding to a non-local IP address (in most
>>>>          * cases), we only allow binding to a local CID.
>>>>          */
>>>>         if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
>>>>                 return -EADDRNOTAVAIL;
>>>>
>>>> We have 2 callers: vsock_auto_bind() and vsock_bind().
>>>>
>>>> vsock_auto_bind() is already checking if the socket is already bound,
>>>> if not is setting VMADDR_CID_ANY, so we can skip those checks.
>>>>
>>>> In vsock_bind() we can do the checks before lock_sock(sk), at least the
>>>> checks on vm_addr, calling vsock_find_cid().
>>>>
>>>> I'm preparing a patch to do this.
>>>
>>> mmm, no, this is more related to vsock_linger() where sk_wait_event()
>>> releases and locks again the sk_lock.
>>> So, it should be related to commit 687aa0c5581b ("vsock: Fix
>>> transport_* TOCTOU") where we take vsock_register_mutex in
>>> vsock_assign_transport() while calling vsk->transport->release().
>>>
>>> So, maybe we need to move the release and vsock_deassign_transport()
>>> after unlocking vsock_register_mutex.
>>
>> I implemented this here:
>> https://lore.kernel.org/netdev/20251021121718.137668-1-sgarzare@redhat.com/
>>
>> sysbot successfully tested it.
>>
>> Stefano
>
>Hi Stefano

Hi Michal!

>
>Apologies for missing this, I was away for a couple of weeks.

Don't worry at all!

>
>Turns out it's vsock_connect()'s reset-on-signal that strikes again. While
>you've fixed the lock order inversion (thank you), being able to reset an
>established socket, combined with SO_LINGER's lock-release-lock dance,
>still leads to crashes.

Yeah, I see!

>
>I think it goes like this: if user hits connect() with a signal right after
>connection is established (which implies an assigned transport), `sk_state`
>gets set to TCP_CLOSING and `state` to SS_UNCONNECTED. SS_UNCONNECTED means
>connect() can be retried. If re-connect() is for a different CID, transport
>reassignment takes place. That involves transport->release() of the old
>transport. Because `sk_state == TCP_CLOSING`, vsock_linger() is called.
>Lingering temporarily releases socket lock. Which can be raced by another
>thread doing connect(). Basically thread-1 can release resources from under
>thread-0. That breaks the assumptions, e.g. virtio_transport_unsent_bytes()
>does not expect a disappearing transport.

Makes sense to me!

>
>BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x34/0x40
>Read of size 1 at addr ffff888107c99420 by task a.out/1385
>CPU: 6 UID: 1000 PID: 1385 Comm: a.out Tainted: G            E
>6.18.0-rc5+ #241 PREEMPT(voluntary)
>Call Trace:
> dump_stack_lvl+0x7e/0xc0
> print_report+0x170/0x4de
> kasan_report+0xc2/0x180
> __kasan_check_byte+0x3a/0x50
> lock_acquire+0xb2/0x300
> _raw_spin_lock_bh+0x34/0x40
> virtio_transport_unsent_bytes+0x3b/0x80
> vsock_linger+0x263/0x370
> virtio_transport_release+0x3ff/0x510
> vsock_assign_transport+0x358/0x780
> vsock_connect+0x5a2/0xc40
> __sys_connect+0xde/0x110
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x94/0xbb0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Allocated by task 1384:
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> __kasan_kmalloc+0x92/0xa0
> virtio_transport_do_socket_init+0x48/0x320
> vsock_assign_transport+0x4ff/0x780
> vsock_connect+0x5a2/0xc40
> __sys_connect+0xde/0x110
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x94/0xbb0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Freed by task 1384:
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> __kasan_save_free_info+0x37/0x50
> __kasan_slab_free+0x63/0x80
> kfree+0x142/0x6a0
> virtio_transport_destruct+0x86/0x170
> vsock_assign_transport+0x3a8/0x780
> vsock_connect+0x5a2/0xc40
> __sys_connect+0xde/0x110
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x94/0xbb0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>I suppose there are many ways this chain of events can be stopped, but I
>see it as yet another reason to simplify vsock_connect(): do not let it
>"reset" an already established socket. I guess that would do the trick.
>What do you think?

I agree, we should do that. Do you have time to take a look?

Thanks for the help!
Stefano


