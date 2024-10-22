Return-Path: <netdev+bounces-137780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5B9A9C57
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED791C23480
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9DF15E5D3;
	Tue, 22 Oct 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HgLI6JBQ"
X-Original-To: netdev@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8C15B102
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585500; cv=none; b=DlmFGEBk7Pp5OHriIA0Aj1+Gg+03PQpKLtFfPsfDRLMO9Ptwp0bEdgSgKi+j19kgGaai3KTH/cuTzRtIXhTcR6qK6Q3YRDW/H7Y9IPzPGTKHKDCW9agCvoa7ZPLwUIOYQTiCnf+7UwvIJWKz3rEF4W0alszEKTtrDPYz25gjOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585500; c=relaxed/simple;
	bh=nWbUuRkkA8xa4hj7k5sHyXIJynhdFqA3FXpFXKa+pyo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E3LGRKuDEFUfkg4qeEqBuMoCDQeMBurY9DUfHx7kD6TiKiSdsg/WWSUHKzsPKp2VSAUSXYekKC9UUZ/wBLCsnWzZnMLIwgFGeTsJS6oToNALyDEnuYTKu0L7cSVB22wkARe6NKBSJcOVt/Gvr4oyUltYfUF3Ffl2bLmSl02R0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HgLI6JBQ; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:320f:0:640:c550:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id C2A6060C9D;
	Tue, 22 Oct 2024 11:24:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jONm0m48NSw0-eoEAFMmx;
	Tue, 22 Oct 2024 11:24:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729585488; bh=i6VPOGg07+Jv0jJdjsgOrE+uGFP6v079ghGi+U2AAiI=;
	h=Subject:To:From:Cc:Date:Message-ID;
	b=HgLI6JBQ6Fj8emYPTwQaCtgpPxfkPxIb+wZQ+mQGWEbCGkiAAA3SXl5Y+clWzUFC7
	 cXq4uYX+YMRNPBfLX1mpLnbrUarJmrIBPh3+W2jKQpWhyPC7Z4AN1ek+MFTLvG6y16
	 H45rG3WFh7Cny26H/uDINZBFLe2lKQHkhdekK5zw=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>
Date: Tue, 22 Oct 2024 11:24:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>
Cc: Simon Horman <horms@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: RTNL: assertion failed at net/core/dev.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

running around https://syzkaller.appspot.com/bug?extid=b390c8062d8387b6272a
with net-next and linux-next, I've noticed the following:

# reboot -f
...
[   16.324520][ T5121] ------------[ cut here ]------------
[   16.324750][ T5121] RTNL: assertion failed at net/core/dev.c (6627)
[   16.325133][ T5121] WARNING: CPU: 0 PID: 5121 at net/core/dev.c:6627 netif_queue_set_napi+0x25b/0x2e0
[   16.325530][ T5121] Modules linked in:
[   16.325697][ T5121] CPU: 0 UID: 0 PID: 5121 Comm: reboot Not tainted 6.12.0-rc4-00051-g5d4382aa0e93 #4
[   16.326085][ T5121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
[   16.326470][ T5121] RIP: 0010:netif_queue_set_napi+0x25b/0x2e0
[   16.326725][ T5121] Code: 62 fe ff ff e8 96 a2 e1 f8 c6 05 37 47 7e 07 01 90 ba e3 19 00 00 48 c7 c6 c0 f5 7a 8c 48 c7 c7 00 f6 7a 8c e8 76 85 a4 f8 90 <0f> 0b 90 90 e9 33 fe ff ff e8 67 a2 e1 f8 
90 0f 0b 90 e8 5e a2 e1
[   16.327487][ T5121] RSP: 0018:ffffc9000320fb58 EFLAGS: 00010282
[   16.327737][ T5121] RAX: 0000000000000000 RBX: ffff888107a48000 RCX: 0000000000000000
[   16.328169][ T5121] RDX: 0000000000000000 RSI: ffffffff8abe03c6 RDI: 0000000000000001
[   16.328483][ T5121] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[   16.328794][ T5121] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[   16.329128][ T5121] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888105b04940
[   16.329517][ T5121] FS:  00007efd0d0c7380(0000) GS:ffff888062800000(0000) knlGS:0000000000000000
[   16.329877][ T5121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.330148][ T5121] CR2: 00007efd0d3af8c0 CR3: 000000002460a000 CR4: 00000000000006f0
[   16.330467][ T5121] Call Trace:
[   16.330601][ T5121]  <TASK>
[   16.330723][ T5121]  ? __warn.cold+0x163/0x2ef
[   16.330933][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
[   16.331157][ T5121]  ? report_bug+0x28f/0x490
[   16.331349][ T5121]  ? handle_bug+0x54/0x90
[   16.331527][ T5121]  ? exc_invalid_op+0x17/0x50
[   16.331719][ T5121]  ? asm_exc_invalid_op+0x1a/0x20
[   16.331928][ T5121]  ? __warn_printk.cold+0x146/0x1a0
[   16.332144][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
[   16.332364][ T5121]  ? netif_queue_set_napi+0x25a/0x2e0
[   16.332583][ T5121]  e1000_down+0x2be/0x6b0
[   16.332767][ T5121]  __e1000_shutdown.isra.0+0x1d6/0x7f0
[   16.332995][ T5121]  e1000_shutdown+0x6d/0x110
[   16.333191][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
[   16.333405][ T5121]  ? lockdep_hardirqs_on+0x7b/0x110
[   16.333618][ T5121]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[   16.333854][ T5121]  ? __pm_runtime_resume+0xc3/0x170
[   16.334072][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
[   16.334323][ T5121]  pci_device_shutdown+0x83/0x160
[   16.334539][ T5121]  device_shutdown+0x3ba/0x5c0
[   16.334738][ T5121]  ? __pfx_pci_device_shutdown+0x10/0x10
[   16.334979][ T5121]  kernel_restart+0x64/0xa0
[   16.335170][ T5121]  __do_sys_reboot+0x29a/0x400
[   16.335369][ T5121]  ? __pfx___do_sys_reboot+0x10/0x10
[   16.335582][ T5121]  ? lock_acquire+0x2f/0xb0
[   16.335772][ T5121]  ? __pfx_ksys_sync+0x10/0x10
[   16.335975][ T5121]  do_syscall_64+0xc7/0x250
[   16.336166][ T5121]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   16.336408][ T5121] RIP: 0033:0x7efd0d2208b4
[   16.336589][ T5121] Code: f0 ff ff 73 01 c3 48 8b 0d 71 55 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 45 55 0d 
00 f7 d8 64 89 02 48 83
[   16.337336][ T5121] RSP: 002b:00007ffd84212378 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
[   16.337663][ T5121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efd0d2208b4
[   16.337971][ T5121] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
[   16.338381][ T5121] RBP: 0000000000000004 R08: 0000000000000001 R09: 00007efd0d3af8ca
[   16.338690][ T5121] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd842124c8
[   16.339003][ T5121] R13: 00007ffd842124e0 R14: 0000558687946169 R15: 00007efd0d3fea80
[   16.339322][ T5121]  </TASK>
[   16.339448][ T5121] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   16.339729][ T5121] CPU: 0 UID: 0 PID: 5121 Comm: reboot Not tainted 6.12.0-rc4-00051-g5d4382aa0e93 #4
[   16.340092][ T5121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
[   16.340458][ T5121] Call Trace:
[   16.340590][ T5121]  <TASK>
[   16.340709][ T5121]  dump_stack_lvl+0x100/0x190
[   16.340898][ T5121]  panic+0x314/0x6da
[   16.341061][ T5121]  ? __pfx_panic+0x10/0x10
[   16.341242][ T5121]  ? show_trace_log_lvl+0x1ac/0x300
[   16.341454][ T5121]  ? check_panic_on_warn+0x1f/0x90
[   16.341664][ T5121]  check_panic_on_warn.cold+0x19/0x34
[   16.341879][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
[   16.342098][ T5121]  __warn.cold+0x16f/0x2ef
[   16.342278][ T5121]  ? netif_queue_set_napi+0x25b/0x2e0
[   16.342491][ T5121]  report_bug+0x28f/0x490
[   16.342665][ T5121]  handle_bug+0x54/0x90
[   16.342831][ T5121]  exc_invalid_op+0x17/0x50
[   16.343017][ T5121]  asm_exc_invalid_op+0x1a/0x20
[   16.343265][ T5121] RIP: 0010:netif_queue_set_napi+0x25b/0x2e0
[   16.343508][ T5121] Code: 62 fe ff ff e8 96 a2 e1 f8 c6 05 37 47 7e 07 01 90 ba e3 19 00 00 48 c7 c6 c0 f5 7a 8c 48 c7 c7 00 f6 7a 8c e8 76 85 a4 f8 90 <0f> 0b 90 90 e9 33 fe ff ff e8 67 a2 e1 f8 
90 0f 0b 90 e8 5e a2 e1
[   16.344252][ T5121] RSP: 0018:ffffc9000320fb58 EFLAGS: 00010282
[   16.344493][ T5121] RAX: 0000000000000000 RBX: ffff888107a48000 RCX: 0000000000000000
[   16.344798][ T5121] RDX: 0000000000000000 RSI: ffffffff8abe03c6 RDI: 0000000000000001
[   16.345109][ T5121] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[   16.345420][ T5121] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[   16.345734][ T5121] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888105b04940
[   16.346115][ T5121]  ? __warn_printk.cold+0x146/0x1a0
[   16.346328][ T5121]  ? netif_queue_set_napi+0x25a/0x2e0
[   16.346547][ T5121]  e1000_down+0x2be/0x6b0
[   16.346722][ T5121]  __e1000_shutdown.isra.0+0x1d6/0x7f0
[   16.346943][ T5121]  e1000_shutdown+0x6d/0x110
[   16.347133][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
[   16.347345][ T5121]  ? lockdep_hardirqs_on+0x7b/0x110
[   16.347570][ T5121]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[   16.347806][ T5121]  ? __pm_runtime_resume+0xc3/0x170
[   16.348119][ T5121]  ? __pfx_e1000_shutdown+0x10/0x10
[   16.348335][ T5121]  pci_device_shutdown+0x83/0x160
[   16.348542][ T5121]  device_shutdown+0x3ba/0x5c0
[   16.348738][ T5121]  ? __pfx_pci_device_shutdown+0x10/0x10
[   16.348970][ T5121]  kernel_restart+0x64/0xa0
[   16.349159][ T5121]  __do_sys_reboot+0x29a/0x400
[   16.349355][ T5121]  ? __pfx___do_sys_reboot+0x10/0x10
[   16.349573][ T5121]  ? lock_acquire+0x2f/0xb0
[   16.349760][ T5121]  ? __pfx_ksys_sync+0x10/0x10
[   16.349960][ T5121]  do_syscall_64+0xc7/0x250
[   16.350148][ T5121]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   16.350388][ T5121] RIP: 0033:0x7efd0d2208b4
[   16.350568][ T5121] Code: f0 ff ff 73 01 c3 48 8b 0d 71 55 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 45 55 0d 
00 f7 d8 64 89 02 48 83
[   16.351318][ T5121] RSP: 002b:00007ffd84212378 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
[   16.351649][ T5121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efd0d2208b4
[   16.351962][ T5121] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
[   16.352274][ T5121] RBP: 0000000000000004 R08: 0000000000000001 R09: 00007efd0d3af8ca
[   16.352587][ T5121] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd842124c8
[   16.352897][ T5121] R13: 00007ffd842124e0 R14: 0000558687946169 R15: 00007efd0d3fea80
[   16.353215][ T5121]  </TASK>
[   16.353721][ T5121] Kernel Offset: disabled
[   16.353907][ T5121] Rebooting in 86400 seconds..

Fast manual bisection makes me think that this was introduced with
8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs"), so
please look at this patch once again.

Dmitry


