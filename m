Return-Path: <netdev+bounces-61877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DABD82525D
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792C61C22D11
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5825565;
	Fri,  5 Jan 2024 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="Zr2oMoPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC20250F9
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kIwG8XY3AVKxa6hbWa8CsvJdWKiMZ0MYfVzxh6XRUIU=; b=Zr2oMoPtNtxMr88FMWDlnGxh/8
	3e1EKMe/5/MoVN8MwzmP246mbotltAb9HRTqSoSl0N5tzsOrjgKOX475MKsMDjD/aWwmZAR+VDfVS
	rqFZ0S866hKITWCB/EiMXb6ijmUxoweaa7Re7aKjgkDV/9NOCPJj4k2yhILgWRvRphTIDNXYkV9Zv
	CQNV1PaaoTrb1VFZjR0fxwGn21uaBJHWyIT7JUhMuAEdJD+NojOdWp4i4Jt902arerAoirj3fBAwC
	sXjc7pzgqLKzmM086sv7nq5mZGlXGDwgXyzrkPc0no51KN4dcvYUNJDtljf32H3Iz9q7KyPZuHmbM
	sDeeMBCw==;
Received: from [192.168.1.4] (port=44807 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhia-0000en-0D;
	Fri, 05 Jan 2024 11:46:24 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:23 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 3/6] net: dsa: implement cross chip port mirroring
Date: Fri, 5 Jan 2024 11:46:16 +0100
Message-ID: <c042ed8271d86fbea62807c3dbeaddb8e9b80810.1704449760.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1704449760.git.ante.knezic@helmholz.de>
References: <cover.1704449760.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

Cross-chip port mirroring requires creating mirroring
segments on each switch that is acting as a part of the
mirroring route, from source to destination mirroring port.
For example, following configuration:

  SW0            SW1           SW2           SW3
+-------+     +-------+     +-------+     +--------+
|     P9|<--->|P10  P9|<--->|P10  P9|<--->|P10     |
|       |     |       |     |       |     |        |
+-------+     +-------+     +----+--+     +--------+
    ^                            |
    |                            v
   P2                           P8

needs dsa tree devices to be configured as follows:
  ----------------------------------------
  |    |     source         destination  |
  | SW |  mirror port       mirror port  |
  ----------------------------------------
  |  0 |   P2          ->      P9        |
  |  1 |   P10         ->      P9        |
  |  2 |   P10         ->      P8        |
  |  3 |               ->                |
  ----------------------------------------

This means that request for adding port mirroring needs to
be propagated to the entire dsa switch tree as we can have
mirroring path in which all switches need to be setup.
This is achieved through use of switch event notifiers.
When adding port mirroring, first step is to create a mirroring
route which will contain source and destination ports for each
switch in the route. Then, this route is passed on to each switch
where it is evaluated for mirror settings for this particular
switch. If a switch is contained inside the route, its source
and destination ports are passed on to ds->ops->port_mirror_add()
normally.
Similar principle applies when removing port mirroring, where
complete mirroring route needs to be extracted from dsa_tree
mirrors list.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 net/dsa/switch.c |  52 +++++++++++++++++
 net/dsa/switch.h |   8 +++
 net/dsa/user.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 219 insertions(+), 15 deletions(-)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 3d2feeea897b..5a81742cb139 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -125,6 +125,52 @@ static int dsa_switch_bridge_leave(struct dsa_switch *ds,
 	return 0;
 }
 
+static int dsa_switch_mirror_add(struct dsa_switch *ds,
+				 struct dsa_notifier_mirror_info *info)
+{
+	struct dsa_route *dr;
+	struct dsa_port *dp;
+	bool ingress;
+	int to_port;
+
+	list_for_each_entry(dr, &info->mirror->route, list) {
+		if (ds->index == dr->sw_index) {
+			ingress = info->mirror->ingress;
+			dp = dsa_to_port(ds, dr->to_local_p);
+			to_port = dp->index;
+
+			return ds->ops->port_mirror_add(ds, dr->from_local_p,
+							to_port, ingress,
+							info->extack);
+		}
+	}
+
+	return 0;
+}
+
+static int dsa_switch_mirror_del(struct dsa_switch *ds,
+				 struct dsa_notifier_mirror_info *info)
+{
+	struct dsa_route *dr;
+	struct dsa_port *dp;
+	bool ingress;
+	int to_port;
+
+	/* check if switch is a part of the route we are trying to delete */
+	list_for_each_entry(dr, &info->mirror->route, list) {
+		if (ds->index == dr->sw_index) {
+			ingress = info->mirror->ingress;
+			dp = dsa_to_port(ds, dr->to_local_p);
+			to_port = dp->index;
+
+			ds->ops->port_mirror_del(ds, dr->from_local_p,
+						 to_port, ingress);
+		}
+	}
+
+	return 0;
+}
+
 /* Matches for all upstream-facing ports (the CPU port and all upstream-facing
  * DSA links) that sit between the targeted port on which the notifier was
  * emitted and its dedicated CPU port.
@@ -1059,6 +1105,12 @@ static int dsa_switch_event(struct notifier_block *nb,
 	case DSA_NOTIFIER_CONDUIT_STATE_CHANGE:
 		err = dsa_switch_conduit_state_change(ds, info);
 		break;
+	case DSA_NOTIFIER_MIRROR_ADD:
+		err = dsa_switch_mirror_add(ds, info);
+		break;
+	case DSA_NOTIFIER_MIRROR_DEL:
+		err = dsa_switch_mirror_del(ds, info);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
diff --git a/net/dsa/switch.h b/net/dsa/switch.h
index be0a2749cd97..9fa52f5bc11d 100644
--- a/net/dsa/switch.h
+++ b/net/dsa/switch.h
@@ -35,6 +35,8 @@ enum {
 	DSA_NOTIFIER_TAG_8021Q_VLAN_ADD,
 	DSA_NOTIFIER_TAG_8021Q_VLAN_DEL,
 	DSA_NOTIFIER_CONDUIT_STATE_CHANGE,
+	DSA_NOTIFIER_MIRROR_ADD,
+	DSA_NOTIFIER_MIRROR_DEL,
 };
 
 /* DSA_NOTIFIER_AGEING_TIME */
@@ -111,6 +113,12 @@ struct dsa_notifier_conduit_state_info {
 	bool operational;
 };
 
+/* DSA_NOTIFIER_MIRROR_ADD */
+struct dsa_notifier_mirror_info {
+	const struct dsa_mirror *mirror;
+	struct netlink_ext_ack *extack;
+};
+
 struct dsa_vlan *dsa_vlan_find(struct list_head *vlan_list,
 			       const struct switchdev_obj_port_vlan *vlan);
 
diff --git a/net/dsa/user.c b/net/dsa/user.c
index ce73d0a5140d..7f705ae8633b 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1359,6 +1359,89 @@ dsa_user_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
 	return NULL;
 }
 
+static int dsa_route_add_segment(int sw_index, int from_port,
+				 int to_port, struct list_head *route)
+{
+	struct dsa_route *nr;
+
+	nr = kzalloc(sizeof(*nr), GFP_KERNEL);
+	if (!nr)
+		return -ENOMEM;
+
+	nr->sw_index = sw_index;
+	nr->from_local_p = from_port;
+	nr->to_local_p = to_port;
+	list_add(&nr->list, route);
+	return 0;
+}
+
+static int dsa_route_create(struct dsa_port *from_dp, struct dsa_port *to_dp,
+			    struct dsa_port *iter, struct list_head *route)
+{
+	struct dsa_switch_tree *dst = from_dp->ds->dst;
+	struct dsa_route *dr;
+	struct dsa_link *dl;
+	int err;
+
+	if (from_dp->ds == to_dp->ds)
+		return dsa_route_add_segment(from_dp->ds->index, from_dp->index,
+					     to_dp->index, route);
+
+	/* Assign iter to final "to port" on first entry */
+	if (!iter)
+		iter = to_dp;
+
+	list_for_each_entry(dl, &dst->rtable, list) {
+		if (dl->dp->ds != iter->ds)
+			continue;
+
+		dr = list_first_entry_or_null(route, struct dsa_route, list);
+
+		if (!dr || dr->sw_index != dl->link_dp->ds->index) {
+			err = dsa_route_add_segment(dl->dp->ds->index, dl->dp->index,
+						    dr ? iter->index : to_dp->index,
+						    route);
+			if (err)
+				return err;
+
+			/* have we reached the final "from" device */
+			if (dl->link_dp->ds == from_dp->ds)
+				return dsa_route_add_segment(dl->link_dp->ds->index,
+							     from_dp->index,
+							     dl->link_dp->index, route);
+
+			err = dsa_route_create(from_dp, to_dp, dl->link_dp, route);
+			if (err <= 0)
+				return err;
+		}
+	}
+
+	dr = list_first_entry_or_null(route, struct dsa_route, list);
+	if (dr) {
+		list_del(&dr->list);
+		kfree(dr);
+	}
+
+	return 1;
+}
+
+static struct dsa_mirror *dsa_tree_find_mirror(struct dsa_switch_tree *dst,
+					       struct dsa_port *from_dp,
+					       struct dsa_mall_mirror_tc_entry *mirror)
+{
+	struct dsa_mirror *dm;
+
+	list_for_each_entry(dm, &dst->mirrors, list) {
+		if (dm->ingress != mirror->ingress)
+			continue;
+
+		if (dm->from_dp == from_dp && dm->to_dp == mirror->to_port)
+			return dm;
+	}
+
+	return NULL;
+}
+
 static int
 dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 				 struct tc_cls_matchall_offload *cls,
@@ -1369,9 +1452,12 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_mall_mirror_tc_entry *mirror;
 	struct dsa_mall_tc_entry *mall_tc_entry;
+	struct dsa_notifier_mirror_info info;
 	struct dsa_switch *ds = dp->ds;
 	struct flow_action_entry *act;
+	struct dsa_route *dr, *n;
 	struct dsa_port *to_dp;
+	struct dsa_mirror *dm;
 	int err;
 
 	if (!ds->ops->port_mirror_add)
@@ -1389,6 +1475,10 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!dsa_user_dev_check(act->dev))
 		return -EOPNOTSUPP;
 
+	to_dp = dsa_user_to_port(act->dev);
+	if (ds->dst != to_dp->ds->dst)
+		return -EINVAL;
+
 	mall_tc_entry = kzalloc(sizeof(*mall_tc_entry), GFP_KERNEL);
 	if (!mall_tc_entry)
 		return -ENOMEM;
@@ -1396,20 +1486,53 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_MIRROR;
 	mirror = &mall_tc_entry->mirror;
-
-	to_dp = dsa_user_to_port(act->dev);
-
 	mirror->to_port = to_dp;
 	mirror->ingress = ingress;
 
-	err = ds->ops->port_mirror_add(ds, dp->index, to_dp->index, ingress, extack);
-	if (err) {
-		kfree(mall_tc_entry);
-		return err;
+	if (dsa_tree_find_mirror(ds->dst, dp, mirror)) {
+		err = -EINVAL;
+		goto err_mirror;
+	}
+
+	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
+	if (!dm) {
+		err = -ENOMEM;
+		goto err_mirror;
 	}
 
+	INIT_LIST_HEAD(&dm->route);
+	dm->from_dp = dp;
+	dm->to_dp = to_dp;
+	dm->ingress = ingress;
+
+	if (dsa_route_create(dp, to_dp, NULL, &dm->route)) {
+		err = -EINVAL;
+		goto err_route;
+	}
+
+	info.mirror = dm;
+	info.extack = extack;
+
+	err = dsa_tree_notify(ds->dst, DSA_NOTIFIER_MIRROR_ADD, &info);
+	if (err)
+		goto err_route;
+
+	list_add(&dm->list, &ds->dst->mirrors);
 	list_add_tail(&mall_tc_entry->list, &p->mall_tc_list);
 
+	return 0;
+
+err_route:
+	dsa_tree_notify(ds->dst, DSA_NOTIFIER_MIRROR_DEL, &info);
+
+	list_for_each_entry_safe(dr, n, &dm->route, list) {
+		list_del(&dr->list);
+		kfree(dr);
+	}
+	kfree(dm);
+err_mirror:
+	kfree(mall_tc_entry);
+
 	return err;
 }
 
@@ -1491,6 +1614,33 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 	return err;
 }
 
+static void dsa_user_mirror_del(struct dsa_switch *ds, struct dsa_port *dp,
+				struct dsa_mall_mirror_tc_entry *mirror)
+{
+	struct dsa_notifier_mirror_info info;
+	struct dsa_route *dr, *n;
+	struct dsa_mirror *dm;
+
+	dm = dsa_tree_find_mirror(ds->dst, dp, mirror);
+
+	if (!dm) {
+		netdev_err(dp->user, "failed to delete mirror\n");
+		return;
+	}
+
+	info.mirror = dm;
+
+	dsa_tree_notify(ds->dst, DSA_NOTIFIER_MIRROR_DEL, &info);
+
+	list_for_each_entry_safe(dr, n, &dm->route, list) {
+		list_del(&dr->list);
+		kfree(dr);
+	}
+
+	list_del(&dm->list);
+	kfree(dm);
+}
+
 static void dsa_user_del_cls_matchall(struct net_device *dev,
 				      struct tc_cls_matchall_offload *cls)
 {
@@ -1506,14 +1656,8 @@ static void dsa_user_del_cls_matchall(struct net_device *dev,
 
 	switch (mall_tc_entry->type) {
 	case DSA_PORT_MALL_MIRROR:
-		if (ds->ops->port_mirror_del) {
-			struct dsa_mall_mirror_tc_entry *mirror;
-
-			mirror = &mall_tc_entry->mirror;
-			ds->ops->port_mirror_del(ds, dp->index,
-						 mirror->to_port->index,
-						 mirror->ingress);
-		}
+		if (ds->ops->port_mirror_del)
+			dsa_user_mirror_del(ds, dp, &mall_tc_entry->mirror);
 		break;
 	case DSA_PORT_MALL_POLICER:
 		if (ds->ops->port_policer_del)
-- 
2.11.0


