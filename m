Return-Path: <netdev+bounces-73061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A698C85AC29
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2761F225DE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1550243;
	Mon, 19 Feb 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="udnPWUsm"
X-Original-To: netdev@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917F25566
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371869; cv=none; b=G15Um8VkiWTR4ogKHRhIdV7Fr0Jah/IcKfbV1T8fBPNhgfz2OzwNU+x1LUXlnaVqP9ZR8QGJ90cadO5R/xGj/kh21ozh1VJar38Oc7yWZiludafTv/9wbr/PMRfqcByONNlHHelcmEFHjnYP71gt+VAmnVyNn201piEJ4AG91bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371869; c=relaxed/simple;
	bh=8F6ZOuD/Kd8ZODuV78qJwsVxjr7qNpIbG648aICGmjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpsQkXl84A310HqFGFoDotSCNDgtr40ZgyofoBtTpEoC7V+5CSSXXCDl/tToooA2HluMA5ibmqEd+4FOc397fRp3qbwoXJ3ap4qQBc3fOA+Ris9+BqTn7VSk6unOaDM7SvB3fgoqOXVPPl0Jn02fdNwmE/J4giKloQVPvWtOCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=udnPWUsm; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 949821AF217;
	Mon, 19 Feb 2024 20:44:22 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708371862; bh=DV2eIkqKdx96gI5d5Xj/fMfxg5yIdnHo5qXtnZzAgao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udnPWUsmkW5NqyXWSRgI6VvrWwj5W0X1O0oxYCMaK9l5Xzb9fGxnUqFIGII5krzlZ
	 QSdsYbg/kTUJxRRI+YZ3ZLVvsUVvVZaEjeczdS7EpHOFyO+JCREdElsw0+KXqktmDB
	 4NJHPqAm02tip7zxY28HwIRDPRttzpIUcqTstaRKaJcBdnCifyNOxbAM91Z6JN3+73
	 CjFWh2p+OAz47HqE4EK0iZUs5Uc+XF/ZLDhRJ5NVkfsko9BRCrbXIMajPRZngjmYZA
	 +ZwCcMvaa7HU+uFFN2Icgpdd/I3lbe+NwR/SJQ07rVwv6EMamYlSpe6MZc0gESpaoM
	 OQhO8Ppu2dT2w==
Date: Mon, 19 Feb 2024 20:44:21 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christian Stewart <christian@aperture.us>
Cc: Marc Haber <mh+netdev@zugschlus.de>, Florian Fainelli
 <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <20240219204421.2f6019c1@meshulam.tesarici.cz>
In-Reply-To: <CA+h8R2okfaYn-=toQPCkQUEZ6oLuwfjZ0ZZ-zRiN9A2fBFmzHQ@mail.gmail.com>
References: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
	<ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
	<229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
	<99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
	<20240126085122.21e0a8a2@meshulam.tesarici.cz>
	<ZbOPXAFfWujlk20q@torres.zugschlus.de>
	<20240126121028.2463aa68@meshulam.tesarici.cz>
	<ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
	<0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com>
	<20240206092351.59b10030@meshulam.tesarici.cz>
	<ZcoL0MseDC69s2_P@torres.zugschlus.de>
	<CA+h8R2okfaYn-=toQPCkQUEZ6oLuwfjZ0ZZ-zRiN9A2fBFmzHQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 11:20:35 -0800
Christian Stewart <christian@aperture.us> wrote:

> Hi all,
>=20
> On Mon, Feb 12, 2024 at 4:15=E2=80=AFAM Marc Haber <mh+netdev@zugschlus.d=
e> wrote:
> >
> > On Tue, Feb 06, 2024 at 09:23:51AM +0100, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
> > > On Mon, 5 Feb 2024 13:50:35 -0800
> > > Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > =20
> > > > On 2/5/24 12:12, Marc Haber wrote: =20
> > > > > On Fri, Jan 26, 2024 at 12:10:28PM +0100, Petr Tesa=C5=99=C3=ADk =
wrote: =20
> > > > >> Then you may want to start by verifying that it is indeed the sa=
me
> > > > >> issue. Try the linked patch. =20
> > > > >
> > > > > The linked patch seemed to help for 6.7.2, the test machine ran f=
or five
> > > > > days without problems. After going to unpatched 6.7.2, the issue =
was
> > > > > back in six hours. =20
> > > >
> > > > Do you mind responding to Petr's patch with a Tested-by? Thanks! =20
> > >
> > > I believe Marc tested my first attempt at a solution (the one with
> > > spinlocks), not the latest incarnation. FWIW I have tested a similar
> > > scenario, with similar results. =20
> >
> > Where is the latest patch? I can give it a try.
> >
> > Sorry for not responding any earlier, February 10 is an important tax
> > due date in Germany.
> >
> > Greetings
> > Marc =20
>=20
> We are seeing the same kernel panic on shutdown with 6.7.4 on a
> BananaPi M2 Ultra:
>=20
> [**    ] (3 of 3) A stop job is running for Network Manager (33s / 52s)
> [  259.463772] rcu: INFO: rcu_sched self-detected stall on CPU
> [  259.469388] rcu:     0-....: (2099 ticks this GP)
> idle=3D0fdc/1/0x40000002 softirq=3D12003/12003 fqs=3D1034
> [  259.478360] rcu:     (t=3D2100 jiffies g=3D16277 q=3D36 ncpus=3D4)
> [  259.483595] CPU: 0 PID: 4462 Comm: ip Tainted: G         C         6.7=
.4 #1
> [  259.490562] Hardware name: Allwinner sun8i Family
> [  259.495268] PC is at stmmac_get_stats64+0x30/0x198
> [  259.500081] LR is at dev_get_stats+0x3c/0x160
> [  259.504445] pc : [<c06b9924>]    lr : [<c07bf7a8>]    psr: 200f0013
> [  259.510712] sp : f1e6d9b8  ip : c3ca478c  fp : c23e0000
> [  259.515941] r10: 00000000  r9 : c3ca4598  r8 : 00000000
> [  259.521168] r7 : 00000001  r6 : 00000000  r5 : c23e3000  r4 : 00000001
> [  259.527697] r3 : 00005c1b  r2 : c23e2e08  r1 : c3ca46c4  r0 : c23e0000
> [  259.534226] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [  259.541363] Control: 10c5387d  Table: 429cc06a  DAC: 00000051
> [  259.547117]  stmmac_get_stats64 from dev_get_stats+0x3c/0x160
> [  259.552882]  dev_get_stats from rtnl_fill_stats+0x30/0x118
> [  259.552899]  rtnl_fill_stats from rtnl_fill_ifinfo+0x720/0x135c
> [  259.564306]  rtnl_fill_ifinfo from rtnl_dump_ifinfo+0x330/0x6a8
> [  259.570240]  rtnl_dump_ifinfo from netlink_dump+0x16c/0x350
> [  259.575830]  netlink_dump from __netlink_dump_start+0x1bc/0x280
> [  259.581766]  __netlink_dump_start from rtnetlink_rcv_msg+0xf4/0x2f0
> [  259.588047]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb8/0x118
> [  259.593893]  netlink_rcv_skb from netlink_unicast+0x1fc/0x2d8
> [  259.599655]  netlink_unicast from netlink_sendmsg+0x1c8/0x440
> [  259.605416]  netlink_sendmsg from sock_write_iter+0xa0/0x10c
> [  259.611094]  sock_write_iter from vfs_write+0x338/0x398
> [  259.616334]  vfs_write from ksys_write+0xbc/0xf0
> [  259.620961]  ksys_write from ret_fast_syscall+0x0/0x54
> [  259.626110] Exception stack(0xf1e6dfa8 to 0xf1e6dff0)
> [  259.631169] dfa0:                   00000003 be997dd8 00000003
> be997dd8 00000014 00000001
> [  259.639351] dfc0: 00000003 be997dd8 00000014 00000004 00519548
> be997e08 b6fd0ce0 0051783c
>=20
> https://github.com/skiffos/SkiffOS/issues/307
>=20
> I'm writing to ask if anyone has found a fix for this yet?

If you're running a 6.7 stable kernel, my patch has just been added to
the 6.7-stable tree.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.7/net-stmmac-protect-updates-of-64-bit-statistics-counters.patch

However, lockdep has reported an issue with it:

https://lore.kernel.org/lkml/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.=
net/

This new report has not yet been properly understood, but FWIW I've
been running stable with my patch for over a month now.

Petr T

