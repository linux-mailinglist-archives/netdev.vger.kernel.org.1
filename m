Return-Path: <netdev+bounces-120814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A395AD2E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5CD28314E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FE14F98;
	Thu, 22 Aug 2024 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="SCQg/pcH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bl14KNfx"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEBA1311B6
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306734; cv=none; b=Lou9Ct3k23gMW23/MlvNWLTlm4pHu3sR4vAAG8QBcTzKE+JEV988BiDj/r8brDQYktrq7EbIRojjm4dK4XIY7Ps7YwM4y2VeyUNXz4MzFdN0UhLe8eWoP7/6UncN1zjngvaYlqifrW0YWMnnes2CbQG9DWeArQy7mIfBW46ODpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306734; c=relaxed/simple;
	bh=ap8Zt4A4o5E8NUPQvXE51ropSgSiidFWzOuAvcQ9Pg0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=eUchfqX/VsMQ/oqZVb0EfUWIM3RvMNNuIarmRz0nx3WzYS9y+WlTEVjpLtleQ9ckqQOJB0mRPUrzCV35+vJ48LyRQAYN5tXqoVdWamKjeZKBsw49xjPq7fvwaPpDe+uBkts5e9/wuXcGG5bY9mRN2IQ7cCsl+0BwJryeJQJnVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=SCQg/pcH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bl14KNfx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 63D181151C01;
	Thu, 22 Aug 2024 02:05:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 02:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1724306731; x=1724393131; bh=FUgHgTBMCRnHKAxIYQ4/49tuKPUdNcRh
	8ygO3z/yj1g=; b=SCQg/pcHxsK0cKZ4PMjUN8Z1TYM71K+QQDd6frcqE68L5hhW
	yKlQyspJe/3n3uaPC5hkQqe98BNuIx1sfcO6MwcpF2UwidDXtFZXQ1fbX8R97x5D
	1j0S5UbrHSgVvXcEPwD/HDvNJcDIEn9zCXngZVuGnpcZhHfb8ivS6vQhAnfagGBq
	1ia2crgzei71uvPsiaDYBfojHcfpRvFJPb1/knJtGBVxCngMomDPxAN5VoK25hFE
	o55bJbuilRUFPZEGbWlNR4LSNtjvZpKF8J3xXN9y+EeiBOu5gNVOekPb1xBnLgSf
	m1UTqyzRMr5FtIGA5m2BE0pYBMDeSZYD65if0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724306731; x=
	1724393131; bh=FUgHgTBMCRnHKAxIYQ4/49tuKPUdNcRh8ygO3z/yj1g=; b=b
	l14KNfxCr32XJn38EkHugOIDcIMj35Oy9yPxVd/lEJ3RVhN6NZPWBLEVlejVs4x3
	cHmUjSdblLqPmlZYsQrhhPXXuk0/yhkauvLfKLGiwx+kivzr3pJUb1UkyMNH4g8D
	WI4soYNdEP26MLqdM3iFXD+yMQDl97H1Ltrk8Drn9BtL2EISOIYfaPgnA40GBNpG
	cEJU+K1iCMR64kqWH24uCl2ggHbALDscRs10OE758ARevvcwEBPXnvFmRobxVKHD
	QvUnrb7B5/7vz9hjRQIvKkyeEzYFncadbjOFGCMrLmRz1WcGZ5Gh4zZKtV4ghz6L
	1GH9pH1AresB1yzmMzBtQ==
X-ME-Sender: <xms:KtXGZh07pnZTCrKyvForT4l-6BsBa05e58vjfC7Q1gABhF3WupAH9g>
    <xme:KtXGZoFVlcoxPrMVbu46VJlale0bmw_oOusEhAzV7osicctTwgj0VnI6xfC4fvkG8
    uZhe68MwzAGECyRW9o>
X-ME-Received: <xmr:KtXGZh6msxSM75CKrQxKeivNzFq6vRB148AiMimNEeMpPfrx-A1zqS5Cuvk7m5mJpD7ZcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    jeenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeegfefghffghffhjefgveekhfeukeevffethffg
    tddutdefffeuheelgeelieeuhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegrnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghgrlhesnhhvihguihgrrdgtohhmpdhrtghpth
    htohepjhhirghnsgholhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnrhho
    sehnvhhiughirgdrtghomhdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtoh
    hm
X-ME-Proxy: <xmx:K9XGZu0aSKSYltdDNG3W8iEd5SJzjZjFu9GJshFkiXluH3jOQhRfWQ>
    <xmx:K9XGZkEppE90xGg9Jv2s20PSqnF149Ko0z527G68-_K3-iqRhED4Dg>
    <xmx:K9XGZv-SyEwTVWtfyeoCPyhx5u8egazrLACJX-4D-cspnzpHqbAG9Q>
    <xmx:K9XGZhlCKf1SL7sWyFb8MVo6CmzLuH74HygiEnvau5ik22Y-4HWr6A>
    <xmx:K9XGZrf6_ZPYF3kw-HLrodgq6xIHgFJ9SLKDvyjIRc_kcdVuxbIg3HRX>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:05:30 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 466D29FBF2; Wed, 21 Aug 2024 23:05:29 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4383F9FB9C;
	Wed, 21 Aug 2024 23:05:29 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jianbo Liu <jianbol@nvidia.com>
cc: "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
    "davem@davemloft.net" <davem@davemloft.net>,
    Leon Romanovsky <leonro@nvidia.com>, Gal Pressman <gal@nvidia.com>,
    "andy@greyhouse.net" <andy@greyhouse.net>,
    Tariq Toukan <tariqt@nvidia.com>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "pabeni@redhat.com" <pabeni@redhat.com>,
    "edumazet@google.com" <edumazet@google.com>,
    Saeed Mahameed <saeedm@nvidia.com>,
    "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to mutex
In-reply-to: <2fb7d110fd9d210e12a61ebb28af6faf330d6421.camel@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com> <20240821090458.10813-4-jianbol@nvidia.com> <120654.1724256030@famine> <2fb7d110fd9d210e12a61ebb28af6faf330d6421.camel@nvidia.com>
Comments: In-reply-to Jianbo Liu <jianbol@nvidia.com>
   message dated "Thu, 22 Aug 2024 01:53:22 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2024 23:05:29 -0700
Message-ID: <139066.1724306729@famine>

Jianbo Liu <jianbol@nvidia.com> wrote:

>On Wed, 2024-08-21 at 09:00 -0700, Jay Vosburgh wrote:
>> Jianbo Liu <jianbol@nvidia.com> wrote:
>>=20
>> > In the cited commit, bond->ipsec_lock is added to protect
>> > ipsec_list,
>> > hence xdo_dev_state_add and xdo_dev_state_delete are called inside
>> > this lock. As ipsec_lock is a spin lock and such xfrmdev ops may
>> > sleep,
>> > "scheduling while atomic" will be triggered when changing bond's
>> > active slave.
>> >=20
>> > [=C2=A0 101.055189] BUG: scheduling while atomic: bash/902/0x00000200
>> > [=C2=A0 101.055726] Modules linked in:
>> > [=C2=A0 101.058211] CPU: 3 PID: 902 Comm: bash Not tainted 6.9.0-rc4+ =
#1
>> > [=C2=A0 101.058760] Hardware name:
>> > [=C2=A0 101.059434] Call Trace:
>> > [=C2=A0 101.059436]=C2=A0 <TASK>
>> > [=C2=A0 101.060873]=C2=A0 dump_stack_lvl+0x51/0x60
>> > [=C2=A0 101.061275]=C2=A0 __schedule_bug+0x4e/0x60
>> > [=C2=A0 101.061682]=C2=A0 __schedule+0x612/0x7c0
>> > [=C2=A0 101.062078]=C2=A0 ? __mod_timer+0x25c/0x370
 >> > [=C2=A0 101.062486]=C2=A0 schedule+0x25/0xd0
>> > [=C2=A0 101.062845]=C2=A0 schedule_timeout+0x77/0xf0
>> > [=C2=A0 101.063265]=C2=A0 ? asm_common_interrupt+0x22/0x40
>> > [=C2=A0 101.063724]=C2=A0 ? __bpf_trace_itimer_state+0x10/0x10
>> > [=C2=A0 101.064215]=C2=A0 __wait_for_common+0x87/0x190
>> > [=C2=A0 101.064648]=C2=A0 ? usleep_range_state+0x90/0x90
>> > [=C2=A0 101.065091]=C2=A0 cmd_exec+0x437/0xb20 [mlx5_core]
>> > [=C2=A0 101.065569]=C2=A0 mlx5_cmd_do+0x1e/0x40 [mlx5_core]
>> > [=C2=A0 101.066051]=C2=A0 mlx5_cmd_exec+0x18/0x30 [mlx5_core]
>> > [=C2=A0 101.066552]=C2=A0 mlx5_crypto_create_dek_key+0xea/0x120 [mlx5_=
core]
>> > [=C2=A0 101.067163]=C2=A0 ? bonding_sysfs_store_option+0x4d/0x80 [bond=
ing]
>> > [=C2=A0 101.067738]=C2=A0 ? kmalloc_trace+0x4d/0x350
>> > [=C2=A0 101.068156]=C2=A0 mlx5_ipsec_create_sa_ctx+0x33/0x100 [mlx5_co=
re]
>> > [=C2=A0 101.068747]=C2=A0 mlx5e_xfrm_add_state+0x47b/0xaa0 [mlx5_core]
>> > [=C2=A0 101.069312]=C2=A0 bond_change_active_slave+0x392/0x900 [bondin=
g]
>> > [=C2=A0 101.069868]=C2=A0 bond_option_active_slave_set+0x1c2/0x240 [bo=
nding]
>> > [=C2=A0 101.070454]=C2=A0 __bond_opt_set+0xa6/0x430 [bonding]
>> > [=C2=A0 101.070935]=C2=A0 __bond_opt_set_notify+0x2f/0x90 [bonding]
>> > [=C2=A0 101.071453]=C2=A0 bond_opt_tryset_rtnl+0x72/0xb0 [bonding]
>> > [=C2=A0 101.071965]=C2=A0 bonding_sysfs_store_option+0x4d/0x80 [bondin=
g]
>> > [=C2=A0 101.072567]=C2=A0 kernfs_fop_write_iter+0x10c/0x1a0
>> > [=C2=A0 101.073033]=C2=A0 vfs_write+0x2d8/0x400
>> > [=C2=A0 101.073416]=C2=A0 ? alloc_fd+0x48/0x180
>> > [=C2=A0 101.073798]=C2=A0 ksys_write+0x5f/0xe0
>> > [=C2=A0 101.074175]=C2=A0 do_syscall_64+0x52/0x110
>> > [=C2=A0 101.074576]=C2=A0 entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> >=20
>> > As bond_ipsec_add_sa_all and bond_ipsec_del_sa_all are only called
>> > from bond_change_active_slave, which requires holding the RTNL
>> > lock.
>> > And bond_ipsec_add_sa and bond_ipsec_del_sa are xfrm state
>> > xdo_dev_state_add and xdo_dev_state_delete APIs, which are in user
>> > context. So ipsec_lock doesn't have to be spin lock, change it to
>> > mutex, and thus the above issue can be resolved.
>> >=20
>> > Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
>> > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> > Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>> > ---
>> > drivers/net/bonding/bond_main.c | 67 +++++++++++++++---------------
>> > ---
>> > include/net/bonding.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
>> > 2 files changed, 32 insertions(+), 37 deletions(-)
>> >=20
>> > diff --git a/drivers/net/bonding/bond_main.c
>> > b/drivers/net/bonding/bond_main.c
>> > index 0d1129eaf47b..f20f6d83ad54 100644
>> > --- a/drivers/net/bonding/bond_main.c
>> > +++ b/drivers/net/bonding/bond_main.c
>> > @@ -439,38 +439,33 @@ static int bond_ipsec_add_sa(struct
>> > xfrm_state *xs,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bond =3D netdev_priv(b=
ond_dev);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rcu_derefere=
nce(bond->curr_active_slave);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!slave) {
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave ? slave-=
>dev : NULL;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!real_dev)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0In reading these, I was =
confused as to why some changes use
>> rcu_read_lock(), rcu_dereference() and others use rtnl_dereference();
>> I
>> think it's because bond_ipsec_{add,del}_sa_all() are guaranteed to be
>> called under RTNL, while the bond_ipsec_{add,del}_sa() functions are
>> do
>> not have that guarantee.=C2=A0 Am I understanding correctly?
>>=20
>
>Right. bond_ipsec_{add,del}_sa_all() are called by
>bond_change_active_slave() which has ASSERT_RTNL(), so I think they are
>under RTNL.

	Yes.

>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave->dev;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!real_dev->xfrmdev=
_ops ||
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !re=
al_dev->xfrmdev_ops->xdo_dev_state_add ||
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net=
if_is_bond_master(real_dev)) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0NL_SET_ERR_MSG_MOD(extack, "Slave does not suppo=
rt
>> > ipsec offload");
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ipsec =3D kmalloc(sizeof(*i=
psec), GFP_ATOMIC);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ipsec) {
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ipsec =3D kmalloc(sizeof(*i=
psec), GFP_KERNEL);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ipsec)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Presumably the switch fr=
om ATOMIC to KERNEL is safe because
>> this
>> is only called under RTNL (and therefore always has a process
>> context),
>> i.e., this change is independent of any other changes in the patch.
>> Correct?
>>=20
>
>No. And it's RCU here, not RTNL. We are safe to use KERNEL after it's
>out of the RCU context, right? And this was suggested by Paolo after he
>reviewd the first version.=20=20=20=20=20=20

	Ok, I think I follow now.  And, yes, KERNEL is ok when outside
the RCU critical section, but not inside of it (because sleeping is not
permitted within the critical section).

>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xs->xso.real_dev =3D r=
eal_dev;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D real_dev->xfrm=
dev_ops->xdo_dev_state_add(xs, extack);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!err) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ipsec->xs =3D xs;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_LIST_HEAD(&ipsec->list);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0spin_lock_bh(&bond->ipsec_lock);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_lock(&bond->ipsec_lock);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0list_add(&ipsec->list, &bond->ipsec_list);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0spin_unlock_bh(&bond->ipsec_lock);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&bond->ipsec_lock);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(ipsec);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
>> > }
>> >=20
>> > @@ -481,35 +476,35 @@ static void bond_ipsec_add_sa_all(struct
>> > bonding *bond)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bond_ipsec *ips=
ec;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct slave *slave;
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rcu_dereference(b=
ond->curr_active_slave);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!slave)
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rtnl_dereference(=
bond->curr_active_slave);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave ? slave-=
>dev : NULL;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!real_dev)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return;
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave->dev;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&bond->ipsec_loc=
k);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!real_dev->xfrmdev=
_ops ||
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !re=
al_dev->xfrmdev_ops->xdo_dev_state_add ||
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net=
if_is_bond_master(real_dev)) {
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0spin_lock_bh(&bond->ipsec_lock);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!list_empty(&bond->ipsec_list))
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
slave_warn(bond_dev, real_dev,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: no slave
>> > xdo_dev_state_add\n",
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0spin_unlock_bh(&bond->ipsec_lock);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_bh(&bond->ipsec_l=
ock);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(ip=
sec, &bond->ipsec_list, list) {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* If new state is added before ipsec_lock acquired
>> > */
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ipsec->xs->xso.real_dev =3D=3D real_dev)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contin=
ue;
>> > +
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ipsec->xs->xso.real_dev =3D real_dev;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (real_dev->xfrmdev_ops->xdo_dev_state_add(ips=
ec-
>> > >xs, NULL)) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
slave_warn(bond_dev, real_dev, "%s: failed
>> > to add SA\n", __func__);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ipsec->xs->xso.real_dev =3D NULL;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_bh(&bond->ipsec=
_lock);
>> > out:
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&bond->ipsec_l=
ock);
>> > }
>> >=20
>> > /**
>> > @@ -530,6 +525,8 @@ static void bond_ipsec_del_sa(struct xfrm_state
>> > *xs)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bond =3D netdev_priv(b=
ond_dev);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rcu_derefere=
nce(bond->curr_active_slave);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave ? slave-=
>dev : NULL;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Is it really safe to acc=
ess real_dev once we've left the rcu
>> critical section?=C2=A0 What prevents the device referenced by real_dev
>> from
>> being deleted as soon as rcu_read_unlock() completes?
>>=20
>
>I am not sure. But RCU protects accessing of the context pointed by
>curr_active_slave, not slave->dev itself. I wrong about this?

	No, you're not wrong: RCU does indeed protect the "slave"
pointer in the above code while inside the RCU read-side critical
section.

	However, we also know that as long as we're within that critical
section, whatever the "slave" pointer points to will remain valid,
because what curr_active_slave points to is also RCU protected (not only
the pointer itself).

	For the interface behind slave->dev specifically, any attempt to
delete an interface that is a member of a bond must pass through
__bond_release_one() first, and it calls synchronize_rcu() as part of
its processing (which will wait for active read-side critical sections
to complete).  Therefore, the bond member interface behind slave->dev
here cannot simply vanish while execution is within this critical
section.

>I can move rcu_read_unlock after xdo_dev_state_delete(). And do the
>same change for bond_ipsec_add_sa and bond_ipsec_free_sa.
>What do you think?

	The original issue was that the xfrm callback within mlx5 could
sleep while a spin lock was held.  However, sleeping is not permitted
within an RCU read-side critical section, either, so would this simply
reintroduce the original problem from a different angle?

	Assuming that's correct, I think one way around that is to
acquire a reference (via dev_hold or netdev_hold) to the interface
(i.e., real_dev) within the minimal rcu_read_lock / rcu_read_unlock, do
the xfrm magic, and then release the reference when finished.  That
won't prevent the interface from being removed from the bond and the
struct slave being freed outside of the RCU critical section, so the
code would also need to use only real_dev after rcu_read_unlock() is
called.

	-J

>Thanks!
>Jianbo=20
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-J
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!slave)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
>> > @@ -537,7 +534,6 @@ static void bond_ipsec_del_sa(struct xfrm_state
>> > *xs)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!xs->xso.real_dev)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave->dev;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WARN_ON(xs->xso.real_d=
ev !=3D real_dev);
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!real_dev->xfrmdev=
_ops ||
>> > @@ -549,7 +545,7 @@ static void bond_ipsec_del_sa(struct xfrm_state
>> > *xs)
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev->xfrmdev_ops-=
>xdo_dev_state_delete(xs);
>> > out:
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_bh(&bond->ipsec_l=
ock);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&bond->ipsec_loc=
k);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(ip=
sec, &bond->ipsec_list, list) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ipsec->xs =3D=3D xs) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
list_del(&ipsec->list);
>> > @@ -557,8 +553,7 @@ static void bond_ipsec_del_sa(struct xfrm_state
>> > *xs)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_bh(&bond->ipsec=
_lock);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&bond->ipsec_l=
ock);
>> > }
>> >=20
>> > static void bond_ipsec_del_sa_all(struct bonding *bond)
>> > @@ -568,15 +563,12 @@ static void bond_ipsec_del_sa_all(struct
>> > bonding *bond)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bond_ipsec *ips=
ec;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct slave *slave;
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rcu_dereference(b=
ond->curr_active_slave);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!slave) {
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slave =3D rtnl_dereference(=
bond->curr_active_slave);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave ? slave-=
>dev : NULL;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!real_dev)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> >=20
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev =3D slave->dev;
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_bh(&bond->ipsec_l=
ock);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&bond->ipsec_loc=
k);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(ip=
sec, &bond->ipsec_list, list) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ipsec->xs->xso.real_dev)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
continue;
>> > @@ -593,8 +585,7 @@ static void bond_ipsec_del_sa_all(struct
>> > bonding *bond)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_dev->xfrmdev_ops-
>> > >xdo_dev_state_free(ipsec->xs);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_bh(&bond->ipsec=
_lock);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&bond->ipsec_l=
ock);
>> > }
>> >=20
>> > static void bond_ipsec_free_sa(struct xfrm_state *xs)
>> > @@ -5917,7 +5908,7 @@ void bond_setup(struct net_device *bond_dev)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set up xfrm device =
ops (only supported in active-backup
>> > right now) */
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bond_dev->xfrmdev_ops =
=3D &bond_xfrmdev_ops;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_LIST_HEAD(&bond->=
ipsec_list);
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_init(&bond->ipsec=
_lock);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&bond->ipsec_loc=
k);
>> > #endif /* CONFIG_XFRM_OFFLOAD */
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* don't acquire bond =
device's netif_tx_lock when
>> > transmitting */
>> > @@ -5966,6 +5957,10 @@ static void bond_uninit(struct net_device
>> > *bond_dev)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0__bond_release_one(bond_dev, slave->dev, true,
>> > true);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev_info(bond_dev, =
"Released all slaves\n");
>> >=20
>> > +#ifdef CONFIG_XFRM_OFFLOAD
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_destroy(&bond->ipsec_=
lock);
>> > +#endif /* CONFIG_XFRM_OFFLOAD */
>> > +
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bond_set_slave_arr(bon=
d, NULL, NULL);
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_del_rcu(&bond->bo=
nd_list);
>> > diff --git a/include/net/bonding.h b/include/net/bonding.h
>> > index b61fb1aa3a56..8bb5f016969f 100644
>> > --- a/include/net/bonding.h
>> > +++ b/include/net/bonding.h
>> > @@ -260,7 +260,7 @@ struct bonding {
>> > #ifdef CONFIG_XFRM_OFFLOAD
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head ipsec=
_list;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* protecting ipsec_li=
st */
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spinlock_t ipsec_lock;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mutex ipsec_lock;
>> > #endif /* CONFIG_XFRM_OFFLOAD */
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct bpf_prog *xdp_p=
rog;
>> > };
>> > --=20
>> > 2.21.0

---
	-Jay Vosburgh, jv@jvosburgh.net

