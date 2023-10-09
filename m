Return-Path: <netdev+bounces-39086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B07BDE22
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD32A2814B1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2898E555;
	Mon,  9 Oct 2023 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="MVEFcIZd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FEC19463
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:16:13 +0000 (UTC)
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F11B6;
	Mon,  9 Oct 2023 06:16:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1696857365;
	bh=LM+eM7modYOnqrVh/3dhXyW83yRoxFdZ9tfpmyW8ugk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=MVEFcIZdfqdBw2CTs80FmBM5+kruiOb2zT9RBE/uUo01DSUTspQfTDwOYLBuXxc8v
	 ShItfhs2wPOlM2nJQGAvUmPUv6LlhRUDLCA+nxMmPzxP3a3kyOAGXm0k1mccSrZbzq
	 t+46LIg1WWloKeUTRWfhvH2vozIj2OFO3oKAlEns=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <31b59df2-d668-478e-a546-c3805f74c3a3@gmail.com>
Date: Mon, 9 Oct 2023 15:15:44 +0200
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org,
 netdev@vger.kernel.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4220ECCB-4B99-43AD-BE6B-36AE86B72871@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
 <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
 <740b0d7e-c789-47b5-b419-377014a99f22@leemhuis.info>
 <BBEA77E4-D376-45CE-9A93-415F2E0703D7@flyingcircus.io>
 <982dc76d-0832-4c8a-a486-5e6a2f5fb49a@gmail.com>
 <0AAB089F-A296-472B-8E6F-0D60B9ACCB95@flyingcircus.io>
 <31b59df2-d668-478e-a546-c3805f74c3a3@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

> On 6. Oct 2023, at 16:13, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>=20
>>> You need to have testing system, unfortunately. It should mimic your
>>> production setup as much as possible. Your organization may have one
>>> already, but if not, you have to arrange for it.
>>=20
>> I=E2=80=99m able to do that, I just didn=E2=80=99t have one at hand =
at this very moment and no time to prepare one within a few minutes. =
I=E2=80=99ll try to reproduce with a 6.6rc in the next days.
>>=20
>=20
> OK, thanks!

So, I got around running this with 6.6-rc5 today and yes, it=E2=80=99s =
broken there as well:

Here=E2=80=99s the output from my testing environment:

#### snip
subtest: try hfsc
machine: must succeed: uname -a
(finished: must succeed: uname -a, in 0.02 seconds)
Linux machine 6.6.0-rc5 #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1 00:00:00 =
UTC 1980 x86_64 GNU/Linux

machine: must succeed: modprobe ifb
(finished: must succeed: modprobe ifb, in 0.02 seconds)
machine: must succeed: modprobe act_mirred
machine # [    9.187251] (udev-worker)[851]: ifb0: Could not set Alias=3D,=
 MACAddress=3D/MACAddressPolicy=3D, TransmitQueues=3D, ReceiveQueues=3D, =
TransmitQueueLength=3D, MTUBytes=3D, GenericSegmentOffloadMaxBytes=3D or =
GenericSegmentOffloadMaxSegments=3D, ignoring: Operation not supported
machine # [    9.190616] (udev-worker)[851]: Network interface =
NamePolicy=3D disabled on kernel command line.
machine # [    9.192605] (udev-worker)[928]: ifb1: Could not set Alias=3D,=
 MACAddress=3D/MACAddressPolicy=3D, TransmitQueues=3D, ReceiveQueues=3D, =
TransmitQueueLength=3D, MTUBytes=3D, GenericSegmentOffloadMaxBytes=3D or =
GenericSegmentOffloadMaxSegments=3D, ignoring: Operation not supported
machine # [    9.197607] (udev-worker)[928]: Network interface =
NamePolicy=3D disabled on kernel command line.
machine # [    9.292073] Mirror/redirect action on
(finished: must succeed: modprobe act_mirred, in 0.04 seconds)
machine: must succeed: tc qdisc add dev eth0 handle ffff: ingress
(finished: must succeed: tc qdisc add dev eth0 handle ffff: ingress, in =
0.05 seconds)
machine: must succeed: ifconfig ifb0 up
machine # [    9.276585] dhcpcd[672]: ifb0: waiting for carrier
machine # [    9.278532] dhcpcd[672]: ifb0: carrier acquired
machine # [    9.287692] dhcpcd[672]: ifb0: IAID df:2e:ad:2b
machine # [    9.288225] dhcpcd[672]: ifb0: adding address =
fe80::40d2:dfff:fe2e:ad2b
(finished: must succeed: ifconfig ifb0 up, in 0.02 seconds)
machine: must succeed: tc filter add dev eth0 parent ffff: protocol all =
u32 match u32 0 0 action mirred egress redirect dev ifb0
machine # [    9.396408] u32 classifier
machine # [    9.396613]     Performance counters on
machine # [    9.396895]     input device check on
machine # [    9.397148]     Actions configured
(finished: must succeed: tc filter add dev eth0 parent ffff: protocol =
all u32 match u32 0 0 action mirred egress redirect dev ifb0, in 0.04 =
seconds)
machine: must succeed: tc qdisc add dev ifb0 root handle 1: hfsc default =
1
machine # [    9.330784] dhcpcd[672]: ifb1: waiting for carrier
machine # [    9.332246] dhcpcd[672]: ifb1: carrier acquired
machine # [    9.343280] dhcpcd[672]: ifb1: IAID ab:f5:e8:5d
machine # [    9.343868] dhcpcd[672]: ifb1: adding address =
fe80::2c7f:abff:fef5:e85d
(finished: must succeed: tc qdisc add dev ifb0 root handle 1: hfsc =
default 1, in 0.03 seconds)
machine: must succeed: tc class add dev ifb0 parent 1: classid 1:999 =
hfsc rt m2 2.5gbit
(finished: must succeed: tc class add dev ifb0 parent 1: classid 1:999 =
hfsc rt m2 2.5gbit, in 0.01 seconds)
machine: must succeed: tc class add dev ifb0 parent 1:999 classid 1:1 =
hfsc sc rate 50mbit
machine # Error: Invalid parent - parent class must have FSC.
machine: output:
Test "try hfsc" failed with error: "command `tc class add dev ifb0 =
parent 1:999 classid 1:1 hfsc sc rate 50mbit` failed (exit code 2)"
cleanup
kill machine (pid 6)
#### snap

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


