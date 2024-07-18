Return-Path: <netdev+bounces-112132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFB9352ED
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BA31F21180
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB37D41D;
	Thu, 18 Jul 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="eMwVBlbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/DODU/R"
X-Original-To: netdev@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41F7711F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337155; cv=none; b=aVpB+mX7bkZC9xGEt33pDsF6+eBBG6SFpHlle2d8b/nH98B3wOlraSfGklQDNzg1/elrQnUAtTn5VmkHxyzIgz/BecOYJUAmdlE2NNOXG6g7LMCrpBt+RZmdmISXilKWC3JDZUJr4UsHGi5XhjRXsnAUkro2XY7smtbcXA/ON08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337155; c=relaxed/simple;
	bh=OyofNPxmkl3fNT0RDWcqFTeyK28cAcyr7irX4ItLu7g=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=LbNA0GLIlkVbh+tHvy5iqX6nRladJD4m/MWwiDxQXIxe2/8OpYXiRk7cgUEasKb9YhA6ML+otrsmoz6TbjE/C9wXsvNgjQanGvLZrd4peISM7xp7T74JMHhEwbDi4Sa8To64D5Ru5y1hDTzClzaVlqtI6E/ePnKpkD/ieaI5dh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=eMwVBlbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/DODU/R; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id DD3F3200157;
	Thu, 18 Jul 2024 17:12:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Jul 2024 17:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1721337151; x=1721340751; bh=TvJd4fLMdmmCs3I/ueMTr
	L+1Xz16+j7VHtHk1DQYxH8=; b=eMwVBlbbpJjxo4dSV/BmWtOPiQWXxsKnHEexh
	t9Wa/edtt46Wg6Z0wvSzLJsIv1fkzEtgziUJGsyAxnN7ncoGRyStFIv8Ap3Dd+XQ
	zh0/WIKfv8xlGsjvByjb8OgFb1KhBn8L/GAGXLO6EKDdXKc2n1O8DEJR/bBCnnia
	ZdAIF5ZhFl7kniUF9icdWJC5qFwLtsr5ccQxh35veyolyUCfV9UFdFMt3V4xAx34
	kpInQVWWghcAKr2jQDF5S3aZqTzCv6M9Rbc2LRD9Hh3haie7LZ4UI1QvZ8cpq32v
	bbNPbUKORXXnkCTxMmNZ1Fix29J3HlQ2ylR6i0qWEgXVJ9KKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721337151; x=1721340751; bh=TvJd4fLMdmmCs3I/ueMTrL+1Xz16
	+j7VHtHk1DQYxH8=; b=o/DODU/RkrrZMCzrCW51df4UWZT2UIfYDGEmiVU8JP+a
	LX4MRCda5j/QV9ouuO8B8TvMY2In7wxt6O03qjtQxHbmmKS5Kf+qVn+rHJjFA48O
	T67lD8LGaBHbFs6OsKQkrQfatq+EUKjI78F6n43hBpnEsuGsqx3KV450pbzTLjKp
	0eBxZlTn7ssnDk+KTLgX5N8bGt55H5cww1Pwk2W6dRNYaGMs3Ug/nzbReYHpEBaY
	b0p+j32AABkUIDwAvv19i6hJygRSSHy5GlzfylBucmt8pEGb1gl4TVDuMLttezyT
	0VN+ybe7xLgwjPMDR2FIo+hpTlthfqrFTmJ+079n+w==
X-ME-Sender: <xms:PoWZZvzvfa4Bl7VE3SwzrcubzXa24zXVDHdaC9ebKg2m2tHRVF7YPw>
    <xme:PoWZZnSygX2dWN5fdQksrp5zDoGlnAeAqkVCg3ssHhkOtmq471uNTSIdTkjaekL1-
    CtdMQ3TeUHpdApqDLY>
X-ME-Received: <xmr:PoWZZpWL3QjO1gq1z7rakr63aGkEpXULMK0FcnJ791u2qD6iR5YaNyPbS2CToH1R9skDfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeelgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgih
    ucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrth
    htvghrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfei
    tdeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvth
X-ME-Proxy: <xmx:PoWZZpi4-_mNq9w_JRwBRTqH5Z-JRCAXSp0_CUhcAb11kNDFDxht-w>
    <xmx:PoWZZhDtadBk7lMlceZH98NTta_snQWuW0qYI6i2acEeXUWIwtsooQ>
    <xmx:PoWZZiLsvNMpRsQ2h76Leed4NolGXAQxJsouyiqVMtoMvM7tpHLTRw>
    <xmx:PoWZZgCojIEhHLuO1TgNqsBnKOJ-_T6NZ8Q9H5EKiuJUN8W8jCi8aw>
    <xmx:P4WZZtxUhHDJygx_Rw8-pqcwKOuXR55NWW2tV7dv7L71iVRnmrrg2jKh>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jul 2024 17:12:30 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 522A49FC9E; Thu, 18 Jul 2024 14:12:29 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 512FA9FC9B;
	Thu, 18 Jul 2024 14:12:29 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Johannes Berg <johannes@sipsolutions.net>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
    Johannes Berg <johannes.berg@intel.com>,
    syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH 2/2] net: bonding: don't call ethtool methods under
 RCU
In-reply-to: 
 <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>
References: 
 <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
 <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>
Comments: In-reply-to Johannes Berg <johannes@sipsolutions.net>
   message dated "Thu, 18 Jul 2024 12:20:17 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2649493.1721337149.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jul 2024 14:12:29 -0700
Message-ID: <2649494.1721337149@famine>

Johannes Berg <johannes@sipsolutions.net> wrote:

>From: Johannes Berg <johannes.berg@intel.com>
>
>Currently, bond_miimon_inspect() is called under RCU, but it
>calls ethtool ops. Since my earlier commit facd15dfd691
>("net: core: synchronize link-watch when carrier is queried")
>this is no longer permitted in the general ethtool case, but
>it was already not permitted for many drivers such as USB in
>which it can sleep to do MDIO register accesses etc.
>
>Therefore, it's better to simply not do this. Change bonding
>to acquire the RTNL for the MII monitor work directly to call
>the bond_miimon_inspect() function and thus ethtool ops.

	We can't do this, as it will hit RTNL every monitor interval,
which can be many times per second.  The logic is structured to
specifically avoid acquiring RTNL during the inspection pass.

	The issue that szybot is seeing only happens if bonding's
use_carrier option is set to 0, which is not the normal case.
use_carrier is a backwards compatibility option from years ago for
drivers that do not implement netif_carrier_on/off (and thus calling
netif_carrier_ok() would be unreliable).

	This also came up in [0], and looking now I see there's a patch
that syzbot tested, although I haven't reviewed it.

	Another option is to for the Powers That Be to declare that it's
safe to assume that network drivers implement netif_carrier_on/off to
advertise their link state, in which case the use_carrier logic in
bonding can be removed.

	Or we can somehow isolate the "must acquire RTNL instead of RCU"
to the problematic use_carrier=3D0 path, but that's a nontrivial change.

	-J

[0] https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/

>Reported-by: syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
>Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>---
> drivers/net/bonding/bond_main.c | 49 +++++++++++----------------------
> 1 file changed, 16 insertions(+), 33 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 2ed0da068490..6a635c23b00e 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2576,7 +2576,6 @@ static int bond_slave_info_query(struct net_device =
*bond_dev, struct ifslave *in
> =

> /*-------------------------------- Monitoring --------------------------=
-----*/
> =

>-/* called with rcu_read_lock() */
> static int bond_miimon_inspect(struct bonding *bond)
> {
> 	bool ignore_updelay =3D false;
>@@ -2585,17 +2584,17 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
> 	struct slave *slave;
> =

> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP) {
>-		ignore_updelay =3D !rcu_dereference(bond->curr_active_slave);
>+		ignore_updelay =3D !rcu_access_pointer(bond->curr_active_slave);
> 	} else {
> 		struct bond_up_slave *usable_slaves;
> =

>-		usable_slaves =3D rcu_dereference(bond->usable_slaves);
>+		usable_slaves =3D rtnl_dereference(bond->usable_slaves);
> =

> 		if (usable_slaves && usable_slaves->count =3D=3D 0)
> 			ignore_updelay =3D true;
> 	}
> =

>-	bond_for_each_slave_rcu(bond, slave, iter) {
>+	bond_for_each_slave(bond, slave, iter) {
> 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
> =

> 		link_state =3D bond_check_dev_link(bond, slave->dev, 0);
>@@ -2807,8 +2806,7 @@ static void bond_mii_monitor(struct work_struct *wo=
rk)
> {
> 	struct bonding *bond =3D container_of(work, struct bonding,
> 					    mii_work.work);
>-	bool should_notify_peers =3D false;
>-	bool commit;
>+	bool should_notify_peers;
> 	unsigned long delay;
> 	struct slave *slave;
> 	struct list_head *iter;
>@@ -2818,45 +2816,30 @@ static void bond_mii_monitor(struct work_struct *=
work)
> 	if (!bond_has_slaves(bond))
> 		goto re_arm;
> =

>-	rcu_read_lock();
>-	should_notify_peers =3D bond_should_notify_peers(bond);
>-	commit =3D !!bond_miimon_inspect(bond);
>-	if (bond->send_peer_notif) {
>-		rcu_read_unlock();
>-		if (rtnl_trylock()) {
>-			bond->send_peer_notif--;
>-			rtnl_unlock();
>-		}
>-	} else {
>-		rcu_read_unlock();
>+	/* deadlock avoidance with bond_close cancel of workqueue */
>+	if (!rtnl_trylock()) {
>+		delay =3D 1;
>+		goto re_arm;
> 	}
> =

>-	if (commit) {
>-		/* Race avoidance with bond_close cancel of workqueue */
>-		if (!rtnl_trylock()) {
>-			delay =3D 1;
>-			should_notify_peers =3D false;
>-			goto re_arm;
>-		}
>+	should_notify_peers =3D bond_should_notify_peers(bond);
> =

>+	if (bond_miimon_inspect(bond)) {
> 		bond_for_each_slave(bond, slave, iter) {
> 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
> 		}
> 		bond_miimon_commit(bond);
>-
>-		rtnl_unlock();	/* might sleep, hold no other locks */
> 	}
> =

>+	if (bond->send_peer_notif)
>+		bond->send_peer_notif--;
>+	if (should_notify_peers)
>+		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>+	rtnl_unlock();	/* might sleep, hold no other locks */
>+
> re_arm:
> 	if (bond->params.miimon)
> 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
>-
>-	if (should_notify_peers) {
>-		if (!rtnl_trylock())
>-			return;
>-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
>-		rtnl_unlock();
>-	}
> }
> =

> static int bond_upper_dev_walk(struct net_device *upper,
>-- =

>2.45.2
>
>

---
	-Jay Vosburgh, jv@jvosburgh.net

