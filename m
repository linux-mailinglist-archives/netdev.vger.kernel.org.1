Return-Path: <netdev+bounces-198320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F06ADBD7A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2B17093B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328E4194A60;
	Mon, 16 Jun 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Yx0No1ny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YT/6Mdb4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DD1F4611
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115765; cv=none; b=jlFmBS36FXaYLBrQctcu1o84c+MUyJnpQq3JMKdu+dm0eoJ+7eF+ShnMqvK0rrZp4V4zFW615xS4GPJO827/fgO4raJrzWCmbLr3zPp1eXVktkTTmgJDJD0XOsUfxyZ0TvadXZexOATs0Sm3kHt1JDGLoQQlK4MvjxVnU/w2a1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115765; c=relaxed/simple;
	bh=+ApUlBAthbr7FVBwhNSNAWAF4lty2jozelflDmOgYFE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=r9C03NjjzhZKbUa++1vkoTsbwyCPXurqvIP0PghFMcxcbNbxd5KWCVY3rsfRlAYmTP787eMlW0GwM7/ZxDQomWG5x1cDNUSlisW+Lpgc4H3efGyNz7WDUtTxNUrhHk4Zth42ieeIkgcxFaqlDPxztBAVZnKtMJQLr06MvzphjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Yx0No1ny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YT/6Mdb4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58E5C114015C;
	Mon, 16 Jun 2025 19:16:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 16 Jun 2025 19:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750115760; x=1750202160; bh=NhXr1nCmIiDFJn7gvG/TX
	eAsFDMJWUKXggX5dl1yACU=; b=Yx0No1ny3nCj3mE01Z8NKSUqIgkyzL3ThW7SO
	Si09YDzOainXERqorTcfR6rD48KqddJSM+WPl9gruYnZ+aMXWDzKoyMJD44gkKDI
	EBbweFmhfWCNUyeue2wlxmSn3215BJeVz2prwkC1Rib4F7pXweL/zUfz7lEJzoFZ
	ObJPO8bQ0R7Fo2lU3FmkKFSHK5RqZMsXtbMFSvsWzYbZJU68G3ktIDH3JUUaoI/C
	tikslggq8mPqsmhHSwWfYOfU4d0uDT3Ebe0gFfNMkEgPGQZj564q042kls7nkfkM
	eG7VzD8r9EZLZ169vvzS8CW1hSjHfoCajcuIZ4dHiC7zPl5eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750115760; x=1750202160; bh=NhXr1nCmIiDFJn7gvG/TXeAsFDMJWUKXggX
	5dl1yACU=; b=YT/6Mdb4JStKfVDLCw7l7m8nB1B/RK8bKCFnwuj2CbbqLnXIy9n
	ncvBxuyLzeRikA+qhHaph2Wbuwjm7aL/ogTfKdZuKaYlnH+7EpH7nIEOufnSzhxM
	4dm5BeY53G1o467t6oEE1jr0GfdYW9+bcgKK24LwRJOcSDhXKto6E5/PKVlW9OXj
	+uFf4EnCz8m3rlU3EI1GzFyETXyRIXFiyNZd4y1d1WmjC8T/LZDRheF0CFsE4NXm
	72624UnGWiUTGybcUxQKP3gNfuFlP8f4GKADyiKZiY8zcrwn2NvuH6aoc3B01/Fz
	vjtyF3a+QHOTBVh2gSaGpX6YXCP7TEYabbg==
X-ME-Sender: <xms:r6VQaEwjF5tydYM77E_VQWhSsbxueIZE--IuXZaC5w8DOfveGWG6IA>
    <xme:r6VQaIRrlow9u_U44l8rmp5UN1GMPayHDeeZp-RDelpkcQglS5VIqm4AATj6GrALI
    SrlNNgKv5P71l5DWOg>
X-ME-Received: <xmr:r6VQaGW3tI1bjVMaJI3C-2EZSB0g30BdcG5LczntJ0iwM6hel0eagJNBD4syzx2DFIAZZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeeifedvleefleejveethfefieduueeivdefieev
    leffuddvveeftdehffffteefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhrrgguvggvphhssehlih
    hnuhigrdhvnhgvthdrihgsmhdrtghomhdprhgtphhtthhopehirdhmrgigihhmvghtshes
    ohhvnhdrohhrghdprhgtphhtthhopegrmhhorhgvnhhoiiesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohephhgrlhhiuhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhrrggu
    vggvphesuhhsrdhisghmrdgtohhmpdhrtghpthhtohepfihilhguvghrsehushdrihgsmh
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r6VQaChAtp58DIQuxzA6mR0DJW5h-t2JSq4eOC96m8VJm6kx4wzfeA>
    <xmx:r6VQaGAFYWKyaYTN9fQk7cTfn_LEksKT9ZrBBeZxJIrW3ms4UExtWg>
    <xmx:r6VQaDImisOExTZthdhZ9Itu-YDCugJ3jwpMx7uV8PIjt9OIDk7azQ>
    <xmx:r6VQaNDA2GQAr3noh6FDviMDk6XO9CgaiGE_WqckX2ZvshlhFI6dDA>
    <xmx:sKVQaAYaZTUSJhNo7Iim7FdcejrM6JNuYzIfOOxEWjwbHqWYLa51tXsY>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 19:15:59 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 15DC69FCA5; Mon, 16 Jun 2025 16:15:58 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 128779FC7E;
	Mon, 16 Jun 2025 16:15:58 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: netdev@vger.kernel.org, pradeeps@linux.vnet.ibm.com,
    pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
    haliu@redhat.com
Subject: Re: [PATCH net-next v3 2/4] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
In-reply-to: <20250614014900.226472-3-wilder@us.ibm.com>
References: <20250614014900.226472-1-wilder@us.ibm.com>
 <20250614014900.226472-3-wilder@us.ibm.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Fri, 13 Jun 2025 18:48:28 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1928186.1750115758.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jun 2025 16:15:58 -0700
Message-ID: <1928187.1750115758@famine>

David Wilder <wilder@us.ibm.com> wrote:

>This change extends the "arp_ip_target" parameter format to allow for a
>list of vlan tags to be included for each arp target. This new list of
>tags is optional and may be omitted to preserve the current format and
>process of gathering tags.  When provided the list of tags circumvents
>the process of gathering tags by using the supplied list. An empty list
>can be provided to simply skip the process of gathering tags.
>
>An update to iproute is required to use this change.
>
>Signed-off-by: David Wilder <wilder@us.ibm.com>
>---
> drivers/net/bonding/bond_main.c    |  51 +++++-----
> drivers/net/bonding/bond_netlink.c |  11 ++-
> drivers/net/bonding/bond_options.c |  57 ++++++-----
> drivers/net/bonding/bond_procfs.c  |   5 +-
> drivers/net/bonding/bond_sysfs.c   |   9 +-
> include/net/bonding.h              | 146 +++++++++++++++++++++++++++++
> 6 files changed, 229 insertions(+), 50 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index ac654b384ea1..a26e17bdcc48 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3029,8 +3029,6 @@ static bool bond_has_this_ip(struct bonding *bond, =
__be32 ip)
> 	return ret;
> }
> =

>-#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
>-
> static bool bond_handle_vlan(struct slave *slave, struct bond_vlan_tag *=
tags,
> 			     struct sk_buff *skb)
> {
>@@ -3144,22 +3142,24 @@ struct bond_vlan_tag *bond_verify_device_path(str=
uct net_device *start_dev,
> =

> static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
> {
>-	struct rtable *rt;
>-	struct bond_vlan_tag *tags;
> 	struct bond_arp_target *targets =3D bond->params.arp_targets;
>+	struct bond_vlan_tag *tags;
> 	__be32 target_ip, addr;
>+	struct rtable *rt;
> 	int i;
> =

> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
> 		target_ip =3D targets[i].target_ip;
> 		tags =3D targets[i].tags;
>+		char pbuf[BOND_OPTION_STRING_MAX_SIZE];
> =

>-		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
>-			  __func__, &target_ip);
>+		bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf));
>+		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__, pbuf);

	As an aside to my main question, below, I'll point out here that
the target is going to be put into a string even if debug is disabled.

> =

> 		/* Find out through which dev should the packet go */
> 		rt =3D ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
> 				     RT_SCOPE_LINK);
>+
> 		if (IS_ERR(rt)) {
> 			/* there's no route to target_ip - try to send arp
> 			 * probe to generate any traffic (arp_validate=3D0)
>@@ -3177,9 +3177,13 @@ static void bond_arp_send_all(struct bonding *bond=
, struct slave *slave)
> 		if (rt->dst.dev =3D=3D bond->dev)
> 			goto found;
> =

>-		rcu_read_lock();
>-		tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0);
>-		rcu_read_unlock();
>+		if (!tags) {
>+			rcu_read_lock();
>+			tags =3D bond_verify_device_path(bond->dev, rt->dst.dev, 0);
>+			/* cache the tags */
>+			targets[i].tags =3D tags;
>+			rcu_read_unlock();
>+		}
> =

> 		if (!IS_ERR_OR_NULL(tags))
> 			goto found;
>@@ -3195,7 +3199,6 @@ static void bond_arp_send_all(struct bonding *bond,=
 struct slave *slave)
> 		addr =3D bond_confirm_addr(rt->dst.dev, target_ip, 0);
> 		ip_rt_put(rt);
> 		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
>-		kfree(tags);
> 	}
> }
> =

>@@ -6077,6 +6080,7 @@ static void bond_uninit(struct net_device *bond_dev=
)
> 	bond_for_each_slave(bond, slave, iter)
> 		__bond_release_one(bond_dev, slave->dev, true, true);
> 	netdev_info(bond_dev, "Released all slaves\n");
>+	bond_free_vlan_tags(bond->params.arp_targets);
> =

> #ifdef CONFIG_XFRM_OFFLOAD
> 	mutex_destroy(&bond->ipsec_lock);
>@@ -6283,21 +6287,26 @@ static int __init bond_check_params(struct bond_p=
arams *params)
> =

> 	for (arp_ip_count =3D 0, i =3D 0;
> 	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
>-		__be32 ip;
>+		struct bond_arp_target tmp_arp_target;
> =

>-		/* not a complete check, but good enough to catch mistakes */
>-		if (!in4_pton(arp_ip_target[i], -1, (u8 *)&ip, -1, NULL) ||
>-		    !bond_is_ip_target_ok(ip)) {
>+		if (bond_arp_ip_target_opt_parse(arp_ip_target[i], &tmp_arp_target)) {
> 			pr_warn("Warning: bad arp_ip_target module parameter (%s), ARP monito=
ring will not be performed\n",
> 				arp_ip_target[i]);
> 			arp_interval =3D 0;
>-		} else {
>-			if (bond_get_targets_ip(arp_target, ip) =3D=3D -1)
>-				arp_target[arp_ip_count++].target_ip =3D ip;
>-			else
>-				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\=
n",
>-					&ip);
>+			break;
> 		}
>+
>+		if (bond_get_targets_ip(arp_target, tmp_arp_target.target_ip) !=3D -1)=
 {
>+			pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n=
",
>+				&tmp_arp_target.target_ip);
>+			kfree(tmp_arp_target.tags);
>+			continue;
>+		}
>+
>+		arp_target[i].target_ip =3D tmp_arp_target.target_ip;
>+		arp_target[i].tags =3D tmp_arp_target.tags;
>+		arp_target[i].flags |=3D BOND_TARGET_DONTFREE;
>+		++arp_ip_count;
> 	}
> =

> 	if (arp_interval && !arp_ip_count) {
>@@ -6663,7 +6672,7 @@ static void __exit bonding_exit(void)
> =

> 	bond_netlink_fini();
> 	unregister_pernet_subsys(&bond_net_ops);
>-
>+	bond_free_vlan_tags_all(bonding_defaults.arp_targets);
> 	bond_destroy_debugfs();
> =

> #ifdef CONFIG_NET_POLL_CONTROLLER
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index 1a3d17754c0a..bab980e84c08 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -287,14 +287,21 @@ static int bond_changelink(struct net_device *bond_=
dev, struct nlattr *tb[],
> =

> 		bond_option_arp_ip_targets_clear(bond);
> 		nla_for_each_nested(attr, data[IFLA_BOND_ARP_IP_TARGET], rem) {
>+			char target_str[BOND_OPTION_STRING_MAX_SIZE];
> 			__be32 target;
> =

> 			if (nla_len(attr) < sizeof(target))
> 				return -EINVAL;
> =

>-			target =3D nla_get_be32(attr);
>+			if (nla_len(attr) > sizeof(target)) {
>+				snprintf(target_str, sizeof(target_str),
>+					 "%s%s", "+", (__force char *)nla_data(attr));
>+				bond_opt_initstr(&newval, target_str);
>+			} else {
>+				target =3D nla_get_be32(attr);
>+				bond_opt_initval(&newval, (__force u64)target);
>+			}

	Here, and further down in bond_arp_ip_target_opt_parse(),
there's a lot of string handling that seems out place.  Why isn't the
string parsing done in user space (iproute, et al), and the tags passed
to the kernel in IFLA_BOND_ARP_IP_TARGET as an optional nested
attribute?

> =

>-			bond_opt_initval(&newval, (__force u64)target);
> 			err =3D __bond_opt_set(bond, BOND_OPT_ARP_TARGETS,
> 					     &newval,
> 					     data[IFLA_BOND_ARP_IP_TARGET],
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index e4b7eb376575..42a11483320c 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -31,8 +31,8 @@ static int bond_option_use_carrier_set(struct bonding *=
bond,
> 				       const struct bond_opt_value *newval);
> static int bond_option_arp_interval_set(struct bonding *bond,
> 					const struct bond_opt_value *newval);
>-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 ta=
rget);
>-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 ta=
rget);
>+static int bond_option_arp_ip_target_add(struct bonding *bond, struct bo=
nd_arp_target target);
>+static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bo=
nd_arp_target target);
> static int bond_option_arp_ip_targets_set(struct bonding *bond,
> 					  const struct bond_opt_value *newval);
> static int bond_option_ns_ip6_targets_set(struct bonding *bond,
>@@ -1115,7 +1115,7 @@ static int bond_option_arp_interval_set(struct bond=
ing *bond,
> }
> =

> static void _bond_options_arp_ip_target_set(struct bonding *bond, int sl=
ot,
>-					    __be32 target,
>+					    struct bond_arp_target target,
> 					    unsigned long last_rx)
> {
> 	struct bond_arp_target *targets =3D bond->params.arp_targets;
>@@ -1125,24 +1125,24 @@ static void _bond_options_arp_ip_target_set(struc=
t bonding *bond, int slot,
> 	if (slot >=3D 0 && slot < BOND_MAX_ARP_TARGETS) {
> 		bond_for_each_slave(bond, slave, iter)
> 			slave->target_last_arp_rx[slot] =3D last_rx;
>-		targets[slot].target_ip =3D target;
>+		memcpy(&targets[slot], &target, sizeof(target));
> 	}
> }
> =

>-static int _bond_option_arp_ip_target_add(struct bonding *bond, __be32 t=
arget)
>+static int _bond_option_arp_ip_target_add(struct bonding *bond, struct b=
ond_arp_target target)
> {
> 	struct bond_arp_target *targets =3D bond->params.arp_targets;
> 	int ind;
> =

>-	if (!bond_is_ip_target_ok(target)) {
>+	if (!bond_is_ip_target_ok(target.target_ip)) {
> 		netdev_err(bond->dev, "invalid ARP target %pI4 specified for addition\=
n",
>-			   &target);
>+			   &target.target_ip);
> 		return -EINVAL;
> 	}
> =

>-	if (bond_get_targets_ip(targets, target) !=3D -1) { /* dup */
>+	if (bond_get_targets_ip(targets, target.target_ip) !=3D -1) { /* dup */
> 		netdev_err(bond->dev, "ARP target %pI4 is already present\n",
>-			   &target);
>+			   &target.target_ip);
> 		return -EINVAL;
> 	}
> =

>@@ -1152,19 +1152,19 @@ static int _bond_option_arp_ip_target_add(struct =
bonding *bond, __be32 target)
> 		return -EINVAL;
> 	}
> =

>-	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target);
>+	netdev_dbg(bond->dev, "Adding ARP target %pI4\n", &target.target_ip);
> =

> 	_bond_options_arp_ip_target_set(bond, ind, target, jiffies);
> =

> 	return 0;
> }
> =

>-static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 ta=
rget)
>+static int bond_option_arp_ip_target_add(struct bonding *bond, struct bo=
nd_arp_target target)
> {
> 	return _bond_option_arp_ip_target_add(bond, target);
> }
> =

>-static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 ta=
rget)
>+static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bo=
nd_arp_target target)
> {
> 	struct bond_arp_target *targets =3D bond->params.arp_targets;
> 	struct list_head *iter;
>@@ -1172,23 +1172,23 @@ static int bond_option_arp_ip_target_rem(struct b=
onding *bond, __be32 target)
> 	unsigned long *targets_rx;
> 	int ind, i;
> =

>-	if (!bond_is_ip_target_ok(target)) {
>+	if (!bond_is_ip_target_ok(target.target_ip)) {
> 		netdev_err(bond->dev, "invalid ARP target %pI4 specified for removal\n=
",
>-			   &target);
>+			   &target.target_ip);
> 		return -EINVAL;
> 	}
> =

>-	ind =3D bond_get_targets_ip(targets, target);
>+	ind =3D bond_get_targets_ip(targets, target.target_ip);
> 	if (ind =3D=3D -1) {
> 		netdev_err(bond->dev, "unable to remove nonexistent ARP target %pI4\n"=
,
>-			   &target);
>+			   &target.target_ip);
> 		return -EINVAL;
> 	}
> =

> 	if (ind =3D=3D 0 && !targets[1].target_ip && bond->params.arp_interval)
> 		netdev_warn(bond->dev, "Removing last arp target with arp_interval on\=
n");
> =

>-	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target);
>+	netdev_dbg(bond->dev, "Removing ARP target %pI4\n", &target.target_ip);
> =

> 	bond_for_each_slave(bond, slave, iter) {
> 		targets_rx =3D slave->target_last_arp_rx;
>@@ -1196,9 +1196,16 @@ static int bond_option_arp_ip_target_rem(struct bo=
nding *bond, __be32 target)
> 			targets_rx[i] =3D targets_rx[i+1];
> 		targets_rx[i] =3D 0;
> 	}
>-	for (i =3D ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target=
_ip; i++)
>-		targets[i] =3D targets[i+1];
>+
>+	bond_free_vlan_tag(&targets[ind]);
>+
>+	for (i =3D ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target=
_ip; i++) {
>+		targets[i].target_ip =3D targets[i + 1].target_ip;
>+		targets[i].tags =3D targets[i + 1].tags;
>+		targets[i].flags =3D targets[i + 1].flags;
>+	}
> 	targets[i].target_ip =3D 0;
>+	targets[i].tags =3D NULL;
> =

> 	return 0;
> }
>@@ -1206,20 +1213,24 @@ static int bond_option_arp_ip_target_rem(struct b=
onding *bond, __be32 target)
> void bond_option_arp_ip_targets_clear(struct bonding *bond)
> {
> 	int i;
>+	struct bond_arp_target empty_target;
>+
>+	empty_target.target_ip =3D 0;
>+	empty_target.tags =3D NULL;
> =

> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++)
>-		_bond_options_arp_ip_target_set(bond, i, 0, 0);
>+		_bond_options_arp_ip_target_set(bond, i, empty_target, 0);
> }
> =

> static int bond_option_arp_ip_targets_set(struct bonding *bond,
> 					  const struct bond_opt_value *newval)
> {
> 	int ret =3D -EPERM;
>-	__be32 target;
>+	struct bond_arp_target target;
> =

> 	if (newval->string) {
> 		if (strlen(newval->string) < 1 ||
>-		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
>+		    bond_arp_ip_target_opt_parse(newval->string + 1, &target)) {
> 			netdev_err(bond->dev, "invalid ARP target specified\n");
> 			return ret;
> 		}
>@@ -1230,7 +1241,7 @@ static int bond_option_arp_ip_targets_set(struct bo=
nding *bond,
> 		else
> 			netdev_err(bond->dev, "no command found in arp_ip_targets file - use =
+<addr> or -<addr>\n");
> 	} else {
>-		target =3D newval->value;
>+		target.target_ip =3D newval->value;
> 		ret =3D bond_option_arp_ip_target_add(bond, target);
> 	}
> =

>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond=
_procfs.c
>index 94e6fd7041ee..b07944396912 100644
>--- a/drivers/net/bonding/bond_procfs.c
>+++ b/drivers/net/bonding/bond_procfs.c
>@@ -111,6 +111,7 @@ static void bond_info_show_master(struct seq_file *se=
q)
> =

> 	/* ARP information */
> 	if (bond->params.arp_interval > 0) {
>+		char pbuf[BOND_OPTION_STRING_MAX_SIZE];
> 		int printed =3D 0;
> =

> 		seq_printf(seq, "ARP Polling Interval (ms): %d\n",
>@@ -125,7 +126,9 @@ static void bond_info_show_master(struct seq_file *se=
q)
> 				break;
> 			if (printed)
> 				seq_printf(seq, ",");
>-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i].target_ip);
>+			bond_arp_target_to_string(&bond->params.arp_targets[i],
>+						  pbuf, sizeof(pbuf));
>+			seq_printf(seq, " %s", pbuf);
> 			printed =3D 1;
> 		}
> 		seq_printf(seq, "\n");
>diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
>index d7c09e0a14dd..feff53e69bd3 100644
>--- a/drivers/net/bonding/bond_sysfs.c
>+++ b/drivers/net/bonding/bond_sysfs.c
>@@ -288,11 +288,14 @@ static ssize_t bonding_show_arp_targets(struct devi=
ce *d,
> {
> 	struct bonding *bond =3D to_bond(d);
> 	int i, res =3D 0;
>+	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
> =

> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++) {
>-		if (bond->params.arp_targets[i].target_ip)
>-			res +=3D sysfs_emit_at(buf, res, "%pI4 ",
>-					     &bond->params.arp_targets[i].target_ip);
>+		if (bond->params.arp_targets[i].target_ip) {
>+			bond_arp_target_to_string(&bond->params.arp_targets[i],
>+						  pbuf, sizeof(pbuf));
>+			res +=3D sysfs_emit_at(buf, res, "%s ", pbuf);
>+		}

	There is no expectation that sysfs should support new bonding
API elements; only netlink / iproute2 support matters.  If sysfs is the
reason to do the string parsing in the kernel, then I imagine this could
all move into userspace.

	-J

> 	}
> 	if (res)
> 		buf[res-1] =3D '\n'; /* eat the leftover space */
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 5b4c43f02c89..2067aa4df123 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -23,6 +23,7 @@
> #include <linux/etherdevice.h>
> #include <linux/reciprocal_div.h>
> #include <linux/if_link.h>
>+#include <linux/inet.h>
> =

> #include <net/bond_3ad.h>
> #include <net/bond_alb.h>
>@@ -787,6 +788,151 @@ static inline int bond_get_targets_ip6(struct in6_a=
ddr *targets, struct in6_addr
> }
> #endif
> =

>+#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
>+#define BOND_OPTION_STRING_MAX_SIZE 256
>+
>+/* Convert vlan_list into struct bond_vlan_tag.
>+ * Inspired by bond_verify_device_path();
>+ */
>+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list=
, int level)
>+{
>+	struct bond_vlan_tag *tags;
>+	char *vlan;
>+
>+	if (!vlan_list || strlen(vlan_list) =3D=3D 0) {
>+		tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);
>+		if (!tags)
>+			return ERR_PTR(-ENOMEM);
>+		tags[level].vlan_proto =3D BOND_VLAN_PROTO_NONE;
>+		return tags;
>+	}
>+
>+	for (vlan =3D strsep(&vlan_list, "/"); (vlan !=3D 0); level++) {
>+		tags =3D bond_vlan_tags_parse(vlan_list, level + 1);
>+		if (IS_ERR_OR_NULL(tags)) {
>+			if (IS_ERR(tags))
>+				return tags;
>+			continue;
>+		}
>+
>+		tags[level].vlan_proto =3D __cpu_to_be16(ETH_P_8021Q);
>+		if (kstrtou16(vlan, 0, &tags[level].vlan_id)) {
>+			kfree(tags);
>+			return ERR_PTR(-EINVAL);
>+		}
>+
>+		if (tags[level].vlan_id < 1 || tags[level].vlan_id > 4094) {
>+			kfree(tags);
>+			return ERR_PTR(-EINVAL);
>+		}
>+
>+		return tags;
>+	}
>+
>+	return NULL;
>+}
>+
>+/**
>+ * bond_arp_ip_target_opt_parse - parse a single arp_ip_target option va=
lue string
>+ * @src: the option value to be parsed
>+ * @dest: struct bond_arp_target to place the results.
>+ *
>+ * This function parses a single arp_ip_target string in the form:
>+ * x.x.x.x[tag/....] into a struct bond_arp_target.
>+ * Returns 0 on success.
>+ */
>+static inline int bond_arp_ip_target_opt_parse(char *src, struct bond_ar=
p_target *dest)
>+{
>+	char *ipv4, *vlan_list;
>+	char target[BOND_OPTION_STRING_MAX_SIZE], *args;
>+	struct bond_vlan_tag *tags =3D NULL;
>+	__be32 ip;
>+
>+	if (strlen(src) > BOND_OPTION_STRING_MAX_SIZE)
>+		return -E2BIG;
>+
>+	pr_debug("Parsing arp_ip_target (%s)\n", src);
>+
>+	/* copy arp_ip_target[i] to local array, strsep works
>+	 * destructively...
>+	 */
>+	args =3D target;
>+	strscpy(target, src);
>+	ipv4 =3D strsep(&args, "[");
>+
>+	/* not a complete check, but good enough to catch mistakes */
>+	if (!in4_pton(ipv4, -1, (u8 *)&ip, -1, NULL) ||
>+	    !bond_is_ip_target_ok(ip)) {
>+		return -EINVAL;
>+	}
>+
>+	/* extract vlan tags */
>+	vlan_list =3D strsep(&args, "]");
>+
>+	/* If a vlan list was not supplied skip the processing of the list.
>+	 * A value of "[]" is a valid list and should be handled a such.
>+	 */
>+	if (vlan_list) {
>+		tags =3D bond_vlan_tags_parse(vlan_list, 0);
>+		dest->flags |=3D BOND_TARGET_USERTAGS;
>+		if (IS_ERR(tags))
>+			return PTR_ERR(tags);
>+	}
>+
>+	dest->target_ip =3D ip;
>+	dest->tags =3D tags;
>+
>+	return 0;
>+}
>+
>+static inline int bond_arp_target_to_string(struct bond_arp_target *targ=
et,
>+					    char *buf, int size)
>+{
>+	struct bond_vlan_tag *tags =3D target->tags;
>+	int i, num =3D 0;
>+
>+	if (!(target->flags & BOND_TARGET_USERTAGS)) {
>+		num =3D snprintf(&buf[0], size, "%pI4", &target->target_ip);
>+		return num;
>+	}
>+
>+	num =3D snprintf(&buf[0], size, "%pI4[", &target->target_ip);
>+	if (tags) {
>+		for (i =3D 0; (tags[i].vlan_proto !=3D BOND_VLAN_PROTO_NONE); i++) {
>+			if (!tags[i].vlan_id)
>+				continue;
>+			if (i !=3D 0)
>+				num =3D num + snprintf(&buf[num], size-num, "/");
>+			num =3D num + snprintf(&buf[num], size-num, "%u",
>+					     tags[i].vlan_id);
>+		}
>+	}
>+	snprintf(&buf[num], size-num, "]");
>+	return num;
>+}
>+
>+static inline void bond_free_vlan_tag(struct bond_arp_target *target)
>+{
>+	if (!(target->flags & BOND_TARGET_DONTFREE))
>+		kfree(target->tags);
>+}
>+
>+static inline void __bond_free_vlan_tags(struct bond_arp_target *targets=
, int all)
>+{
>+	int i;
>+
>+	for (i =3D 0; i < BOND_MAX_ARP_TARGETS && targets[i].tags; i++) {
>+		if (!all)
>+			bond_free_vlan_tag(&targets[i]);
>+		else
>+			kfree(targets[i].tags);
>+	}
>+}
>+
>+#define bond_free_vlan_tags(targets)  __bond_free_vlan_tags(targets, 0)
>+#define bond_free_vlan_tags_all(targets) __bond_free_vlan_tags(targets, =
1)
>+
>+
> /* exported from bond_main.c */
> extern unsigned int bond_net_id;
> =

>-- =

>2.43.5
>

---
	-Jay Vosburgh, jv@jvosburgh.net

