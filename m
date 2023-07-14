Return-Path: <netdev+bounces-17811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1427531A7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55B02820DC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05126FAE;
	Fri, 14 Jul 2023 05:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40006FA4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:59:35 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B430CB;
	Thu, 13 Jul 2023 22:59:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4wrIG022549;
	Fri, 14 Jul 2023 05:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0c9gx394O2KZ9g52PIHyILTHpIsvOLIJK8hhHHaQizQ=;
 b=fa9rnjLSBe+R9sZRSjuEBytmD35fWvAY2yuYxcLbC7ZCt47/4huiywaBt85BmfIdRXPD
 BIDgUVHnZKldbNCEBVCMuxRBSUKGBqpTvYDgiJySfKmNrOAgeDQBBCzAnl17QLY/hwyC
 EGBj7KUj4Q8e+XN2uT1f0fSppkoB5Ftooi0KShmjpq0WuWObIqCW9jdymZFUefgNxoVP
 F6TSufQVj9coAd+s9u37FEKekImLcIaAAyT3IJmjfKejUsJ2xphYjhOqikQpCqB0Oh6D
 qV9cqpi4N/aAtsF2IWHhSScxpQZImIQ2A4bhcXBPmQnXQ01KMgZ+5U5J7TkZT9OGVmWp rA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpts10sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 05:59:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E5xPbk009830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 05:59:25 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 22:59:20 -0700
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
To: <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_clew@quicinc.com>,
        Vignesh Viswanathan
	<quic_viswanat@quicinc.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH V2 net-next 3/3] net: qrtr: Handle IPCR control port format of older targets
Date: Fri, 14 Jul 2023 11:28:46 +0530
Message-ID: <20230714055846.1481015-4-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714055846.1481015-1-quic_viswanat@quicinc.com>
References: <20230714055846.1481015-1-quic_viswanat@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rITQFGwi2QpkbynFwHnpFUbYtxWJsuYM
X-Proofpoint-ORIG-GUID: rITQFGwi2QpkbynFwHnpFUbYtxWJsuYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The destination port value in the IPCR control buffer on older
targets is 0xFFFF. Handle the same by updating the dst_port to
QRTR_PORT_CTRL.

Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 net/qrtr/af_qrtr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 78beb74146e7..41ece61eb57a 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -23,6 +23,8 @@
 #define QRTR_EPH_PORT_RANGE \
 		XA_LIMIT(QRTR_MIN_EPH_SOCKET, QRTR_MAX_EPH_SOCKET)
 
+#define QRTR_PORT_CTRL_LEGACY 0xffff
+
 /**
  * struct qrtr_hdr_v1 - (I|R)PCrouter packet header version 1
  * @version: protocol version
@@ -495,6 +497,9 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 		goto err;
 	}
 
+	if (cb->dst_port == QRTR_PORT_CTRL_LEGACY)
+		cb->dst_port = QRTR_PORT_CTRL;
+
 	if (!size || len != ALIGN(size, 4) + hdrlen)
 		goto err;
 
-- 
2.41.0


