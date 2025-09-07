Return-Path: <netdev+bounces-220687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03002B47CFF
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 21:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB4E7AC9B6
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FFA1E51FB;
	Sun,  7 Sep 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KC+tzviV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47410F1
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757272649; cv=none; b=HYqXLm+tBw/8F7OvvfvU1Eq+ZLPJZQfghe9eGDdrCUbxZUmvm1aCtmUk+QxgbMZ4f2f9JLqWeWAD2yIiavuYhpzQaj5C/NZwj9e9IUZtEUFN0FX2+Q0rxezIh2MxnG3MgB8B6w6X8T70Jnd0vlpZmAW+hXnsSVdVLUAyp/PoDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757272649; c=relaxed/simple;
	bh=gpBuxK39NzOcvo9c+MaD0j8Eq4D4uRZ4gDDF/A9ocv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBFbkHtAdRJyIvl3gAuodzl3SSoWKNbBm2ROnKMzo28XMFx/KN0WqTAtQPSfc9hXmTqIRI8LQYrX7rw6nVNS4iPe6vxAWsZyFfRD+NgQc9Lo4VZVTN2hlFODpJhXv136IgErR/e++cYMNMRCpH1FQ9i77GuTYZv7PNEn8zHvn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KC+tzviV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Ipkxp018048;
	Sun, 7 Sep 2025 19:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=QO5mYKWCuP2Z4nlNg+fwG5rDmiw1E
	Umd8k1heDcVMUY=; b=KC+tzviVNk5nKCYVedtSyXrc69eQ2vNhLDTkctXPddDkq
	jIRrhwS+tJVXBayf08GefTA8PyOlFdzO9+HUiw4l5qFV0aqY41kiE6dGPFNn7I6C
	BG4ERX4sj7NM9WPWeN5JBQtAc/WCsLfDawPKnkVYR5aENY+ZaDcJtXlzKVETI6vR
	4CIR/4JSGDawZIqKo/X6Qy5Q8IdbAm60DUbxWYZSscBqTGFTOVRokTkQzv/Hupz8
	M4hl1uoLCPymhaGHtPwqJZQi5d+xCKplLanYwbtYCB26IiaCITqC/2NmND+a1eVj
	Jy34mxnvVk6/QR4ixGXMWed0jRD4BpGBvMZjr/dVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491fnug0c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 19:17:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 587EjU3s032803;
	Sun, 7 Sep 2025 19:17:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8ch6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 19:17:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 587JH2MO006051;
	Sun, 7 Sep 2025 19:17:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bd8ch6b-1;
	Sun, 07 Sep 2025 19:17:02 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ipv6: udp: fix typos in comments
Date: Sun,  7 Sep 2025 12:16:52 -0700
Message-ID: <20250907191659.3610353-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509070200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDE5NiBTYWx0ZWRfX7bv6WO3J/5cZ
 EPki8g4PfCNbfDIiB9RceIZ/lPms7vlvDtDqc1cg9hiuzUFeAueEJNzR1tQJR46E+BWQ2WDWtYY
 T4GHyKdYQzCxvohS2+kPoQJm4BaqNWpstzmKJaZSb1GR5/XwlJUSOACE2Z2PmVogx/FF0GqET8W
 iMDN/cxiiRmJtRq/7O1vXXC1cR8tX6aMKB/ePMXxqq4qEfYwpgxteEaqbEgICgjLC2tzTj+7QBU
 B1AyUIQd5dLDXTY/FssACLu0shiMf5yD5b7j0sWJGNj5jsTQIOz2dTqRA76lx3FTZE+a1El0MZL
 kVFMKeLFGl6fZmBjOegfXI5GfAgmBgiPjqxm+V+O7pcv00nQxlg5SXwjlXtaUoY87jHJLi3CJnT
 4fUICckp
X-Proofpoint-GUID: g_w-EXCY4RVf5MatSwtDvn2wHUcGzrBK
X-Proofpoint-ORIG-GUID: g_w-EXCY4RVf5MatSwtDvn2wHUcGzrBK
X-Authority-Analysis: v=2.4 cv=LdI86ifi c=1 sm=1 tr=0 ts=68bdda30 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=1S7usWkXNqeztYIjQa0A:9

Correct typos in ipv6/udp.c comments:
"execeeds" -> "exceeds"
"tacking care" -> "taking care"

No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/ipv6/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index a35ee6d693a8..74569969f9a7 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -449,7 +449,7 @@ struct sock *udp6_lib_lookup(const struct net *net, const struct in6_addr *saddr
 EXPORT_SYMBOL_GPL(udp6_lib_lookup);
 #endif
 
-/* do not use the scratch area len for jumbogram: their length execeeds the
+/* do not use the scratch area len for jumbogram: their length exceeds the
  * scratch area space; note that the IP6CB flags is still in the first
  * cacheline, so checking for jumbograms is cheap
  */
@@ -1048,7 +1048,7 @@ static void udp6_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 		sk->sk_rx_dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 }
 
-/* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
+/* wrapper for udp_queue_rcv_skb taking care of csum conversion and
  * return code conversion for ip layer consumption
  */
 static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
-- 
2.50.1


