Return-Path: <netdev+bounces-199699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCAAE17CF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25E3188DAF2
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3F2836AF;
	Fri, 20 Jun 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kWcRjZX9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CEA283C83
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412343; cv=none; b=gPLxn1B6qwxKCYJdGvr1HjNcHAEdXHGcg7wVj7L8g0SL/umvDWGOV8DUYIWml38E5OoZdzadQy9fcZ5RTIm0otF26y7oSN5ndCAT5F9VsXrxnUvhlfpGqzbPbhkOhqG86O/jwsRkQ/a6W+KuyXZ8E/BhPDcicPiNFumvUwv01Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412343; c=relaxed/simple;
	bh=Tf6xbrt59za2mOs1WKg4U1LLbS722JDL294beKjWitE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwglEEFOpZSt2CJ/KsKGLlH8Lg9G7V6+fTx8Euy7t917e4/qwsURH8DPI6ZkrIj+dXaf5tgO72S+TDpEcyE0gD7dW8h/GHi/jCiU1JOWGNERgt/EckKtmDLL2IaKeZPMcLiDc2yo3fva39zKJSlnIgHZSPtiHzNJq7UfN0vxfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kWcRjZX9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3Tiu6015658;
	Fri, 20 Jun 2025 02:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=0TNg2fr3TAZ1xn7NSfvgGCW
	d4jKHrYaP9pvdFzZBVOo=; b=kWcRjZX9pXU6EeEFgdwiK00Kj+sYtkyFzIWJVVr
	E4tYKKcmVvDzekFAXg+86mWcJ7YqkfLVglaJQ1p/DxBCMBbGaabiI6sKcsB4bFd4
	JlwMaYQhxRy09o8eqrnUWkbs+qyJfd/sAbBePvzYQCCwpZaDltzdP6RuaetwYpXK
	cnHH1XwH7ir55N2v2SDUQNd8GLTv7qLveVF72/au31v9M8H5Xk4A5eObdGc2yN4L
	ACkhjsR6K2JgPcoM5bb2dyECL95uZsTNx248AFw2RKUlHCW8FPFpfPyBvwPcxFOU
	6Vq8wq+grV1hs+JFWCn/z9RmCGtm7zP8FhAmUbZ/41kJWMw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgmx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 02:38:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 02:38:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 02:38:30 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id C42F05B692E;
	Fri, 20 Jun 2025 02:38:26 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>, <antony@phenome.org>
Subject: [PATCH] xfrm: Duplicate SPI Handling
Date: Fri, 20 Jun 2025 15:08:23 +0530
Message-ID: <20250620093823.1111444-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=68552c17 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=TPNI6p8SSMKYmAjfnVIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA3MCBTYWx0ZWRfX8oJzN5z5rKLd 6F6MWMqfNco6by9kvMnpcNpqIgSos+Q8g6W4ou3yzBx1jHej8gcgOdK5GRImmFDcCKjwVn6ja2S zhzUpcCPr6lmwEDC7uUagQKM3qSdmftAd8fqelA77Xe0lHghxepor0Q/g+2YXbs9RgvaqRvsPzC
 EBUeYJnDnDSxqfCL5VHnX06GHQ80cEzE7p9fGWt+aiBA49BhShT+YodnIlfVQlzSknGOQdVw+cC SfZJ2OAV68m7wpCXucqpx6epfvyARlTUkLbX0fCsfSz3xPcmTFNTGWdNNIjNKMyZhEzy/joQ5Ff vkkpFeHR4n+aSufXl8I3HW9ESAFhjX8h2zn2p2SmEc/pIa8eemHTvzlGo21e9fIVZq4OtOMvh8A
 tswSHtJb9WlXMxHG6HKWQ5KoCNKwRQblW9pIK+FPNtcdKgBJ6sSFLFvTPINZPYXBwRsv5MML
X-Proofpoint-ORIG-GUID: eIOxxMdOxu1HMmWi_srkXumDnp5FxEn8
X-Proofpoint-GUID: eIOxxMdOxu1HMmWi_srkXumDnp5FxEn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01

The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
Netlink message, which triggers the kernel function xfrm_alloc_spi().
This function is expected to ensure uniqueness of the Security Parameter
Index (SPI) for inbound Security Associations (SAs). However, it can
return success even when the requested SPI is already in use, leading
to duplicate SPIs assigned to multiple inbound SAs, differentiated
only by their destination addresses.

This behavior causes inconsistencies during SPI lookups for inbound packets.
Since the lookup may return an arbitrary SA among those with the same SPI,
packet processing can fail, resulting in packet drops.

According to RFC 4301 section 4.4.2 , for inbound processing a unicast SA
is uniquely identified by the SPI and optionally protocol.

Reproducing the Issue Reliably:
To consistently reproduce the problem, restrict the available SPI range in
charon.conf : spi_min = 0x10000000 spi_max = 0x10000002
This limits the system to only 2 usable SPI values.
Next, create more than 2 Child SA. each using unique pair of src/dst address.
As soon as the 3rd Child SA is initiated, it will be assigned a duplicate
SPI, since the SPI pool is already exhausted.
With a narrow SPI range, the issue is consistently reproducible.
With a broader/default range, it becomes rare and unpredictable.

Current implementation:
xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
So if two SAs have the same SPI but different destination addresses, then
they will:
a. Hash into different buckets
b. Be stored in different linked lists (byspi + h)
c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
As a result, the lookup will result in NULL and kernel allows that Duplicate SPI

Proposed Change:
xfrm_state_lookup_spi_proto() does a truly global search - across all states,
regardless of hash bucket and matches SPI and proto.

Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
---
 include/net/xfrm.h    |  3 +++
 net/xfrm/xfrm_state.c | 38 ++++++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 39365fd2ea17..bd128980e8fd 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1693,6 +1693,9 @@ struct xfrm_state *xfrm_stateonly_find(struct net *net, u32 mark, u32 if_id,
 				       u8 mode, u8 proto, u32 reqid);
 struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 					      unsigned short family);
+struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi,
+						u8 proto);
+
 int xfrm_state_check_expire(struct xfrm_state *x);
 void xfrm_state_update_stats(struct net *net);
 #ifdef CONFIG_XFRM_OFFLOAD
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..fb05f47898fe 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1714,6 +1714,28 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byspi);
 
+struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
+{
+    struct xfrm_state *x;
+    unsigned int i;
+
+    rcu_read_lock();
+
+    for (i = 0; i <= net->xfrm.state_hmask; i++) {
+        hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
+            if (x->id.spi == spi && x->id.proto == proto) {
+                if (!xfrm_state_hold_rcu(x))
+                    continue;
+                rcu_read_unlock();
+                return x;
+            }
+        }
+    }
+
+    rcu_read_unlock();
+    return NULL;
+}
+
 static void __xfrm_state_insert(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -2550,7 +2572,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	__be32 minspi = htonl(low);
 	__be32 maxspi = htonl(high);
 	__be32 newspi = 0;
-	u32 mark = x->mark.v & x->mark.m;
 
 	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_DEAD) {
@@ -2565,18 +2586,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	err = -ENOENT;
 
 	if (minspi == maxspi) {
-		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
-		if (x0) {
-			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
-			xfrm_state_put(x0);
-			goto unlock;
-		}
 		newspi = minspi;
 	} else {
 		u32 spi = 0;
 		for (h = 0; h < high-low+1; h++) {
 			spi = get_random_u32_inclusive(low, high);
-			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
+			x0 = xfrm_state_lookup_spi_proto(net, htonl(spi), x->id.proto);
 			if (x0 == NULL) {
 				newspi = htonl(spi);
 				break;
@@ -2586,6 +2601,13 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	}
 	if (newspi) {
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
+		if (x0) {
+			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
+			xfrm_state_put(x0);
+			goto unlock;
+		}
+
 		x->id.spi = newspi;
 		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
 		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
-- 
2.43.0


