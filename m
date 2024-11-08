Return-Path: <netdev+bounces-143159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5AC9C148F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BA71F20226
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B201865E0;
	Fri,  8 Nov 2024 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="GGpqly9N"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509447E76D
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036287; cv=none; b=mF1Z3Y9zkrH/jk4RpxBBvv7MzfPEWFfpflbKCGygumAv4DaswbOUnfnlWjs12CX/vH6/QDku1DOowSoTEKJFCscX9KyZfwHT+O9dL1g6l9pScNgMnsy6zej9OO+LTlN6ipimwu8eLp48cP9qmkiQInYkF/DUejhUVkXNoZZN63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036287; c=relaxed/simple;
	bh=rbqdFotREDfEBhyAZgmy6TN4n/PMKHOQvslonALnvfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz4RZVwxGK2op1w4duW94h8z7WU+cL4G9lqRryLKKuu212My4Tesz/4574O/OfgNICV1hC/IoB2znUem2Sj84gt49MnUMWlM04ezV3HmRet/aNwbjG7hAEvtF9j31gT99h9YOzSJzJ7a0UIUU4hIZEN4AMocOXPZ2Md/qsmfpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=GGpqly9N; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BF1F62C0540;
	Fri,  8 Nov 2024 16:24:37 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731036277;
	bh=6cWa61liB2w2TV338VOIAV95E585BXObvb8p5aUjLG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGpqly9NjeBSo4XN6NmOIyWPHcuYOQdvZHkaQB2unPElK0fMZgzT09Af9f6ApmNC6
	 r5xrWL6AHfujnz5MMaXjJ1RM3+478e2vdd7heDtvzLmofwzfRbHoQMSU0eaC8ARhqh
	 88p29tJnFu8B0bKStC6xQNVf/D0ugN2sU759koeuHinf/tk7lh4wWgaWnVMjz9mB4H
	 KlvcoZOiEOa0pMw5myYexY55mCIiwFCzkz8goHGhar3isTaILxcHLwUQB4FRI6AclE
	 J2Cp8dbZ5MbLOhW1n9/GdOIRU2xOCg+8+9zGX+LSAI16rXoJWTCLDqzYzBtWpVCx04
	 +6TQMjVGhFJug==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672d84750000>; Fri, 08 Nov 2024 16:24:37 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 90FC913ECD2;
	Fri,  8 Nov 2024 16:24:37 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 8F1C13C0261; Fri,  8 Nov 2024 16:24:37 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [RFC net-next 2/4] net: bridge: send notification for roaming hosts
Date: Fri,  8 Nov 2024 16:24:19 +1300
Message-ID: <20241108032422.2011802-3-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672d8475 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=LYxsSh6Jf1NNSQcWqj0A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

When an fdb entry is configured as static and sticky it should never
roam. However there are times where it would be useful to know when
this happens so a user application can act on it. For this reason,
extend the fdb notification mechanism to send a notification when the
bridge detects a host that is attempting to roam when it has been
configured not to.

This is achieved by temporarily updating the fdb entry with the new
port, setting a new notify roaming bit, firing off a notification, and
restoring the original port immediately afterwards. The port remains
unchanged, respecting the sticky flag, but userspace is now notified
of the new port the host was seen on.

The roaming bit is cleared if the entry becomes inactive or if it is
replaced by a user entry.

Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 include/uapi/linux/neighbour.h |  4 ++-
 net/bridge/br_fdb.c            | 64 +++++++++++++++++++++++-----------
 net/bridge/br_input.c          | 10 ++++--
 net/bridge/br_private.h        |  3 ++
 4 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbou=
r.h
index 5e67a7eaf4a7..e1c686268808 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -201,10 +201,12 @@ enum {
  /* FDB activity notification bits used in NFEA_ACTIVITY_NOTIFY:
   * - FDB_NOTIFY_BIT - notify on activity/expire for any entry
   * - FDB_NOTIFY_INACTIVE_BIT - mark as inactive to avoid multiple notif=
ications
+  * - FDB_NOTIFY_ROAMING_BIT - mark as attempting to roam
   */
 enum {
 	FDB_NOTIFY_BIT		=3D (1 << 0),
-	FDB_NOTIFY_INACTIVE_BIT	=3D (1 << 1)
+	FDB_NOTIFY_INACTIVE_BIT	=3D (1 << 1),
+	FDB_NOTIFY_ROAMING_BIT	=3D (1 << 2)
 };
=20
 /* embedded into NDA_FDB_EXT_ATTRS:
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index d0eeedc03390..a8b841e74e15 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -145,6 +145,8 @@ static int fdb_fill_info(struct sk_buff *skb, const s=
truct net_bridge *br,
 			goto nla_put_failure;
 		if (test_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags))
 			notify_bits |=3D FDB_NOTIFY_INACTIVE_BIT;
+		if (test_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags))
+			notify_bits |=3D FDB_NOTIFY_ROAMING_BIT;
=20
 		if (nla_put_u8(skb, NFEA_ACTIVITY_NOTIFY, notify_bits)) {
 			nla_nest_cancel(skb, nest);
@@ -554,8 +556,10 @@ void br_fdb_cleanup(struct work_struct *work)
 					work_delay =3D min(work_delay,
 							 this_timer - now);
 				else if (!test_and_set_bit(BR_FDB_NOTIFY_INACTIVE,
-							   &f->flags))
+							   &f->flags)) {
+					clear_bit(BR_FDB_NOTIFY_ROAMING, &f->flags);
 					fdb_notify(br, f, RTM_NEWNEIGH, false);
+				}
 			}
 			continue;
 		}
@@ -880,6 +884,19 @@ static bool __fdb_mark_active(struct net_bridge_fdb_=
entry *fdb)
 		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
 }
=20
+void br_fdb_notify_roaming(struct net_bridge *br, struct net_bridge_port=
 *p,
+			   struct net_bridge_fdb_entry *fdb)
+{
+	struct net_bridge_port *old_p =3D READ_ONCE(fdb->dst);
+
+	if (test_bit(BR_FDB_NOTIFY, &fdb->flags) &&
+	    !test_and_set_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags)) {
+		WRITE_ONCE(fdb->dst, p);
+		fdb_notify(br, fdb, RTM_NEWNEIGH, false);
+		WRITE_ONCE(fdb->dst, old_p);
+	}
+}
+
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source=
,
 		   const unsigned char *addr, u16 vid, unsigned long flags)
 {
@@ -906,21 +923,24 @@ void br_fdb_update(struct net_bridge *br, struct ne=
t_bridge_port *source,
 			}
=20
 			/* fastpath: update of existing entry */
-			if (unlikely(source !=3D READ_ONCE(fdb->dst) &&
-				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
-				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
-				WRITE_ONCE(fdb->dst, source);
-				fdb_modified =3D true;
-				/* Take over HW learned entry */
-				if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
-						      &fdb->flags)))
-					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
-						  &fdb->flags);
-				/* Clear locked flag when roaming to an
-				 * unlocked port.
-				 */
-				if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
-					clear_bit(BR_FDB_LOCKED, &fdb->flags);
+			if (unlikely(source !=3D READ_ONCE(fdb->dst))) {
+				if (unlikely(test_bit(BR_FDB_STICKY, &fdb->flags))) {
+					br_fdb_notify_roaming(br, source, fdb);
+				} else {
+					br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+					WRITE_ONCE(fdb->dst, source);
+					fdb_modified =3D true;
+					/* Take over HW learned entry */
+					if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+							      &fdb->flags)))
+						clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
+							  &fdb->flags);
+					/* Clear locked flag when roaming to an
+					 * unlocked port.
+					 */
+					if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
+						clear_bit(BR_FDB_LOCKED, &fdb->flags);
+				}
 			}
=20
 			if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
@@ -1045,6 +1065,7 @@ static bool fdb_handle_notify(struct net_bridge_fdb=
_entry *fdb, u8 notify)
 		   test_and_clear_bit(BR_FDB_NOTIFY, &fdb->flags)) {
 		/* disabled activity tracking, clear notify state */
 		clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags);
+		clear_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags);
 		modified =3D true;
 	}
=20
@@ -1457,10 +1478,13 @@ int br_fdb_external_learn_add(struct net_bridge *=
br, struct net_bridge_port *p,
=20
 		fdb->updated =3D jiffies;
=20
-		if (READ_ONCE(fdb->dst) !=3D p &&
-		    !test_bit(BR_FDB_STICK, &fdb->flags)) {
-			WRITE_ONCE(fdb->dst, p);
-			modified =3D true;
+		if (READ_ONCE(fdb->dst) !=3D p) {
+			if (test_bit(BR_FDB_STICKY, &fdb->flags)) {
+				br_fdb_notify_roaming(br, p, fdb);
+			} else {
+				WRITE_ONCE(fdb->dst, p);
+				modified =3D true;
+			}
 		}
=20
 		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..512ffab16f5d 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -120,8 +120,14 @@ int br_handle_frame_finish(struct net *net, struct s=
ock *sk, struct sk_buff *skb
 				br_fdb_update(br, p, eth_hdr(skb)->h_source,
 					      vid, BIT(BR_FDB_LOCKED));
 			goto drop;
-		} else if (READ_ONCE(fdb_src->dst) !=3D p ||
-			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
+		} else if (READ_ONCE(fdb_src->dst) !=3D p) {
+			/* FDB is trying to roam. Notify userspace and drop
+			 * the packet
+			 */
+			if (test_bit(BR_FDB_STICKY, &fdb_src->flags))
+				br_fdb_notify_roaming(br, p, fdb_src);
+			goto drop;
+		} else if (test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
 			/* FDB mismatch. Drop the packet without roaming. */
 			goto drop;
 		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 041f6e571a20..18d3cb5fec0e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -277,6 +277,7 @@ enum {
 	BR_FDB_NOTIFY_INACTIVE,
 	BR_FDB_LOCKED,
 	BR_FDB_DYNAMIC_LEARNED,
+	BR_FDB_NOTIFY_ROAMING,
 };
=20
 struct net_bridge_fdb_key {
@@ -874,6 +875,8 @@ int br_fdb_external_learn_del(struct net_bridge *br, =
struct net_bridge_port *p,
 			      bool swdev_notify);
 void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port =
*p,
 			  const unsigned char *addr, u16 vid, bool offloaded);
+void br_fdb_notify_roaming(struct net_bridge *br, struct net_bridge_port=
 *p,
+			   struct net_bridge_fdb_entry *fdb);
=20
 /* br_forward.c */
 enum br_pkt_type {

