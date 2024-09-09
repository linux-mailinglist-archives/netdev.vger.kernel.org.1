Return-Path: <netdev+bounces-126622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327EE972164
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE845284355
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F25178CE8;
	Mon,  9 Sep 2024 17:53:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A8524C4
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904439; cv=none; b=ZeNwB0gdIk5mJZebEKezuF9xmb8+RgIDCwrkakU98E813yjwb73beoJQ7Y/1SFLWGo1y1iMnpLbgfiJh4nnBrvXsvYPapVhA990Iwwzxd2NG7Z8MvOGEOPSu5qhvd1emnf7Zx/t4AOH1xXMFldysSK+yhUclGh3xgX4gDcaftTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904439; c=relaxed/simple;
	bh=yR3NURQyzNN0v3hm6cEq55pcBOzTOHXaMkrqpyqYRr0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BJ9N3VIlakrjUL+DXZGHc5ui/CfgVOC75BrhvqlUhxpeaJVH0GKIWZ0FiacxlxPBKMs++YglpvN2MW7wGDvNIqx/zfuCJ4/Tkx36N2z/HXRXCt5YUS7xbLgRyW9Sx+NS+pPcNh2l3EgHBMCdq4/XzZFMyuO2/QAggg5DxeOGRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id E9A417D0AA;
	Mon,  9 Sep 2024 17:53:48 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 07/16] xfrm: iptfs: add new
 iptfs xfrm mode impl
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <Zt8jL9c9geA4T_p-@Antony2201.local>
Date: Mon, 9 Sep 2024 13:53:37 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org,
 Florian Westphal <fw@strlen.de>,
 Sabrina Dubroca <sd@queasysnail.net>,
 Simon Horman <horms@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAFC4B76-122D-44C4-9044-14C466FC2D7A@chopps.org>
References: <20240824022054.3788149-1-chopps@chopps.org>
 <20240824022054.3788149-8-chopps@chopps.org>
 <ZtBe_anpf3QOG8jW@Antony2201.local>
 <24F9C7DC-1591-44C4-8451-00BF3F593853@chopps.org>
 <Zt8jL9c9geA4T_p-@Antony2201.local>
To: Antony Antony <antony@phenome.org>
X-Mailer: Apple Mail (2.3776.700.51)



> On Sep 9, 2024, at 12:32, Antony Antony <antony@phenome.org> wrote:
>=20
> On Fri, Sep 06, 2024 at 11:04:45PM -0400, Christian Hopps via Devel =
wrote:
>>=20
>>=20
>>> On Aug 29, 2024, at 07:43, Antony Antony via Devel =
<devel@linux-ipsec.org> wrote:
>>>=20
>>> On Fri, Aug 23, 2024 at 10:20:45PM -0400, Christian Hopps wrote:
>>>> From: Christian Hopps <chopps@labn.net>
>>>>=20
>>>> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>>=20
>> [...]
>>=20
>>>> +static int iptfs_clone(struct xfrm_state *x, struct xfrm_state =
*orig)
>>>> +{
>>>> + struct xfrm_iptfs_data *xtfs;
>>>> +
>>>> + xtfs =3D kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
>>>> + if (!xtfs)
>>>> + return -ENOMEM;
>>>> +
>>>> + __iptfs_init_state(x, xtfs);
>>>=20
>>> I noticed __iptfs_init_state() is called twice during =
XFRM_MSG_MIGRATE.
>>> This, the first, call does the right thing. However, the second call =
resets=20
>>> the iptfs values to zero.
>>=20
>> Fixed in patchset v11.
>=20
> thanks Chris.
>=20
> I notice an unconditional memory alloc in iptfs_init_state()
> xtfs =3D kzalloc(sizeof(*xtfs), GFP_KERNEL);
>=20
> That is not what I tested. It looks odd.  Did you miss a hunk during =
the git=20
> rebase, or did you change the code?
> I didn't test v11 yet.

Hmm, this was removed when I removed the call to `__iptfs_init_state()` =
inside `iptfs_clone_state()`; however, You are correct that the check is =
still needed. I will have to publish a v12 to add this back. It would be =
great if it were easier to test migration, but that's another project.

Thanks,
Chris.

>=20
> -antony
>=20
>=20
>>=20
>> Thanks,
>> Chris.
>>=20
>>>=20
>>> While testing I noticed clone is not workig as expected. It seems to =
reset=20
>>> values iptfs. See the "ip x s"  out before and after clone.
>>>=20
>>> Here are two "ip x s"  output one before clone and another after =
clone noice=20
>>> iptfs values are 0, while before max-queue-size 10485760
>>>=20
>>> root@east:/testing/pluto/ikev2-mobike-01$ip x s
>>> src 192.1.2.23 dst 192.1.3.33
>>> proto esp spi 0xcd561999 reqid 16393 mode iptfs
>>> replay-window 0 flag af-unspec esn
>>> auth-trunc hmac(sha256) =
0xcba08c655b22df167c9bf16ac8005cffbe15e6baab553b8f48ec0056c037c51f 128
>>> enc cbc(aes) =
0xb3702487e95675713e7dfb738cc21c5dd86a666af38cdabcc3705ed30fea92e2
>>> lastused 2024-08-29 12:33:12
>>> anti-replay esn context:
>>> seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0xb
>>> replay_window 0, bitmap-length 0
>>> dir out
>>> iptfs-opts dont-frag init-delay 0 max-queue-size 10485760 pkt-size 0
>>> src 192.1.3.33 dst 192.1.2.23
>>> proto esp spi 0xd9ecf873 reqid 16393 mode iptfs
>>> replay-window 0 flag af-unspec esn
>>> auth-trunc hmac(sha256) =
0xf841c6643a06186e86a856600e071e2a220450943fdf7b64a8d2f3e3bffd6c62 128
>>> enc cbc(aes) =
0x5ffa993bbc568ecab82e15433b14c03e5da18ca4d216137493d552260bef0be1
>>> lastused 2024-08-29 12:33:12
>>> anti-replay esn context:
>>> seq-hi 0x0, seq 0xb, oseq-hi 0x0, oseq 0x0
>>> replay_window 128, bitmap-length 4
>>> 00000000 00000000 00000000 000007ff
>>> dir in
>>> iptfs-opts drop-time 3 reorder-window 3
>>>=20
>>> After migrate: note iptfs vallues are 0.
>>>=20
>>> root@east:/testing/pluto/ikev2-mobike-01$ip x s
>>> src 192.1.8.22 dst 192.1.2.23
>>> proto esp spi 0xd9ecf873 reqid 16393 mode iptfs
>>> replay-window 0 flag af-unspec esn
>>> auth-trunc hmac(sha256) =
0xf841c6643a06186e86a856600e071e2a220450943fdf7b64a8d2f3e3bffd6c62 128
>>> enc cbc(aes) =
0x5ffa993bbc568ecab82e15433b14c03e5da18ca4d216137493d552260bef0be1
>>> lastused 2024-08-29 12:33:12
>>> anti-replay esn context:
>>> seq-hi 0x0, seq 0xb, oseq-hi 0x0, oseq 0x0
>>> replay_window 128, bitmap-length 4
>>> 00000000 00000000 00000000 000007ff
>>> dir in
>>> iptfs-opts drop-time 0 reorder-window 0
>>> src 192.1.2.23 dst 192.1.8.22
>>> proto esp spi 0xcd561999 reqid 16393 mode iptfs
>>> replay-window 0 flag af-unspec esn
>>> auth-trunc hmac(sha256) =
0xcba08c655b22df167c9bf16ac8005cffbe15e6baab553b8f48ec0056c037c51f 128
>>> enc cbc(aes) =
0xb3702487e95675713e7dfb738cc21c5dd86a666af38cdabcc3705ed30fea92e2
>>> lastused 2024-08-29 12:33:12
>>> anti-replay esn context:
>>> seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0xb
>>> replay_window 0, bitmap-length 0
>>> dir out
>>> iptfs-opts init-delay 0 max-queue-size 0 pkt-size 0
>>>=20
>>> Now running under gdb during a migrate I see __iptfs_init_state() =
called=20
>>> twice.
>>>=20
>>> I got gdb back trace to show the two calls during XFRM_MSG_MIGRATE.
>>>=20
>>> First call __iptfs_init_state() with bt. This is during =
clone/MIGRATE.
>>>=20
>>> #0  __iptfs_init_state (x=3Dx@entry=3D0xffff888110a1fc40, =
xtfs=3Dxtfs@entry=3D0xffff88810e275000)
>>>   at net/xfrm/xfrm_iptfs.c:2674
>>> #1  0xffffffff81ece552 in iptfs_clone (x=3D0xffff888110a1fc40, =
orig=3D<optimized out>)
>>>   at net/xfrm/xfrm_iptfs.c:2722
>>> #2  0xffffffff81eb65ad in xfrm_state_clone =
(encap=3D0xffffffff00000010, orig=3D0xffff888110a1e040)
>>>   at net/xfrm/xfrm_state.c:1878
>>> #3  xfrm_state_migrate (x=3Dx@entry=3D0xffff888110a1e040, =
m=3Dm@entry=3D0xffffc90001b47400,
>>>   encap=3Dencap@entry=3D0x0 <fixed_percpu_data>) at =
net/xfrm/xfrm_state.c:1948
>>> #4  0xffffffff81ea9206 in xfrm_migrate =
(sel=3Dsel@entry=3D0xffff88811193ce50, dir=3D<optimized out>,
>>>   type=3Dtype@entry=3D0 '\000', m=3Dm@entry=3D0xffffc90001b47400, =
num_migrate=3Dnum_migrate@entry=3D1,
>>>   k=3Dk@entry=3D0x0 <fixed_percpu_data>, net=3D<optimized out>, =
encap=3D<optimized out>, if_id=3D<optimized out>,
>>>   extack=3D<optimized out>) at net/xfrm/xfrm_policy.c:4652
>>> #5  0xffffffff81ec26de in xfrm_do_migrate =
(skb=3Dskb@entry=3D0xffff888109265000, nlh=3D<optimized out>,
>>>   attrs=3Dattrs@entry=3D0xffffc90001b47730, extack=3D<optimized =
out>) at net/xfrm/xfrm_user.c:3047
>>> #6  0xffffffff81ec3e70 in xfrm_user_rcv_msg (skb=3D0xffff888109265000,=
 nlh=3D<optimized out>,
>>>   extack=3D<optimized out>) at net/xfrm/xfrm_user.c:3389
>>> ---
>>> second call to __iptfs_init_state() bt.
>>>=20
>>> #0  __iptfs_init_state (x=3Dx@entry=3D0xffff888110a1fc40, =
xtfs=3D0xffff88810e272000) at net/xfrm/xfrm_iptfs.c:2674
>>> #1  0xffffffff81ece1a4 in iptfs_create_state (x=3D0xffff888110a1fc40) =
at net/xfrm/xfrm_iptfs.c:2742
>>> #2  0xffffffff81eb5c61 in xfrm_init_state =
(x=3Dx@entry=3D0xffff888110a1fc40) at net/xfrm/xfrm_state.c:3042
>>> #3  0xffffffff81eb65dc in xfrm_state_migrate =
(x=3Dx@entry=3D0xffff888110a1e040, m=3Dm@entry=3D0xffffc90001b47400,
>>>   encap=3Dencap@entry=3D0x0 <fixed_percpu_data>) at =
net/xfrm/xfrm_state.c:1954
>>> #4  0xffffffff81ea9206 in xfrm_migrate =
(sel=3Dsel@entry=3D0xffff88811193ce50, dir=3D<optimized out>,
>>>   type=3Dtype@entry=3D0 '\000', m=3Dm@entry=3D0xffffc90001b47400, =
num_migrate=3Dnum_migrate@entry=3D1,
>>>   k=3Dk@entry=3D0x0 <fixed_percpu_data>, net=3D<optimized out>, =
encap=3D<optimized out>, if_id=3D<optimized out>,
>>>   extack=3D<optimized out>) at net/xfrm/xfrm_policy.c:4652
>>> #5  0xffffffff81ec26de in xfrm_do_migrate =
(skb=3Dskb@entry=3D0xffff888109265000, nlh=3D<optimized out>,
>>>   attrs=3Dattrs@entry=3D0xffffc90001b47730, extack=3D<optimized =
out>) at net/xfrm/xfrm_user.c:3047
>>> #6  0xffffffff81ec3e70 in xfrm_user_rcv_msg (skb=3D0xffff888109265000,=
=20
>>> nlh=3D<optimized out>,
>>>=20
>>> I have a proposed fix against v10, that seems to work. see the =
attached=20
>>> patch. The patch is applied top of the series.
>>>=20
>>> -antony
>>>=20
>>> PS: this exact issue was also reported in:
>>> https://www.spinics.net/lists/netdev/msg976146.html
>>> <0001-call-iptfs-state-init-only-once-during-cloning.patch>--=20
>>> Devel mailing list
>>> Devel@linux-ipsec.org
>>> https://linux-ipsec.org/mailman/listinfo/devel
>>=20
>>=20
>> --=20
>> Devel mailing list
>> Devel@linux-ipsec.org
>> https://linux-ipsec.org/mailman/listinfo/devel



