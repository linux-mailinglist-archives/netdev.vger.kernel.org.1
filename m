Return-Path: <netdev+bounces-116612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D529994B1F7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93368282240
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EC14C5B0;
	Wed,  7 Aug 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SuQMEWmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA814901B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065504; cv=none; b=V74USiSmrcIm//KjngQygZK3gbnCwvavObflnTZjDQpstRGJGxOrqAwxFA++gouz5q3I1F7OrpNXtupgdAG5BGk8e5n95rE9/RdCbRp+yckUGr7u9eVKTpMy6fF+MFhh/9Q5cLL12nmu0qfThOl1vQRwG4H+RMNoU+1OcmyHlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065504; c=relaxed/simple;
	bh=Kqs1oanX2CFh5bqm2O06WaaqrcjQpu5zcoiMJxfIj5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuNINbTyw6I9EBTvxrqTYAnCjX+YVLw/AXH4pKiR7JQHY/3WrjQ4NyeAifGiaDSggBHhP4LOYClEEk6GIXo0hTsn0lFan1BcKQKAQz0T3ocEtlgz5+mV7Gi+fgy7xV2Dz/vS97qFg6Mojmqisjt0CwbOvXAQsdOO2lHrm1PZA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SuQMEWmQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477Hcvbr003324
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/WWOxJSB9YHdL
	kcY/o1RHZPbx2RKM7u1KdpN2dHSc7Y=; b=SuQMEWmQVkWU0ZfC163dbtZAkjV1+
	luLtjAMegYXb//d4bThQXjOiWVM6ghlFHfHMdwgBQZ78t+ZqpykfTXL+RBh3yLmL
	mr6ozqfOZ9klnDBHFyilhSN+29HufqiiZ6SDvGVHHDq3NChIIYH7kjwHN/bpQOjp
	rpV23AOZw39T5HEK+VwIZuRRvrrKdT4dW05nKSJwTe8CYhshzE6Zj11AIxVL1e53
	zxssAZ7HY7aY19Bn8yR8+pH3UvyrP3ZFnk69btQf7nuZ5kUlKrhDzOeWzbM40493
	gsyYq5ayG3zj2GL9cDxNF8SnJJJOBaZZJ3WhWM27KtkCVELAvy4fZbOLA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vdgerf3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477J4mqm024155
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpk3pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIEWv21627466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F0B58079;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43E8358077;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 2/7] ibmvnic: Use header len helper functions on tx
Date: Wed,  7 Aug 2024 16:18:04 -0500
Message-ID: <20240807211809.1259563-3-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807211809.1259563-1-nnac123@linux.ibm.com>
References: <20240807211809.1259563-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LIOD3aycCOK0qNm2F3jNYZzss8QCutNq
X-Proofpoint-ORIG-GUID: LIOD3aycCOK0qNm2F3jNYZzss8QCutNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=603 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070146

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


