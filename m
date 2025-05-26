Return-Path: <netdev+bounces-193366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF2DAC3A16
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AB5172D7B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E3145323;
	Mon, 26 May 2025 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KZ2YOX2F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CE1DE3BE
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241824; cv=none; b=lq3yrbekgRSyB66PCUR+hnsSZNkSMjAr67jzPzJQ2RXNfj9m9pAXWkiyjjL07VOl/jEvVT5y9xFxofDGDwPaR4vY9GvEOkyYqp0Jct3ftj1+lTDTdjyksG4jYLqBD53PM7W9mtUmEzn9CBfbb754HnP6GqIbCSWzkeXPk0QkW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241824; c=relaxed/simple;
	bh=2kQp/LguXrEt3grrIG+CpzIR0XkMpTObFcnULUyRxmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oMaMUiwUTfO29duJ8r2wYtQkxEGKqUzeK24ywX4SJLVwe1PW2iMelZdvNvmQzV0WQ/W/CLh83b1syloc9OpIOwMsR5pIgcyQWwS7x6ttCqHGBa65pAxQayhFb6ZYr8/Vsy4QhE0TwciM43BKJg+LpVVrZ/B8ZFA6+wN1PFNf0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KZ2YOX2F; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q57Bbc017685;
	Sun, 25 May 2025 23:43:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=G9rdg20e9Ykg8dg10NWx1T7
	+K85TK1valHTulAtX+/0=; b=KZ2YOX2F/OSPBFmTk0bSOrnhdSIjHlZFb/cTePE
	xzu8pAWYoTQzW30B7JCTnGW+b+Lorly1k3LIsIv3pVMvtHigiPgci1e2MYg+cbuR
	vzT2a6XYUHqdjMpbPivF2jxP2TjsQM3gUNGII9ZWbuL268o+Dm3qNoHgz/AysOiY
	CbGgVnaZtSauyFioS6Hc0gpb+YMfXHyZr4ZeflVfEWhsS0QuGw1DxDw+sIoAfKEX
	CFJxxo0/VnmhyzQa3y5RJH8IBCF7ZEtSidWlrbQVkjY9DvG8bzV6BsSxBdLxVruS
	zOC/qEdo2Wc4uKxjqZ8n1F/ppKkYwTOAfnPpm6ibVl1KsVQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vhv1054x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 May 2025 23:43:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 25 May 2025 23:43:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 25 May 2025 23:43:29 -0700
Received: from cavium-System-i9-11 (unknown [10.28.35.33])
	by maili.marvell.com (Postfix) with ESMTP id B5E9B3F705C;
	Sun, 25 May 2025 23:43:25 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>
Subject: [PATCH] =?UTF-8?q?xfrm:=20Duplicate=20SPI=20Handling=20=E2=80=93?= =?UTF-8?q?=20IPsec-v3=20Compliance=20Concern?=
Date: Mon, 26 May 2025 12:13:22 +0530
Message-ID: <20250526064322.75199-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B8W50PtM c=1 sm=1 tr=0 ts=68340d92 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=M5GUcnROAAAA:8 a=A28M-VhkntV8-xi-p34A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aWURxr39I7M1Gn3LuaKP2wo4yYYzDYbQ
X-Proofpoint-ORIG-GUID: aWURxr39I7M1Gn3LuaKP2wo4yYYzDYbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA1NSBTYWx0ZWRfXwiPPNoYG+jAP FXX4Tabg+c1xZtaDArSB4+FLCvpoXw86VYlalkrPL+T1tWqwmT6K21mySjYqDSV68NiSjjRn5ca st7KRmYkQ0cfNMYbTzFMmZsaKxTwvclnNqINoPZ01IU/egI3qBsA9aTa5b5ADS5K961ixntEjnV
 BR0TinqUI7ToIatdU2tQwlPxbjMYwuxla7K9W1V5Z2vw5guRY/E47HpYegwzbqtVb4OaOaUCflz SXXyODYGXCL8va/8Rk4Zu7h7gDxsEVCsHJuL9jn0nSJgDRDw4lyazOVObUWynV/tQeIW6buB9Ld C3E6y4AsUzbTOUu41POMufYX5+6ZNuBLYtUUXlJ/5zjR+gd3u4s9+OE05mv2Mk67HLm+J5vi2Zw
 iEdZQLvxTlVQ5lsrJDqDYRKtsfRgXQRVcvFMkWR9U1gUqlD3Qs1R/zjfvier3rriMnspf0MU
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


