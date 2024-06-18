Return-Path: <netdev+bounces-104640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0890DB2A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0350D284DC9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874A1482E6;
	Tue, 18 Jun 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XE5RgZ3L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F841C89;
	Tue, 18 Jun 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733400; cv=none; b=L0qhCWVclvhDqkPme3839q22S6o5kir18933JSCEHR4Snoz7vGzx9LN9LCz4NXUuF65r/OdfKgdhR/TAL6eJKntMDqH5KVKmQWPuGZFvptOadYqVVfQ/nkgaRMVQz457aWD9dnBnI/7QeaDwCFIGpWg2BPrZuvvEq0xkLghwWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733400; c=relaxed/simple;
	bh=Km919CFyw8OSShS6B8IYDf17coDJFN1nYTJygYZHhfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SonG1x63K0pe49OQPWlt5YebLngny+gF5mE20v8Wa5ru3yvtOBu8ypgawM6DBbrE48saf1MBtWC5N/KgGP8Dns3639EMbD9YavPALcuNSCcdIwcR/e89TQllTDy+xY7lrZScYV8SGZPow0vnqvraCITskx7wh/h0Kn75ijIroPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XE5RgZ3L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ICTBwE011398;
	Tue, 18 Jun 2024 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GtT8QPt+w7lXq+BEYNDUO/
	UJ1vTg+doTOXgVkhie5Yo=; b=XE5RgZ3LNY+lkt8iNx2zx1CG879ILnW+bGV+KZ
	QbSJqct+5XXYVqUbe8SxDsH+Mc0v5hcrpqwSUqRqAidmGdbTmqHPbCnQc1jPA0XJ
	k0g5wLlabAzvwTOWlEygmHw1wKK5ula5Q3+pQky9+DcesWYyxLsADbIdeJZqN/MX
	z9gBHJu3MqXyI7lhDA5QGK5cfE+ek++4S5DaNfyfs/Mfo/xho1Sszz4ddVK86yr9
	TH+lA1bD3W5So72+lZIM4wxUeBS1pBAae/sIS2UHBhm7+263GOD24LNODYPxopXE
	1lrPTOZjkLmt67xLsnoscjOF6oMBFBSS2ipvCGhNKtLxUphQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu24n22vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 17:56:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IHuTbm026216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 17:56:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 10:56:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 18 Jun 2024 10:56:28 -0700
Subject: [PATCH net-next] net: smc9194: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-md-m68k-drivers-net-ethernet-smsc-v1-1-ad3d7200421e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEvKcWYC/x2NwQqDMBBEf0X23AUVEemvlB5iMtalTVp2UwmI/
 97Y2zxmmLeTQQVG12YnxSYm71ShuzTkV5ceYAmVqW/7oR27iWPgOE5PDiob1DghM/IKPYNF8ww
 /uH7p2nEJoPrzUSxS/o4bnauEkulem9kZeFaX/Ho6XpK+haOzDKXj+AECI2x7nAAAAA==
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eZWjci9KWdPMBfjRpA_0c2gx2HSfFRaL
X-Proofpoint-ORIG-GUID: eZWjci9KWdPMBfjRpA_0c2gx2HSfFRaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180133

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smc9194.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/ethernet/smsc/smc9194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/smsc/smc9194.c b/drivers/net/ethernet/smsc/smc9194.c
index af661c65ffe2..e2e7b1c68563 100644
--- a/drivers/net/ethernet/smsc/smc9194.c
+++ b/drivers/net/ethernet/smsc/smc9194.c
@@ -1501,6 +1501,7 @@ static void smc_set_multicast_list(struct net_device *dev)
 #ifdef MODULE
 
 static struct net_device *devSMC9194;
+MODULE_DESCRIPTION("SMC 9194 Ethernet driver");
 MODULE_LICENSE("GPL");
 
 module_param_hw(io, int, ioport, 0);

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-md-m68k-drivers-net-ethernet-smsc-ec4a2f106fde


