Return-Path: <netdev+bounces-193365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B23AC3A13
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821AF3AF2BE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395A1DC07D;
	Mon, 26 May 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O3g34XiA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E044139E
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241745; cv=none; b=qhhp/IbVFGMIGT0D+zj0Juk9JkdEhOGVsQST7WT0IUMiTVknZIz9lcCOGKxmg4tFqHikyMYo438K8Yj4zAv98/MUI26C+roHS9fF/vcSlwbbJBipafnr0jroE/LvFWEh/ecfW41U0tJeVa95/SNzWmJ/05Wzbr5ThTOtDHx8pNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241745; c=relaxed/simple;
	bh=2kQp/LguXrEt3grrIG+CpzIR0XkMpTObFcnULUyRxmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eEXmzcFMRZTZaHETxRZE1LdBuFPke10IXatmKYfHDbJePvZZFt2w5uPt4F2Xd+UEna2QBRBFqhEiwdGGtNU4gqLXLMyTZxBhWHel6Xt2227gyJOhJMjLkgbJxfQbD3WDx/n7Uhbw2KkrLSF2NnB6e2h0MtnP/1aQIdcTo/pfEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O3g34XiA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q57Bne017694;
	Sun, 25 May 2025 23:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=G9rdg20e9Ykg8dg10NWx1T7
	+K85TK1valHTulAtX+/0=; b=O3g34XiAu8TJCI3UU4IO8CxYvIrQrcczGesHHGb
	JZ/IEHIViKjdVbEFbCA2ylIUBu5od9opi6OTZnW5o3Ygxssl79/SPqFVjjAhhRrC
	zwHrzCKh1SCsfnd8DuHUcREaxcqT+cMSa0WiG6hHULzzYYhOXp0vFO+RfK68CnuO
	5ZCK3lKuVSrN3nTCL8eCykNsv0Hefd+Ql9DY/BR+9FZHnVuqKGM6KGWtjyBAT3fk
	ARNe4rUB8+tljeO32IAM1BF/iE+VvVAI4SMIQ5De1l5VnyL3ZJaQwoj2NHRBTOPJ
	kKSz42LHHWFwxsUg/q089OEoYv9kUPGtT9AdoYd0WqtyEVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vhv1052k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 May 2025 23:42:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 25 May 2025 23:42:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 25 May 2025 23:42:01 -0700
Received: from cavium-System-i9-11 (unknown [10.28.35.33])
	by maili.marvell.com (Postfix) with ESMTP id 3CDEF3F705C;
	Sun, 25 May 2025 23:41:57 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamluddin@marvell.com>
Subject: [PATCH] =?UTF-8?q?xfrm:=20Duplicate=20SPI=20Handling=20=E2=80=93?= =?UTF-8?q?=20IPsec-v3=20Compliance=20Concern?=
Date: Mon, 26 May 2025 12:11:55 +0530
Message-ID: <20250526064155.75189-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B8W50PtM c=1 sm=1 tr=0 ts=68340d3a cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=M5GUcnROAAAA:8 a=A28M-VhkntV8-xi-p34A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 47FFAyyWIAxdfMibXRaN48y6Pwj-Fs8S
X-Proofpoint-ORIG-GUID: 47FFAyyWIAxdfMibXRaN48y6Pwj-Fs8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA1NSBTYWx0ZWRfX3VFgv2V4eP1+ pb1wgtk3mOBSl3rl6Vo9SgrI2Fq5+ned6Mts7FakupL4XCfh4cozif0Ccp4rKGbUq4etoXNUKGt NOjg3kJcFTXHS+rRxfaDxxiPnlG4qSgBC1oJxibUZIp/8WrL/NptQu8uJkNA0iSOMnLaP7vpKrO
 8Ig110aIM+pdlOH0EnnM7oouvL7aAkO+ZBbIjRJUHxWBSjOt7IjoHG6GKMk14amrSm5zIgL4/39 KmH/fYOCR0FsrGFz5P3EOQz5uEOVDGdjFYERX3rauDN+W7NfWxVig/56jw9ozemduhNVo+03HuD S2E32Ple1IU9kORSuJiQmrKWio2e+11579EQ+mSRe6R7XNksTRH89QfboReURjUcnuj3i9orb07
 FROhusFli5SmuZ0jv6jo733yEf/rrORHraBGRhDsG2gkRVUXiXRPTwp9KUyRPmUIKPs5fii+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_03,2025-05-22_01,2025-03-28_01

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

Hence, the change is necessary to enforce strict SPI uniqueness for inbound SAs,
ensuring deterministic lookup behavior and compliance with the IPsec specification.

Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
---
 net/xfrm/xfrm_hash.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_hash.h b/net/xfrm/xfrm_hash.h
index d12bb906c9c9..a71b6dbdf532 100644
--- a/net/xfrm/xfrm_hash.h
+++ b/net/xfrm/xfrm_hash.h
@@ -116,18 +116,11 @@ static inline unsigned int __xfrm_src_hash(const xfrm_address_t *daddr,
 }
 
 static inline unsigned int
-__xfrm_spi_hash(const xfrm_address_t *daddr, __be32 spi, u8 proto,
-		unsigned short family, unsigned int hmask)
+__xfrm_spi_hash(const xfrm_address_t * __maybe_unused daddr, __be32 spi,
+		u8 __maybe_unused proto, unsigned short __maybe_unused family,
+		unsigned int hmask)
 {
-	unsigned int h = (__force u32)spi ^ proto;
-	switch (family) {
-	case AF_INET:
-		h ^= __xfrm4_addr_hash(daddr);
-		break;
-	case AF_INET6:
-		h ^= __xfrm6_addr_hash(daddr);
-		break;
-	}
+	unsigned int h = (__force u32)spi;
 	return (h ^ (h >> 10) ^ (h >> 20)) & hmask;
 }
 
-- 
2.48.1


