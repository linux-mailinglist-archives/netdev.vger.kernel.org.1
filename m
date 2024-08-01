Return-Path: <netdev+bounces-115132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8B94541A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D241F23BA0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B7A14C5A9;
	Thu,  1 Aug 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PG4aCxyk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8511D14883C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547436; cv=none; b=SCO52L2LLLD7NSGEcInRoytYEjcB2oyqCLRThN65DBC32VYQCSVMV1B+4lBhDP2W5g7ewTZWDYWtBuBAOZjIk2C9r6sBE5/kLjb0M2XftMA+9ZDUG9ij869lheVBxoD1bvm8Q7AfAPb8Yjqoj327pkv3EWJeuxJGxtt3XVVOCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547436; c=relaxed/simple;
	bh=Kqs1oanX2CFh5bqm2O06WaaqrcjQpu5zcoiMJxfIj5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNv1Jg3tJwicIIhC3jX662Si3N3D39HdjiimFhefkYh6LBXx14nRozEYfXwHxwM0eaUhyAZQoUnJ7hMaPtREPlgIs+nkLkvT2Te2oFJe88yOnRewStM6DyiUCS6koUpX//hA3qiAoMqpWFKD+2+grhdA0+HRCKANJ20Gkm9Ef+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PG4aCxyk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Kv0vi002954
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/WWOxJSB9YHdL
	kcY/o1RHZPbx2RKM7u1KdpN2dHSc7Y=; b=PG4aCxyk21E9CScrVayKyPMhmRZ4K
	pwbPcG0v6AIHeSo/G2HZSuNIuP28BfsXZmlFCwbtci2qn3N1qNXxrK/5+9YHLVV9
	71DwCC6HCLMtOnucb6FCqbpKcSUI1MQROvUQoM3b0NN80E+5BUo1Sntqea8tUrbX
	TAEjYBdYQiFHMbTm6SzeseMRwzXOdsRCwjPr+M2z/nFXtKHxhhHYJpGMbPuDTDLl
	wTwIzdT63LW23peX/vPyZ4CRmjurD2LTbJhoIjbAFb/qL2Pz2cznm/p51ce58lAo
	m5WSS6p+/0IkrbTEzYgLAic/LoU+VT/sfxO48DfBAu2x/2gjyxjo0Z/ig==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh02r55k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471IaAAP018867
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q3xwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LNjbO25428608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:23:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E835E58061;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F4135805C;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 2/7] ibmvnic: Use header len helper functions on tx
Date: Thu,  1 Aug 2024 16:23:35 -0500
Message-ID: <20240801212340.132607-3-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801212340.132607-1-nnac123@linux.ibm.com>
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CbWmUXLAVJvlwm-mHqWOLmdYLPTIbKgi
X-Proofpoint-GUID: CbWmUXLAVJvlwm-mHqWOLmdYLPTIbKgi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_19,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=599 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010142

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


