Return-Path: <netdev+bounces-215252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03371B2DC8E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253C3163547
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E8311977;
	Wed, 20 Aug 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="dZW2e2Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E958374D1;
	Wed, 20 Aug 2025 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693069; cv=none; b=S3Ldl8CgkxXFSt5SR0EQX3qgv0Y9zZX6T0zFz5g4AfjSTjJAqlHRBiT/mBTNnZt68s58Q8VXcG5/NN1LOszfAwuc/uCyLbQ7hkXMQnWVgMIQB7ydrbqV4tRAWX9zPEwRKWUMwN+0g1+ZOaW071aAZmziEUDvYhuXnH+qs8zxjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693069; c=relaxed/simple;
	bh=XSOtgHJqwd2gyt0eHkw9iUIebkOH1rwpms4sDZDX4OU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOQOdWlpEkvc6TAxG5hVu/MpiXmKTyShtiHKOqK2lJa40ZZ4lwLmhXgUXq1D6KX5cQhJQhcO4Y0tJBYvizI9T6C+eQ1EFf5CbOA856BqN0pFh9RLF0u9DaZIqS74l8SwDUmQuagyHfFzlux4qgNcFFtPJcL/bJULwV3oLBGWY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=dZW2e2Ik; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755693063; x=1756297863; i=efault@gmx.de;
	bh=kLGOX+oG9XzAe1bf1yaH/BJz/LKRmV1eczsRlzPSbAo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dZW2e2IkB2ysZrlCZMRlHIwarIAIUYwf81IRlC++oXpe2JkmoNd4UQCPboCn+CZR
	 rO6XSqp/HsXa3JYuV6/l9RlcpDat1nXYr1Cs59Cgg3IZKf6TbI+RVZKFP7jaMOsOL
	 +nlUe8CUuj2GRpHLXmZ2xw6WB5yqH8NFswk6JQuqIe7ScMuGWvcRKraVtKYXdX81q
	 T3o3zOgUv5SjipZqhdP0QF5roOfgS3l6qaoFt2JwvMw3qvto0IluJxuxLSiHSP2+i
	 qTlkPU1SEHNzQHFCXL2ZC6EhItxNsZ/jfaJLk+YXZRi6eB0FiGzyDMqmle0thn+Vh
	 wECSWUgPbQYZeB2sLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.58]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1uJFMv1tqg-00dwdM; Wed, 20
 Aug 2025 14:31:03 +0200
Message-ID: <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>,  paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 boqun.feng@gmail.com
Date: Wed, 20 Aug 2025 14:31:02 +0200
In-Reply-To: <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	 <20250814172326.18cf2d72@kernel.org>
	 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
	 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:x2N2QQvgbVYZdBUh6qXLP6pL0gq9cVTcOzTFZphwVn0CJbDTrOd
 wf/5LKXKA73tns/9MYfE+WI+msGoh/HarBm0gmu8RH3Zmkn5FWm2S4s23WDRV8u4Sk//PxD
 rl9ucQFAStE/CwleedceYvgXj/sJFUjJvTpgtoAWA5qsq3WKII6RypwiLyJut7rse/XDJcK
 zbMUxCfKQli4gf9dxXaDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EvDrg0Dy/eQ=;fbYHz9mDGWwind3SxOAwbxrr0WX
 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

On Tue, 2025-08-19 at 10:27 -0700, Breno Leitao wrote:
>=20
> I=E2=80=99ve continued investigating possible solutions, and it looks lik=
e
> moving netconsole over to the non=E2=80=91blocking console (nbcon) framew=
ork
> might be the right approach. Unlike the classic console path, nbcon
> doesn=E2=80=99t rely on the global console lock, which was one of the mai=
n
> concerns regarding the possible deadlock.

ATM at least, classic can remotely log a crash whereas nbcon can't per
test drive, so it would be nice for classic to stick around until nbcon
learns some atomic packet blasting.

> The new path is protected by NETCONSOLE_NBCON, which is disabled by
> default. This allows us to experiment and test both approaches.

As patch sits, interrupts being disabled is still a problem, gripes
below.  Not disabling IRQs makes nbcon gripe free, but creates the
issue of netpoll_tx_running() lying to the rest of NETPOLL consumers.

RT and the wireless stack have in common that IRQs being disabled in
netpoll.c sucks rocks for them.  I've been carrying a hack to allow RT
to use netconsole since 5.15, and adapted it to squelch nbcons inspired
gripes as well (had to whack irqsave/restore in your patch as well).=20
Once the dust settles, perhaps RT can simply select NETCONSOLE_NBCON to
solve its netconsole woes for free.

[   99.875439] netconsole: network logging started
[   99.876652] ------------[ cut here ]------------
[   99.876922] WARNING: CPU: 3 PID: 4396 at kernel/softirq.c:387 __local_bh=
_enable_ip+0x8f/0xe0
[   99.877007] Modules linked in: netconsole ccm af_packet bridge stp llc i=
scsi_ibft iscsi_boot_sysfs cmac algif_hash algif_skcipher af_alg iwlmvm int=
el_rapl_msr intel_rapl_common mac80211 snd_hda_codec_hdmi binfmt_misc x86_p=
kg_temp_thermal intel_powerclamp snd_hda_codec_conexant snd_hda_codec_gener=
ic coretemp libarc4 kvm_intel uvcvideo snd_hda_intel snd_intel_dspcfg uvc s=
nd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep mei_hdcp iwlwifi =
kvm iTCO_wdt btusb snd_hda_core videobuf2_v4l2 intel_pmc_bxt btrtl videobuf=
2_common btbcm snd_pcm iTCO_vendor_support mfd_core btintel nls_iso8859_1 v=
ideodev nls_cp437 snd_timer cfg80211 irqbypass mc snd bluetooth mei_me i2c_=
i801 pcspkr rfkill i2c_smbus soundcore mei thermal battery joydev button ac=
pi_pad ac sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse dm_=
mod configfs dmi_sysfs hid_multitouch hid_generic usbhid i915 i2c_algo_bit =
ghash_clmulni_intel drm_buddy drm_client_lib drm_display_helper xhci_pci dr=
m_kms_helper xhci_hcd ahci ttm libahci video drm wmi libata
[   99.877440]  usbcore usb_common serio_raw sd_mod scsi_dh_emc scsi_dh_rda=
c scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio_mmio virt=
io virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 aesni_inte=
l gf128mul
[   99.878391] CPU: 3 UID: 0 PID: 4396 Comm: pr/netcon0 Kdump: loaded Taint=
ed: G          I         6.17.0.gb19a97d5-master #220 PREEMPT(lazy)=20
[   99.878492] Tainted: [I]=3DFIRMWARE_WORKAROUND
[   99.878529] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   99.878588] RIP: 0010:__local_bh_enable_ip+0x8f/0xe0
[   99.878639] Code: 3e bf 01 00 00 00 e8 f0 68 03 00 e8 3b 75 14 00 fb 65 =
8b 05 ab 6f 9b 01 85 c0 74 41 5b 5d c3 65 8b 05 a1 a8 9b 01 85 c0 75 a4 <0f=
> 0b eb a0 e8 68 74 14 00 eb a1 48 89 ef e8 de c0 07 00 eb aa 48
[   99.878774] RSP: 0018:ffff8881051abac8 EFLAGS: 00010046
[   99.878823] RAX: 0000000000000000 RBX: 0000000000000201 RCX: ffff8881051=
aba84
[   99.878881] RDX: 0000000000000001 RSI: 0000000000000201 RDI: ffffffffa13=
7b870
[   99.878937] RBP: ffffffffa137b870 R08: 0000000000000008 R09: ffffffff832=
b3620
[   99.878993] R10: 0000000000000001 R11: 000000000000240f R12: ffff8881037=
c2168
[   99.879049] R13: ffff888102bc0f00 R14: ffff8881037c2000 R15: ffff888102b=
c0f20
[   99.879105] FS:  0000000000000000(0000) GS:ffff888261310000(0000) knlGS:=
0000000000000000
[   99.879217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.879307] CR2: 00007f6f8ca7c4c0 CR3: 0000000004e4e003 CR4: 00000000003=
726f0
[   99.879418] Call Trace:
[   99.879466]  <TASK>
[   99.879522]  ieee80211_queue_skb+0x140/0x350 [mac80211]
[   99.879752]  __ieee80211_xmit_fast+0x217/0x3a0 [mac80211]
[   99.879962]  ? __skb_get_hash_net+0x47/0x1c0
[   99.880009]  ? __skb_get_hash_net+0x47/0x1c0
[   99.880075]  ieee80211_xmit_fast+0xee/0x1e0 [mac80211]
[   99.880265]  __ieee80211_subif_start_xmit+0x141/0x390 [mac80211]
[   99.880464]  ieee80211_subif_start_xmit+0x39/0x200 [mac80211]
[   99.880629]  ? lock_acquire.part.0+0x94/0x1e0
[   99.880681]  ? lock_acquire.part.0+0xa4/0x1e0
[   99.880736]  ? netif_skb_features+0xb6/0x2b0
[   99.880784]  netpoll_start_xmit+0x125/0x1a0
[   99.880839]  __netpoll_send_skb+0x329/0x3b0
[   99.880897]  netcon_write_thread+0xb3/0xe0 [netconsole]
[   99.881015]  nbcon_emit_next_record+0x239/0x290
[   99.881123]  ? nbcon_kthread_func+0x24/0x210
[   99.881190]  nbcon_emit_one+0x83/0xd0
[   99.881265]  nbcon_kthread_func+0x150/0x210
[   99.881371]  ? nbcon_device_release+0x110/0x110
[   99.881458]  kthread+0x139/0x220
[   99.881525]  ? _raw_spin_unlock_irq+0x28/0x50
[   99.881601]  ? kthreads_online_cpu+0xf0/0xf0
[   99.881695]  ret_from_fork+0x213/0x270
[   99.881765]  ? kthreads_online_cpu+0xf0/0xf0
[   99.881852]  ret_from_fork_asm+0x11/0x20
[   99.881994]  </TASK>
[   99.882038] irq event stamp: 63
[   99.882094] hardirqs last  enabled at (61): [<ffffffff8130a198>] finish_=
task_switch.isra.0+0xb8/0x290
[   99.882220] hardirqs last disabled at (62): [<ffffffff81cfccf3>] _raw_sp=
in_lock_irqsave+0x53/0x60
[   99.882343] softirqs last  enabled at (0): [<ffffffff812c4d0b>] copy_pro=
cess+0x81b/0x1930
[   99.882455] softirqs last disabled at (63): [<ffffffffa137b82d>] ieee802=
11_queue_skb+0xfd/0x350 [mac80211]
[   99.882789] ---[ end trace 0000000000000000 ]---
[   99.882929]=20
[   99.882948] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   99.882972] WARNING: inconsistent lock state
[   99.882996] 6.17.0.gb19a97d5-master #220 Tainted: G        W I       =
=20
[   99.883028] --------------------------------
[   99.883051] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[   99.883081] pr/netcon0/4396 [HC0[0]:SC0[0]:HE0:SE1] takes:
[   99.883117] ffff8881225d3118 (_xmit_ETHER#2){+.?.}-{3:3}, at: __netpoll_=
send_skb+0x2e0/0x3b0
[   99.883207] {IN-SOFTIRQ-W} state was registered at:
[   99.883233]   __lock_acquire+0x3d6/0xbc0
[   99.883266]   lock_acquire.part.0+0x94/0x1e0
[   99.883297]   _raw_spin_lock+0x33/0x40
[   99.883326]   __dev_queue_xmit+0x7d2/0xbf0
[   99.883358]   ip_finish_output2+0x1f7/0x7f0
[   99.883390]   ip_output+0xa6/0x3a0
[   99.883419]   igmp_ifc_timer_expire+0x21/0xf0
[   99.883449]   call_timer_fn+0x98/0x230
[   99.883480]   __run_timers+0x1dc/0x2a0
[   99.883511]   run_timer_base+0x46/0x60
[   99.883542]   run_timer_softirq+0x1a/0x30
[   99.883574]   handle_softirqs+0xdb/0x3f0
[   99.883608]   __irq_exit_rcu+0xc1/0x130
[   99.883641]   irq_exit_rcu+0xe/0x30
[   99.883666]   sysvec_apic_timer_interrupt+0xa1/0xd0
[   99.883701]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   99.883732]   cpuidle_enter_state+0x10d/0x530
[   99.883767]   cpuidle_enter+0x2d/0x40
[   99.883799]   cpuidle_idle_call+0xfd/0x1a0
[   99.883831]   do_idle+0x83/0xc0
[   99.883858]   cpu_startup_entry+0x29/0x30
[   99.883889]   start_secondary+0xf3/0x110
[   99.883917]   common_startup_64+0x13e/0x148
[   99.883950] irq event stamp: 64
[   99.883971] hardirqs last  enabled at (61): [<ffffffff8130a198>] finish_=
task_switch.isra.0+0xb8/0x290
[   99.884013] hardirqs last disabled at (62): [<ffffffff81cfccf3>] _raw_sp=
in_lock_irqsave+0x53/0x60
[   99.884056] softirqs last  enabled at (64): [<ffffffffa137b870>] ieee802=
11_queue_skb+0x140/0x350 [mac80211]
[   99.884310] softirqs last disabled at (63): [<ffffffffa137b82d>] ieee802=
11_queue_skb+0xfd/0x350 [mac80211]
[   99.884540]=20
[   99.884540] other info that might help us debug this:
[   99.884576]  Possible unsafe locking scenario:
[   99.884576]=20
[   99.884611]        CPU0
[   99.884629]        ----
[   99.884647]   lock(_xmit_ETHER#2);
[   99.884679]   <Interrupt>
[   99.884698]     lock(_xmit_ETHER#2);
[   99.884728]=20
[   99.884728]  *** DEADLOCK ***
[   99.884728]=20
[   99.884768] 5 locks held by pr/netcon0/4396:
[   99.884795]  #0: ffffffff8255a030 (console_srcu){....}-{0:0}, at: consol=
e_srcu_read_lock+0x49/0x60
[   99.884859]  #1: ffffffffa16e3ab8 (target_list_lock){+.+.}-{3:3}, at: ne=
tconsole_device_lock+0x19/0x20 [netconsole]
[   99.884925]  #2: ffffffff8255cb80 (rcu_read_lock){....}-{1:3}, at: __net=
poll_send_skb+0x4a/0x3b0
[   99.884987]  #3: ffff8881225d3118 (_xmit_ETHER#2){+.?.}-{3:3}, at: __net=
poll_send_skb+0x2e0/0x3b0
[   99.885052]  #4: ffffffff8255cb80 (rcu_read_lock){....}-{1:3}, at: __iee=
e80211_subif_start_xmit+0xa5/0x390 [mac80211]
[   99.885319]=20
[   99.885319] stack backtrace:
[   99.885354] CPU: 3 UID: 0 PID: 4396 Comm: pr/netcon0 Kdump: loaded Taint=
ed: G        W I         6.17.0.gb19a97d5-master #220 PREEMPT(lazy)=20
[   99.885372] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   99.885375] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   99.885380] Call Trace:
[   99.885385]  <TASK>
[   99.885394]  dump_stack_lvl+0x5b/0x80
[   99.885413]  print_usage_bug.part.0+0x22c/0x2c0
[   99.885431]  mark_lock_irq+0x399/0x580
[   99.885446]  ? stack_trace_save+0x3e/0x50
[   99.885458]  ? save_trace+0xbe/0x170
[   99.885476]  mark_lock+0x1b7/0x3c0
[   99.885491]  mark_held_locks+0x40/0x70
[   99.885504]  ? ieee80211_queue_skb+0x140/0x350 [mac80211]
[   99.885708]  lockdep_hardirqs_on_prepare.part.0+0xaf/0x160
[   99.885730]  trace_hardirqs_on+0x44/0xc0
[   99.885743]  __local_bh_enable_ip+0x75/0xe0
[   99.885768]  ieee80211_queue_skb+0x140/0x350 [mac80211]
[   99.886068]  __ieee80211_xmit_fast+0x217/0x3a0 [mac80211]
[   99.886278]  ? __skb_get_hash_net+0x47/0x1c0
[   99.886292]  ? __skb_get_hash_net+0x47/0x1c0
[   99.886312]  ieee80211_xmit_fast+0xee/0x1e0 [mac80211]
[   99.886512]  __ieee80211_subif_start_xmit+0x141/0x390 [mac80211]
[   99.886713]  ieee80211_subif_start_xmit+0x39/0x200 [mac80211]
[   99.886899]  ? lock_acquire.part.0+0x94/0x1e0
[   99.886915]  ? lock_acquire.part.0+0xa4/0x1e0
[   99.886931]  ? netif_skb_features+0xb6/0x2b0
[   99.886945]  netpoll_start_xmit+0x125/0x1a0
[   99.886964]  __netpoll_send_skb+0x329/0x3b0
[   99.886984]  netcon_write_thread+0xb3/0xe0 [netconsole]
[   99.887005]  nbcon_emit_next_record+0x239/0x290
[   99.887029]  ? nbcon_kthread_func+0x24/0x210
[   99.887040]  nbcon_emit_one+0x83/0xd0
[   99.887055]  nbcon_kthread_func+0x150/0x210
[   99.887077]  ? nbcon_device_release+0x110/0x110
[   99.887090]  kthread+0x139/0x220
[   99.887105]  ? _raw_spin_unlock_irq+0x28/0x50
[   99.887119]  ? kthreads_online_cpu+0xf0/0xf0
[   99.887145]  ret_from_fork+0x213/0x270
[   99.887162]  ? kthreads_online_cpu+0xf0/0xf0
[   99.887181]  ret_from_fork_asm+0x11/0x20
[   99.887214]  </TASK>
[   99.888658] ------------[ cut here ]------------
[   99.888709] WARNING: CPU: 3 PID: 4396 at net/mac80211/tx.c:3814 ieee8021=
1_tx_dequeue+0x6f6/0x7b0 [mac80211]
[   99.889145] Modules linked in: netconsole ccm af_packet bridge stp llc i=
scsi_ibft iscsi_boot_sysfs cmac algif_hash algif_skcipher af_alg iwlmvm int=
el_rapl_msr intel_rapl_common mac80211 snd_hda_codec_hdmi binfmt_misc x86_p=
kg_temp_thermal intel_powerclamp snd_hda_codec_conexant snd_hda_codec_gener=
ic coretemp libarc4 kvm_intel uvcvideo snd_hda_intel snd_intel_dspcfg uvc s=
nd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep mei_hdcp iwlwifi =
kvm iTCO_wdt btusb snd_hda_core videobuf2_v4l2 intel_pmc_bxt btrtl videobuf=
2_common btbcm snd_pcm iTCO_vendor_support mfd_core btintel nls_iso8859_1 v=
ideodev nls_cp437 snd_timer cfg80211 irqbypass mc snd bluetooth mei_me i2c_=
i801 pcspkr rfkill i2c_smbus soundcore mei thermal battery joydev button ac=
pi_pad ac sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse dm_=
mod configfs dmi_sysfs hid_multitouch hid_generic usbhid i915 i2c_algo_bit =
ghash_clmulni_intel drm_buddy drm_client_lib drm_display_helper xhci_pci dr=
m_kms_helper xhci_hcd ahci ttm libahci video drm wmi libata
[   99.889869]  usbcore usb_common serio_raw sd_mod scsi_dh_emc scsi_dh_rda=
c scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio_mmio virt=
io virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 aesni_inte=
l gf128mul
[   99.890607] CPU: 3 UID: 0 PID: 4396 Comm: pr/netcon0 Kdump: loaded Taint=
ed: G        W I         6.17.0.gb19a97d5-master #220 PREEMPT(lazy)=20
[   99.890707] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   99.890750] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   99.890807] RIP: 0010:ieee80211_tx_dequeue+0x6f6/0x7b0 [mac80211]
[   99.891278] Code: 84 16 fc ff ff 48 8b 44 24 20 48 8b bc 24 a0 00 00 00 =
31 d2 48 8d 70 0a e8 47 61 ff ff 84 c0 0f 85 9d fa ff ff e9 f1 fb ff ff <0f=
> 0b e9 48 f9 ff ff e8 4e b4 fe df 85 c0 0f 85 b2 fb ff ff e8 91
[   99.891392] RSP: 0018:ffff8881051ab9b0 EFLAGS: 00010246
[   99.891453] RAX: 0000000000000002 RBX: ffff88810ee7a8a0 RCX: 00000000000=
00002
[   99.891513] RDX: ffffffffa1808a49 RSI: ffff8881037c2168 RDI: ffff888102b=
c0e40
[   99.891574] RBP: ffff8881037c2168 R08: 0000000000000000 R09: 00000000000=
00000
[   99.891633] R10: ffffffffa1808a49 R11: 0000000000000002 R12: 00000000000=
00002
[   99.891688] R13: ffff8881037c2000 R14: ffff888102bc0e40 R15: ffff888102b=
c3088
[   99.891747] FS:  0000000000000000(0000) GS:ffff888261310000(0000) knlGS:=
0000000000000000
[   99.891815] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.891867] CR2: 00007f6f8ca7c4c0 CR3: 0000000004e4e003 CR4: 00000000003=
726f0
[   99.891926] Call Trace:
[   99.891963]  <TASK>
[   99.892006]  ? rcu_is_watching+0x11/0x40
[   99.892072]  ? rcu_is_watching+0x11/0x40
[   99.892129]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   99.892194]  ? rcu_is_watching+0x11/0x40
[   99.892248]  ? lock_acquire+0xee/0x130
[   99.892300]  ? iwl_mvm_mac_itxq_xmit+0x59/0x1f0 [iwlmvm]
[   99.892545]  iwl_mvm_mac_itxq_xmit+0xb3/0x1f0 [iwlmvm]
[   99.892747]  ieee80211_queue_skb+0x21b/0x350 [mac80211]
[   99.893200]  __ieee80211_xmit_fast+0x217/0x3a0 [mac80211]
[   99.893657]  ? __skb_get_hash_net+0x47/0x1c0
[   99.893719]  ? __skb_get_hash_net+0x47/0x1c0
[   99.893792]  ieee80211_xmit_fast+0xee/0x1e0 [mac80211]
[   99.894230]  __ieee80211_subif_start_xmit+0x141/0x390 [mac80211]
[   99.894650]  ieee80211_subif_start_xmit+0x39/0x200 [mac80211]
[   99.895057]  ? lock_acquire.part.0+0x94/0x1e0
[   99.895157]  ? lock_acquire.part.0+0xa4/0x1e0
[   99.895224]  ? netif_skb_features+0xb6/0x2b0
[   99.895284]  netpoll_start_xmit+0x125/0x1a0
[   99.895349]  __netpoll_send_skb+0x329/0x3b0
[   99.895416]  netcon_write_thread+0xb3/0xe0 [netconsole]
[   99.895490]  nbcon_emit_next_record+0x239/0x290
[   99.895564]  ? nbcon_kthread_func+0x24/0x210
[   99.895617]  nbcon_emit_one+0x83/0xd0
[   99.895674]  nbcon_kthread_func+0x150/0x210
[   99.895742]  ? nbcon_device_release+0x110/0x110
[   99.895798]  kthread+0x139/0x220
[   99.895849]  ? _raw_spin_unlock_irq+0x28/0x50
[   99.895903]  ? kthreads_online_cpu+0xf0/0xf0
[   99.895965]  ret_from_fork+0x213/0x270
[   99.896019]  ? kthreads_online_cpu+0xf0/0xf0
[   99.896081]  ret_from_fork_asm+0x11/0x20
[   99.896179]  </TASK>
[   99.896212] irq event stamp: 64
[   99.896248] hardirqs last  enabled at (61): [<ffffffff8130a198>] finish_=
task_switch.isra.0+0xb8/0x290
[   99.896326] hardirqs last disabled at (62): [<ffffffff81cfccf3>] _raw_sp=
in_lock_irqsave+0x53/0x60
[   99.896403] softirqs last  enabled at (64): [<ffffffffa137b870>] ieee802=
11_queue_skb+0x140/0x350 [mac80211]
[   99.896859] softirqs last disabled at (63): [<ffffffffa137b82d>] ieee802=
11_queue_skb+0xfd/0x350 [mac80211]
[   99.897285] ---[ end trace 0000000000000000 ]---
[   99.897458] ------------[ cut here ]------------
[   99.897508] netpoll_send_skb_on_dev(): wlan0 enabled interrupts in poll =
(ieee80211_subif_start_xmit+0x0/0x200 [mac80211])
[   99.898032] WARNING: CPU: 3 PID: 4396 at net/core/netpoll.c:359 __netpol=
l_send_skb+0x382/0x3b0
[   99.898133] Modules linked in: netconsole ccm af_packet bridge stp llc i=
scsi_ibft iscsi_boot_sysfs cmac algif_hash algif_skcipher af_alg iwlmvm int=
el_rapl_msr intel_rapl_common mac80211 snd_hda_codec_hdmi binfmt_misc x86_p=
kg_temp_thermal intel_powerclamp snd_hda_codec_conexant snd_hda_codec_gener=
ic coretemp libarc4 kvm_intel uvcvideo snd_hda_intel snd_intel_dspcfg uvc s=
nd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep mei_hdcp iwlwifi =
kvm iTCO_wdt btusb snd_hda_core videobuf2_v4l2 intel_pmc_bxt btrtl videobuf=
2_common btbcm snd_pcm iTCO_vendor_support mfd_core btintel nls_iso8859_1 v=
ideodev nls_cp437 snd_timer cfg80211 irqbypass mc snd bluetooth mei_me i2c_=
i801 pcspkr rfkill i2c_smbus soundcore mei thermal battery joydev button ac=
pi_pad ac sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse dm_=
mod configfs dmi_sysfs hid_multitouch hid_generic usbhid i915 i2c_algo_bit =
ghash_clmulni_intel drm_buddy drm_client_lib drm_display_helper xhci_pci dr=
m_kms_helper xhci_hcd ahci ttm libahci video drm wmi libata
[   99.898853]  usbcore usb_common serio_raw sd_mod scsi_dh_emc scsi_dh_rda=
c scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio_mmio virt=
io virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 aesni_inte=
l gf128mul
[   99.899647] CPU: 3 UID: 0 PID: 4396 Comm: pr/netcon0 Kdump: loaded Taint=
ed: G        W I         6.17.0.gb19a97d5-master #220 PREEMPT(lazy)=20
[   99.899762] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   99.899809] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   99.899868] RIP: 0010:__netpoll_send_skb+0x382/0x3b0
[   99.899933] Code: 0f 85 65 ff ff ff 49 8b 44 24 08 49 8d b4 24 20 01 00 =
00 48 c7 c7 40 43 14 82 c6 05 ef 24 b8 00 01 48 8b 50 20 e8 de c3 7f ff <0f=
> 0b e9 3a ff ff ff 9c 58 f6 c4 02 0f 84 a5 fd ff ff 80 3d cd 24
[   99.900049] RSP: 0018:ffff8881051abd68 EFLAGS: 00010292
[   99.900105] RAX: 000000000000006d RBX: ffff888115403200 RCX: 00000000000=
00000
[   99.900163] RDX: 0000000000000003 RSI: ffffffff82169464 RDI: 00000000fff=
fffff
[   99.900222] RBP: ffff88811586d148 R08: 00000000ffffdfff R09: ffffffff825=
29e08
[   99.900278] R10: ffffffff82479e60 R11: 5f6c6c6f7074656e R12: ffff88810ee=
78000
[   99.900335] R13: ffff88813b78da00 R14: ffff8881225d3000 R15: 00000000000=
00000
[   99.900392] FS:  0000000000000000(0000) GS:ffff888261310000(0000) knlGS:=
0000000000000000
[   99.900456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.900507] CR2: 00007f6f8ca7c4c0 CR3: 0000000004e4e003 CR4: 00000000003=
726f0
[   99.900567] Call Trace:
[   99.900604]  <TASK>
[   99.900655]  netcon_write_thread+0xb3/0xe0 [netconsole]
[   99.900736]  nbcon_emit_next_record+0x239/0x290
[   99.900814]  ? nbcon_kthread_func+0x24/0x210
[   99.900869]  nbcon_emit_one+0x83/0xd0
[   99.900927]  nbcon_kthread_func+0x150/0x210
[   99.900999]  ? nbcon_device_release+0x110/0x110
[   99.901058]  kthread+0x139/0x220
[   99.901110]  ? _raw_spin_unlock_irq+0x28/0x50
[   99.901166]  ? kthreads_online_cpu+0xf0/0xf0
[   99.901229]  ret_from_fork+0x213/0x270
[   99.901282]  ? kthreads_online_cpu+0xf0/0xf0
[   99.901343]  ret_from_fork_asm+0x11/0x20
[   99.901436]  </TASK>
[   99.901472] irq event stamp: 64
[   99.901508] hardirqs last  enabled at (61): [<ffffffff8130a198>] finish_=
task_switch.isra.0+0xb8/0x290
[   99.901588] hardirqs last disabled at (62): [<ffffffff81cfccf3>] _raw_sp=
in_lock_irqsave+0x53/0x60
[   99.901664] softirqs last  enabled at (64): [<ffffffffa137b870>] ieee802=
11_queue_skb+0x140/0x350 [mac80211]
[   99.902125] softirqs last disabled at (63): [<ffffffffa137b82d>] ieee802=
11_queue_skb+0xfd/0x350 [mac80211]
[   99.902552] ---[ end trace 0000000000000000 ]---
[   99.903332] ------------[ cut here ]------------
[   99.903382] WARNING: CPU: 3 PID: 4396 at net/core/netpoll.c:505 netpoll_=
send_udp+0x3b3/0x3c0
[   99.903469] Modules linked in: netconsole ccm af_packet bridge stp llc i=
scsi_ibft iscsi_boot_sysfs cmac algif_hash algif_skcipher af_alg iwlmvm int=
el_rapl_msr intel_rapl_common mac80211 snd_hda_codec_hdmi binfmt_misc x86_p=
kg_temp_thermal intel_powerclamp snd_hda_codec_conexant snd_hda_codec_gener=
ic coretemp libarc4 kvm_intel uvcvideo snd_hda_intel snd_intel_dspcfg uvc s=
nd_hda_codec videobuf2_vmalloc videobuf2_memops snd_hwdep mei_hdcp iwlwifi =
kvm iTCO_wdt btusb snd_hda_core videobuf2_v4l2 intel_pmc_bxt btrtl videobuf=
2_common btbcm snd_pcm iTCO_vendor_support mfd_core btintel nls_iso8859_1 v=
ideodev nls_cp437 snd_timer cfg80211 irqbypass mc snd bluetooth mei_me i2c_=
i801 pcspkr rfkill i2c_smbus soundcore mei thermal battery joydev button ac=
pi_pad ac sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse dm_=
mod configfs dmi_sysfs hid_multitouch hid_generic usbhid i915 i2c_algo_bit =
ghash_clmulni_intel drm_buddy drm_client_lib drm_display_helper xhci_pci dr=
m_kms_helper xhci_hcd ahci ttm libahci video drm wmi libata
[   99.904176]  usbcore usb_common serio_raw sd_mod scsi_dh_emc scsi_dh_rda=
c scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio_mmio virt=
io virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 aesni_inte=
l gf128mul
[   99.904880] CPU: 3 UID: 0 PID: 4396 Comm: pr/netcon0 Kdump: loaded Taint=
ed: G        W I         6.17.0.gb19a97d5-master #220 PREEMPT(lazy)=20
[   99.904980] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   99.905024] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   99.905081] RIP: 0010:netpoll_send_udp+0x3b3/0x3c0
[   99.905143] Code: 0c 13 71 10 48 8d 49 04 ff ca 75 f5 83 d6 00 89 f2 c1 =
ee 10 66 01 d6 83 d6 00 f7 d6 66 89 70 0a b8 08 00 00 00 e9 a4 fe ff ff <0f=
> 0b e9 75 fc ff ff 66 0f 1f 44 00 00 f3 0f 1e fa 0f 1f 44 00 00
[   99.905261] RSP: 0018:ffff8881051abd58 EFLAGS: 00010202
[   99.905320] RAX: 0000000000000292 RBX: ffff88811586d148 RCX: 00000000000=
00000
[   99.905380] RDX: 0000000000000023 RSI: ffff88820897d3e8 RDI: ffff8881158=
6d148
[   99.905440] RBP: ffff8881051abd98 R08: ffffffffa168e9b0 R09: ffff888105c=
c8ea0
[   99.905500] R10: ffffffffa137ef4d R11: 0000000000000000 R12: 00000000000=
00023
[   99.905560] R13: 0000000000000023 R14: ffff88811586d148 R15: ffff8882089=
7d3e8
[   99.905622] FS:  0000000000000000(0000) GS:ffff888261310000(0000) knlGS:=
0000000000000000
[   99.905689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.905743] CR2: 00007f6f8ca7c4c0 CR3: 0000000004e4e003 CR4: 00000000003=
726f0
[   99.905807] Call Trace:
[   99.905844]  <TASK>
[   99.905882]  ? __netpoll_send_skb+0xc9/0x3b0
[   99.905965]  netcon_write_thread+0xb3/0xe0 [netconsole]
[   99.906012]  nbcon_emit_next_record+0x239/0x290
[   99.906057]  ? nbcon_kthread_func+0x24/0x210
[   99.906089]  nbcon_emit_one+0x83/0xd0
[   99.906123]  nbcon_kthread_func+0x150/0x210
[   99.906165]  ? nbcon_device_release+0x110/0x110
[   99.906198]  kthread+0x139/0x220
[   99.906228]  ? _raw_spin_unlock_irq+0x28/0x50
[   99.906259]  ? kthreads_online_cpu+0xf0/0xf0
[   99.906291]  ret_from_fork+0x213/0x270
[   99.906320]  ? kthreads_online_cpu+0xf0/0xf0
[   99.906355]  ret_from_fork_asm+0x11/0x20
[   99.906405]  </TASK>


