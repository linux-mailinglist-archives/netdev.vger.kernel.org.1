Return-Path: <netdev+bounces-116617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46794B1FC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46CB1F22EBD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A21487EB;
	Wed,  7 Aug 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dttbeZF/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32986149C54
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065506; cv=none; b=Li6KRlzPm91rJtgJA3iRhIHRRYQP8KbNZJuYxWVL2Xe8S6VvE0cdUMkC6zRCkcXt9S1l42oDutWue0Axav28wA7MbJpehTzfknI0TOljBN688g7KTprxHocl1vEHAaelmLKELShGOUBJuhVVVC+fFQUaGkI09SLSbQhZ2YnfAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065506; c=relaxed/simple;
	bh=X1x65+oVBjmFGkhTaaSIErUkd4o7w3bNA0msba57SfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tee3HYgBJPzcuSp2iaFkbXuUNk+MI5NRMa14XVrI7P3Oafs9YJaPH0Z70Mq/sudoHJyCBSLVdhGd0HnuNKXz06Lj6EkvcaZOeEAsbYBt5cBqfJF8ZIprPzn5uoZWC4Usm5pDW7F3RP8cgFTwJMAjhwb5kC+gLpcrUF5uKzyvZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dttbeZF/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772MlLa016630
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=lTehq2M4fiknY
	WzxmnpSnLFP7DVdBHCFtroGUYJ1hXA=; b=dttbeZF/uV4V1FCXUkia7CHKe3/KV
	82fnC5KrevGjIaeVLj1m9KRAmZJNnmT7GzefZkVJHkyCJXfHw1qZIyytu6k5LVT6
	fv5Lke9DLm9dZ/MGg25D4PnXVR/y0j28PF0QGsjES5WkKNcyz9GdkAsAirOU3baM
	q9+KyHyzE0DVHIZcPNSyYKWdVY49X7C+6L+mpKQVxw/aNld4aMh7wR8WbTor5G8u
	OGamXMQ6ja8X7gO5AQUVOo32lxzfVUmOe02gIRV/7zjqa7oVmerAiT1R1l6+SZ3b
	kDZypdThUutdRdbp0peWqNQjxrDWpcsAnMEC9Yd96PlwXBaZty7fWKSFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40urpub381-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477KG9Vb030242
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3aqb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIEtE18940644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA23158077;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE2F5807B;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 3/7] ibmvnic: Reduce memcpys in tx descriptor generation
Date: Wed,  7 Aug 2024 16:18:05 -0500
Message-ID: <20240807211809.1259563-4-nnac123@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 9xEx2Mh7-wiN3d9bkuTa81yabAsIr_OG
X-Proofpoint-GUID: 9xEx2Mh7-wiN3d9bkuTa81yabAsIr_OG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=654 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070146

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
 drivers/net/ethernet/ibm/ibmvnic.c | 89 ++++++++++++++----------------
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7d552d4bbe15..58a517ecbda3 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2140,56 +2140,49 @@ static int ibmvnic_close(struct net_device *netdev)
 }
 
 /**
- * build_hdr_data - creates L2/L3/L4 header data buffer
+ * get_hdr_lens - fills list of L2/L3/L4 hdr lens
  * @hdr_field: bitfield determining needed headers
  * @skb: socket buffer
- * @hdr_len: array of header lengths
- * @hdr_data: buffer to write the header to
+ * @hdr_len: array of header lengths to be filled
  *
  * Reads hdr_field to determine which headers are needed by firmware.
  * Builds a buffer containing these headers.  Saves individual header
  * lengths and total buffer length to be used to build descriptors.
+ *
+ * Return: total len of all headers
  */
-static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
-			  int *hdr_len, u8 *hdr_data)
+static int get_hdr_lens(u8 hdr_field, struct sk_buff *skb,
+			int *hdr_len)
 {
 	int len = 0;
-	u8 *hdr;
-
 
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
@@ -2202,12 +2195,14 @@ static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
  *
  * Creates header and, if needed, header extension descriptors and
  * places them in a descriptor array, scrq_arr
+ *
+ * Return: Number of header descs
  */
 
 static int create_hdr_descs(u8 hdr_field, u8 *hdr_data, int len, int *hdr_len,
 			    union sub_crq *scrq_arr)
 {
-	union sub_crq hdr_desc;
+	union sub_crq *hdr_desc;
 	int tmp_len = len;
 	int num_descs = 0;
 	u8 *data, *cur;
@@ -2216,28 +2211,26 @@ static int create_hdr_descs(u8 hdr_field, u8 *hdr_data, int len, int *hdr_len,
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
 
@@ -2260,13 +2253,11 @@ static void build_hdr_descs_arr(struct sk_buff *skb,
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


