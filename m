Return-Path: <netdev+bounces-115682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A7947843
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10AE1F2243A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A71514CC;
	Mon,  5 Aug 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5kUBSn2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CD3398B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849885; cv=none; b=DGPLEKlRbkxqGLGwnNkwQqJiHGi/nRigs9tN7U2FSGROPq5EV6RA47xCu7W/efJPhPmWX/syOiHj8PKjmlem0uSImuSdPpaQhk6bnzLQjXBFh+XmBMES8q7NAJBMwlc4fJV+QzQYpaPzxWKxKAUbVof9C3jr4TueGQaZYaWdX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849885; c=relaxed/simple;
	bh=M63g2oYmbMxhFljDsLtL5VEzb3XIPGEck8hCGr2prrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ZGeya96IeOcAeNZx5K3Wd7r4kibn1OGoiRTialuUNJk16/v6IZyZdyAFZ/NZ38AJCQh5jNl0PxvhMYR1jJJva8rPwSbN8DuB2gEzNbsjNkjSHQPNcVAdfK0v7hq/mEYBRnaEBI0AVTSuesdhyxgPXq2MhgeQrBTthn5L0MvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5kUBSn2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722849882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0pYmuPo/nFf96XOsauE11gUpXx62D2hN1ZeJsgHOeA=;
	b=Z5kUBSn2dHqlVMEjDnMOOlcWeom1C34ac3hjnP7Iqzh6V9OidjUyMqQtjcDvCSVIGynopu
	8MnyNVCbqFGIpj8U7CP5PxVb6BWa0/oUFb9SBNzXji2dZ/vaYX9csbZ3maWzBUZOiWKxir
	fFwRWpnM+v+jHpruqwkhdozom3Nd87c=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-B0GujWrBMbCZkAW0IzdxzQ-1; Mon, 05 Aug 2024 05:24:41 -0400
X-MC-Unique: B0GujWrBMbCZkAW0IzdxzQ-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8203b230c5eso2293718241.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 02:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849880; x=1723454680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0pYmuPo/nFf96XOsauE11gUpXx62D2hN1ZeJsgHOeA=;
        b=Xtser/+GGWNAcdQBfe3lIeWvYlHS8j03TYrzbfPK0oCr4iqym7oNKwaTFC7xIoCS6t
         ADo7Y5ZB2PeqbcciITTSgifNXH0kyPzF1/cIZYg7FepH7ePXv0IBMVNsgrf2Etw143HF
         ukn7/fWB9yARBkfhV1pU5RHBLV6lPjN7i76Mc+0QepqbSFR9uU6HmEzD5puUl5kwZxkT
         UfaO9uP7R8mFhQyH8zwS1RXyKi7Lwbh6K8Qm+pZSdrkime0+F8I9G08uNXesxiyKv3O4
         3DaaOh27+DA7RUJcdalQzqjYuToJSxWh5/LcKWFcqF96abgrokYtTmmbZ6pNk4x1P85S
         JipQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnUCcMmc3sldpupDDXZl5dv/DDONjiNTP/YD6vfnzonJTjI7MI5wxhB/2StFSVE6Z2YYqchUwkFMdIVEao+V5TO5Ds1Lso
X-Gm-Message-State: AOJu0Yzf6C8MFrJpVrypi12a2a9FFTALc62no/DqBsktHWS7noEQDMRq
	Bt/lIIysdssN5UtP9Up8Fregg/yCuvy1GD40WiL5r/NWWIpjB0K9QfiFnsQNV+uhP4sDRtiYd8G
	bd6qwygsJNNpQy5pc6uynbxtOAagbnpgu4WxgqVWvYa7MhH5grpTgvQ==
X-Received: by 2002:a05:6102:54ac:b0:493:f5a9:7aef with SMTP id ada2fe7eead31-4945bdc95c9mr13378948137.4.1722849880497;
        Mon, 05 Aug 2024 02:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYt/5yOIJftrWiL6e8dhZIESR+YaSp6QUwrrNWcyx/rzID6g2xqDxI2S/gUVul0mkJcZzR8A==
X-Received: by 2002:a05:6102:54ac:b0:493:f5a9:7aef with SMTP id ada2fe7eead31-4945bdc95c9mr13378933137.4.1722849879922;
        Mon, 05 Aug 2024 02:24:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83cc30sm32961206d6.101.2024.08.05.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:24:39 -0700 (PDT)
Date: Mon, 5 Aug 2024 11:24:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, virtualization <virtualization@lists.linux.dev>, 
	netdev <netdev@vger.kernel.org>
Subject: Re: BUG: stack guard page was hit in vsock_connectible_recvmsg
Message-ID: <xbtb4224f5l6zvwxnszjyppuus4si5cu4ka4kghpdlooqkeogz@tuvb6fjtexcw>
References: <59b20304-a273-4882-8dfb-fe9a668ec8d8.bugreport@valiantsec.com>
 <b7e53b09-3153-4640-936b-1c20c24ef75c.bugreport@valiantsec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b7e53b09-3153-4640-936b-1c20c24ef75c.bugreport@valiantsec.com>

Hi,

On Mon, Aug 05, 2024 at 08:44:11AM GMT, Ubisectech Sirius wrote:
>
>Hello.
>We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8. Attached to the email were a PoC file of the issue.

Thanks for the report!

It looks like this is releated to the net/vmw_vsock/vsock_bpf.c, so I'm 
CCing Bobby who developed that.

@Bobby if you have time, please take a look.

I'm trying to replicate on a VM with 6.8 kernel, but for now I can't 
reproduce it.

How reproducible is it in your system?

I see that the reproducer was generated by syzkaller.
Is that internal or public instance?
In the second case, do you have a link to the report?

 From the report I see that you're using 6.8.0.
Is it the upstream version (commit 
e8f897f4afef0031fe618a8e94127a0934896aba)?
Can you replicate this with more recent versions as well?

Thanks,
Stefano

>
>Stack dump:
>BUG: TASK stack guard page was hit at ffffc90001b27f88 (stack is 
>ffffc90001b28000..ffffc90001b30000)
>stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
>CPU: 0 PID: 8069 Comm: syz-executor293 Not tainted 6.8.0 #1
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>RIP: 0010:mark_lock+0x25/0xd60 kernel/locking/lockdep.c:4639
>Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 55 41 54 41 89 d4 48 ba 00 00 00 00 00 fc ff df 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 5c 24 30 48 c7 44 24 38 00 88 b9
>RSP: 0018:ffffc90001b27f90 EFLAGS: 00010086
>RAX: 0000000000000004 RBX: ffff888042cd2fa2 RCX: ffff888042cd2f64
>RDX: dffffc0000000000 RSI: ffff888042cd2f80 RDI: ffff888042cd24c0
>RBP: ffffc90001b280c8 R08: 0000000000000001 R09: fffffbfff2711214
>R10: ffffffff938890a7 R11: 0000000000000000 R12: 0000000000000002
>R13: 0000000000000000 R14: ffff888042cd24c0 R15: 000000000004073c
>FS:  00005555558f13c0(0000) GS:ffff88802c600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: ffffc90001b27f88 CR3: 0000000048cb8000 CR4: 0000000000750ef0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>PKRU: 55555554
>Call Trace:
> <#DF>
> </#DF>
> <TASK>
> mark_usage kernel/locking/lockdep.c:4587 [inline]
> __lock_acquire+0x91e/0x3bc0 kernel/locking/lockdep.c:5091
> lock_acquire kernel/locking/lockdep.c:5754 [inline]
> lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5719
> lock_sock_nested+0x3a/0xf0 net/core/sock.c:3523
> lock_sock include/net/sock.h:1691 [inline]
> vsock_connectible_recvmsg+0xdd/0xba0 net/vmw_vsock/af_vsock.c:2196
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> __vsock_recvmsg net/vmw_vsock/vsock_bpf.c:67 [inline]
> vsock_bpf_recvmsg+0xb41/0x11a0 net/vmw_vsock/vsock_bpf.c:105
> vsock_connectible_recvmsg+0x92b/0xba0 net/vmw_vsock/af_vsock.c:2240
> sock_recvmsg_nosec net/socket.c:1046 [inline]
> sock_recvmsg+0x1de/0x240 net/socket.c:1068
> ____sys_recvmsg+0x216/0x670 net/socket.c:2803
> ___sys_recvmsg+0xff/0x190 net/socket.c:2845
> __sys_recvmsg+0xfb/0x1d0 net/socket.c:2875
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x6f/0x77
>RIP: 0033:0x7f6c450819cd
>Code: c3 e8 a7 1f 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007ffcae667888 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
>RAX: ffffffffffffffda RBX: 0000000000016644 RCX: 00007f6c450819cd
>RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000005
>RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcae66789c
>R13: 431bde82d7b634db R14: 00007f6c450fe4f0 R15: 0000000000000001
> </TASK>
>Modules linked in:
>---[ end trace 0000000000000000 ]---
>RIP: 0010:mark_lock+0x25/0xd60 kernel/locking/lockdep.c:4639
>Code: 90 90 90 90 90 55 48 89 e5 41 57 41 56 41 55 41 54 41 89 d4 48 ba 00 00 00 00 00 fc ff df 53 48 83 e4 f0 48 81 ec 10 01 00 00 <48> c7 44 24 30 b3 8a b5 41 48 8d 5c 24 30 48 c7 44 24 38 00 88 b9
>RSP: 0018:ffffc90001b27f90 EFLAGS: 00010086
>RAX: 0000000000000004 RBX: ffff888042cd2fa2 RCX: ffff888042cd2f64
>RDX: dffffc0000000000 RSI: ffff888042cd2f80 RDI: ffff888042cd24c0
>RBP: ffffc90001b280c8 R08: 0000000000000001 R09: fffffbfff2711214
>R10: ffffffff938890a7 R11: 0000000000000000 R12: 0000000000000002
>R13: 0000000000000000 R14: ffff888042cd24c0 R15: 000000000004073c
>FS:  00005555558f13c0(0000) GS:ffff88802c600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: ffffc90001b27f88 CR3: 0000000048cb8000 CR4: 0000000000750ef0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>PKRU: 55555554
>----------------
>Code disassembly (best guess):
>   0:   90                      nop
>   1:   90                      nop
>   2:   90                      nop
>   3:   90                      nop
>   4:   90                      nop
>   5:   55                      push   %rbp
>   6:   48 89 e5                mov    %rsp,%rbp
>   9:   41 57                   push   %r15
>   b:   41 56                   push   %r14
>   d:   41 55                   push   %r13
>   f:   41 54                   push   %r12
>  11:   41 89 d4                mov    %edx,%r12d
>  14:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
>  1b:   fc ff df
>  1e:   53                      push   %rbx
>  1f:   48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
>  23:   48 81 ec 10 01 00 00    sub    $0x110,%rsp
>* 2a:   48 c7 44 24 30 b3 8a    movq   $0x41b58ab3,0x30(%rsp) <-- trapping instruction
>  31:   b5 41
>  33:   48 8d 5c 24 30          lea    0x30(%rsp),%rbx
>  38:   48                      rex.W
>  39:   c7                      .byte 0xc7
>  3a:   44 24 38                rex.R and $0x38,%al
>  3d:   00                      .byte 0x0
>  3e:   88                      .byte 0x88
>  3f:   b9                      .byte 0xb9
>
>Thank you for taking the time to read this email and we look forward to working with you further.
>
>
>



