Return-Path: <netdev+bounces-198012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6DADAD03
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969E37AABB1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF5271A6D;
	Mon, 16 Jun 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NyhcmlKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09562698AE
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068421; cv=none; b=BCekvsy4izsTcx8IKPQQAnWZKXvQsSTsaLdtmJbwFXBDQl2df8oWpWHG4JIoeNDOZGY503XEWNE19OQb/udQ7w3sPRvVdKy7ysfITmwFbQ14ttili7yEQoAmJzhzvE9QALFWvaoTP2fYoLKm6tiVRjIgtk+GJZ1ww+KJtGlFakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068421; c=relaxed/simple;
	bh=eGTrlAv5J2ntZdoE6k+KE6bBizuGluTEOd7hAUyE47I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcYFTpXrrVTUYNyuWjsIWZ21e229XH0O1lFn4XOJJ1Mmx2CBsYocVeuOZSYafx2jaL8vu24W0uPIs2XqPHUQyf5/6nnlpJo41Lw2kDEIscsPZwn34slJcgMZBinqKnz8R/lTGtIpa/nqN4xiLX8vEW9AK/MxlPt3S3kzk0aHu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NyhcmlKQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNfdZS021061;
	Mon, 16 Jun 2025 03:06:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=DTPrH8SLt8pENynpDIwVZGR
	OalYkJDB6N3hEAd5AgfU=; b=NyhcmlKQmuZmVqzMs1f5QQyr0c3Lj0yj1c6Od3m
	+G1v/kz18nlpSLkTr2FwKDd5Wwc4Fm1FFLVPf7MAZSbSJVILAdQ431/11hKwrQIQ
	LdiTy1AdlJyItSUSbbr8ScLmLrCx4SicU5bsJ64Uf65YV2Gv9UQX9m1HvtLmifFO
	2Suytw4owdIZahWsRVueSLzZpJ4JS3mleC82w5721WA7r8Lupx4gDZ3oH0/t0jB7
	iFBqsPy3imIoGNkmHRe4Ye15UEg8hpw3vIUd1mAkO5tGALTQZWi/beqfYIkwOBpC
	yCYbXRRvD8nNBCBblTLZPHiuk+SpQ0kuT4bepb3qwDF5WlQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47a7vqgykj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 03:06:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 03:06:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 03:06:28 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id DE78C5E6869;
	Mon, 16 Jun 2025 03:06:24 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>, <antony@phenome.org>
Subject: [PATCH]    xfrm: Duplicate SPI Handling
Date: Mon, 16 Jun 2025 15:36:21 +0530
Message-ID: <20250616100621.837472-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fr7m4_t0UmJqBcapbAbcJBsS9ss_9xSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NCBTYWx0ZWRfXyqQm/sZyH+ZG PzeNWtgf1n520pv0loBnW0pd74Ux4zO6HdG583bw4gF5HOnH2TSmHVq0c6PXSYCDvpLSfmOhcoE Rb2oD4hmrk92WuyIMuACinTAO3IoclZXVY5knfN94m0QU0NJoN2FGCVu1VpkNfYWndyu5RxnUGt
 FOBSGW/Ye40LQMO/0z+WXtVlf02FphwD3R12oSUZSh4I4pg2uro3trKq8sWSmZ6meHBpFW1acFh ToHHx+dUxTV2nCWxA49xZPa0nk87oB3yqxquf1w8MevS+J/p8aj8t0DRV/ZmCvtOjwhT8ZCjHfo waPCi0Gn/9BMKg6sf4ZkOpupAk71Lm41TqbnqCQqOPYPt5EwvE59OrXavmZlpf+GNLKNE2AK6dg
 BG7FCqpTWE3rkZjIq1SsLG2roXrwBU21IxYcoyH2a06M4em/YrA4ozW0yrcCHtRqwolSNBsz
X-Authority-Analysis: v=2.4 cv=Q9jS452a c=1 sm=1 tr=0 ts=684feca5 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=3cPYwFQvcDpM_y1OWQkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: fr7m4_t0UmJqBcapbAbcJBsS9ss_9xSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01

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


