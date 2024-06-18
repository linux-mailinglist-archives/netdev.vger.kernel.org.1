Return-Path: <netdev+bounces-104624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14990DA09
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA831C21D8E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D814884D;
	Tue, 18 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KqQXui8G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210013D528;
	Tue, 18 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729641; cv=none; b=a+dVuX4cVlgwYvA6iR8nLtCdnF5hLakSgHUcJ2nHU369dCsN+sAcHqtH9/Ko+yIojIqqiKRbqNQ22nD+JMR/M4zyYeGKar+c0ixYsbv24X91ng5pp3Rt5+Ylp6jrA6UOdcI1YkLdYC+8aFI80eA9bYSR8wUOhkvP9V8KPMEBhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729641; c=relaxed/simple;
	bh=oYute8/wy9hiVcWRO+JQF6ZA/DGfGn+3eK/4yP/RxNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hWZiZLUlLNS8UtWfmQXmoFn1eqppbv6lAGsmQ2Pv3hb/z3bYkbcjp8NUKkhTJCsZmIAl6L/HXfrVRztrzYJW17KVEpDTsQba3mCUqx3Gztt540VUKBajUW/dpbVhua11EzZILVydroVCCj9OIdY/wda8shWEi76+4YTPumoRUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KqQXui8G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IBChOl005240;
	Tue, 18 Jun 2024 16:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X6V/Yl7iMXuRwzk2uprHwg
	UlY145d2MyTJHzRCYnK6w=; b=KqQXui8GBCwqA/c0zSkOKaEInLy2QTfZidAXUH
	DveN6h+ODNo3HoBGJNNgemMuGqIfAIrG++kRATvaOQMnQ6nNp+RjkCaJupX3Dy9Z
	ImuaEcrVDEuF3upZA/Ov+MON+noj+1k+FIfGv7HMOOvZkVFYVJYQOW+d7sbaWvM2
	1a8A0z25cMO/yrUMjlRFqhW/J3JpJjWFEdeB50OGhoucjFTenep9VfqlQuLuHfVE
	G29yLM0FS7LcTDKA4mRPavS4kSV78jTCri8YgD9A48q71lC/vwWmZjTRx6sNPGfn
	smP4JaB5BEuUxVCHqCTROk3pquA2C43klYD/PQNVntETwYNw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu95rgvxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:53:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IGrldi029289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:53:47 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 09:53:47 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 18 Jun 2024 09:53:44 -0700
Subject: [PATCH net-next] net: arcnet: com20020-isa: add missing
 MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-md-m68k-drivers-net-arcnet-v1-1-90e42bc58102@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJe7cWYC/x2MywrCMBBFf6XM2oG0Shv8FXGRx9QO2lEmsQRK/
 93E1eVwD2eHRMqU4NrtoLRx4rdU6E8dhMXJg5BjZRjMcDFjb3GNuI72iVF5I00olNFpaHOm2cb
 JToa8hRr4KM1c/vEbNEGoZLjXx7tE6NVJWFr8xfItuLqUSeE4fpeMILaVAAAA
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UKTUcdgcdT1q81BCbzHmFRntShhrvUAy
X-Proofpoint-ORIG-GUID: UKTUcdgcdT1q81BCbzHmFRntShhrvUAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 phishscore=0 mlxlogscore=958 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180126

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020-isa.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/arcnet/com20020-isa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
index 293a621e654c..fef2ac2852a8 100644
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -137,6 +137,7 @@ module_param(backplane, int, 0);
 module_param(clockp, int, 0);
 module_param(clockm, int, 0);
 
+MODULE_DESCRIPTION("ARCnet COM20020 chipset ISA driver");
 MODULE_LICENSE("GPL");
 
 static struct net_device *my_dev;

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-md-m68k-drivers-net-arcnet-3ef8d7870eb8


