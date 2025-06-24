Return-Path: <netdev+bounces-200785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089C4AE6E5F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9217B4A1934
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83B2E8DFF;
	Tue, 24 Jun 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LAP1/sr+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC02E62B3
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788692; cv=none; b=InH2YZOEFJ7qeZpAX36pJgg2CiDK4iVUlNsrt4jrW2O1SFHijEfeYnvai2SewC6ASfwENz9DfjWKf0S028TeEQqP7Yy+Lh+gMTDPl2a8c8IxQl6m9MIBb31KNy4S9D4jbaV+vuDJm3U9adHpIch1hvG09hFb7BgE0v0uaIrjMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788692; c=relaxed/simple;
	bh=zjcxu2dHhUgBLzgZxfuYmFLgW7b1g0/mu9rhxn59Urc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRwXzjf2OKF8Z6bHm7iTAc5tO73Ci/OyUHcdqCRsMNdn/Jou8VJeLvPTujuOlXC/GQ+Szm/4eL8oBCN3/qVy+nPX/K5cFg3EIJdyiSqJk9htkHYvm5sNgMX4WvxPDbjwaYSMaUjSCU1UnTFMVYmGGY1SVItN5gct/IiK7Lf7x9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LAP1/sr+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHJsXk029843;
	Tue, 24 Jun 2025 11:11:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=B/x4fdFZXrv9BoJYZq0RM0v
	AoJgg98yjaM/hGKqb2YU=; b=LAP1/sr+5Hbk9IagRC6FcFN9x/zRkRDZwK6qy87
	2G44/DHB8Z5b952w+h77n/pp+NHzvBolSkyCGCaCArUdvRMQ83UyD/1JgKj511sj
	M5xlMxcm8iZ+520TnYXzNS3z+lo3jgdADv6CXX7Ze9VEH9dXqlt1utUR8x8VN5Ag
	yOCOJ4rREp9z+UMRXufqeKEsTWnmhwzRXp813B1TgIlrGWo70SHIwyDB2GFdROxw
	cBJs+7nfJzFCvxrRkgxtNnK9lJ7EXn3DnJVNMpzyhBb13C9kGcFqo4HYw1LOY8wC
	IVC5efORURDj6bXJ76QD9LpaS2P5C1+tdo/Ml1pOCmFbs8A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ft7h133b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 11:11:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 11:11:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 11:11:00 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id B95D75B694A;
	Tue, 24 Jun 2025 11:10:56 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>, <antony@phenome.org>
Subject: [PATCH] xfrm: Duplicate SPI Handling
Date: Tue, 24 Jun 2025 23:40:54 +0530
Message-ID: <20250624181054.1502835-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FZTZKJ9NUJ0GHxe7VRdhsdozbwllZA02
X-Proofpoint-ORIG-GUID: FZTZKJ9NUJ0GHxe7VRdhsdozbwllZA02
X-Authority-Analysis: v=2.4 cv=Nr7Rc9dJ c=1 sm=1 tr=0 ts=685aea36 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=tltKNFKyYWRyqH3nS48A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE0OSBTYWx0ZWRfX9dUx46tMFRZV C0pvM0x4DZ+PSpkcdnAAyt8vl2JtasSbl4DI1Y1oVywlOFeQBXuZEeA77IwiIJ7BRTEriWz7vXb UpChBUsYaVG8oOn3IidsqccesFNyOLLAPdFiMHpendB1mwzf9qQJsDJvjp6AvyEnz89KtuoP3po
 GGJiAdOFvlsNtDGzWu7Vh++Ljw6Ggb3yrMAlxZXe+SZmAEIhPAWcO5YH/1CpDy+F3iKdGmtfIJU ckT+yggq9V5K7/pfA1J+dFPLRFK1Z+OzQmMLDbZXtAJLX59Yz5xnCgbeVsg2FE6RoxIHibeN3mm Ki6BVUNzAHHqwTeAxcxVDDpnuO+G0yjHhTZaKxZiRsqCgGlT4iqW6F5E5XDXtGudCSxC+TCq6u9
 +f1O7N/LI+k+TlVnImwqN9GfAq23AXT7cTYTwJN2fBqX5d8n0es6Ug1uJDDpwX75Zpy+Jhix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

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
 net/xfrm/xfrm_state.c | 78 ++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..74855af27d15 100644
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
@@ -2547,10 +2569,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	unsigned int h;
 	struct xfrm_state *x0;
 	int err = -ENOENT;
-	__be32 minspi = htonl(low);
-	__be32 maxspi = htonl(high);
+	u32 range = high - low + 1;
 	__be32 newspi = 0;
-	u32 mark = x->mark.v & x->mark.m;
 
 	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_DEAD) {
@@ -2564,39 +2584,35 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	err = -ENOENT;
 
-	if (minspi == maxspi) {
-		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
-		if (x0) {
-			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
-			xfrm_state_put(x0);
-			goto unlock;
-		}
-		newspi = minspi;
-	} else {
-		u32 spi = 0;
-		for (h = 0; h < high-low+1; h++) {
-			spi = get_random_u32_inclusive(low, high);
-			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
-			if (x0 == NULL) {
-				newspi = htonl(spi);
-				break;
-			}
-			xfrm_state_put(x0);
-		}
-	}
-	if (newspi) {
+	for (h = 0; h < range; h++) {
+		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		newspi = htonl(spi);
+
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		x->id.spi = newspi;
-		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
-		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
-				  x->xso.type);
+		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
+		if (!x0) {
+			x->id.spi = newspi;
+			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
+			XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h, x->xso.type);
+			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+			err = 0;
+			goto unlock;
+                }
+		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-		err = 0;
-	} else {
-		NL_SET_ERR_MSG(extack, "No SPI available in the requested range");
+		if (signal_pending(current)) {
+			err = -ERESTARTSYS;
+			goto unlock;
+                }
+
+		if (low == high)
+			break;
 	}
 
+	if (err)
+		NL_SET_ERR_MSG(extack, "No SPI available in the requested range");
+
 unlock:
 	spin_unlock_bh(&x->lock);
 
-- 
2.43.0


