Return-Path: <netdev+bounces-268559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kExODO41uWmcvAEAu9opvQ
	(envelope-from <netdev+bounces-268559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:07:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5CA2A877A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05163022608
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273483A6B91;
	Tue, 17 Mar 2026 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgO5Ns7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8F359A9F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745443; cv=none; b=L+S57hdKaO7yuSXT7UevzD0YxBUq69lPti2jsVzFXoq07MNJjK+5vELx5/y9AI8Lv6djySj0OJJCKgS3xTdpn1RzTezB3/CiHoSt3HUYC1B0u/foKp/mcFuVM5v/g1s+1700bdgCFW3HeHbAN1ujheLOCubm5Isy/olJ5WQdJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745443; c=relaxed/simple;
	bh=KNMdTz0dMtsZ0/bH1FzXk+0DNsqD2IF/dA5rxowQT18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rx3tGjTQ8EcNcvgOr86gBhMabuB07YZiP+IlzXbHElP6sHQfOLMocLsZxHWKefpViNQeFmbrM5LYWZmBx7ccFdmYNk/xccDOeQ3uAE+KEhVhciI01IJksex45cqj5ENiyHp+MI+8PcJ8gXW+kArs0d5sYLoaihbncSEYKU0iCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgO5Ns7W; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b979d16dd0cso442194466b.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773745440; x=1774350240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+sB1F9ylcq5EEMpOQgUFXx9/JMgB+sZnio0KZ13MVg=;
        b=OgO5Ns7WLfKdW2/u+iUMNWrD3g+Gp8awfDhS9vA4/291hZClk594QsheW0UQu4HelG
         J73i7x5kMI9vJ3w1b9ADmZltai2BmOUyvxyl6wzYtBaQAeobpMAa4+n31mhhz19Vlhiu
         yA4OBhCVmiLtwCvkD6YpEI6odDLuHmqb4Gjje4NzCQjjdHLmaF1VHCVl5QxUKZBTF7qV
         EZPHF9SqIeqRy1czO4nIxfK1nKYeUMAQGgsAoTi8JZHpiK7waTZ+6VQAgktogIc7MQk0
         2xpTin/OtUPmr7stXO8Hj7iK/cMNgnLf9xlEDEDhc7lgxPPDjEgNyM6eGDfZhJhjJ0Po
         HKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773745440; x=1774350240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+sB1F9ylcq5EEMpOQgUFXx9/JMgB+sZnio0KZ13MVg=;
        b=YtZTSRiBNaSVPh9955r5VVTdgrTsPA50x72rK8DRU5qjIqLqzowd9byzzJZb4KRasE
         2cxiHrfkNuNzRRAu2fA44VbqK2yKSzOsJ0m7Mevxn2ih0Q/Y7QcCXwpuuWPmbhirzDTA
         hnBL78s9f58ty1gny7SYP+HqTzjWeZigTmHFiKdhzFtCwEVdf08/UEYPA2yxb9hXx2NU
         5SQpUSiY1s31yXLIpvcjM7bPz4aDUurmxAJiaO7EnelIlKvzU3W3p7DpVTBZtUU3Tuj9
         GuO++q9Kh5iY+PC0cjHJK8kwmZUKmxWkeOVZRKHsubu/PUmchbLwlWwCYzPEqzSbEfmV
         6VLg==
X-Gm-Message-State: AOJu0Yzyi9FlVVqpL192LMwtzzVv2OBnKW1OoHIxpG6AIDPHVXh4c7nA
	fzylC7XXX39ausW6NrpKOz+FA/v90t7Invp9yBc+ZvFWePeIlCqFMXo6
X-Gm-Gg: ATEYQzzVTx4qBJHUBYKA1p3ZIvOne9Dr8BsD6RoT3rJKD3wjffNZESm60hVBVLZYzje
	vwhgqievFx99h/J2d4zsEIWC3w98ZVrWAFt7Q1Px1JPmWAzMRoppE/z0accF99faVGkfhl+iqqE
	SZRk1obTot4KpbSm5uATw7Z2CTgE0Wosgq4LpyDzRwe2nZdu13AU6Zc6oyLgI/kUhpHLGCOfp2I
	U66UiAEEp2eY9Z0lan9VVASp6l7b/DksDep8FqjXtoTuvsv8cwDMP34nEIrh8VKLUbmiUBdyd60
	+PhcsYFKSahtQrnP3ZyRVsBfqZca+sX+6HKe7Nm6RhkDGlaBnjvwNRykl0D+c89ypBD3zKFRAem
	ODtykiowXeU4xVKM4naTKn0ZTgLtkEZUXAdXC5hMmhCrsUl1V7IyuZONkAro7maHZ/SOxZ+tZ09
	ZOyTzFlG45s+B36w7gFCXpUQdCA0zQAqV5DiFgjs1xpZggCwKWkIqoGWJjOAWf4SYK980BD7Vjo
	1/54mr/ceNA1M5RucHGnSQr2z2KOJud5X9XOTutHmGMfnjRM2GjcAg=
X-Received: by 2002:a17:907:94d6:b0:b97:9076:f84f with SMTP id a640c23a62f3a-b979077179cmr655488666b.45.1773745439719;
        Tue, 17 Mar 2026 04:03:59 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9791c30cf3sm594116866b.2.2026.03.17.04.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:03:59 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 net-next] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
Date: Tue, 17 Mar 2026 12:03:47 +0100
Message-ID: <20260317110347.363875-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-268559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD5CA2A877A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In network setup as below:

             fastpath bypass
 .----------------------------------------.
/                                          \
|                        IP - forwarding    |
|                       /                \  v
|                      /                  wan ...
|                     /
|                     |
|                     |
|                   brlan.1
|                     |
|    +-------------------------------+
|    |           vlan 1              |
|    |                               |
|    |     brlan (vlan-filtering)    |
|    |               +---------------+
|    |               |  DSA-SWITCH   |
|    |    vlan 1     |               |
|    |      to       |               |
|    |   untagged    1     vlan 1    |
|    +---------------+---------------+
.         /                   \
 ----->wlan1                 lan0
       .                       .
       .                       ^
       ^                     vlan 1 tagged packets
     untagged packets

br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
filling in from brlan.1 towards wlan1. But it should be set to
DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
is not correct. The dsa switchdev adds it as a foreign port.

The same problem for all foreignly added dsa vlans on the bridge.

First add the vlan, trying only native devices.
If this fails, we know this may be a vlan from a foreign device.

Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG_HW
is set only when there if no foreign device involved.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

This patch has started in v2 of my original patch-set. It remains
unchanged from v4, always moving along in a patch-set. The Acked-by
from Nikolay Aleksandrov was added in v5.

Changes in v12:
 - Moved to net-next.git
 - Split from [PATCH v11 nf-next] netfilter: fastpath fixes

Changes in v10:
- Moved to nf-next.git
- Split from patch-set: bridge-fastpath and related improvements v9

Changes in v9:
- Moved from net-next.git to nf.git

Changes in v4:
- Added !CONFIG_NET_SWITCHDEV version of
   br_switchdev_port_vlan_no_foreign_add().

 include/net/switchdev.h   |  1 +
 net/bridge/br_private.h   | 10 ++++++++++
 net/bridge/br_switchdev.c | 15 +++++++++++++++
 net/bridge/br_vlan.c      |  7 ++++++-
 net/switchdev/switchdev.c |  2 +-
 5 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 8346b0d29542..ee500706496b 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -15,6 +15,7 @@
 #define SWITCHDEV_F_NO_RECURSE		BIT(0)
 #define SWITCHDEV_F_SKIP_EOPNOTSUPP	BIT(1)
 #define SWITCHDEV_F_DEFER		BIT(2)
+#define SWITCHDEV_F_NO_FOREIGN		BIT(3)
 
 enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b9b2981c4841..5a6f7d8fca1f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -182,6 +182,7 @@ enum {
 	BR_VLFLAG_MCAST_ENABLED = BIT(2),
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
+	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
 };
 
 /**
@@ -2224,6 +2225,8 @@ void br_switchdev_mdb_notify(struct net_device *dev,
 			     int type);
 int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 			       bool changed, struct netlink_ext_ack *extack);
+int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid, u16 flags,
+					  bool changed, struct netlink_ext_ack *extack);
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid);
 void br_switchdev_init(struct net_bridge *br);
 
@@ -2307,6 +2310,13 @@ static inline int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid,
 	return -EOPNOTSUPP;
 }
 
+static inline int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid,
+							u16 flags, bool changed,
+							struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 {
 	return -EOPNOTSUPP;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index fe3f7bbe86ee..556ed24700db 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -190,6 +190,21 @@ int br_switchdev_port_vlan_add(struct net_device *dev, u16 vid, u16 flags,
 	return switchdev_port_obj_add(dev, &v.obj, extack);
 }
 
+int br_switchdev_port_vlan_no_foreign_add(struct net_device *dev, u16 vid, u16 flags,
+					  bool changed, struct netlink_ext_ack *extack)
+{
+	struct switchdev_obj_port_vlan v = {
+		.obj.orig_dev = dev,
+		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
+		.obj.flags = SWITCHDEV_F_NO_FOREIGN,
+		.flags = flags,
+		.vid = vid,
+		.changed = changed,
+	};
+
+	return switchdev_port_obj_add(dev, &v.obj, extack);
+}
+
 int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
 {
 	struct switchdev_obj_port_vlan v = {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index ce72b837ff8e..636c86fa1183 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -109,6 +109,11 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
 	/* Try switchdev op first. In case it is not supported, fallback to
 	 * 8021q add.
 	 */
+	err = br_switchdev_port_vlan_no_foreign_add(dev, v->vid, flags, false, extack);
+	if (err != -EOPNOTSUPP) {
+		v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV | BR_VLFLAG_TAGGING_BY_SWITCHDEV;
+		return err;
+	}
 	err = br_switchdev_port_vlan_add(dev, v->vid, flags, false, extack);
 	if (err == -EOPNOTSUPP)
 		return vlan_vid_add(dev, br->vlan_proto, v->vid);
@@ -1491,7 +1496,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
+	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
 	else
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 4d5fbacef496..bf252d116ed3 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -760,7 +760,7 @@ static int __switchdev_handle_port_obj_add(struct net_device *dev,
 	/* Event is neither on a bridge nor a LAG. Check whether it is on an
 	 * interface that is in a bridge with us.
 	 */
-	if (!foreign_dev_check_cb)
+	if (!foreign_dev_check_cb || port_obj_info->obj->flags & SWITCHDEV_F_NO_FOREIGN)
 		return err;
 
 	br = netdev_master_upper_dev_get(dev);
-- 
2.53.0


