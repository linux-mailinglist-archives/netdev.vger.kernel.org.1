Return-Path: <netdev+bounces-195636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1564AAD18B8
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1897169804
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4728030B;
	Mon,  9 Jun 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UemKjj6L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1652459CF
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749451834; cv=none; b=FKTynI+kUXoCqNjEiIp8WSf+UIjZ5XGgdKNKI2qsnBmU6/y37G2r9qPUOxqA6Xp2Gu1Y0glfGFEh5mY3rgNrcdgwW7hEeh2fO1HMjOOkRodMRLvtAKSRovxv86EARqPeRpScTEQdIQ5BDqQjFZRDbenptsm9AAkJ9JxXzYGwj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749451834; c=relaxed/simple;
	bh=EsmXMKt64tYiu+smKrC2ARAI+5VLlmhr2veqlA2P9vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4kc4N1p4UHxjHwYCTqKiOkL/fWuk1FeNNLBJwvcPfTpGzoO+sVAPh70Vhn4HSEuT5Qk0U9yZPEhpF5epur0PC02I0J6qppoYEQf4ktXqh14MQ6+KquK8d5+3RLtiIf7OlIjfsH2YozfDmIvDSTKVUyniFe66Zx1CEiNfZ819BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UemKjj6L; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55940tPI005580;
	Sun, 8 Jun 2025 23:50:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=SRxlXKxDhlkVwaERbD8tMYA
	vBa7GfiaYewMd6PgC2Qs=; b=UemKjj6LiLh8UwYuA617DFrr2hgijBG0zb3NpE5
	uu32EnHcYuyUIHwPco5DRG/qqVQR6J8rnQr3gFxK94bQdq0n1j+QiAUrescHGG40
	SzCJcRpm0KcHhRET/h4zW3cg3zTU1xhJ0rUGQ6P1X0+rXv3cZquL04LXvGREKBvX
	x6N+WI7vLXkADg+8SideblYUnVmnT8RhSoMxBnzwMHMvK6q32B4L+3ncZaQYPyoS
	a8G+XN+WMI94vCCSl7md2r+osUde899UMU0ECRkBbjh2lylTONt8kXMBcQzXIpdm
	fFAdH3Nzq3ogbI8OQn59wenEMmQr5x66MOgWaJFzZtXwXBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4759pbh65x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Jun 2025 23:50:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 8 Jun 2025 23:50:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 8 Jun 2025 23:50:21 -0700
Received: from cavium-System-i9-11 (unknown [10.28.38.183])
	by maili.marvell.com (Postfix) with ESMTP id E53233F708C;
	Sun,  8 Jun 2025 23:50:17 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>
Subject: [PATCH] =?UTF-8?q?=20=20=20xfrm:=20Duplicate=20SPI=20Handling=20?= =?UTF-8?q?=E2=80=93=20IPsec-v3=20Compliance=20Concern?=
Date: Mon, 9 Jun 2025 12:20:14 +0530
Message-ID: <20250609065014.381215-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f+pIBPyM c=1 sm=1 tr=0 ts=6846842d cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=5KLPUuaC_9wA:10 a=M5GUcnROAAAA:8 a=zGm2w0v4Y8SJgk1fLE4A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: yssy3skGLSBR2NAHbne30mFFCmxM5ahE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1MyBTYWx0ZWRfX/W/1ot4BCzus cUQxYcoilNt34WynvvJAZ2o7btBvhVYj0J8zjX8a5V/yWdYec0DRItn8U04Rv/zrsd4z9L1afbz FsxVBSw19mgc90q0J8B+9czxR3nbApkyIqtQkFRP9Ck6P0CtbZv2XFP+V9Ura7iPuXAbjG/x9qm
 c1jg2kdHBJUTKXmayF8H2Azh9Wy0aD3RUFtiYttae7Lx9bsExQQeQ8u9CX+Nqrd5v7gpTRWV6gL 0HGozbOMJ5IweyN7j+JVBrCYct/QF6Jp4vKRxjlZfkwd6myoXjfJ0u3ok3kABtq9kueNMN3eV8P WNnwuJcTbc8yZtFM/AH9j1q2BULdZhK1ficUD9prXQ14zNpcBavFXV4zUI+tZqULlBcELp53lVm
 nlkVei3pdpRV/bUag50t9h8AETTyw+kDv+2yktzAagHYsg3sIA3OFA2PLNVZYwqiLpz4pJcB
X-Proofpoint-GUID: yssy3skGLSBR2NAHbne30mFFCmxM5ahE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01

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
        by the SPI alone. Therefore, relying on additional fields
        (such as destination addresses, proto) to disambiguate SPIs contradicts
        the RFC and undermines protocol correctness.

        Current implementation:
        xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
        So if two SAs have the same SPI but different destination addresses or protocols,
        they will:
           a. Hash into different buckets
           b. Be stored in different linked lists (byspi + h)
           c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
        As a result, the lookup will result in NULL and kernel allows that Duplicate SPI

        Proposed Change:
        xfrm_state_lookup_byspi() does a truly global search - across all states,
        regardless of hash bucket and matches SPI for a specified family

        Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
---
 net/xfrm/xfrm_state.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..4a3d6fbb3fba 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2550,7 +2550,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	__be32 minspi = htonl(low);
 	__be32 maxspi = htonl(high);
 	__be32 newspi = 0;
-	u32 mark = x->mark.v & x->mark.m;
 
 	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_DEAD) {
@@ -2565,18 +2564,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
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
+			x0 = xfrm_state_lookup_byspi(net, htonl(spi), x->props.family);
 			if (x0 == NULL) {
 				newspi = htonl(spi);
 				break;
@@ -2587,6 +2580,14 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	if (newspi) {
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
 		x->id.spi = newspi;
+
+		x0 = xfrm_state_lookup_byspi(net, newspi, x->props.family);
+		if (x0) {
+			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
+			xfrm_state_put(x0);
+			goto unlock;
+		}
+
 		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
 		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
 				  x->xso.type);
-- 
2.43.0


