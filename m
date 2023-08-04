Return-Path: <netdev+bounces-24511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A87706AC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0E21C21923
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA81AA7E;
	Fri,  4 Aug 2023 17:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8A1AA7D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:06:37 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA41994;
	Fri,  4 Aug 2023 10:06:36 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374H1log024495;
	Fri, 4 Aug 2023 17:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jLXPXLJNvTPzxp+oPtL7ppWGFWCzpH+suUNWGoXnwVM=;
 b=APbhzFQVwC790ZSMha+Aw68A78tF7JNdtFgsogVggAjm9N17JmjM05l0Tn6/XXzt/4aq
 +9E9r4WcPdBOkaVLOUfJi8UqlIAdVJENGBC4TEILPwROmoyRYB+nBYxquXHPcOZoasmK
 xki2awm/B8iOnB7A1K35DjDGDe4Q1XIl6fLVJR1Lmwm/AJfDaqoP1EOd0cWKDtQA3rLN
 Uj6PluLSDwzr/ZlvAc3kt+dBluva9wUhKbcX794oSbVpgBtzbTgxZYaQWShWthw2H6o4
 T1DX74NvCmwZLSCbYnQ8859VMlNOBNmgRYgaKMUddvu04NfPc2vvWDOTP38moxCAoEY9 wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s95c382q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 17:06:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374H2ciC026193;
	Fri, 4 Aug 2023 17:06:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s95c382pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 17:06:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374Fisbe015788;
	Fri, 4 Aug 2023 17:06:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kn77h3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 17:06:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374H6QOq22086292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Aug 2023 17:06:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F415D2004B;
	Fri,  4 Aug 2023 17:06:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9815920043;
	Fri,  4 Aug 2023 17:06:25 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Aug 2023 17:06:25 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] net/smc: Use correct buffer sizes when switching between TCP and SMC
Date: Fri,  4 Aug 2023 19:06:24 +0200
Message-ID: <20230804170624.940883-3-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804170624.940883-1-gbayer@linux.ibm.com>
References: <20230804170624.940883-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7-B-c6JHmHu5uiZ6nfjwb-Ub6zI07CUH
X-Proofpoint-GUID: 23LZR7WwyfdU7dD__08UxHXHLgYgL4Vz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tuning of the effective buffer size through setsockopts was working for
SMC traffic only but not for TCP fall-back connections even before
commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and
make them tunable"). That change made it apparent that TCP fall-back
connections would use net.smc.[rw]mem as buffer size instead of
net.ipv4_tcp_[rw]mem.

Amend the code that copies attributes between the (TCP) clcsock and the
SMC socket and adjust buffer sizes appropriately:
- Copy over sk_userlocks so that both sockets agree on whether tuning
  via setsockopt is active.
- When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified with
  setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
- Likewise, use either values from setsockopt or from sysctl for SMC
  (duplicated) on successful SMC connect.

In smc_tcp_listen_work() drop the explicit copy of buffer sizes as that
is taken care of by the attribute copy.

Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 net/smc/af_smc.c | 73 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5b878e523abf..f5834af5fad5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -436,13 +436,60 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 	return rc;
 }
 
+/* copy only relevant settings and flags of SOL_SOCKET level from smc to
+ * clc socket (since smc is not called for these options from net/core)
+ */
+
+#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
+			     (1UL << SOCK_KEEPOPEN) | \
+			     (1UL << SOCK_LINGER) | \
+			     (1UL << SOCK_BROADCAST) | \
+			     (1UL << SOCK_TIMESTAMP) | \
+			     (1UL << SOCK_DBG) | \
+			     (1UL << SOCK_RCVTSTAMP) | \
+			     (1UL << SOCK_RCVTSTAMPNS) | \
+			     (1UL << SOCK_LOCALROUTE) | \
+			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			     (1UL << SOCK_RXQ_OVFL) | \
+			     (1UL << SOCK_WIFI_STATUS) | \
+			     (1UL << SOCK_NOFCS) | \
+			     (1UL << SOCK_FILTER_LOCKED) | \
+			     (1UL << SOCK_TSTAMP_NEW))
+
+/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
+static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
+				     unsigned long mask)
+{
+	struct net *nnet = sock_net(nsk);
+
+	nsk->sk_userlocks = osk->sk_userlocks;
+	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
+		nsk->sk_sndbuf = osk->sk_sndbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
+	}
+	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
+		nsk->sk_rcvbuf = osk->sk_rcvbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
+	}
+}
+
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 				   unsigned long mask)
 {
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
-	nsk->sk_sndbuf = osk->sk_sndbuf;
-	nsk->sk_rcvbuf = osk->sk_rcvbuf;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
 	nsk->sk_mark = READ_ONCE(osk->sk_mark);
@@ -453,26 +500,10 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 
 	nsk->sk_flags &= ~mask;
 	nsk->sk_flags |= osk->sk_flags & mask;
+
+	smc_adjust_sock_bufsizes(nsk, osk, mask);
 }
 
-#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
-			     (1UL << SOCK_KEEPOPEN) | \
-			     (1UL << SOCK_LINGER) | \
-			     (1UL << SOCK_BROADCAST) | \
-			     (1UL << SOCK_TIMESTAMP) | \
-			     (1UL << SOCK_DBG) | \
-			     (1UL << SOCK_RCVTSTAMP) | \
-			     (1UL << SOCK_RCVTSTAMPNS) | \
-			     (1UL << SOCK_LOCALROUTE) | \
-			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
-			     (1UL << SOCK_RXQ_OVFL) | \
-			     (1UL << SOCK_WIFI_STATUS) | \
-			     (1UL << SOCK_NOFCS) | \
-			     (1UL << SOCK_FILTER_LOCKED) | \
-			     (1UL << SOCK_TSTAMP_NEW))
-/* copy only relevant settings and flags of SOL_SOCKET level from smc to
- * clc socket (since smc is not called for these options from net/core)
- */
 static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 {
 	smc_copy_sock_settings(smc->clcsock->sk, &smc->sk, SK_FLAGS_SMC_TO_CLC);
@@ -2479,8 +2510,6 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
-		new_smc->sk.sk_sndbuf = lsmc->sk.sk_sndbuf;
-		new_smc->sk.sk_rcvbuf = lsmc->sk.sk_rcvbuf;
 		sock_hold(&new_smc->sk); /* sock_put in passive closing */
 		if (!queue_work(smc_hs_wq, &new_smc->smc_listen_work))
 			sock_put(&new_smc->sk);
-- 
2.41.0


