Return-Path: <netdev+bounces-121216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776395C385
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28001F23BA0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1126AC6;
	Fri, 23 Aug 2024 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="W1BXCQw1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B4171C2;
	Fri, 23 Aug 2024 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382118; cv=none; b=t5Shuvhyep8frLFOHXBZA0ckmcz77JJGnLsQoBOv7TPc4cvkP7gpifnztOIk5KgWBzmALSW5IoASC1ak7lQPDkdQIgzpIBScAxS+NlrX+M8Q9XZNob+XpMLPewz3dUsjr3ah6Vh2BX4x5D/pZEQB3+K3Ntx0GbPITxZkkRJL+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382118; c=relaxed/simple;
	bh=WPCHBig5DRinRvTaXXZ9Vpk5zJV2wFCTWtXfZMM8JNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcbFpgVkahxvwE6+JLO/ZHgkAuhOLeNtMi4ao6YvekFHNSQuuimNXRf9vCXHY13eWQ6wb90JXutxHkcYyhof/NGzSMZY82DwMES6Rgs5Y7MgkoKIogPs6mG3NmBVmWI9bxSEOj3dawgkon1FbIQskXJuMWJlH4Y7kKxmUnK/YoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=W1BXCQw1; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 47MAaidU030965;
	Fri, 23 Aug 2024 03:14:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=7WWIS+/Dp506iu4vAOaQV51OIFRNeLyO4MDm/OaBe1E=; b=W1BXCQw1RsRN
	6vTmtS1HgstLk4TKn3DRfiUx73rPsmv+oXCQEk0e9c17Cq+E691p0gRqBFrPiNXd
	hZZuZURr29VHM2YNuCrGIFQswCCnDZ1eNBZBDvu1PBXUUCCCp6v1j8QMxAIWmf4C
	l1T9aHXNdfo+k0QSoHlIifmKZLdQqep5/s46tLQpgmxU3SuFoiit3M9rDcLBPLdT
	lDJHK6PyfptLtvfyZHRgTTIB/KcCMkEY0KfpsuUlMVUOmn4jAYw3AtC7pQaf5J0h
	ggVQjSuTJzErblaXE1Ba+V95wC3X5/e5fIMsxfeXmLCpnKItmicEWQBXOWxgaRqC
	R1WD5ILCPA==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4149pgffk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 03:14:52 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 47MN8ZHA010713;
	Thu, 22 Aug 2024 22:14:51 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.27])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 412q6y1mds-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 22:14:51 -0400
Received: from usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) by
 usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 22:14:47 -0400
Received: from bos-lhvx56.bos01.corp.akamai.com (172.28.41.223) by
 usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) with Microsoft SMTP Server
 id 15.2.1544.11 via Frontend Transport; Thu, 22 Aug 2024 22:14:47 -0400
Received: by bos-lhvx56.bos01.corp.akamai.com (Postfix, from userid 30754)
	id B39DB15F534; Thu, 22 Aug 2024 22:14:47 -0400 (EDT)
From: Josh Hunt <johunt@akamai.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <johunt@akamai.com>
Subject: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
Date: Thu, 22 Aug 2024 22:13:33 -0400
Message-ID: <20240823021333.1252272-2-johunt@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823021333.1252272-1-johunt@akamai.com>
References: <20240823021333.1252272-1-johunt@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_01,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=994
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230011
X-Proofpoint-GUID: xo6xvYrI72Cq-rv61-tLMQlC2RbQ7dLL
X-Proofpoint-ORIG-GUID: xo6xvYrI72Cq-rv61-tLMQlC2RbQ7dLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_01,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxlogscore=826 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230013

There have been multiple occassions where we have crashed in this path
because packets_out suggested there were packets on the write or retransmit
queues, but in fact there weren't leading to a NULL skb being dereferenced.
While we should fix that root cause we should also just make sure the skb
is not NULL before dereferencing it. Also add a warn once here to capture
some information if/when the problem case is hit again.

Signed-off-by: Josh Hunt <johunt@akamai.com>
---
 include/net/tcp.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..19ea6ed87880 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2433,10 +2433,19 @@ void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_state *plb);
 static inline s64 tcp_rto_delta_us(const struct sock *sk)
 {
 	const struct sk_buff *skb = tcp_rtx_queue_head(sk);
-	u32 rto = inet_csk(sk)->icsk_rto;
-	u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + jiffies_to_usecs(rto);
+	u32 rto = jiffies_to_usecs(inet_csk(sk)->icsk_rto);
+
+	if (likely(skb)) {
+		u64 rto_time_stamp_us = tcp_skb_timestamp_us(skb) + rto;
+
+		return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
+	} else {
+		WARN_ONCE(1,
+			"rtx queue emtpy: inflight %u tlp_high_seq %u state %u\n",
+			tcp_sk(sk)->packets_out, tcp_sk(sk)->tlp_high_seq, sk->sk_state);
+		return rto;
+	}
 
-	return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
 }
 
 /*
-- 
2.34.1


