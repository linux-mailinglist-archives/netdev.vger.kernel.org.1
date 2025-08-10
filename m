Return-Path: <netdev+bounces-212368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A8B1FB2F
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15C917742A
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912252571C7;
	Sun, 10 Aug 2025 16:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768012033A;
	Sun, 10 Aug 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844917; cv=none; b=AHRONu8AXSD9CGY8tz21rRfPsOg7d2Dw3sB2sN/hXTNM4ZxWRUAuqqW2XanpAKbzE4TXDSjsV09TwRl98mFLmElbkLlyDXBwVEfecSle/Rk2iEtz1uG2rEnFdL2fjvWNYyqqSckNm1blM1j5QjXMV2yKHz4ZSFond+r8sK5+N54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844917; c=relaxed/simple;
	bh=r7wmBAXARc6iJoSNQFqQIZQwQ2uaQmOHxJt+UfLQwwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEdaRjmR99toVVIwcCCguaK3CFXn86ENH9yYDF3T6LcC7mogHKtSnLHJ5a8Qr4AJIyFducJtfGehYN/vp8UChlqIrxpzZq9C6keWcAxOZO+eqAGg6P/3/1PjH34VFJq15NLEa5oruI88zsj42rOJsYmeF+6NdPXXM3XkxDAmMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ul9K5-000000005F6-2cqC;
	Sun, 10 Aug 2025 16:55:05 +0000
Date: Sun, 10 Aug 2025 17:54:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH/RFC net] net: dsa: lantiq_gswip: honor dsa_db passed to
 port_fdb_{add,del}
Message-ID: <aJjO3wIbjzJYsS2o@pidgin.makrotopia.org>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <20250810130637.aa5bjkmpeg4uylnu@skbuf>
 <aJixPn_7gYd1o69V@pidgin.makrotopia.org>
 <20250810163229.otapw4mhtv7e35jp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810163229.otapw4mhtv7e35jp@skbuf>

On Sun, Aug 10, 2025 at 07:32:29PM +0300, Vladimir Oltean wrote:
> On Sun, Aug 10, 2025 at 03:48:30PM +0100, Daniel Golle wrote:
> > [   66.300000] gswip 1e108000.switch: port 3 failed to add 6a:94:c2:xx:xx:xx vid 1 to fdb: -22
> > [   66.300000] gswip 1e108000.switch: port 3 failed to add 1a:f8:a8:xx:xx:xx vid 0 to fdb: -22
> > [   66.320000] gswip 1e108000.switch: port 3 failed to add 1a:f8:a8:xx:xx:xx vid 1 to fdb: -22
> > [   66.320000] gswip 1e108000.switch: port 3 failed to delete 6a:94:c2:xx:xx:xx vid 1 from fdb: -2
> > 
> > So the problem is apparently that at the point of calling br_add_if() the
> > port obviously isn't (yet) a member of the bridge and hence
> > dsa_port_bridge_dev_get() would still return NULL at this point, which
> > then causes gswip_port_fdb() to return -EINVAL.
> 
> Nope, this theory is false because the user port _is_ a member of the
> bridge when it processes the SWITCHDEV_FDB_ADD_TO_DEVICE events.
> 
> There are 2 cases for handling these events. One is handling past events
> which were missed and are re-generated during FDB replay:
> 
> [   65.510000] [<807ed128>] dsa_user_fdb_event+0x110/0x1c8
> [   65.510000] [<807f89b8>] __switchdev_handle_fdb_event_to_device+0x138/0x228
> [   65.510000] [<807f8ad8>] switchdev_handle_fdb_event_to_device+0x30/0x48
> [   65.510000] [<807ec328>] dsa_user_switchdev_event+0x90/0xb0
> [   65.510000] [<807c43c0>] br_switchdev_fdb_replay+0xd0/0x138
> [   65.510000] [<807c4de8>] br_switchdev_port_offload+0x240/0x39c
> [   65.510000] [<80799b6c>] br_switchdev_blocking_event+0x80/0xec
> [   65.510000] [<80065e20>] raw_notifier_call_chain+0x48/0x88
> [   65.510000] [<807f83e0>] switchdev_bridge_port_offload+0x5c/0xd0
> [   65.510000] [<807e4c90>] dsa_port_bridge_join+0x170/0x410
> [   65.510000] [<807ed5fc>] dsa_user_changeupper.part.0+0x40/0x180
> [   65.510000] [<807f0ac0>] dsa_user_netdevice_event+0x5b4/0xc34
> [   65.510000] [<80065e20>] raw_notifier_call_chain+0x48/0x88
> [   65.510000] [<805edeec>] __netdev_upper_dev_link+0x1bc/0x450
> [   65.510000] [<805ee1dc>] netdev_master_upper_dev_link+0x2c/0x38
> [   65.510000] [<807a055c>] br_add_if+0x494/0x890
> 
> If you look at the order of operations, you'll see that:
> 
> int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
> 			 struct netlink_ext_ack *extack)
> {
> 	...
> 	err = dsa_port_bridge_create(dp, br, extack); // this sets dp->bridge
> 	if (err)
> 		return err;
> 
> 	brport_dev = dsa_port_to_bridge_port(dp);
> 
> 	info.bridge = *dp->bridge;
> 	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_JOIN, &info); // this calls ds->ops->port_bridge_join()
> 	if (err)
> 		goto out_rollback;
> 
> 	/* Drivers which support bridge TX forwarding should set this */
> 	dp->bridge->tx_fwd_offload = info.tx_fwd_offload;
> 
> 	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
> 					    &dsa_user_switchdev_notifier,
> 					    &dsa_user_switchdev_blocking_notifier,
> 					    dp->bridge->tx_fwd_offload, extack); // this calls br_switchdev_fdb_replay()
> 	if (err)
> 		goto out_rollback_unbridge;
> 	...
> }
> 
> by the time br_switchdev_fdb_replay() is called, dp->bridge correctly
> reflects the bridge that is generating the events.
> 
> The problem is not a race condition, the problem is that the driver does
> not correctly handle host FDB entries.
> 
> The truly revealing step is to uncomment this:
> 
> 	netdev_dbg(dev, "%s FDB entry towards %s, addr %pM vid %d%s\n",
> 		   event == SWITCHDEV_FDB_ADD_TO_DEVICE ? "Adding" : "Deleting",
> 		   orig_dev->name, fdb_info->addr, fdb_info->vid,
> 		   host_addr ? " as host address" : "");
> 
> and see it will print "as host address", meaning dsa_port_bridge_host_fdb_add()
> will be called.

Thank you for explaining the details, it makes perfect sense to me now.

> 
> At the DSA cross-chip notifier layer, this generates a DSA_NOTIFIER_HOST_FDB_ADD
> event rather than the port-level DSA_NOTIFIER_FDB_ADD. The major difference in
> handling is that HOST_FDB_ADD events are matched by the *CPU* port, see
> dsa_port_host_address_match().
> 
> The CPU port is not part of the bridge that generated the host FDB entry,
> only the user port it services is.
> 
> The problem originates, roughly speaking, since commit 10fae4ac89ce
> ("net: dsa: include bridge addresses which are local in the host fdb
> list"), which first appeared in v5.14. We rolled out a new feature using
> existing API, and didn't notice the gswip driver wouldn't tolerate
> ds->ops->port_fdb_add() getting called on the CPU port.
> 
> Anyway, your intuition for fixing this properly was somewhat correct.
> Even if gswip does not implement FDB isolation, it is correct to look at
> the dsa_db :: bridge member to see which bridge originated the host FDB
> entry. That was its exact purpose, as documented in section "Address
> databases" of Documentation/networking/dsa/dsa.rst. Even if cpu_dp->bridge
> is NULL (as expected), drivers have to know on behalf of which user port
> (member of a bridge) the CPU port is filtering an entry towards the host.
> This is because CPU and DSA ports are servicing multiple address databases.
> 
> The only problem is that the API you're making use for fixing this was
> introduced in commit c26933639b54 ("net: dsa: request drivers to perform
> FDB isolation"), first appeared in v5.18. Thus, you can't fix an issue
> in linux-5.15.y using this method, unless the API change is backported.
> 
> Alternatively, for stable kernels you could suppress the error and
> return 0 in the gswip driver, with the appropriate comment that the API
> doesn't communicate the bridge ID for host FDB entries, and thus, the
> driver just won't filter them. Then, you could develop the solution
> further for net-next, keeping in mind how things are supposed to work.

As it would be nice to have the proper fix backported at least all the way
down to linux-6.1.y, do you think it would be ok to have that solution
I proposed (and picked from the GPL-2.0 licensed vendor driver) applied to
the 'net' tree (with a more appropriate Fixes: tag and commit description,
obviously) and either just not fix it for linux-5.15.y, or only there
replace the 'return -EINVAL;' with a 'dev_warn(...); return 0;'?

In fact, commit c26933639b54 ("net: dsa: request drivers to perform FDB
isolation") also touches drivers/net/dsa/lantiq_gswip.c and does add
struct dsa_db as parameter for the .port_fdb_{add,del} ops. Would it be
ok to hence target that commit in the Fixes: tag?


