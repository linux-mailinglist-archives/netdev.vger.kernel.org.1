Return-Path: <netdev+bounces-137958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479209AB3ED
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8811F2149A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960611A4F1B;
	Tue, 22 Oct 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="k3Ceppbp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDB1474C9
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614429; cv=none; b=r4B+EHAZ90FeWKoozUTfzSQGJMaVgsrd8ujfE3pdHGLAuRu02kYVLbCHcdBxRsaiDJO2fevkOhwZgNlehKK2AU4N350kHK4UNW85zJaWTrMjOwwqNVoMHqJdC+kfqaaui66NCCE8zEQMMsxmwn+g4zokAIEQgW8jhgOxpOxr+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614429; c=relaxed/simple;
	bh=JF1ot1KKFBt3VmIdGguMHCgpwn2RdBXnMOPY+pOQoEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEEepUF+92tCrarNFxZGonl0ADuxJvA512st+aIg7hLWp7qj7YMZwBSBxi6SoLNcHFssaH4R27nsofhIsjIUTkToSIaxnsCrBHWGWFFpRN2loOw0J65gwJrPvjGMetbJYk5jOaePdZAe40eoKfqxgPgitrm20+ACyYWuZmNtydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=k3Ceppbp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdbe608b3so48182565ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729614427; x=1730219227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P17u73tzu6baozQ8mzn9PDSUHLI2WlJBSf89HSBdajk=;
        b=k3Ceppbpw3rk8LV/Ry0z+IjNs0OFc5lZR2+173dyATHxKNCiYlQ++XekhlxB80zFmS
         Wc23vbUsfiHHJLDEsDU/oKfJSKjirGNgxLvXVQtlVm0/7osapsWspJWw+u1dA4yABQZa
         R+bcnFyUmPwayJxhQBBvYEs8SkcyVIIkophEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614427; x=1730219227;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P17u73tzu6baozQ8mzn9PDSUHLI2WlJBSf89HSBdajk=;
        b=B42YpJ+yEE9bj3BtnjlI27O3tQRwsl3JRLY/J4JoUYs6hbNuUWFbhaUuRb27zz5CD0
         d8M3dSLi80v8Ef8osJ/o7c7xwlthge830IccuHMXjTJeJ+B1JYoxyS5aLd/qxqtDWYuK
         os0Ed2wVnQFnaDwvJzrNgU50mtvY4g1N+xR3cKNMnV2EIUw679O2oGWOLDYUI9rfJmi7
         /dIUce47q1+/m8H5jVElhOiNJ+Jv1VRQXkyJtWIIcpnc76kSWUcSLzmiG6UmnjIIe5Hk
         1UvBx1Kyr6TDiXYtEWsYOP1BYb9uvCMMeviE4ecPcGbQ9neXHbh+KdxvuPo4Taz5Se7M
         zloA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Glnv6Y6xkTfz8pd5k6ItBZDBUCugbRZlsk6s8hQKA4oBshrxDxq8xfkCyzTdxsovbjePgqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVmfqu83mfWqo+YyvxBa02qYHIGuhZu9IpTsGwtWeCF3AP3nb
	xvPz/S8jwylaR8H0FdspvJtLJEBKQK3gR4JSmaDLqryZhyMuOgcJRghzYRibr9o=
X-Google-Smtp-Source: AGHT+IFJZvPkUe+TP5gVyj8g34DiclLei/dlWdJw9eg5c+jkFL9vcO7Kf5eIADi11TrtsM6GLU6u6A==
X-Received: by 2002:a17:902:fc84:b0:207:15f9:484a with SMTP id d9443c01a7336-20e948937b3mr58904385ad.15.1729614426793;
        Tue, 22 Oct 2024 09:27:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f65cbsm44671345ad.273.2024.10.22.09.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:27:06 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:27:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RTNL: assertion failed at net/core/dev.c
Message-ID: <ZxfSV66cYq7N6i5H@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>

On Tue, Oct 22, 2024 at 11:24:45AM +0300, Dmitry Antipov wrote:
> Hello,
> 
> running around https://syzkaller.appspot.com/bug?extid=b390c8062d8387b6272a
> with net-next and linux-next, I've noticed the following:
> 
> # reboot -f
> ...
> [   16.324520][ T5121] ------------[ cut here ]------------
> [   16.324750][ T5121] RTNL: assertion failed at net/core/dev.c (6627)
> [   16.325133][ T5121] WARNING: CPU: 0 PID: 5121 at net/core/dev.c:6627 netif_queue_set_napi+0x25b/0x2e0
> [   16.325530][ T5121] Modules linked in:
> [   16.325697][ T5121] CPU: 0 UID: 0 PID: 5121 Comm: reboot Not tainted 6.12.0-rc4-00051-g5d4382aa0e93 #4
> [   16.326085][ T5121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> [   16.326470][ T5121] RIP: 0010:netif_queue_set_napi+0x25b/0x2e0
> [   16.326725][ T5121] Code: 62 fe ff ff e8 96 a2 e1 f8 c6 05 37 47 7e 07 01
> 90 ba e3 19 00 00 48 c7 c6 c0 f5 7a 8c 48 c7 c7 00 f6 7a 8c e8 76 85 a4 f8
> 90 <0f> 0b 90 90 e9 33 fe ff ff e8 67 a2 e1 f8 90 0f 0b 90 e8 5e a2 e1
> [   16.327487][ T5121] RSP: 0018:ffffc9000320fb58 EFLAGS: 00010282
> [   16.327737][ T5121] RAX: 0000000000000000 RBX: ffff888107a48000 RCX: 0000000000000000
> [   16.328169][ T5121] RDX: 0000000000000000 RSI: ffffffff8abe03c6 RDI: 0000000000000001
> [   16.328483][ T5121] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [   16.328794][ T5121] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [   16.329128][ T5121] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888105b04940
> [   16.329517][ T5121] FS:  00007efd0d0c7380(0000) GS:ffff888062800000(0000) knlGS:0000000000000000
> [   16.329877][ T5121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.330148][ T5121] CR2: 00007efd0d3af8c0 CR3: 000000002460a000 CR4: 00000000000006f0
> [   16.330467][ T5121] Call Trace:
> [   16.330601][ T5121]  <TASK>
> [   16.330723][ T5121]  ? __warn.cold+0x163/0x2ef
> [   16.330933][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
> [   16.331157][ T5121]  ? report_bug+0x28f/0x490
> [   16.331349][ T5121]  ? handle_bug+0x54/0x90
> [   16.331527][ T5121]  ? exc_invalid_op+0x17/0x50
> [   16.331719][ T5121]  ? asm_exc_invalid_op+0x1a/0x20
> [   16.331928][ T5121]  ? __warn_printk.cold+0x146/0x1a0
> [   16.332144][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
> [   16.332364][ T5121]  ? netif_queue_set_napi+0x25a/0x2e0
> [   16.332583][ T5121]  e1000_down+0x2be/0x6b0
> [   16.332767][ T5121]  __e1000_shutdown.isra.0+0x1d6/0x7f0
> [   16.332995][ T5121]  e1000_shutdown+0x6d/0x110
> [   16.333191][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
> [   16.333405][ T5121]  ? lockdep_hardirqs_on+0x7b/0x110
> [   16.333618][ T5121]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
> [   16.333854][ T5121]  ? __pm_runtime_resume+0xc3/0x170
> [   16.334072][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
> [   16.334323][ T5121]  pci_device_shutdown+0x83/0x160
> [   16.334539][ T5121]  device_shutdown+0x3ba/0x5c0
> [   16.334738][ T5121]  ? __pfx_pci_device_shutdown+0x10/0x10
> [   16.334979][ T5121]  kernel_restart+0x64/0xa0
> [   16.335170][ T5121]  __do_sys_reboot+0x29a/0x400
> [   16.335369][ T5121]  ? __pfx___do_sys_reboot+0x10/0x10
> [   16.335582][ T5121]  ? lock_acquire+0x2f/0xb0
> [   16.335772][ T5121]  ? __pfx_ksys_sync+0x10/0x10
> [   16.335975][ T5121]  do_syscall_64+0xc7/0x250
> [   16.336166][ T5121]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   16.336408][ T5121] RIP: 0033:0x7efd0d2208b4
> [   16.336589][ T5121] Code: f0 ff ff 73 01 c3 48 8b 0d 71 55 0d 00 f7 d8 64
> 89 01 48 83 c8 ff c3 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 45 55 0d 00 f7 d8 64 89 02 48 83
> [   16.337336][ T5121] RSP: 002b:00007ffd84212378 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
> [   16.337663][ T5121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efd0d2208b4
> [   16.337971][ T5121] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [   16.338381][ T5121] RBP: 0000000000000004 R08: 0000000000000001 R09: 00007efd0d3af8ca
> [   16.338690][ T5121] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd842124c8
> [   16.339003][ T5121] R13: 00007ffd842124e0 R14: 0000558687946169 R15: 00007efd0d3fea80
> [   16.339322][ T5121]  </TASK>
> [   16.339448][ T5121] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [   16.339729][ T5121] CPU: 0 UID: 0 PID: 5121 Comm: reboot Not tainted 6.12.0-rc4-00051-g5d4382aa0e93 #4
> [   16.340092][ T5121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> [   16.340458][ T5121] Call Trace:
> [   16.340590][ T5121]  <TASK>
> [   16.340709][ T5121]  dump_stack_lvl+0x100/0x190
> [   16.340898][ T5121]  panic+0x314/0x6da
> [   16.341061][ T5121]  ? __pfx_panic+0x10/0x10
> [   16.341242][ T5121]  ? show_trace_log_lvl+0x1ac/0x300
> [   16.341454][ T5121]  ? check_panic_on_warn+0x1f/0x90
> [   16.341664][ T5121]  check_panic_on_warn.cold+0x19/0x34
> [   16.341879][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
> [   16.342098][ T5121]  __warn.cold+0x16f/0x2ef
> [   16.342278][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
> [   16.342491][ T5121]  report_bug+0x28f/0x490
> [   16.342665][ T5121]  handle_bug+0x54/0x90
> [   16.342831][ T5121]  exc_invalid_op+0x17/0x50
> [   16.343017][ T5121]  asm_exc_invalid_op+0x1a/0x20
> [   16.343265][ T5121] RIP: 0010:netif_queue_set_napi+0x25b/0x2e0
> [   16.343508][ T5121] Code: 62 fe ff ff e8 96 a2 e1 f8 c6 05 37 47 7e 07 01
> 90 ba e3 19 00 00 48 c7 c6 c0 f5 7a 8c 48 c7 c7 00 f6 7a 8c e8 76 85 a4 f8
> 90 <0f> 0b 90 90 e9 33 fe ff ff e8 67 a2 e1 f8 90 0f 0b 90 e8 5e a2 e1
> [   16.344252][ T5121] RSP: 0018:ffffc9000320fb58 EFLAGS: 00010282
> [   16.344493][ T5121] RAX: 0000000000000000 RBX: ffff888107a48000 RCX: 0000000000000000
> [   16.344798][ T5121] RDX: 0000000000000000 RSI: ffffffff8abe03c6 RDI: 0000000000000001
> [   16.345109][ T5121] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [   16.345420][ T5121] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> [   16.345734][ T5121] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888105b04940
> [   16.346115][ T5121]  ? __warn_printk.cold+0x146/0x1a0
> [   16.346328][ T5121]  ? netif_queue_set_napi+0x25a/0x2e0
> [   16.346547][ T5121]  e1000_down+0x2be/0x6b0
> [   16.346722][ T5121]  __e1000_shutdown.isra.0+0x1d6/0x7f0
> [   16.346943][ T5121]  e1000_shutdown+0x6d/0x110
> [   16.347133][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
> [   16.347345][ T5121]  ? lockdep_hardirqs_on+0x7b/0x110
> [   16.347570][ T5121]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
> [   16.347806][ T5121]  ? __pm_runtime_resume+0xc3/0x170
> [   16.348119][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
> [   16.348335][ T5121]  pci_device_shutdown+0x83/0x160
> [   16.348542][ T5121]  device_shutdown+0x3ba/0x5c0
> [   16.348738][ T5121]  ? __pfx_pci_device_shutdown+0x10/0x10
> [   16.348970][ T5121]  kernel_restart+0x64/0xa0
> [   16.349159][ T5121]  __do_sys_reboot+0x29a/0x400
> [   16.349355][ T5121]  ? __pfx___do_sys_reboot+0x10/0x10
> [   16.349573][ T5121]  ? lock_acquire+0x2f/0xb0
> [   16.349760][ T5121]  ? __pfx_ksys_sync+0x10/0x10
> [   16.349960][ T5121]  do_syscall_64+0xc7/0x250
> [   16.350148][ T5121]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   16.350388][ T5121] RIP: 0033:0x7efd0d2208b4
> [   16.350568][ T5121] Code: f0 ff ff 73 01 c3 48 8b 0d 71 55 0d 00 f7 d8 64
> 89 01 48 83 c8 ff c3 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 45 55 0d 00 f7 d8 64 89 02 48 83
> [   16.351318][ T5121] RSP: 002b:00007ffd84212378 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
> [   16.351649][ T5121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efd0d2208b4
> [   16.351962][ T5121] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [   16.352274][ T5121] RBP: 0000000000000004 R08: 0000000000000001 R09: 00007efd0d3af8ca
> [   16.352587][ T5121] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd842124c8
> [   16.352897][ T5121] R13: 00007ffd842124e0 R14: 0000558687946169 R15: 00007efd0d3fea80
> [   16.353215][ T5121]  </TASK>
> [   16.353721][ T5121] Kernel Offset: disabled
> [   16.353907][ T5121] Rebooting in 86400 seconds..
> 
> Fast manual bisection makes me think that this was introduced with
> 8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs"), so
> please look at this patch once again.

Thanks for reporting this.

The issue is that in the path highlighted above, rtnl is not held
before e1000_down is called.

I believe this will fix the issue you are seeing, but I am not sure
if a similar change needs to be added for power management's suspend
(which also eventually calls e1000_down):

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 4de9b156b2be..ebbd3fa3a5c8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -5074,7 +5074,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
                        usleep_range(10000, 20000);

                WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+               rtnl_lock()
                e1000_down(adapter);
+               rtnl_unlock();
        }

        status = er32(STATUS);

