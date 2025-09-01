Return-Path: <netdev+bounces-218625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D7B3DADA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E722165E52
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718C260563;
	Mon,  1 Sep 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fiYqK46/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B0263C75
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710765; cv=none; b=rRvKiBbPK/6htQIGCWuPRXowmTJgibo1vIlwoHOpaJfc3IaYqV4YDs0CQVPFJV2Y9ILxmFvx5RP4BN286QCfBZg1IYnNjZ5z3hos7fUN4fFZsIntzgsTg6ViqS8udxYNj4NSto8UtuDGLN7dJSUfYXYBffgtqvdlz2IJKnuWRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710765; c=relaxed/simple;
	bh=Wgw5ls+1vGrPWogeF9U7TXLrqKpxOPCBDRrwGNndUDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bl4jNsj21grgBGCjr+CqqtDpmdQZ33Ls7gQW5wtSFO5w2wX9798zgTvrbEOvQObOx33jAW+0WklHYR2QTa73bIDVaOfKGKNxiPnOb0uPKvm6i2dn1Q3Cg3TToA8EQRhj7mUShcafe5oXvUatnwNMR2fGasqylnkfHvk+/L0/HkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fiYqK46/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fmDL018243;
	Mon, 1 Sep 2025 07:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8X6IONRu3rZZWW+2eJ5EZGNj4J6QX
	nW6i7Rs9UHs/5A=; b=fiYqK46/7SQPODA8luMfKefT+WFkt7kDF0A8ZbyIphNGI
	azJUh4KRrYi5Qzp0Xhn6Io6yNLox35sVQPo6RUA2OCMYh0GM9UP2dHmKgkKtJ9cV
	IUhoKnTATB3eLNwQD47qaPFenF+Yx7t8tJ2Z96ouvJMctkUqefMzsNbrMnOUjp8g
	dt69knSbin8LPou0/uh6VmtA4LsMyOgMM0h/zhBsC8oWZ7OCb6B+POofiadx10si
	kBUGZA7GJIaEqOTnMAdsNF4vSSeP5nHLPzGtW7GZf6zHBcKO+Cp9hTtbOXSMccbH
	cjQIlcfGjeSBkuskiDcttSAQtc0Zj8o5EUKS4Jw/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9husr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 07:12:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58171ZLS026777;
	Mon, 1 Sep 2025 07:12:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01m37kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 07:12:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58179l8B008209;
	Mon, 1 Sep 2025 07:12:25 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48v01m37kb-1;
	Mon, 01 Sep 2025 07:12:25 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [QUERY] mctp: getsockopt unknown option return code -EINVAL
Date: Mon,  1 Sep 2025 00:11:53 -0700
Message-ID: <20250901071156.1169519-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010075
X-Proofpoint-GUID: NcO0J6sFa-KJA66P2RzIL6ZNgCbeba7y
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b5475b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yOcRUqXPRtnYrbv3vJkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXzUx7aBRZKbYH
 1VJkeYmVAP1nyFe0GfBg75YxVxx78qcpf6BH6LUh0WLJPB+ZtRq1ymRTS0isoD6kIRrJrHQePki
 6WmHGjldLWRReWv8e2kjVKGMvRYuMYXcWMZHfc6vaUJdmmT0uKkk1dhT4lT4SrA+zGqVQcWd+mA
 XWAVDl4DAl4BKHOAQ3BQVjr5dhMzxSGe4xjnMsV+mSYRh6fsRZfYeKX56AlpqQT7e3qvjDDAB1q
 epqVaSFiQaTb0fOBMIGqX00gpgqm0TwB5tV/JIJWiSlwG5o28xRRhmzdHt7HItZ41vH9KgUO307
 tJDKdO/ddWuRMaYnoToFbAAaIdugUIrDmnAsBozY5RC5T1BTYjRdlhXztFkB/XfWygCncJLQftW
 k13zvIRC
X-Proofpoint-ORIG-GUID: NcO0J6sFa-KJA66P2RzIL6ZNgCbeba7y

net/mctp/af_mctp.c
In mctp_getsockopt(), unknown options currently return -EINVAL.
In contrast, mctp_setsockopt() returns -ENOPROTOOPT for unknown
options.

Would it be ideal to return -ENOPROTOOPT instead of -EINVAL in
mctp_getsockopt() when an option is unrecognized?
This would match the behavior of mctp_setsockopt() and follow the
standard kernel socket API convention for unknown options.

---
 net/mctp/af_mctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index df4e8cf33899b..e8938ca35a066 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -425,7 +425,7 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 
-	return -EINVAL;
+	return -EINVAL; // > ENOPROTOOPT
 }
 
 /* helpers for reading/writing the tag ioc, handling compatibility across the
-- 
2.50.1


Thanks,
Alok

