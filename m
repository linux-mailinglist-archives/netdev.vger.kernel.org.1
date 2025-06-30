Return-Path: <netdev+bounces-202426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA8AEDD4A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F977ACB09
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2A2857FF;
	Mon, 30 Jun 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Msm+Zl6m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D13286439
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287223; cv=none; b=WJ6C0AkEmJEvMLrmIIo8wxaZKd6ExH4RiPDXJ4KN/z/bsrIH25bMUo4HU/aXI9O+vMxBkhjdRZ1ZynALqDnIHxI/ceG/RIlnGn/YGKnf6vRraz+YBimpuVF8qPfcpmF8lCRq4xSMXbO2NPnuGBA83KSLJ93siH4vLZTMKgVvAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287223; c=relaxed/simple;
	bh=Hpvy8t9wTo9E/h0YcjG6qn2O5/OoiyUzLSiUPmNyOQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdOhW5uxyKML/GHXcYr3+8qYszc58F+HiR5cgyoTJoeYkvsHQGWB0VFS3dFwoU7KfCT8PDs/1Vj4QxJVgfYTl+kJAMjcmbKgz1hZTD6N56nkg2LVgRqzyWVPJem3r74hzpASVYRF0br/PHwEKS7PwuaCn3vsOjtw/AMpqQwphs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Msm+Zl6m; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UAk81R004916;
	Mon, 30 Jun 2025 05:39:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OJxeVJTqA0mRGuf7tl7qBXI
	MkNzRkvwFjGh/rL4EQTM=; b=Msm+Zl6m68KVKQ9xgfiH5qwPszN1ETlDajoijCs
	F4+AStpgtR1Ls0a8/VmbkyHSTS8Im7P5Ol8z1tEEn+h21FClfoe4/dOxIjdu7Ur+
	BOOO7QXXNyJk6HqnSwtDz0n6WXG5QxYhWGq+5HwUr9OGkxfNEjVt9culmCUqjgEx
	aX2QizC3a+/v/OsB2p8coFDOfvGnZMy3eXtJScJB6g+fyygLYbClkm8NP8oH6VZk
	Prag+G4ThR46uEgCUV54zKR9xdvEVtGN5WMQCxUbWbW3Q2iU/JfHObZ1yqOzVagq
	ZCf4lPG7mIeohDgYvqtivBaATbgnKhbvAiQYeX9gx2DA3OQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ks43g660-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:39:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Jun 2025 05:39:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Jun 2025 05:39:04 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id 951B05B6921;
	Mon, 30 Jun 2025 05:39:01 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>, <antony@phenome.org>
Subject: [PATCH] xfrm: Duplicate SPI Handling
Date: Mon, 30 Jun 2025 18:08:56 +0530
Message-ID: <20250630123856.1750366-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEwMyBTYWx0ZWRfX8KggS4zEeSWu wByldHchvtkwyb4dJ4ep+AkZbHNFPPR2MtrRquTO0WPntF+6RDNsN90XhcRxJMDtxXnSu/RRTNN 119ue+2NSAv6tdaLSlL3UkJ2RmEc0I3+RypZh4kO30cAVw/ZqdCRdHs4RmO2Gc/yLdad+RY0Zf/
 RKVFgOf6N+nhNvd0/XIl8kQ3+55dND18thzvJR7YW2RiWRIuqBUiIctK4kc97Ewfx3o8SQhgKtH tUcsKEbsisCNHVBT4043alLuTC+hOGRxc8mPX2qwikDkdV3oBbIQGLJCzQkn7DUkFdRbxGpJwzn Hdm4l/1ySaUfXdQBfSJxuT9+oBvBqeQtHrodMZvl6M0AEVTjKe07sRqWyZM+/vPWcuqh34qPiMW
 OT01AMySMVNEGnPeUdziVwGNSu8K5UumJ1RdTHukeBKnoO1VKaiOvKSLYYY2Z3zTt2RAWuSB
X-Proofpoint-GUID: 3-aHxNUAM8tQfJPiEJjyO9palZxsIza4
X-Proofpoint-ORIG-GUID: 3-aHxNUAM8tQfJPiEJjyO9palZxsIza4
X-Authority-Analysis: v=2.4 cv=Lbc86ifi c=1 sm=1 tr=0 ts=68628569 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=UX3akyHuaT3hde3hHWgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01

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
 net/xfrm/xfrm_state.c | 72 ++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..0b8168a30c2e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1714,6 +1714,26 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byspi);
 
+static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
+{
+	struct xfrm_state *x;
+	unsigned int i;
+
+	rcu_read_lock();
+	for (i = 0; i <= net->xfrm.state_hmask; i++) {
+		hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
+			if (x->id.spi == spi && x->id.proto == proto) {
+				if (!xfrm_state_hold_rcu(x))
+					continue;
+				rcu_read_unlock();
+				return x;
+			}
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
 static void __xfrm_state_insert(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -2547,10 +2567,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
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
@@ -2564,38 +2582,34 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	err = -ENOENT;
 
-	if (minspi == maxspi) {
-		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
-		if (x0) {
-			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
-			xfrm_state_put(x0);
+	for (h = 0; h < range; h++) {
+		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		newspi = htonl(spi);
+
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
+		if (!x0) {
+			x->id.spi = newspi;
+			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
+			XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h, x->xso.type);
+			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+			err = 0;
 			goto unlock;
 		}
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
+		xfrm_state_put(x0);
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+
+		if (signal_pending(current)) {
+			err = -ERESTARTSYS;
+			goto unlock;
 		}
+
+		if (low == high)
+			break;
 	}
-	if (newspi) {
-		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		x->id.spi = newspi;
-		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
-		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
-				  x->xso.type);
-		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-		err = 0;
-	} else {
+	if (err)
 		NL_SET_ERR_MSG(extack, "No SPI available in the requested range");
-	}
 
 unlock:
 	spin_unlock_bh(&x->lock);
-- 
2.43.0


