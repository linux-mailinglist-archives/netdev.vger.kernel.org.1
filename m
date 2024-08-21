Return-Path: <netdev+bounces-120666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ACF95A23B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF71F20FA7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0EB136342;
	Wed, 21 Aug 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="S5WkmobB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YF1f/7LB"
X-Original-To: netdev@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6B364D6
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256036; cv=none; b=gltx2bMMBE/lSUmtV3HG8QRkN6rmAiYObcBxtX24ey+icmGSy3WPvUAt/KVFQaJzkUj77/zDy6lzgmnmqY7J+wH5HNTwFYaWRL68y6wzm8lP4WLOtmJAyAynP/qiJ8UpMIYydd266h865lm87PRT3blNd0DrDK5yzOvjlkZXNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256036; c=relaxed/simple;
	bh=nVfrwaSssU14tp5uLAnny+QimY0XO6ljqSR8QEPfsbQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=kol63LygumI7dV7qqd9fX+hkH6P4t17s7SS35UbuH44ux3TjqbOQrCao+3h5UNgGn4rlvLdWpwkI6elBRPmsoEGoFi8Gj7dvjeIwa/j4BJkWrpVA8FdVolmRkMJSzPuc/r3ay2d1j4Lq6fJAGExhV/IMpzsJGE7uT47DgrxhtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=S5WkmobB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YF1f/7LB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1506E138FC4F;
	Wed, 21 Aug 2024 12:00:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Aug 2024 12:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1724256033; x=1724342433; bh=nYK4ypeQHEwxwYC8r6fmB
	ielMCRuJeA8z+FRaAKHeLE=; b=S5WkmobBtnNcZnMO6dJifZPcZQi7sMp5OdcEP
	aKgzKl4dE6YOL44UjN7iE2znItyS9X5FKX5kjw6AcECe1GL44RSJd7/oBjZvCnol
	XtFDcfM4T+d7iNOakVMi51ez4StgFfh9pohA8PATooEHrMv3qHFjrpmSJaX8lyuG
	vfCKhHUvlVUwTJedg/7hhjDgAZvwLHQonLIGIZG7UUiVu6XfsGORzoRKiEiMscOb
	2ZhKu99UbkfkujZt09anXZyiBaC6lu/IblJtoZWvNj0taBMQyNRbL5wb8eQ1Yeiu
	RRD7xQXKTt3wN9jJyPzTr5ivCLsHKhzJRW8p/PyTuxTz5w2QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724256033; x=1724342433; bh=nYK4ypeQHEwxwYC8r6fmBielMCRu
	JeA8z+FRaAKHeLE=; b=YF1f/7LB8SInuiZoo9SODNe4luS8tNDPQzFj8zYcgtH7
	hQ+pfw7B0IyB1o+B/h/iaEVM0MsZWGfya25g/ikuX3XZjhgiM0NHfq0nHX4s4mqW
	Rij27iUkaq9MZsaGvRsW9APF3h/hXvJHblWnFyc2gtGCFOJcrkpaw99UrK5Bb2GY
	OonjOMT0kkYQ5VE6Xr3NhM3E7h36lydt/1Ixkcwl0GlztFsqZLYARUXRGwXU0uWG
	e0cMtfg18QFvbNcQKD8qOjkBFnq0/hdWmT9o6aoMnWH7pKt2J4pxcAnTpdJ6h2s8
	p3uwDScNCYXi8oxru1AWExn09n5wlmLx1GL5VqxrUA==
X-ME-Sender: <xms:IA_GZnLt9fXlV-koDj8ja9dGj-H_qjp_ORnJTh1YehmZPtvdSBUeIg>
    <xme:IA_GZrKhGLb_ly7c1Xtkab6xRZO057j7PVs5xqiG7xa-dUSpdP-Wiras9MGqUBUq7
    hxUiHzFRRBIIXobolo>
X-ME-Received: <xmr:IA_GZvscOw1Sm_NxA-0H9TSwIDhX19veD5mpbtCVn41T3F1TfU2zlth6XzAy4_rkEsKEDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertdertddv
    necuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveel
    ffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthho
    peduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghnugihsehgrhgvhihhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgrghlsehnvhhiughirgdrtghomhdprhgtphhtth
    hopehjihgrnhgsohhlsehnvhhiughirgdrtghomhdprhgtphhtthhopehlvghonhhrohes
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepshgrvggvughmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:IA_GZgZFfGT4RCmtQ9vS-sOrV1ZVO4S0yA5WErBFuaPvpRDHlBSsOg>
    <xmx:IA_GZuaLuIAjrrHynpeW6cMXGrBVLUkFsgF0hJk1rbSN1u2EUYqqrQ>
    <xmx:IA_GZkDRMonyCp4BOlsksPp-y2o422QjPfRCUy-nBTSTPk-8YfonUQ>
    <xmx:IA_GZsYpQOzPkPAlBd5MAzNMRH-g53yWbr4fSjKkHDYAQaHuD7cSog>
    <xmx:IQ_GZqQnAlGKLotrn_Vhj8i0ZH4WBY5vtbl3gv9fH2QcBmkfnz1AEK5U>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 12:00:32 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id C8D9A9FBF0; Wed, 21 Aug 2024 09:00:30 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id C658E9FBCC;
	Wed, 21 Aug 2024 09:00:30 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jianbo Liu <jianbol@nvidia.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
    pabeni@redhat.com, edumazet@google.com, andy@greyhouse.net,
    saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com,
    liuhangbin@gmail.com, tariqt@nvidia.com
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
In-reply-to: <20240821090458.10813-4-jianbol@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
 <20240821090458.10813-4-jianbol@nvidia.com>
Comments: In-reply-to Jianbo Liu <jianbol@nvidia.com>
   message dated "Wed, 21 Aug 2024 12:04:58 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <120653.1724256030.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Aug 2024 09:00:30 -0700
Message-ID: <120654.1724256030@famine>

Jianbo Liu <jianbol@nvidia.com> wrote:

>In the cited commit, bond->ipsec_lock is added to protect ipsec_list,
>hence xdo_dev_state_add and xdo_dev_state_delete are called inside
>this lock. As ipsec_lock is a spin lock and such xfrmdev ops may sleep,
>"scheduling while atomic" will be triggered when changing bond's
>active slave.
>
>[  101.055189] BUG: scheduling while atomic: bash/902/0x00000200
>[  101.055726] Modules linked in:
>[  101.058211] CPU: 3 PID: 902 Comm: bash Not tainted 6.9.0-rc4+ #1
>[  101.058760] Hardware name:
>[  101.059434] Call Trace:
>[  101.059436]  <TASK>
>[  101.060873]  dump_stack_lvl+0x51/0x60
>[  101.061275]  __schedule_bug+0x4e/0x60
>[  101.061682]  __schedule+0x612/0x7c0
>[  101.062078]  ? __mod_timer+0x25c/0x370
>[  101.062486]  schedule+0x25/0xd0
>[  101.062845]  schedule_timeout+0x77/0xf0
>[  101.063265]  ? asm_common_interrupt+0x22/0x40
>[  101.063724]  ? __bpf_trace_itimer_state+0x10/0x10
>[  101.064215]  __wait_for_common+0x87/0x190
>[  101.064648]  ? usleep_range_state+0x90/0x90
>[  101.065091]  cmd_exec+0x437/0xb20 [mlx5_core]
>[  101.065569]  mlx5_cmd_do+0x1e/0x40 [mlx5_core]
>[  101.066051]  mlx5_cmd_exec+0x18/0x30 [mlx5_core]
>[  101.066552]  mlx5_crypto_create_dek_key+0xea/0x120 [mlx5_core]
>[  101.067163]  ? bonding_sysfs_store_option+0x4d/0x80 [bonding]
>[  101.067738]  ? kmalloc_trace+0x4d/0x350
>[  101.068156]  mlx5_ipsec_create_sa_ctx+0x33/0x100 [mlx5_core]
>[  101.068747]  mlx5e_xfrm_add_state+0x47b/0xaa0 [mlx5_core]
>[  101.069312]  bond_change_active_slave+0x392/0x900 [bonding]
>[  101.069868]  bond_option_active_slave_set+0x1c2/0x240 [bonding]
>[  101.070454]  __bond_opt_set+0xa6/0x430 [bonding]
>[  101.070935]  __bond_opt_set_notify+0x2f/0x90 [bonding]
>[  101.071453]  bond_opt_tryset_rtnl+0x72/0xb0 [bonding]
>[  101.071965]  bonding_sysfs_store_option+0x4d/0x80 [bonding]
>[  101.072567]  kernfs_fop_write_iter+0x10c/0x1a0
>[  101.073033]  vfs_write+0x2d8/0x400
>[  101.073416]  ? alloc_fd+0x48/0x180
>[  101.073798]  ksys_write+0x5f/0xe0
>[  101.074175]  do_syscall_64+0x52/0x110
>[  101.074576]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>As bond_ipsec_add_sa_all and bond_ipsec_del_sa_all are only called
>from bond_change_active_slave, which requires holding the RTNL lock.
>And bond_ipsec_add_sa and bond_ipsec_del_sa are xfrm state
>xdo_dev_state_add and xdo_dev_state_delete APIs, which are in user
>context. So ipsec_lock doesn't have to be spin lock, change it to
>mutex, and thus the above issue can be resolved.
>
>Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
>Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 67 +++++++++++++++------------------
> include/net/bonding.h           |  2 +-
> 2 files changed, 32 insertions(+), 37 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 0d1129eaf47b..f20f6d83ad54 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -439,38 +439,33 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
> 	rcu_read_lock();
> 	bond =3D netdev_priv(bond_dev);
> 	slave =3D rcu_dereference(bond->curr_active_slave);
>-	if (!slave) {
>-		rcu_read_unlock();
>+	real_dev =3D slave ? slave->dev : NULL;
>+	rcu_read_unlock();
>+	if (!real_dev)
> 		return -ENODEV;

	In reading these, I was confused as to why some changes use
rcu_read_lock(), rcu_dereference() and others use rtnl_dereference(); I
think it's because bond_ipsec_{add,del}_sa_all() are guaranteed to be
called under RTNL, while the bond_ipsec_{add,del}_sa() functions are do
not have that guarantee.  Am I understanding correctly?

>-	}
> =

>-	real_dev =3D slave->dev;
> 	if (!real_dev->xfrmdev_ops ||
> 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> 	    netif_is_bond_master(real_dev)) {
> 		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
>-		rcu_read_unlock();
> 		return -EINVAL;
> 	}
> =

>-	ipsec =3D kmalloc(sizeof(*ipsec), GFP_ATOMIC);
>-	if (!ipsec) {
>-		rcu_read_unlock();
>+	ipsec =3D kmalloc(sizeof(*ipsec), GFP_KERNEL);
>+	if (!ipsec)
> 		return -ENOMEM;

	Presumably the switch from ATOMIC to KERNEL is safe because this
is only called under RTNL (and therefore always has a process context),
i.e., this change is independent of any other changes in the patch.
Correct?

>-	}
> =

> 	xs->xso.real_dev =3D real_dev;
> 	err =3D real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
> 	if (!err) {
> 		ipsec->xs =3D xs;
> 		INIT_LIST_HEAD(&ipsec->list);
>-		spin_lock_bh(&bond->ipsec_lock);
>+		mutex_lock(&bond->ipsec_lock);
> 		list_add(&ipsec->list, &bond->ipsec_list);
>-		spin_unlock_bh(&bond->ipsec_lock);
>+		mutex_unlock(&bond->ipsec_lock);
> 	} else {
> 		kfree(ipsec);
> 	}
>-	rcu_read_unlock();
> 	return err;
> }
> =

>@@ -481,35 +476,35 @@ static void bond_ipsec_add_sa_all(struct bonding *b=
ond)
> 	struct bond_ipsec *ipsec;
> 	struct slave *slave;
> =

>-	rcu_read_lock();
>-	slave =3D rcu_dereference(bond->curr_active_slave);
>-	if (!slave)
>-		goto out;
>+	slave =3D rtnl_dereference(bond->curr_active_slave);
>+	real_dev =3D slave ? slave->dev : NULL;
>+	if (!real_dev)
>+		return;
> =

>-	real_dev =3D slave->dev;
>+	mutex_lock(&bond->ipsec_lock);
> 	if (!real_dev->xfrmdev_ops ||
> 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> 	    netif_is_bond_master(real_dev)) {
>-		spin_lock_bh(&bond->ipsec_lock);
> 		if (!list_empty(&bond->ipsec_list))
> 			slave_warn(bond_dev, real_dev,
> 				   "%s: no slave xdo_dev_state_add\n",
> 				   __func__);
>-		spin_unlock_bh(&bond->ipsec_lock);
> 		goto out;
> 	}
> =

>-	spin_lock_bh(&bond->ipsec_lock);
> 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>+		/* If new state is added before ipsec_lock acquired */
>+		if (ipsec->xs->xso.real_dev =3D=3D real_dev)
>+			continue;
>+
> 		ipsec->xs->xso.real_dev =3D real_dev;
> 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
> 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> 			ipsec->xs->xso.real_dev =3D NULL;
> 		}
> 	}
>-	spin_unlock_bh(&bond->ipsec_lock);
> out:
>-	rcu_read_unlock();
>+	mutex_unlock(&bond->ipsec_lock);
> }
> =

> /**
>@@ -530,6 +525,8 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> 	rcu_read_lock();
> 	bond =3D netdev_priv(bond_dev);
> 	slave =3D rcu_dereference(bond->curr_active_slave);
>+	real_dev =3D slave ? slave->dev : NULL;
>+	rcu_read_unlock();

	Is it really safe to access real_dev once we've left the rcu
critical section?  What prevents the device referenced by real_dev from
being deleted as soon as rcu_read_unlock() completes?

	-J
	=

> =

> 	if (!slave)
> 		goto out;
>@@ -537,7 +534,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> 	if (!xs->xso.real_dev)
> 		goto out;
> =

>-	real_dev =3D slave->dev;
> 	WARN_ON(xs->xso.real_dev !=3D real_dev);
> =

> 	if (!real_dev->xfrmdev_ops ||
>@@ -549,7 +545,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> =

> 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
> out:
>-	spin_lock_bh(&bond->ipsec_lock);
>+	mutex_lock(&bond->ipsec_lock);
> 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> 		if (ipsec->xs =3D=3D xs) {
> 			list_del(&ipsec->list);
>@@ -557,8 +553,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> 			break;
> 		}
> 	}
>-	spin_unlock_bh(&bond->ipsec_lock);
>-	rcu_read_unlock();
>+	mutex_unlock(&bond->ipsec_lock);
> }
> =

> static void bond_ipsec_del_sa_all(struct bonding *bond)
>@@ -568,15 +563,12 @@ static void bond_ipsec_del_sa_all(struct bonding *b=
ond)
> 	struct bond_ipsec *ipsec;
> 	struct slave *slave;
> =

>-	rcu_read_lock();
>-	slave =3D rcu_dereference(bond->curr_active_slave);
>-	if (!slave) {
>-		rcu_read_unlock();
>+	slave =3D rtnl_dereference(bond->curr_active_slave);
>+	real_dev =3D slave ? slave->dev : NULL;
>+	if (!real_dev)
> 		return;
>-	}
> =

>-	real_dev =3D slave->dev;
>-	spin_lock_bh(&bond->ipsec_lock);
>+	mutex_lock(&bond->ipsec_lock);
> 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> 		if (!ipsec->xs->xso.real_dev)
> 			continue;
>@@ -593,8 +585,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bon=
d)
> 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
> 		}
> 	}
>-	spin_unlock_bh(&bond->ipsec_lock);
>-	rcu_read_unlock();
>+	mutex_unlock(&bond->ipsec_lock);
> }
> =

> static void bond_ipsec_free_sa(struct xfrm_state *xs)
>@@ -5917,7 +5908,7 @@ void bond_setup(struct net_device *bond_dev)
> 	/* set up xfrm device ops (only supported in active-backup right now) *=
/
> 	bond_dev->xfrmdev_ops =3D &bond_xfrmdev_ops;
> 	INIT_LIST_HEAD(&bond->ipsec_list);
>-	spin_lock_init(&bond->ipsec_lock);
>+	mutex_init(&bond->ipsec_lock);
> #endif /* CONFIG_XFRM_OFFLOAD */
> =

> 	/* don't acquire bond device's netif_tx_lock when transmitting */
>@@ -5966,6 +5957,10 @@ static void bond_uninit(struct net_device *bond_de=
v)
> 		__bond_release_one(bond_dev, slave->dev, true, true);
> 	netdev_info(bond_dev, "Released all slaves\n");
> =

>+#ifdef CONFIG_XFRM_OFFLOAD
>+	mutex_destroy(&bond->ipsec_lock);
>+#endif /* CONFIG_XFRM_OFFLOAD */
>+
> 	bond_set_slave_arr(bond, NULL, NULL);
> =

> 	list_del_rcu(&bond->bond_list);
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index b61fb1aa3a56..8bb5f016969f 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -260,7 +260,7 @@ struct bonding {
> #ifdef CONFIG_XFRM_OFFLOAD
> 	struct list_head ipsec_list;
> 	/* protecting ipsec_list */
>-	spinlock_t ipsec_lock;
>+	struct mutex ipsec_lock;
> #endif /* CONFIG_XFRM_OFFLOAD */
> 	struct bpf_prog *xdp_prog;
> };
>-- =

>2.21.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

