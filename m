Return-Path: <netdev+bounces-73902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C585F30F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757541F263B8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D417BB7;
	Thu, 22 Feb 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAQGwwlY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HsUn3B1m"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E517998
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590909; cv=none; b=s6KrBAaE6YXlrQbEThcqcs9+VBK3BP6xJyNqimZp5pgt9Pb+BWzcXsUk3GK1Cm7hB4cFHuj5N1QovIgXfXX+pn1kkPodt37UC3u53Wb88+7XToltoiowJk0ckKRLGLO4G5Fik9O2qd4KEUWZjtW2NkE1DUFMw8WrT5/pcWGxLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590909; c=relaxed/simple;
	bh=r8Kerpg/FD+F24xaoib3TvxTwZoM9Vf4SMSpY2WHa4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W/ugnSN5su1UNHw/GWH8pBdlNs6MGVXPVPaLIj4XKL9v6kqrHOLH+FRauRpbgBKks5hjPXA0Akh8vEMj0fEAoPnN0AAXwhE36Er+6UO2BOfRDW73tReqPZX/fqV4wBDZs7YoqXWDPvnYthKKjcQwEG3kUSCElGHnvDwthUZ+9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAQGwwlY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HsUn3B1m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708590904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Npl9mOX95bj5LvCyYAPnC/SPz1CvWOixSiLh74Y1gC0=;
	b=sAQGwwlYnI/khPTvnuuBVMjXhb/coVuEoS54SogI0YRTHoP+OIjqne9b3AN+UbFBrk/c4/
	DlLKZiPg4xYqztfs64t300SualyNQdgSP1DP54qZLxrGsBBhJ0Bkk/O4m5KcOtp7dEHZIS
	U/0uvON5QrBYzt/ZYUW7FAIxtbjIwkis8gFDf1PAKDC15ptHGyPKU5P1i9ozL44Mqh8ne4
	PTS9tEOMJW0+XCqISS8H8jxJi7V5Yz2+S3drDcPVohRWjTMHVrysB4C3LpLKtN8u1u1Nup
	Mm1bhq1hRTnKLqsESrr3CM+DwSWljz+I8UoKyhZ+fckJ7uad4fLqtv8mBAk+wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708590904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Npl9mOX95bj5LvCyYAPnC/SPz1CvWOixSiLh74Y1gC0=;
	b=HsUn3B1minr+6EOCVT3ih+tzD8PC/eR3LclEuao9IV0YDFNrryiqh6/tOgoyErUNY6H2Gb
	3QsRRousYwdFM4Ag==
To: Serge Semin <fancer.lancer@gmail.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
In-Reply-To: <6h4rap3pi5v2qnq2goy63sanf7ygzosh3uikjlf6zgygt3rrcc@lyex4jslf5tf>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
 <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
 <87ttm25lxw.fsf@kurt.kurt.home> <87le7e5g1r.fsf@kurt.kurt.home>
 <ZdYdzmvDSrdz03mb@boxer>
 <6h4rap3pi5v2qnq2goy63sanf7ygzosh3uikjlf6zgygt3rrcc@lyex4jslf5tf>
Date: Thu, 22 Feb 2024 09:35:02 +0100
Message-ID: <874je0c2x5.fsf@kurt.kurt.home>
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

On Wed Feb 21 2024, Serge Semin wrote:
> On Wed, Feb 21, 2024 at 04:59:10PM +0100, Maciej Fijalkowski wrote:
>> On Wed, Feb 21, 2024 at 10:21:04AM +0100, Kurt Kanzenbach wrote:
>> > On Wed Feb 21 2024, Kurt Kanzenbach wrote:
>> > > On Tue Feb 20 2024, Stanislav Fomichev wrote:
>> > >> On Tue, Feb 20, 2024 at 6:43=E2=80=AFAM Maciej Fijalkowski
>> > >> <maciej.fijalkowski@intel.com> wrote:
>> > >>>
>> > >>> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
>> > >>> > Hi Kurt
>> > >>> >
>> > >>> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
>> > >>> > > Hello netdev community,
>> > >>> > >
>> > >>> > > after updating to v6.8 kernel I've encountered an issue in the=
 stmmac
>> > >>> > > driver.
>> > >>> > >
>> > >>> > > I have an application which makes use of XDP zero-copy sockets=
. It works
>> > >>> > > on v6.7. On v6.8 it results in the stack trace shown below. Th=
e program
>> > >>> > > counter points to:
>> > >>> > >
>> > >>> > >  - ./include/net/xdp_sock.h:192 and
>> > >>> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
>> > >>> > >
>> > >>> > > It seems to be caused by the XDP meta data patches. This one in
>> > >>> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to =
XDP ZC").
>> > >>> > >
>> > >>> > > To reproduce:
>> > >>> > >
>> > >>> > >  - Hardware: imx93
>> > >>> > >  - Run ptp4l/phc2sys
>> > >>> > >  - Configure Qbv, Rx steering, NAPI threading
>> > >>> > >  - Run my application using XDP/ZC on queue 1
>> > >>> > >
>> > >>> > > Any idea what might be the issue here?
>> > >>> > >
>> > >>> > > Thanks,
>> > >>> > > Kurt
>> > >>> > >
>> > >>> > > Stack trace:
>> > >>> > >
>> > >>> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured E=
ST
>> > >>> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL ha=
s been switched
>> > >>> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered prom=
iscuous mode
>> > >>> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM=
_TYPE_PAGE_POOL RxQ-0
>> > >>> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM=
_TYPE_PAGE_POOL RxQ-1
>> > >>> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM=
_TYPE_XSK_BUFF_POOL RxQ-1
>> > >>> > > |[  255.822584] Unable to handle kernel NULL pointer dereferen=
ce at virtual address 0000000000000000
>> > >>> > > |[  255.822602] Mem abort info:
>> > >>> > > |[  255.822604]   ESR =3D 0x0000000096000044
>> > >>> > > |[  255.822608]   EC =3D 0x25: DABT (current EL), IL =3D 32 bi=
ts
>> > >>> > > |[  255.822613]   SET =3D 0, FnV =3D 0
>> > >>> > > |[  255.822616]   EA =3D 0, S1PTW =3D 0
>> > >>> > > |[  255.822618]   FSC =3D 0x04: level 0 translation fault
>> > >>> > > |[  255.822622] Data abort info:
>> > >>> > > |[  255.822624]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00=
000000
>> > >>> > > |[  255.822627]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =
=3D 0
>> > >>> > > |[  255.822630]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs=
 =3D 0
>> > >>> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000=
0000085fe1000
>> > >>> > > |[  255.822638] [0000000000000000] pgd=3D0000000000000000, p4d=
=3D0000000000000000
>> > >>> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PR=
EEMPT_RT SMP
>> > >>> > > |[  255.822655] Modules linked in:
>> > >>> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainte=
d 6.8.0-rc4-rt4-00100-g9c63d995ca19 #8
>> > >>> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
>> > >>> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DI=
T -SSBS BTYPE=3D--)
>> > >>> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
>> > >>> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
>> > >>> > > |[  255.822696] sp : ffff800085ec3bc0
>> > >>> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x2=
7: 0000000000000001
>> > >>> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x2=
4: 0000000000000001
>> > >>> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x2=
1: 0000000000000000
>> > >>> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x1=
8: 0000000000000000
>> > >>> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x1=
5: 0000000000000008
>> > >>> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x1=
2: 0000000000008507
>> > >>> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9=
 : ffff800080e32f84
>> > >>> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6=
 : 0000000000003ff0
>> > >>> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3=
 : 0000000000000000
>> > >>> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0=
 : 0000000000000000
>> > >>> > > |[  255.822764] Call trace:
>> > >>> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>> > >>>
>> > >>> Shouldn't xsk_tx_metadata_complete() be called only when correspon=
ding
>> > >>> buf_type is STMMAC_TXBUF_T_XSK_TX?
>> > >>
>> > >> +1. I'm assuming Serge isn't enabling it explicitly, so none of the
>> > >> metadata stuff should trigger in this case.
>> > >
>> > > The only other user of xsk_tx_metadata_complete() in mlx5 guards it =
with
>> > > xp_tx_metadata_enabled(). Seems like that's missing in stmmac?
>> >=20
>> > Well, the following patch seems to help:
>> >=20
>> > commit e85ab4b97b4d6e50036435ac9851b876c221f580
>> > Author: Kurt Kanzenbach <kurt@linutronix.de>
>> > Date:   Wed Feb 21 08:18:15 2024 +0100
>> >=20
>> >     net: stmmac: Complete meta data only when enabled
>> >=20=20=20=20=20
>> >     Currently using XDP sockets on stmmac results in a kernel crash:
>> >=20=20=20=20=20
>> >     |[  255.822584] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000000000000000
>> >     |[...]
>> >     |[  255.822764] Call trace:
>> >     |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
>> >=20=20=20=20=20
>> >     The program counter indicates xsk_tx_metadata_complete(). However,=
 this
>> >     function shouldn't be called unless metadata is actually enabled.
>> >=20=20=20=20=20
>> >     Tested on imx93.
>> >=20=20=20=20=20
>> >     Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
>> >     Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> >=20
>> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > index 9df27f03a8cb..77c62b26342d 100644
>> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > @@ -2678,9 +2678,10 @@ static int stmmac_tx_clean(struct stmmac_priv *=
priv, int budget, u32 queue,
>> >                                         .desc =3D p,
>> >                                 };
>> >=20=20
>> > -                               xsk_tx_metadata_complete(&tx_q->tx_skb=
uff_dma[entry].xsk_meta,
>> > -                                                        &stmmac_xsk_t=
x_metadata_ops,
>> > -                                                        &tx_compl);
>> > +                               if (xp_tx_metadata_enabled(tx_q->xsk_p=
ool))
>>=20
>
>> every other usage of tx metadata functions should be wrapped with
>> xp_tx_metadata_enabled() - can you address other places and send a proper
>> patch?
>
> AFAICS this is the only place. But the change above still isn't enough
> to fix the problem. In my case XDP zero-copy isn't activated. So
> xsk_pool isn't allocated and the NULL/~NULL dereference is still
> persistent due to xp_tx_metadata_enabled() dereferencing the
> NULL-structure fields. The attached patched fixes the problem in my
> case.

Sure about that? In my case without ZC the else path is not executed,
because skb is set.

>
> Kurt, are you sure that xp_tx_metadata_enabled() is required in your
> case?

Yes, I'm sure it's required, because I do use ZC without using any
metadata.

> Could you test the attached patch with the xp_tx_metadata_enabled()
> invocation discarded?

Well, it works. But, the xp_tx_metadata_enabled() is not discarded in
the ZC case:

|RtcRxThread-790     [001] b...3   202.970243: stmmac_tx_clean.constprop.0:=
 huhu from xp_tx_metadata_enabled

Let's go with your version of the patch. It works without XDP, with XDP
and XDP/ZC. I'll send it upstream.

Thanks for the help :).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXXBzYTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgs8+D/9ioHZFZh0p6FAD6APEo0WXBS3zU5TY
A8PzaIDGMMvsjeFrl4m8PCg3HqiKzWfdNSh6gp05ALvSYhzAVlV01hb+o0gMGBLa
iDbDDTQkD2DYpX72AtAd6XgRoDTNWUnQRrmCq6bzWUpwWLrAV6aWNAOxa3KhUz19
S5EWj11nO9kPSjdONGCIHCtzlFVh3Dwepm2tM98sW5ZdV3WM/ibnBuheMGApgM2U
Y6wpyc/f3fa8kUXsDGZk8RZBcSOPoV0MsdLrIgzkMErm0hz0COM1A+Cwl574m+rH
rV46Ep1/x1SrjiQA4b11I7T6I2D+sfoLsp9VgFBzQbPeudKV8ewM5flvu8EVIq8j
yGXaM0NtTT+W3yaNOmvxxeRHzNGQrlr74jICPh3pGOPDZg4SrBn1P5sHFRpJ9XC1
uOtRRkOJSokS/6+pMtV7UwYCfo7VB0xmTGFaiA7tSq6DFi6ssGjN99mT5VVVHmOK
qbA9IRIb1q0ngY2C3eX56BBzlIRYpoQbl5ooG/PQ1gnEIJOkBO1vAekzS8ijDZew
E9rTilagwJTe7w3+kM/daqNTOHagvr2sHtfMyFCiTXYmGNBDLv/Iyn+EyZiaHIoV
D4BQRSLtFgLDOg54NOsu6hPP+MYDFnMt1cRZw94b6Hl93vP50fohg4boS22i70ok
8WR2fAisp4lZjg==
=yEBn
-----END PGP SIGNATURE-----
--=-=-=--

