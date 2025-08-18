Return-Path: <netdev+bounces-214711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B8B2AFCB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCED5E04D6
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9032D24BB;
	Mon, 18 Aug 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="cfQpecLv"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C82D248E;
	Mon, 18 Aug 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539655; cv=none; b=SJy4MMV+Jy1xljCWsbYVVXv78ZcoyOxewNoLLvnEI5EjzovJYTOG6rHkYmzjKO00arsvKEryZQy8zdDfFFHYtsTMRixz0bs0ZGNxvMBd0hncb7eiFKio4JF7Fwv/zuUmxqqtCJFcga6wXqIZvE5G3dQo7a1TccN0+S8wnmBqDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539655; c=relaxed/simple;
	bh=qXYdtRYjNlssAFFfOdpPkanzTwuDOzu9i4HXcHU5CpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ignb2PHWIoZ795OvwBbavbBxwqyNbK0ksHnOYXj0USOeb/nryaph1SHvLxE1qps5+TPTBgINPbPBym/Zu6msaedFmcZro0BeL72kBMkqH7gq21jT0hHNSFmIefQbc3zIgGNjDMqmRXBT2ne32eaZWUCqNPzikPdxdpgWtIwerjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=cfQpecLv; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=23437; q=dns/txt;
  s=iport01; t=1755539652; x=1756749252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GsJFe9l4mJ1ku8HUfjAwiJaRDh4ufCaFfjG1MdG23Og=;
  b=cfQpecLviGTeZWSLEJAB6Mk7PileAMhfrcu9Wys3YbR8x/FpzgxvtO+k
   bEDAULgvnGqTlsB36hGY9WiawMKozxGSZP/M5W+Nprq916bYa8p4qiYGP
   1hdJVLNieqwYGsdqVOJiv2435MzFd8fel3d84+la4MSUMIBS4A6PsweQL
   NPq0ZRLZe+Lg/yOJlkNI7XSypVgom8igZqcOx+WMClnbvkUIR3BIHo/rm
   RuOrphXG+q4kRNWRteDVSWWVt/GfDdqRULQXNQs+M8WMddB52errvg2lg
   VHcoCUGwEWZeSdFKW6CUUhF4XsuPuARl0nlhLiqhDuJ0/426VNL71taRl
   Q==;
X-CSE-ConnectionGUID: f46AFm5KQJKDZNbjCJj6FQ==
X-CSE-MsgGUID: K1tr/gF9QNafAzQVKDWxUw==
X-IPAS-Result: =?us-ascii?q?A0ADAACJZ6No/4//Ja1SCBkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBgX8EAQEBAQELAYIXL3pZQ0kEjGyJVYMBiGaFZoxQg?=
 =?us-ascii?q?X8PAQEBD0QNBAEBghOCdIwmAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZPDYZdHg0LAToMgT4SgipYAYI6AzUDEbEmgXkzgQHeO?=
 =?us-ascii?q?IFnBoFJAY1MhWcnG4FJRIEVgTuCLYIfQgSBN4ZrBIIigQIUiDaCaIUcJYJpI?=
 =?us-ascii?q?oZcSIEeA1ksAVUTDQoLBwWBYwMqCwwLEhwVbjIdgSeFFoQnK0+FDoRtJGsPB?=
 =?us-ascii?q?oEVg2UGggNAAwsYDUgRLDcUGwY+bgeTToI5awYBLWIrFz0MGwiBAQ87LJJnA?=
 =?us-ascii?q?gEHslJxhCaMHo8+hXsaM4QEpmYBmQYigjaLMIQJkVkVWYRpgWg8gVkzGggbF?=
 =?us-ascii?q?YMiEz8ZD44tFohxrQ5GMgIBOQIHCwEBAwmTZwEB?=
IronPort-Data: A9a23:sLELnqKFyJVz9brjFE+RzZQlxSXFcZb7ZxGr2PjKsXjdYENS1zIHz
 WoXD2GPb/eCYjemeYpxaIzg9hkDv8CAzdI3HlYd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCWa/073WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrS0
 T/Oi5eHYgL9i2ckajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1gUB8fE4hF2d9VIk180
 /YaAxIPMD660rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBU7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2ME+ojx5nYj/7DLo7huiogWL/WzZZs1mS46Ew5gA/ySQsi+Swb4KOI43iqcN9vR+Ev
 CXJ0TXAJBgUHc6m9xmpzWKRmbqa9c/8cMdIfFGizdZvmlyVw2sCPxI+VVynpPC4jgi1XNc3A
 0YO+yYhoIA29Ve3VZ/5XhulsDuKuQMaV9NMEuo8rgaXxcL85wefG3hBTTNbbtEinNE5SCZs1
 VKTmd7tQzt1v9W9T3+B+rqKhS29NDJTLmIYYyIACwwf7LHeTJoblBnDSJNnVaWylNCwQW+2y
 DGRpy94jLIW5SIW65iGEZn8q2rEjvD0osQdv207gkrNAttFWbOY
IronPort-HdrOrdr: A9a23:MdLNcatWY2jmBZ1QVtO+FPQz7skDRdV00zEX/kB9WHVpmwKj+/
 xG+85rtyMc5wx+ZJhNo7q90cq7MBDhHPxOgLX5VI3KNGLbUQCTQ72Kg7GO/xTQXwXj6+9Q0r
 pheaBiBNC1MUJ3lq/BkWyF+q4boOVuNMuT9IDjJ7AHd3APV51d
X-Talos-CUID: 9a23:TuR3wWOCm0m/C+5DVnU53WARR+McUF7x/lHaIWSaCzhHcejA
X-Talos-MUID: 9a23:4RXMTAZfcU+ZG+BTlGbwnnZtGpZRxa2gIVI0r7YqhNm5Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,300,1747699200"; 
   d="scan'208";a="534570319"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Aug 2025 17:53:03 +0000
Received: from mrghosh-ub.cisco.com (unknown [10.26.161.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mrghosh@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id 9017F18000278;
	Mon, 18 Aug 2025 17:53:02 +0000 (GMT)
From: Mrinmoy Ghosh <mrghosh@cisco.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org,
	Mrinmoy Ghosh <mrghosh@cisco.com>,
	Mrinmoy Ghosh <mrinmoy_g@hotmail.com>,
	Patrice Brissette <pbrisset@cisco.com>
Subject: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb
Date: Mon, 18 Aug 2025 17:52:58 +0000
Message-ID: <20250818175258.275997-1-mrghosh@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: mrghosh@cisco.com
X-Outbound-SMTP-Client: 10.26.161.178, [10.26.161.178]
X-Outbound-Node: rcdn-l-core-06.cisco.com

This is to add optional "protocol" field for bridge fdb entries.
The introduction of the 'protocol' field in the bridge FDB for EVPN Multihome, addresses the need to distinguish between MAC addresses learned via the control plane and those learned via the data plane with data plane aging. Specifically:
* A MAC address in an EVPN Multihome environment can be learned either through the control plane (static MAC) or the data plane (dynamic MAC with aging).
* The 'protocol' field uses values such as 'HW' for data plane dynamic MACs and 'ZEBRA' for control plane static MACs.
* This distinction allows the application to manage the MAC address state machine effectively during transitions, which can occur due to traffic hashing between EVPN Multihome peers or mobility of MAC addresses across EVPN peers.
* By identifying the source of the MAC learning (control plane vs. data plane), the system can handle MAC aging and mobility more accurately, ensuring synchronization between control and data planes and improving stability and reliability in MAC route handling.

This mechanism supports the complex state transitions and synchronization required in EVPN Multihome scenarios, where MAC addresses may move or be learned differently depending on network events and traffic patterns.

Change Summary:
vxlan_core.c:  Encode NDA_PROTOCOL, and create and update fdb protocol field
               Use RTPROT_UNSPEC when protocol not specified (default)
vxlan_private.h: protocol field in vxlan_fdb, function signature updates
vxlan_vnifilter.c: Use default RTPROT_UNSPEC, for default fdb create
br.c: Use default RTPROT_UNSPEC as protocol, for swdev event
br_fdb.c: Set NDA_PROTOCOL from protocol for fdb fill.
          bridge fdb add, delete, learn update of protocol field
br_private.h: protocol field in net_bridge_fdb_entry

e.g:
Test along with iproute2 change i.e https://lore.kernel.org/netdev/20250816031145.1153429-1-mrghosh@cisco.com/T/#u

$ bridge fdb add 00:00:00:00:00:88 dev hostbond2 vlan 1000 master dynamic extern_learn proto hw

$ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto hw

$ bridge -d -j -p fdb show dev hostbond2

...

[ {
        "mac": "00:00:00:00:00:88",
        "vlan": 1000,
        "flags": [ "extern_learn" ],
        "master": "br1000",
        "flags_ext": [ ],
        "protocol": "hw",
        "state": ""
    },{
...

Transition to Zebra:
$ bridge fdb replace  00:00:00:00:00:88 dev hostbond2 vlan 1000 master dynamic extern_learn proto zebra

$ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto zebra

$ bridge -d -j -p fdb show dev hostbond2 ...
[ {
        "mac": "00:00:00:00:00:88",
        "vlan": 1000,
        "flags": [ "extern_learn" ],
        "master": "br1000",
        "flags_ext": [ ],
        "protocol": "zebra",
        "state": ""
    },
...

iproute2 review: https://lore.kernel.org/netdev/20250816031145.1153429-1-mrghosh@cisco.com/T/#u

Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
---
 drivers/net/vxlan/vxlan_core.c      | 132 ++++++++++++++--------------
 drivers/net/vxlan/vxlan_private.h   |  21 +++--
 drivers/net/vxlan/vxlan_vnifilter.c |  11 +--
 net/bridge/br.c                     |   4 +-
 net/bridge/br_fdb.c                 |  52 ++++++++---
 net/bridge/br_private.h             |   5 +-
 6 files changed, 127 insertions(+), 98 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f32be2e301f2..eff342e467a6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -206,6 +206,8 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			peernet2id(dev_net(vxlan->dev), vxlan->net)))
 		goto nla_put_failure;
 
+	if (nla_put_u8(skb, NDA_PROTOCOL, fdb->protocol))
+		goto nla_put_failure;
 	if (send_eth && nla_put(skb, NDA_LLADDR, ETH_ALEN, &fdb->key.eth_addr))
 		goto nla_put_failure;
 	if (nh) {
@@ -852,12 +854,11 @@ static int vxlan_fdb_nh_update(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 	return err;
 }
 
-int vxlan_fdb_create(struct vxlan_dev *vxlan,
-		     const u8 *mac, union vxlan_addr *ip,
-		     __u16 state, __be16 port, __be32 src_vni,
-		     __be32 vni, __u32 ifindex, __u16 ndm_flags,
+int vxlan_fdb_create(struct vxlan_dev *vxlan, const u8 *mac,
+		     union vxlan_addr *ip, __u16 state, __be16 port,
+		     __be32 src_vni, __be32 vni, __u32 ifindex, __u16 ndm_flags,
 		     u32 nhid, struct vxlan_fdb **fdb,
-		     struct netlink_ext_ack *extack)
+		     struct netlink_ext_ack *extack, u8 protocol)
 {
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
@@ -872,6 +873,7 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 	if (!f)
 		return -ENOMEM;
 
+	f->protocol = protocol;
 	if (nhid)
 		rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
 	else
@@ -964,14 +966,12 @@ static void vxlan_dst_free(struct rcu_head *head)
 	kfree(rd);
 }
 
-static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
-				     union vxlan_addr *ip,
-				     __u16 state, __u16 flags,
-				     __be16 port, __be32 vni,
-				     __u32 ifindex, __u16 ndm_flags,
-				     struct vxlan_fdb *f, u32 nhid,
-				     bool swdev_notify,
-				     struct netlink_ext_ack *extack)
+static int
+vxlan_fdb_update_existing(struct vxlan_dev *vxlan, union vxlan_addr *ip,
+			  __u16 state, __u16 flags, __be16 port, __be32 vni,
+			  __u32 ifindex, __u16 ndm_flags, struct vxlan_fdb *f,
+			  u32 nhid, bool swdev_notify,
+			  struct netlink_ext_ack *extack, u8 protocol)
 {
 	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
 	struct vxlan_rdst *rd = NULL;
@@ -1005,6 +1005,11 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 			f->flags = fdb_flags;
 			notify = 1;
 		}
+		if (f->protocol != protocol) {
+			f->protocol = protocol;
+			f->updated = jiffies;
+			notify = 1;
+		}
 	}
 
 	if ((flags & NLM_F_REPLACE)) {
@@ -1063,13 +1068,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	return err;
 }
 
-static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
-				   const u8 *mac, union vxlan_addr *ip,
-				   __u16 state, __u16 flags,
-				   __be16 port, __be32 src_vni, __be32 vni,
-				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
-				   bool swdev_notify,
-				   struct netlink_ext_ack *extack)
+static int vxlan_fdb_update_create(struct vxlan_dev *vxlan, const u8 *mac,
+				   union vxlan_addr *ip, __u16 state,
+				   __u16 flags, __be16 port, __be32 src_vni,
+				   __be32 vni, __u32 ifindex, __u16 ndm_flags,
+				   u32 nhid, bool swdev_notify,
+				   struct netlink_ext_ack *extack, u8 protocol)
 {
 	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
 	struct vxlan_fdb *f;
@@ -1081,8 +1085,8 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 
 	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-	rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni,
-			      vni, ifindex, fdb_flags, nhid, &f, extack);
+	rc = vxlan_fdb_create(vxlan, mac, ip, state, port, src_vni, vni,
+			      ifindex, fdb_flags, nhid, &f, extack, protocol);
 	if (rc < 0)
 		return rc;
 
@@ -1099,13 +1103,11 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 }
 
 /* Add new entry to forwarding table -- assumes lock held */
-int vxlan_fdb_update(struct vxlan_dev *vxlan,
-		     const u8 *mac, union vxlan_addr *ip,
-		     __u16 state, __u16 flags,
-		     __be16 port, __be32 src_vni, __be32 vni,
-		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
-		     bool swdev_notify,
-		     struct netlink_ext_ack *extack)
+int vxlan_fdb_update(struct vxlan_dev *vxlan, const u8 *mac,
+		     union vxlan_addr *ip, __u16 state, __u16 flags,
+		     __be16 port, __be32 src_vni, __be32 vni, __u32 ifindex,
+		     __u16 ndm_flags, u32 nhid, bool swdev_notify,
+		     struct netlink_ext_ack *extack, u8 protocol)
 {
 	struct vxlan_fdb *f;
 
@@ -1119,7 +1121,8 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 
 		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
 						 vni, ifindex, ndm_flags, f,
-						 nhid, swdev_notify, extack);
+						 nhid, swdev_notify, extack,
+						 protocol);
 	} else {
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
@@ -1127,7 +1130,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
 					       port, src_vni, vni, ifindex,
 					       ndm_flags, nhid, swdev_notify,
-					       extack);
+					       extack, protocol);
 	}
 }
 
@@ -1142,7 +1145,7 @@ static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
 			   __be32 *vni, u32 *ifindex, u32 *nhid,
-			   struct netlink_ext_ack *extack)
+			   struct netlink_ext_ack *extack, u8 *protocol)
 {
 	struct net *net = dev_net(vxlan->dev);
 	int err;
@@ -1222,6 +1225,11 @@ static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
 
 	*nhid = nla_get_u32_default(tb[NDA_NH_ID], 0);
 
+	if (tb[NDA_PROTOCOL])
+		*protocol = nla_get_u8(tb[NDA_PROTOCOL]);
+	else
+		*protocol = RTPROT_UNSPEC;
+
 	return 0;
 }
 
@@ -1238,6 +1246,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	__be32 src_vni, vni;
 	u32 ifindex, nhid;
 	int err;
+	u8 protocol;
 
 	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
 		pr_info("RTM_NEWNEIGH with invalid state %#x\n",
@@ -1249,7 +1258,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EINVAL;
 
 	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
-			      &nhid, extack);
+			      &nhid, extack, &protocol);
 	if (err)
 		return err;
 
@@ -1257,10 +1266,10 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		return -EAFNOSUPPORT;
 
 	spin_lock_bh(&vxlan->hash_lock);
-	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
-			       port, src_vni, vni, ifindex,
-			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
-			       nhid, true, extack);
+	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags, port,
+			       src_vni, vni, ifindex,
+			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER, nhid,
+			       true, extack, protocol);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
@@ -1314,9 +1323,10 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	u32 ifindex, nhid;
 	__be16 port;
 	int err;
+	u8 protocol;
 
 	err = vxlan_fdb_parse(tb, vxlan, &ip, &port, &src_vni, &vni, &ifindex,
-			      &nhid, extack);
+			      &nhid, extack, &protocol);
 	if (err)
 		return err;
 
@@ -1470,13 +1480,12 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 
 		/* close off race between vxlan_flush and incoming packets */
 		if (netif_running(dev))
-			vxlan_fdb_update(vxlan, src_mac, src_ip,
-					 NUD_REACHABLE,
-					 NLM_F_EXCL|NLM_F_CREATE,
-					 vxlan->cfg.dst_port,
-					 vni,
-					 vxlan->default_dst.remote_vni,
-					 ifindex, NTF_SELF, 0, true, NULL);
+			vxlan_fdb_update(vxlan, src_mac, src_ip, NUD_REACHABLE,
+					 NLM_F_EXCL | NLM_F_CREATE,
+					 vxlan->cfg.dst_port, vni,
+					 vxlan->default_dst.remote_vni, ifindex,
+					 NTF_SELF, 0, true, NULL,
+					 RTPROT_UNSPEC);
 		spin_unlock(&vxlan->hash_lock);
 	}
 
@@ -3963,15 +3972,13 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&dst->remote_ip)) {
 		spin_lock_bh(&vxlan->hash_lock);
-		err = vxlan_fdb_update(vxlan, all_zeros_mac,
-				       &dst->remote_ip,
+		err = vxlan_fdb_update(vxlan, all_zeros_mac, &dst->remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_EXCL | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
-				       dst->remote_vni,
-				       dst->remote_vni,
-				       dst->remote_ifindex,
-				       NTF_SELF, 0, true, extack);
+				       vxlan->cfg.dst_port, dst->remote_vni,
+				       dst->remote_vni, dst->remote_ifindex,
+				       NTF_SELF, 0, true, extack,
+				       RTPROT_UNSPEC);
 		spin_unlock_bh(&vxlan->hash_lock);
 		if (err)
 			goto unlink;
@@ -4416,10 +4423,10 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       &conf.remote_ip,
 					       NUD_REACHABLE | NUD_PERMANENT,
 					       NLM_F_APPEND | NLM_F_CREATE,
-					       vxlan->cfg.dst_port,
-					       conf.vni, conf.vni,
-					       conf.remote_ifindex,
-					       NTF_SELF, 0, true, extack);
+					       vxlan->cfg.dst_port, conf.vni,
+					       conf.vni, conf.remote_ifindex,
+					       NTF_SELF, 0, true, extack,
+					       RTPROT_UNSPEC);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
 				netdev_adjacent_change_abort(dst->remote_dev,
@@ -4767,14 +4774,11 @@ vxlan_fdb_external_learn_add(struct net_device *dev,
 
 	spin_lock_bh(&vxlan->hash_lock);
 	err = vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
-			       NUD_REACHABLE,
-			       NLM_F_CREATE | NLM_F_REPLACE,
-			       fdb_info->remote_port,
-			       fdb_info->vni,
-			       fdb_info->remote_vni,
-			       fdb_info->remote_ifindex,
-			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
-			       0, false, extack);
+			       NUD_REACHABLE, NLM_F_CREATE | NLM_F_REPLACE,
+			       fdb_info->remote_port, fdb_info->vni,
+			       fdb_info->remote_vni, fdb_info->remote_ifindex,
+			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED, 0, false,
+			       extack, RTPROT_UNSPEC);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 6c625fb29c6c..19d1b93be279 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -39,6 +39,7 @@ struct vxlan_fdb {
 	struct vxlan_fdb_key key;
 	u16		  state;	/* see ndm_state */
 	u16		  flags;	/* see ndm_flags and below */
+	u8 protocol; /* protocol for FDB entry */
 	struct list_head  nh_list;
 	struct hlist_node fdb_node;
 	struct nexthop __rcu *nh;
@@ -180,24 +181,22 @@ vxlan_vnifilter_lookup(struct vxlan_dev *vxlan, __be32 vni)
 }
 
 /* vxlan_core.c */
-int vxlan_fdb_create(struct vxlan_dev *vxlan,
-		     const u8 *mac, union vxlan_addr *ip,
-		     __u16 state, __be16 port, __be32 src_vni,
-		     __be32 vni, __u32 ifindex, __u16 ndm_flags,
+int vxlan_fdb_create(struct vxlan_dev *vxlan, const u8 *mac,
+		     union vxlan_addr *ip, __u16 state, __be16 port,
+		     __be32 src_vni, __be32 vni, __u32 ifindex, __u16 ndm_flags,
 		     u32 nhid, struct vxlan_fdb **fdb,
-		     struct netlink_ext_ack *extack);
+		     struct netlink_ext_ack *extack, u8 protocol);
 int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 		       const unsigned char *addr, union vxlan_addr ip,
 		       __be16 port, __be32 src_vni, __be32 vni,
 		       u32 ifindex, bool swdev_notify);
 u32 eth_vni_hash(const unsigned char *addr, __be32 vni);
 u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni);
-int vxlan_fdb_update(struct vxlan_dev *vxlan,
-		     const u8 *mac, union vxlan_addr *ip,
-		     __u16 state, __u16 flags,
-		     __be16 port, __be32 src_vni, __be32 vni,
-		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
-		     bool swdev_notify, struct netlink_ext_ack *extack);
+int vxlan_fdb_update(struct vxlan_dev *vxlan, const u8 *mac,
+		     union vxlan_addr *ip, __u16 state, __u16 flags,
+		     __be16 port, __be32 src_vni, __be32 vni, __u32 ifindex,
+		     __u16 ndm_flags, u32 nhid, bool swdev_notify,
+		     struct netlink_ext_ack *extack, u8 protocol);
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc);
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index adc89e651e27..908b6b489ac8 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -482,15 +482,12 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 
 	spin_lock_bh(&vxlan->hash_lock);
 	if (remote_ip && !vxlan_addr_any(remote_ip)) {
-		err = vxlan_fdb_update(vxlan, all_zeros_mac,
-				       remote_ip,
+		err = vxlan_fdb_update(vxlan, all_zeros_mac, remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
 				       NLM_F_APPEND | NLM_F_CREATE,
-				       vxlan->cfg.dst_port,
-				       vni,
-				       vni,
-				       dst->remote_ifindex,
-				       NTF_SELF, 0, true, extack);
+				       vxlan->cfg.dst_port, vni, vni,
+				       dst->remote_ifindex, NTF_SELF, 0, true,
+				       extack, RTPROT_UNSPEC);
 		if (err) {
 			spin_unlock_bh(&vxlan->hash_lock);
 			return err;
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 1885d0c315f0..55f017e00247 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -173,8 +173,8 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = ptr;
 		err = br_fdb_external_learn_add(br, p, fdb_info->addr,
-						fdb_info->vid,
-						fdb_info->locked, false);
+						fdb_info->vid, fdb_info->locked,
+						false, RTPROT_UNSPEC);
 		if (err) {
 			err = notifier_from_errno(err);
 			break;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 902694c0ce64..e1b93e495db3 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -123,6 +123,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 		goto nla_put_failure;
 	if (nla_put_u32(skb, NDA_MASTER, br->dev->ifindex))
 		goto nla_put_failure;
+	if (nla_put_u8(skb, NDA_PROTOCOL, fdb->protocol))
+		goto nla_put_failure;
 	if (nla_put_u32(skb, NDA_FLAGS_EXT, ext_flags))
 		goto nla_put_failure;
 
@@ -1153,7 +1155,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			struct net_bridge_port *p, const unsigned char *addr,
 			u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[],
-			bool *notified, struct netlink_ext_ack *extack)
+			bool *notified, struct netlink_ext_ack *extack,
+			u8 protocol)
 {
 	int err = 0;
 
@@ -1177,7 +1180,8 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 					   "FDB entry towards bridge must be permanent");
 			return -EINVAL;
 		}
-		err = br_fdb_external_learn_add(br, p, addr, vid, false, true);
+		err = br_fdb_external_learn_add(br, p, addr, vid, false, true,
+						protocol);
 	} else {
 		spin_lock_bh(&br->hash_lock);
 		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
@@ -1206,6 +1210,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_bridge_vlan *v;
 	struct net_bridge *br = NULL;
 	u32 ext_flags = 0;
+	u8 protocol = RTPROT_UNSPEC;
 	int err = 0;
 
 	trace_br_fdb_add(ndm, dev, addr, vid, nlh_flags);
@@ -1237,6 +1242,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (tb[NDA_FLAGS_EXT])
 		ext_flags = nla_get_u32(tb[NDA_FLAGS_EXT]);
 
+	if (tb[NDA_PROTOCOL])
+		protocol = nla_get_u8(tb[NDA_PROTOCOL]);
+
 	if (ext_flags & NTF_EXT_LOCKED) {
 		NL_SET_ERR_MSG_MOD(extack, "Cannot add FDB entry with \"locked\" flag set");
 		return -EINVAL;
@@ -1261,10 +1269,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 
 		/* VID was specified, so use it. */
 		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfea_tb,
-				   notified, extack);
+				   notified, extack, protocol);
 	} else {
 		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_tb,
-				   notified, extack);
+				   notified, extack, protocol);
 		if (err || !vg || !vg->num_vlans)
 			goto out;
 
@@ -1276,7 +1284,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			if (!br_vlan_should_use(v))
 				continue;
 			err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v->vid,
-					   nfea_tb, notified, extack);
+					   nfea_tb, notified, extack, protocol);
 			if (err)
 				goto out;
 		}
@@ -1288,7 +1296,8 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 
 static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 				       const struct net_bridge_port *p,
-				       const u8 *addr, u16 vlan, bool *notified)
+				       const u8 *addr, u16 vlan, u8 protocol,
+				       bool *notified)
 {
 	struct net_bridge_fdb_entry *fdb;
 
@@ -1296,6 +1305,13 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 	if (!fdb || READ_ONCE(fdb->dst) != p)
 		return -ENOENT;
 
+	/* If the delete comes from a different protocol type,
+	* that type is used in the notification as some software
+	* may be expecting multiple deletes (control learned +
+	* hardware datapath learned) */
+	if (protocol != RTPROT_UNSPEC)
+		fdb->protocol = protocol;
+
 	fdb_delete(br, fdb, true);
 	*notified = true;
 
@@ -1304,12 +1320,13 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 
 static int __br_fdb_delete(struct net_bridge *br,
 			   const struct net_bridge_port *p,
-			   const unsigned char *addr, u16 vid, bool *notified)
+			   const unsigned char *addr, u16 vid, u8 protocol,
+			   bool *notified)
 {
 	int err;
 
 	spin_lock_bh(&br->hash_lock);
-	err = fdb_delete_by_addr_and_port(br, p, addr, vid, notified);
+	err = fdb_delete_by_addr_and_port(br, p, addr, vid, protocol, notified);
 	spin_unlock_bh(&br->hash_lock);
 
 	return err;
@@ -1324,8 +1341,12 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
 	struct net_bridge *br;
+	u8 protocol = RTPROT_UNSPEC;
 	int err;
 
+	if (tb[NDA_PROTOCOL])
+		protocol = nla_get_u8(tb[NDA_PROTOCOL]);
+
 	if (netif_is_bridge_master(dev)) {
 		br = netdev_priv(dev);
 		vg = br_vlan_group(br);
@@ -1341,19 +1362,20 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	}
 
 	if (vid) {
-		err = __br_fdb_delete(br, p, addr, vid, notified);
+		err = __br_fdb_delete(br, p, addr, vid, protocol, notified);
 	} else {
 		struct net_bridge_vlan *v;
 
 		err = -ENOENT;
-		err &= __br_fdb_delete(br, p, addr, 0, notified);
+		err &= __br_fdb_delete(br, p, addr, 0, protocol, notified);
 		if (!vg || !vg->num_vlans)
 			return err;
 
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			if (!br_vlan_should_use(v))
 				continue;
-			err &= __br_fdb_delete(br, p, addr, v->vid, notified);
+			err &= __br_fdb_delete(br, p, addr, v->vid, protocol,
+					       notified);
 		}
 	}
 
@@ -1414,7 +1436,7 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid, bool locked,
-			      bool swdev_notify)
+			      bool swdev_notify, u8 protocol)
 {
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
@@ -1445,6 +1467,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			err = -ENOMEM;
 			goto err_unlock;
 		}
+		fdb->protocol = protocol;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
 		if (locked &&
@@ -1483,6 +1506,11 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		    test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
 			atomic_dec(&br->fdb_n_learned);
 
+		if (fdb->protocol != protocol) {
+			modified = true;
+			fdb->protocol = protocol;
+		}
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b159aae594c0..dc14c3c102b2 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -291,6 +291,7 @@ struct net_bridge_fdb_entry {
 	struct net_bridge_fdb_key	key;
 	struct hlist_node		fdb_node;
 	unsigned long			flags;
+	u8 protocol;
 
 	/* write-heavy members should not affect lookups */
 	unsigned long			updated ____cacheline_aligned_in_smp;
@@ -870,8 +871,8 @@ int br_fdb_get(struct sk_buff *skb, struct nlattr *tb[], struct net_device *dev,
 int br_fdb_sync_static(struct net_bridge *br, struct net_bridge_port *p);
 void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p);
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
-			      const unsigned char *addr, u16 vid,
-			      bool locked, bool swdev_notify);
+			      const unsigned char *addr, u16 vid, bool locked,
+			      bool swdev_notify, u8 protocol);
 int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid,
 			      bool swdev_notify);
-- 
2.43.0


