Return-Path: <netdev+bounces-78454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D18875300
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F231F23E2F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8312EBEE;
	Thu,  7 Mar 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBfDtxNc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F512F581
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824747; cv=none; b=AhDkKMg0zOuYrJ3bKk6CZYn9sm0e1S2/712tRTQbbR0Np/6rJxGb+CtIW/kHHQJKyeHkR9kW6l6s8tGg55a6arj+9kzVCKbVxvZ6Er0PmaVBkXzZADTmwZNai/uk97tdBb6zFfXyHFXj4VbASeqm2bX/YiaEETPGa3EBS336q9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824747; c=relaxed/simple;
	bh=t9Gyy9Rx+cUKRqNooyQyKo1PrlA/EIfkWgt00/0lX1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpSFGwAKvmezk2Uf14WoFvnW5s1j7FmSo/Gy9t61X6SRVIUUHeSzukJaLxwFFbvyrYViVXiWzZgIJAj3dQMP2BZ1aAwFENM/kiQMueTGUpmMY1CFNDqFaUsp6xeIyIz5qD62Dc8MaEsuVAKcSEE160zWUijrW73f43jWh+gHrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBfDtxNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jmx+YaI5ayJ4tS4SNgOtRv03CU7/WTXqQ4vzYMtif0=;
	b=XBfDtxNcY0SabOoa7rY4Plx/A5rRiJkJDDYixQekCfo3AlDcjfxbzfmaaHHyToPtnXIBoc
	6/bZFFVtK6PRiILG2yOYHST0Tfj1cpCUa4+wS3he7AW4gQa/wvVsG0JwFRxk/iX7TD95sd
	9hSBSfo5gFMY50KWJXgsh28gI54fAck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-NueeuX66MhS-rXX-TYIB5Q-1; Thu, 07 Mar 2024 10:19:00 -0500
X-MC-Unique: NueeuX66MhS-rXX-TYIB5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC96B811E81;
	Thu,  7 Mar 2024 15:18:59 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72FF92166B33;
	Thu,  7 Mar 2024 15:18:58 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC PATCH 4/4] net:openvswitch: Add multicasted packets to stats
Date: Thu,  7 Mar 2024 16:18:48 +0100
Message-ID: <20240307151849.394962-5-amorenoz@redhat.com>
In-Reply-To: <20240307151849.394962-1-amorenoz@redhat.com>
References: <20240307151849.394962-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

If we mix multicasted and unicasted statistics, there could be a serious
discrepancy between the stats reported by the kernel and the ones read
by userspace, leading to increased confusion.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/openvswitch.h | 2 ++
 net/openvswitch/datapath.c       | 9 ++++++---
 net/openvswitch/vport.c          | 8 ++++++++
 net/openvswitch/vport.h          | 1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index 77525a1c648a..25e35b627fe5 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -288,10 +288,12 @@ enum ovs_vport_attr {
  * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands
  * @OVS_VPORT_UPCALL_SUCCESS: 64-bit upcall success packets.
  * @OVS_VPORT_UPCALL_FAIL: 64-bit upcall fail packets.
+ * @OVS_VPORT_UPCALL_MCAST: 64-bit multicasted upcall packets.
  */
 enum ovs_vport_upcall_attr {
 	OVS_VPORT_UPCALL_ATTR_SUCCESS,
 	OVS_VPORT_UPCALL_ATTR_FAIL,
+	OVS_VPORT_UPCALL_ATTR_MCAST,
 	__OVS_VPORT_UPCALL_ATTR_MAX
 };
 
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 5171aefa6a7c..a457a07adb52 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -217,7 +217,7 @@ static struct vport *new_vport(const struct vport_parms *parms)
 
 static void ovs_vport_update_upcall_stats(struct sk_buff *skb,
 					  const struct dp_upcall_info *upcall_info,
-					  bool upcall_result)
+					  bool mcast, bool upcall_result)
 {
 	struct vport *p = OVS_CB(skb)->input_vport;
 	struct vport_upcall_stats_percpu *stats;
@@ -229,7 +229,10 @@ static void ovs_vport_update_upcall_stats(struct sk_buff *skb,
 	stats = this_cpu_ptr(p->upcall_stats);
 	u64_stats_update_begin(&stats->syncp);
 	if (upcall_result)
-		u64_stats_inc(&stats->n_success);
+		if (mcast)
+			u64_stats_inc(&stats->n_mcast);
+		else
+			u64_stats_inc(&stats->n_success);
 	else
 		u64_stats_inc(&stats->n_fail);
 	u64_stats_update_end(&stats->syncp);
@@ -336,7 +339,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 	else
 		err = queue_gso_packets(dp, skb, key, upcall_info, cutlen);
 
-	ovs_vport_update_upcall_stats(skb, upcall_info, !err);
+	ovs_vport_update_upcall_stats(skb, upcall_info, mcast, !err);
 	if (err)
 		goto err;
 
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 972ae01a70f7..b78287e443d1 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -315,6 +315,7 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 
 	__u64 tx_success = 0;
 	__u64 tx_fail = 0;
+	__u64 mcast = 0;
 
 	for_each_possible_cpu(i) {
 		const struct vport_upcall_stats_percpu *stats;
@@ -325,6 +326,7 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 			start = u64_stats_fetch_begin(&stats->syncp);
 			tx_success += u64_stats_read(&stats->n_success);
 			tx_fail += u64_stats_read(&stats->n_fail);
+			mcast  += u64_stats_read(&stats->n_mcast);
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 	}
 
@@ -343,6 +345,12 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 		nla_nest_cancel(skb, nla);
 		return -EMSGSIZE;
 	}
+
+	if (nla_put_u64_64bit(skb, OVS_VPORT_UPCALL_ATTR_MCAST, mcast,
+			      OVS_VPORT_ATTR_PAD)) {
+		nla_nest_cancel(skb, nla);
+		return -EMSGSIZE;
+	}
 	nla_nest_end(skb, nla);
 
 	return 0;
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 3e71ca8ad8a7..e9817b2b3b61 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -151,6 +151,7 @@ struct vport_upcall_stats_percpu {
 	struct u64_stats_sync syncp;
 	u64_stats_t n_success;
 	u64_stats_t n_fail;
+	u64_stats_t n_mcast;
 };
 
 struct vport *ovs_vport_alloc(int priv_size, const struct vport_ops *,
-- 
2.44.0


