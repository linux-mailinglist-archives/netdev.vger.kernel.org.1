Return-Path: <netdev+bounces-150568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46C9EAACD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D26616118D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995F230990;
	Tue, 10 Dec 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5tNPJxr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEB1B6CE5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819821; cv=none; b=iYOH5Zk3P9x9N1aUO3yKIlSqmHeghg/VJkwld2flDrMbmwUu1Z+w4HpCkN7Ho504apZHaYxPOQxXbVDJocgR/OrbmXdJRXMTbzLvNg5KhphH5w6ebKqEGEZNQ7hk46tBmbHCZvGn4mpY+stwRtrWPTGkbFk4Z5xLkgn4yKtBj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819821; c=relaxed/simple;
	bh=d97GTUZGLw6k3hjnd5U72/XSa/1M3BMFL0etNUqjcZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyrkuzVM7nw0UpldArZlN17fI4/EhI3tAgp3AUMKENSQGafgtymT7EjTRxYd8DP3oHIuEB/+VaIud3giu5mRnEKPbVlds50EUS6F/g8ucrSA9MMyLXoncqQLex5MVvaw0hhfYuR0W3E1GURUbDUZ6fR7kCtU3b3n8/bMfcu4ZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5tNPJxr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733819818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXx1aulz1QdplSJwRsSBebpo3uH7S/P6vC1NV17HVwg=;
	b=O5tNPJxr+ZdJWmNFcbTXLc0SlOGahp6XRW/741sSX/bDomJ+Ef4sxVYVipRm1z8jN551lS
	jbil9dIDSZOKIayRCFTCqX1hwI9dGFhjI/PKetVZ+K/47eMmrCrhsi2PGoegbEfBBIzmBP
	jE2W0HS1dyY09BRAVRriYusRXEhHQL4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-zeQtzKAgP7KA6xB4t8kEbA-1; Tue, 10 Dec 2024 03:36:57 -0500
X-MC-Unique: zeQtzKAgP7KA6xB4t8kEbA-1
X-Mimecast-MFC-AGG-ID: zeQtzKAgP7KA6xB4t8kEbA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4667e12c945so79263531cf.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819817; x=1734424617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXx1aulz1QdplSJwRsSBebpo3uH7S/P6vC1NV17HVwg=;
        b=Xml+vmDfOVTR7zDLEeCazbwX61x82aXNZoZW1TumliDeG4bEcS843Dqfks8vDK0ItK
         Q6oI846bnDmN9QzoGLYyWhNi5b3Ur8WJBP+X35CQBYW/PUrWP7iqApkph5MPhzAdLQ/u
         YuJamUnTEeQOQnNMGR62qgMhmrZSf65lClJul108XQXG+vV68y0/1BGwtDDAoI0ynVgG
         fKawPKsQTCfG4DYCmTe/aLK0smZ5wh3tkIGKLc4iaPAlThHcmFHE6GNEJ2y3Pa9a21N/
         +cP3XyMcaRXixqsmpUqJVeRx2taBcZRXIqUFQs8+PDXwmuEG3+S3vrMB2HpRvY+F4PuX
         HImA==
X-Forwarded-Encrypted: i=1; AJvYcCVsx8L7Sj+RflXETdBJBS44PvuLpHzIYgzVWUMXTVuN5k7CMURhj0gYsgfw72eZkuSZO2iT+Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Dr7y9AsPxMnkZ4sQsU1tYZt7xtbYKH+8ILRZyoP/fOBzQBsx
	kP6XS9ozzfLVRYbczXRS+t2SNZ1ZCpuU3MVseLLv2X+2d4wLRmbUg9gv5ktkmhuEILZyYGpRCrP
	1f0Yfhlga49uxTkBQc5vZ+YPj+6PCaWBPPPjEC/qMFOemabupLKM7Jw==
X-Gm-Gg: ASbGnct9rYdwNoOpTiLIDhoKeMQRCOXNm8yEdHUlbMK1O310vWCBukoZ4oZP0d9vhZN
	ANT9uy5sW404zdqw+KMIkQOBzJD0tFh98H8yhG/bk8LPCNxfkNtyVfx3SfYMknMe8ZupRcmgVj9
	b1AvyPP82Vcnd3rSRcQ1HWsDMbhqdht7BzNd9IFTKkBgsim6qMjUjy450kvFysYssF5oGXEsZQ/
	YQJVkYxr8uH5seuVDVmQEziBJTUUkb0zU6xc6BY1G7GNhcte1VB7135MHUIRce2SJzk981xXABm
	d+Ep7eHFVuNoojDO1cgh7gHxwA==
X-Received: by 2002:a05:622a:900a:b0:467:79eb:4a16 with SMTP id d75a77b69052e-46779eb4dfamr28229211cf.4.1733819816881;
        Tue, 10 Dec 2024 00:36:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEazZl2nb7+W1PyktYZ1vwK3OYpgBWcIWjH7XStMhK6S8yrD2oF8TqcReAmDTmO8s5JsMLxw==
X-Received: by 2002:a05:622a:900a:b0:467:79eb:4a16 with SMTP id d75a77b69052e-46779eb4dfamr28228911cf.4.1733819816560;
        Tue, 10 Dec 2024 00:36:56 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46782e5c662sm1135561cf.80.2024.12.10.00.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 00:36:56 -0800 (PST)
Message-ID: <2d713deb-180a-422f-b7bd-15832944d1e4@redhat.com>
Date: Tue, 10 Dec 2024 09:36:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in NUM
To: syzbot <syzbot+3f059ffbdd539a3f6bc9@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6753d8c1.050a0220.a30f1.0151.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6753d8c1.050a0220.a30f1.0151.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/24 06:10, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=146c8330580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6851fe4f61792030
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f059ffbdd539a3f6bc9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-cdd30ebb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/35bb9b3cd157/vmlinux-cdd30ebb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9c6bbf481907/bzImage-cdd30ebb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3f059ffbdd539a3f6bc9@syzkaller.appspotmail.com
> 
> Dec  3 05:04:02 syzkaller daemon.info dhcpcd[5653]: eth3: IAID d8:df:c9:55
> Dec  3 05:04:02 syzkaller daemon.info dhcpcd[5653]: eth3: adding address fe80::7[   49.690919][ T6466] ------------[ cut here ]------------
> f27:c3e8:bb45:52[   49.693207][ T6466] WARNING: CPU: 3 PID: 6466 at net/ipv6/ip6mr.c:419 ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
> df
> Dec  3 05:04:02 [   49.710042][ T6466] Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 c4 c5 af f7 90 <0f> 0b 90 e8 bb c5 af f7 48 8d 7b 38 e8 22 86 9c f7 48 89 df be 0f
> syzkaller kern.w[   49.717312][ T6466] RSP: 0018:ffffc90003487bd8 EFLAGS: 00010293
> arn kernel: [   [   49.719598][ T6466] RAX: 0000000000000000 RBX: ffff888108508000 RCX: ffffffff89ea4014
> 49.690919][ T646[   49.725534][ T6466] RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> 6] ------------[[   49.725548][ T6466] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88804e965ac0
>  cut here ]-----[   49.725561][ T6466] R13: ffff888108508000 R14: ffff888108508008 R15: dead000000000100
> -------
> Dec  3 05:04:02 [   49.739536][ T6466] CR2: 00007f4fd5157580 CR3: 0000000035ea8000 CR4: 0000000000352ef0
> syzkaller kern.w[   49.742428][ T6466] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> arn kernel: [   [   49.746956][ T6466] Call Trace:
> 49.693207][ T646[   49.748809][ T6466]  ? __warn+0xea/0x3c0 kernel/panic.c:746
> 6] WARNING: CPU:[   49.750217][ T6466]  ? ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
>  3 PID: 6466 at [   49.751877][ T6466]  ? __report_bug lib/bug.c:199 [inline]
>  3 PID: 6466 at [   49.751877][ T6466]  ? report_bug+0x3c0/0x580 lib/bug.c:219
> net/ipv6/ip6mr.c[   49.751908][ T6466]  ? exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
> :419 ip6mr_free_[   49.751922][ T6466]  ? asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
> table+0xbd/0x120[   49.759463][ T6466]  ? ip6mr_free_table+0xbc/0x120 net/ipv6/ip6mr.c:419
> 
> Dec  3 05:04:02 syzkaller kern[   49.762545][ T6466]  ? ip6mr_free_table+0xbc/0x120 net/ipv6/ip6mr.c:419
> .warn kernel: [ [   49.765091][ T6466]  ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
>   49.696818][ T6[   49.767196][ T6466]  ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
> 466] Modules lin[   49.768971][ T6466]  ? __pfx_ip6mr_net_exit_batch+0x10/0x10 net/ipv6/ip6mr.c:285
> ked in:
> Dec  3 05:04:02 [   49.769038][ T6466]  setup_net+0x4fe/0x860 net/core/net_namespace.c:394
> syzkaller kern.w[   49.769059][ T6466]  ? __pfx_setup_net+0x10/0x10 net/core/net_namespace.c:185
> arn kernel: [   [   49.778049][ T6466]  ? __down_read_common kernel/locking/rwsem.c:1255 [inline]
> arn kernel: [   [   49.778049][ T6466]  ? __down_read_killable kernel/locking/rwsem.c:1271 [inline]
> arn kernel: [   [   49.778049][ T6466]  ? down_read_killable+0xcc/0x380 kernel/locking/rwsem.c:1549
> 49.699801][ T646[   49.781754][ T6466]  ? lockdep_init_map_waits include/linux/lockdep.h:135 [inline]
> 49.699801][ T646[   49.781754][ T6466]  ? lockdep_init_map_wait include/linux/lockdep.h:142 [inline]
> 49.699801][ T646[   49.781754][ T6466]  ? __raw_spin_lock_init+0x3a/0x110 kernel/locking/spinlock_debug.c:25
> 6] CPU: 3 UID: 0 PID: 6466 Comm: syz.2.106 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0

#syz fix: ipmr: tune the ipmr_can_free_table() checks.


