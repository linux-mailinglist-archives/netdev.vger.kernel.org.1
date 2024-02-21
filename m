Return-Path: <netdev+bounces-73558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7B85D106
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 08:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9E31C2228A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 07:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411C13A8D8;
	Wed, 21 Feb 2024 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SJYYSDnV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e25tMU+J"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA43A292
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499633; cv=none; b=N4zaSzhC6gQMn2rFK998eboHmt2dtAEAVJ0ToN9wcj1MLXV796goN2xLufrzVYC1ABKCwBCbBG8vmY4dgzlWuRXf3oyDLx4HUoxWSL+Vo+q3DdiUkCu048gm1LhVuvPCkJ5pH77KY8TLeiqZHOD6j5HzcStCFiYGRIDabPFn9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499633; c=relaxed/simple;
	bh=V6OAAh8E3hWBEVCNm+YVeTHl0XUS7Eqw/f5BMcSLOmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dh/6N2xfvd3QPVtIW2lSbEhdYbzzJYpvHm3uzKuNWmimBbkynSvb5AGcMosfq+6U1quMI/1TO5RU7Rd9l5mrHkf0ePZiy/dB6NlL3FwngknlsQ8XzYwEevVe287lg5n8VDSA3m3gFRVBxAOKVApoGUDv2KWx6a1oZH/Wexeiz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SJYYSDnV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e25tMU+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708499628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K/yVmx8E5CijuRxL13UstFMZnoj0im2T78P0TqUZOZE=;
	b=SJYYSDnVoNYNb7IQ97RAdlmPh9pN/8H0nM460Md0OsKxQ5RUWKzI8diqnvlzYLHooSBPoU
	TOZr6rEN0BLsie4dJVOwU7MH25pJVA1F8FgnEPXcggEZgF9MyEFx5w5609t4DwsFLRgL6X
	dq8TwzHdyaIVQlsiBvR/GzBCKVI820jDWyNoUthUp2NNgKpE1BGuBtIw7tiH6tX/PZ1g3z
	5MWjy51NWr7V3/Zhq952iaXWe1psO/MK2ewbJoJQt0LowGFZ62Sebtm/MeezTUZvpwCANQ
	5OIGlUK4AGzwj0KusOLskC4VvA2se8JG5E1NWFVhdeCFhJNVM9sTzfIZX0bL5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708499628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K/yVmx8E5CijuRxL13UstFMZnoj0im2T78P0TqUZOZE=;
	b=e25tMU+J1lJV+KsT3Y5rkEztmzWb0A3o0Pk4nEB5OSHjhb6q3ZwMxlHSXRPED6gfvhB9cl
	VeyJSaLAwHQsFCAQ==
To: Stanislav Fomichev <sdf@google.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
In-Reply-To: <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
 <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
Date: Wed, 21 Feb 2024 08:13:47 +0100
Message-ID: <87ttm25lxw.fsf@kurt.kurt.home>
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

On Tue Feb 20 2024, Stanislav Fomichev wrote:
> On Tue, Feb 20, 2024 at 6:43=E2=80=AFAM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
>>
>> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
>> > Hi Kurt
>> >
>> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
>> > > Hello netdev community,
>> > >
>> > > after updating to v6.8 kernel I've encountered an issue in the stmmac
>> > > driver.
>> > >
>> > > I have an application which makes use of XDP zero-copy sockets. It w=
orks
>> > > on v6.7. On v6.8 it results in the stack trace shown below. The prog=
ram
>> > > counter points to:
>> > >
>> > >  - ./include/net/xdp_sock.h:192 and
>> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
>> > >
>> > > It seems to be caused by the XDP meta data patches. This one in
>> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC=
").
>> > >
>> > > To reproduce:
>> > >
>> > >  - Hardware: imx93
>> > >  - Run ptp4l/phc2sys
>> > >  - Configure Qbv, Rx steering, NAPI threading
>> > >  - Run my application using XDP/ZC on queue 1
>> > >
>> > > Any idea what might be the issue here?
>> > >
>> > > Thanks,
>> > > Kurt
>> > >
>> > > Stack trace:
>> > >
>> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
>> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been=
 switched
>> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuou=
s mode
>> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_=
PAGE_POOL RxQ-0
>> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_=
PAGE_POOL RxQ-1
>> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_=
XSK_BUFF_POOL RxQ-1
>> > > |[  255.822584] Unable to handle kernel NULL pointer dereference at =
virtual address 0000000000000000
>> > > |[  255.822602] Mem abort info:
>> > > |[  255.822604]   ESR =3D 0x0000000096000044
>> > > |[  255.822608]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> > > |[  255.822613]   SET =3D 0, FnV =3D 0
>> > > |[  255.822616]   EA =3D 0, S1PTW =3D 0
>> > > |[  255.822618]   FSC =3D 0x04: level 0 translation fault
>> > > |[  255.822622] Data abort info:
>> > > |[  255.822624]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
>> > > |[  255.822627]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
>> > > |[  255.822630]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000008=
5fe1000
>> > > |[  255.822638] [0000000000000000] pgd=3D0000000000000000, p4d=3D000=
0000000000000
>> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_=
RT SMP
>> > > |[  255.822655] Modules linked in:
>> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.=
0-rc4-rt4-00100-g9c63d995ca19 #8
>> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
>> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
>> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
>> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
>> > > |[  255.822696] sp : ffff800085ec3bc0
>> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 000=
0000000000001
>> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 000=
0000000000001
>> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 000=
0000000000000
>> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 000=
0000000000000
>> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 000=
0000000000008
>> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 000=
0000000008507
>> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : fff=
f800080e32f84
>> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000=
0000000003ff0
>> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 000=
0000000000000
>> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000=
0000000000000
>> > > |[  255.822764] Call trace:
>> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>>
>> Shouldn't xsk_tx_metadata_complete() be called only when corresponding
>> buf_type is STMMAC_TXBUF_T_XSK_TX?
>
> +1. I'm assuming Serge isn't enabling it explicitly, so none of the
> metadata stuff should trigger in this case.

The only other user of xsk_tx_metadata_complete() in mlx5 guards it with
xp_tx_metadata_enabled(). Seems like that's missing in stmmac?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXVoqsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgqgAEACZV1hcTE285nj/3KoZLbDuDoTGKEdw
lIksYCBg+QJxWev+FzwUmNdE+a9aZEWxEuzws0/jK84kGzcZ1uVVDaQdfDs1eSiN
F7GOQ+Lh599bBceg89UZUrfuyxzOoZICsQ5lRi6Lw5G0REA7KxDdOxpIJEwBAGUr
3huLvtNYVLBc08qfpKt/hcoecIdTdCPELFJ3ZFzvLs9hNvJ0oObyq2gsw95uUt3Z
anSXwuOgDQb7/pTK6+8dpfpOvRzycgomxZkR+GFLCh4nveU3T7C6NojmO091FmD3
FrliI0G/ZYRCjIKKBeX1OFZgkAGpKzNOPtHnqeiJsUcvoaENtPOlXJ6Fee6Ij3Tl
5SM4FctGLkJPkwYI4C9qNkvd8hIvXUNaOFyCf7EPW0zOuKBzR5APp2cBdqwVWzof
pxHhDXDvRdKjfxa6/d+eKsVxr9ASAYDFjC7PbiQO7rjobozKpGUThsNn8MPVv3zc
+wElQROuFltBJBt2+7vNOI04e2cXYJPg3eMCtCfpyhgpnWdKDEZUOQk0LtuUV4d7
6TdMB0QMsobOW1mPDaOUDtT8GKvyaQHgjcqsQ4DecLYK42QpP2miDQyOeUeA7i84
+vo/6csCiIjz3e1js4i5WxJ2h+q2ke2TveFYzrJGTMkfoNFKnqtThT3qiezsRvWj
y13vP4BGu5F3xw==
=Y0hi
-----END PGP SIGNATURE-----
--=-=-=--

