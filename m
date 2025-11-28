Return-Path: <netdev+bounces-242524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8ABC91515
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF3B3AA88B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2842FD7C3;
	Fri, 28 Nov 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KKhtqKl7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0A2FD668
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320026; cv=none; b=hXCJn3NcDXmMveqpbKh73HMx0yJFQ6OhewaYW3KBbporhvqgl0NGOSjB/v2uGs9kVtn60IVOt+dcepmMPHAUINhNojb37pe5IU+DW7WVmWk13cl7Fnkrjd5alZqd1i9bCxpNGR0xk0wSe3/CTiqtUat6pF4V7HpUooEOnK0CPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320026; c=relaxed/simple;
	bh=OBSmjV+7meHP1rGMO9tDjTk4DyTM4GEeiQCa9XdkFe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6aw7YD4PkbH80f0zs+rYVIhuYx/FbK39meno8bfXGMm+X6qdLO5eX4BhaMPTSmM8/+9f3Zin96xOtDNvqD1AYrMlNKgJDiEUBB2qpKCQI/u6grnRDMIWTfqxrhk4uIIfKu6Ksw289Tm769TuTGvEqkYiSzhGmX+SqYaPcKZD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KKhtqKl7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7uQoq2925758;
	Fri, 28 Nov 2025 08:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=kKDgTC21y3fyx/3WZzRX19j1BCz5K
	ppprJg1KGFen1c=; b=KKhtqKl7OjXmiL8B1m+0sLlmT6kdzqlPhpzpymsrxrDrY
	fV0mqTun9rsmEkZFEdNK1S9JGQZn5VkxCUug6ntUW0qHw+/ZeIpuqTug06hXn1KX
	IZejntDrpy/8qh7+XELKV9b8nZ0ZrH2NWyKBAaa/nr2pO+Cu7L7zWwbk5XSiHteo
	3tPjDXwDKmXCmHzMVglebspTzSSWWVFnfOWcdiwEXet437Voju+mtND0SzCypfkH
	URPlAJ/YxsljO9wewqgVMjqCfEwNMnGO3N1IvXoUcIBZfb41xyEvwGR4myDzsBnP
	PNf3NdIaviE53c7xIiLTGzBpwXGmlGTKRqA1/crXg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aq3s28a8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:53:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7pIrK019718;
	Fri, 28 Nov 2025 08:53:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3md1w4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:53:31 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AS8rUaw026427;
	Fri, 28 Nov 2025 08:53:30 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3md1w43-1;
	Fri, 28 Nov 2025 08:53:30 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] l2tp: correct debugfs label for tunnel tx stats
Date: Fri, 28 Nov 2025 00:52:57 -0800
Message-ID: <20251128085300.3377210-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511280064
X-Proofpoint-ORIG-GUID: vY10kv64-KCeDhbUzZJOuS2JDUurPjxw
X-Proofpoint-GUID: vY10kv64-KCeDhbUzZJOuS2JDUurPjxw
X-Authority-Analysis: v=2.4 cv=SLJPlevH c=1 sm=1 tr=0 ts=6929630c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Lxq-UBtxJWYXIj6hXk0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA2NCBTYWx0ZWRfX8cLMUoBeyIKk
 u7yjtFhKltp+2SAkLGQbS76hlHIgTUG8KM75iMMxfSoyerCUh36YwC7QmhElmjzURX/Xfqjj20X
 bbsIk/HznKB2IXo9RKAeBx2KIKwUKnuZ4BvHLOgFs0ROoa0rLwVHhYfKlzWGbM0sQ6c2ha1hT6F
 B+8YSTP0dLySfY/XZAlIeGKwyYpWpBj/liHoOkrg1Ll6Qx/PNcDU+ZuO6K8okrDATrfjSsK74W6
 kVotA+gwhFQagdpNKEXMBzyD3xwpdBdrlSG/zw9dAVSYIu+nxOZUnroGHd/zyTQDChAV4GAbizt
 QSBHCESN3pMFwcvmXmEM4bBaUBgyss9iWVCp7s6HfrfQm0Olkd7YqaMbLb3YBPh/d/lRwDl7B4M
 cVfQrdBdWWC4g7eDzC52RsbSapgX0g==

l2tp_dfs_seq_tunnel_show prints two groups of tunnel statistics. The
first group reports transmit counters, but the code labels it as rx.
Set the label to "tx" so the debugfs output reflects the actual meaning.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/l2tp/l2tp_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 2d0c8275a3a8..5cfaab7d0890 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -163,7 +163,7 @@ static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)
 	seq_printf(m, " %d sessions, refcnt %d/%d\n", session_count,
 		   tunnel->sock ? refcount_read(&tunnel->sock->sk_refcnt) : 0,
 		   refcount_read(&tunnel->ref_count));
-	seq_printf(m, " %08x rx %ld/%ld/%ld rx %ld/%ld/%ld\n",
+	seq_printf(m, " %08x tx %ld/%ld/%ld rx %ld/%ld/%ld\n",
 		   0,
 		   atomic_long_read(&tunnel->stats.tx_packets),
 		   atomic_long_read(&tunnel->stats.tx_bytes),
-- 
2.50.1


