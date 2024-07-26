Return-Path: <netdev+bounces-113305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A3993D9ED
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB331C22147
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683B149C41;
	Fri, 26 Jul 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SSFCuIhc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071818641
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026486; cv=none; b=bpRCvJfHotAVWtW8iVxeTQ3KMuk7492RT1CPW2/kmB8CDtrSW0+YQ9gg2ULsVTuWy5ccveTH5MdsCHXuRJ3qCnoussA0prcG/VgPPPKa1T7wfcnN1p/ImJR/grEwoZOyZyAvlxIbCaDOBHOiApy+Z/4JWKASVZF+dTEwHCnqntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026486; c=relaxed/simple;
	bh=Xu8XGUMdaHDgeQaKtIvNfP+89TJiirX2byjvvfiXrZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=txQOE3tJe4exPtQTlIbsdjlQERvAKDzLf5NPlnwjNPTYBl0/UgoB4DY/nBxuAfAloykzDqNnch+wZPO7JwF2QJQx6VHt5L89wq1dvCxRXAMf4DvlYjKyLeBrv3FwdzLyUTzNSIV3/wCQ/E/P806o+OwwsDQ2rbWf0LKD+6n8Y7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SSFCuIhc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBtkHB021699;
	Fri, 26 Jul 2024 20:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5B0ZsC6DzjD5EZvnG7aoqKzluxFOBZgrrV8
	fTysh+O8=; b=SSFCuIhcXi/lWDTS6mzV+UNyznO6nmSlkhMoIehrCpSm1+jDDf4
	d0p86x5yQaYv3OSRKDKki8pxX+RXkZUWB1a0vH4CQooKVXcsKujhne6s3Fg8Aoid
	/TWXTo4z6GZnO3WkyiRqpfkXWKVMcL2BfCTC4UmVnUL6cppZHpqGmnuaHYvks+kQ
	W9DSb26mzRxLq/nO4UU7oNn9MarfmO53DOAX2jkCOL14s5fBVCjAiLu7Ew3DpxqI
	PKta4FJWF0ZJgU2D+ZbBlwQYh30uKGGCAv0r4Fdq0WgtsEjpeIIrijgttUNVx3s9
	zLnyweP86z3yEO9izA6eI+4Jx+hGWhluQlA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1sv2ewv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 20:41:15 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46QKbVbG016816;
	Fri, 26 Jul 2024 20:41:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 40mdnqag3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 20:41:14 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46QKbViB016807;
	Fri, 26 Jul 2024 20:41:14 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 46QKfD43027970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 20:41:14 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id B463C64A; Fri, 26 Jul 2024 13:41:13 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
To: edumazet@google.com, soheil@google.com, ncardwell@google.com,
        yyd@google.com, ycheng@google.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, dsahern@kernel.org,
        pabeni@redhat.com
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        Sean Tranchetti <quic_stranche@quicinc.com>
Subject: [PATCH net v2] tcp: Adjust clamping window for applications specifying SO_RCVBUF
Date: Fri, 26 Jul 2024 13:41:05 -0700
Message-Id: <20240726204105.1466841-1-quic_subashab@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8pxACz_9E3G-T1sog6MpZjpdPo2nFyVs
X-Proofpoint-GUID: 8pxACz_9E3G-T1sog6MpZjpdPo2nFyVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260139

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
v1 -> v2
  Update the condition for SO_RCVBUF window_clamp updates to always
  monitor the current rcvbuf value as suggested by Eric.

 net/ipv4/tcp_input.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 454362e359da..e2b9583ed96a 100644
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
 
@@ -771,12 +770,22 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
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
+			int clamp = tcp_win_from_space(sk, min(rcvbuf, sk->sk_rcvbuf));
+
+			if (clamp > tp->window_clamp)
+				WRITE_ONCE(tp->window_clamp, clamp);
 		}
 	}
 	tp->rcvq_space.space = copied;
-- 
2.34.1


