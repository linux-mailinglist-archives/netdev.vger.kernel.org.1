Return-Path: <netdev+bounces-227433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720DBAF2AC
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D4B2A14B3
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 06:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF51A76BC;
	Wed,  1 Oct 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="cPEVyTWH"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BE1BF58;
	Wed,  1 Oct 2025 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759298485; cv=none; b=pxWBDM5TZYRZGqf/7rOZ2zElpNmFTdek2XR9OOwekTcxEATAuCzCwZ1Pljvz81uC64tx13OcvuleC1cosVBqSx264M+Z2SCmr7vA/BmoL+hn2VoTOeFVh0CSUD83kZJGCDQgpSqg1+k7zjVbVwEFueOcgcvkG9JzL7t/TfcfUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759298485; c=relaxed/simple;
	bh=CnKOzvg/V3VcWjKK6emGcI4FnqsOEW7w5NIOpHOEvKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CgaYwaIX/pnriDJGUeiEQcNsa9Ub/TvTYeuAZ1UAGEVz53WRN8ojJ6e6m4Wkb06aEVyGMSqVrsrvPmoIx9nZAZHpCymUo7+VrMBzgsbH9CwPe66UY3ng3u3/Cny1w72AUqf/ywFcliRubCV3J7SVA9IkryD6KkFKm0FzhSslBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=cPEVyTWH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759298451; x=1759903251; i=efault@gmx.de;
	bh=0AvgxlzuhYXOARv35FFriB8gUEnddddlmuei1VCMT4s=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cPEVyTWHQUgWQ+IMjQTadIFmorHYnbw+iRh/uztAFRLZC/Xzs8Tp8yLZTTmA4qrU
	 Yw2kCI3isiyRr3RfhX+QTU86hY9yp5ubtYkvWsLyS6bJpG1BIOJeTsUC2NiDyJzcJ
	 zRKnpM38lIVfukRU1dausPFa8POX+6jvbl+B/Dbkg6r/FxCLYX3XExcDsfHfygNfv
	 goaxI75THbzjq3vcIlwiBCXGJ4QUTm/zgBBnzVE3FUw0QOr2YM1Ti0lfAn3V8Yi8i
	 uA5OnKhp6tFt0EwxS4pFgqbEKQbxJIRaJ3neS/yJpXS3UdmMcM+p0J5I9SZP7okBn
	 xUF1e625v8m7R3mOZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1u6o5R1GAs-00tqS6; Wed, 01
 Oct 2025 08:00:51 +0200
Message-ID: <087e8f711ab1814b7e035744256f3948d63aaf7f.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Siewior <bigeasy@linutronix.de>, John Ogness
	 <john.ogness@linutronix.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>, Petr
 Mladek <pmladek@suse.com>, Simon Horman <horms@kernel.org>,
 kuba@kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>,  paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 boqun.feng@gmail.com, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 01 Oct 2025 08:00:49 +0200
In-Reply-To: <d92202c8ec3d31eb54b41e669e3bf687acbf86e1.camel@gmx.de>
References: 
	<tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
	 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
	 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
	 <84a539f4kf.fsf@jogness.linutronix.de>
	 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
	 <847by65wfj.fsf@jogness.linutronix.de> <aMGVa5kGLQBvTRB9@pathway.suse.cz>
	 <oc46gdpmmlly5o44obvmoatfqo5bhpgv7pabpvb6sjuqioymcg@gjsma3ghoz35>
	 <aNvh2Cd2i9MVA1d3@mozart.vkv.me> <84frc4j9yx.fsf@jogness.linutronix.de>
	 <20250930143059.OA_NFC9S@linutronix.de>
	 <d92202c8ec3d31eb54b41e669e3bf687acbf86e1.camel@gmx.de>
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
X-Provags-ID: V03:K1:OCgx4hW/vrp8cobnSs8BSYLD7cMS3I1HVhXralLlhbCcmgiO+jx
 Eezab5xsHTIJk14D83O2EwlJcSOAbI0HZDHuzMd7MTrV8BoXDSHPE+s2ngn/d2uORzg2oQp
 kK5umqYA3qtz40KT8JcrM5zFQC73BAp9VluDVp4tkdZOXlKkGh6LsI2iksAPQnzJhjoUkno
 pcASazzm1a1vEFrdfW3NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1BbAi3nyytE=;WgfNwylv4+ky+TFteS+tENHhN7i
 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
 f9LHA==

On Tue, 2025-09-30 at 19:35 +0200, Mike Galbraith wrote:
>=20
> I've been using a test coverage and monitoring patchlet for years that
> let's RT relax local exclusion to better suit its needs, substituting
> BH for IRQ exclusion....

BTW, that approach isn't perfect, but along with Breno's WIP nbcon
goodies it works pretty well.  His netconsole tests are happy, RT can
do mundane netpoll business just fine (zzz).

The interesting bit is that RT can now also do some not so mundane:

netconsole.sh bart
modprobe crashtest
echo crash_nmi_kill > /sys/kernel/debug/crashtest (1 2 3 NMI punch)
./runltp (busy work for box)

bart's log: Look for "NMI watchdog"+PING!|WARN!|BOOM!
                                    1     2     3
<record start/restart tag>
[  161.779133] netconsole: network logging started
[  219.873700] Process accounting resumed
[  220.020136] Process accounting resumed
[  229.208910] UDPLite: UDP-Lite is deprecated and scheduled to be removed =
in 2025, please contact the netdev mailing list
[  229.209355] UDPLite6: UDP-Lite is deprecated and scheduled to be removed=
 in 2025, please contact the netdev mailing list
[  230.377870] watchdog: NMI watchdog PING!
[  232.216928] NMI watchdog WARN!
[  232.216932] WARNING: CPU: 1 PID: 4890 at kernel/watchdog.c:204 watchdog_=
hardlockup_crashtest+0x5b/0x60
[  232.216940] BUG: sleeping function called from invalid context at kernel=
/locking/spinlock_rt.c:48
[  232.216941] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 4890,=
 name: bind06
[  232.216941] preempt_count: 110002, expected: 0
[  232.216942] RCU nest depth: 1, expected: 1
[  232.216943] Preemption disabled at:
[  232.216943] [<ffffffff81c0ddd3>] schedule+0x23/0x90
[  232.216948] CPU: 1 UID: 0 PID: 4890 Comm: bind06 Kdump: loaded Not taint=
ed 6.17.0.ge5f0a698-master-nbcon-rt #154 PREEMPT_{RT,(lazy)}=20
[  232.216950] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  232.216951] Call Trace:
[  232.216952]  <TASK>
[  232.216954]  dump_stack_lvl+0x5b/0x80
[  232.216957]  ? schedule+0x23/0x90
[  232.216959]  __might_resched.cold+0xcb/0x104
[  232.216963]  rt_spin_lock+0x36/0xc0
[  232.216965]  ___slab_alloc+0x7d/0x730
[  232.216967]  ? __alloc_skb+0x135/0x170
[  232.216970]  ? info_print_prefix+0xa7/0xd0
[  232.216972]  ? record_print_text+0x1cc/0x2b0
[  232.216974]  ? __alloc_skb+0x135/0x170
[  232.216975]  kmem_cache_alloc_node_noprof+0x7a/0x1c0
[  232.216977]  __alloc_skb+0x135/0x170
[  232.216979]  netpoll_prepare_skb+0x84/0x390 [netconsole]
[  232.216983]  netcon_write_thread+0xbb/0xf0 [netconsole]
[  232.216986]  nbcon_emit_next_record+0x24a/0x270
[  232.216989]  __nbcon_atomic_flush_pending_con+0x9a/0xf0
[  232.216991]  __nbcon_atomic_flush_pending+0xba/0x130
[  232.216994]  vprintk_emit+0x253/0x4d0
[  232.216996]  _printk+0x4c/0x50
[  232.216999]  ? vprintk_store+0x3f6/0x4a0
[  232.217000]  ? watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217002]  ? watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217003]  __warn.cold+0x89/0xf0
[  232.217005]  ? watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217007]  report_bug+0xe6/0x170
[  232.217010]  ? watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217012]  ? watchdog_hardlockup_crashtest+0x5d/0x60
[  232.217013]  handle_bug+0xe6/0x140
[  232.217016]  exc_invalid_op+0x17/0x60
[  232.217017]  asm_exc_invalid_op+0x1a/0x20
[  232.217019] RIP: 0010:watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217021] Code: c0 0f 84 2d d3 e5 ff 8b 15 02 94 8f 01 85 d2 0f 84 2b =
d3 e5 ff 83 f8 01 0f 8f 22 d3 e5 ff 48 c7 c7 06 2a 16 82 e8 85 04 f1 ff <0f=
> 0b c3 c3 90 66 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41 55 41 89
[  232.217022] RSP: 0000:ffff88810667bc18 EFLAGS: 00010096
[  232.217024] RAX: 0000000000000012 RBX: ffff88810667bf58 RCX: 00000000000=
00000
[  232.217025] RDX: 0000000080110002 RSI: 0000000000000001 RDI: 00000000000=
00001
[  232.217026] RBP: ffff88810667bf58 R08: 00000000ffffbfff R09: ffff88840eb=
fffa8
[  232.217026] R10: ffff88840eaa0000 R11: 0000000000000002 R12: 00000000000=
00000
[  232.217027] R13: 0000000000000001 R14: ffffffffffffffff R15: ffff888100b=
00000
[  232.217029]  ? watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217030]  watchdog_hardlockup_check+0x1e/0xe0
[  232.217032]  __perf_event_overflow+0x111/0x3b0
[  232.217035]  ? perf_event_update_userpage+0x17/0x140
[  232.217037]  ? packet_notifier+0x74/0x220 [af_packet]
[  232.217039]  ? ndisc_netdev_event+0xda/0x2b0
[  232.217042]  ? effective_cpu_util+0x2f/0xc0
[  232.217045]  handle_pmi_common+0x1b5/0x3d0
[  232.217047]  ? sugov_update_single_freq+0xfe/0x230
[  232.217050]  ? sugov_get_util+0x2c/0x70
[  232.217051]  ? sugov_update_single_freq+0xfe/0x230
[  232.217053]  ? update_load_avg+0x3c5/0x3d0
[  232.217054]  ? update_curr+0x90/0x1b0
[  232.217056]  ? nohz_balance_exit_idle+0x1a/0xa0
[  232.217058]  ? nohz_balancer_kick+0x28b/0x320
[  232.217060]  ? perf_event_task_tick+0x73/0xc0
[  232.217062]  intel_pmu_handle_irq+0x116/0x2a0
[  232.217063]  perf_event_nmi_handler+0x2a/0x50
[  232.217066]  nmi_handle.part.0+0x53/0x110
[  232.217069]  default_do_nmi+0x15f/0x170
[  232.217070]  exc_nmi+0xef/0x110
[  232.216926] ------------[ cut here ]------------
[  232.217071]  asm_exc_nmi+0x74/0xbd
[  232.217073] RIP: 0033:0x406ca5
[  232.217075] Code: 00 84 d2 0f 85 b2 00 00 00 8b 15 b2 36 03 00 8b 05 b0 =
36 03 00 39 c2 7d 24 8b 05 aa 36 03 00 85 c0 75 1a 83 05 73 36 03 00 01 <8b=
> 15 91 36 03 00 8b 05 8f 36 03 00 39 c2 7c df 0f 1f 00 8b 0d 7a
[  232.217075] RSP: 002b:00007fff3e364580 EFLAGS: 00000202
[  232.217076] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
0fb62
[  232.217077] RDX: 0000000000000092 RSI: 000000000043a2c8 RDI: 00000000000=
00004
[  232.217078] RBP: 0000000000000000 R08: 00007f47ecdbd128 R09: 00000000000=
00000
[  232.217078] R10: 00007f47ecdbd0e8 R11: 000000000000fb62 R12: 00000000000=
00000
[  232.217079] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000004=
38db8
[  232.217080]  </TASK>
[  232.217140] Modules linked in: crashtest netconsole af_packet nft_fib_in=
et nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reje=
ct_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 nf_tables bridge stp llc iscsi_ibft iscsi_boot_sysfs rfkill =
nfnetlink binfmt_misc nls_iso8859_1 nls_cp437 snd_hda_codec_generic snd_hda=
_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec intel_rapl_msr snd=
_hwdep intel_rapl_common snd_hda_core x86_pkg_temp_thermal intel_powerclamp=
 coretemp r8169 snd_pcm realtek mdio_devres kvm_intel at24 snd_timer libphy=
 regmap_i2c iTCO_wdt snd intel_pmc_bxt mei_hdcp iTCO_vendor_support i2c_i80=
1 mei_me lpc_ich usblp kvm joydev irqbypass pcspkr i2c_smbus mdio_bus mei s=
oundcore mfd_core fan thermal uas usb_storage intel_smartconnect nfsd auth_=
rpcgss nfs_acl lockd sch_fq_codel grace sunrpc dm_mod fuse configfs dmi_sys=
fs hid_generic nouveau usbhid drm_ttm_helper ttm drm_client_lib gpu_sched i=
2c_algo_bit drm_gpuvm drm_exec drm_display_helper
[  232.217181]  drm_kms_helper xhci_pci xhci_hcd drm ghash_clmulni_intel eh=
ci_pci ahci ehci_hcd libahci libata usbcore video wmi usb_common button sd_=
mod scsi_dh_emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat =
ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 aesni_intel gf128mul
[  232.217198] CPU: 1 UID: 0 PID: 4890 Comm: bind06 Kdump: loaded Tainted: =
G        W           6.17.0.ge5f0a698-master-nbcon-rt #154 PREEMPT_{RT,(laz=
y)}=20
[  232.217201] Tainted: [W]=3DWARN
[  232.217202] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  232.217203] RIP: 0010:watchdog_hardlockup_crashtest+0x5b/0x60
[  232.217206] Code: c0 0f 84 2d d3 e5 ff 8b 15 02 94 8f 01 85 d2 0f 84 2b =
d3 e5 ff 83 f8 01 0f 8f 22 d3 e5 ff 48 c7 c7 06 2a 16 82 e8 85 04 f1 ff <0f=
> 0b c3 c3 90 66 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41 55 41 89
[  232.217208] RSP: 0000:ffff88810667bc18 EFLAGS: 00010096
[  232.217210] RAX: 0000000000000012 RBX: ffff88810667bf58 RCX: 00000000000=
00000
[  232.217211] RDX: 0000000080110002 RSI: 0000000000000001 RDI: 00000000000=
00001
[  232.217213] RBP: ffff88810667bf58 R08: 00000000ffffbfff R09: ffff88840eb=
fffa8
[  232.217214] R10: ffff88840eaa0000 R11: 0000000000000002 R12: 00000000000=
00000
[  232.217215] R13: 0000000000000001 R14: ffffffffffffffff R15: ffff888100b=
00000
[  232.217217] FS:  00007f47ecd7e740(0000) GS:ffff88848c02c000(0000) knlGS:=
0000000000000000
[  232.217219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  232.217220] CR2: 00007f61356005a0 CR3: 000000012281e005 CR4: 00000000001=
726f0
[  232.217222] Call Trace:
[  232.217223]  <TASK>
[  232.217224]  watchdog_hardlockup_check+0x1e/0xe0
[  232.217227]  __perf_event_overflow+0x111/0x3b0
[  232.217230]  ? perf_event_update_userpage+0x17/0x140
[  232.217232]  ? packet_notifier+0x74/0x220 [af_packet]
[  232.217234]  ? ndisc_netdev_event+0xda/0x2b0
[  232.217237]  ? effective_cpu_util+0x2f/0xc0
[  232.217240]  handle_pmi_common+0x1b5/0x3d0
[  232.217242]  ? sugov_update_single_freq+0xfe/0x230
[  232.217244]  ? sugov_get_util+0x2c/0x70
[  232.217246]  ? sugov_update_single_freq+0xfe/0x230
[  232.217248]  ? update_load_avg+0x3c5/0x3d0
[  232.217251]  ? update_curr+0x90/0x1b0
[  232.217253]  ? nohz_balance_exit_idle+0x1a/0xa0
[  232.217256]  ? nohz_balancer_kick+0x28b/0x320
[  232.217259]  ? perf_event_task_tick+0x73/0xc0
[  232.217262]  intel_pmu_handle_irq+0x116/0x2a0
[  232.217264]  perf_event_nmi_handler+0x2a/0x50
[  232.217267]  nmi_handle.part.0+0x53/0x110
[  232.217269]  default_do_nmi+0x15f/0x170
[  232.217271]  exc_nmi+0xef/0x110
[  232.217273]  asm_exc_nmi+0x74/0xbd
[  232.217274] RIP: 0033:0x406ca5
[  232.217276] Code: 00 84 d2 0f 85 b2 00 00 00 8b 15 b2 36 03 00 8b 05 b0 =
36 03 00 39 c2 7d 24 8b 05 aa 36 03 00 85 c0 75 1a 83 05 73 36 03 00 01 <8b=
> 15 91 36 03 00 8b 05 8f 36 03 00 39 c2 7c df 0f 1f 00 8b 0d 7a
[  232.217277] RSP: 002b:00007fff3e364580 EFLAGS: 00000202
[  232.217279] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
0fb62
[  232.217280] RDX: 0000000000000092 RSI: 000000000043a2c8 RDI: 00000000000=
00004
[  232.217282] RBP: 0000000000000000 R08: 00007f47ecdbd128 R09: 00000000000=
00000
[  232.217283] R10: 00007f47ecdbd0e8 R11: 000000000000fb62 R12: 00000000000=
00000
[  232.217284] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000004=
38db8
[  232.217286]  </TASK>
[  232.217287] ---[ end trace 0000000000000000 ]---
[  232.217293] perf: interrupt took too long (2857 > 2500), lowering kernel=
.perf_event_max_sample_rate to 70000
[  233.447090] Kernel panic - not syncing: NMI watchdog BOOM!
[  233.447096] CPU: 2 UID: 0 PID: 4891 Comm: bind06 Kdump: loaded Tainted: =
G        W           6.17.0.ge5f0a698-master-nbcon-rt #154 PREEMPT_{RT,(laz=
y)}=20
[  233.447099] Tainted: [W]=3DWARN
[  233.447101] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  233.447103] Call Trace:
[  233.447106]  <TASK>
[  233.447109]  dump_stack_lvl+0x5b/0x80
[  233.447116]  vpanic+0xca/0x290
[  233.447120]  panic+0x4c/0x4c
[  233.447124]  watchdog_hardlockup_crashtest.cold+0xc/0x18
[  233.447129]  watchdog_hardlockup_check+0x1e/0xe0
[  233.447136]  __perf_event_overflow+0x111/0x3b0
[  233.447141]  ? perf_event_update_userpage+0x17/0x140
[  233.447145]  ? effective_cpu_util+0x2f/0xc0
[  233.447151]  handle_pmi_common+0x1b5/0x3d0
[  233.447155]  ? sugov_update_single_freq+0xfe/0x230
[  233.447160]  ? sugov_get_util+0x2c/0x70
[  233.447163]  ? sugov_update_single_freq+0xfe/0x230
[  233.447167]  ? update_load_avg+0x3c5/0x3d0
[  233.447172]  ? update_curr+0x90/0x1b0
[  233.447176]  ? nohz_balance_exit_idle+0x1a/0xa0
[  233.447179]  ? nohz_balancer_kick+0x28b/0x320
[  233.447183]  ? perf_event_task_tick+0x73/0xc0
[  233.447186]  intel_pmu_handle_irq+0x116/0x2a0
[  233.447190]  perf_event_nmi_handler+0x2a/0x50
[  233.447194]  nmi_handle.part.0+0x53/0x110
[  233.447199]  default_do_nmi+0x15f/0x170
[  233.447202]  exc_nmi+0xef/0x110
[  233.447204]  asm_exc_nmi+0x74/0xbd
[  233.447208] RIP: 0033:0x406018
[  233.447212] Code: c0 0f 85 6b fe ff ff 83 05 1c 43 03 00 01 8b 15 3e 43 =
03 00 8b 05 34 43 03 00 39 c2 7c db e9 4f fe ff ff 0f 1f 80 00 00 00 00 <8b=
> 05 26 43 03 00 85 c0 0f 85 89 fe ff ff 8b 15 14 43 03 00 8b 05
[  233.447214] RSP: 002b:00007f47ec9feec0 EFLAGS: 00000297
[  233.447218] RAX: 00000000000000cd RBX: 0000000000000000 RCX: 00000000000=
0fdca
[  233.447221] RDX: 00000000000000cc RSI: 000000000043a2d8 RDI: 00000000000=
00004
[  233.447222] RBP: 0000000000000000 R08: 00007f47ecdbd128 R09: 00000000000=
00000
[  233.447224] R10: 00007f47ecdbd0e8 R11: 000000000000fdca R12: fffffffffff=
fff88
[  233.447226] R13: 0000000000000000 R14: 00007fff3e364350 R15: 00007f47ec1=
ff000
[  233.447230]  </TASK>



