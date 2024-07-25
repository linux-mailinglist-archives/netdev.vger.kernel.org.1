Return-Path: <netdev+bounces-113097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF48C93CA5F
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6291F227D4
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DD13D893;
	Thu, 25 Jul 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gUSAI+Cz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52912D299
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944568; cv=none; b=NruI66X+2AT2XiW9przwkKOSDOxnY5sGFndmRaRreyaSZ0qfMmIANjiLiTRM7GsL3gowOT9oUf8NNGX1hT6Qp9az+qVCKFtUxQhaWZdgSYeTKJhFZdPUAWUghzGGAC8N6jH7FpTAH52YCNZxpLQjPccp07nOEh9VLtqm7PNr8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944568; c=relaxed/simple;
	bh=/buEbdUx1kZDQ027WGqU1XyDI7WoQRS9gOpneLUWCy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rl1WnmSrKYDMoeaAc3JuiDfmvxnBD+FOn3BeqT3JV1KjsfaIyl4Grb8RtXb0wY6T/8x1fkx9mY7fzCL0q2LoHC9SuVElzPZBGgKAOZZXvIIMWnbOztzfUZwdfkXILXtodhierEpQayBp5NiqushIn2ujCE64UICFltUJHhptyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gUSAI+Cz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PCpegL014738;
	Thu, 25 Jul 2024 21:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jAKAIQPMnMh6pj+7pvZzWK9i3+7L8fMrNVY
	nVUiE08E=; b=gUSAI+CzCFMvoUiTzwQcm7AXPW6YXG2BavO0cSdjHzKXdD6iu4K
	5b7B+87I9wL/D2DIEK7NnvEAbgvz2oQY2Z1XL1E/G+Oc+ikuOoPxWM0Ln8SddPDD
	54/ZIIGT93C247k09S+W5Tc/LM9XuC5Axn3HmHj75CasGeMFWVESNZZg3fIc30U3
	/x6UkA7e+RQxmSwFjDmBv5JXhcmsOmx9Ghqt+jG0YUmWFI+0B4aEDoL9XeGud2c9
	C2IinTxKNuKG9J8u2ks+fspA+IE6PeVs1/Y5QNb8Y7OiQTLU/crWhPaECmskV6jX
	Lo3YuuRcpRYHqwOf8xisXE+722TdYcaTu6Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k40ym0sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 21:55:51 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46PLton6001051;
	Thu, 25 Jul 2024 21:55:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 40km31n9u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 21:55:50 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46PLtnra001043;
	Thu, 25 Jul 2024 21:55:50 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 46PLtnH3001040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 21:55:49 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id A7F344AB; Thu, 25 Jul 2024 14:55:49 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
To: edumazet@google.com, soheil@google.com, ncardwell@google.com,
        yyd@google.com, ycheng@google.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>
Subject: [PATCH net] tcp: Adjust clamping window for applications specifying SO_RCVBUF
Date: Thu, 25 Jul 2024 14:55:42 -0700
Message-Id: <20240725215542.894348-1-quic_subashab@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vwIfv6Ej4_OZMMrXaB_iyAQQWE2I_YFp
X-Proofpoint-ORIG-GUID: vwIfv6Ej4_OZMMrXaB_iyAQQWE2I_YFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_22,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250151

tp->scaling_ratio is not updated based on skb->len/skb->truesize once
SO_RCVBUF is set leading to the maximum window scaling to be 25% of
rcvbuf after
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
and 50% of rcvbuf after
commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
50% tries to emulate the behavior of older kernels using
sysctl_tcp_adv_win_scale with default value.

Systems which were using a different values of sysctl_tcp_adv_win_scale
in older kernels ended up seeing reduced download speeds in certain
cases as covered in https://lists.openwall.net/netdev/2024/05/15/13
While the sysctl scheme is no longer acceptable, the value of 50% is
a bit conservative when the skb->len/skb->truesize ratio is later
determined to be ~0.66.

Applications not specifying SO_RCVBUF update the window scaling and
the receiver buffer every time data is copied to userspace. This
computation is now used for applications setting SO_RCVBUF to update
the maximum window scaling while ensuring that the receive buffer
is within the application specified limit.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
---
 net/ipv4/tcp_input.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 454362e359da..c8fb029a15a4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -754,8 +754,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
 	 * <prev RTT . ><current RTT .. ><next RTT .... >
 	 */
 
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
-	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)) {
 		u64 rcvwin, grow;
 		int rcvbuf;
 
@@ -771,12 +770,24 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 		rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-		if (rcvbuf > sk->sk_rcvbuf) {
-			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+		if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
+			if (rcvbuf > sk->sk_rcvbuf) {
+				WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
-			/* Make the window clamp follow along.  */
-			WRITE_ONCE(tp->window_clamp,
-				   tcp_win_from_space(sk, rcvbuf));
+				/* Make the window clamp follow along.  */
+				WRITE_ONCE(tp->window_clamp,
+					   tcp_win_from_space(sk, rcvbuf));
+			}
+		} else {
+			/* Make the window clamp follow along while being bounded
+			 * by SO_RCVBUF.
+			 */
+			if (rcvbuf <= sk->sk_rcvbuf) {
+				int clamp = tcp_win_from_space(sk, rcvbuf);
+
+				if (clamp > tp->window_clamp)
+					WRITE_ONCE(tp->window_clamp, clamp);
+			}
 		}
 	}
 	tp->rcvq_space.space = copied;
-- 
2.34.1


