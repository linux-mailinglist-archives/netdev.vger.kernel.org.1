Return-Path: <netdev+bounces-212773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B28B21CC6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1329E3BDB32
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270E29BDA4;
	Tue, 12 Aug 2025 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aMzbkq2c"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249741A9FA6
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975495; cv=none; b=lHEoh+wvJ/QnEggRQ19yX+vUz+5AaVxMXS3cwRw2dbfKHPMCm7J5KTBM+Mz8fQIbI2RQqJPnbcAvZkxZBjfv3qXzmYufsOixoe/9g7Fvz+oN02biql8qF6Oe0Ng8NDSg20sLsY5aW6ZIL3NM27j5moDuNNX47n1Rqlueqa7b4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975495; c=relaxed/simple;
	bh=cQ1zW4ybdFIo18h/V2wirjzwEM0K/Q2Ht+ZiShY4z1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mAK/TxqZglX5bJvyyty7bMC+fHNDrMV2IkX3GmssVgpUb58a0wwWPjWo7nuQvp9wRrKwbr9Dngm3fmXccUFFE3nWVuMKiQSEgQMJ0QZMQSXQm35X4HXjzjdGTbYOrcHAqafASAYvZViYxEQI3et58Cr5dPqY84B+UKaSbhEs4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aMzbkq2c; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754975492;
	bh=4qmv1+yQmN3H/DORzZjRjWLSoaUojDmJgqOYjxR9fm8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aMzbkq2cPSdt9JEVqaEq717C/+oew8NsaWlsyGWpL84eN40y754LcoE8leG9mOgNh
	 9TP/GzssKaRAzW6UQfkHcAZ04eb7ZM61l/9JcAnsPUFVd1jyoqF4R/SbPn+Df68/WX
	 WMsYzwdianUKjEAEvLR2SNOifYGmCmz6tHLrnMOEUWlknvS1JTSyvkVPL7yMOUeY8G
	 gJP5GJhYaiJQdlK08CjxQMJQlMwIkOJBDdOABkxM5nUBc6aMQiqoieHreV+uTXf1bM
	 JNy+TXJKT0pAqd1U3n9S3EJN8F/Zi4O3YXsvZ/wLZYTVBU2zzttncSUoTo7t3XWvsY
	 A8bsNBnCt3Ijw==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F37E26ABED;
	Tue, 12 Aug 2025 13:11:31 +0800 (AWST)
Message-ID: <e7cbbdbc939b7e1fe1e27981c01aca49c022cdb7.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 7/7] net: mctp: Add bind lookup test
From: Matt Johnston <matt@codeconstruct.com.au>
To: Alexandre Ghiti <alex@ghiti.fr>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 12 Aug 2025 13:11:31 +0800
In-Reply-To: <734b02a3-1941-49df-a0da-ec14310d41e4@ghiti.fr>
References: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
	 <20250703-mctp-bind-v1-7-bb7e97c24613@codeconstruct.com.au>
	 <734b02a3-1941-49df-a0da-ec14310d41e4@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alexandre,

Thanks for the report.

On Mon, 2025-08-11 at 13:35 +0200, Alexandre Ghiti wrote:

> I'm hitting different issues with this test.
>=20
> With a simple riscv defconfig, I get the following warning a bit after=
=20
> the test succeeds:
>=20
> [=C2=A0=C2=A0=C2=A0 5.991567] WARNING: CPU: 1 PID: 0 at net/netlink/af_ne=
tlink.c:402=20
> netlink_sock_destruct+0x3a/0x6a
> [=C2=A0=C2=A0=C2=A0 5.992039] Modules linked in:

I can reproduce it with the um kunit runner if I enable kasan.=C2=A0The skb=
_pkt
shouldn't be freed, I've submitted a fix for that.

Cheers,
Matt

> [=C2=A0=C2=A0=C2=A0 5.992384] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainte=
d:=20
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 N=C2=A0 6.17.0-rc1-00005-g1692753ec9e8-dirty #40 N=
ONE
> [=C2=A0=C2=A0=C2=A0 5.992502] Tainted: [N]=3DTEST
> [=C2=A0=C2=A0=C2=A0 5.992521] Hardware name: riscv-virtio,qemu (DT)
> [=C2=A0=C2=A0=C2=A0 5.992604] epc : netlink_sock_destruct+0x3a/0x6a
> [=C2=A0=C2=A0=C2=A0 5.992643]=C2=A0 ra : netlink_sock_destruct+0x18/0x6a
> [=C2=A0=C2=A0=C2=A0 5.992669] epc : ffffffff809bdf26 ra : ffffffff809bdf0=
4 sp :=20
> ff2000000000bd90
> [=C2=A0=C2=A0=C2=A0 5.992685]=C2=A0 gp : ffffffff81a1b458 tp : ff60000080=
2ce000 t0 :=20
> 0000000000000040
> [=C2=A0=C2=A0=C2=A0 5.992700]=C2=A0 t1 : 0000000000000000 t2 : 0000000080=
150012 s0 :=20
> ff2000000000bdb0
> [=C2=A0=C2=A0=C2=A0 5.992715]=C2=A0 s1 : ff600000825a0800 a0 : ff60000082=
5a08a8 a1 :=20
> 0000000000000068
> [=C2=A0=C2=A0=C2=A0 5.992729]=C2=A0 a2 : 0000000000000008 a3 : 0000000000=
00000a a4 :=20
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 5.992743]=C2=A0 a5 : ffffffffffffce00 a6 : ffffffffff=
ffffff a7 :=20
> ffffffff81a20810
> [=C2=A0=C2=A0=C2=A0 5.992757]=C2=A0 s2 : ff600000825a0800 s3 : ffffffff81=
a7c040 s4 :=20
> ff2000000000be60
> [=C2=A0=C2=A0=C2=A0 5.992770]=C2=A0 s5 : 0000000000000000 s6 : 0000000000=
00000a s7 :=20
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 5.992784]=C2=A0 s8 : ff600003fff1e580 s9 : 0000000000=
000001 s10:=20
> ffffffff81890a80
> [=C2=A0=C2=A0=C2=A0 5.992798]=C2=A0 s11: ff600000825a0c28 t3 : 0000000000=
000002 t4 :=20
> 0000000000000402
> [=C2=A0=C2=A0=C2=A0 5.992811]=C2=A0 t5 : ff60000080069168 t6 : ff60000080=
069170
> [=C2=A0=C2=A0=C2=A0 5.992824] status: 0000000200000120 badaddr: ffffffff8=
09bdf26 cause:=20
> 0000000000000003
> [=C2=A0=C2=A0=C2=A0 5.992925] [<ffffffff809bdf26>] netlink_sock_destruct+=
0x3a/0x6a
> [=C2=A0=C2=A0=C2=A0 5.993015] [<ffffffff809369b8>] __sk_destruct+0x22/0x1=
aa
> [=C2=A0=C2=A0=C2=A0 5.993034] [<ffffffff809385b0>] sk_destruct+0x46/0x50
> [=C2=A0=C2=A0=C2=A0 5.993049] [<ffffffff8093860a>] __sk_free+0x50/0xc6
> [=C2=A0=C2=A0=C2=A0 5.993062] [<ffffffff809386aa>] sk_free+0x2a/0x46
> [=C2=A0=C2=A0=C2=A0 5.993077] [<ffffffff809bdb08>] deferred_put_nlk_sk+0x=
42/0x62
> [=C2=A0=C2=A0=C2=A0 5.993089] [<ffffffff800a5b80>] rcu_core+0x1ba/0x5c8
> [=C2=A0=C2=A0=C2=A0 5.993106] [<ffffffff800a5f9a>] rcu_core_si+0xc/0x14
> [=C2=A0=C2=A0=C2=A0 5.993119] [<ffffffff8002d8de>] handle_softirqs+0x110/=
0x2e8
> [=C2=A0=C2=A0=C2=A0 5.993133] [<ffffffff8002dbd2>] __irq_exit_rcu+0xd0/0x=
fa
> [=C2=A0=C2=A0=C2=A0 5.993144] [<ffffffff8002ddbe>] irq_exit_rcu+0xc/0x14
> [=C2=A0=C2=A0=C2=A0 5.993156] [<ffffffff80b438e0>] handle_riscv_irq+0x64/=
0x74
> [=C2=A0=C2=A0=C2=A0 5.993177] [<ffffffff80b4f88a>] call_on_irq_stack+0x32=
/0x40
>=20
> The following diff fixes it (completely unsure this is the right fix=20
> though):
>=20
> diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
> index fb6b46a952cb4..03f2f76c97f75 100644
> --- a/net/mctp/test/route-test.c
> +++ b/net/mctp/test/route-test.c
> @@ -1585,7 +1585,6 @@ static void mctp_test_bind_lookup(struct kunit *tes=
t)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0cleanup:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_skb(skb_sock);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_skb(skb_pkt);
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Drop all binds */
>=20
>=20
> But then with a more consequent config attached, even with the previous=
=20
> fix, I'm hitting:
>=20
> [=C2=A0 137.494285] kernel BUG at mm/slub.c:563!
> [=C2=A0 137.494365] Kernel BUG [#2]
> [=C2=A0 137.494388] Modules linked in:
> [=C2=A0 137.494449] CPU: 4 UID: 0 PID: 4699 Comm: kunit_try_catch Tainted=
:=20
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 N=C2=A0 6.17.0-rc1+ #16 PREEMPT(voluntary)
> [=C2=A0 137.494500] Tainted: [D]=3DDIE, [W]=3DWARN, [N]=3DTEST
> [=C2=A0 137.494514] Hardware name: riscv-virtio,qemu (DT)
> [=C2=A0 137.494534] epc : kmem_cache_free+0x334/0x39e
> [=C2=A0 137.494588]=C2=A0 ra : kmem_cache_free+0x76/0x39e
> [=C2=A0 137.494617] epc : ffffffff802e8ec4 ra : ffffffff802e8c06 sp :=20
> ff2000000b6cbb60
> [=C2=A0 137.494637]=C2=A0 gp : ffffffff82ac7b70 tp : ff60000087cc1f00 t0 =
:=20
> ff60000087ba6820
> [=C2=A0 137.494657]=C2=A0 t1 : 0000000000000000 t2 : 0000000000000000 s0 =
:=20
> ff2000000b6cbbb0
> [=C2=A0 137.494676]=C2=A0 s1 : ffffffff80c34db8 a0 : ff1c0000021ee900 a1 =
:=20
> ff60000087ba6680
> [=C2=A0 137.494695]=C2=A0 a2 : ff60000087ba6680 a3 : ffffffff82e4a858 a4 =
:=20
> ff600003fff21d80
> [=C2=A0 137.494715]=C2=A0 a5 : ff60000087ba67e0 a6 : 000000000002dc04 a7 =
:=20
> 0000000000000000
> [=C2=A0 137.494733]=C2=A0 s2 : ff60000087ba6680 s3 : ff600000802cc900 s4 =
:=20
> ff1c0000021ee900
> [=C2=A0 137.494754]=C2=A0 s5 : 0000000000000002 s6 : ff600000833d9b00 s7 =
:=20
> ff60000087b55a80
> [=C2=A0 137.494772]=C2=A0 s8 : 0000000000000000 s9 : ff2000000b6cbd18 s10=
:=20
> ffffffff81e29a90
> [=C2=A0 137.494791]=C2=A0 s11: 000000000000060e t3 : 0000000000000000 t4 =
:=20
> 0000000000000000
> [=C2=A0 137.494810]=C2=A0 t5 : 0000000000000000 t6 : ff60000087ba6685
> [=C2=A0 137.494826] status: 0000000200000120 badaddr: ffffffff802e8ec4 ca=
use:=20
> 0000000000000003
> [=C2=A0 137.494849] [<ffffffff802e8ec4>] kmem_cache_free+0x334/0x39e
> [=C2=A0 137.494883] [<ffffffff80c34db8>] skb_free_head+0xca/0x112
> [=C2=A0 137.494922] [<ffffffff80c37bba>] skb_release_data+0xe2/0x112
> [=C2=A0 137.494952] [<ffffffff80c3a202>] sk_skb_reason_drop+0x40/0x124
> [=C2=A0 137.494984] [<ffffffff80e57afe>] mctp_test_bind_lookup+0x15e/0x3f=
4
> [=C2=A0 137.495019] [<ffffffff80623454>] kunit_try_run_case+0x4c/0x13e
> [=C2=A0 137.495051] [<ffffffff80625a10>]=20
> kunit_generic_run_threadfn_adapter+0x1a/0x34
> [=C2=A0 137.495080] [<ffffffff80064a9c>] kthread+0xea/0x1c2
> [=C2=A0 137.495111] [<ffffffff8001b42e>] ret_from_fork_kernel+0x10/0x162
> [=C2=A0 137.495139] [<ffffffff80e9d192>] ret_from_fork_kernel_asm+0x16/0x=
18
> [=C2=A0 137.495199] Code: 80a3 00e7 5097 ffd5 80e7 9880 9002 b715 ec56 e8=
5a=20
> (9002) 9b61
> [=C2=A0 137.495760] ---[ end trace 0000000000000000 ]---
>=20
> Let me know if I can do anything to help.
>=20
> Thanks,
>=20
> Alex


