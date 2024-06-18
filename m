Return-Path: <netdev+bounces-104634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC6D90DACF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD616282315
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856CD13FD72;
	Tue, 18 Jun 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RnqZX+FH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951941C89;
	Tue, 18 Jun 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732525; cv=none; b=Ch3leIoDoJom8Sy8HVeygin3OAEASeRYc2ustm4PIogtr5QJiwJ6FTw5yuqbH1eSQxnsatGsNRZYciVc9BvSk1IXSWI0GactSoJERY1MH0adv/v++avHjlMRF3mbSG89oXw1H8Bf/CncrBH628Y6g4Yqb44vpXxTlAp6UHh9EL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732525; c=relaxed/simple;
	bh=XJL+Fhe5nKB+1xkBdbIdnAo2+nyfuaGX+VNEVe3DdqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sbkEeiw9g/JxUv3ES9a22K0NGE6WnZ84b29Mnuu+ffg8L1Izpnr2d3juNX5Z2aO1isKTc0IgkJh0Zk0+08/EypHIQiiT2JlmI8sVd108s6q4H00i6j8zmqzFBnTxVR9DThfEruQ34TlX9LQtxI0BA+2l3+hZDcI3xudX4NLPB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RnqZX+FH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IGM3Ck021307;
	Tue, 18 Jun 2024 17:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=62THTjkwAl0xCY97eg1FIS
	xzP7RhV6/9iENORIzA4mE=; b=RnqZX+FHdKZIajauwAEAi1HbmIApAllxkyxnaK
	3HBSdbjebU3GaDzWST7Gk//heDYXiS4zNGuL/Xb117uLc69v84ZymbcOKSGBhpSM
	CqnCfxfAajX7zY1jTZ7LKABC52flepEOMP2CGnjC/kK3vvpic59/8eXc1UVTFvlL
	TsW6gGoDFJYmqqdPZfQJHN7ftXyyuoAMJzDtFF53TalKY2to0Z5b0kOQ9eNll2Im
	tfFBqJGDSGe9sKSyN0NIcMPp6XhH5umfR6XVsuQIh8neJtJQa9ntnc3LoPykfs2K
	Ml4ASLvkPmrHiG2BXjR0aT0X9zQcHyE/MBKuZdkRfMdsjHWg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytx3wtf6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 17:41:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IHfttP014258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 17:41:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 10:41:55 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 18 Jun 2024 10:41:54 -0700
Subject: [PATCH net-next] net: ethernet: mac89x0: add missing
 MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-md-m68k-drivers-net-ethernet-cirrus-v1-1-07f5bd0b64cb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOHGcWYC/x2NSwrDMAxErxK0riA2IQ29SunCH6URrd0iOSEQc
 vfa3c1jhnkHKAmTwq07QGhj5U+uYC4dhMXlJyHHymB7O/SjmTBFTOP0wii8kShmKkhlIWkhsMi
 q6IK1vTFXb+YI9ekrNPP+t9yh7TLtBR618U4JvbgclmZ5c153TE4LCZznD8cv+r+eAAAA
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
X-Proofpoint-GUID: xZxw18AlH8Y1bSt6zfE-eOYm30qntAWL
X-Proofpoint-ORIG-GUID: xZxw18AlH8Y1bSt6zfE-eOYm30qntAWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=986 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180131

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/cirrus/mac89x0.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/ethernet/cirrus/mac89x0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 887876f35f10..84b300fee2bb 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -554,6 +554,7 @@ static int set_mac_address(struct net_device *dev, void *addr)
 	return 0;
 }
 
+MODULE_DESCRIPTION("Macintosh CS89x0-based Ethernet driver");
 MODULE_LICENSE("GPL");
 
 static void mac89x0_device_remove(struct platform_device *pdev)

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-md-m68k-drivers-net-ethernet-cirrus-ac220117b1fd


