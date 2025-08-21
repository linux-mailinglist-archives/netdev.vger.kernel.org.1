Return-Path: <netdev+bounces-215573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4DB2F4D5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31651C20FC5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089B72ECEA6;
	Thu, 21 Aug 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="RC9N6DnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0967A7263A;
	Thu, 21 Aug 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770793; cv=none; b=MhJH4MCHpFxC3gwV/XuAP9Q4zm/M2IkKdaK/LZ1f+SObToz59JXz5im29g6GaakzQE+bYJQ/oMSCvq7IZU5p9ouhOchgqhnuDIZIJly67ZizAtRHENfjYpWWwTjrmmjZ08SHxm8VgyYEsLa25CszG7zVLwpWXpIyMDV6BWlg47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770793; c=relaxed/simple;
	bh=wtUavIxwQcpvhbgWLzhzIas/DSzVQvhfB2hvQYo5GtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKNVTEkLPZrsKtCND8kLOohyNjjgiUl1xOmJRS6+OGFyChwuhB4pDWVtpDqGqOreEePhuVe83afKfIczBNO/OUcxlhIDxyQIogxumDdc5NqjbzZGETB34j8Fc3CKvRwOqY38okuSSADOy59L6D96nj2XvHe+eVq5v0mwAIGQrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=RC9N6DnZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755770776; x=1756375576; i=efault@gmx.de;
	bh=EcIDBY17GwVPVPhkmDK9ZPhCBvI8ni9r+pWa9+jo5QI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RC9N6DnZvXktIXPrlE44ggzxOgnyP1mS5pmMybID9PRnTbTzROO6a29yPnVGlztB
	 0ud1IIlvAp4zvBNi64PR9VEJlerzuZmZE2AcZ7fqsNYJAbzcnxXT639ALnmQ4Ii5q
	 mnllXobp5L7xRWvsS7LU60xhGvfY5pCOtuTeK235MdzYZz26KPENzCAEjostgq8h3
	 JtP067/2HzmRvsrUC53NIrq8LAhSsONdH9i9iHvjmF+PpRS3pIkRz9gIgykMZWCxl
	 LEnbvHGMEHp9ZK66cnuA4aWem0CP/qhbfukay/wvQ5tSfiebDvAydP9saW2rDdUyW
	 +javQ/PonxBBuzU+kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.96]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1uIACn2W0P-00qioo; Thu, 21
 Aug 2025 12:06:16 +0200
Message-ID: <bf39250ebfb25160a5ce0abd9ce694f07cab8433.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Breno Leitao <leitao@debian.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Thu, 21 Aug 2025 12:06:15 +0200
In-Reply-To: <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	 <20250814172326.18cf2d72@kernel.org>
	 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
	 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
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
X-Provags-ID: V03:K1:MFT1YMUovTVp2nTOJdAp/12J94QyDNFZYG4cHyciIhZXS9agtOy
 eSM1bfSbXeDHk8iMIoXwdCl1uRZjjdgal7vEL3OmIYV1LWmLFTKSXB9IO5On7gc0iCYc7Oj
 /VQyFcoAeEFsR73oTghTtQUtPLP6FioeU7y+dLjvdMrrnN05IroibpuPdDN1Ebh4r/91LLH
 USwC5cmS8IBm5JFpKcmYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nzjgtiHUnnY=;PWA3Vc12ZX6aNGIt4QWm+T+aDAP
 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
 +EfeXVi/TJZZJiu5Of91+bo3FsI6

On Thu, 2025-08-21 at 05:37 +0200, Mike Galbraith wrote:
> On Wed, 2025-08-20 at 10:36 -0700, Breno Leitao wrote:
> > On Wed, Aug 20, 2025 at 02:31:02PM +0200, Mike Galbraith wrote:
> > > On Tue, 2025-08-19 at 10:27 -0700, Breno Leitao wrote:
> > > >=20
> > > > I=E2=80=99ve continued investigating possible solutions, and it loo=
ks like
> > > > moving netconsole over to the non=E2=80=91blocking console (nbcon) =
framework
> > > > might be the right approach. Unlike the classic console path, nbcon
> > > > doesn=E2=80=99t rely on the global console lock, which was one of t=
he main
> > > > concerns regarding the possible deadlock.
> > >=20
> > > ATM at least, classic can remotely log a crash whereas nbcon can't pe=
r
> > > test drive, so it would be nice for classic to stick around until nbc=
on
> > > learns some atomic packet blasting.
> >=20
> > Oh, does it mean that during crash nbcon invokes `write_atomic` call
> > back, and because this patch doesn't implement it, it will not send
> > those pkts? Am I reading it correct?
>=20
> No, I'm just saying that the kernel's last gasp doesn't make it out of
> the box with CONFIG_NETCONSOLE_NBCON=3Dy as your patch sits.

A quick test proved you correct as to the why.

--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
 static void netconsole_device_lock(struct console *con, unsigned long *fla=
gs)
 {
 	/* protects all the targets at the same time */
-	spin_lock_irqsave(&target_list_lock, *flags);
+	spin_lock(&target_list_lock);
 }
=20
 static void netconsole_device_unlock(struct console *con, unsigned long fl=
ags)
 {
-	spin_unlock_irqrestore(&target_list_lock, flags);
+	spin_unlock(&target_list_lock);
 }
 #endif
=20
@@ -1966,6 +1966,7 @@ static struct console netconsole_ext =3D {
 #ifdef CONFIG_NETCONSOLE_NBCON
 	.flags	=3D CON_ENABLED | CON_EXTENDED | CON_NBCON,
 	.write_thread =3D netcon_write_ext_thread,
+	.write_atomic =3D netcon_write_ext_thread,
 	.device_lock =3D netconsole_device_lock,
 	.device_unlock =3D netconsole_device_unlock,
 #else
@@ -1979,6 +1980,7 @@ static struct console netconsole =3D {
 #ifdef CONFIG_NETCONSOLE_NBCON
 	.flags	=3D CON_ENABLED | CON_NBCON,
 	.write_thread =3D netcon_write_thread,
+	.write_atomic =3D netcon_write_thread,
 	.device_lock =3D netconsole_device_lock,
 	.device_unlock =3D netconsole_device_unlock,
 #else

...presto, wired desktop box now captures wireless lappy crash.

[   48.378783] netconsole: network logging started
[   77.329021] sysrq: Trigger a crash
[   77.329392] Kernel panic - not syncing: sysrq triggered crash
[   77.329556] ------------[ cut here ]------------
[   77.329562] WARNING: CPU: 3 PID: 2452 at kernel/softirq.c:387 __local_bh=
_enable_ip+0x8f/0xe0
[   77.329593] Modules linked in: netconsole ccm 8021q garp mrp af_packet b=
ridge stp llc iscsi_ibft iscsi_boot_sysfs cmac algif_hash algif_skcipher af=
_alg iwlmvm snd_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic=
 mac80211 binfmt_misc libarc4 intel_rapl_msr uvcvideo intel_rapl_common snd=
_hda_intel uvc x86_pkg_temp_thermal snd_intel_dspcfg videobuf2_vmalloc snd_=
hda_codec intel_powerclamp videobuf2_memops videobuf2_v4l2 iwlwifi coretemp=
 btusb iTCO_wdt snd_hwdep kvm_intel btrtl snd_hda_core videobuf2_common int=
el_pmc_bxt nls_iso8859_1 btbcm iTCO_vendor_support nls_cp437 mei_hdcp mfd_c=
ore btintel videodev snd_pcm cfg80211 kvm mc bluetooth snd_timer irqbypass =
i2c_i801 snd pcspkr mei_me rfkill soundcore i2c_smbus mei thermal battery a=
cpi_pad ac button joydev nfsd sch_fq_codel auth_rpcgss nfs_acl lockd grace =
sunrpc fuse dm_mod configfs dmi_sysfs hid_multitouch hid_generic usbhid i91=
5 ghash_clmulni_intel i2c_algo_bit drm_buddy drm_client_lib video drm_displ=
ay_helper xhci_pci xhci_hcd drm_kms_helper ahci ttm libahci
[   77.329898]  usbcore libata drm wmi usb_common serio_raw sd_mod scsi_dh_=
emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk v=
irtio_mmio virtio virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs aut=
ofs4 aesni_intel gf128mul
[   77.329993] CPU: 3 UID: 0 PID: 2452 Comm: bash Kdump: loaded Tainted: G =
         I         6.17.0.g068a56e5-master #231 PREEMPT(lazy)=20
[   77.330011] Tainted: [I]=3DFIRMWARE_WORKAROUND
[   77.330016] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   77.330021] RIP: 0010:__local_bh_enable_ip+0x8f/0xe0
[   77.330041] Code: 3e bf 01 00 00 00 e8 f0 68 03 00 e8 3b 75 14 00 fb 65 =
8b 05 ab af 9b 01 85 c0 74 41 5b 5d c3 65 8b 05 a1 e8 9b 01 85 c0 75 a4 <0f=
> 0b eb a0 e8 68 74 14 00 eb a1 48 89 ef e8 de c0 07 00 eb aa 48
[   77.330050] RSP: 0018:ffff8881251bf898 EFLAGS: 00010046
[   77.330061] RAX: 0000000000000000 RBX: 0000000000000201 RCX: ffff8881251=
bf854
[   77.330069] RDX: 0000000000000001 RSI: 0000000000000201 RDI: ffffffffa13=
6b870
[   77.330075] RBP: ffffffffa136b870 R08: 0000000000000002 R09: ffffffff832=
b6820
[   77.330081] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888126d=
a2168
[   77.330088] R13: ffff8881221e8f00 R14: ffff888126da2000 R15: ffff8881221=
e8f20
[   77.330095] FS:  00007f22ad9c3740(0000) GS:ffff88826130c000(0000) knlGS:=
0000000000000000
[   77.330104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.330111] CR2: 0000563c1913f2e0 CR3: 0000000111548006 CR4: 00000000003=
726f0
[   77.330118] Call Trace:
[   77.330124]  <TASK>
[   77.330139]  ieee80211_queue_skb+0x140/0x350 [mac80211]
[   77.330428]  __ieee80211_xmit_fast+0x217/0x3a0 [mac80211]
[   77.330698]  ? __skb_get_hash_net+0x47/0x1c0
[   77.330718]  ? __skb_get_hash_net+0x47/0x1c0
[   77.330768]  ieee80211_xmit_fast+0xee/0x1e0 [mac80211]
[   77.331012]  __ieee80211_subif_start_xmit+0x141/0x390 [mac80211]
[   77.331218]  ? __lock_acquire+0x550/0xbc0
[   77.331268]  ieee80211_subif_start_xmit+0x39/0x200 [mac80211]
[   77.331478]  ? lock_acquire.part.0+0xa4/0x1e0
[   77.331512]  ? netif_skb_features+0xb6/0x2b0
[   77.331535]  netpoll_start_xmit+0x125/0x1a0
[   77.331569]  __netpoll_send_skb+0x309/0x310
[   77.331594]  ? netpoll_send_skb+0x24/0x80
[   77.331618]  netpoll_send_skb+0x42/0x80
[   77.331644]  netcon_write_thread+0xb3/0xe0 [netconsole]
[   77.331684]  nbcon_emit_next_record+0x25f/0x290
[   77.331739]  __nbcon_atomic_flush_pending_con+0x9a/0xf0
[   77.331786]  __nbcon_atomic_flush_pending+0xbc/0x130
[   77.331822]  vprintk_emit+0x258/0x540
[   77.331866]  _printk+0x4c/0x50
[   77.331908]  vpanic+0xb1/0x290
[   77.331934]  panic+0x4c/0x4c
[   77.331956]  ? rcu_read_unlock+0x17/0x60
[   77.331993]  sysrq_handle_crash+0x1a/0x20
[   77.332011]  __handle_sysrq.cold+0x8f/0xd4
[   77.332037]  write_sysrq_trigger+0x66/0x80
[   77.332059]  proc_reg_write+0x53/0x90
[   77.332074]  ? rcu_read_lock_any_held+0x6b/0xa0
[   77.332090]  vfs_write+0xcc/0x550
[   77.332115]  ? exc_page_fault+0x75/0x1e0
[   77.332130]  ? __lock_release.isra.0+0x54/0x140
[   77.332150]  ? exc_page_fault+0x75/0x1e0
[   77.332167]  ? exc_page_fault+0x75/0x1e0
[   77.332199]  ksys_write+0x5c/0xd0
[   77.332228]  do_syscall_64+0x76/0x3d0
[   77.332260]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   77.332271] RIP: 0033:0x7f22ad721000
[   77.332285] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[   77.332294] RSP: 002b:00007ffd75be2678 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[   77.332306] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f22ad7=
21000
[   77.332313] RDX: 0000000000000002 RSI: 0000563c1913f2e0 RDI: 00000000000=
00001
[   77.332319] RBP: 0000563c1913f2e0 R08: 0000000000000000 R09: 00000000000=
00000
[   77.332326] R10: 00007f22ad610ea0 R11: 0000000000000202 R12: 00000000000=
00002
[   77.332331] R13: 00007f22ad8005c0 R14: 00007f22ad7fdf60 R15: 0000563c193=
36af0
[   77.332405]  </TASK>
[   77.332410] irq event stamp: 44121
[   77.332415] hardirqs last  enabled at (44119): [<ffffffff81351872>] __up=
_console_sem+0x52/0x60
[   77.332429] hardirqs last disabled at (44120): [<ffffffff8120632a>] vpan=
ic+0x3a/0x290
[   77.332442] softirqs last  enabled at (43324): [<ffffffff812cf84e>] hand=
le_softirqs+0x31e/0x3f0
[   77.332459] softirqs last disabled at (44121): [<ffffffff81aca754>] netp=
oll_send_skb+0x24/0x80
[   77.332475] ---[ end trace 0000000000000000 ]---
[   77.336439] CPU: 3 UID: 0 PID: 2452 Comm: bash Kdump: loaded Tainted: G =
       W I         6.17.0.g068a56e5-master #231 PREEMPT(lazy)=20
[   77.336507] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   77.336552] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[   77.336597] Call Trace:
[   77.336646]  <TASK>
[   77.336705]  dump_stack_lvl+0x5b/0x80
[   77.336848]  vpanic+0xca/0x290
[   77.336968]  panic+0x4c/0x4c
[   77.337045]  ? rcu_read_unlock+0x17/0x60
[   77.337127]  sysrq_handle_crash+0x1a/0x20
[   77.337186]  __handle_sysrq.cold+0x8f/0xd4
[   77.337253]  write_sysrq_trigger+0x66/0x80
[   77.337315]  proc_reg_write+0x53/0x90
[   77.337373]  ? rcu_read_lock_any_held+0x6b/0xa0
[   77.337430]  vfs_write+0xcc/0x550
[   77.337494]  ? exc_page_fault+0x75/0x1e0
[   77.337550]  ? __lock_release.isra.0+0x54/0x140
[   77.337612]  ? exc_page_fault+0x75/0x1e0
[   77.338937]  ? exc_page_fault+0x75/0x1e0
[   77.339125]  ksys_write+0x5c/0xd0
[   77.339227]  do_syscall_64+0x76/0x3d0
[   77.339302]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   77.339355] RIP: 0033:0x7f22ad721000
[   77.339410] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[   77.339460] RSP: 002b:00007ffd75be2678 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[   77.339517] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f22ad7=
21000
[   77.339565] RDX: 0000000000000002 RSI: 0000563c1913f2e0 RDI: 00000000000=
00001
[   77.339611] RBP: 0000563c1913f2e0 R08: 0000000000000000 R09: 00000000000=
00000
[   77.339655] R10: 00007f22ad610ea0 R11: 0000000000000202 R12: 00000000000=
00002
[   77.339700] R13: 00007f22ad8005c0 R14: 00007f22ad7fdf60 R15: 0000563c193=
36af0
[   77.339807]  </TASK>

The wireless stack now hates vpanic() for disabling IRQs, but that's
way better than death rattle not being transmitted.

	-Mike


