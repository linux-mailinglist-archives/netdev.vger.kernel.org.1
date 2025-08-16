Return-Path: <netdev+bounces-214292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA0B28C52
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47D8587FF1
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A9238C15;
	Sat, 16 Aug 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="aOWUC0rv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06561849C;
	Sat, 16 Aug 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335972; cv=none; b=XOzsAmeXlSwk2e4r2WByJ+GhGL8/xsSqeQAfhDRADwPyGI/HGdw/cyhSjqOjIy7bf/yH0OCwxH1+APA1GqegGUIBaYSidnKumAtYuR2AMcLf7oi0RGGrG4nialCPR43asQyEX20dPKTlfdfqpw2npcw7vqRm1BXs/EAYR2tafcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335972; c=relaxed/simple;
	bh=fNc3+rZ3eDN9LdCoi8t4um56X3BTAzqNIZTtW0oiSuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJcY+DvfBMGYiGEIq1PVxlXLkjO3X1jJ7vrlLi3mbSJ+AE4/O1gk0kQOPkoULzXONCuDe9vgj1STJgJDHmGWmXVx1zPfSw7AV+2PiNCDIgBWa2y9Nw16A+5dEPT5cJO2PrHyx0cFbJ9NBCVpC1yC/mpgVCPwCcXzkmiyc2y3quM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=aOWUC0rv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755335954; x=1755940754; i=efault@gmx.de;
	bh=/ntjvpxnc7K71/qqnKgNv8qO3nTBjMGFZbVCeygtYUw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aOWUC0rvwx3epiqaL3BffOYryM54NzL/+2/GVlu9RbLh5ma3zz6qsAjnxFwqTf++
	 24lFzyLcMErJrKHt0qw/Ct70ErD5SIWSPYd5fqJaQ6+dHN+qWTkNgXiU7OL4hErnP
	 NnqGoD9kL5JUmk3b8O6ive0cGuQhQNkyh8EkoytGFPfBrHhqN+AKN5/++vNvco0G1
	 95VnpkmXJ8VUHY3unuYtS3nUvZMZVrxNapqRSPqTRPXBP7Jqj1N5uDqRr1oQBk/35
	 y/7qERKz3B4ycnuV8mBZe8cMeqoIDezO1HGQuwMI2oQHUXs1fs0k/5gq5HPviivYN
	 1pjlFeOAJbePv5TN7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1uKDN13dTC-00prnh; Sat, 16
 Aug 2025 11:19:13 +0200
Message-ID: <1ce95a952ddf73bf1e6532376eab3a5efbbfa814.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov
 <asml.silence@gmail.com>,  Johannes Berg <johannes@sipsolutions.net>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Sat, 16 Aug 2025 11:19:13 +0200
In-Reply-To: <aJ-GMfXarWgEoYTH@mozart.vkv.me>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	 <20250814172326.18cf2d72@kernel.org>
	 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
	 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <aJ-GMfXarWgEoYTH@mozart.vkv.me>
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
X-Provags-ID: V03:K1:sIn3cNJ6WXGVqDbz5TazozzPdoc8GAbOhDxpZ1HlT/iHIs5Xxm1
 e8/PvFzwolPHDT71t1Dq818SjNu6hcsZDZG0tpnKiSiUlEMTNk2TtrPv+PfCBMC+nZEHOFp
 D9RNN6qCRhUz7zJWypzNOoia+JBj4KO5AMPUNnFOQzeVQlHycgJ8ofdExz/fvnDv2KEkQXo
 o6Nz5q5MwhZIZppn3n9WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lgUCAXqcxcM=;ynpoqm3kT2ygnHn/tW1HnhB2+PU
 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

On Fri, 2025-08-15 at 12:10 -0700, Calvin Owens wrote:
>=20
> If your condition instead becomes:
>=20
> =C2=A0=C2=A0=C2=A0 if (in_irq() && !oops_in_progress)
>=20
> ...I think we can have our cake and eat it too? In an OOPS we're
> busting locks and such, all bets are off anyway. Although, I suppose
> that might still drop messages emitted immediately before it...

I tried that to skip the __netpoll_send_skb() xmit loop, but lockdep
didn't look any happier, so I rummaged for a wireless signpost to
redirect all wireless traffic instead.

With only the __netpoll_send_skb() fork-in-road, lappy moaned as below,
all of which use of local_bh_disable() in queue_process() silenced.

sharp stick:
---
 net/core/netpoll.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -90,7 +90,6 @@ static void queue_process(struct work_st
 	struct netpoll_info *npinfo =3D
 		container_of(work, struct netpoll_info, tx_work.work);
 	struct sk_buff *skb;
-	unsigned long flags;
=20
 	while ((skb =3D skb_dequeue(&npinfo->txq))) {
 		struct net_device *dev =3D skb->dev;
@@ -102,7 +101,7 @@ static void queue_process(struct work_st
 			continue;
 		}
=20
-		local_irq_save(flags);
+		local_bh_disable();
 		/* check if skb->queue_mapping is still valid */
 		q_index =3D skb_get_queue_mapping(skb);
 		if (unlikely(q_index >=3D dev->real_num_tx_queues)) {
@@ -115,13 +114,13 @@ static void queue_process(struct work_st
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			skb_queue_head(&npinfo->txq, skb);
 			HARD_TX_UNLOCK(dev, txq);
-			local_irq_restore(flags);
+			local_bh_enable();
=20
 			schedule_delayed_work(&npinfo->tx_work, HZ/10);
 			return;
 		}
 		HARD_TX_UNLOCK(dev, txq);
-		local_irq_restore(flags);
+		local_bh_enable();
 	}
 }
=20
@@ -339,6 +338,8 @@ static netdev_tx_t __netpoll_send_skb(st
 		/* try until next clock tick */
 		for (tries =3D jiffies_to_usecs(1)/USEC_PER_POLL;
 		     tries > 0; --tries) {
+			if (dev->ieee80211_ptr && !oops_in_progress)
+				break;
 			if (HARD_TX_TRYLOCK(dev, txq)) {
 				if (!netif_xmit_stopped(txq))
 					status =3D netpoll_start_xmit(skb, dev, txq);

wireless lappy gripes:
[   61.191326][ T3992] netconsole: network logging started
[   61.193561][  T504] ------------[ cut here ]------------
[   61.193798][  T504] WARNING: CPU: 1 PID: 504 at kernel/softirq.c:387 __l=
ocal_bh_enable_ip+0x8f/0xe0
[   61.193852][  T504] Modules linked in: netconsole ccm nf_nat_tftp nf_con=
ntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet =
nf_reject_ipv4 nf_reject_ipv6 nft_reject af_packet nft_ct nft_chain_nat nf_=
nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set nfnetlink c=
mac algif_hash algif_skcipher af_alg iwlmvm mac80211 snd_hda_codec_hdmi bin=
fmt_misc snd_hda_codec_conexant snd_hda_codec_generic snd_hda_intel intel_r=
apl_msr intel_rapl_common snd_intel_dspcfg x86_pkg_temp_thermal intel_power=
clamp libarc4 snd_hda_codec btusb snd_hwdep coretemp iTCO_wdt intel_pmc_bxt=
 snd_hda_core iTCO_vendor_support mei_hdcp mei_pxp mfd_core btrtl nls_iso88=
59_1 kvm_intel btbcm btintel nls_cp437 kvm snd_pcm iwlwifi snd_timer irqbyp=
ass uvcvideo bluetooth cfg80211 uvc videobuf2_vmalloc videobuf2_memops vide=
obuf2_v4l2 videobuf2_common videodev mc i2c_i801 snd pcspkr mei_me i2c_smbu=
s soundcore rfkill mei thermal battery tiny_power_button acpi_pad button ac=
 joydev sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse
[   61.194109][  T504]  dm_mod configfs dmi_sysfs hid_multitouch hid_generi=
c usbhid i915 i2c_algo_bit drm_buddy drm_client_lib drm_display_helper poly=
val_clmulni ghash_clmulni_intel drm_kms_helper cec rc_core ttm video xhci_p=
ci xhci_hcd drm ahci libahci usbcore wmi libata serio_raw sd_mod scsi_dh_em=
c scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk vir=
tio_mmio virtio virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autof=
s4 aesni_intel
[   61.194852][  T504] CPU: 1 UID: 0 PID: 504 Comm: kworker/1:3 Kdump: load=
ed Tainted: G          I         6.17.0.gdfd4b508-master #199 PREEMPT(lazy)=
  d58b2f71f2d7e509bfea5f74e10faccc1d76d31c
[   61.194932][  T504] Tainted: [I]=3DFIRMWARE_WORKAROUND
[   61.194961][  T504] Hardware name: HP HP Spectre x360 Convertible/804F, =
BIOS F.47 11/22/2017
[   61.195003][  T504] Workqueue: events queue_process
[   61.195038][  T504] RIP: 0010:__local_bh_enable_ip+0x8f/0xe0
[   61.195119][  T504] Code: 3e bf 01 00 00 00 e8 90 ba 03 00 e8 1b 71 19 0=
0 fb 65 8b 05 e3 81 ee 01 85 c0 74 41 5b 5d c3 65 8b 05 91 bf ee 01 85 c0 7=
5 a4 <0f> 0b eb a0 e8 48 70 19 00 eb a1 48 89 ef e8 ae 1c 09 00 eb aa 48
[   61.195204][  T504] RSP: 0018:ffffcf9b80fb7b20 EFLAGS: 00010046
[   61.195241][  T504] RAX: 0000000000000000 RBX: 0000000000000201 RCX: fff=
fcf9b80fb7ad4
[   61.195282][  T504] RDX: 0000000000000001 RSI: 0000000000000201 RDI: fff=
fffffc1a4ae30
[   61.195323][  T504] RBP: ffffffffc1a4ae30 R08: 0000000000000001 R09: 000=
0000000000002
[   61.195364][  T504] R10: ffffcf9b80fb7988 R11: 0000000000000004 R12: fff=
f8b2c8440e168
[   61.195403][  T504] R13: ffff8b2c8fe78f20 R14: ffff8b2c8440e000 R15: fff=
f8b2c8fe78f40
[   61.195442][  T504] FS:  0000000000000000(0000) GS:ffff8b2e394b0000(0000=
) knlGS:0000000000000000
[   61.195487][  T504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.195523][  T504] CR2: 000055ac249a6b20 CR3: 000000015aed7002 CR4: 000=
00000003726f0
[   61.195563][  T504] Call Trace:
[   61.195585][  T504]  <TASK>
[   61.195610][  T504]  ieee80211_queue_skb+0x140/0x350 [mac80211 b718f73b2=
47535542b221eff8a4a9e1817e251c7]
[   61.195821][  T504]  __ieee80211_xmit_fast+0x202/0x360 [mac80211 b718f73=
b247535542b221eff8a4a9e1817e251c7]
[   61.196014][  T504]  ? __skb_get_hash_net+0x54/0x1f0
[   61.196051][  T504]  ? __skb_get_hash_net+0x54/0x1f0
[   61.196098][  T504]  ieee80211_xmit_fast+0xfb/0x1f0 [mac80211 b718f73b24=
7535542b221eff8a4a9e1817e251c7]
[   61.196283][  T504]  __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211 =
b718f73b247535542b221eff8a4a9e1817e251c7]
[   61.196469][  T504]  ieee80211_subif_start_xmit+0x46/0x230 [mac80211 b71=
8f73b247535542b221eff8a4a9e1817e251c7]
[   61.196698][  T504]  ? lock_acquire.part.0+0xb1/0x210
[   61.196740][  T504]  ? netif_skb_features+0xb6/0x2b0
[   61.196778][  T504]  netpoll_start_xmit+0x8b/0xd0
[   61.196813][  T504]  queue_process+0xb5/0x200
[   61.196850][  T504]  process_one_work+0x21f/0x5b0
[   61.196890][  T504]  ? lock_is_held_type+0xca/0x120
[   61.196937][  T504]  worker_thread+0x1ce/0x3c0
[   61.196975][  T504]  ? bh_worker+0x250/0x250
[   61.197007][  T504]  kthread+0x146/0x230
[   61.197040][  T504]  ? kthreads_online_cpu+0x110/0x110
[   61.197078][  T504]  ret_from_fork+0x1a6/0x1f0
[   61.197112][  T504]  ? kthreads_online_cpu+0x110/0x110
[   61.197150][  T504]  ret_from_fork_asm+0x11/0x20
[   61.197209][  T504]  </TASK>
[   61.197292][  T504] irq event stamp: 164585
[   61.197322][  T504] hardirqs last  enabled at (164583): [<ffffffffac5798=
7c>] _raw_spin_unlock_irqrestore+0x4c/0x60
[   61.197377][  T504] hardirqs last disabled at (164584): [<ffffffffac31a9=
3e>] queue_process+0x11e/0x200
[   61.197428][  T504] softirqs last  enabled at (164454): [<ffffffffab9025=
1e>] handle_softirqs+0x31e/0x3f0
[   61.197479][  T504] softirqs last disabled at (164585): [<ffffffffc1a4ad=
ed>] ieee80211_queue_skb+0xfd/0x350 [mac80211]
[   61.197664][  T504] ---[ end trace 0000000000000000 ]---
[   61.197707][  T504]=20
[   61.197717][  T504] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   61.197728][  T504] WARNING: inconsistent lock state
[   61.197740][  T504] 6.17.0.gdfd4b508-master #199 Tainted: G        W I  =
     =20
[   61.197754][  T504] --------------------------------
[   61.197765][  T504] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[   61.197778][  T504] kworker/1:3/504 [HC0[0]:SC0[0]:HE0:SE1] takes:
[   61.197793][  T504] ffff8b2c84899d18 (_xmit_ETHER#2){+.?.}-{3:3}, at: qu=
eue_process+0x138/0x200
[   61.197820][  T504] {IN-SOFTIRQ-W} state was registered at:
[   61.197832][  T504]   __lock_acquire+0x3d6/0xbc0
[   61.197849][  T504]   lock_acquire.part.0+0xa1/0x210
[   61.197863][  T504]   _raw_spin_lock+0x33/0x40
[   61.197875][  T504]   __dev_queue_xmit+0x7fb/0xc20
[   61.197891][  T504]   ip_finish_output2+0x1f7/0x800
[   61.197905][  T504]   ip_output+0xb3/0x3c0
[   61.197918][  T504]   igmp_ifc_timer_expire+0x21/0xf0
[   61.197931][  T504]   call_timer_fn+0xa5/0x250
[   61.197944][  T504]   __run_timers+0x1f2/0x2c0
[   61.197957][  T504]   run_timer_base+0x46/0x60
[   61.197969][  T504]   run_timer_softirq+0x1a/0x30
[   61.197981][  T504]   handle_softirqs+0xdb/0x3f0
[   61.197994][  T504]   __irq_exit_rcu+0xc1/0x130
[   61.198006][  T504]   irq_exit_rcu+0xe/0x30
[   61.198018][  T504]   sysvec_apic_timer_interrupt+0x55/0xd0
[   61.198032][  T504]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   61.198046][  T504] irq event stamp: 164586
[   61.198058][  T504] hardirqs last  enabled at (164583): [<ffffffffac5798=
7c>] _raw_spin_unlock_irqrestore+0x4c/0x60
[   61.198077][  T504] hardirqs last disabled at (164584): [<ffffffffac31a9=
3e>] queue_process+0x11e/0x200
[   61.198094][  T504] softirqs last  enabled at (164586): [<ffffffffc1a4ae=
30>] ieee80211_queue_skb+0x140/0x350 [mac80211]
[   61.198239][  T504] softirqs last disabled at (164585): [<ffffffffc1a4ad=
ed>] ieee80211_queue_skb+0xfd/0x350 [mac80211]
[   61.198375][  T504]=20
[   61.198375][  T504] other info that might help us debug this:
[   61.198391][  T504]  Possible unsafe locking scenario:
[   61.198391][  T504]=20
[   61.198406][  T504]        CPU0
[   61.198416][  T504]        ----
[   61.198425][  T504]   lock(_xmit_ETHER#2);
[   61.198440][  T504]   <Interrupt>
[   61.198449][  T504]     lock(_xmit_ETHER#2);
[   61.198463][  T504]=20
[   61.198463][  T504]  *** DEADLOCK ***
[   61.198463][  T504]=20
[   61.198482][  T504] 4 locks held by kworker/1:3/504:
[   61.198494][  T504]  #0: ffff8b2c8004d148 ((wq_completion)events){+.+.}-=
{0:0}, at: process_one_work+0x52a/0x5b0
[   61.198521][  T504]  #1: ffffcf9b80fb7e28 ((work_completion)(&(&npinfo->=
tx_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1f0/0x5b0
[   61.198546][  T504]  #2: ffff8b2c84899d18 (_xmit_ETHER#2){+.?.}-{3:3}, a=
t: queue_process+0x138/0x200
[   61.198573][  T504]  #3: ffffffffacf71400 (rcu_read_lock){....}-{1:3}, a=
t: __ieee80211_subif_start_xmit+0xb2/0x3d0 [mac80211]
[   61.198718][  T504]=20
[   61.198718][  T504] stack backtrace:
[   61.198735][  T504] CPU: 1 UID: 0 PID: 504 Comm: kworker/1:3 Kdump: load=
ed Tainted: G        W I         6.17.0.gdfd4b508-master #199 PREEMPT(lazy)=
  d58b2f71f2d7e509bfea5f74e10faccc1d76d31c
[   61.198742][  T504] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   61.198743][  T504] Hardware name: HP HP Spectre x360 Convertible/804F, =
BIOS F.47 11/22/2017
[   61.198745][  T504] Workqueue: events queue_process
[   61.198750][  T504] Call Trace:
[   61.198751][  T504]  <TASK>
[   61.198755][  T504]  dump_stack_lvl+0x5b/0x80
[   61.198762][  T504]  print_usage_bug.part.0+0x22c/0x2c0
[   61.198769][  T504]  mark_lock_irq+0x3a9/0x590
[   61.198775][  T504]  ? save_trace+0x65/0x1e0
[   61.198783][  T504]  mark_lock+0x1b7/0x3c0
[   61.198788][  T504]  mark_held_locks+0x40/0x70
[   61.198793][  T504]  ? ieee80211_queue_skb+0x140/0x350 [mac80211 b718f73=
b247535542b221eff8a4a9e1817e251c7]
[   61.198914][  T504]  lockdep_hardirqs_on_prepare.part.0+0xaf/0x160
[   61.198919][  T504]  trace_hardirqs_on+0x44/0xc0
[   61.198923][  T504]  __local_bh_enable_ip+0x75/0xe0
[   61.198927][  T504]  ieee80211_queue_skb+0x140/0x350 [mac80211 b718f73b2=
47535542b221eff8a4a9e1817e251c7]
[   61.199047][  T504]  __ieee80211_xmit_fast+0x202/0x360 [mac80211 b718f73=
b247535542b221eff8a4a9e1817e251c7]
[   61.199184][  T504]  ? __skb_get_hash_net+0x54/0x1f0
[   61.199190][  T504]  ? __skb_get_hash_net+0x54/0x1f0
[   61.199199][  T504]  ieee80211_xmit_fast+0xfb/0x1f0 [mac80211 b718f73b24=
7535542b221eff8a4a9e1817e251c7]
[   61.199310][  T504]  __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211 =
b718f73b247535542b221eff8a4a9e1817e251c7]
[   61.199422][  T504]  ieee80211_subif_start_xmit+0x46/0x230 [mac80211 b71=
8f73b247535542b221eff8a4a9e1817e251c7]
[   61.199527][  T504]  ? lock_acquire.part.0+0xb1/0x210
[   61.199534][  T504]  ? netif_skb_features+0xb6/0x2b0
[   61.199541][  T504]  netpoll_start_xmit+0x8b/0xd0
[   61.199547][  T504]  queue_process+0xb5/0x200
[   61.199552][  T504]  process_one_work+0x21f/0x5b0
[   61.199557][  T504]  ? lock_is_held_type+0xca/0x120
[   61.199565][  T504]  worker_thread+0x1ce/0x3c0
[   61.199570][  T504]  ? bh_worker+0x250/0x250
[   61.199574][  T504]  kthread+0x146/0x230
[   61.199578][  T504]  ? kthreads_online_cpu+0x110/0x110
[   61.199582][  T504]  ret_from_fork+0x1a6/0x1f0
[   61.199588][  T504]  ? kthreads_online_cpu+0x110/0x110
[   61.199592][  T504]  ret_from_fork_asm+0x11/0x20
[   61.199602][  T504]  </TASK>
[   61.200069][  T504] ------------[ cut here ]------------
[   61.200093][  T504] WARNING: CPU: 1 PID: 504 at net/mac80211/tx.c:3814 i=
eee80211_tx_dequeue+0x71c/0x7e0 [mac80211]
[   61.200309][  T504] Modules linked in: netconsole ccm nf_nat_tftp nf_con=
ntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet =
nf_reject_ipv4 nf_reject_ipv6 nft_reject af_packet nft_ct nft_chain_nat nf_=
nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set nfnetlink c=
mac algif_hash algif_skcipher af_alg iwlmvm mac80211 snd_hda_codec_hdmi bin=
fmt_misc snd_hda_codec_conexant snd_hda_codec_generic snd_hda_intel intel_r=
apl_msr intel_rapl_common snd_intel_dspcfg x86_pkg_temp_thermal intel_power=
clamp libarc4 snd_hda_codec btusb snd_hwdep coretemp iTCO_wdt intel_pmc_bxt=
 snd_hda_core iTCO_vendor_support mei_hdcp mei_pxp mfd_core btrtl nls_iso88=
59_1 kvm_intel btbcm btintel nls_cp437 kvm snd_pcm iwlwifi snd_timer irqbyp=
ass uvcvideo bluetooth cfg80211 uvc videobuf2_vmalloc videobuf2_memops vide=
obuf2_v4l2 videobuf2_common videodev mc i2c_i801 snd pcspkr mei_me i2c_smbu=
s soundcore rfkill mei thermal battery tiny_power_button acpi_pad button ac=
 joydev sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc fuse
[   61.200565][  T504]  dm_mod configfs dmi_sysfs hid_multitouch hid_generi=
c usbhid i915 i2c_algo_bit drm_buddy drm_client_lib drm_display_helper poly=
val_clmulni ghash_clmulni_intel drm_kms_helper cec rc_core ttm video xhci_p=
ci xhci_hcd drm ahci libahci usbcore wmi libata serio_raw sd_mod scsi_dh_em=
c scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk vir=
tio_mmio virtio virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autof=
s4 aesni_intel
[   61.200923][  T504] CPU: 1 UID: 0 PID: 504 Comm: kworker/1:3 Kdump: load=
ed Tainted: G        W I         6.17.0.gdfd4b508-master #199 PREEMPT(lazy)=
  d58b2f71f2d7e509bfea5f74e10faccc1d76d31c
[   61.200969][  T504] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[   61.200992][  T504] Hardware name: HP HP Spectre x360 Convertible/804F, =
BIOS F.47 11/22/2017
[   61.201018][  T504] Workqueue: events queue_process
[   61.201050][  T504] RIP: 0010:ieee80211_tx_dequeue+0x71c/0x7e0 [mac80211=
]
[   61.201269][  T504] Code: 84 00 fc ff ff 48 8b 44 24 20 48 8b bc 24 a0 0=
0 00 00 31 d2 48 8d 70 0a e8 51 6d ff ff 84 c0 0f 85 87 fa ff ff e9 db fb f=
f ff <0f> 0b e9 32 f9 ff ff e8 98 35 f7 e9 85 c0 0f 85 9c fb ff ff e8 eb
[   61.201316][  T504] RSP: 0018:ffffcf9b80fb7a00 EFLAGS: 00010246
[   61.201343][  T504] RAX: 0000000000000002 RBX: ffff8b2c861a68e0 RCX: 000=
0000000000002
[   61.201369][  T504] RDX: ffffffffc1798ee9 RSI: ffff8b2c8440e168 RDI: fff=
f8b2c8fe78e60
[   61.201395][  T504] RBP: ffff8b2c8440e168 R08: 0000000000000000 R09: 000=
0000000000000
[   61.201420][  T504] R10: ffffffffc1798ee9 R11: 0000000000000003 R12: 000=
0000000000002
[   61.201445][  T504] R13: ffff8b2c8440e000 R14: ffff8b2c8fe78e60 R15: fff=
f8b2c8fe7b0a8
[   61.201470][  T504] FS:  0000000000000000(0000) GS:ffff8b2e394b0000(0000=
) knlGS:0000000000000000
[   61.201499][  T504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.201524][  T504] CR2: 000055ac249a6b20 CR3: 000000026524f006 CR4: 000=
00000003726f0
[   61.201551][  T504] Call Trace:
[   61.201571][  T504]  <TASK>
[   61.201594][  T504]  ? rcu_is_watching+0x11/0x40
[   61.201624][  T504]  ? rcu_is_watching+0x11/0x40
[   61.201650][  T504]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   61.201683][  T504]  ? rcu_is_watching+0x11/0x40
[   61.201709][  T504]  ? lock_acquire+0xee/0x130
[   61.201734][  T504]  ? iwl_mvm_mac_itxq_xmit+0x59/0x1f0 [iwlmvm c8adf931=
d43d5fa86daab53059e4bf48817253e5]
[   61.201820][  T504]  iwl_mvm_mac_itxq_xmit+0xb3/0x1f0 [iwlmvm c8adf931d4=
3d5fa86daab53059e4bf48817253e5]
[   61.201900][  T504]  ieee80211_queue_skb+0x21b/0x350 [mac80211 b718f73b2=
47535542b221eff8a4a9e1817e251c7]
[   61.202128][  T504]  __ieee80211_xmit_fast+0x202/0x360 [mac80211 b718f73=
b247535542b221eff8a4a9e1817e251c7]
[   61.202330][  T504]  ? __skb_get_hash_net+0x54/0x1f0
[   61.202352][  T504]  ? __skb_get_hash_net+0x54/0x1f0
[   61.202375][  T504]  ieee80211_xmit_fast+0xfb/0x1f0 [mac80211 b718f73b24=
7535542b221eff8a4a9e1817e251c7]
[   61.202549][  T504]  __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211 =
b718f73b247535542b221eff8a4a9e1817e251c7]
[   61.202719][  T504]  ieee80211_subif_start_xmit+0x46/0x230 [mac80211 b71=
8f73b247535542b221eff8a4a9e1817e251c7]
[   61.202878][  T504]  ? lock_acquire.part.0+0xb1/0x210
[   61.202900][  T504]  ? netif_skb_features+0xb6/0x2b0
[   61.202920][  T504]  netpoll_start_xmit+0x8b/0xd0
[   61.202939][  T504]  queue_process+0xb5/0x200
[   61.202958][  T504]  process_one_work+0x21f/0x5b0
[   61.202983][  T504]  ? lock_is_held_type+0xca/0x120
[   61.203006][  T504]  worker_thread+0x1ce/0x3c0
[   61.203024][  T504]  ? bh_worker+0x250/0x250
[   61.203040][  T504]  kthread+0x146/0x230
[   61.203057][  T504]  ? kthreads_online_cpu+0x110/0x110
[   61.203075][  T504]  ret_from_fork+0x1a6/0x1f0
[   61.203093][  T504]  ? kthreads_online_cpu+0x110/0x110
[   61.203128][  T504]  ret_from_fork_asm+0x11/0x20
[   61.203154][  T504]  </TASK>
[   61.203166][  T504] irq event stamp: 164586
[   61.203179][  T504] hardirqs last  enabled at (164583): [<ffffffffac5798=
7c>] _raw_spin_unlock_irqrestore+0x4c/0x60
[   61.203203][  T504] hardirqs last disabled at (164584): [<ffffffffac31a9=
3e>] queue_process+0x11e/0x200
[   61.203224][  T504] softirqs last  enabled at (164586): [<ffffffffc1a4ae=
30>] ieee80211_queue_skb+0x140/0x350 [mac80211]
[   61.203393][  T504] softirqs last disabled at (164585): [<ffffffffc1a4ad=
ed>] ieee80211_queue_skb+0xfd/0x350 [mac80211]
[   61.203552][  T504] ---[ end trace 0000000000000000 ]---


