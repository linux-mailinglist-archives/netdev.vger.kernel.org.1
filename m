Return-Path: <netdev+bounces-239066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A363C6364A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1009E4ED0EB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997B32548B;
	Mon, 17 Nov 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k1julFPI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C632720F
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373282; cv=none; b=qxrjuVC7fD7s0+gfX+V8dtdNEAzS61udY+wl72t6aVzlBud0VH4iIJJTRaXnI5+RJ1/ugnRvylSqzOnPSHBOUII+2bx6HP5NSkuRR1ogD1Sd9GQmL7SJObXZmjJD3JcHemHLo4GrCbVSNhuJ03l8lBpgRtlAZFetrD/02uXUiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373282; c=relaxed/simple;
	bh=dTBPHpLQbB+iYIc+Bpw/SnviuHCVvkD7biO0GBEhJP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhom7zskq9328+HlMwMKeNT2N3Hx8a8Knfw/2/kxvEepBNaG2jSPSG9HD2yJSB4PgE9Z8lBGry4eSumSuqrawfV6cH5N72NniJ4DH2+fxTJFKAf1fZY1PCLf//FoAHJNLroF7YJARB/Dk8Oezfre5o/9+m1LNRiUEHPgKqgF85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k1julFPI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1vXqc010746;
	Mon, 17 Nov 2025 09:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=IzLHTA0mXTpKrmN96w1Z3DebiNjTq
	XQuERrtRQ/75c0=; b=k1julFPIdlfLd5GFH2ihCqTCufpoKebJQEdzhSLLcJFlm
	a9GfGGnmCif+ZOW7tvs31KVMyde77iBm/3VGqen8V9RTf4IO5cmW3iF19VIBI94O
	MvG9V5U4plIQ4CjB/GR3UyXQRyfbcPm0y1pu+yZsxseYQm1fv++5WmqH++3KfR7m
	EXiSR0bBGIQJrI7uTegSW/pTNnH5kLdSz+d62XyoSB8hvYdazRN2xytAQ0ER1F+B
	sx8rx4WC013LjVQq0W2JezHZ0YDX4eJ88mb0zuRejaeGEGdBoEH9y/uZRbtwrv2p
	cWHgzpuY6qG6U5rquTmnrfLMeDCiQLSgJq2TLhorw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j260x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:54:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH9XRc8004290;
	Mon, 17 Nov 2025 09:54:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy76ddg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:54:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AH9sQPc025584;
	Mon, 17 Nov 2025 09:54:26 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefy76dd0-1;
	Mon, 17 Nov 2025 09:54:26 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linus.walleij@linaro.org, andrew@lunn.ch, olteanv@gmail.com,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: dsa: ks8995: Fix incorrect OF match table name
Date: Mon, 17 Nov 2025 01:53:50 -0800
Message-ID: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511170083
X-Proofpoint-ORIG-GUID: Lt6rVU8OFb2ScIhL_A2g-WmaVaZ52GIB
X-Proofpoint-GUID: Lt6rVU8OFb2ScIhL_A2g-WmaVaZ52GIB
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691af0d4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=dMjwkYdLyfkfgCMjcIoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXxwcWMFmCzSMu
 AJ5LhWLW4zVa6SYCO4bIR6hFJh544RPWoCmBeUPjbAE4y43EtCrHfypNuRuOitiRRDlyFYbpEve
 H5bBxL3E8WwaG+HR1Ac/ELlfe5gMAVwALp2wcDDdhDZ0TNVsL9Ww3Ml2C/GIAXVjlkd0Uvx+XpW
 eNH9SUqUHBgqYtbCcEXsa5Rn7TVU3vQxpGoYEpg4j/rmh5REincEU8EUO7e8kNNgyjLRjRquon7
 SodFd0VMgHBDgm42BHwIi7sc7VU9U0U+Hob6YsrHeisuj8NQ6G1a7qNJoqGuHeLO4ORMwkoVSWo
 VXSbyHlvS5LIjcw2akcvDARD7Z1H/FcwjqSEUTHkUZgKPfGa2fW4xd+L4rCLyKNpS97ahYmawi8
 6QxwhS1WLNpnceXhiWsKmYraatuOxQ==

The driver declares an OF match table named ks8895_spi_of_match, even
though it describes compatible strings for the KS8995 and related Micrel
switches. This is a leftover typo, the correct name should match the
chip family handled by this driver ks8995, and also match the variable
used in spi_driver.of_match_table.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/dsa/ks8995.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 5c4c83e00477..77d8b842693c 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -203,13 +203,13 @@ static const struct spi_device_id ks8995_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ks8995_id);
 
-static const struct of_device_id ks8895_spi_of_match[] = {
+static const struct of_device_id ks8995_spi_of_match[] = {
 	{ .compatible = "micrel,ks8995" },
 	{ .compatible = "micrel,ksz8864" },
 	{ .compatible = "micrel,ksz8795" },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, ks8895_spi_of_match);
+MODULE_DEVICE_TABLE(of, ks8995_spi_of_match);
 
 static inline u8 get_chip_id(u8 val)
 {
@@ -842,7 +842,7 @@ static void ks8995_remove(struct spi_device *spi)
 static struct spi_driver ks8995_driver = {
 	.driver = {
 		.name	    = "spi-ks8995",
-		.of_match_table = ks8895_spi_of_match,
+		.of_match_table = ks8995_spi_of_match,
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
-- 
2.50.1


