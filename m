Return-Path: <netdev+bounces-186467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F419FA9F41F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507DA1736E2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035B2797A1;
	Mon, 28 Apr 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Io0LMtRH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LhO1FVHA"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C226FA53;
	Mon, 28 Apr 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853047; cv=none; b=NcPl10tFhuxE7V0JviL4ARVzlfE2nDUvPXSRbgrAHKBDsSR1CbHai70qA4LWlILW0fVzNHwjD2NFuGZN4cvmx7ZL5WJl5B640Jysn7pYKCmGsp0G/DlJYhtSKp/+jE0AjvNJSg4oofAMzslHMtDBLi0CkG2ROx58rE4hZ4yC8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853047; c=relaxed/simple;
	bh=3Id4jfGAbWGt23ZWob5q/ugo60180Az68ewA51peYpE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=s4X38HSASKhberaL3TVA8BA3bObF5qxeRmSOhQXsOK4DkUWu7cAIU2zhmgWc31DtsjaUPh7NE033B4eOUeBv34Hb5pmiU54+oUTQDbX1sEYZACTmxAeGbh2xWQOpogFeEAGoBB0/aKmJNKOEaruq4k6gRHGztyhJpkrP/TrNfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Io0LMtRH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LhO1FVHA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A5DFF11401E9;
	Mon, 28 Apr 2025 11:10:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Apr 2025 11:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745853042; x=1745939442; bh=2h4gVAV9MICZKS5uWlGF6qr/IC8IkPJ4
	hAC79RaRz+8=; b=Io0LMtRHwmJ55l3kspS+y/EyOOf0Itipjld1+BZqjjSm0v6a
	ZLez7mXlS9I/EDeJOey0xFYyCwkjqzP/BWc++A/Zr7vWku3tzCv/lKJvIzhnj/a4
	/0ZuMu1u5faRjU91zVeblgmrfHYMbwqukyis43UE2+VJ/D3QYbLP/E2y5d86boHg
	l9dcTOQe5bYEPxTuwifvAz956oLH7S7/qNzNq0w2g2Hk6X6Cm3dkFG6DGSE1V4xK
	FFElcZSFHxDHVstZ/NG1bAQaemJftsqNO2SSJ35Mks8suhyjIGrT6iIKKCBm5yo0
	lrV8zDyl/q1e8dPyjnAqSa+gDo1EPkaEMayk9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745853042; x=
	1745939442; bh=2h4gVAV9MICZKS5uWlGF6qr/IC8IkPJ4hAC79RaRz+8=; b=L
	hO1FVHAj1aEfxwqCoIiI6JaEfUyb/kBuMbuvao9DpMvUOlUfK62wQyB6szjBAJLB
	bG8+ep5X/TcEpWaQEzmzGqtUiQX9d7iR2Ss1iVQn4FVq2+qkodDjj4xJMrMtt1PS
	0ab6WNwOQPKz+7RuJTPKDSz31RAHNXGZKNA4IJu3b+Ne8CR6mkzfeQXW4NRUa6qD
	MV06ElLJNTMwkAXnWErJkhUgu+TxMCq+ZMVUx05lJleV5zWd99SxkqECMsdGrV0I
	mUymnXsf0+79YF3KhrdJW1Juq9DLD1QftuYLkTPiP8pgoW88eUoOCUYmy5hJaQds
	a0ZZ+XGj/M6EPFODT6+Cg==
X-ME-Sender: <xms:cZoPaD3UCFF_UpyoNKOUK_1A0t5RfYn96rqELns9MMtH1cboL8qzbQ>
    <xme:cZoPaCFIo0XkGN3cjwOJs4zBCSIpQWyF0Un6ZRobhFTjguLQzYSmshE_3gF1a1ABs
    RwatMTM_p010-t6IQE>
X-ME-Received: <xmr:cZoPaD60H20EhkV7bhkymzge5b8nejJzaMBY1EW1yjuty9J-UlcG9MISr-HWlb_ISLghPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tdejnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepgedvgfdujeeuhfeljeeikefggeehvdduuedv
    leejleeflefhlefgledvvdetfefhnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrph
    hpshhpohhtrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnh
    gspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepshgufhesfhhomhhitghhvg
    hvrdhmvgdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgt
    phhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfigrnh
    hglhhirghnghejgeeshhhurgifvghirdgtohhmpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtg
    hhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehs
    hiiisghothdogeektgdugehfieduheelgegsughfrggusgdtkeeisehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cZoPaI3eeiSR75L4ej2oRpbGXcrrzDXWQXssFD_4nvk0sAN6-aykNQ>
    <xmx:cZoPaGE0g5jRWKAEVGtVEE2hRb8-aiHRCgyvJvHr9dKkzAHC0f4bDw>
    <xmx:cZoPaJ8PP7lsiZp9nBRPSpGMGW7LYTDxqDZJOIn_qieWbx-a92KBcQ>
    <xmx:cZoPaDkSFEMTFQcRYnfqak-In1cCkRTAe28CAEFizxoW2gLMJE1Tog>
    <xmx:cpoPaD5QiIY5GvkjEyoZ-5WD2QYl4erOhPgIFcflqdY5gynFyzHWOJLO>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 11:10:41 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 1398E9FD42; Mon, 28 Apr 2025 08:10:40 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 0F50B9FC50;
	Mon, 28 Apr 2025 08:10:40 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Wang Liang <wangliang74@huawei.com>,
    Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, andrew+netdev@lunn.ch,
    linux-kernel@vger.kernel.org,
    syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] bonding: hold ops lock around get_link
In-reply-to: <aA7hwMhd3kyKpvUu@fedora>
References: <20250410161117.3519250-1-sdf@fomichev.me> <11fb538b-0007-4fe7-96b2-6ddb255b496e@huawei.com> <aA7hwMhd3kyKpvUu@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 28 Apr 2025 02:02:40 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Apr 2025 08:10:40 -0700
Message-ID: <804583.1745853040@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Sun, Apr 27, 2025 at 11:06:32AM +0800, Wang Liang wrote:
>>=20
>> =E5=9C=A8 2025/4/11 0:11, Stanislav Fomichev =E5=86=99=E9=81=93:
>> > syzbot reports a case of ethtool_ops->get_link being called without
>> > ops lock:
>> >=20
>> >   ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
>> >   bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
>> >   bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
>> >   bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
>> >   process_one_work kernel/workqueue.c:3238 [inline]
>> >   process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>> >   worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>> >   kthread+0x7b7/0x940 kernel/kthread.c:464
>> >   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>> >=20
>> > Commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
>> > changed to lockless __linkwatch_sync_dev in ethtool_op_get_link.
>> > All paths except bonding are coming via locked ioctl. Add necessary
>> > locking to bonding.
>> >=20
>> > Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>> > Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
>> > Closes: https://syzkaller.appspot.com/bug?extid=3D48c14f61594bdfadb086
>> > Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
>> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>> > ---
>> > v2:
>> > - move 'BMSR_LSTATUS : 0' part out (Jakub)
>> > ---
>> >   drivers/net/bonding/bond_main.c | 13 +++++++++----
>> >   1 file changed, 9 insertions(+), 4 deletions(-)
>> >=20
>> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bon=
d_main.c
>> > index 950d8e4d86f8..8ea183da8d53 100644
>> > --- a/drivers/net/bonding/bond_main.c
>> > +++ b/drivers/net/bonding/bond_main.c
>> > @@ -850,8 +850,9 @@ static int bond_check_dev_link(struct bonding *bon=
d,
>> >   			       struct net_device *slave_dev, int reporting)
>> >   {
>> >   	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
>> > -	struct ifreq ifr;
>> >   	struct mii_ioctl_data *mii;
>> > +	struct ifreq ifr;
>> > +	int ret;
>> >   	if (!reporting && !netif_running(slave_dev))
>> >   		return 0;
>> > @@ -860,9 +861,13 @@ static int bond_check_dev_link(struct bonding *bo=
nd,
>> >   		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
>> >   	/* Try to get link status using Ethtool first. */
>> > -	if (slave_dev->ethtool_ops->get_link)
>> > -		return slave_dev->ethtool_ops->get_link(slave_dev) ?
>> > -			BMSR_LSTATUS : 0;
>> > +	if (slave_dev->ethtool_ops->get_link) {
>> > +		netdev_lock_ops(slave_dev);
>> > +		ret =3D slave_dev->ethtool_ops->get_link(slave_dev);
>> > +		netdev_unlock_ops(slave_dev);
>> > +
>> > +		return ret ? BMSR_LSTATUS : 0;
>> > +	}
>> >   	/* Ethtool can't be used, fallback to MII ioctls. */
>> >   	if (slave_ops->ndo_eth_ioctl) {
>>=20
>>=20
>> Hello, I find that a WARNING still exists:
>>=20
>> =C2=A0 RTNL: assertion failed at ./include/net/netdev_lock.h (56)
>> =C2=A0 WARNING: CPU: 1 PID: 3020 at ./include/net/netdev_lock.h:56
>> netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
>> =C2=A0 WARNING: CPU: 1 PID: 3020 at ./include/net/netdev_lock.h:56
>> __linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
>> =C2=A0 Modules linked in:
>> =C2=A0 CPU: 1 UID: 0 PID: 3020 Comm: kworker/u8:10 Not tainted
>> 6.15.0-rc2-syzkaller-00257-gb5c6891b2c5b #0 PREEMPT(full)
>> =C2=A0 Hardware name: Google Compute Engine, BIOS Google 02/12/2025
>> =C2=A0 Workqueue: bond0 bond_mii_monitor
>> =C2=A0 RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:56 [=
inline]
>>=20
>> It is report by syzbot (link:
>> https://syzkaller.appspot.com/bug?extid=3D48c14f61594bdfadb086).
>>=20
>> Because ASSERT_RTNL() failed in netdev_ops_assert_locked().
>>=20
>> I wonder if should add rtnl lock in bond_check_dev_link()?
>>=20
>> Like this:
>>=20
>> =C2=A0 +++ b/drivers/net/bonding/bond_main.c
>> =C2=A0 @@ -862,10 +862,12 @@=C2=A0 static int bond_check_dev_link(struct=
 bonding
>> *bond,
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Try to get link status using Eth=
tool first. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (slave_dev->ethtool_ops->get_lin=
k) {
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_lock_ops(slave=
_dev);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D slave_dev->et=
htool_ops->get_link(slave_dev);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_unlock_ops(sla=
ve_dev);
>> =C2=A0 -
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rtnl_trylock()) {
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 netdev_lock_ops(slave_dev);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D slave_dev->ethtool_ops->get_link(slave_dev);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 netdev_unlock_ops(slave_dev);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 rtnl_unlock();
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret =
? BMSR_LSTATUS : 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20
>
>What if rtnl_trylock() failed? This will return ret directly.
>Maybe
>	if (slave_dev->ethtool_ops->get_link && rtnl_trylock()) {
>		netdev_lock_ops(slave_dev);
>		ret =3D slave_dev->ethtool_ops->get_link(slave_dev);
>		netdev_unlock_ops(slave_dev);
>		rtnl_unlock();
>		return ret ? BMSR_LSTATUS : 0;
>	}

	This is on me; I had worked up a patch to remove all of this
logic entirely and deprecate use_carrier, but got sidetracked.  Let me
rebase it and repost it for real.

	For reference, the original patch is below; it still needs an
update to Documentation/networking/bonding.rst.

Subject: [PATCH RFC net-next] bonding: Remove support for use_carrier

	 Remove the implementation of use_carrier, the link monitoring
method that utilizes ethtool or ioctl to determine the link state of an
interface in a bond.  The ability to set or query the use_carrier option
remains, but bonding now always behaves as if use_carrier=3D1, which relies
on netif_carrier_ok() to determine the link state of interfaces.

	To avoid acquiring RTNL many times per second, bonding inspects
link state under RCU, but not under RTNL.  However, ethtool
implementations in drivers may sleep, and therefore this strategy is
unsuitable for use with calls into driver ethtool functions.

	The use_carrier option was introduced in 2003, to provide
backwards compatibility for network device drivers that did not support
the then-new netif_carrier_ok/on/off system.  Device drivers are now
expected to support netif_carrier_*, and the use_carrier backwards
compatibility logic is no longer necessary.

Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9de=
d97163aef4e4de10985cd8f7de60d28@changeid/
Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

---
 drivers/net/bonding/bond_main.c    | 107 +----------------------------
 drivers/net/bonding/bond_netlink.c |  11 +--
 drivers/net/bonding/bond_options.c |  13 +---
 drivers/net/bonding/bond_sysfs.c   |   6 +-
 include/net/bonding.h              |   1 -
 5 files changed, 7 insertions(+), 131 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index af9ddd3902cc..98d77a9e5cf1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -141,8 +141,7 @@ module_param(downdelay, int, 0);
 MODULE_PARM_DESC(downdelay, "Delay before considering link down, "
 			    "in milliseconds");
 module_param(use_carrier, int, 0);
-MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in mii=
mon; "
-			      "0 for off, 1 for on (default)");
+MODULE_PARM_DESC(use_carrier, "Obsolete, has no effect");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Mode of operation; 0 for balance-rr, "
 		       "1 for active-backup, 2 for balance-xor, "
@@ -723,73 +722,6 @@ const char *bond_slave_link_status(s8 link)
 	}
 }
=20
-/* if <dev> supports MII link status reporting, check its link status.
- *
- * We either do MII/ETHTOOL ioctls, or check netif_carrier_ok(),
- * depending upon the setting of the use_carrier parameter.
- *
- * Return either BMSR_LSTATUS, meaning that the link is up (or we
- * can't tell and just pretend it is), or 0, meaning that the link is
- * down.
- *
- * If reporting is non-zero, instead of faking link up, return -1 if
- * both ETHTOOL and MII ioctls fail (meaning the device does not
- * support them).  If use_carrier is set, return whatever it says.
- * It'd be nice if there was a good way to tell if a driver supports
- * netif_carrier, but there really isn't.
- */
-static int bond_check_dev_link(struct bonding *bond,
-			       struct net_device *slave_dev, int reporting)
-{
-	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
-	int (*ioctl)(struct net_device *, struct ifreq *, int);
-	struct ifreq ifr;
-	struct mii_ioctl_data *mii;
-
-	if (!reporting && !netif_running(slave_dev))
-		return 0;
-
-	if (bond->params.use_carrier)
-		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
-
-	/* Try to get link status using Ethtool first. */
-	if (slave_dev->ethtool_ops->get_link)
-		return slave_dev->ethtool_ops->get_link(slave_dev) ?
-			BMSR_LSTATUS : 0;
-
-	/* Ethtool can't be used, fallback to MII ioctls. */
-	ioctl =3D slave_ops->ndo_eth_ioctl;
-	if (ioctl) {
-		/* TODO: set pointer to correct ioctl on a per team member
-		 *       bases to make this more efficient. that is, once
-		 *       we determine the correct ioctl, we will always
-		 *       call it and not the others for that team
-		 *       member.
-		 */
-
-		/* We cannot assume that SIOCGMIIPHY will also read a
-		 * register; not all network drivers (e.g., e100)
-		 * support that.
-		 */
-
-		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
-		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
-		mii =3D if_mii(&ifr);
-		if (ioctl(slave_dev, &ifr, SIOCGMIIPHY) =3D=3D 0) {
-			mii->reg_num =3D MII_BMSR;
-			if (ioctl(slave_dev, &ifr, SIOCGMIIREG) =3D=3D 0)
-				return mii->val_out & BMSR_LSTATUS;
-		}
-	}
-
-	/* If reporting, report that either there's no ndo_eth_ioctl,
-	 * or both SIOCGMIIREG and get_link failed (meaning that we
-	 * cannot report link status).  If not reporting, pretend
-	 * we're ok.
-	 */
-	return reporting ? -1 : BMSR_LSTATUS;
-}
-
 /*----------------------------- Multicast list ---------------------------=
---*/
=20
 /* Push the promiscuity flag down to appropriate slaves */
@@ -1832,7 +1764,6 @@ int bond_enslave(struct net_device *bond_dev, struct =
net_device *slave_dev,
 	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
 	struct slave *new_slave =3D NULL, *prev_slave;
 	struct sockaddr_storage ss;
-	int link_reporting;
 	int res =3D 0, i;
=20
 	if (slave_dev->flags & IFF_MASTER &&
@@ -1842,12 +1773,6 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev,
 		return -EPERM;
 	}
=20
-	if (!bond->params.use_carrier &&
-	    slave_dev->ethtool_ops->get_link =3D=3D NULL &&
-	    slave_ops->ndo_eth_ioctl =3D=3D NULL) {
-		slave_warn(bond_dev, slave_dev, "no link monitoring support\n");
-	}
-
 	/* already in-use? */
 	if (netdev_is_rx_handler_busy(slave_dev)) {
 		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
@@ -2050,29 +1975,10 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
=20
 	new_slave->last_tx =3D new_slave->last_rx;
=20
-	if (bond->params.miimon && !bond->params.use_carrier) {
-		link_reporting =3D bond_check_dev_link(bond, slave_dev, 1);
-
-		if ((link_reporting =3D=3D -1) && !bond->params.arp_interval) {
-			/* miimon is set but a bonded network driver
-			 * does not support ETHTOOL/MII and
-			 * arp_interval is not set.  Note: if
-			 * use_carrier is enabled, we will never go
-			 * here (because netif_carrier is always
-			 * supported); thus, we don't need to change
-			 * the messages for netif_carrier.
-			 */
-			slave_warn(bond_dev, slave_dev, "MII and ETHTOOL support not available =
for slave, and arp_interval/arp_ip_target module parameters not specified, =
thus bonding will not detect link failures! see bonding.txt for details\n");
-		} else if (link_reporting =3D=3D -1) {
-			/* unable get link status using mii/ethtool */
-			slave_warn(bond_dev, slave_dev, "can't get link status from slave; the =
network driver associated with this interface does not support MII or ETHTO=
OL link status reporting, thus miimon has no effect on this interface\n");
-		}
-	}
-
 	/* check for initial state */
 	new_slave->link =3D BOND_LINK_NOCHANGE;
 	if (bond->params.miimon) {
-		if (bond_check_dev_link(bond, slave_dev, 0) =3D=3D BMSR_LSTATUS) {
+		if (netif_carrier_ok(slave_dev)) {
 			if (bond->params.updelay) {
 				bond_set_slave_link_state(new_slave,
 							  BOND_LINK_BACK,
@@ -2601,7 +2507,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
=20
-		link_state =3D bond_check_dev_link(bond, slave->dev, 0);
+		link_state =3D netif_carrier_ok(slave->dev);
=20
 		switch (slave->link) {
 		case BOND_LINK_UP:
@@ -6044,12 +5950,6 @@ static int __init bond_check_params(struct bond_para=
ms *params)
 		downdelay =3D 0;
 	}
=20
-	if ((use_carrier !=3D 0) && (use_carrier !=3D 1)) {
-		pr_warn("Warning: use_carrier module parameter (%d), not of valid value =
(0/1), so it was set to 1\n",
-			use_carrier);
-		use_carrier =3D 1;
-	}
-
 	if (num_peer_notif < 0 || num_peer_notif > 255) {
 		pr_warn("Warning: num_grat_arp/num_unsol_na (%d) not in range 0-255 so i=
t was reset to 1\n",
 			num_peer_notif);
@@ -6294,7 +6194,6 @@ static int __init bond_check_params(struct bond_param=
s *params)
 	params->updelay =3D updelay;
 	params->downdelay =3D downdelay;
 	params->peer_notif_delay =3D 0;
-	params->use_carrier =3D use_carrier;
 	params->lacp_active =3D 1;
 	params->lacp_fast =3D lacp_fast;
 	params->primary[0] =3D 0;
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_=
netlink.c
index 2a6a424806aa..e35433cd76b1 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -257,15 +257,6 @@ static int bond_changelink(struct net_device *bond_dev=
, struct nlattr *tb[],
 		if (err)
 			return err;
 	}
-	if (data[IFLA_BOND_USE_CARRIER]) {
-		int use_carrier =3D nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
-
-		bond_opt_initval(&newval, use_carrier);
-		err =3D __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
-				     data[IFLA_BOND_USE_CARRIER], extack);
-		if (err)
-			return err;
-	}
 	if (data[IFLA_BOND_ARP_INTERVAL]) {
 		int arp_interval =3D nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
=20
@@ -674,7 +665,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			bond->params.peer_notif_delay * bond->params.miimon))
 		goto nla_put_failure;
=20
-	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
+	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
 		goto nla_put_failure;
=20
 	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_=
options.c
index bc80fb6397dc..ab5db55e27ea 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -183,12 +183,6 @@ static const struct bond_opt_value bond_primary_resele=
ct_tbl[] =3D {
 	{ NULL,      -1},
 };
=20
-static const struct bond_opt_value bond_use_carrier_tbl[] =3D {
-	{ "off", 0,  0},
-	{ "on",  1,  BOND_VALFLAG_DEFAULT},
-	{ NULL,  -1, 0}
-};
-
 static const struct bond_opt_value bond_all_slaves_active_tbl[] =3D {
 	{ "off", 0,  BOND_VALFLAG_DEFAULT},
 	{ "on",  1,  0},
@@ -410,8 +404,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST=
] =3D {
 	[BOND_OPT_USE_CARRIER] =3D {
 		.id =3D BOND_OPT_USE_CARRIER,
 		.name =3D "use_carrier",
-		.desc =3D "Use netif_carrier_ok (vs MII ioctls) in miimon",
-		.values =3D bond_use_carrier_tbl,
+		.desc =3D "Obsolete, has no effect",
 		.set =3D bond_option_use_carrier_set
 	},
 	[BOND_OPT_ACTIVE_SLAVE] =3D {
@@ -1064,10 +1057,6 @@ static int bond_option_peer_notif_delay_set(struct b=
onding *bond,
 static int bond_option_use_carrier_set(struct bonding *bond,
 				       const struct bond_opt_value *newval)
 {
-	netdev_dbg(bond->dev, "Setting use_carrier to %llu\n",
-		   newval->value);
-	bond->params.use_carrier =3D newval->value;
-
 	return 0;
 }
=20
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sy=
sfs.c
index 1e13bb170515..9a75ad3181ab 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -467,14 +467,12 @@ static ssize_t bonding_show_primary_reselect(struct d=
evice *d,
 static DEVICE_ATTR(primary_reselect, 0644,
 		   bonding_show_primary_reselect, bonding_sysfs_store_option);
=20
-/* Show the use_carrier flag. */
+/* use_carrier is obsolete, but print value for compatibility */
 static ssize_t bonding_show_carrier(struct device *d,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct bonding *bond =3D to_bond(d);
-
-	return sysfs_emit(buf, "%d\n", bond->params.use_carrier);
+	return sysfs_emit(buf, "1\n");
 }
 static DEVICE_ATTR(use_carrier, 0644,
 		   bonding_show_carrier, bonding_sysfs_store_option);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index b61fb1aa3a56..2977a9bc343b 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -124,7 +124,6 @@ struct bond_params {
 	int arp_interval;
 	int arp_validate;
 	int arp_all_targets;
-	int use_carrier;
 	int fail_over_mac;
 	int updelay;
 	int downdelay;
--=20
2.34.1


---
	-Jay Vosburgh, jv@jvosburgh.net

