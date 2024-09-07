Return-Path: <netdev+bounces-126187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96B96FF85
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880F2281354
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88111BC41;
	Sat,  7 Sep 2024 03:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530FA923
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725678422; cv=none; b=VRAnUCqDf4tp90yJzbEQ+HFsV0XlQtoqBvMyYcStc21uqEF0R5xagFFzyQSh1QYB5euQT46lq21fkuNfwrJpRMRUEdfhBn5/yV+0EMt2/R++5CgzgLJVQ5I7G8052ctgt2jREU2liDwbyGnZy91NETFSXJrI4EMvbss/nXKx+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725678422; c=relaxed/simple;
	bh=XgVJ2MHx2lAsxczyqeIu2NDEAG4/kjgWBrS36uhasJQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jjHTaQCIsk7d5kuImnqphfa7Pz7vkcxsf//aE43xunOzPq6QMFoWHRUNLESZC8W49BkZ69d3XhvMJjSXPkJA7I9PJmWNOF+hrSaebBXooxiSyWtC6CS0JUKwoqOwC/0x+roa1iqKQcgAWfRSQKDNftJ+e8DIIdfqmuvezuP7V24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id DB39A7D0B0;
	Sat,  7 Sep 2024 03:06:59 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 00/16] Add IP-TFS mode to
 xfrm
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <ZtcczN2JXhTIhbse@Antony2201.local>
Date: Fri, 6 Sep 2024 23:06:49 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org,
 Florian Westphal <fw@strlen.de>,
 Sabrina Dubroca <sd@queasysnail.net>,
 Simon Horman <horms@kernel.org>,
 devel@linux-ipsec.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4358AC61-1779-48A3-9CB4-0EF6887FDA54@chopps.org>
References: <20240824022054.3788149-1-chopps@chopps.org>
 <ZtAmxA_xflBWGlYO@Antony2201.local> <m2le09ikle.fsf@owl-home.int.chopps.org>
 <ZtcczN2JXhTIhbse@Antony2201.local>
To: Antony Antony <antony@phenome.org>
X-Mailer: Apple Mail (2.3776.700.51)



> On Sep 3, 2024, at 10:27, Antony Antony via Devel =
<devel@linux-ipsec.org> wrote:
>=20
> On Mon, Sep 02, 2024 at 08:10:26PM -0400, Christian Hopps wrote:
>>=20
>> Antony Antony via Devel <devel@linux-ipsec.org> writes:
>>=20
>>>>=20
>>>=20
>>> I ran few tests. The basic tests passed. I noticed packet loss with =
ping -f
>>> especilly on IPv6.
>>>=20
>>> ping6 -f  -n -q -c 50 2001:db8:1:2::23
>>=20
>> [ ... ]
>>=20
>>> Occessionally, once every, 3-4 tries, I noticed packet loss and =
kernel
>>> splat.
>>>=20

This was happening during packet aggregation with locally originated =
pings. Fixed in patchset v11 by calling skb_orphan on skbuffs prior to =
aggregating them together into a single skbuff.

Thanks,
Chris.



>>> $ping6 -f -n -q -c 100 -I  2001:db8:1:2::23
>>> PING 2001:db8:1:2::23(2001:db8:1:2::23) from 2001:db8:1:2::45 : 56 =
data bytes
>>>=20
>>> --- 2001:db8:1:2::23 ping statistics ---
>>> 100 packets transmitted, 38 received, 62% packet loss, time 17843ms
>>> rtt min/avg/max/mdev =3D 7.639/8.652/36.772/4.642 ms, pipe 2, =
ipg/ewma
>>> 180.229/11.165 ms
>>>=20
>>> Without iptfs, in tunnel mode, I  have never see the kernel splat or =
packet losss.
>>>=20
>>> Have you tried ping6 -f? and possibly with "dont-frag"?
>>=20
>> I will run some IPv6 flood tests with dont-frag, and see if I can =
replicate this.
>>=20
>>> The setup is a simple one, host-to-host tunnel,
>>> 2001:db8:1:2::23 to 2001:db8:1:2::45 wit policy /128
>>>=20
>>> root@west:/testing/pluto/ikev2-74-iptfs-02-ipv6$ip x p
>>> src 2001:db8:1:2::45/128 dst 2001:db8:1:2::23/128
>>> dir out priority 1703937 ptype main
>>> tmpl src 2001:db8:1:2::45 dst 2001:db8:1:2::23
>>> proto esp reqid 16393 mode iptfs
>>> src 2001:db8:1:2::23/128 dst 2001:db8:1:2::45/128
>>> dir fwd priority 1703937 ptype main
>>> tmpl src 2001:db8:1:2::23 dst 2001:db8:1:2::45
>>> proto esp reqid 16393 mode iptfs
>>> src 2001:db8:1:2::23/128 dst 2001:db8:1:2::45/128
>>> dir in priority 1703937 ptype main
>>> tmpl src 2001:db8:1:2::23 dst 2001:db8:1:2::45
>>> proto esp reqid 16393 mode iptfs
>>>=20
>>> src 2001:db8:1:2::45 dst 2001:db8:1:2::23
>>> proto esp spi 0x64b502a7 reqid 16393 mode iptfs
>>> flag af-unspec esn
>>> aead rfc4106(gcm(aes)) =
0x4bf7846c1418b14213487da785fb4019cfa47396c8c1968fb3a38559e7e39709fa87dfd9=
 128
>>> lastused 2024-08-29 09:30:00
>>> anti-replay esn context:  oseq-hi 0x0, oseq 0xa
>>> dir out
>>> iptfs-opts drop-time 0 reorder-window 0 init-delay 0 dont-frag
>>> src 2001:db8:1:2::23 dst 2001:db8:1:2::45
>>> proto esp spi 0xc5b34ddd reqid 16393 mode iptfs
>>> replay-window 0 flag af-unspec esn
>>> aead rfc4106(gcm(aes)) =
0x9029a5ad6da74a19086946836152a6a5d1abbdd81b7a8b997785d23b271413e522da9a11=
 128
>>> lastused 2024-08-29 09:30:00
>>> anti-replay esn context:
>>>  seq-hi 0x0, seq 0xa
>>>  replay_window 128, bitmap-length 4
>>>  00000000 00000000 00000000 000003ff
>>> dir in
>>> iptfs-opts pkt-size 3 max-queue-size 3
>>>=20
>>> Did I misconfigure "reorder-window 0" even then it should not drop =
packets?
>>=20
>> Is this a custom version? The output is suspicious. The reorder =
window is for handling the receipt of out-of-order tunnel packets, it's =
a `dir-in` attribute. The above output shows reorder-window under the =
`dir out` SA and is missing from the `dir in` SA. FWIW `drop-time` is =
also a receiving parameter, and `pkt-size` is a sending parameter, these =
both appear to be in the wrong spot.
>=20
> right. It was a older version iproute2. I figured it out after I send =
the=20
> previous e-mail.  There was no XFRMA_NAT_KEEPALIVE_INTERVAL.
>=20
>>=20
>> Here's example output from the iptfs-dev project iproute2:
>>=20
>>   src fc00:0:0:1::3 dst fc00:0:0:1::2
>>           proto esp spi 0x80000bbb reqid 11 mode iptfs
>>           replay-window 0 flag af-unspec
>>           aead rfc4106(gcm(aes)) =
0x4a506a794f574265564551694d6537681a2b1a2b 128
>>           lastused 2024-09-03 01:35:57
>>           anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
>>           if_id 0x37
>>           dir in
>>           iptfs-opts drop-time 1000000 reorder-window 3
>>   src fc00:0:0:1::2 dst fc00:0:0:1::3
>>           proto esp spi 0x80000aaa reqid 10 mode iptfs
>>           replay-window 0 flag af-unspec
>>           aead rfc4106(gcm(aes)) =
0x4a506a794f574265564551694d6537681a2b1a2b 128
>>           lastused 2024-09-03 01:35:57
>>           anti-replay context: seq 0x0, oseq 0x8, bitmap 0x00000000
>>           if_id 0x37
>>           dir out
>>           iptfs-opts init-delay 0 max-queue-size 10485760 pkt-size 0
>=20
> Here is new output using updated iproute2
> ip x s
> src 2001:db8:1:2::45 dst 2001:db8:1:2::23
> proto esp spi 0xaf6d8b34 reqid 16389 mode iptfs
> replay-window 0 flag af-unspec esn
> aead rfc4106(gcm(aes)) =
0x87383f4d6e7e3f810fabc90968f85bd77eb5cb5bf2bd2ff6838f105cc5f90d5f9ea8eb97=
 128
> lastused 2024-09-03 13:34:41
> anti-replay esn context:
>  seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0x4b
>  replay_window 0, bitmap-length 0
> dir out
> iptfs-opts dont-frag init-delay 0 max-queue-size 10485760 pkt-size 0
> src 2001:db8:1:2::23 dst 2001:db8:1:2::45
> proto esp spi 0x42a52f95 reqid 16389 mode iptfs
> replay-window 0 flag af-unspec esn
> aead rfc4106(gcm(aes)) =
0x4450069fdb5d2c1e313f8a076a823ac517ce00556129acaf9d69af732b565f9e0686f34d=
 128
> lastused 2024-09-03 13:34:41
> anti-replay esn context:
>  seq-hi 0x0, seq 0x48, oseq-hi 0x0, oseq 0x0
>  replay_window 128, bitmap-length 4
>  00000000 000000ff ffffffff ffffffff
> dir in
> iptfs-opts drop-time 1000000 reorder-window 3
>=20
> [   35.046910] 8021q: adding VLAN 0 to HW filter on device eth0
> [  144.719096] ------------[ cut here ]------------
> [  144.719686] refcount_t: underflow; use-after-free.
> [  144.720252] WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 =
refcount_warn_saturate+0xc7/0x110
> [  144.721105] Modules linked in:
> [  144.721459] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted =
6.10.0-12627-gfced06475e82 #58
> [  144.722346] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  144.723294] RIP: 0010:refcount_warn_saturate+0xc7/0x110
> [  144.723857] Code: 65 0e f1 01 01 e8 9e c3 7a ff 0f 0b eb 5e 80 3d =
54 0e f1 01 00 75 55 48 c7 c7 c0 2a 6d 82 c6 05 44 0e f1 01 01 e8 7e c3 =
7a ff <0f> 0b eb 3e 80 3d 33 0e f1 01 00 75 35 48 c7 c7 20 2c 6d 82 c6 =
05
> [  144.725725] RSP: 0018:ffffc90000007bc8 EFLAGS: 00010282
> [  144.726298] RAX: 0000000000000000 RBX: 0000000000000003 RCX: =
0000000000000000
> [  144.727050] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: =
fffff52000000f69
> [  144.727791] RBP: ffff88810773d43c R08: 0000000000000004 R09: =
0000000000000001
> [  144.728543] R10: ffff88815ae2794b R11: ffffed102b5c4f29 R12: =
ffff88810773d43c
> [  144.729286] R13: ffff88810773d560 R14: 1ffff92000000f8e R15: =
ffff8881073db800
> [  144.730044] FS:  0000000000000000(0000) GS:ffff88815ae00000(0000) =
knlGS:0000000000000000
> [  144.730877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  144.731486] CR2: 0000557060841e90 CR3: 0000000103f1e000 CR4: =
0000000000350ef0
> [  144.732245] Call Trace:
> [  144.732537]  <IRQ>
> [  144.732787]  ? __warn+0xc4/0x175
> [  144.733161]  ? refcount_warn_saturate+0xc7/0x110
> [  144.733669]  ? report_bug+0x133/0x1c0
> [  144.734098]  ? refcount_warn_saturate+0xc7/0x110
> [  144.734608]  ? handle_bug+0x3c/0x6c
> [  144.735006]  ? exc_invalid_op+0x13/0x3c
> [  144.735446]  ? asm_exc_invalid_op+0x16/0x20
> [  144.735919]  ? refcount_warn_saturate+0xc7/0x110
> [  144.736434]  ? refcount_warn_saturate+0xc7/0x110
> [  144.736943]  __refcount_sub_and_test.constprop.0+0x39/0x42
> [  144.737536]  sock_wfree+0x8d/0x161
> [  144.737929]  skb_release_head_state+0x28/0x72
> [  144.738436]  skb_release_all+0x13/0x3e
> [  144.738863]  napi_consume_skb+0x53/0x62
> [  144.739295]  __free_old_xmit+0x119/0x26b
> [  144.739738]  ? __pfx___free_old_xmit+0x10/0x10
> [  144.740241]  ? __send_ipi_mask+0x22d/0x296
> [  144.740705]  free_old_xmit+0x74/0xd3
> [  144.741113]  ? __pfx_free_old_xmit+0x10/0x10
> [  144.741608]  ? do_raw_spin_lock+0x72/0xbf
> [  144.741837] ------------[ cut here ]------------
> [  144.742037]  ? srso_return_thunk+0x5/0x5f
> [  144.742049]  ? srso_return_thunk+0x5/0x5f
> [  144.742518] refcount_t: saturated; leaking memory.
> [  144.742911]  ? virtqueue_disable_cb+0x71/0xed
> [  144.743569] WARNING: CPU: 1 PID: 542 at lib/refcount.c:22 =
refcount_warn_saturate+0x87/0x110
> [  144.743773]  virtnet_poll_tx+0x110/0x233
> [  144.744215] Modules linked in:
> [  144.745020]  __napi_poll.constprop.0+0x5d/0x1b1
> [  144.745409] CPU: 1 UID: 0 PID: 542 Comm: ping6 Not tainted =
6.10.0-12627-gfced06475e82 #58
> [  144.745717]  net_rx_action+0x255/0x427
> [  144.746191] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  144.746964]  ? __pfx_net_rx_action+0x10/0x10
> [  144.747329] RIP: 0010:refcount_warn_saturate+0x87/0x110
> [  144.748223]  ? srso_return_thunk+0x5/0x5f
> [  144.748645] Code: c3 7a ff 0f 0b e9 a2 00 00 00 80 3d 9a 0e f1 01 =
00 0f 85 95 00 00 00 48 c7 c7 60 2b 6d 82 c6 05 86 0e f1 01 01 e8 be c3 =
7a ff <0f> 0b eb 7e 80 3d 75 0e f1 01 00 75 75 48 c7 c7 c0 2b 6d 82 c6 =
05
> [  144.749153]  ? srso_return_thunk+0x5/0x5f
> [  144.749540] RSP: 0018:ffffc900011577c8 EFLAGS: 00010282
> [  144.751319]  ? __raise_softirq_irqoff+0x5e/0x77
> [  144.751332]  ? srso_return_thunk+0x5/0x5f
>=20
> [  144.752252]  ? __napi_schedule+0x40/0x53
> [  144.752698] RAX: 0000000000000000 RBX: 0000000000000001 RCX: =
0000000000000000
> [  144.753093]  ? srso_return_thunk+0x5/0x5f
> [  144.753251] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: =
fffff5200022aee9
> [  144.753636]  ? do_raw_spin_lock+0x72/0xbf
> [  144.754342] RBP: ffff88810773d43c R08: 0000000000000004 R09: =
0000000000000001
> [  144.754731]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  144.755419] R10: ffff88815af2794b R11: ffffed102b5e4f29 R12: =
00000000000000e1
> [  144.755814]  ? srso_return_thunk+0x5/0x5f
> [  144.756514] R13: 0000000000000000 R14: ffff88810773d2c0 R15: =
0000000000000000
> [  144.756955]  ? preempt_count_add+0x1b/0x6a
> [  144.757644] FS:  00007fc78bd11c40(0000) GS:ffff88815af00000(0000) =
knlGS:0000000000000000
> [  144.758044]  ? srso_return_thunk+0x5/0x5f
> [  144.758059]  handle_softirqs+0x153/0x300
> [  144.758075]  ? srso_return_thunk+0x5/0x5f
> [  144.758758] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  144.759160]  common_interrupt+0x96/0xbc
> [  144.759927] CR2: 00007f494c02a098 CR3: 0000000103f1e000 CR4: =
0000000000350ef0
> [  144.760334]  </IRQ>
> [  144.760725] Call Trace:
> [  144.761120]  <TASK>
> [  144.761678]  <TASK>
> [  144.762068]  asm_common_interrupt+0x22/0x40
> [  144.762763]  ? __warn+0xc4/0x175
> [  144.762976] RIP: 0010:default_idle+0xb/0x11
> [  144.763220]  ? refcount_warn_saturate+0x87/0x110
> [  144.763442] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 47 04 36 00 =
fb f4 <fa> e9 5f cc 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 =
90
> [  144.763660]  ? report_bug+0x133/0x1c0
> [  144.764066] RSP: 0018:ffffffff83007e58 EFLAGS: 00000202
> [  144.764391]  ? refcount_warn_saturate+0x87/0x110
>=20
> [  144.765255]  ? handle_bug+0x3c/0x6c
> [  144.767045] RAX: 0000000000000000 RBX: ffffffff8301ad40 RCX: =
ffffed102b5c67e1
> [  144.767052] RDX: ffffed102b5c67e1 RSI: ffffffff826d8680 RDI: =
0000000000035024
> [  144.767413]  ? exc_invalid_op+0x13/0x3c
> [  144.767921] RBP: 0000000000000000 R08: 0000000000000004 R09: =
0000000000000001
> [  144.768384]  ? asm_exc_invalid_op+0x16/0x20
> [  144.768541] R10: ffff88815ae33f03 R11: ffffed102b5c67e0 R12: =
0000000000000000
> [  144.768895]  ? refcount_warn_saturate+0x87/0x110
> [  144.769578] R13: 1ffffffff0600fcd R14: 0000000000000000 R15: =
0000000000013af0
> [  144.770284]  ? refcount_warn_saturate+0x87/0x110
> [  144.770665]  ? srso_return_thunk+0x5/0x5f
> [  144.771339]  __ip6_append_data.isra.0+0x14ed/0x157a
> [  144.771744]  default_idle_call+0x34/0x53
> [  144.772440]  ? __pfx_raw6_getfrag+0x10/0x10
> [  144.772881]  do_idle+0x100/0x211
> [  144.773575]  ? __pfx_xfrm_lookup_with_ifid+0x10/0x10
> [  144.774036]  ? __pfx_do_idle+0x10/0x10
> [  144.774439]  ? __pfx___ip6_append_data.isra.0+0x10/0x10
> [  144.774911]  ? __pfx_kthreadd+0x10/0x10
> [  144.775294]  ? __rcu_read_unlock+0x4e/0x228
> [  144.775707]  cpu_startup_entry+0x2f/0x31
> [  144.776026]  ? ip6_dst_lookup_tail.constprop.0+0x338/0x3e0
> [  144.776512]  rest_init+0xda/0xda
> [  144.776878]  ? srso_return_thunk+0x5/0x5f
> [  144.777442]  start_kernel+0x33a/0x33a
> [  144.777844]  ? xfrm_mtu+0x24/0x44
> [  144.778268]  x86_64_start_reservations+0x25/0x25
> [  144.778656]  ? srso_return_thunk+0x5/0x5f
> [  144.779189]  x86_64_start_kernel+0x78/0x78
> [  144.779509]  ? ip6_setup_cork+0x4ee/0x507
> [  144.779905]  common_startup_64+0x12c/0x138
> [  144.780274]  ip6_append_data+0x167/0x17e
> [  144.780616]  </TASK>
> [  144.781070]  ? __pfx_raw6_getfrag+0x10/0x10
> [  144.781462] ---[ end trace 0000000000000000 ]---
> [  144.781870]  rawv6_sendmsg+0x10a6/0x153e
> [  144.788903]  ? srso_return_thunk+0x5/0x5f
> [  144.789357]  ? __schedule+0xad9/0xb54
> [  144.789784]  ? __pfx_rawv6_sendmsg+0x10/0x10
> [  144.790291]  ? srso_return_thunk+0x5/0x5f
> [  144.790952]  ? srso_return_thunk+0x5/0x5f
> [  144.791591]  ? tty_insert_flip_string_and_push_buffer+0x100/0x139
> [  144.792265]  ? srso_return_thunk+0x5/0x5f
> [  144.792724]  ? srso_return_thunk+0x5/0x5f
> [  144.793175]  ? preempt_schedule_common+0x33/0x40
> [  144.793691]  ? srso_return_thunk+0x5/0x5f
> [  144.794166]  ? preempt_schedule_thunk+0x16/0x30
> [  144.794754]  ? preempt_count_sub+0x14/0xb9
> [  144.795216]  ? srso_return_thunk+0x5/0x5f
> [  144.795665]  ? srso_return_thunk+0x5/0x5f
> [  144.796113]  ? preempt_count_sub+0x14/0xb9
> [  144.796590]  ? srso_return_thunk+0x5/0x5f
> [  144.797039]  ? up_read+0x54/0x6a
> [  144.797415]  ? srso_return_thunk+0x5/0x5f
> [  144.797864]  ? n_tty_write+0x60b/0x669
> [  144.798321]  ? srso_return_thunk+0x5/0x5f
> [  144.798864]  ? mutex_unlock+0x7e/0xc4
> [  144.799333]  ? srso_return_thunk+0x5/0x5f
> [  144.799784]  ? __wake_up_common+0x2c/0xb8
> [  144.800246]  ? srso_return_thunk+0x5/0x5f
> [  144.800703]  ? sock_sendmsg_nosec+0x82/0xe2
> [  144.801172]  ? __pfx_rawv6_sendmsg+0x10/0x10
> [  144.801650]  sock_sendmsg_nosec+0x82/0xe2
> [  144.802127]  __sys_sendto+0x15d/0x1d0
> [  144.802602]  ? __pfx___sys_sendto+0x10/0x10
> [  144.803095]  ? srso_return_thunk+0x5/0x5f
> [  144.803544]  ? file_end_write.isra.0+0x9/0x35
> [  144.804029]  ? vfs_write+0x22e/0x298
> [  144.804457]  ? __might_resched+0x8c/0x24a
> [  144.804907]  ? __might_sleep+0x26/0xa1
> [  144.805337]  ? __fget_light+0x8f/0xca
> [  144.805755]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
> [  144.806386]  ? __pfx_ksys_write+0x10/0x10
> [  144.806950]  __x64_sys_sendto+0x76/0x86
> [  144.807418]  do_syscall_64+0x68/0xd8
> [  144.807829]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  144.808387] RIP: 0033:0x7fc78bfcda73
> [  144.808792] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff =
ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c =
24
> [  144.810676] RSP: 002b:00007ffccb57b818 EFLAGS: 00000202 ORIG_RAX: =
000000000000002c
> [  144.811575] RAX: ffffffffffffffda RBX: 0000559df5f27340 RCX: =
00007fc78bfcda73
> [  144.812335] RDX: 0000000000000040 RSI: 0000559df5f2d3c0 RDI: =
0000000000000003
> [  144.813086] RBP: 0000559df5f2d3c0 R08: 0000559df5f29554 R09: =
000000000000001c
> [  144.813837] R10: 0000000000000800 R11: 0000000000000202 R12: =
00007ffccb57cb28
> [  144.814747] R13: 0000000000000040 R14: 0000001d00000001 R15: =
0000559df5f2a700
> [  144.815674]  </TASK>
> [  144.816091] ---[ end trace 0000000000000000 ]---
> --=20
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel



