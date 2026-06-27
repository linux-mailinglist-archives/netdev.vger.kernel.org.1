Return-Path: <netdev+bounces-302330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g05gEvCxP2q1XAkAu9opvQ
	(envelope-from <netdev+bounces-302330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 13:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02D6D1D2E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 13:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DLnLsZml;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302330-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1D7302882F
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55E391849;
	Sat, 27 Jun 2026 11:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A84377EDC;
	Sat, 27 Jun 2026 11:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782559213; cv=none; b=jEzOWjWPUqRphovu+r6IoPAmxRWhAaoD3gAeVPS4N/lwiPzee9FmuUImi37Tgxyef8D8vpHxCDriH86p4agKd1JIMUFzJmccLFPxnT29sKSux2I3t1ZzrOmbN84IArD3hpIo2IQ0EBAe+cA4ncZfVkcsI/+kcJXZjDJZTu6Qfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782559213; c=relaxed/simple;
	bh=WCUXx01z2Y8UfrblA6Ezt3HI1umsj9SWxKhZyA6sByM=;
	h=From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Date; b=n/Acuq3pByskc4rd8qAnrEDlrZuabS0LQIVQd3ZCzvYZ6339isXEUTeIXtg5mcXM0KuiPZAbc21AD3i+HrEvkKNjYo/R0YlIGDLdkuTpWASlYg0j+3RhVOgg66cawqQdhk4rfmh2QvIAu2XYE3E62OUoj/ezrpRLH7EhUbhPwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLnLsZml; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 941371F000E9;
	Sat, 27 Jun 2026 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782559211;
	bh=rYQQUx7LclQ+ZAbuPlSmf6Qov10I1jjdY4SZQEjrMzo=;
	h=From:To:Cc:Subject:Date;
	b=DLnLsZmlcfPyo9IBhwaOY1ujPCLRDk/34TQFaHBLEsFEZLO0JlN7rphArobKVGcwj
	 OU0JiOiT7LanCWLv7d2O+uSMNyBaMX7KSm1m3K/apA6Oc60RLEfvFXhb+pKzAeygP7
	 ewq/qGR/lgcDfoDXfjeEiM5ctaQnV5M3DURkUWv2OVMUEypnP/HFCoukmDXjYLvDvU
	 vPsF5Eu/wIjEhzLWOanODN+4a0h/yvAs7KaLVAWuWEkcYHAFVmcAVuXnjlCoAn/SRb
	 IwXH9TcHog+MW3Tp+JBBDhovFLqXzNXrYaNMBavkOrFoUsPX3s2F41gALEzqUEO2y7
	 CJHcDG8jQz3dQ==
From: "syzbot" <syzbot@kernel.org>
To: syzkaller-bugs@googlegroups.com, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
Subject: [PATCH] netdevsim: remove debugfs files before freeing net_device
Message-ID: <f15205c4-30e1-454f-97e6-92067a74f98f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sat, 27 Jun 2026 11:20:11 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:syzkaller-bugs@googlegroups.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:syzbot@lists.linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,goo.gle:url,mail.kernel.org:mid,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C02D6D1D2E

From: Aleksandr Nogikh <nogikh@google.com>

A KASAN slab-use-after-free was detected in debugfs_u32_get() when reading
a debugfs file associated with a netdevsim port.

BUG: KASAN: slab-use-after-free in debugfs_u32_get+0x6c/0x70
Read of size 4 at addr ffff88810cd6db00

Call Trace:
 debugfs_u32_get+0x6c/0x70
 simple_attr_read+0x227/0x490
 debugfs_attr_read+0x76/0x130
 vfs_read+0x213/0xa80

The root cause is that the net_device (and its embedded netdevsim private
data) is freed before its associated debugfs files are removed. When a user
reads a debugfs file like rx_max_pending, debugfs_u32_get() dereferences a
pointer to the freed memory. This happens because nsim_destroy() calls
free_netdev() but does not remove the debugfs files created by
nsim_ethtool_init() or nsim_bpf_init(). These files are only removed later
when nsim_dev_port_debugfs_exit() is called. A similar issue exists in the
error path of nsim_create().

To fix this, swap the teardown order in __nsim_dev_port_del() and the
__nsim_dev_port_add() error path so that nsim_dev_port_debugfs_exit() is
called before nsim_destroy(). This ensures the debugfs directory is
recursively removed before the net_device is freed. Additionally, remove
explicit debugfs_remove() calls from various subsystem teardown functions
(like nsim_psp_uninit, nsim_ipsec_teardown, etc.) since the parent
directory is now removed earlier, which would otherwise lead to a
use-after-free of the dentry itself. Finally, ensure the debugfs directory
is removed before free_netdev() is called in the nsim_create() error path.

Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
Assisted-by: Gemini:gemini-3.1-pro-preview Gemini:gemini-3-flash-preview syzbot
Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
Link: https://syzkaller.appspot.com/ai_job?id=f0f1a72a-a527-478e-a31c-7b83cdfee8d1
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>

---
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index f00fc2f9e..4c2c9aa1e 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1516,17 +1516,17 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 		err = devl_rate_leaf_create(&nsim_dev_port->devlink_port,
 					    nsim_dev_port, NULL);
 		if (err)
-			goto err_nsim_destroy;
+			goto err_port_debugfs_exit;
 	}
 
 	list_add(&nsim_dev_port->list, &nsim_dev->port_list);
 
 	return 0;
 
-err_nsim_destroy:
-	nsim_destroy(nsim_dev_port->ns);
 err_port_debugfs_exit:
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	if (!IS_ERR_OR_NULL(nsim_dev_port->ns))
+		nsim_destroy(nsim_dev_port->ns);
 err_port_resource_unregister:
 	if (nsim_dev_port_is_pf(nsim_dev_port))
 		devl_port_resources_unregister(devlink_port);
@@ -1544,8 +1544,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
 	list_del(&nsim_dev_port->list);
 	if (nsim_dev_port_is_vf(nsim_dev_port))
 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
-	nsim_destroy(nsim_dev_port->ns);
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	nsim_destroy(nsim_dev_port->ns);
 	if (nsim_dev_port_is_pf(nsim_dev_port))
 		devl_port_resources_unregister(devlink_port);
 	devl_port_unregister(devlink_port);
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 36a1be492..0bc9f42a5 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -292,5 +292,4 @@ void nsim_ipsec_teardown(struct netdevsim *ns)
 	if (ipsec->count)
 		netdev_err(ns->netdev, "tearing down IPsec offload with %d SAs left\n",
 			   ipsec->count);
-	debugfs_remove_recursive(ipsec->pfile);
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a75076891..240107369 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1154,16 +1154,17 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	if (err)
 		goto err_free_netdev;
 
-	ns->pp_dfs = debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir,
-					 ns, &nsim_pp_hold_fops);
-	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
-					 nsim_dev_port->ddir, ns,
-					 &nsim_qreset_fops);
-	ns->vlan_dfs = debugfs_create_file("vlan", 0400, nsim_dev_port->ddir,
-					   ns, &nsim_vlan_fops);
+	debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir, ns,
+			    &nsim_pp_hold_fops);
+	debugfs_create_file("queue_reset", 0200, nsim_dev_port->ddir, ns,
+			    &nsim_qreset_fops);
+	debugfs_create_file("vlan", 0400, nsim_dev_port->ddir, ns,
+			    &nsim_vlan_fops);
 	return ns;
 
 err_free_netdev:
+	debugfs_remove_recursive(nsim_dev_port->ddir);
+	nsim_dev_port->ddir = NULL;
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -1174,10 +1175,6 @@ void nsim_destroy(struct netdevsim *ns)
 	struct netdevsim *peer;
 	u16 vid;
 
-	debugfs_remove(ns->vlan_dfs);
-	debugfs_remove(ns->qr_dfs);
-	debugfs_remove(ns->pp_dfs);
-
 	if (ns->nb.notifier_call)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
 						      &ns->nn);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d909c4160..29cbf004a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -153,9 +153,6 @@ struct netdevsim {
 	} udp_ports;
 
 	struct page *page;
-	struct dentry *pp_dfs;
-	struct dentry *qr_dfs;
-	struct dentry *vlan_dfs;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6936ecb81..2f27a2114 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -227,7 +227,6 @@ static void __nsim_psp_uninit(struct netdevsim *ns, bool teardown)
 
 void nsim_psp_uninit(struct netdevsim *ns)
 {
-	debugfs_remove(ns->psp.rereg);
 	mutex_destroy(&ns->psp.rereg_lock);
 	__nsim_psp_uninit(ns, true);
 }
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 89fff76e5..a69b15f12 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -188,9 +188,6 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 
 void nsim_udp_tunnels_info_destroy(struct net_device *dev)
 {
-	struct netdevsim *ns = netdev_priv(dev);
-
-	debugfs_remove_recursive(ns->udp_ports.ddir);
 	kfree(dev->udp_tunnel_nic_info);
 	dev->udp_tunnel_nic_info = NULL;
 }


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
See https://goo.gle/syzbot-ai-patches for information about AI-generated patches.
You can comment on the patch as usual, syzbot will try to address
the comments and send a new version of the patch if necessary.
syzbot engineers can be reached at syzkaller@googlegroups.com.

