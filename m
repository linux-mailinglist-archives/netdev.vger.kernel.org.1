Return-Path: <netdev+bounces-117035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24294C731
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A4F1F23BB1
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42C15EFB6;
	Thu,  8 Aug 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RJVLQ2F6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125B157466
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158468; cv=none; b=gGuhSRfOfFXs01hMTE95DO1YAn7a9B5o3DJ4TaqGKmQ3YCiCDdyper+93dAMbcmuVluXrPvmyGTEv+156NtuqgfMhPF/adMCn/EsRx2r1xGRGsehqy6BUvXOwIiXf5R3qSsTfMvoCthmMzZYd9fagFhPPQiCjKpbAdVriOo3zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158468; c=relaxed/simple;
	bh=bhXcunquBL+0cxQBjEayHnaMyaPypf41KcBs7iHOs1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ppQO6MPJYotAPSrYhu+n1FgRf+ZFQWZA9NLQ7+iUq/a84SF4dPdklXqUCuY7LtOEHgI+PVqvvhtHdxP1p77qeUy87BY6pyBePNWv+G+2MHM3avjGumUbfpDmX2oiuOPPYTZ5t1PORcyeDJFNUi3bmgeqvYow/Rl56nBS8NiWC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RJVLQ2F6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AgTXW018279;
	Thu, 8 Aug 2024 23:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ewh9dBUYD5muld04wk5BggR34Yj1suA07Na
	TpGhvY+w=; b=RJVLQ2F6qTWWP896uHHjyoKf5SeQzbr3YedfdU90EhoRJoDskdB
	tIR23DJ26jLf0hwF7+1nln1puOU6X00kymL7UHuOgaX9beUwQA8Z3bihWLbk/8fG
	/56jebqA09truw61CVE9hb52pij7RJ2vTlJ17ZXUopTdP0qz4aW8GZRmn4fGwrj+
	eNzYNVHVgfIkxPdNI+BjqwumoiNm7p1x3if8Qd4nm9FGzb/VLfqUzxC9hxsIF608
	DL2bugDfMvM7OSAoGM4S4Q0U4xsAlfvv9cJQhtDEg+3kpUSVtNkGFlmLNseMb8Ky
	Fan0UCm6c0Ln4e3LCQ6jgmvPaScOcrgjI3w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vvgm1sw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 23:07:36 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 478N4L6e024381;
	Thu, 8 Aug 2024 23:07:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 40vfkht7x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 23:07:35 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 478N7Ymq027522;
	Thu, 8 Aug 2024 23:07:34 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 478N7YbU027521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 23:07:34 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id AF6D3657; Thu,  8 Aug 2024 16:07:34 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
To: edumazet@google.com, soheil@google.com, ncardwell@google.com,
        yyd@google.com, ycheng@google.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, dsahern@kernel.org,
        pabeni@redhat.com
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>
Subject: [PATCH net] tcp: Update window clamping condition
Date: Thu,  8 Aug 2024 16:06:40 -0700
Message-Id: <20240808230640.1384785-1-quic_subashab@quicinc.com>
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
X-Proofpoint-ORIG-GUID: N4guMgw5uIK8O9w90ZtbEppwdUKfR0_1
X-Proofpoint-GUID: N4guMgw5uIK8O9w90ZtbEppwdUKfR0_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_23,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080165

This patch is based on the discussions between Neal Cardwell and
Eric Dumazet in the link
https://lore.kernel.org/netdev/20240726204105.1466841-1-quic_subashab@quicinc.com/

It was correctly pointed out that tp->window_clamp would not be
updated in cases where net.ipv4.tcp_moderate_rcvbuf=0 or if
(copied <= tp->rcvq_space.space). While it is expected for most
setups to leave the sysctl enabled, the latter condition may
not end up hitting depending on the TCP receive queue size and
the pattern of arriving data.

The updated check should be hit only on initial MSS update from
TCP_MIN_MSS to measured MSS value and subsequently if there was
an update to a larger value.

Fixes: 05f76b2d634e ("tcp: Adjust clamping window for applications specifying SO_RCVBUF")
Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
---
 net/ipv4/tcp_input.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e2b9583ed96a..e37488d3453f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -238,9 +238,14 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		 */
 		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
 			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
+			u8 old_ratio = tcp_sk(sk)->scaling_ratio;
 
 			do_div(val, skb->truesize);
 			tcp_sk(sk)->scaling_ratio = val ? val : 1;
+
+			if (old_ratio != tcp_sk(sk)->scaling_ratio)
+				WRITE_ONCE(tcp_sk(sk)->window_clamp,
+					   tcp_win_from_space(sk, sk->sk_rcvbuf));
 		}
 		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
 					       tcp_sk(sk)->advmss);
@@ -754,7 +759,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 	 * <prev RTT . ><current RTT .. ><next RTT .... >
 	 */
 
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)) {
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
+	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
 		u64 rcvwin, grow;
 		int rcvbuf;
 
@@ -770,22 +776,12 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 		rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-		if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-			if (rcvbuf > sk->sk_rcvbuf) {
-				WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
-
-				/* Make the window clamp follow along.  */
-				WRITE_ONCE(tp->window_clamp,
-					   tcp_win_from_space(sk, rcvbuf));
-			}
-		} else {
-			/* Make the window clamp follow along while being bounded
-			 * by SO_RCVBUF.
-			 */
-			int clamp = tcp_win_from_space(sk, min(rcvbuf, sk->sk_rcvbuf));
+		if (rcvbuf > sk->sk_rcvbuf) {
+			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
-			if (clamp > tp->window_clamp)
-				WRITE_ONCE(tp->window_clamp, clamp);
+			/* Make the window clamp follow along.  */
+			WRITE_ONCE(tp->window_clamp,
+				   tcp_win_from_space(sk, rcvbuf));
 		}
 	}
 	tp->rcvq_space.space = copied;
-- 
2.34.1


