Return-Path: <netdev+bounces-301753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9p/tHPsfPGrmkAgAu9opvQ
	(envelope-from <netdev+bounces-301753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:20:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386F6C0B4D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BGSQsVkH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301753-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301753-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47530303E15E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAB32BF42;
	Wed, 24 Jun 2026 18:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C745329E5D
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325228; cv=none; b=SJjdwVFMUD/PDNlP0HCZkBbo5VI7YHjbo+eHC4Cez7m499aE8WsHwevLVH/4m5dNHcDayAZPRYW5w/85coLrs7/EZh+xOl5JCJte5rOk3HqeiAvbntYcMRtH+qHWEZneeHX1G1qXaWy7vVlRMv5umWnwalcMJ5SwFCa+vjxsfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325228; c=relaxed/simple;
	bh=4A8HWYBkfkZGSDTJL9J9UFE5cKWCFdTvTAwhZQuIgZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORdr6cam1B57B9VBg0AMP8dcw7ayFaA7ub/T9W772bzCzhCR1rVRCLvVYlIx3DfEwFYQrNv3l99ImoFeqXniJogiIDCbHuQkynbMvWmxPAZ2sJLISMwhd0lKWJY2UxIP+j9s5GfLFgzIvHwdirLWdUDI4w/vEiqrgH5Hymjr8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGSQsVkH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BEB1F000E9;
	Wed, 24 Jun 2026 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325227;
	bh=6Cnvywao+PbJAm9SYg8Hy1arAGQEbcPsDuDWO9kmCbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGSQsVkHrB3eeoTBDOfxD9EWwto/qd4w0SVraM5Kley1dGfOz9DyCUhrY8lzEXtjL
	 hwH6r7IIonrgDY8wecnPCed4Sb0oZoxCsiqg85FvcsGp3COLmEGQC66TQE8u6CtDok
	 Ua7THwyzWntuWeXgPIl/oG1iUM+xd1piBShEkATsAunMvTsIOx5/cb2BdNEGe3+Ot+
	 jvS8o32NsE0kilCMU/p8uNFVmY7Fd/Eb2VvgU5ZuzCeydbu90fxIeLzloe80G7nO9S
	 BY/vFTrzveNiQxj+xMxIAOTxxlmf0clTv9hMtvQidSObkJJHCeCpXgos3FbzHCJmiB
	 nvmCrN3tQFxWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	sdf@fomichev.me,
	dongchenchen2@huawei.com,
	idosch@nvidia.com,
	n05ec@lzu.edu.cn,
	yuantan098@gmail.com,
	kuniyu@google.com,
	nb@tipi-net.de,
	aleksandr.loktionov@intel.com,
	dtatulea@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,
	syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,
	syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
Subject: [PATCH net 3/4] vlan: defer real device state propagation to netdev_work
Date: Wed, 24 Jun 2026 11:20:17 -0700
Message-ID: <20260624182018.2445732-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624182018.2445732-1-kuba@kernel.org>
References: <20260624182018.2445732-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301753-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:kuba@kernel.org,m:syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,m:syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,m:syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com,syzkaller.appspotmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,09da62a8b78959ceb8bb,cb67c392b0b8f0fd0fc1,9bb8bd77f3966641f298];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1386F6C0B4D

vlan_device_event() generates nested UP/DOWN, MTU and feature
change events. It executes an event for the VLAN device directly
from the notifier - while the locks of the lower device are held.

This causes deadlocks, for example:

  bond    (3) bond_update_speed_duplex(vlan)
    |           ^                v
  vlan    (2) UP(vlan)    (4) vlan_ethtool_get_link_ksettings()
    |           ^                v
  dummy   (1) UP(dummy)   (5) __ethtool_get_link_ksettings()

The dummy device is ops locked, vlan creates a nested event (2),
then bond wants to ask vlan for link state (3). bond uses the
"I'm already holding the instance lock" flavor of API. But in
this case the lock held refers to vlan itself. We hit vlan's
link settings trampoline (4) and call __ethtool_get_link_ksettings()
which tries to lock dummy. Deadlock. There's no clean way for us
to tell the vlan_ethtool_get_link_ksettings() that the caller
is already in lower device's critical section.

Defer the propagation to the per-netdev work facility instead:
the notifier only schedules netdev_work_sched(vlandev, VLAN_WORK_*),
and ndo_work (vlan_dev_work) applies the change later. Hopefully
nobody expects the VLAN state changes to be instantaneous.

If someone does expect the changes to be instantaneous we will
have to do the same thing Stan did for rx_mode and "strategically"
place sync calls, to make sure such delayed works are executed
after we drop the ops lock but before we drop rtnl_lock.

Stan suggests that if we need that down the line we may
consider reshaping the mechanism into "async notifications".
AFAICT only vlan does this sort of netdev open chaining,
so as a first try I think that sticking the complexity into
the vlan code makes sense.

One corner case is that we need to cancel the event if user
explicitly changes the state before work could run. Consider
the following operations with vlan0 on top of dummy0:

  ip link set dev dummy0 up    # queues work to up vlan0
  ip link set dev vlan0 down   # user explicitly downs the vlan
  ndo_work                     # acts on the stale event

Reported-by: syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com
Reported-by: syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com
Reported-by: syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
Fixes: 9f275c2e9020 ("net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdevices.rst |  2 +
 net/8021q/vlan.h                        | 11 ++++
 net/8021q/vlan.c                        | 76 +++----------------------
 net/8021q/vlan_dev.c                    | 60 +++++++++++++++++++
 net/core/dev.c                          |  1 +
 5 files changed, 82 insertions(+), 68 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index fde601acd1d2..d2a238f8cc8b 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -433,6 +433,8 @@ exceptions) notifiers run under the instance lock. Please extend this
 documentation whenever you make explicit assumption about lock being held
 from a notifier.
 
+Drivers **must not** generate nested notifications of the ops-locked types.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index c7ffe591d593..c41caaf94095 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -125,6 +125,17 @@ static inline netdev_features_t vlan_tnl_features(struct net_device *real_dev)
 int vlan_filter_push_vids(struct vlan_info *vlan_info, __be16 proto);
 void vlan_filter_drop_vids(struct vlan_info *vlan_info, __be16 proto);
 
+/* netdev_work events propagated from the real device, see vlan_dev_work(). */
+enum {
+	VLAN_WORK_LINK_STATE	= BIT(0), /* sync up/down with real_dev */
+	VLAN_WORK_MTU		= BIT(1), /* clamp mtu to real_dev's */
+	VLAN_WORK_FEATURES	= BIT(2), /* re-inherit real_dev features */
+};
+
+void vlan_stacked_transfer_operstate(const struct net_device *rootdev,
+				     struct net_device *dev,
+				     struct vlan_dev_priv *vlan);
+
 /* found in vlan_dev.c */
 void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb16..2d2efb877975 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -77,9 +77,9 @@ static int vlan_group_prealloc_vid(struct vlan_group *vg,
 	return 0;
 }
 
-static void vlan_stacked_transfer_operstate(const struct net_device *rootdev,
-					    struct net_device *dev,
-					    struct vlan_dev_priv *vlan)
+void vlan_stacked_transfer_operstate(const struct net_device *rootdev,
+				     struct net_device *dev,
+				     struct vlan_dev_priv *vlan)
 {
 	if (!(vlan->flags & VLAN_FLAG_BRIDGE_BINDING))
 		netif_stacked_transfer_operstate(rootdev, dev);
@@ -316,29 +316,6 @@ static void vlan_sync_address(struct net_device *dev,
 	ether_addr_copy(vlan->real_dev_addr, dev->dev_addr);
 }
 
-static void vlan_transfer_features(struct net_device *dev,
-				   struct net_device *vlandev)
-{
-	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
-
-	netif_inherit_tso_max(vlandev, dev);
-
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
-
-#if IS_ENABLED(CONFIG_FCOE)
-	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
-#endif
-
-	vlandev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	vlandev->priv_flags |= (vlan->real_dev->priv_flags & IFF_XMIT_DST_RELEASE);
-	vlandev->hw_enc_features = vlan_tnl_features(vlan->real_dev);
-
-	netdev_update_features(vlandev);
-}
-
 static int __vlan_device_event(struct net_device *dev, unsigned long event)
 {
 	int err = 0;
@@ -391,13 +368,11 @@ static void vlan_vid0_del(struct net_device *dev)
 static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			     void *ptr)
 {
-	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct vlan_group *grp;
 	struct vlan_info *vlan_info;
 	int i, flgs;
 	struct net_device *vlandev;
-	struct vlan_dev_priv *vlan;
 	bool last = false;
 	LIST_HEAD(list);
 	int err;
@@ -447,54 +422,19 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			if (vlandev->mtu <= dev->mtu)
 				continue;
 
-			dev_set_mtu(vlandev, dev->mtu);
+			netdev_work_sched(vlandev, VLAN_WORK_MTU);
 		}
 		break;
 
 	case NETDEV_FEAT_CHANGE:
-		/* Propagate device features to underlying device */
 		vlan_group_for_each_dev(grp, i, vlandev)
-			vlan_transfer_features(dev, vlandev);
+			netdev_work_sched(vlandev, VLAN_WORK_FEATURES);
 		break;
 
-	case NETDEV_DOWN: {
-		struct net_device *tmp;
-		LIST_HEAD(close_list);
-
-		/* Put all VLANs for this dev in the down state too.  */
-		vlan_group_for_each_dev(grp, i, vlandev) {
-			flgs = vlandev->flags;
-			if (!(flgs & IFF_UP))
-				continue;
-
-			vlan = vlan_dev_priv(vlandev);
-			if (!(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
-				list_add(&vlandev->close_list, &close_list);
-		}
-
-		netif_close_many(&close_list, false);
-
-		list_for_each_entry_safe(vlandev, tmp, &close_list, close_list) {
-			vlan_stacked_transfer_operstate(dev, vlandev,
-							vlan_dev_priv(vlandev));
-			list_del_init(&vlandev->close_list);
-		}
-		list_del(&close_list);
-		break;
-	}
+	case NETDEV_DOWN:
 	case NETDEV_UP:
-		/* Put all VLANs for this dev in the up state too.  */
-		vlan_group_for_each_dev(grp, i, vlandev) {
-			flgs = netif_get_flags(vlandev);
-			if (flgs & IFF_UP)
-				continue;
-
-			vlan = vlan_dev_priv(vlandev);
-			if (!(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
-				dev_change_flags(vlandev, flgs | IFF_UP,
-						 extack);
-			vlan_stacked_transfer_operstate(dev, vlandev, vlan);
-		}
+		vlan_group_for_each_dev(grp, i, vlandev)
+			netdev_work_sched(vlandev, VLAN_WORK_LINK_STATE);
 		break;
 
 	case NETDEV_UNREGISTER:
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 7aa3af8b10ea..ec2569b3f8da 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -270,6 +270,9 @@ static int vlan_dev_open(struct net_device *dev)
 	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
 		return -ENETDOWN;
 
+	/* The explicit open supersedes any deferred link-state sync */
+	netdev_work_cancel(dev, VLAN_WORK_LINK_STATE);
+
 	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
 	    !vlan_dev_inherit_address(dev, real_dev)) {
 		err = dev_uc_add(real_dev, dev->dev_addr);
@@ -300,6 +303,9 @@ static int vlan_dev_stop(struct net_device *dev)
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	struct net_device *real_dev = vlan->real_dev;
 
+	/* The explicit close supersedes any deferred link-state sync */
+	netdev_work_cancel(dev, VLAN_WORK_LINK_STATE);
+
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
 
@@ -1016,6 +1022,59 @@ static const struct ethtool_ops vlan_ethtool_ops = {
 	.get_ts_info		= vlan_ethtool_get_ts_info,
 };
 
+static void vlan_transfer_features(struct net_device *dev,
+				   struct net_device *vlandev)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
+
+	netif_inherit_tso_max(vlandev, dev);
+
+	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
+		vlandev->hard_header_len = dev->hard_header_len;
+	else
+		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+
+#if IS_ENABLED(CONFIG_FCOE)
+	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
+#endif
+
+	vlandev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	vlandev->priv_flags |= (vlan->real_dev->priv_flags & IFF_XMIT_DST_RELEASE);
+	vlandev->hw_enc_features = vlan_tnl_features(vlan->real_dev);
+
+	netdev_update_features(vlandev);
+}
+
+static void vlan_dev_work(struct net_device *vlandev, unsigned long events)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
+	struct net_device *real_dev = vlan->real_dev;
+	bool loose = vlan->flags & VLAN_FLAG_LOOSE_BINDING;
+	unsigned int flgs;
+
+	if (events & VLAN_WORK_LINK_STATE) {
+		flgs = netif_get_flags(vlandev);
+		if (real_dev->flags & IFF_UP) {
+			if (!(flgs & IFF_UP)) {
+				if (!loose)
+					netif_change_flags(vlandev,
+							   flgs | IFF_UP, NULL);
+				vlan_stacked_transfer_operstate(real_dev,
+								vlandev, vlan);
+			}
+		} else if ((flgs & IFF_UP) && !loose) {
+			netif_change_flags(vlandev, flgs & ~IFF_UP, NULL);
+			vlan_stacked_transfer_operstate(real_dev, vlandev, vlan);
+		}
+	}
+
+	if ((events & VLAN_WORK_MTU) && vlandev->mtu > real_dev->mtu)
+		netif_set_mtu(vlandev, real_dev->mtu);
+
+	if (events & VLAN_WORK_FEATURES)
+		vlan_transfer_features(real_dev, vlandev);
+}
+
 static const struct net_device_ops vlan_netdev_ops = {
 	.ndo_change_mtu		= vlan_dev_change_mtu,
 	.ndo_init		= vlan_dev_init,
@@ -1027,6 +1086,7 @@ static const struct net_device_ops vlan_netdev_ops = {
 	.ndo_set_mac_address	= vlan_dev_set_mac_address,
 	.ndo_set_rx_mode	= vlan_dev_set_rx_mode,
 	.ndo_change_rx_flags	= vlan_dev_change_rx_flags,
+	.ndo_work		= vlan_dev_work,
 	.ndo_eth_ioctl		= vlan_dev_ioctl,
 	.ndo_neigh_setup	= vlan_dev_neigh_setup,
 	.ndo_get_stats64	= vlan_dev_get_stats64,
diff --git a/net/core/dev.c b/net/core/dev.c
index e1d8af0ef6ab..4b3d5cfdf6e0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9822,6 +9822,7 @@ int netif_change_flags(struct net_device *dev, unsigned int flags,
 	__dev_notify_flags(dev, old_flags, changes, 0, NULL);
 	return ret;
 }
+EXPORT_SYMBOL(netif_change_flags);
 
 int __netif_set_mtu(struct net_device *dev, int new_mtu)
 {
-- 
2.54.0


