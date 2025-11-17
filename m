Return-Path: <netdev+bounces-239242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A27C662FE
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDF5B34438F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCE34C121;
	Mon, 17 Nov 2025 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QEzTPtGI"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EC220F37;
	Mon, 17 Nov 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413250; cv=none; b=m3v4kBMATexy/+IwbFEpx4wLKssVlsdzEhQCRrpGORQeq3r2h074Mo5lBzKJ4xHHyNWYaoWDAg2fTMVwz9SIN3uEEYxtcxfZo1WozPcHSGXIWAvqw/jlj3mRaUS0t49b8YCyEGubtpAzIhzzloWdtlONS6MZhSV/nGz9PiSyBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413250; c=relaxed/simple;
	bh=1PUojN2f7AR7h9+eE7KCQXOtrKuqH62g74kcAO7+TLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqTKCROJFN4+SEKQ+nGhFuI+yc9C7sJAs4gknaGdcD3FteNOsXFeqyzcbbeYRpM02l5ptEbsf5dkkipTxqj54xjGRD4XCfxesRBZWImy3hspq/93AV5lxXURlaQZ9rjl64VpFYi+X77A6W2WepfkKrGSSwE9ajuY3bStc7VWeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QEzTPtGI; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vL6Kx-000RQ3-VA; Mon, 17 Nov 2025 22:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=RrSJqj+hLAZcTqrceEpKG/9yU8WQ+bJidKLcFOYJpWg=; b=QEzTPtGIOrfpu0LdVl6PaWsRrZ
	pzBO30+LvC8WlqRp/Ttnxl9p6PnpmYtosmgtLXxWQ4cEk6vEsx1RdaJZXScaqqBXqwQa5U2AoxTG7
	P42Uk+cmvpHbBS6GN573maWJgt77lnC+MQrW/yrqrgA9xfLTzhTS0Lpx7sRNw0FlV3iE9Bkzpw7AL
	jlTk7NS7N0rrurvxXYSvFmokOCWDQjkfnpjCH5KyxpbHc3vgVDJ4wVUWUY/ZZ60d/8ECoYaAaT68F
	V0g4frcqoNUSTNR3EkiaRApPdZQ1A+RR7Z+bBaH2uRBdTNdHz77UsboVEHbbKTjedk62wpSn/SgdU
	jKfvdNbQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vL6Kw-0004XU-SF; Mon, 17 Nov 2025 22:00:35 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vL6Ki-00Atjo-93; Mon, 17 Nov 2025 22:00:20 +0100
Message-ID: <9a0daed1-fd18-4fef-99e9-4058fd4abe18@rbox.co>
Date: Mon, 17 Nov 2025 22:00:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
 <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
 <CAGxU2F5y+kdByEwAq-t15fyrfrgQGpmapmLgkmDmY4xH4TJSDw@mail.gmail.com>
 <CAGxU2F6KaqmmK7qP55Rs8YHLOX62HyT77wY-RU1qPFpjhgV4jg@mail.gmail.com>
 <60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co>
 <awg7m76nw234dqgbe5e3tzuwpr6aznj6htvypwoulg5sjwax36@z6wqmopayakt>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <awg7m76nw234dqgbe5e3tzuwpr6aznj6htvypwoulg5sjwax36@z6wqmopayakt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/25 10:57, Stefano Garzarella wrote:
> On Sat, Nov 15, 2025 at 05:00:28PM +0100, Michal Luczaj wrote:
>> On 10/21/25 14:19, Stefano Garzarella wrote:
>>> On Tue, 21 Oct 2025 at 12:48, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>
>>>> On Tue, 21 Oct 2025 at 10:27, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>>
>>>>> Hi Michal,
>>>>>
>>>>> On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>>>>>> git tree:       upstream
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>>>>>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000
>>>>>>
>>>>>> Downloadable assets:
>>>>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
>>>>>>
>>>>>> ======================================================
>>>>>> WARNING: possible circular locking dependency detected
>>>>>> syzkaller #0 Not tainted
>>>>>> ------------------------------------------------------
>>>>>> syz.0.17/6098 is trying to acquire lock:
>>>>>> ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>>>>>> ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
>>>>>
>>>>> Could this be related to our recent work on linger in vsock?
>>>>>
>>>>>>
>>>>>> but task is already holding lock:
>>>>>> ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
>>>>>>
>>>>>> which lock already depends on the new lock.
>>>>>>
>>>>>>
>>>>>> the existing dependency chain (in reverse order) is:
>>>>>>
>>>>>> -> #1 (vsock_register_mutex){+.+.}-{4:4}:
>>>>>>       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>>>>>>       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>>>>>>       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]
>>>>>
>>>>> Ah, no maybe this is related to commit 209fd720838a ("vsock:
>>>>> Fix transport_{g2h,h2g} TOCTOU") where we added locking in
>>>>> vsock_find_cid().
>>>>>
>>>>> Maybe we can just move the checks on top of __vsock_bind() to the
>>>>> caller. I mean:
>>>>>
>>>>>         /* First ensure this socket isn't already bound. */
>>>>>         if (vsock_addr_bound(&vsk->local_addr))
>>>>>                 return -EINVAL;
>>>>>
>>>>>         /* Now bind to the provided address or select appropriate values if
>>>>>          * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
>>>>>          * like AF_INET prevents binding to a non-local IP address (in most
>>>>>          * cases), we only allow binding to a local CID.
>>>>>          */
>>>>>         if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
>>>>>                 return -EADDRNOTAVAIL;
>>>>>
>>>>> We have 2 callers: vsock_auto_bind() and vsock_bind().
>>>>>
>>>>> vsock_auto_bind() is already checking if the socket is already bound,
>>>>> if not is setting VMADDR_CID_ANY, so we can skip those checks.
>>>>>
>>>>> In vsock_bind() we can do the checks before lock_sock(sk), at least the
>>>>> checks on vm_addr, calling vsock_find_cid().
>>>>>
>>>>> I'm preparing a patch to do this.
>>>>
>>>> mmm, no, this is more related to vsock_linger() where sk_wait_event()
>>>> releases and locks again the sk_lock.
>>>> So, it should be related to commit 687aa0c5581b ("vsock: Fix
>>>> transport_* TOCTOU") where we take vsock_register_mutex in
>>>> vsock_assign_transport() while calling vsk->transport->release().
>>>>
>>>> So, maybe we need to move the release and vsock_deassign_transport()
>>>> after unlocking vsock_register_mutex.
>>>
>>> I implemented this here:
>>> https://lore.kernel.org/netdev/20251021121718.137668-1-sgarzare@redhat.com/
>>>
>>> sysbot successfully tested it.
>>>
>>> Stefano
>>
>> Hi Stefano
> 
> Hi Michal!
> 
>>
>> Apologies for missing this, I was away for a couple of weeks.
> 
> Don't worry at all!
> 
>>
>> Turns out it's vsock_connect()'s reset-on-signal that strikes again. While
>> you've fixed the lock order inversion (thank you), being able to reset an
>> established socket, combined with SO_LINGER's lock-release-lock dance,
>> still leads to crashes.
> 
> Yeah, I see!
> 
>>
>> I think it goes like this: if user hits connect() with a signal right after
>> connection is established (which implies an assigned transport), `sk_state`
>> gets set to TCP_CLOSING and `state` to SS_UNCONNECTED. SS_UNCONNECTED means
>> connect() can be retried. If re-connect() is for a different CID, transport
>> reassignment takes place. That involves transport->release() of the old
>> transport. Because `sk_state == TCP_CLOSING`, vsock_linger() is called.
>> Lingering temporarily releases socket lock. Which can be raced by another
>> thread doing connect(). Basically thread-1 can release resources from under
>> thread-0. That breaks the assumptions, e.g. virtio_transport_unsent_bytes()
>> does not expect a disappearing transport.
> 
> Makes sense to me!
> 
>>
>> BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x34/0x40
>> Read of size 1 at addr ffff888107c99420 by task a.out/1385
>> CPU: 6 UID: 1000 PID: 1385 Comm: a.out Tainted: G            E
>> 6.18.0-rc5+ #241 PREEMPT(voluntary)
>> Call Trace:
>> dump_stack_lvl+0x7e/0xc0
>> print_report+0x170/0x4de
>> kasan_report+0xc2/0x180
>> __kasan_check_byte+0x3a/0x50
>> lock_acquire+0xb2/0x300
>> _raw_spin_lock_bh+0x34/0x40
>> virtio_transport_unsent_bytes+0x3b/0x80
>> vsock_linger+0x263/0x370
>> virtio_transport_release+0x3ff/0x510
>> vsock_assign_transport+0x358/0x780
>> vsock_connect+0x5a2/0xc40
>> __sys_connect+0xde/0x110
>> __x64_sys_connect+0x6e/0xc0
>> do_syscall_64+0x94/0xbb0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> Allocated by task 1384:
>> kasan_save_stack+0x1c/0x40
>> kasan_save_track+0x10/0x30
>> __kasan_kmalloc+0x92/0xa0
>> virtio_transport_do_socket_init+0x48/0x320
>> vsock_assign_transport+0x4ff/0x780
>> vsock_connect+0x5a2/0xc40
>> __sys_connect+0xde/0x110
>> __x64_sys_connect+0x6e/0xc0
>> do_syscall_64+0x94/0xbb0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> Freed by task 1384:
>> kasan_save_stack+0x1c/0x40
>> kasan_save_track+0x10/0x30
>> __kasan_save_free_info+0x37/0x50
>> __kasan_slab_free+0x63/0x80
>> kfree+0x142/0x6a0
>> virtio_transport_destruct+0x86/0x170
>> vsock_assign_transport+0x3a8/0x780
>> vsock_connect+0x5a2/0xc40
>> __sys_connect+0xde/0x110
>> __x64_sys_connect+0x6e/0xc0
>> do_syscall_64+0x94/0xbb0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> I suppose there are many ways this chain of events can be stopped, but I
>> see it as yet another reason to simplify vsock_connect(): do not let it
>> "reset" an already established socket. I guess that would do the trick.
>> What do you think?
> 
> I agree, we should do that. Do you have time to take a look?

Sure, here's a patch:
https://lore.kernel.org/netdev/20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co/

Michal


