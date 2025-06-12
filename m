Return-Path: <netdev+bounces-196813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B3AD6781
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66977A25E9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4CD19B3CB;
	Thu, 12 Jun 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fdqcJznN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6912AE6D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707441; cv=none; b=A0uVXImw0k8uNnmoSE8wqlYvnFcb0PwQxJNkOrNWhNBDV/cFJ1vf1QFtN8/6F/cGRXU4Pv1EqyMc1zjrg0j7nnBBOcvVThXaR0H4hO+XWuFF8zlq8EvfSCl/0oSv379bOexcwmV4CH71/pkZRe34L/Ab3awy9/HZi9RHBr2V4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707441; c=relaxed/simple;
	bh=WzhZF+n0ftIhiUaWutuO1KfR54tlKHLOcLdH4pRRd94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NjD1xHoZClQyNgJJdzQM5P0yZVJtwuW9RvqCzVjbTThwBFueWw6vP0DTsc0vIlYqA0k223idCSmUTPYGKJjNPrflWH8TB45i+JjQpmgCG4jN0/aRgznBIFuVir6Yut6CpwIQjSUwBJgz1bk3sa3vemtFliu3jZjGg/TJerUGEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fdqcJznN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C5Fe3V024954;
	Wed, 11 Jun 2025 22:50:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ERMTXDW8LMQ+O/nXSKDQcxO
	kTdXjenpZYMuyqGD06mY=; b=fdqcJznNott810Ph4jepTXao25uXY8l3Io9jZx0
	0iB+E8PXyWoDotwdKzOOy0849uwswNZy+PKa/PO1h8q6rIgQxEPmSiY3c0IoZ/ec
	ZP0rytNj32azO7c87ZJKUB2gNbYcR45s8LHmJ/lEMga4co2r3NhQ3SIcNPOn8OaZ
	8oXiUthSwXPlSIgQQdzIlz4D4RjPlcVYc7XBXBvy5wddI/2S4s10SfZE8WVW9RDB
	cRai+xws119EpzUtVI95TBBqtpkHJcUTENNsSYqoIvaqfeN+bONSZd4VLUu39Fez
	AZZApIP7eCYgclRCPidvIGglwpOw2yLKDOXkRHpAiBpMpTg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 477rk101st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 22:50:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Jun 2025 22:50:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Jun 2025 22:50:26 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id 9C5813F7064;
	Wed, 11 Jun 2025 22:50:22 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>
Subject: [PATCH] =?UTF-8?q?=20=20=20xfrm:=20Duplicate=20SPI=20Handling=20?= =?UTF-8?q?=E2=80=93=20IPsec-v3=20Compliance=20Concern?=
Date: Thu, 12 Jun 2025 11:20:17 +0530
Message-ID: <20250612055017.806273-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QjlM0PVi9fQseISJ3LQqmpR6sopprUzk
X-Authority-Analysis: v=2.4 cv=V4t90fni c=1 sm=1 tr=0 ts=684a6aa3 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=5KLPUuaC_9wA:10 a=M5GUcnROAAAA:8 a=3cPYwFQvcDpM_y1OWQkA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0MiBTYWx0ZWRfX+PvxC9t0gfGW 0IFfkNn6pdXg1DZFI9NaAfsMN19FdaJ+VYh9tCsT4aqDgvnfu/3z/iwA8WadroLnc9lZyYL2L5a 4AO4y/g7+zxZgQpBO2lvYrLvJyb9XNWpnkp9TO4XHy5OuUlCZS23hStbimzvrY+xo2Xr5plhxmo
 cA1ZDRZpA4hsYQU++b2B+8QJAUbgQMErBrSUcvbaFvSQSwv+t20cjsTFkPbIc8Kii7bBRZzkHVe tZjQr9tNbEttRY4MLnFKJH5VLJYemW+AOos2XrbBvzn7CIHL7XorpYxuF7F4wjjGPXfnjeM7w+h ZjXnP6d6zGeT78pTpcMiQuAw+snct8ES4Bgpwhr8vp5zUSnufQGctRKrVGW+x6S0Tv5Hy2f8uSK
 0AmORZxvv+ZCH3McSpD16Wr6RZg5VgVRnderO/8XCytLSDggr5K0G8semu4x96/cu/chEk9F
X-Proofpoint-GUID: QjlM0PVi9fQseISJ3LQqmpR6sopprUzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01

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

        According to RFC 6071, in IPsec-v3, a unicast SA is uniquely identified
        by the SPI and optionally protocol. Therefore, relying on additional fields
        (such as destination addresses) to disambiguate SPIs contradicts
        the RFC and undermines protocol correctness.

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
 net/xfrm/xfrm_state.c | 39 +++++++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

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
index 341d79ecb5c2..9820025610ee 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1714,6 +1714,29 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
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
+EXPORT_SYMBOL(xfrm_state_lookup_spi_proto);
+
 static void __xfrm_state_insert(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -2550,7 +2573,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	__be32 minspi = htonl(low);
 	__be32 maxspi = htonl(high);
 	__be32 newspi = 0;
-	u32 mark = x->mark.v & x->mark.m;
 
 	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_DEAD) {
@@ -2565,18 +2587,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
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
@@ -2586,6 +2602,13 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
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


