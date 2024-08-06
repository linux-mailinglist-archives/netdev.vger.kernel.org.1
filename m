Return-Path: <netdev+bounces-116238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16694987D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20331F22848
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CBB154BE5;
	Tue,  6 Aug 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQ4w2Z4z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CC770FB
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973043; cv=none; b=EcWCjVqrnCXXn9y/Zh1FS/jydaR9TY7SLWKYLDTL8Su2KNBdGJ8YaM1M6CRAYZ2sdu9NHuzO37f5Qh+K+vqPDQ52sNMh+7ILtQOL81RtuJiYpI7NX3Vh3RC3tts3g3YJ26+q3qz7I1Q04Nvl7gCjOPOgRb/b+H4ZkkJVMUbI68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973043; c=relaxed/simple;
	bh=PxGkMih3F1DwayUPdeXWmoxFMlmrFU+9NtlY5FOTNp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdSwf6dVTvHutsF49a26+nVfYxsKsrOh0u+poS0odrUtfFQN485Sy6Pn01yhIv7Ohqtis0WKLN0QOSsm01AjejwH9dOtZyX6s+Yp2N0W603uqDPiKnDnkAbJ2y7QY+gZPlnGn9lkpkqR00g1KKGsLvK29AqIb3iSnoxOVPD79/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQ4w2Z4z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DMf0w023083
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=vcrgCoHvDklPk
	5gHhGY6i/mP6evg2YPtp7ZAAPbqzpA=; b=VQ4w2Z4z7r1knXHnSNq0/k5U1ovtQ
	K4o3su2adoG5EWR1JmrnogHE2ZlTyyd3EpNpouNw+X/soxxdsL76g0t2TRmuAScN
	ONMTfWXRQICggQgW9a/pcP7fBteu7yo0qlc0Bupb1ov/IVFTWeuCF2guvntVs6cj
	n9vH+boa6TekDkoKx2nrEkOeCkGa+sRlnEAN0o+d+iK3a08+yX9nlh6fQgY1OfmS
	2fTHMFUyCWhaOFfy1DCPQKqd08VDn2rjI4JmeI2Nl9fzQYV1fjTRK7kbJy+Lhhzp
	LP6FAhje3j9x0rBO0Obn3SCUTaGAG/cDenCQJtDYflq4zEwBEi025GK1w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk0292e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476IKik8018818
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40sxvu5kmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbDQv21299790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E355805C;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E85D58071;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 3/7] ibmvnic: Reduce memcpys in tx descriptor generation
Date: Tue,  6 Aug 2024 14:37:02 -0500
Message-ID: <20240806193706.998148-4-nnac123@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: xQY5tWL-gw_wU6qp57LCmlAC5D9BpBlt
X-Proofpoint-GUID: xQY5tWL-gw_wU6qp57LCmlAC5D9BpBlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=526
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060137

Previously when creating the header descriptors, the driver would:
1. allocate a temporary buffer on the stack (in build_hdr_descs_arr)
2. memcpy the header info into the temporary buffer (in build_hdr_data)
3. memcpy the temp buffer into a local variable (in create_hdr_descs)
4. copy the local variable into the return buffer (in create_hdr_descs)

Since, there is no opportunity for errors during this process, the temp
buffer is not needed and work can be done on the return buffer directly.

Repurpose build_hdr_data() to only calculate the header lengths. Rename
it to get_hdr_lens().
Edit create_hdr_descs() to read from the skb directly and copy directly
into the returned useful buffer.

The process now involves less memory and write operations while
also being more readable.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 80 +++++++++++++-----------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7d552d4bbe15..4fe2c8c17b05 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2150,46 +2150,38 @@ static int ibmvnic_close(struct net_device *netdev)
  * Builds a buffer containing these headers.  Saves individual header
  * lengths and total buffer length to be used to build descriptors.
  */
-static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
-			  int *hdr_len, u8 *hdr_data)
+static int get_hdr_lens(u8 hdr_field, struct sk_buff *skb,
+			int *hdr_len)
 {
 	int len = 0;
-	u8 *hdr;
 
 
-	if (skb->protocol == htons(ETH_P_IP)) {
-		if (ip_hdr(skb)->protocol == IPPROTO_TCP)
-			hdr_len[2] = tcp_hdrlen(skb);
-		else if (ip_hdr(skb)->protocol == IPPROTO_UDP)
-			hdr_len[2] = sizeof(struct udphdr);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		if (ipv6_hdr(skb)->nexthdr == IPPROTO_TCP)
-			hdr_len[2] = tcp_hdrlen(skb);
-		else if (ipv6_hdr(skb)->nexthdr == IPPROTO_UDP)
-			hdr_len[2] = sizeof(struct udphdr);
-	}
-
 	if ((hdr_field >> 6) & 1) {
 		hdr_len[0] = skb_mac_header_len(skb);
-		hdr = skb_mac_header(skb);
-		memcpy(hdr_data, hdr, hdr_len[0]);
 		len += hdr_len[0];
 	}
 
 	if ((hdr_field >> 5) & 1) {
 		hdr_len[1] = skb_network_header_len(skb);
-		hdr = skb_network_header(skb);
-		memcpy(hdr_data + len, hdr, hdr_len[1]);
 		len += hdr_len[1];
 	}
 
-	if ((hdr_field >> 4) & 1) {
-		hdr = skb_transport_header(skb);
-		memcpy(hdr_data + len, hdr, hdr_len[2]);
-		len += hdr_len[2];
+	if (!((hdr_field >> 4) & 1))
+		return len;
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		if (ip_hdr(skb)->protocol == IPPROTO_TCP)
+			hdr_len[2] = tcp_hdrlen(skb);
+		else if (ip_hdr(skb)->protocol == IPPROTO_UDP)
+			hdr_len[2] = sizeof(struct udphdr);
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		if (ipv6_hdr(skb)->nexthdr == IPPROTO_TCP)
+			hdr_len[2] = tcp_hdrlen(skb);
+		else if (ipv6_hdr(skb)->nexthdr == IPPROTO_UDP)
+			hdr_len[2] = sizeof(struct udphdr);
 	}
 
-	return len;
+	return len + hdr_len[2];
 }
 
 /**
@@ -2207,7 +2199,7 @@ static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
 static int create_hdr_descs(u8 hdr_field, u8 *hdr_data, int len, int *hdr_len,
 			    union sub_crq *scrq_arr)
 {
-	union sub_crq hdr_desc;
+	union sub_crq *hdr_desc;
 	int tmp_len = len;
 	int num_descs = 0;
 	u8 *data, *cur;
@@ -2216,28 +2208,26 @@ static int create_hdr_descs(u8 hdr_field, u8 *hdr_data, int len, int *hdr_len,
 	while (tmp_len > 0) {
 		cur = hdr_data + len - tmp_len;
 
-		memset(&hdr_desc, 0, sizeof(hdr_desc));
-		if (cur != hdr_data) {
-			data = hdr_desc.hdr_ext.data;
+		hdr_desc = &scrq_arr[num_descs];
+		if (num_descs) {
+			data = hdr_desc->hdr_ext.data;
 			tmp = tmp_len > 29 ? 29 : tmp_len;
-			hdr_desc.hdr_ext.first = IBMVNIC_CRQ_CMD;
-			hdr_desc.hdr_ext.type = IBMVNIC_HDR_EXT_DESC;
-			hdr_desc.hdr_ext.len = tmp;
+			hdr_desc->hdr_ext.first = IBMVNIC_CRQ_CMD;
+			hdr_desc->hdr_ext.type = IBMVNIC_HDR_EXT_DESC;
+			hdr_desc->hdr_ext.len = tmp;
 		} else {
-			data = hdr_desc.hdr.data;
+			data = hdr_desc->hdr.data;
 			tmp = tmp_len > 24 ? 24 : tmp_len;
-			hdr_desc.hdr.first = IBMVNIC_CRQ_CMD;
-			hdr_desc.hdr.type = IBMVNIC_HDR_DESC;
-			hdr_desc.hdr.len = tmp;
-			hdr_desc.hdr.l2_len = (u8)hdr_len[0];
-			hdr_desc.hdr.l3_len = cpu_to_be16((u16)hdr_len[1]);
-			hdr_desc.hdr.l4_len = (u8)hdr_len[2];
-			hdr_desc.hdr.flag = hdr_field << 1;
+			hdr_desc->hdr.first = IBMVNIC_CRQ_CMD;
+			hdr_desc->hdr.type = IBMVNIC_HDR_DESC;
+			hdr_desc->hdr.len = tmp;
+			hdr_desc->hdr.l2_len = (u8)hdr_len[0];
+			hdr_desc->hdr.l3_len = cpu_to_be16((u16)hdr_len[1]);
+			hdr_desc->hdr.l4_len = (u8)hdr_len[2];
+			hdr_desc->hdr.flag = hdr_field << 1;
 		}
 		memcpy(data, cur, tmp);
 		tmp_len -= tmp;
-		*scrq_arr = hdr_desc;
-		scrq_arr++;
 		num_descs++;
 	}
 
@@ -2260,13 +2250,11 @@ static void build_hdr_descs_arr(struct sk_buff *skb,
 				int *num_entries, u8 hdr_field)
 {
 	int hdr_len[3] = {0, 0, 0};
-	u8 hdr_data[140] = {0};
 	int tot_len;
 
-	tot_len = build_hdr_data(hdr_field, skb, hdr_len,
-				 hdr_data);
-	*num_entries += create_hdr_descs(hdr_field, hdr_data, tot_len, hdr_len,
-					 indir_arr + 1);
+	tot_len = get_hdr_lens(hdr_field, skb, hdr_len);
+	*num_entries += create_hdr_descs(hdr_field, skb_mac_header(skb),
+					 tot_len, hdr_len, indir_arr + 1);
 }
 
 static int ibmvnic_xmit_workarounds(struct sk_buff *skb,
-- 
2.43.0


