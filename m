Return-Path: <netdev+bounces-197947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A0ADA7C8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 07:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29981890753
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1D1D7E35;
	Mon, 16 Jun 2025 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uxdb5lPN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D17189F43;
	Mon, 16 Jun 2025 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052723; cv=none; b=WzEzTHlPPCKrsftLrSQ6/wrtpCGxzqB6GjbvIoMhJ83bF4oJ5vQEhxwBpG8BiTGhnpOeGexUbwYLu1Cwnie2kR8uTd5OO86CHXYJC9JWtTBy02ewCOIsSnBUJ2czaxgYvB2gnQn0OyG9q2dYk5X5svAbJVyFn6bm0CBZbOACAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052723; c=relaxed/simple;
	bh=gW5bZLE9sgCg6gbX4kvf2O0i/zIh/t2ry5bBkgirVag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmE6+0Uhso3J3BeCDle3w5ag8vF7FS3jzp+Sqnv/1aROpz6Efce4OcrYwC7upw2MxUFtRZ/Xq3C3WuaInXturDjCMeZYue0cbQ3NbhBAlzHc4eT0EFPLfdb/R87m7R52yn2bJW3pXiuPwgV1CQik3UGqoz6aFKePL+ilL8SYAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uxdb5lPN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FMsIIx002773;
	Mon, 16 Jun 2025 05:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Y+l1mitau88cEIaB9U1RNxbvPYefA
	rPDvO5XqEFHDWo=; b=Uxdb5lPN0xx9mTqc9K+LyTyUQbMV8Zi66IP3I38LoFxA9
	nKjIXk1APudemWhjABHGgIBiOjpA3kh59GMAdoZfhTUk0bY/8nb4XveGHwn3Vgra
	H7z9ooIU8kBcXSrPUbCsCO/dTxk+uFIWDsRacS1EyTuG8aYQVxzEOR+llEkY8fMX
	1eYAUDGnOqptvywbVX+dKQjsj3qo8wpVC4OYpZQTdXLQgaFyh+TPqGre85GK4qve
	TwE+qzZGfN9bnQ5JNmuIpeGktaDphIm6gLiTkJhvypt/82aL0YLmUDQSE8zN+W8Z
	OEt1ENXSQrrJKRwjHKISCK3wZYuq1Y5ntRFGnUiOg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4hrk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 05:45:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55G4HCmp032196;
	Mon, 16 Jun 2025 05:45:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7fhen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 05:45:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55G5j7FS015580;
	Mon, 16 Jun 2025 05:45:07 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh7fhda-1;
	Mon, 16 Jun 2025 05:45:07 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: pabeni@redhat.com, kuba@kernel.org, jeroendb@google.com,
        hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com,
        bcf@google.com
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        ziweixiao@google.com, joshwash@google.com, willemb@google.com,
        pkaligineedi@google.com
Subject: [PATCH 1/2] gve: Fix various typos and improve code comments
Date: Sun, 15 Jun 2025 22:45:00 -0700
Message-ID: <20250616054504.1644770-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160036
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAzNiBTYWx0ZWRfX4YTUkfzbKf7W Ws1nLi4NDtWMq7mypnMs7kAhIMn8ZT7QHHWNwNofkX5vjqLUfRQSNF/Y15NoNe2vospioeaHacZ SfS2ohfPbzUJMlvACOroT6pXx/fL4m4UGO3PE703AcHAdDM5Wnh/uuJr4Y4OsHYJnguTjNDurZ2
 AiZT7vAerG0maJn6FXHlK+zn/vnlUJSKT3yE87jyFCHEPS4CmBKmWauMnScx99wvQgkkfozr3wM Pue3v8ttzBpv0uOfE4aMT6sxY7CZdlV2dhyHz0vyYLf1V1e3TFH4exH8FReee6+YvmFKc/6/4gP 7DEL0PBHJO5CY3xxzCPSd8inNQ0nA20Zcfhn6rcgctRAyFI/M59x5oCGgFr9RLIDO1KbApANf6z
 qlIbGNy3lC2inYppEgxtD9skALQUTS8/PaaV4AIsmE0si1BLSn7N6rYmgQWTOut3OxPJf3l1
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=684faf65 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=s4veeftoOa1AlaYYChsA:9
X-Proofpoint-GUID: fABk84Szros29Iw-f_-ODjjY5uIHPMh1
X-Proofpoint-ORIG-GUID: fABk84Szros29Iw-f_-ODjjY5uIHPMh1

- Correct spelling and improves the clarity of comments
   "confiugration" -> "configuration"
   "spilt" -> "split"
   "It if is 0" -> "If it is 0"
   "DQ" -> "DQO" (correct abbreviation)
- Clarify BIT(0) flag usage in gve_get_priv_flags()
- Replaced hardcoded array size with GVE_NUM_PTYPES
  for clarity and maintainability.

These changes are purely cosmetic and do not affect functionality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 2 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 2 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  | 2 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 2fab38c8ee78..bd4bf591e0b3 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -781,7 +781,7 @@ struct gve_priv {
 
 	struct gve_tx_queue_config tx_cfg;
 	struct gve_rx_queue_config rx_cfg;
-	u32 num_ntfy_blks; /* spilt between TX and RX so must be even */
+	u32 num_ntfy_blks; /* split between TX and RX so must be even */
 
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
 	__be32 __iomem *db_bar2; /* "array" of doorbells */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3e8fc33cc11f..e93e564f3e65 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -625,7 +625,7 @@ static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
 
 /* The device specifies that the management vector can either be the first irq
  * or the last irq. ntfy_blk_msix_base_idx indicates the first irq assigned to
- * the ntfy blks. It if is 0 then the management vector is last, if it is 1 then
+ * the ntfy blks. If it is 0 then the management vector is last, if it is 1 then
  * the management vector is first.
  *
  * gve arranges the msix vectors so that the management vector is last.
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 228217458275..8490592d053e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -451,7 +451,7 @@ struct gve_ptype_entry {
 };
 
 struct gve_ptype_map {
-	struct gve_ptype_entry ptypes[1 << 10]; /* PTYPES are always 10 bits. */
+	struct gve_ptype_entry ptypes[GVE_NUM_PTYPES]; /* PTYPES are always 10 bits. */
 };
 
 struct gve_adminq_get_ptype_map {
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 3c1da0cf3f61..ab33e9d9b84c 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -667,7 +667,7 @@ static u32 gve_get_priv_flags(struct net_device *netdev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	u32 ret_flags = 0;
 
-	/* Only 1 flag exists currently: report-stats (BIT(O)), so set that flag. */
+	/* Only 1 flag exists currently: report-stats (BIT(0)), so set that flag. */
 	if (priv->ethtool_flags & BIT(0))
 		ret_flags |= BIT(0);
 	return ret_flags;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index dc35a23ec47f..857c6d7dd676 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1727,7 +1727,7 @@ int gve_adjust_config(struct gve_priv *priv,
 {
 	int err;
 
-	/* Allocate resources for the new confiugration */
+	/* Allocate resources for the new configuration */
 	err = gve_queues_mem_alloc(priv, tx_alloc_cfg, rx_alloc_cfg);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
@@ -2236,7 +2236,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		goto err;
 	}
 
-	/* Big TCP is only supported on DQ*/
+	/* Big TCP is only supported on DQO */
 	if (!gve_is_gqi(priv))
 		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 
-- 
2.47.1


