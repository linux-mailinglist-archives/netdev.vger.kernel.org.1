Return-Path: <netdev+bounces-130513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAAD98AB76
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439F8282F08
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE91990A7;
	Mon, 30 Sep 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W0ix6LOl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB238198E96
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719018; cv=none; b=S6UZRwb9WcRPIILPcB5FFfA+9WIM2wHyhLW1QbldWuKgdXK+BlUe0fM8RA1m+VjNLXfMv0ZuTG9HEWqG2pPVCZNNi+0wqEDrDck+P6ATkJ0fHhXmrhr/CAs1IKrxLOTzQnGCXUiS1IRekuZYmTXKbj/NYnW4iU4sOWR8mBr+85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719018; c=relaxed/simple;
	bh=eKo/A02EaTF15W6w2BCW6hV0IYdC0sQAiJ0vJbPEeH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpWgjsLQ4Ly0ZZ7u4d3K9vsijB/jU8CX8FJ3qaEVFHy3yDEKTIInGZB75qQssDbEUwl996vXh9IT3gxVUfcNQVctaBKf6w6TIYT9gOs7oqC53gOhettsEKNUeNLrqe9UhyX/66vmb20QxVCzuJZDgKK3UR/Mp/6jhrfputbpiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W0ix6LOl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBeouC025312
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=D5lY1Z/wx5TWA
	HnamX6pZiJXQ02Cwt+o3jfInqA3PIQ=; b=W0ix6LOlZIEkwXzmqZp9Owv1vtKe2
	zRndMnJi9XrQ4JNiu0QKz4G7WJEuknE7Bc3HqPOd2gDEu+kmOWg3KKy5jPuM5cjq
	w3oRkqiNS79haJZj7jK/IfMnHCRxQQkrZphk9HB+XGqSKEem0TbVoR3u6UX73ygh
	VmKt1MxEWUHuq90B3PslDwGfbSPS8Bz8usBhRjjTPsfp65SF51pVq848H8JF0mmb
	HnYT/mIp25cZmzTf0bxBRncsv0dzrFXL3Hlu2AQfLpX+chjhNvwxi1JTAI0XxxN2
	FfZWZRjuHpNX02Xj04raGG/8FjZ94zvCesNWxSivH3thc2JHHxBzbjKiw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87kk4j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:56:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UFoqsU002386
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:56:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu0ykw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:56:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UHupAY29360488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 17:56:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2956F58056;
	Mon, 30 Sep 2024 17:56:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD655803F;
	Mon, 30 Sep 2024 17:56:51 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.45.36])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 17:56:51 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net 2/2] ibmvnic: Inspect header requirements before using scrq direct
Date: Mon, 30 Sep 2024 12:56:35 -0500
Message-ID: <20240930175635.1670111-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930175635.1670111-1-nnac123@linux.ibm.com>
References: <20240930175635.1670111-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ox5rk0rLpYA8B1VNPQEXLuGasNTMBJTH
X-Proofpoint-ORIG-GUID: Ox5rk0rLpYA8B1VNPQEXLuGasNTMBJTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=719 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300126

Previously, the TX header requirement for standard frames was ignored.
This requirement is a bitstring sent from the VIOS which maps to the
type of header information needed during TX. If no header information,
is needed then send subcrq direct can be used (which can be more
performant).

This bitstring was previously ignored for standard packets (AKA non LSO,
non CSO) due to the belief that the bitstring was over-cautionary. It
turns out that there are some configurations where the backing device
does need header information for transmission of standard packets. If
the information is not supplied then this causes continuous "Adapter
error" transport events. Therefore, this bitstring should be respected
and observed before considering the use of send subcrq direct.

Fixes: 1c33e29245cc ("ibmvnic: Only record tx completed bytes once per handler")

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 53b309ddc63b..cca2ed6ad289 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2473,9 +2473,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* if we are going to send_subcrq_direct this then we need to
 	 * update the checksum before copying the data into ltb. Essentially
 	 * these packets force disable CSO so that we can guarantee that
-	 * FW does not need header info and we can send direct.
+	 * FW does not need header info and we can send direct. Also, vnic
+	 * server must be able to xmit standard packets without header data
 	 */
-	if (!skb_is_gso(skb) && !ind_bufp->index && !netdev_xmit_more()) {
+	if (*hdrs == 0 && !skb_is_gso(skb) &&
+	    !ind_bufp->index && !netdev_xmit_more()) {
 		use_scrq_send_direct = true;
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
 		    skb_checksum_help(skb))
-- 
2.43.5


