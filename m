Return-Path: <netdev+bounces-162066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B9A25978
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB35C1884FD8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D0204598;
	Mon,  3 Feb 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FJ0JFiV3"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E71FFC69;
	Mon,  3 Feb 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586060; cv=none; b=uOQaaOA4KQcGvyYSkMtoq/hY6/3/Eh1KL2CpGeZGXT2aMMKx/yXS5NLeInq+BaXxp9hNgY6XGgZIvHNf0VpThLtMmPuiIEY6MmDMRaG9rJ4a3PZYeKWi8kMQoraIdqQoKvGz/oR6x95Pa36ZZ+gQgwekWEmiIEL/sxubtVYmI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586060; c=relaxed/simple;
	bh=SxdrcH2VhP60EQ4RYlkXGF/1B52K3+MyKQOH8suB+Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VJoaMTMs1hRwRhmT2TIsdXY+XDvvmbtfWQZRPlWV0eVmikJ2XRFIuTcJO5ZzXUZyN8u3hC+06I9GUgi6zXSvy5mKD3iZ1XcmMgwx21vx94VAyWsXwwmVoP5I3GCLYOBN8kVzPy25im9VtcSCKk0mj4wOaRLJEusRRCl8l6MxcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FJ0JFiV3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1teveO-001iWM-Mg; Mon, 03 Feb 2025 13:34:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=/2fG8qYY+waR9wlagpy2bZ0EgN+0Gjg7TSFbowo5UZc=; b=FJ0JFiV3sL6VAzqH1lYao2M3DE
	CI3XeNnJ9ZjOgkBr8g+5xfAYJyUoIpmlB+V6kvibVYW9Za3WzWIvPoBq/x0XiFQw7QzmefshfbPR0
	xrrSjPsupp9A0oChd0Las/N1zHkUX4U1QhDU/F2A5eXFsfVI5yvCw2KlCBHMEfe8M/kSBrNXLKBcI
	t8GrK3tqLZ8IIotJrOC90dUI0rMnZelWIxqxNUHPkl4PYDO7snjuDh2LFXZuJBZji8voShQCWlqi1
	s2sZ+B5GSE+0FKw+WHMcEyua+B9Exo/nzXQw0GveXDxVlZbH3YliQwOHIdWvBxSh/mB6PPmGJOAFq
	VngcpZ1Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1teveN-0001A8-Ep; Mon, 03 Feb 2025 13:34:03 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1teveF-000eKd-HR; Mon, 03 Feb 2025 13:33:55 +0100
Message-ID: <d2b9f0c0-33d8-43b6-85b1-0cc45e38a60b@rbox.co>
Date: Mon, 3 Feb 2025 13:33:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] general protection fault in add_wait_queue
To: syzbot <syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
 horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com
References: <67a09300.050a0220.d7c5a.008b.GAE@google.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <67a09300.050a0220.d7c5a.008b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 10:57, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel...
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f676b0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13300b24580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12418518580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c7667ae12603/disk-c2933b2b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/944ca63002c1/vmlinux-c2933b2b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/30748115bf0b/bzImage-c2933b2b.xz
> 
> The issue was bisected to:
> 
> commit fcdd2242c0231032fc84e1404315c245ae56322a
> Author: Michal Luczaj <mhal@rbox.co>
> Date:   Tue Jan 28 13:15:27 2025 +0000
> 
>     vsock: Keep the binding until socket destruction
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148f5ddf980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=168f5ddf980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=128f5ddf980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
> Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
> ...

Let me take a look.

Michal


