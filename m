Return-Path: <netdev+bounces-200572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B156FAE6200
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742A2402EA5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D79283C8C;
	Tue, 24 Jun 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DOzg3GiE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F7281509
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760156; cv=none; b=E+X3bYheeruR/HAWyD57jJUj65ZT0fQ1lTnn7WQpJCKo4ePVKKvH5W6V8nYS43cIpT/BqOxsIc6/R2K5bzkTtqlHVqlScVikLOi8Ez7oP+FTox19hPxLOpUeZZQf+BiYGzQuIuDHy5ONYzGIwygTrtbjdi0EkVk4soy4mdYAMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760156; c=relaxed/simple;
	bh=gFxarwu0PDR3HDKcnSvhfRBs/bBdKM1YGi6F57MVE3M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2lBHu3sZSaB2vX3V+GLLs3BGf8mrSkCHmgO1FiWVULefZYEnYPBx65BBtqGEZzdoqp02HnCA7UCV3Ew6MvyL23gO+NpzDiztIQ/gIvfd+C8z9p8GZdO9ovuK4le4CSnQ1dHxL0W6xuvZMDyKZqx8i1JScFb6aNuS/I0d6qcvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DOzg3GiE; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5BaLB031388;
	Tue, 24 Jun 2025 03:15:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ZMgjaewWj6Qqx9E4P6SHVOS
	Bk/M/VM8W9psrSZAapqk=; b=DOzg3GiENVcSuO6xxZ0H3as2rnk4G8/tN8AlOaZ
	IIRWvLthhZkQTXohQzu9jJi10KS3kNpTAo1Un73iwdULgH7BzAuCf+eD7Jdi4NPS
	B/1GzrnpFanuihEbOAhdA5WKG4zmUWZvUHF6CrVT2s6uCT5r18Yu1o0WkE4XexnB
	Uoq2yoLJjCcqDUNnRoT68562HbGyrpvttc7UHrH0r/HYv3vjSJDbLJ39nVaA5Qm/
	ssruTJr83jtFklRjvdzrU/WcWF5/rTfNUrBvSdNwyHIMONU1s90eTWnhusqqDp7l
	LJr8j6+8KkmwwxUksjkvKkaTdBj4SPpvoNsTL/zUrDolCPg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47fnnbrkje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 03:15:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 03:15:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 03:15:23 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id E35855B6949;
	Tue, 24 Jun 2025 03:15:19 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>, <antony@phenome.org>
Subject: [PATCH] xfrm: Duplicate SPI Handling
Date: Tue, 24 Jun 2025 15:45:16 +0530
Message-ID: <20250624101516.1468701-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA4NyBTYWx0ZWRfX3A820xMBjtka kJlS3qNU+YHORVGqZ/FwsH8CEpNzaNwWKz9v30XKMhWuw/tuwILZtk5Pz4M+OSvgAwukjqQ0vwK S3ul+qvR6Swf00VLRGx6LJ18kC14PTxk0QgnbW1bSZBqWNhlFX/MC++xcVzjsbcIIZKg4YjqAbo
 LlGl8wEf3GSwsFdoBT6y5mSGC6g5JJAjYLIZ0uCZaPG8C6VIpNNe2PGNKV4AuDCbEz/Q/Iz9zgp +sSPy0Z0P5tpunyBRNhJL3+Qi6tcIAqx12x8BbshpF8mqcQ0Q3fdCWIO9vrPHPfiBZY7fuuU7bK Dua34k1d9Tcx9n5qxBeXNITHSIxsXmFGM1rh9+nC0m5p6tn/9nYg+bvK06fR62cEoDy5ivbThHQ
 MQ2JxxGNuq47VdIr/ZoFS/nHvrqBoeLcUTiKXMlKA4500pttBgyrhssw/kVg6F+p1PHTgm9K
X-Authority-Analysis: v=2.4 cv=IPECChvG c=1 sm=1 tr=0 ts=685a7abc cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=xNkmOz5aGSZoEMeN370A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ldt-ADTYCZgg89ta7R4xoiSSKSOb6d5j
X-Proofpoint-ORIG-GUID: Ldt-ADTYCZgg89ta7R4xoiSSKSOb6d5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01

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
 net/xfrm/xfrm_state.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..6e6bc1818903 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1714,6 +1714,28 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byspi);
 
+static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
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


