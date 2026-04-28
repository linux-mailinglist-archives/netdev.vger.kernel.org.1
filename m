Return-Path: <netdev+bounces-281837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBzfHUap8GltWwEAu9opvQ
	(envelope-from <netdev+bounces-281837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:34:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE7484E44
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7AF3039CAC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63942EECC;
	Tue, 28 Apr 2026 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhTgThPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E4426EBB
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379539; cv=none; b=Mluey50YObA78SX19byzfQxf9sWimuPR9jVXd4WzH2RSts5xZVbQNGSwTq9SfUq55wTRB22ICKfIAKe67ezsIWPtouXMHM+jTr7pAPQcEYlL5WeFeBmuhJlt9YDX/USZcl9JQmsSUKz0fiZ9wx0zReAndbs25mHNhKa3Jcz+8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379539; c=relaxed/simple;
	bh=aabR+arHHfj07s+uPoCdG0FdCIdZvTUxGbqjUtOPYMM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tT9CIaEmoF+c5927bm7E/eOz4Wd/Bw7P7+Yv6YkpQEMto4mFr2XusRO9TOFQrKIJwtSy5pVAY+XL+GIsh6U+3pqfstkrhsolBDXOYM6kY4n2Kr2fYAaMUMBqKmn3FT/VGlyY1egcNkP766pwkjAQxeutCqQDcIrK27Q1ovW5ThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhTgThPb; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50f817c3240so119375131cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777379529; x=1777984329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qVGzil9+NtzsO8G+wEJMrgZXdqJPGRZf7ESIzhMvAR8=;
        b=EhTgThPbkIdn7Iy6Jh4ETXcXwt59j+ftmXL9MppGZ/yOcpH3sO4kt8yd4g6uXah2ys
         X2lCRoacgVSMXjgKNEQBPPfwmUyDjFRV0+n9s5Q0qsfY8HdUT4VxckiYLHlOo3rNgEfx
         mEJf/0pCLKsUhBez9/i21gTwHHva9jMUz7v/sQBRghI9+jhbsFUMaKweBIq/Oem3cLne
         JSZY+YKJg+Uy6L2RyL8jvqHbTdoZOVbTIYx6c84mB1thRRfJXT0dbOrRnGDM706KTaFd
         H8299WGpiFaHt3vCydgP+wUibRJPTJM7+hNOLrbPd7zLep+qHyaioX20KxJk8p9Z+eOR
         TJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777379529; x=1777984329;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVGzil9+NtzsO8G+wEJMrgZXdqJPGRZf7ESIzhMvAR8=;
        b=KrXmRf1A8WFj2bIL/QAmwu1kzdIhXbuiwYk8pOIdivd4Co65QKZfurge9xYwXzuSWs
         HxJRxzswqBwOpMeQ/grVaRT1GgsU1M+Rra820cKKQ47XA76UMaG436PuIp6AUsLiGeTM
         +mS5QnPXDpg2AYO130YelzVEMQKOuAfRlm2IuuSWFOCGs7H+j0gxKyEnWESAORR4n5Wm
         Hnda1Vcr6XglcGR32J8ukhf+TBPvX2rC+27BCHAzGaX+TapL3IwmeVNoNiXTQt5BEAjJ
         xiBOKvd+vFrFkpW/i1HgqbQ5dFuW2z5Y2apwfreLe2t/4zPoI2M9S7USkkv7MYMKh9ZC
         R3yw==
X-Forwarded-Encrypted: i=1; AFNElJ8eX/tXrLcr7ot+znxAGqtiUnq86cDKRVY4UN2SxE8FdV4qhDOZtWexzxXHtUSVw6Ek1haEPrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOiaYvVLC6FRK0cvlvjBumdE1ffMeSFis3yQNdTVXkfciaiIv
	HgU16LtKQbb020pUxw4YQooinQXgAopXDRf4GnZQS1MB3JetVq1NemmCkPviSLPZepULYbPUN45
	W40xKtStSPi6Kmw==
X-Received: from qknvq18.prod.google.com ([2002:a05:620a:5592:b0:8eb:c01e:dfd7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1f06:b0:50b:4491:a2cf with SMTP id d75a77b69052e-5100e14429cmr38598481cf.27.1777379528840;
 Tue, 28 Apr 2026 05:32:08 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:32:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428123207.3809211-1-edumazet@google.com>
Subject: [PATCH net] bonding: 3ad: implement proper RCU rules for port->aggregator
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+9bb2ff2a4ab9e17307e1@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B9DE7484E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch];
	TAGGED_FROM(0.00)[bounces-281837-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.160.202:received];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[netdev,9bb2ff2a4ab9e17307e1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:email]

syzbot found a data-race in bond_3ad_get_active_agg_info /
bond_3ad_state_machine_handler [1] which hints at lack of proper
RCU implementation.

Add __rcu qualifier to port->aggregator, and add proper RCU API.

[1]

BUG: KCSAN: data-race in bond_3ad_get_active_agg_info / bond_3ad_state_machine_handler

write to 0xffff88813cf5c4b0 of 8 bytes by task 36 on cpu 0:
  ad_port_selection_logic drivers/net/bonding/bond_3ad.c:1659 [inline]
  bond_3ad_state_machine_handler+0x9d5/0x2d60 drivers/net/bonding/bond_3ad.c:2569
  process_one_work kernel/workqueue.c:3302 [inline]
  process_scheduled_works+0x4f0/0x9c0 kernel/workqueue.c:3385
  worker_thread+0x58a/0x780 kernel/workqueue.c:3466
  kthread+0x22a/0x280 kernel/kthread.c:436
  ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read to 0xffff88813cf5c4b0 of 8 bytes by task 22063 on cpu 1:
  __bond_3ad_get_active_agg_info drivers/net/bonding/bond_3ad.c:2858 [inline]
  bond_3ad_get_active_agg_info+0x8c/0x230 drivers/net/bonding/bond_3ad.c:2881
  bond_fill_info+0xe0f/0x10f0 drivers/net/bonding/bond_netlink.c:853
  rtnl_link_info_fill net/core/rtnetlink.c:906 [inline]
  rtnl_link_fill+0x1d7/0x4e0 net/core/rtnetlink.c:927
  rtnl_fill_ifinfo+0xf8e/0x1380 net/core/rtnetlink.c:2168
  rtmsg_ifinfo_build_skb+0x11c/0x1b0 net/core/rtnetlink.c:4453
  rtmsg_ifinfo_event net/core/rtnetlink.c:4486 [inline]
  rtmsg_ifinfo+0x6d/0x110 net/core/rtnetlink.c:4495
  __dev_notify_flags+0x76/0x390 net/core/dev.c:9790
  netif_change_flags+0xac/0xd0 net/core/dev.c:9823
  do_setlink+0x905/0x2950 net/core/rtnetlink.c:3180
  rtnl_group_changelink net/core/rtnetlink.c:3813 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3981 [inline]
  rtnl_newlink+0xf55/0x1400 net/core/rtnetlink.c:4109
  rtnetlink_rcv_msg+0x64b/0x720 net/core/rtnetlink.c:6995
  netlink_rcv_skb+0x123/0x220 net/netlink/af_netlink.c:2550
  rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:7022
  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
  netlink_unicast+0x5a8/0x680 net/netlink/af_netlink.c:1344
  netlink_sendmsg+0x5c8/0x6f0 net/netlink/af_netlink.c:1894
  sock_sendmsg_nosec net/socket.c:787 [inline]
  __sock_sendmsg net/socket.c:802 [inline]
  ____sys_sendmsg+0x563/0x5b0 net/socket.c:2698
  ___sys_sendmsg+0x195/0x1e0 net/socket.c:2752
  __sys_sendmsg net/socket.c:2784 [inline]
  __do_sys_sendmsg net/socket.c:2789 [inline]
  __se_sys_sendmsg net/socket.c:2787 [inline]
  __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2787
  x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000000 -> 0xffff88813cf5c400

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22063 Comm: syz.0.31122 Tainted: G        W           syzkaller #0 PREEMPT(full)
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026

Fixes: 47e91f56008b ("bonding: use RCU protection for 3ad xmit path")
Reported-by: syzbot+9bb2ff2a4ab9e17307e1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69f0a82f.050a0220.3aadc4.0000.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bonding/bond_3ad.c         | 109 ++++++++++++++-----------
 drivers/net/bonding/bond_main.c        |   8 +-
 drivers/net/bonding/bond_netlink.c     |  16 ++--
 drivers/net/bonding/bond_procfs.c      |   3 +-
 drivers/net/bonding/bond_sysfs_slave.c |  17 ++--
 include/net/bond_3ad.h                 |   2 +-
 6 files changed, 89 insertions(+), 66 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index af7f74cfdc086c3e1f1565d5e930e356902b1b99..f0aa7d2f21717a7084d78a8016643fa9f7e9e91e 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1029,6 +1029,7 @@ static void ad_cond_set_peer_notif(struct port *port)
 static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 {
 	struct bonding *bond = __get_bond_by_port(port);
+	struct aggregator *aggregator;
 	mux_states_t last_state;
 
 	/* keep current State Machine state to compare later if it was
@@ -1036,6 +1037,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 	 */
 	last_state = port->sm_mux_state;
 
+	aggregator = rcu_dereference(port->aggregator);
 	if (port->sm_vars & AD_PORT_BEGIN) {
 		port->sm_mux_state = AD_MUX_DETACHED;
 	} else {
@@ -1055,7 +1057,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 * cycle to update ready variable, we check
 				 * READY_N and update READY here
 				 */
-				__set_agg_ports_ready(port->aggregator, __agg_ports_are_ready(port->aggregator));
+				__set_agg_ports_ready(aggregator, __agg_ports_are_ready(aggregator));
 				port->sm_mux_state = AD_MUX_DETACHED;
 				break;
 			}
@@ -1070,7 +1072,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			 * update ready variable, we check READY_N and update
 			 * READY here
 			 */
-			__set_agg_ports_ready(port->aggregator, __agg_ports_are_ready(port->aggregator));
+			__set_agg_ports_ready(aggregator, __agg_ports_are_ready(aggregator));
 
 			/* if the wait_while_timer expired, and the port is
 			 * in READY state, move to ATTACHED state
@@ -1086,7 +1088,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			if ((port->sm_vars & AD_PORT_SELECTED) &&
 			    (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) &&
 			    !__check_agg_selection_timer(port)) {
-				if (port->aggregator->is_active) {
+				if (aggregator->is_active) {
 					int state = AD_MUX_COLLECTING_DISTRIBUTING;
 
 					if (!bond->params.coupled_control)
@@ -1102,9 +1104,9 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 * cycle to update ready variable, we check
 				 * READY_N and update READY here
 				 */
-				__set_agg_ports_ready(port->aggregator, __agg_ports_are_ready(port->aggregator));
+				__set_agg_ports_ready(aggregator, __agg_ports_are_ready(aggregator));
 				port->sm_mux_state = AD_MUX_DETACHED;
-			} else if (port->aggregator->is_active) {
+			} else if (aggregator->is_active) {
 				port->actor_oper_port_state |=
 				    LACP_STATE_SYNCHRONIZATION;
 			}
@@ -1115,7 +1117,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 * sure that a collecting distributing
 				 * port in an active aggregator is enabled
 				 */
-				if (port->aggregator->is_active &&
+				if (aggregator->is_active &&
 				    !__port_is_collecting_distributing(port)) {
 					__enable_port(port);
 					*update_slave_arr = true;
@@ -1134,7 +1136,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 					 */
 					struct slave *slave = port->slave;
 
-					if (port->aggregator->is_active &&
+					if (aggregator->is_active &&
 					    bond_is_slave_rx_disabled(slave)) {
 						ad_enable_collecting(port);
 						*update_slave_arr = true;
@@ -1154,8 +1156,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				 * sure that a collecting distributing
 				 * port in an active aggregator is enabled
 				 */
-				if (port->aggregator &&
-				    port->aggregator->is_active &&
+				if (aggregator &&
+				    aggregator->is_active &&
 				    !__port_is_collecting_distributing(port)) {
 					__enable_port(port);
 					*update_slave_arr = true;
@@ -1187,7 +1189,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			port->sm_mux_timer_counter = __ad_timer_to_ticks(AD_WAIT_WHILE_TIMER, 0);
 			break;
 		case AD_MUX_ATTACHED:
-			if (port->aggregator->is_active)
+			if (aggregator->is_active)
 				port->actor_oper_port_state |=
 				    LACP_STATE_SYNCHRONIZATION;
 			else
@@ -1561,9 +1563,9 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 	bond = __get_bond_by_port(port);
 
 	/* if the port is connected to other aggregator, detach it */
-	if (port->aggregator) {
+	temp_aggregator = rcu_dereference(port->aggregator);
+	if (temp_aggregator) {
 		/* detach the port from its former aggregator */
-		temp_aggregator = port->aggregator;
 		for (curr_port = temp_aggregator->lag_ports; curr_port;
 		     last_port = curr_port,
 		     curr_port = curr_port->next_port_in_aggregator) {
@@ -1586,7 +1588,7 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 				/* clear the port's relations to this
 				 * aggregator
 				 */
-				port->aggregator = NULL;
+				RCU_INIT_POINTER(port->aggregator, NULL);
 				port->next_port_in_aggregator = NULL;
 				port->actor_port_aggregator_identifier = 0;
 
@@ -1609,7 +1611,7 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 					     port->slave->bond->dev->name,
 					     port->slave->dev->name,
 					     port->actor_port_number,
-					     port->aggregator->aggregator_identifier);
+					     temp_aggregator->aggregator_identifier);
 		}
 	}
 	/* search on all aggregators for a suitable aggregator for this port */
@@ -1633,15 +1635,15 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 		    )
 		   ) {
 			/* attach to the founded aggregator */
-			port->aggregator = aggregator;
+			rcu_assign_pointer(port->aggregator, aggregator);
 			port->actor_port_aggregator_identifier =
-				port->aggregator->aggregator_identifier;
+				aggregator->aggregator_identifier;
 			port->next_port_in_aggregator = aggregator->lag_ports;
-			port->aggregator->num_of_ports++;
+			aggregator->num_of_ports++;
 			aggregator->lag_ports = port;
 			slave_dbg(bond->dev, slave->dev, "Port %d joined LAG %d (existing LAG)\n",
 				  port->actor_port_number,
-				  port->aggregator->aggregator_identifier);
+				  aggregator->aggregator_identifier);
 
 			/* mark this port as selected */
 			port->sm_vars |= AD_PORT_SELECTED;
@@ -1656,39 +1658,40 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 	if (!found) {
 		if (free_aggregator) {
 			/* assign port a new aggregator */
-			port->aggregator = free_aggregator;
 			port->actor_port_aggregator_identifier =
-				port->aggregator->aggregator_identifier;
+				free_aggregator->aggregator_identifier;
 
 			/* update the new aggregator's parameters
 			 * if port was responsed from the end-user
 			 */
 			if (port->actor_oper_port_key & AD_DUPLEX_KEY_MASKS)
 				/* if port is full duplex */
-				port->aggregator->is_individual = false;
+				free_aggregator->is_individual = false;
 			else
-				port->aggregator->is_individual = true;
+				free_aggregator->is_individual = true;
 
-			port->aggregator->actor_admin_aggregator_key =
+			free_aggregator->actor_admin_aggregator_key =
 				port->actor_admin_port_key;
-			port->aggregator->actor_oper_aggregator_key =
+			free_aggregator->actor_oper_aggregator_key =
 				port->actor_oper_port_key;
-			port->aggregator->partner_system =
+			free_aggregator->partner_system =
 				port->partner_oper.system;
-			port->aggregator->partner_system_priority =
+			free_aggregator->partner_system_priority =
 				port->partner_oper.system_priority;
-			port->aggregator->partner_oper_aggregator_key = port->partner_oper.key;
-			port->aggregator->receive_state = 1;
-			port->aggregator->transmit_state = 1;
-			port->aggregator->lag_ports = port;
-			port->aggregator->num_of_ports++;
+			free_aggregator->partner_oper_aggregator_key = port->partner_oper.key;
+			free_aggregator->receive_state = 1;
+			free_aggregator->transmit_state = 1;
+			free_aggregator->lag_ports = port;
+			free_aggregator->num_of_ports++;
+
+			rcu_assign_pointer(port->aggregator, free_aggregator);
 
 			/* mark this port as selected */
 			port->sm_vars |= AD_PORT_SELECTED;
 
 			slave_dbg(bond->dev, port->slave->dev, "Port %d joined LAG %d (new LAG)\n",
 				  port->actor_port_number,
-				  port->aggregator->aggregator_identifier);
+				  free_aggregator->aggregator_identifier);
 		} else {
 			slave_err(bond->dev, port->slave->dev,
 				  "Port %d did not find a suitable aggregator\n",
@@ -1700,13 +1703,12 @@ static void ad_port_selection_logic(struct port *port, bool *update_slave_arr)
 	 * in all aggregator's ports, else set ready=FALSE in all
 	 * aggregator's ports
 	 */
-	__set_agg_ports_ready(port->aggregator,
-			      __agg_ports_are_ready(port->aggregator));
+	aggregator = rcu_dereference(port->aggregator);
+	__set_agg_ports_ready(aggregator, __agg_ports_are_ready(aggregator));
 
-	aggregator = __get_first_agg(port);
-	ad_agg_selection_logic(aggregator, update_slave_arr);
+	ad_agg_selection_logic(__get_first_agg(port), update_slave_arr);
 
-	if (!port->aggregator->is_active)
+	if (!aggregator->is_active)
 		port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
 }
 
@@ -2075,13 +2077,15 @@ static void ad_initialize_port(struct port *port, const struct bond_params *bond
  */
 static void ad_enable_collecting(struct port *port)
 {
-	if (port->aggregator->is_active) {
+	struct aggregator *aggregator = rcu_dereference(port->aggregator);
+
+	if (aggregator->is_active) {
 		struct slave *slave = port->slave;
 
 		slave_dbg(slave->bond->dev, slave->dev,
 			  "Enabling collecting on port %d (LAG %d)\n",
 			  port->actor_port_number,
-			  port->aggregator->aggregator_identifier);
+			  aggregator->aggregator_identifier);
 		__enable_collecting_port(port);
 	}
 }
@@ -2093,11 +2097,13 @@ static void ad_enable_collecting(struct port *port)
  */
 static void ad_disable_distributing(struct port *port, bool *update_slave_arr)
 {
-	if (port->aggregator && __agg_has_partner(port->aggregator)) {
+	struct aggregator *aggregator = rcu_dereference(port->aggregator);
+
+	if (aggregator && __agg_has_partner(aggregator)) {
 		slave_dbg(port->slave->bond->dev, port->slave->dev,
 			  "Disabling distributing on port %d (LAG %d)\n",
 			  port->actor_port_number,
-			  port->aggregator->aggregator_identifier);
+			  aggregator->aggregator_identifier);
 		__disable_distributing_port(port);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
@@ -2114,11 +2120,13 @@ static void ad_disable_distributing(struct port *port, bool *update_slave_arr)
 static void ad_enable_collecting_distributing(struct port *port,
 					      bool *update_slave_arr)
 {
-	if (port->aggregator->is_active) {
+	struct aggregator *aggregator = rcu_dereference(port->aggregator);
+
+	if (aggregator->is_active) {
 		slave_dbg(port->slave->bond->dev, port->slave->dev,
 			  "Enabling port %d (LAG %d)\n",
 			  port->actor_port_number,
-			  port->aggregator->aggregator_identifier);
+			  aggregator->aggregator_identifier);
 		__enable_port(port);
 		/* Slave array needs update */
 		*update_slave_arr = true;
@@ -2135,11 +2143,13 @@ static void ad_enable_collecting_distributing(struct port *port,
 static void ad_disable_collecting_distributing(struct port *port,
 					       bool *update_slave_arr)
 {
-	if (port->aggregator && __agg_has_partner(port->aggregator)) {
+	struct aggregator *aggregator = rcu_dereference(port->aggregator);
+
+	if (aggregator && __agg_has_partner(aggregator)) {
 		slave_dbg(port->slave->bond->dev, port->slave->dev,
 			  "Disabling port %d (LAG %d)\n",
 			  port->actor_port_number,
-			  port->aggregator->aggregator_identifier);
+			  aggregator->aggregator_identifier);
 		__disable_port(port);
 		/* Slave array needs an update */
 		*update_slave_arr = true;
@@ -2379,7 +2389,7 @@ void bond_3ad_unbind_slave(struct slave *slave)
 				 */
 				for (temp_port = aggregator->lag_ports; temp_port;
 				     temp_port = temp_port->next_port_in_aggregator) {
-					temp_port->aggregator = new_aggregator;
+					rcu_assign_pointer(temp_port->aggregator, new_aggregator);
 					temp_port->actor_port_aggregator_identifier = new_aggregator->aggregator_identifier;
 				}
 
@@ -2848,15 +2858,16 @@ int bond_3ad_set_carrier(struct bonding *bond)
 int __bond_3ad_get_active_agg_info(struct bonding *bond,
 				   struct ad_info *ad_info)
 {
-	struct aggregator *aggregator = NULL;
+	struct aggregator *aggregator = NULL, *tmp;
 	struct list_head *iter;
 	struct slave *slave;
 	struct port *port;
 
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		port = &(SLAVE_AD_INFO(slave)->port);
-		if (port->aggregator && port->aggregator->is_active) {
-			aggregator = port->aggregator;
+		tmp = rcu_dereference(port->aggregator);
+		if (tmp && tmp->is_active) {
+			aggregator = tmp;
 			break;
 		}
 	}
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c7baa5c4bf40ad614b8512cb69c7343d9b53efb6..af82a3df2c5d386fefa7f1468b792e8c1cb224fa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1433,7 +1433,7 @@ static void bond_poll_controller(struct net_device *bond_dev)
 
 		if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 			struct aggregator *agg =
-			    SLAVE_AD_INFO(slave)->port.aggregator;
+			    rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
 
 			if (agg &&
 			    agg->aggregator_identifier != ad_info.aggregator_id)
@@ -5179,15 +5179,16 @@ int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
 		spin_unlock_bh(&bond->mode_lock);
 		agg_id = ad_info.aggregator_id;
 	}
+	rcu_read_lock();
 	bond_for_each_slave(bond, slave, iter) {
 		if (skipslave == slave)
 			continue;
 
 		all_slaves->arr[all_slaves->count++] = slave;
 		if (BOND_MODE(bond) == BOND_MODE_8023AD) {
-			struct aggregator *agg;
+			const struct aggregator *agg;
 
-			agg = SLAVE_AD_INFO(slave)->port.aggregator;
+			agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
 			if (!agg || agg->aggregator_identifier != agg_id)
 				continue;
 		}
@@ -5199,6 +5200,7 @@ int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
 
 		usable_slaves->arr[usable_slaves->count++] = slave;
 	}
+	rcu_read_unlock();
 
 	bond_set_slave_arr(bond, usable_slaves, all_slaves);
 	return ret;
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index ea1a80e658aeb2862032e006d6a3c92caa2b17e1..c7d3e0602c831dcac74d2bed16b5026cddda4839 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -66,27 +66,29 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 		const struct port *ad_port;
 
 		ad_port = &SLAVE_AD_INFO(slave)->port;
-		agg = SLAVE_AD_INFO(slave)->port.aggregator;
+		rcu_read_lock();
+		agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
 		if (agg) {
 			if (nla_put_u16(skb, IFLA_BOND_SLAVE_AD_AGGREGATOR_ID,
 					agg->aggregator_identifier))
-				goto nla_put_failure;
+				goto nla_put_failure_rcu;
 			if (nla_put_u8(skb,
 				       IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 				       ad_port->actor_oper_port_state))
-				goto nla_put_failure;
+				goto nla_put_failure_rcu;
 			if (nla_put_u16(skb,
 					IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 					ad_port->partner_oper.port_state))
-				goto nla_put_failure;
+				goto nla_put_failure_rcu;
 
 			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
 				       ad_port->sm_churn_actor_state))
-				goto nla_put_failure;
+				goto nla_put_failure_rcu;
 			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
 				       ad_port->sm_churn_partner_state))
-				goto nla_put_failure;
+				goto nla_put_failure_rcu;
 		}
+		rcu_read_unlock();
 
 		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
 				SLAVE_AD_INFO(slave)->port_priority))
@@ -95,6 +97,8 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 
 	return 0;
 
+nla_put_failure_rcu:
+	rcu_read_unlock();
 nla_put_failure:
 	return -EMSGSIZE;
 }
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index e34f80305191353a0fdb6c98a1f86a14a2e30a01..3714aab1a3d9c54cb41de06e074ff483f2ac0b94 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -188,6 +188,7 @@ static void bond_info_show_master(struct seq_file *seq)
 	}
 }
 
+/* Note: runs under rcu_read_lock() */
 static void bond_info_show_slave(struct seq_file *seq,
 				 const struct slave *slave)
 {
@@ -214,7 +215,7 @@ static void bond_info_show_slave(struct seq_file *seq,
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		const struct port *port = &SLAVE_AD_INFO(slave)->port;
-		const struct aggregator *agg = port->aggregator;
+		const struct aggregator *agg = rcu_dereference(port->aggregator);
 
 		if (agg) {
 			seq_printf(seq, "Aggregator ID: %d\n",
diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 36d0e8440b5b94464b3226ce1a04f32361de5aa6..fc6fe7181789d383680beb5082ad443f14eaa4d8 100644
--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -62,10 +62,15 @@ static ssize_t ad_aggregator_id_show(struct slave *slave, char *buf)
 	const struct aggregator *agg;
 
 	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD) {
-		agg = SLAVE_AD_INFO(slave)->port.aggregator;
-		if (agg)
-			return sysfs_emit(buf, "%d\n",
-					  agg->aggregator_identifier);
+		rcu_read_lock();
+		agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
+		if (agg) {
+			ssize_t res = sysfs_emit(buf, "%d\n",
+						 agg->aggregator_identifier);
+			rcu_read_unlock();
+			return res;
+		}
+		rcu_read_unlock();
 	}
 
 	return sysfs_emit(buf, "N/A\n");
@@ -78,7 +83,7 @@ static ssize_t ad_actor_oper_port_state_show(struct slave *slave, char *buf)
 
 	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD) {
 		ad_port = &SLAVE_AD_INFO(slave)->port;
-		if (ad_port->aggregator)
+		if (rcu_access_pointer(ad_port->aggregator))
 			return sysfs_emit(buf, "%u\n",
 				       ad_port->actor_oper_port_state);
 	}
@@ -93,7 +98,7 @@ static ssize_t ad_partner_oper_port_state_show(struct slave *slave, char *buf)
 
 	if (BOND_MODE(slave->bond) == BOND_MODE_8023AD) {
 		ad_port = &SLAVE_AD_INFO(slave)->port;
-		if (ad_port->aggregator)
+		if (rcu_access_pointer(ad_port->aggregator))
 			return sysfs_emit(buf, "%u\n",
 				       ad_port->partner_oper.port_state);
 	}
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index c92d4a976246d2e6d61d5d445b928b34aca93a9a..05572c19e14b7ae97d497cc9c5d97d4314eab295 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -243,7 +243,7 @@ typedef struct port {
 	churn_state_t sm_churn_actor_state;
 	churn_state_t sm_churn_partner_state;
 	struct slave *slave;		/* pointer to the bond slave that this port belongs to */
-	struct aggregator *aggregator;	/* pointer to an aggregator that this port related to */
+	struct aggregator __rcu *aggregator;	/* pointer to an aggregator that this port related to */
 	struct port *next_port_in_aggregator;	/* Next port on the linked list of the parent aggregator */
 	u32 transaction_id;		/* continuous number for identification of Marker PDU's; */
 	struct lacpdu lacpdu;		/* the lacpdu that will be sent for this port */
-- 
2.54.0.545.g6539524ca2-goog


