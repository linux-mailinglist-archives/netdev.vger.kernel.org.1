Return-Path: <netdev+bounces-116236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AD94987B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9976281C46
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03637154C11;
	Tue,  6 Aug 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QAavUyVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A59129A7E
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973041; cv=none; b=Bbpwq+NbxV/H6qjxG22VIrbQo5Cf/8J5IdXC2P+UT7FNHG6vuivTQeWwJ83m0DNsnsAIxysKUKLFW/IbEyKo0jzsOE4F+ddA6+0R48WPlGrSkkJ5lQ9GC/tNpbs9oRnTqF2anGXCqijFIMmto8S4VaQkDnS5mCU6xSo4NFKSejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973041; c=relaxed/simple;
	bh=Kqs1oanX2CFh5bqm2O06WaaqrcjQpu5zcoiMJxfIj5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lurAsu4T7tjfbkqW3BYYu6fxaJWsWTO8Rjfv2btNf4vsBp3D33kh8MrhYE/0SRx8e3qQW4Smcvu16ktkbmTNNPSdEHn1tyqA4Rrl8JSsjBqRnqYuFHISXHxlE2amSoWNXosR2JcEyYO7A9oVES8Vo3efIMFAizOI51RRYk2qX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QAavUyVQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476ES4VK011534
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/WWOxJSB9YHdL
	kcY/o1RHZPbx2RKM7u1KdpN2dHSc7Y=; b=QAavUyVQ8Qy62EvnH0WF6cEGRCsM2
	5CmWcOVLI+44WijUtCjbEatQMDUGla6t4lWY5sPC84mtqLDfPz1AcR8YKDWtlR0s
	Yn6pniNhIcl2gcBK15DGlUGvQSZJy3hWlRcZQ5l0ZeJSX42IMZmX9CCCcqbQ2toN
	cL3YYo2N8aRDdNvam+95F4HbN4p+UDZoCerouSlFaKGmIrVuyGTAQvqnV1DNmtDi
	hmfURLZcyyj26LaIl9rTBxZxcnh+5VH/6jCcpeoS0TJ6FDwa1lHCRa1fF1zLujhs
	9aJz6IXPFUjhqhjQzxWeABbkMFqbwRyHa6Q4JOIgKX0D8FlFrKVMLcQOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40umqvrtus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476IcJSE024361
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90ng1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbBLY15139400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AFF258068;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 300E65805D;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 2/7] ibmvnic: Use header len helper functions on tx
Date: Tue,  6 Aug 2024 14:37:01 -0500
Message-ID: <20240806193706.998148-3-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806193706.998148-1-nnac123@linux.ibm.com>
References: <20240806193706.998148-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D5hIWMMHhp95Kok-HqQbD1KOQC6vVh4f
X-Proofpoint-GUID: D5hIWMMHhp95Kok-HqQbD1KOQC6vVh4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=603 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408060137

Use the header length helper functions rather than trying to calculate
it within the driver. There are defined functions for mac and network
headers (skb_mac_header_len and skb_network_header_len) but no such
function exists for the transport header length.

Also, hdr_data was memset during allocation to all 0's so no need to
memset again.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 857d585bd229..7d552d4bbe15 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2156,36 +2156,28 @@ static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
 	int len = 0;
 	u8 *hdr;
 
-	if (skb_vlan_tagged(skb) && !skb_vlan_tag_present(skb))
-		hdr_len[0] = sizeof(struct vlan_ethhdr);
-	else
-		hdr_len[0] = sizeof(struct ethhdr);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
-		hdr_len[1] = ip_hdr(skb)->ihl * 4;
 		if (ip_hdr(skb)->protocol == IPPROTO_TCP)
 			hdr_len[2] = tcp_hdrlen(skb);
 		else if (ip_hdr(skb)->protocol == IPPROTO_UDP)
 			hdr_len[2] = sizeof(struct udphdr);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		hdr_len[1] = sizeof(struct ipv6hdr);
 		if (ipv6_hdr(skb)->nexthdr == IPPROTO_TCP)
 			hdr_len[2] = tcp_hdrlen(skb);
 		else if (ipv6_hdr(skb)->nexthdr == IPPROTO_UDP)
 			hdr_len[2] = sizeof(struct udphdr);
-	} else if (skb->protocol == htons(ETH_P_ARP)) {
-		hdr_len[1] = arp_hdr_len(skb->dev);
-		hdr_len[2] = 0;
 	}
 
-	memset(hdr_data, 0, 120);
 	if ((hdr_field >> 6) & 1) {
+		hdr_len[0] = skb_mac_header_len(skb);
 		hdr = skb_mac_header(skb);
 		memcpy(hdr_data, hdr, hdr_len[0]);
 		len += hdr_len[0];
 	}
 
 	if ((hdr_field >> 5) & 1) {
+		hdr_len[1] = skb_network_header_len(skb);
 		hdr = skb_network_header(skb);
 		memcpy(hdr_data + len, hdr, hdr_len[1]);
 		len += hdr_len[1];
@@ -2196,6 +2188,7 @@ static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
 		memcpy(hdr_data + len, hdr, hdr_len[2]);
 		len += hdr_len[2];
 	}
+
 	return len;
 }
 
-- 
2.43.0


