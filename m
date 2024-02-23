Return-Path: <netdev+bounces-74314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75178860DC3
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3CF28297F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA159B47;
	Fri, 23 Feb 2024 09:16:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDB1AAD8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679801; cv=none; b=GIRd2Xk8A8AOJpOsldZschOExEtBcQPL4asZBdK/VPJ0/KkBqttpg4batNRop2ki2zxIj/UCfP1+G5qQRV0STkVvKS/L9O6LZxGIlztgeaysD5SCrhL+MPfeCIv3WktQ9GlBXAYkx6vFD1EkgsYTZga6XG+Knxdp67dmAUg67mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679801; c=relaxed/simple;
	bh=o6Ne5XFFprkYaeU+uml6UMhNIQVh3Ne9sXXMIEoRgm4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NwkCsM7jEPevOWaJvmCO+mZa4eC6S80M/fe1lDAwTvjbQ+Lf6PlsJJRII1cGIwY3dBVZxPPSL9+BE6U3Jz780a5zM0RvYXxPiK1KHGDuW4yPntHdJO6On3UaUtI5d3pP+NyxMyihbPdrFczdJY+NIZZcxHSXndUgjwPK02JUwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas7t1708679688t631t13971
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [220.184.149.201])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17674526621027131931
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<maciej.fijalkowski@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com> <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch> <003801da6249$888e4210$99aac630$@trustnetic.com> <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch> <00e301da63de$bd53db90$37fb92b0$@trustnetic.com> <96b3ed32-1115-46bf-ae07-9eea0c24e85a@lunn.ch> <021e01da6532$6ab0e900$4012bb00$@trustnetic.com> <91d182fe-179b-4fad-9d67-3b62230dcb86@lunn.ch>
In-Reply-To: <91d182fe-179b-4fad-9d67-3b62230dcb86@lunn.ch>
Subject: RE: [PATCH] net: txgbe: fix GPIO interrupt blocking
Date: Fri, 23 Feb 2024 17:14:47 +0800
Message-ID: <038101da6638$bf8cd310$3ea67930$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKQWSrySMPq8PWl707TeSOritAirQH7bedeAP/Pp5gCVYvqAQHVv3hWAVoX6xcBxXLXCgH1FNMLr0nOXVA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Thu, Feb 22, 2024 11:08 PM, Andrew Lunn wrote:
> > There are flags passed in sfp.c:
> >
> > err = devm_request_threaded_irq(sfp->dev, sfp->gpio_irq[i],
> > 				NULL, sfp_irq,
> > 				IRQF_ONESHOT |
> > 				IRQF_TRIGGER_RISING |
> > 				IRQF_TRIGGER_FALLING,
> > 				sfp_irq_name, sfp);
> 
> Does you hardware support edges for GPIOs? And by that, i mean the
> whole chain of interrupt controllers? So your GPIO controller notices
> an edge in the GPIO. It then passed a notification to the interrupt
> controller within the GPIO controller. It then sets a bit to indicate
> an interrupt has happened. At that point you have a level
> interrupt. That bit causes a level interrupt to the interrupt
> controller above in the chain. And it needs to be level all way up.

My hardware is required to configure GPIOs as edge-sensitive.
But I think I got something wrong. There were two problems to be solved
in this patch:

1) The register of GPIO interrupt status is masked before MAC IRQ enabled.

This is because of hardware deficiency. I need to manually clear the interrupt
status before using them. Otherwise, GPIO interrupts will never be reported
again. So there is a workaround for clearing interrupts to set GPIOs EOI in
txgbe_up_complete().

2) GPIO EOI is not set to clear interrupt status after handling the interrupt,
it  should be done in chip->irq_ack, but this ops is not called.

This is because I used handle_nested_irq() in txgbe_gpio_irq_handler() to
handle the IRQ of specific GPIO line. Since the IRQ is requested as threaded
IRQ and only action->thread_fn is created in sfp.c, the highlevel irq-events
handler (handle_level_irq() or handle_edge_irq() set in gpio irq chip) is not
called. Both level and edge type will call chip->irq_ack, but they are not called.

So I should use generic_handle_domain_irq() instead of handle_nested_irq()
to handle GPIO IRQ. But there is call trace when I do it,

[   86.784113] ------------[ cut here ]------------
[   86.784114] irq 154 handler irq_default_primary_handler+0x0/0x10 enabled interrupts
[   86.784122] WARNING: CPU: 0 PID: 3383 at kernel/irq/handle.c:161 __handle_irq_event_percpu+0x150/0x1a0
[   86.784125] Modules linked in: i2c_designware_platform sfp i2c_designware_core txgbe libwx fuse vfat fat nouveau
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel intel_rapl_msr snd_intel_dspcfg intel_rapl_common
snd_hda_codec snd_hda_core edac_mce_amd snd_hwdep eeepc_wmi crc32_pclmul asus_wmi snd_pcm ledtrig_audio platform_profile
ghash_clmulni_intel sparse_keymap snd_seq_dummy sha512_ssse3 rfkill wmi_bmof drm_gpuvm snd_seq_oss mxm_wmi drm_exec snd_seq_midi
binfmt_misc snd_seq_midi_event gpu_sched snd_rawmidi aesni_intel i2c_algo_bit crypto_simd bridge cryptd snd_seq drm_display_helper
snd_seq_device drm_ttm_helper snd_timer ttm stp drm_kms_helper snd llc acpi_cpufreq k10temp ccp video soundcore wmi squashfs loop
sch_fq_codel drm parport_pc ppdev lp parport ramoops reed_solomon ip_tables ext4 mbcache jbd2 mdio_i2c nvme ahci nvme_core libahci
t10_pi i2c_piix4 libata pcs_xpcs crc32c_intel crc64_rocksoft i2c_core crc64 crc_t10dif r8169 crct10dif_generic crct10dif_pclmul
phylink
[   86.784200]  crct10dif_common realtek [last unloaded: i2c_designware_core]
[   86.784204] CPU: 0 PID: 3383 Comm: irq/126-eth%d Not tainted 6.8.0-rc1+ #147
[   86.784206] Hardware name: System manufacturer System Product Name/PRIME X570-P, BIOS 4403 04/28/2022
[   86.784207] RIP: 0010:__handle_irq_event_percpu+0x150/0x1a0
[   86.784210] Code: 44 00 00 e9 09 ff ff ff 80 3d 17 15 7e 01 00 75 1b 48 8b 13 44 89 ee 48 c7 c7 f8 e7 82 a8 c6 05 01 15 7e 01 01
e8 00 d8 f6 ff <0f> 0b fa 0f 1f 44 00 00 e9 fc fe ff ff f0 48 0f ba 6b 40 01 0f 82
[   86.784211] RSP: 0018:ffffa04300d6bd68 EFLAGS: 00010282
[   86.784213] RAX: 0000000000000000 RBX: ffff8defda7bc000 RCX: 0000000000000000
[   86.784214] RDX: 0000000000000002 RSI: ffffffffa88644c3 RDI: 00000000ffffffff
[   86.784215] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffa04300d6bc00
[   86.784216] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   86.784217] R13: 000000000000009a R14: ffff8def8ff50a00 R15: ffff8defda7bc300
[   86.784219] FS:  0000000000000000(0000) GS:ffff8df68ea00000(0000) knlGS:0000000000000000
[   86.784220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.784221] CR2: 000000c00081f000 CR3: 00000001821b6000 CR4: 0000000000750ef0
[   86.784222] PKRU: 55555554
[   86.784223] Call Trace:
[   86.784225]  <TASK>
[   86.784227]  ? __warn+0x80/0x130
[   86.784231]  ? __handle_irq_event_percpu+0x150/0x1a0
[   86.784233]  ? report_bug+0x1f4/0x200
[   86.784236]  ? srso_alias_return_thunk+0x5/0xfbef5
[   86.784240]  ? handle_bug+0x42/0x70
[   86.784243]  ? exc_invalid_op+0x14/0x70
[   86.784245]  ? asm_exc_invalid_op+0x16/0x20
[   86.784249]  ? __handle_irq_event_percpu+0x150/0x1a0
[   86.784251]  ? __handle_irq_event_percpu+0x150/0x1a0
[   86.784253]  ? __pfx_irq_thread_fn+0x10/0x10
[   86.784255]  handle_irq_event_percpu+0x10/0x50
[   86.784257]  handle_irq_event+0x34/0x60
[   86.784260]  handle_level_irq+0xa5/0x120
[   86.784263]  handle_irq_desc+0x3a/0x50
[   86.784266]  txgbe_gpio_irq_handler+0x82/0x140 [txgbe]
[   86.784271]  ? __pfx_irq_thread_fn+0x10/0x10
[   86.784273]  handle_nested_irq+0xaf/0x100
[   86.784275]  txgbe_misc_irq_handle+0x60/0x80 [txgbe]
[   86.784279]  irq_thread_fn+0x20/0x60
[   86.784282]  irq_thread+0xe2/0x190
[   86.784284]  ? srso_alias_return_thunk+0x5/0xfbef5
[   86.784286]  ? __pfx_irq_thread_dtor+0x10/0x10
[   86.784288]  ? __pfx_irq_thread+0x10/0x10
[   86.784290]  kthread+0xf0/0x120
[   86.784294]  ? __pfx_kthread+0x10/0x10
[   86.784296]  ret_from_fork+0x30/0x50
[   86.784299]  ? __pfx_kthread+0x10/0x10
[   86.784301]  ret_from_fork_asm+0x1b/0x30
[   86.784306]  </TASK>
[   86.784307] ---[ end trace 0000000000000000 ]---

This is due to default primary handler in the irq action chain.
I'm not quite sure what I dig here, am I missing any flags?



