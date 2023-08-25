Return-Path: <netdev+bounces-30638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD378851D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4579F1C20F71
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63070CA55;
	Fri, 25 Aug 2023 10:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483DCA54
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:40:49 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593EAE54;
	Fri, 25 Aug 2023 03:40:48 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P3YDPJ025425;
	Fri, 25 Aug 2023 03:40:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=FDAvOwv2LqGa+wMd9jZNlvAu/XjCAqoWNpeCsM6PENY=;
 b=J8tl37b0p2Xi7PXoLdjvGTJhw/azowtRsPnsyetUZqoLUx/9vci7Eumc7XG8iEqdjAXS
 VYJt+fqaAAXiAxek2agEmRO6hp7QloywVUQRGx4XckxysKy/HZFGZPPrJvhn/H5NW5xc
 mfwsYz7JTocdNdsAwcVrNgvazhEGSzgKGfBtMDuPYXbGEo0OHw5dJV9H2HW3J5zRg+xX
 rvSmd5uc+D7FZdTfsdncoPc+XNpthA7U7POCZse5ScnGcV4Ub+7hBIxMnQiA9uKWs7/m
 54/tJJpQPRqLJwbglNCwWsisEbgYWFs2daXZes39+VWANxT396+M7wR/Xm/f5hOPHHM1 NQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3spmgvs3p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 25 Aug 2023 03:40:39 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 03:40:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 25 Aug 2023 03:40:37 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 881853F70B7;
	Fri, 25 Aug 2023 03:40:33 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2 2/4] octeontx2-af: Don't treat lack of CGX interfaces as error
Date: Fri, 25 Aug 2023 16:10:20 +0530
Message-ID: <20230825104022.16288-3-hkelam@marvell.com>
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
X-Proofpoint-GUID: qArULdQmsjDMn_nFCc09PJi2OG6YyqJ1
X-Proofpoint-ORIG-GUID: qArULdQmsjDMn_nFCc09PJi2OG6YyqJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sunil Goutham <sgoutham@marvell.com>

Don't treat lack of CGX LMACs on the system as a error.
Instead ignore it so that LBK VFs are created and can be used.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index b3f766b970ca..4e3aec7bdbee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -345,7 +345,7 @@ int rvu_cgx_init(struct rvu *rvu)
 	rvu->cgx_cnt_max = cgx_get_cgxcnt_max();
 	if (!rvu->cgx_cnt_max) {
 		dev_info(rvu->dev, "No CGX devices found!\n");
-		return -ENODEV;
+		return 0;
 	}
 
 	rvu->cgx_idmap = devm_kzalloc(rvu->dev, rvu->cgx_cnt_max *
-- 
2.17.1


