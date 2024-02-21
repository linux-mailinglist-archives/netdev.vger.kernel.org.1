Return-Path: <netdev+bounces-73575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C285D351
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1845B230D9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCF3CF72;
	Wed, 21 Feb 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bYOKlIhP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kldN2QLV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C53D39A
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507268; cv=none; b=rkaBcw3Z2ZtNj6SnbzclqJ01nR9dP5ZwchnBIFYT/Kf2faIT3/uFet/ITAWHU2VhWouO5HzsPEHuJk1fYOqoQSOFej2TCm5NLCHGEZVHof9sKg8aRfb7ZptBSWdOIrfdiuUFZeputa+/cxGm8JkzL4nBKzQ49t5RTej3mYXnEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507268; c=relaxed/simple;
	bh=R1afw1kdH9UrDU8L1SZBfp32UsIpHnCpQqVA+p1zU30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9bOPooi2h832qMDCBk3fHq+WkRuVd2V0uCMCdoo7uxy91czH+UZDqdOrCNDdAQ0gfCd4Dc5BWSzQgvfl66FlH62VtC65Btvf5soYil8uf/1cH3fukMq/dt8J2/vBtdCQ9ryHt/S7w9w0x9SLXDn+GLNseVxlipf+F3Q7rE/4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bYOKlIhP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kldN2QLV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708507265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaUppiVQ51nO4ypvb/Yv5OmtRsISIOKIVFh4kfje4W8=;
	b=bYOKlIhPynUuei5WMnszbJFV9nvttcluPhnUxHNvDNtBrZ/Hj1rY7Jj6itG7/LLVLEnruz
	C4hBlHDIz67uIKt/BiNedWetYzVMCsp0GST35umllsPmMtjxCxtrdVvgNLd3lWhrNflid2
	r8d984em7gjb4quiGHNbF5afIUg4NLBf7btVH1GDYJHn7x/x52eHUSkq/QKD5BJh2yq+QL
	YQyCvkXktlAronwmM0TeDQZxOfqtdMICrFX/ZcjAUwzyrV2TuIEQP0Mw1r6iLGmFeDR4L1
	SA1ZFtse8CA/zwqS04GFfTEb7awYzjaUakRC50kR0SSJJ6mAFDb2JUaahTqcxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708507265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaUppiVQ51nO4ypvb/Yv5OmtRsISIOKIVFh4kfje4W8=;
	b=kldN2QLVessmOE9l4F7jIGjq+k44bduJQFGbDiEiqiLOfwHawM6W+vQTiMidEC1l7fLzPM
	k6nJphW0htAYQqBQ==
To: Stanislav Fomichev <sdf@google.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
In-Reply-To: <87ttm25lxw.fsf@kurt.kurt.home>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
 <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
 <87ttm25lxw.fsf@kurt.kurt.home>
Date: Wed, 21 Feb 2024 10:21:04 +0100
Message-ID: <87le7e5g1r.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Feb 21 2024, Kurt Kanzenbach wrote:
> On Tue Feb 20 2024, Stanislav Fomichev wrote:
>> On Tue, Feb 20, 2024 at 6:43=E2=80=AFAM Maciej Fijalkowski
>> <maciej.fijalkowski@intel.com> wrote:
>>>
>>> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
>>> > Hi Kurt
>>> >
>>> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
>>> > > Hello netdev community,
>>> > >
>>> > > after updating to v6.8 kernel I've encountered an issue in the stmm=
ac
>>> > > driver.
>>> > >
>>> > > I have an application which makes use of XDP zero-copy sockets. It =
works
>>> > > on v6.7. On v6.8 it results in the stack trace shown below. The pro=
gram
>>> > > counter points to:
>>> > >
>>> > >  - ./include/net/xdp_sock.h:192 and
>>> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
>>> > >
>>> > > It seems to be caused by the XDP meta data patches. This one in
>>> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP Z=
C").
>>> > >
>>> > > To reproduce:
>>> > >
>>> > >  - Hardware: imx93
>>> > >  - Run ptp4l/phc2sys
>>> > >  - Configure Qbv, Rx steering, NAPI threading
>>> > >  - Run my application using XDP/ZC on queue 1
>>> > >
>>> > > Any idea what might be the issue here?
>>> > >
>>> > > Thanks,
>>> > > Kurt
>>> > >
>>> > > Stack trace:
>>> > >
>>> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
>>> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has bee=
n switched
>>> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuo=
us mode
>>> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE=
_PAGE_POOL RxQ-0
>>> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE=
_PAGE_POOL RxQ-1
>>> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE=
_XSK_BUFF_POOL RxQ-1
>>> > > |[  255.822584] Unable to handle kernel NULL pointer dereference at=
 virtual address 0000000000000000
>>> > > |[  255.822602] Mem abort info:
>>> > > |[  255.822604]   ESR =3D 0x0000000096000044
>>> > > |[  255.822608]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>>> > > |[  255.822613]   SET =3D 0, FnV =3D 0
>>> > > |[  255.822616]   EA =3D 0, S1PTW =3D 0
>>> > > |[  255.822618]   FSC =3D 0x04: level 0 translation fault
>>> > > |[  255.822622] Data abort info:
>>> > > |[  255.822624]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
>>> > > |[  255.822627]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
>>> > > |[  255.822630]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>>> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000=
85fe1000
>>> > > |[  255.822638] [0000000000000000] pgd=3D0000000000000000, p4d=3D00=
00000000000000
>>> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT=
_RT SMP
>>> > > |[  255.822655] Modules linked in:
>>> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8=
.0-rc4-rt4-00100-g9c63d995ca19 #8
>>> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
>>> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SS=
BS BTYPE=3D--)
>>> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
>>> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
>>> > > |[  255.822696] sp : ffff800085ec3bc0
>>> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 00=
00000000000001
>>> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 00=
00000000000001
>>> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 00=
00000000000000
>>> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 00=
00000000000000
>>> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 00=
00000000000008
>>> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 00=
00000000008507
>>> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ff=
ff800080e32f84
>>> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00=
00000000003ff0
>>> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 00=
00000000000000
>>> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00=
00000000000000
>>> > > |[  255.822764] Call trace:
>>> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>>>
>>> Shouldn't xsk_tx_metadata_complete() be called only when corresponding
>>> buf_type is STMMAC_TXBUF_T_XSK_TX?
>>
>> +1. I'm assuming Serge isn't enabling it explicitly, so none of the
>> metadata stuff should trigger in this case.
>
> The only other user of xsk_tx_metadata_complete() in mlx5 guards it with
> xp_tx_metadata_enabled(). Seems like that's missing in stmmac?

Well, the following patch seems to help:

commit e85ab4b97b4d6e50036435ac9851b876c221f580
Author: Kurt Kanzenbach <kurt@linutronix.de>
Date:   Wed Feb 21 08:18:15 2024 +0100

    net: stmmac: Complete meta data only when enabled
=20=20=20=20
    Currently using XDP sockets on stmmac results in a kernel crash:
=20=20=20=20
    |[  255.822584] Unable to handle kernel NULL pointer dereference at vir=
tual address 0000000000000000
    |[...]
    |[  255.822764] Call trace:
    |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
=20=20=20=20
    The program counter indicates xsk_tx_metadata_complete(). However, this
    function shouldn't be called unless metadata is actually enabled.
=20=20=20=20
    Tested on imx93.
=20=20=20=20
    Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
    Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 9df27f03a8cb..77c62b26342d 100644
=2D-- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2678,9 +2678,10 @@ static int stmmac_tx_clean(struct stmmac_priv *priv,=
 int budget, u32 queue,
                                        .desc =3D p,
                                };
=20
=2D                               xsk_tx_metadata_complete(&tx_q->tx_skbuff=
_dma[entry].xsk_meta,
=2D                                                        &stmmac_xsk_tx_m=
etadata_ops,
=2D                                                        &tx_compl);
+                               if (xp_tx_metadata_enabled(tx_q->xsk_pool))
+                                       xsk_tx_metadata_complete(&tx_q->tx_=
skbuff_dma[entry].xsk_meta,
+                                                                &stmmac_xs=
k_tx_metadata_ops,
+                                                                &tx_compl);
                        }
                }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXVwIATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgrKnD/4n4gidibhtrNPaXhF5lvWJ+BWLPVID
48yRBRAzmEQKzr8A3ODzNep3YwYd1G4iT15TDxgQSY3ZwExGXYqHI9YtjT180kCu
htDrZID8enz9c5Oj/ojJqu7BUZHmQ29bPKkymFYVV6U0MMxRwRiq4A/VHABk06FB
7hcvTdxuG6QX+Vw6fWpMWDJg+2M3tFDEllJ7T0S4kVdbHLqTxJguSyyNBzHlRVTb
Ogl6zTeaAZi06F6SjXP6j4SJLB2YQdz9XTq4h/8a2cWPs91t22AsYmVtTnX5vlku
AoKWm6Uil0uJ+x7Ujf21IOx796k6i/IXriYysPEWldtCOgTFg0BCAJcwv1097azk
WTRyG4jGgd90FCsnpdglqhxPt1iwVbp/jvpWaE0u8lPas4wuvkFrdZgoQ8/O6X5h
jh/q9paV1QsBdq2sPCHBXrGbZaSzL95piY1GM8+AoKxWYHQrgMnp16wgrxW5S1g2
CHN+geSz6IyQfFfPoRbkMUKrH4wMvC9qC7hapAUol1Z4Lbw/MfRyhjWt+qILcso6
SF4Uh+abY4iHutOVJTsj3zk7opWLEnRquLrqrKKeOwgJOvMUVllduqF7FjmUZQLi
vYmZAXBRjE4uwF8rGYxbr6gdwxULHUfmS4edW09rRgL/+eT6IJXEYv9jOzLpg01u
Pb7amQ0/lel4Eg==
=arm0
-----END PGP SIGNATURE-----
--=-=-=--

