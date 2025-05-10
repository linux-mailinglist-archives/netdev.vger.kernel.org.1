Return-Path: <netdev+bounces-189470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B381AB23EB
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698064A1D3A
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D84211710;
	Sat, 10 May 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="DNDi9WFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LD+1V8/S"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E6B644
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746883026; cv=none; b=aJVK9hUXkvu2iLEStGIkBqA5NmjRoQnH2QABr4IzIt0HsB6vjP6RoBUb1XIYci8E5awtZgEJUG2+x0FyfyO2Z8vRggFqouLT+GXvOEASkPo6krt1vhz2thfhn5EfK77gqfGJIKjuCqjoDGsz7FR6lFSzqww2vIm556A6C6SCvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746883026; c=relaxed/simple;
	bh=33IBCb1yfM0bJLP+0mdW9AlHS//fDulUO3xbbPXG1VI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ApSgOqIf4yiAApixwnbxbqIkCpsNi7GuYepWl4CjTMGXc3/1FOindj/EeQN2dRf+VVKvPZTiIsBulliEioDJ7pYCbdWiLAs/Sy7axROljhh257ap9U5vah3fXnuSRoijtzr1o9gzFxFsNoliJCWHTgXkjANkVxt6CeDRIZ5O/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=DNDi9WFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LD+1V8/S; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 043A0114014E;
	Sat, 10 May 2025 09:17:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 10 May 2025 09:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1746883021; x=1746969421; bh=Q7UZ89t4c3O1LHEp16WrP
	MIBzVWtKBSZvCfvGIpUwtI=; b=DNDi9WFxBlD3E8u//JslDnQsaIKtpIgsPGjEB
	xNOoZ17Ssn7f63RRt07H5L6SQU6kAQb0qrRkaZjauo3hD/mC/8flcEZv61UH63li
	kgn8LFPF5LwPF8mr85PS8XBRX9q9mxtEfdR5h8eciZof2WPLxwNgfdAdZKaipG5D
	K1hXre9lOidNANKCYsmIJXDK9yIQ5PdTU6Dt2kblKV8VRJwz2AFyf6ik3sVV6bja
	PBjGIIQwxjq3+G9npLIMQnY9JQMhqXxQwfNDv1fMWSkiSRfe3E5Lqs8NfWOPPtDP
	t20BtsCmzwsfvokDcOvEi3cUz38JpHIqrRk1m0E4T8IFUOwgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746883021; x=1746969421; bh=Q7UZ89t4c3O1LHEp16WrPMIBzVWtKBSZvCf
	vGIpUwtI=; b=LD+1V8/Sov3byS5KtnEDDWlt4qFI3NVM4Ofbfi4+BuuWN9haO1l
	KaT6N8G3rBuuejx3cNVgPvMq+hULwrkRA5W6w70aEi+4zuBGWr+5205PDODY36Ti
	IQYBO747BN5apfsZrBSaNDEVCIOW9CIanD9oNfbj4vsGAIGffvPqweBKzAAMCRSc
	AFNdPSbNipCF/7PtVTISLUnlNaZGOIH8p//levoeSRYrjQgznGCONsV7xspU19ZX
	SbJHGNmf9f3RGTX9/tzt3N01kTYErj9qJzCddaapB1+JEb7RTC7tdwYADvZFxRwH
	gHj2gT4I2Z91mC90aSxpsbs7E2sOi7KKMJQ==
X-ME-Sender: <xms:zVEfaO7fKhoC_9yrK_gom5V05ZdRPL3tomRqcPYFRHj4sPCvpCfLDw>
    <xme:zVEfaH5Iz8T2aofY8YjkPZ8PMWqyp3fXgjGtTtHCJU4g56xojIvU7R88FR7Nsuxdh
    GtqjMXmdQwyd3LRoaQ>
X-ME-Received: <xmr:zVEfaNdp6xYeCGjpshEk0wzsNart0Bk9ig_Wbzj4Kb5hbBkpzx1Ovv3vvXcYb4iQdYOLOsM->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleehiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgruggvvghpsheslh
    hinhhugidrvhhnvghtrdhisghmrdgtohhmpdhrtghpthhtohepihdrmhgrgihimhgvthhs
    sehovhhnrdhorhhgpdhrtghpthhtoheprghmohhrvghnohiisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehhrghlihhusehrvgguhhgrthdrtghomhdprhgtphhtthhopehprhgr
    uggvvghpsehushdrihgsmhdrtghomhdprhgtphhtthhopeifihhluggvrhesuhhsrdhisg
    hmrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zVEfaLKmaozSMKMnR7PL9hhkkirIwfuo_XV2yiFteGfrSdL4Di0DWA>
    <xmx:zVEfaCKqiN-r4MIZFeAYqL3iaMriqSwXNTfbX3qO1Vjh4YeSX7CIfA>
    <xmx:zVEfaMyYScrgT4b7c9J5mkcfWOxWvr4GZTLDlsW_3LhCFOKU_xUmKQ>
    <xmx:zVEfaGLoSndFhKfZIDhJCddMbLadHcI0pYwWQiWm8KxPZDZ6YDexzQ>
    <xmx:zVEfaACBTDtE7-yuJzwbW8TWi1qrZvVQNoIyclLyaZBDskWqsye9wYxW>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 May 2025 09:17:00 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 9324A1C007C; Sat, 10 May 2025 06:16:57 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 916F01C007B;
	Sat, 10 May 2025 15:16:57 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David J Wilder <wilder@us.ibm.com>
cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com
Subject: Re: [PATCH net-next v1 1/2] bonding: Adding struct arp_target
In-reply-to: <20250508183014.2554525-2-wilder@us.ibm.com>
References: <20250508183014.2554525-1-wilder@us.ibm.com> <20250508183014.2554525-2-wilder@us.ibm.com>
Comments: In-reply-to David J Wilder <wilder@us.ibm.com>
   message dated "Thu, 08 May 2025 11:29:28 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1134100.1746883017.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 May 2025 15:16:57 +0200
Message-ID: <1134101.1746883017@vermin>

David J Wilder <wilder@us.ibm.com> wrote:

>Replacing the definition of bond_params.arp_targets (__be32 arp_targets[]=
)
>with:
>
>struct arp_target {
>        __be32 target_ip;
>        struct bond_vlan_tag *tags;
>};

	Since this struct is only for bonding, perhaps "struct
bond_arp_target"?

>To provide storage for a list of vlan tags for each target.
>
>All references to arp_target are change to use the new structure.
>
>Signed-off-by: David J Wilder <wilder@us.ibm.com>
>---
> drivers/net/bonding/bond_main.c    | 29 ++++++++++++++++-------------
> drivers/net/bonding/bond_netlink.c |  4 ++--
> drivers/net/bonding/bond_options.c | 18 +++++++++---------
> drivers/net/bonding/bond_procfs.c  |  4 ++--
> drivers/net/bonding/bond_sysfs.c   |  4 ++--
> include/net/bonding.h              | 15 ++++++++++-----
> 6 files changed, 41 insertions(+), 33 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index d05226484c64..ab388dab218a 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3151,26 +3151,29 @@ static void bond_arp_send_all(struct bonding *bon=
d, struct slave *slave)
> {
> 	struct rtable *rt;
> 	struct bond_vlan_tag *tags;
>-	__be32 *targets =3D bond->params.arp_targets, addr;
>+	struct arp_target *targets =3D bond->params.arp_targets;
>+	__be32 target_ip, addr;
> 	int i;
> =

>-	for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i]; i++) {
>+	for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
>+		target_ip =3D targets[i].target_ip;
>+		tags =3D targets[i].tags;
>+
> 		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
>-			  __func__, &targets[i]);
>-		tags =3D NULL;
>+			  __func__, &target_ip);

	Perhaps add the tags to the debug message?  It might be kind of
a pain to format, but seems like it would be useful.

	-J

> =

> 		/* Find out through which dev should the packet go */
>-		rt =3D ip_route_output(dev_net(bond->dev), targets[i], 0, 0, 0,
>+		rt =3D ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
> 				     RT_SCOPE_LINK);
> 		if (IS_ERR(rt)) {
>-			/* there's no route to target - try to send arp
>+			/* there's no route to target_ip - try to send arp
> 			 * probe to generate any traffic (arp_validate=3D0)
> 			 */
> 			if (bond->params.arp_validate)
> 				pr_warn_once("%s: no route to arp_ip_target %pI4 and arp_validate is=
 set\n",
> 					     bond->dev->name,
>-					     &targets[i]);
>-			bond_arp_send(slave, ARPOP_REQUEST, targets[i],
>+					     &target_ip);
>+			bond_arp_send(slave, ARPOP_REQUEST, target_ip,
> 				      0, tags);
> 			continue;
> 		}
>@@ -3188,15 +3191,15 @@ static void bond_arp_send_all(struct bonding *bon=
d, struct slave *slave)
> =

> 		/* Not our device - skip */
> 		slave_dbg(bond->dev, slave->dev, "no path to arp_ip_target %pI4 via rt=
.dev %s\n",
>-			   &targets[i], rt->dst.dev ? rt->dst.dev->name : "NULL");
>+			   &target_ip, rt->dst.dev ? rt->dst.dev->name : "NULL");
> =

> 		ip_rt_put(rt);
> 		continue;
> =

> found:
>-		addr =3D bond_confirm_addr(rt->dst.dev, targets[i], 0);
>+		addr =3D bond_confirm_addr(rt->dst.dev, target_ip, 0);
> 		ip_rt_put(rt);
>-		bond_arp_send(slave, ARPOP_REQUEST, targets[i], addr, tags);
>+		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
> 		kfree(tags);
> 	}
> }
>@@ -6102,7 +6105,7 @@ static int __init bond_check_params(struct bond_par=
ams *params)
> 	int arp_all_targets_value =3D 0;
> 	u16 ad_actor_sys_prio =3D 0;
> 	u16 ad_user_port_key =3D 0;
>-	__be32 arp_target[BOND_MAX_ARP_TARGETS] =3D { 0 };
>+	struct arp_target arp_target[BOND_MAX_ARP_TARGETS] =3D { 0 };
> 	int arp_ip_count;
> 	int bond_mode	=3D BOND_MODE_ROUNDROBIN;
> 	int xmit_hashtype =3D BOND_XMIT_POLICY_LAYER2;
>@@ -6296,7 +6299,7 @@ static int __init bond_check_params(struct bond_par=
ams *params)
> 			arp_interval =3D 0;
> 		} else {
> 			if (bond_get_targets_ip(arp_target, ip) =3D=3D -1)
>-				arp_target[arp_ip_count++] =3D ip;
>+				arp_target[arp_ip_count++].target_ip =3D ip;
> 			else
> 				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\=
n",
> 					&ip);
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index ac5e402c34bc..1a3d17754c0a 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -688,8 +688,8 @@ static int bond_fill_info(struct sk_buff *skb,
> =

> 	targets_added =3D 0;
> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {
>-		if (bond->params.arp_targets[i]) {
>-			if (nla_put_be32(skb, i, bond->params.arp_targets[i]))
>+		if (bond->params.arp_targets[i].target_ip) {
>+			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
> 				goto nla_put_failure;
> 			targets_added =3D 1;
> 		}
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 91893c29b899..54940950079e 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1090,7 +1090,7 @@ static int bond_option_arp_interval_set(struct bond=
ing *bond,
> 			netdev_dbg(bond->dev, "ARP monitoring cannot be used with MII monitor=
ing. Disabling MII monitoring\n");
> 			bond->params.miimon =3D 0;
> 		}
>-		if (!bond->params.arp_targets[0])
>+		if (!bond->params.arp_targets[0].target_ip)
> 			netdev_dbg(bond->dev, "ARP monitoring has been set up, but no ARP tar=
gets have been specified\n");
> 	}
> 	if (bond->dev->flags & IFF_UP) {
>@@ -1118,20 +1118,20 @@ static void _bond_options_arp_ip_target_set(struc=
t bonding *bond, int slot,
> 					    __be32 target,
> 					    unsigned long last_rx)
> {
>-	__be32 *targets =3D bond->params.arp_targets;
>+	struct arp_target *targets =3D bond->params.arp_targets;
> 	struct list_head *iter;
> 	struct slave *slave;
> =

> 	if (slot >=3D 0 && slot < BOND_MAX_ARP_TARGETS) {
> 		bond_for_each_slave(bond, slave, iter)
> 			slave->target_last_arp_rx[slot] =3D last_rx;
>-		targets[slot] =3D target;
>+		targets[slot].target_ip =3D target;
> 	}
> }
> =

> static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 t=
arget)
> {
>-	__be32 *targets =3D bond->params.arp_targets;
>+	struct arp_target *targets =3D bond->params.arp_targets;
> 	int ind;
> =

> 	if (!bond_is_ip_target_ok(target)) {
>@@ -1166,7 +1166,7 @@ static int bond_option_arp_ip_target_add(struct bon=
ding *bond, __be32 target)
> =

> static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 ta=
rget)
> {
>-	__be32 *targets =3D bond->params.arp_targets;
>+	struct arp_target *targets =3D bond->params.arp_targets;
> 	struct list_head *iter;
> 	struct slave *slave;
> 	unsigned long *targets_rx;
>@@ -1185,20 +1185,20 @@ static int bond_option_arp_ip_target_rem(struct b=
onding *bond, __be32 target)
> 		return -EINVAL;
> 	}
> =

>-	if (ind =3D=3D 0 && !targets[1] && bond->params.arp_interval)
>+	if (ind =3D=3D 0 && !targets[1].target_ip && bond->params.arp_interval)
> 		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\=
n");
> =

> 	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
> =

> 	bond_for_each_slave(bond, slave, iter) {
> 		targets_rx =3D slave->target_last_arp_rx;
>-		for (i =3D ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
>+		for (i =3D ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].targe=
t_ip; i++)
> 			targets_rx[i] =3D targets_rx[i+1];
> 		targets_rx[i] =3D 0;
> 	}
>-	for (i =3D ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
>+	for (i =3D ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target=
_ip; i++)
> 		targets[i] =3D targets[i+1];
>-	targets[i] =3D 0;
>+	targets[i].target_ip =3D 0;
> =

> 	return 0;
> }
>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c
>index 7edf72ec816a..94e6fd7041ee 100644
>--- a/drivers/net/bonding/bond_procfs.c
>+++ b/drivers/net/bonding/bond_procfs.c
>@@ -121,11 +121,11 @@ static void bond_info_show_master(struct seq_file *=
seq)
> 		seq_printf(seq, "ARP IP target/s (n.n.n.n form):");
> =

> 		for (i =3D 0; (i < BOND_MAX_ARP_TARGETS); i++) {
>-			if (!bond->params.arp_targets[i])
>+			if (!bond->params.arp_targets[i].target_ip)
> 				break;
> 			if (printed)
> 				seq_printf(seq, ",");
>-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i]);
>+			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
> 			printed =3D 1;
> 		}
> 		seq_printf(seq, "\n");
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index 1e13bb170515..d7c09e0a14dd 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -290,9 +290,9 @@ static ssize_t bonding_show_arp_targets(struct device=
 *d,
> 	int i, res =3D 0;
> =

> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {
>-		if (bond->params.arp_targets[i])
>+		if (bond->params.arp_targets[i].target_ip)
> 			res +=3D sysfs_emit_at(buf, res, "%pI4 ",
>-					     &bond->params.arp_targets[i]);
>+					     &bond->params.arp_targets[i].target_ip);
> 	}
> 	if (res)
> 		buf[res-1] =3D '\n'; /* eat the leftover space */
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 95f67b308c19..709ef9a302dd 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -115,6 +115,11 @@ static inline int is_netpoll_tx_blocked(struct net_d=
evice *dev)
> #define is_netpoll_tx_blocked(dev) (0)
> #endif
> =

>+struct arp_target {
>+	__be32 target_ip;
>+	struct bond_vlan_tag *tags;
>+};
>+
> struct bond_params {
> 	int mode;
> 	int xmit_policy;
>@@ -135,7 +140,7 @@ struct bond_params {
> 	int ad_select;
> 	char primary[IFNAMSIZ];
> 	int primary_reselect;
>-	__be32 arp_targets[BOND_MAX_ARP_TARGETS];
>+	struct arp_target arp_targets[BOND_MAX_ARP_TARGETS];
> 	int tx_queues;
> 	int all_slaves_active;
> 	int resend_igmp;
>@@ -522,7 +527,7 @@ static inline unsigned long slave_oldest_target_arp_r=
x(struct bonding *bond,
> 	int i =3D 1;
> 	unsigned long ret =3D slave->target_last_arp_rx[0];
> =

>-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
>+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i].target=
_ip; i++)
> 		if (time_before(slave->target_last_arp_rx[i], ret))
> 			ret =3D slave->target_last_arp_rx[i];
> =

>@@ -760,14 +765,14 @@ static inline bool bond_slave_has_mac_rcu(struct bo=
nding *bond, const u8 *mac)
> /* Check if the ip is present in arp ip list, or first free slot if ip =3D=
=3D 0
>  * Returns -1 if not found, index if found
>  */
>-static inline int bond_get_targets_ip(__be32 *targets, __be32 ip)
>+static inline int bond_get_targets_ip(struct arp_target *targets, __be32=
 ip)
> {
> 	int i;
> =

> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++)
>-		if (targets[i] =3D=3D ip)
>+		if (targets[i].target_ip =3D=3D ip)
> 			return i;
>-		else if (targets[i] =3D=3D 0)
>+		else if (targets[i].target_ip =3D=3D 0)
> 			break;
> =

> 	return -1;
>-- =

>2.43.5
>

---
	-Jay Vosburgh, jv@jvosburgh.net

