Return-Path: <netdev+bounces-30639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58CB788520
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2C28180D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B456D2E0;
	Fri, 25 Aug 2023 10:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAACCA54
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:40:50 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147FE54;
	Fri, 25 Aug 2023 03:40:49 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P3YFRL025654;
	Fri, 25 Aug 2023 03:40:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Cm5ET/zQ5LW1F23s9rWWuJVG7OKW3B4iSmqVn85MD2o=;
 b=Pc49L3oywg6/4Wrb8QOHsEF+1vX9Kg7SHeLp1mLowA/Zv9/q76a4IobHQKweBG4NVDho
 ul9USl/IOASj0xQfb4MU4zwMI05iiluorzLeP+EZQOokES3ipBsnjbtnKSY1oF6DSiYZ
 aBVElPHr2yBvKGe1q1zHSif7tI4X/iuaV3nr5voCIgTV9OeGaM15W+ivOJPXmf+LjZE4
 CErOGMaGe73A9W/pDHsG98wOxqO1nRi+mhw7fGDAZYkBt52e+cCTA+yQkEmdnQjaLtMF
 fKZ6YjTWrHcy7Ue1jUJag8kGFGXL84Q8qJSSLIDjnfVAv1xbY+HRw1MVtc/1LGDNSHJ8 kg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3spmgvs3p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 03:40:34 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 03:40:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 25 Aug 2023 03:40:32 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B60013F70A3;
	Fri, 25 Aug 2023 03:40:28 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2 1/4] octeontx2-af: CN10KB: Add USGMII LMAC mode
Date: Fri, 25 Aug 2023 16:10:19 +0530
Message-ID: <20230825104022.16288-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825104022.16288-1-hkelam@marvell.com>
References: <20230825104022.16288-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 7wOTaH5ArKMI86dUwrILqx_Xv9e5f3vJ
X-Proofpoint-ORIG-GUID: 7wOTaH5ArKMI86dUwrILqx_Xv9e5f3vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Upon physical link change, firmware reports to the kernel about the
change along with the details like speed, lmac_type_id, etc.
Kernel derives lmac_type based on lmac_type_id received from firmware.

This patch extends current lmac list with new USGMII mode supported
by CN10KB RPM block.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 988383e20bb8..9392ef95a245 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -55,6 +55,7 @@ static const char *cgx_lmactype_string[LMAC_MODE_MAX] = {
 	[LMAC_MODE_50G_R] = "50G_R",
 	[LMAC_MODE_100G_R] = "100G_R",
 	[LMAC_MODE_USXGMII] = "USXGMII",
+	[LMAC_MODE_USGMII] = "USGMII",
 };
 
 /* CGX PHY management internal APIs */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 574114179688..6f7d1dee5830 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -110,6 +110,7 @@ enum LMAC_TYPE {
 	LMAC_MODE_50G_R		= 8,
 	LMAC_MODE_100G_R	= 9,
 	LMAC_MODE_USXGMII	= 10,
+	LMAC_MODE_USGMII	= 11,
 	LMAC_MODE_MAX,
 };
 
-- 
2.17.1


