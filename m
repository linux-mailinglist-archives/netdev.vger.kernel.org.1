Return-Path: <netdev+bounces-73255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E185B9D5
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B259B215CE
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5C657D5;
	Tue, 20 Feb 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nw8JFBBG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4Fn/9Xj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA5604A9
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426949; cv=none; b=hDGGqt3CAn2+eiYgH2g3u6NECOtuv+tlhzt5v97KxDqsc8UwmTT2wgUPOwIEqXnA1WT9Gnsh5bHmFl/AdPy1rIBbyll/UvlUftVo5kGf+UFW+C/9r13E0LDSCzJ1MROpmmv9HBIWHv7bpxoKEvD9usu376XhX5d9OtaWdEdAPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426949; c=relaxed/simple;
	bh=kE2sHx9Nn4khvh4mpCXPzjp55iheh3+ObEEcfaZ/i/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f5rFimhDmWvONuJupE4EEOEoig4+xTlI6HcBZkfYo6LSpSsQveGesGG07l2J6M2S4TL9kyxkH64a5wIdVRQ8NRR/Qx37HVrTbsrmHaPJABDJsk/ynLmSM71KBpQGJ0d7ZGVIr30qEJHmAPK+ktpPrhc9L0BWFZRKKjWPZNdginw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nw8JFBBG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4Fn/9Xj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708426946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=befm6GpEEjbO02wzhPC5PhEe99aKTuQuGM4LCIZPYhE=;
	b=nw8JFBBGXAjqwxT/g5V+dw9kt0pvghSB6CEMykCYqj0MhZgIVjVAXgDyrSq3o+VbcgiP5D
	HDjw+1zDS6RoJtHhIChTzL835h4bdz93hc7bhEXHBTvR/AWIWNwDlh2zPJg3SNOkDb9x2K
	C3pmxh2/r8AHnG7EXf7e9Xreptx34mojrQG4uaaaMqFNoOAgT4Th5q92XcNlh2eYbJW13r
	UKxTIn5ZfmAR3ULeND0yGZTeyQqi9CU9Up/0TIVEdggawUGy/no9TIff5XrfSg1b22ozAe
	nC2ru5rTq6p3/3lu95m1wgQ0+sD7bBB1MJ3AqhwyReRg+R8wmR1vwrfKyBkevA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708426946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=befm6GpEEjbO02wzhPC5PhEe99aKTuQuGM4LCIZPYhE=;
	b=T4Fn/9XjDPlLUgFinAg0MuWD30iE79kiwZQOd6Y9yFkBBlYGHCJiskv0M2tmoKmzjXegRe
	OYd89014oVbbk/CQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang
 <yoong.siang.song@intel.com>
Subject: stmmac and XDP/ZC issue
Date: Tue, 20 Feb 2024 12:02:25 +0100
Message-ID: <87r0h7wg8u.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello netdev community,

after updating to v6.8 kernel I've encountered an issue in the stmmac
driver.

I have an application which makes use of XDP zero-copy sockets. It works
on v6.7. On v6.8 it results in the stack trace shown below. The program
counter points to:

 - ./include/net/xdp_sock.h:192 and
 - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681

It seems to be caused by the XDP meta data patches. This one in
particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC").

To reproduce:

 - Hardware: imx93
 - Run ptp4l/phc2sys
 - Configure Qbv, Rx steering, NAPI threading
 - Run my application using XDP/ZC on queue 1

Any idea what might be the issue here?

Thanks,
Kurt

Stack trace:

|[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
|[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switch=
ed
|[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous mode
|[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_PO=
OL RxQ-0
|[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_PO=
OL RxQ-1
|[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_XSK_BUF=
F_POOL RxQ-1
|[  255.822584] Unable to handle kernel NULL pointer dereference at virtual=
 address 0000000000000000
|[  255.822602] Mem abort info:
|[  255.822604]   ESR =3D 0x0000000096000044
|[  255.822608]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
|[  255.822613]   SET =3D 0, FnV =3D 0
|[  255.822616]   EA =3D 0, S1PTW =3D 0
|[  255.822618]   FSC =3D 0x04: level 0 translation fault
|[  255.822622] Data abort info:
|[  255.822624]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
|[  255.822627]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
|[  255.822630]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
|[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000085fe1000
|[  255.822638] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000=
000000
|[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
|[  255.822655] Modules linked in:
|[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0-rc4-r=
t4-00100-g9c63d995ca19 #8
|[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
|[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
|[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
|[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
|[  255.822696] sp : ffff800085ec3bc0
|[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000000000=
000001
|[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000000000=
000001
|[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000000000=
000000
|[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000000000=
000000
|[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000000000=
000008
|[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000000000=
008507
|[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff800080=
e32f84
|[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000=
003ff0
|[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000000000=
000000
|[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000=
000000
|[  255.822764] Call trace:
|[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
|[  255.822772]  stmmac_napi_poll_rxtx+0xc4/0xec0
|[  255.822778]  __napi_poll.constprop.0+0x40/0x220
|[  255.822785]  napi_threaded_poll+0xd8/0x228
|[  255.822790]  kthread+0x108/0x120
|[  255.822798]  ret_from_fork+0x10/0x20
|[  255.822808] Code: 910303e0 f9003be1 97ffdec0 f9403be1 (f9000020)=20
|[  255.822812] ---[ end trace 0000000000000000 ]---
|[  255.822817] Kernel panic - not syncing: Oops: Fatal exception in interr=
upt
|[  255.822819] SMP: stopping secondary CPUs
|[  255.822827] Kernel Offset: disabled
|[  255.822829] CPU features: 0x0,c0000000,4002814a,2100720b
|[  255.822834] Memory Limit: none
|[  256.062429] ---[ end Kernel panic - not syncing: Oops: Fatal exception =
in interrupt ]---

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXUhsETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgjD3EACaTqzoeCfhIAdAevDKoF6QmHccBOpa
RwjmypRGcgeJfDIeDK5nGTxM22C5NlRaLedx2Dy0PuuD7j/b6D6YWpx5hhXR93V7
c3utFsvcLWXDDNA+4ON0QoAd/8RI8hVjNKxDssPRJoknyO5zQbnsgMPrKYCTpAFo
Jidi/ZPtZjJX3hmg5yM6aUsqu+hJ+MLv6jgVGhJFmCXHkzmMXqzcHzCPrSB1jLpc
CFdHkwt9WYexC9gM8l0xSl/VocVq4Nd8bKE1Vp/1GCi7EkjpYoVDQG7MKLKLKpGu
VCOULslAMb97BwSBesscLMsIbYQfNhxmrSOHiKxYBMciK4PNjN8/gxQ4s4RdxnrH
SUT6+3daooDMRciWaNqTDQDXFQzJhmfBDGJrg6cbTrq3XClgQRFYVNjh1cU1rj/G
Osie9vTP7sB57GZ0cR1Ku4jHMkitbFWCiwm85u5N2lTbtVqZk4kXxYPkl4Cy/QDH
PLXQishkOnk6ifMoDYmPmdqP6hAyJULRQxj/tIRuZQByH/ruitmT7jj1ZiVHiIGJ
sNng2zOugz3Uf27/yJh6s/xWM9AZdzgeSHBZkdSkmqwIMli31vxbDCRt0gjWpNe7
1fVzGMWR1Nr2LB43cSdF1HweuCJy0gImdDXCotULWm+v9y8Rl39N/2A0ZQhW6Qt1
l/zxhSPqyvleew==
=4rvK
-----END PGP SIGNATURE-----
--=-=-=--

