Return-Path: <netdev+bounces-204209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D1AF990F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA86F1CC1B3F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B12D8370;
	Fri,  4 Jul 2025 16:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082C2D836A
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647245; cv=none; b=ROOhOFYUNLkXqV+j8hLFcuQGFDZiM6zwh1S4u1iWuLyLOHKfwPwHNRZF7bgp5gpBak7b37brssok2R+uBHrBbLu9V9dnAKmO3jHkDxN6ADUnDeH3T6KWDuMlPh0SOjBBQulr8yClSOQATLSQ9V9d7mPiX4oQ91VO1Th4dzpGRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647245; c=relaxed/simple;
	bh=sEKHJG/iJ/vzcRFCIp5Aq6Ruhy5InePyFZo5yx8x9CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuTOLkv6ATjRM6/ZrQGbjM/3dmNrMglAIPpwxr1+ShqO3auh5lpb8NBr4RTeh82qDgSbbqDWksoE9udVibSHffxCEle+IGbQfLKQGNcM1bivs4ThXmH2elPsLSrwVyljYpMZVuGPjzar5aV7mVwrBg2/AgLbp8tM5HKj57K+L5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uXjSh-0006IE-A5; Fri, 04 Jul 2025 18:40:31 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uXjSf-006nL1-0M;
	Fri, 04 Jul 2025 18:40:29 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uXjSf-00H1RC-01;
	Fri, 04 Jul 2025 18:40:29 +0200
Date: Fri, 4 Jul 2025 18:40:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jun Miao <jun.miao@intel.com>
Cc: sbhatta@marvell.com, kuba@kernel.org, oneukum@suse.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, qiang.zhang@linux.dev
Subject: [bug report] [PATCH v6] net: usb: Convert tasklet API to new bottom
 half workqueue mechanism
Message-ID: <aGgD_Lp0i-ZU2xkt@pengutronix.de>
References: <20250618173923.950510-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618173923.950510-1-jun.miao@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Jun,

On Wed, Jun 18, 2025 at 01:39:23PM -0400, Jun Miao wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the usbnet driver. This transition ensures compatibility
> with the latest design and enhances performance.

After applying this patch, the smsc95xx driver fails after one down/up
cycle.
Here is how I can reproduce the issue:

nmcli device set enu1u1 managed no
ip a a 10.10.10.1/24 dev enu1u1
ping -c 4 10.10.10.3
ip l s dev enu1u1 down
ip l s dev enu1u1 up
ping -c 4 10.10.10.3

The second ping does not reach the host. Networking also fails on other
interfaces.

After some delay, the following trace appears:
[  846.838527] INFO: task kworker/u16:1:308 blocked for more than 120 seconds.
[  846.838596]       Not tainted 6.16.0-rc3-00963-g4fcedea9cdf2-dirty #32
[  846.838666] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  846.838697] task:kworker/u16:1   state:D stack:0     pid:308 tgid:308   ppid:2
               task_flags:0x4208060 flags:0x00000010
[  846.838776] Workqueue: events_unbound linkwatch_event
[  846.838851] Call trace:
[  846.838880]  __switch_to+0x1d0/0x330 (T)
[  846.838933]  __schedule+0xa88/0x2a90
[  846.838980]  schedule+0x114/0x428
[  846.839010]  schedule_preempt_disabled+0x80/0x118
[  846.839036]  __mutex_lock+0x764/0xba8
[  846.839060]  mutex_lock_nested+0x28/0x38
[  846.839084]  rtnl_lock+0x20/0x30
[  846.839115]  linkwatch_event+0x18/0x70
[  846.839141]  process_one_work+0x760/0x17b0
[  846.839175]  worker_thread+0x768/0xce8
[  846.839208]  kthread+0x3bc/0x690
[  846.839237]  ret_from_fork+0x10/0x20
[  846.839359] INFO: task kworker/u16:1:308 is blocked on a mutex likely
owned by task ip:899.
[  846.839381] task:ip              state:D stack:0     pid:899
tgid:899   ppid:1      task_flags:0x400100 flags:0x00000019
[  846.839419] Call trace:
[  846.839432]  __switch_to+0x1d0/0x330 (T)
[  846.839466]  __schedule+0xa88/0x2a90
[  846.839495]  schedule+0x114/0x428
[  846.839524]  schedule_timeout+0xec/0x220
[  846.839551]  wait_skb_queue_empty+0xa0/0x168
[  846.839581]  usbnet_terminate_urbs+0x150/0x2c8
[  846.839609]  usbnet_stop+0x41c/0x608
[  846.839636]  __dev_close_many+0x1fc/0x4b8
[  846.839668]  __dev_change_flags+0x33c/0x500
[  846.839694]  netif_change_flags+0x7c/0x158
[  846.839718]  do_setlink.isra.0+0x2040/0x2eb8
[  846.839745]  rtnl_newlink+0xd88/0x16c8
[  846.839770]  rtnetlink_rcv_msg+0x654/0x8c8
[  846.839795]  netlink_rcv_skb+0x19c/0x350
[  846.839823]  rtnetlink_rcv+0x1c/0x30
[  846.839848]  netlink_unicast+0x3c4/0x668
[  846.839873]  netlink_sendmsg+0x620/0xa10
[  846.839899]  ____sys_sendmsg+0x2f8/0x788
[  846.839924]  ___sys_sendmsg+0xf0/0x178
[  846.839950]  __sys_sendmsg+0x104/0x198
[  846.839975]  __arm64_sys_sendmsg+0x74/0xa8
[  846.840000]  el0_svc_common.constprop.0+0xe4/0x338
[  846.840033]  do_el0_svc+0x44/0x60
[  846.840061]  el0_svc+0x3c/0xb0
[  846.840089]  el0t_64_sync_handler+0x104/0x130
[  846.840117]  el0t_64_sync+0x154/0x158
[  846.840164]
[  846.840164] Showing all locks held in the system:
[  846.840199] 1 lock held by khungtaskd/41:
[  846.840216]  #0: ffffffc08424ede0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x14/0x1b0
[  846.840309] 3 locks held by kworker/u16:2/47:
[  846.840325]  #0: ffffff800926a148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x698/0x17b0
[  846.840406]  #1: ffffffc0860f7c00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x6bc/0x17b0
[  846.840484]  #2: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x30
[  846.840568] 2 locks held by pr/ttymxc1/60:
[  846.840595] 5 locks held by sugov:0/84:
[  846.840618] 2 locks held by systemd-journal/124:
[  846.840639] 3 locks held by kworker/u16:1/308:
[  846.840655]  #0: ffffff8005d00148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x698/0x17b0
[  846.840733]  #1: ffffffc087307c00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x6bc/0x17b0
[  846.840810]  #2: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x30
[  846.840894] 1 lock held by ip/899:
[  846.840910]  #0: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x5e8/0x16c8
[  846.840982] 2 locks held by sshd/901:
[  846.840998]  #0: ffffff800aee06b0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: __netlink_dump_start+0x100/0x800
[  846.841073]  #1: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x128/0x1a8
[  846.841149] 2 locks held by sshd/903:
[  846.841165]  #0: ffffff800b1c76b0 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: __netlink_dump_start+0x100/0x800
[  846.841237]  #1: ffffffc084924408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x128/0x1a8

Reverting this patch recovers smsc95xx functionality.

Best Regards,
Oleksij

