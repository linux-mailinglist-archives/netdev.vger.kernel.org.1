Return-Path: <netdev+bounces-212360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E451CB1FA91
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1AC3B90E1
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554425CC63;
	Sun, 10 Aug 2025 14:48:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85929CEB;
	Sun, 10 Aug 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837336; cv=none; b=EzH4h34PUJnvJ+bhNgQRwtz7g7rA66urV+NDgzPemhfq+PhJeclrj2/Z1773TzCyR+WfRBPrJY+6hfqHLxJNM+PScagUDQ0CkHKw+5GVDjw9iygG1DuaSrNMlBQOvTkKWlxD7BARO+Vv28Puou++CIssEGX8JqLD6I2bd131GWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837336; c=relaxed/simple;
	bh=j6zCzNZhni3byLFMba0pJQ7VLIFrLN27SdwzmnecZ7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0edU05N6Mshwgr8RtPyzIlzvfJCQBSoEA9iKJakL2uoYkOZTqlUonZjni1oxCFXXAM4RIRNgPFtBCMpUmE13Fo/PXoJ8adX8nc9bgv2vVNoeTu56rhwf6JHmp+VzT2OKbvQ97p4DEqjRH8zwo95P4wZW0xMnHhV5feneBTr5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ul7Ln-000000004sj-1eSy;
	Sun, 10 Aug 2025 14:48:43 +0000
Date: Sun, 10 Aug 2025 15:48:30 +0100
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
Message-ID: <aJixPn_7gYd1o69V@pidgin.makrotopia.org>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <20250810130637.aa5bjkmpeg4uylnu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810130637.aa5bjkmpeg4uylnu@skbuf>

Hi Vladimir,

thank you for spending parts of your weekend dealing with this problem ;)

On Sun, Aug 10, 2025 at 04:06:37PM +0300, Vladimir Oltean wrote:
> On Sat, Aug 09, 2025 at 11:35:28PM +0100, Daniel Golle wrote:
> > Commit c9eb3e0f8701 ("net: dsa: Add support for learning FDB through
> > notification") added a dev_close() call "to indicate inconsistent
> > situation" when we could not delete an FDB entry from the port. In case
> > of the lantiq_gswip driver this is problematic on standalone ports for
> > which all calls to either .port_fdb_add() or .port_fdb_del() would just
> > always return -EINVAL as adding or removing FDB entries is currently
> > only supported for ports which are a member of a bridge.
> > 
> > As since commit c26933639b54 ("net: dsa: request drivers to perform FDB
> > isolation") the dsa_db is passed to the .port_fdb_add() or
> > .port_fdb_del() calls we can use that to set the FID accordingly,
> > similar to how it was for bridge ports, and to FID 0 for standalone
> > ports. In order for FID 0 to work at all we also need to set bit 1 in
> > val[1], so always set it.
> > 
> > This solution was found in a downstream driver provided by MaxLinear
> > (which is the current owner of the former Lantiq switch IP) under
> > GPL-2.0. Import the implementation and the copyright headers from that
> > driver.
> > 
> > Fixes: c9eb3e0f8701 ("net: dsa: Add support for learning FDB through notification")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> 
> 1. The dev_close() call was removed in commit 2fd186501b1c ("net: dsa:
>    be louder when a non-legacy FDB operation fails"); what kernel are you
>    seeing failures on?

I'm working on net-next at this moment, trying historic OpenWrt releases
on that hardware I noticed the problem has been introduced somewhere
between Linxu 5.10 and Linux 5.15, but it is still present up to net-next
as of today. That's why I concluded c9eb3e0f8701 would be the original
cause.

> 
> 2. The call paths which set DSA_DB_PORT should be all guarded by
>    dsa_switch_supports_uc_filtering(), which the gswip driver doesn't
>    fulfill (it's missing ds->fdb_isolation). Can you put a dump_stack()
>    in the DSA_DB_PORT handler and let me know where it's called from?

In case you meant the driver implementation of .port_fdb_add() and
.port_fdb_del(), see below. If you meant somewhere else, please let me
know exactly where you want the dump_stack() to be placed.

> 
> 3. You haven't actually explained the context that leads to
>    gswip_port_fdb() returning -EINVAL. It would be great to have that as
>    a starting point, perhaps a dump_stack() in the unmodified code could
>    reveal more.

So instead of the fix I have now applied this simple patch to reveal the
stacktrace which leads to the return of -EINVAL:

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d4044..befca64cce6d 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1359,7 +1359,7 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
-	if (!bridge)
+	if (WARN_ON(!bridge))
 		return -EINVAL;
 
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
---

Unfortunately that doesn't tell much:
[   52.910000] ------------[ cut here ]------------
[   52.910000] WARNING: CPU: 0 PID: 12 at drivers/net/dsa/lantiq_gswip.c:1362 0xc026c364
[   52.920000] Modules linked in: tag_gswip lantiq_gswip
[   52.930000] CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.16.0+ #0 NONE 
[   52.930000] Hardware name: o2 Box 6431
[   52.930000] Workqueue: dsa_ordered dsa_user_switchdev_event_work
[   52.930000] Stack : 8187db3c 8187db10 00000000 000affff 807ec348 81c05200 81bd5e00 6473615f
[   52.930000]         6f726465 72656400 00000000 00000000 00000000 00000001 8187daf8 8183ddc0
[   52.930000]         00000000 00000000 808edd50 8187d920 ffffefff 00000000 00000098 0000009a
[   52.930000]         8187d92c 0000009a 809fd7d8 fffffffb 00000001 00000000 808edd50 00000000
[   52.930000]         00000000 c026c364 00000000 81cb6154 00000003 fffc2513 00000000 80eb0000
[   52.930000]         ...
[   52.930000] Call Trace:
[   52.930000] [<800167cc>] show_stack+0x28/0xf0
[   52.930000] [<8000d234>] dump_stack_lvl+0x70/0xb0
[   52.930000] [<8003bb58>] __warn+0x9c/0x114
[   52.930000] [<8003bcf4>] warn_slowpath_fmt+0x124/0x17c
[   52.930000] [<c026c364>] 0xc026c364
[   52.930000] 
[   52.930000] ---[ end trace 0000000000000000 ]---

So my next attempt is this

diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..34d67486ec2f 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3649,7 +3649,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 			err = dsa_port_lag_fdb_add(dp, addr, vid);
 		else
 			err = dsa_port_fdb_add(dp, addr, vid);
-		if (err) {
+		if (WARN_ON(err)) {
 			dev_err(ds->dev,
 				"port %d failed to add %pM vid %d to fdb: %d\n",
 				dp->index, addr, vid, err);
@@ -3665,7 +3665,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 			err = dsa_port_lag_fdb_del(dp, addr, vid);
 		else
 			err = dsa_port_fdb_del(dp, addr, vid);
-		if (err) {
+		if (WARN_ON(err)) {
 			dev_err(ds->dev,
 				"port %d failed to delete %pM vid %d from fdb: %d\n",
 				dp->index, addr, vid, err);
---

That lead to a little more revealing result:
[   48.930000] ------------[ cut here ]------------
[   48.930000] WARNING: CPU: 0 PID: 31 at net/dsa/user.c:3652 dsa_user_switchdev_event_work+0x1e8/0x210
[   48.940000] Modules linked in: tag_gswip lantiq_gswip
[   48.940000] CPU: 0 UID: 0 PID: 31 Comm: kworker/u8:2 Tainted: G        W           6.16.0+ #0 NONE 
[   48.940000] Tainted: [W]=WARN
[   48.940000] Hardware name: o2 Box 6431
[   48.940000] Workqueue: dsa_ordered dsa_user_switchdev_event_work
[   48.940000] Stack : 81c2dd24 81c2dcf8 00000000 000affff 807ec348 81c6b000 81bcc200 6473615f
[   48.940000]         6f726465 72656400 00000000 00000000 00000000 00000001 81c2dce0 8183b840
[   48.940000]         00000000 00000000 808edd50 81c2db08 ffffefff 00000000 00000191 00000193
[   48.940000]         81c2db14 00000193 809fd7d8 fffffffb 00000001 00000000 808edd50 00000000
[   48.940000]         00000000 807ec530 00000000 81804420 00000003 fffc5b17 000a3b9f 00000001
[   48.940000]         ...
[   48.940000] Call Trace:
[   48.940000] [<800167cc>] show_stack+0x28/0xf0
[   48.940000] [<8000d234>] dump_stack_lvl+0x70/0xb0
[   48.940000] [<8003bb58>] __warn+0x9c/0x114
[   48.940000] [<8003bcf4>] warn_slowpath_fmt+0x124/0x17c
[   48.940000] [<807ec530>] dsa_user_switchdev_event_work+0x1e8/0x210
[   48.940000] [<8005892c>] process_one_work+0x1c4/0x3e0
[   48.940000] [<8005a1ac>] worker_thread+0x318/0x488
[   48.940000] [<80062000>] kthread+0x118/0x258
[   48.940000] [<80011db8>] ret_from_kernel_thread+0x14/0x1c
[   48.940000] 
[   48.940000] ---[ end trace 0000000000000000 ]---

So I went ahead and instead put the WARN_ON() in the function which schedules the work.

diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..1b56c0a5d5d6 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3748,6 +3748,7 @@ static int dsa_user_fdb_event(struct net_device *dev,
 		   orig_dev->name, fdb_info->addr, fdb_info->vid,
 		   host_addr ? " as host address" : "");
 
+	WARN_ON(1);
 	INIT_WORK(&switchdev_work->work, dsa_user_switchdev_event_work);
 	switchdev_work->event = event;
	switchdev_work->dev = dev;
---

It is now a bit difficult to tell which of the calls actually return
-EINVAL, but counting the number of stackdumps and the number of -EINVAL
error messages seem to match:

[   65.500000] ------------[ cut here ]------------
[   65.500000] WARNING: CPU: 0 PID: 1238 at net/dsa/user.c:3751 dsa_user_fdb_event+0x110/0x1c8
[   65.510000] Modules linked in: tag_gswip lantiq_gswip
[   65.510000] CPU: 0 UID: 0 PID: 1238 Comm: netifd Not tainted 6.16.0+ #0 NONE 
[   65.510000] Hardware name: o2 Box 6431
[   65.510000] Stack : 81f5b8b4 00000096 00000000 00000001 00000000 00000000 00000000 00000000
[   65.510000]         00000000 00000000 00000000 00000000 00000000 00000001 81f5b870 81839f40
[   65.510000]         00000000 00000000 808edd50 81f5b708 ffffefff 00000000 00000096 00000098
[   65.510000]         81f5b714 00000098 809fd7d8 fffffff9 00000001 00000000 808edd50 00000000
[   65.510000]         00000000 807ed128 00000000 807eb87c 00000003 fffc249b 000726df 00000001
[   65.510000]         ...
[   65.510000] Call Trace:
[   65.510000] [<800167cc>] show_stack+0x28/0xf0
[   65.510000] [<8000d234>] dump_stack_lvl+0x70/0xb0
[   65.510000] [<8003bb58>] __warn+0x9c/0x114
[   65.510000] [<8003bcf4>] warn_slowpath_fmt+0x124/0x17c
[   65.510000] [<807ed128>] dsa_user_fdb_event+0x110/0x1c8
[   65.510000] [<807f89b8>] __switchdev_handle_fdb_event_to_device+0x138/0x228
[   65.510000] [<807f8ad8>] switchdev_handle_fdb_event_to_device+0x30/0x48
[   65.510000] [<807ec328>] dsa_user_switchdev_event+0x90/0xb0
[   65.510000] [<807c43c0>] br_switchdev_fdb_replay+0xd0/0x138
[   65.510000] [<807c4de8>] br_switchdev_port_offload+0x240/0x39c
[   65.510000] [<80799b6c>] br_switchdev_blocking_event+0x80/0xec
[   65.510000] [<80065e20>] raw_notifier_call_chain+0x48/0x88
[   65.510000] [<807f83e0>] switchdev_bridge_port_offload+0x5c/0xd0
[   65.510000] [<807e4c90>] dsa_port_bridge_join+0x170/0x410
[   65.510000] [<807ed5fc>] dsa_user_changeupper.part.0+0x40/0x180
[   65.510000] [<807f0ac0>] dsa_user_netdevice_event+0x5b4/0xc34
[   65.510000] [<80065e20>] raw_notifier_call_chain+0x48/0x88
[   65.510000] [<805edeec>] __netdev_upper_dev_link+0x1bc/0x450
[   65.510000] [<805ee1dc>] netdevbmaster_upper_dev_link+0x2c/0x38
[   65.510000] [<807a055c>] br_add_if+0x494/0x890
[   65.510000] [<807a20cc>] br_ioctl_stub+0x238/0x514
[   65.510000] [<805bc06c>] br_ioctl_call+0x58/0xa8
[   65.510000] [<80255a60>] sys_ioctl+0x4a8/0xa60
[   65.510000] [<8002204c>] syscall_common+0x34/0x58
[   65.510000] 
[   65.510000] ---[ end trace 0000000000000000 ]---
[   65.710000] gswip 1e108000.switch lan1: entered promiscuous mode
[   65.710000] ------------[ cut here ]------------
[   65.720000] WARNING: CPU: 0 PID: 1238 at net/dsa/user.c:3751 dsa_user_fdb_event+0x110/0x1c8
[   65.730000] Modules linked in: tag_gswip lantiq_gswip
[   65.730000] CPU: 0 UID: 0 PID: 1238 Comm: netifd Tainted: G        W           6.16.0+ #0 NONE 
[   65.730000] Tainted: [W]=WARN
[   65.730000] Hardware name: o2 Box 6431
[   65.730000] Stack : 81f5bb04 8003b4bc 00000000 00000001 00000000 00000000 00000000 00000000
[   65.730000]         00000000 00000000 00000000 00000000 00000000 00000001 81f5bac0 81839f40
[   65.730000]         00000000 00000000 808edd50 81f5b958 ffffefff 00000000 000000be 000000c0
[   65.730000]         81f5b964 000000c0 809fd7d8 fffffff9 00000001 00000000 808edd50 00000000
[   65.730000]         00000000 807ed128 00000000 807eb87c 00000003 fffc2d13 00000000 80eb0000
[   65.730000]         ...
[   65.730000] Call Trace:
[   65.730000] [<800167cc>] show_stack+0x28/0xf0
[   65.730000] [<8000d234>] dump_stack_lvl+0x70/0xb0
[   65.730000] [<8003bb58>] __warn+0x9c/0x114
[   65.730000] [<8003bcf4>] warn_slowpath_fmt+0x124/0x17c
[   65.730000] [<807ed128>] dsa_user_fdb_event+0x110/0x1c8
[   65.730000] [<807f89b8>] __switchdev_handle_fdb_event_to_device+0x138/0x228
[   65.730000] [<807f8ad8>] switchdev_handle_fdb_event_to_device+0x30/0x48
[   65.730000] [<807ec328>] dsa_user_switchdev_event+0x90/0xb0
[   65.730000] [<80065ea8>] atomic_notifier_call_chain+0x48/0x88
[   65.730000] [<807c47f0>] br_switchdev_fdb_notify+0xf0/0x11c
[   65.730000] [<8079b33c>] fdb_notify+0x110/0x158
[   65.730000] [<8079c1d0>] fdb_add_local+0x124/0x140
[   65.730000] [<8079ce64>] br_fdb_add_local+0x4c/0x7c
[   65.730000] [<807a0670>] br_add_if+0x5a8/0x890
[   65.730000] [<807a20cc>] br_ioctl_stub+0x238/0x514
[   65.730000] [<805bc06c>] br_ioctl_call+0x58/0xa8
[   65.730000] [<80255a60>] sys_ioctl+0x4a8/0xa60
[   65.730000] [<8002204c>] syscall_common+0x34/0x58
[   65.730000] 
[   65.730000] ---[ end trace 0000000000000000 ]---
[   65.890000] ------------[ cut here ]------------
[   65.900000] WARNING: CPU: 0 PID: 1238 at net/dsa/user.c:3751 dsa_user_fdb_event+0x110/0x1c8
[   65.900000] Modules linked in: tag_gswip lantiq_gswip
[   65.910000] CPU: 0 UID: 0 PID: 1238 Comm: netifd Tainted: G        W           6.16.0+ #0 NONE 
[   65.910000] Tainted: [W]=WARN
[   65.910000] Hardware name: o2 Box 6431
[   65.910000] Stack : 81f5ba34 8003b4bc 00000000 00000001 00000000 00000000 00000000 00000000
[   65.910000]         00000000 00000000 00000000 00000000 00000000 00000001 81f5b9f0 81839f40
[   65.910000]         00000000 00000000 808edd50 81f5b888 ffffefff 00000000 000000df 000000e1
[   65.910000]         81f5b894 000000e1 809fd7d8 fffffff9 00000001 00000000 808edd50 00000000
[   65.910000]         00000000 807ed128 00000000 807eb87c 00000003 fffc33df 00000000 80eb0000
[   65.910000]         ...
[   65.910000] Call Trace:
[   65.910000] [<800167cc>] show_stack+0x28/0xf0
[   65.910000] [<8000d234>] dump_stack_lvl+0x70/0xb0
[   65.910000] [<8003bb58>] __warn+0x9c/0x114
[   65.910000] [<8003bcf4>] warn_slowpath_fmt+0x124/0x17c
[   65.910000] [<807ed128>] dsa_user_fdb_event+0x110/0x1c8
[   65.910000] [<807f89b8>] __switchdev_handle_fdb_event_to_device+0x138/0x228
[   65.910000] [<807f8ad8>] switchdev_handle_fdb_event_to_device+0x30/0x48
[   65.910000] [<807ec328>] dsa_user_switchdev_event+0x90/0xb0
[   65.910000] [<80065ea8>] atomic_notifier_call_chain+0x48/0x88
[   65.910000] [<807c47f0>] br_switchdev_fdb_notify+0xf0/0x11c
[   65.910000] [<8079b33c>] fdb_notify+0x110/0x158
[   65.910000] [<8079c1d0>] fdb_add_local+0x124/0x140
[   65.910000] [<8079ce64>] br_fdb_add_local+0x4c/0x7c
[   65.910000] [<807bee58>] __vlan_add+0xa0/0x93c
[   65.910000] [<807bfc04>] nbp_vlan_add+0x134/0x1fc
[   65.910000] [<807c0750>] nbp_vlan_init+0x120/0x178
[   65.910000] [<807a06ac>] br_add_if+0x5e4/0x890
[   65.910000] [<807a20cc>] br_ioctl_stub+0x238/0x514
[   65.910000] [<805bc06c>] br_ioctl_call+0x58/0xa8
[   65.910000] [<80255a60>] sys_ioctl+0x4a8/0xa60
[   65.910000] [<8002204c>] syscall_common+0x34/0x58
[   65.910000] 
[   65.910000] ---[ end trace 0000000000000000 ]---
[   66.080000] ------------[ cut here ]------------
[   66.090000] WARNING: CPU: 0 PID: 1238 at net/dsa/user.c:3751 dsa_user_fdb_event+0x110/0x1c8
[   66.100000] Modules linked in: tag_gswip lantiq_gswip
[   66.100000] CPU: 0 UID: 0 PID: 1238 Comm: netifd Tainted: G        W           6.16.0+ #0 NONE 
[   66.100000] Tainted: [W]=WARN
[   66.100000] Hardware name: o2 Box 6431
[   66.100000] Stack : 81f5baa4 8003b4bc 00000000 00000001 00000000 00000000 00000000 00000000
[   66.100000]         00000000 00000000 00000000 00000000 00000000 00000001 81f5ba60 81839f40
[   66.100000]         00000000 00000000 808edd50 81f5b8f8 ffffefff 00000000 00000103 00000105
[   66.100000]         81f5b904 00000105 809fd7d8 fffffff9 00000001 00000000 808edd50 00000000
[   66.100000]         00000000 807ed128 00000000 807eb87c 00000003 fffc3b2b 00000000 80eb0000
[   66.100000]         ...
[   66.100000] Call Trace:
[   66.100000] [<800167cc>] show_stack+0x28/0xf0
[   66.100000] [<8000d234>] dump_stack_lvl+0x70/0xb0
[   66.100000] [<8003bb58>] __warn+0x9c/0x114
[   66.100000] [<8003bcf4>] warn_slowpath_fmt+0x124/0x17c
[   66.100000] [<807ed128>] dsa_user_fdb_event+0x110/0x1c8
[   66.100000] [<807f89b8>] __switchdev_handle_fdb_event_to_device+0x138/0x228
[   66.100000] [<807f8ad8>] switchdev_handle_fdb_event_to_device+0x30/0x48
[   66.100000] [<807ec328>] dsa_user_switchdev_event+0x90/0xb0
[   66.100000] [<80065ea8>] atomic_notifier_call_chain+0x48/0x88
[   66.100000] [<807c4810>] br_switchdev_fdb_notify+0x110/0x11c
[   66.100000] [<8079b33c>] fdb_notify+0x110/0x158
[   66.100000] [<8079bdb4>] fdb_delete+0x1e4/0x310
[   66.100000] [<8079c59c>] br_fdb_change_mac_address+0x180/0x188
[   66.100000] [<807a46f0>] br_stp_change_bridge_id+0x4c/0x1c8
[   66.100000] [<807a496c>] br_stp_recalculate_bridge_id+0x100/0x148
[   66.100000] [<807a06c4>] br_add_if+0x5fc/0x890
[   66.100000] [<807a20cc>] br_ioctl_stub+0x238/0x514
[   66.100000] [<805bc06c>] br_ioctl_call+0x58/0xa8
[   66.100000] [<80255a60>] sys_ioctl+0x4a8/0xa60
[   66.100000] [<8002204c>] syscall_common+0x34/0x58
[   66.100000] 
[   66.100000] ---[ end trace 0000000000000000 ]---
[   66.300000] gswip 1e108000.switch: port 3 failed to add 6a:94:c2:xx:xx:xx vid 1 to fdb: -22
[   66.300000] gswip 1e108000.switch: port 3 failed to add 1a:f8:a8:xx:xx:xx vid 0 to fdb: -22
[   66.320000] gswip 1e108000.switch: port 3 failed to add 1a:f8:a8:xx:xx:xx vid 1 to fdb: -22
[   66.320000] gswip 1e108000.switch: port 3 failed to delete 6a:94:c2:xx:xx:xx vid 1 from fdb: -2

So the problem is apparently that at the point of calling br_add_if() the
port obviously isn't (yet) a member of the bridge and hence
dsa_port_bridge_dev_get() would still return NULL at this point, which
then causes gswip_port_fdb() to return -EINVAL.


