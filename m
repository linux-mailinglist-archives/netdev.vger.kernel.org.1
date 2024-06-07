Return-Path: <netdev+bounces-101961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D017A900C2A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 20:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3984C1F21C1D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65614B951;
	Fri,  7 Jun 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dsnu5D+b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30114B083;
	Fri,  7 Jun 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786621; cv=none; b=d+drrX0g0UfjGjci8l2tKPxB1/ODbpeSV6SPdozGuG43rhsVpXSKyp9aBOhkpHSZy46dgoZJH+tnoPaibBXRI5naJiDgpK4WGFczjCqKA/2hnYDTdEzEZxpZcoIPdJ9r4tS7FWDpAtEFytrxzCZQifWXL5k9fcb+A+CsXFroBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786621; c=relaxed/simple;
	bh=cOHWxYXhS4QzE8FPRetOVqOidM7FNPnmXPV0JI8jboo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fS8dC+bKMRtAQVB9nz8jI7hSVdu3CiLVA4soq40Euj9nYakTdGmEvGRc0QUedf1YMTC2cR5LrhQ7xpAArppNcgJlNJvtLjV76pknXKV3WgZpFv/U0nLalRObjvlJ+5glNZyFiGFT1TNFIUYFN5SzkJX+Ja9GDzoN+rtPCD88rUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dsnu5D+b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZwoE008786;
	Fri, 7 Jun 2024 18:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UQvPbsNBuGyozGV8ZlE2kZ
	OfZWaPoZTtzz/LxPOdJ0k=; b=dsnu5D+bGmwxBUjAW8fb4WoQMlsnhN+EkGivMq
	hxObHG3kRlKLdCUfibFAKhlAtTIJLInrfy12f1NmI+1+bi6Dc8toGImJNtTsFrKy
	gutmG1omNS9IHq7cniFySaqbwM/oFsTGpwnByCGeJSwwu54O8O42qJG1s8azdZFQ
	SK43WUJheceQc0qshI/TvCbHCuAHC7ENAg3oR2OMl9vkfg/yBKm9/+IxQENo1OYl
	/4vQG51CSFE4cQn+VKyDp/BBnw1kxayPHES7tol7FDgv6SWqrQkZJ119de5vXWd1
	aCCK0q2HynCDFfbgTqw0lPfB6I8U9w2HSdUAZ9LdZLxdc04Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk8tccg10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 18:56:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457Iuvae026378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 18:56:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 11:56:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 11:56:56 -0700
Subject: [PATCH] isdn: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-isdn-v1-1-81fb7001bc3a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPdXY2YC/x3MQQrCQAxA0auUrA2MY1vRq4iLSSdjAzZKoqVQe
 nfHLt/i/xWcTdjh2qxgPIvLSyuOhwaGMemDUXI1xBDb0IczThmzyczmKJ4VL30s1FKJJ+qgVm/
 jIst+vN2rKTkjWdJh/H+eot8Fp+QfNti2H9EZKCqAAAAA
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PHbWhhGYVDJq93_2jcMDE6KIOzbm_RiQ
X-Proofpoint-GUID: PHbWhhGYVDJq93_2jcMDE6KIOzbm_RiQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=857 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070138

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcpci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcmulti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcsusb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/avmfritz.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/speedfax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNinfineon.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/w6692.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/netjet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNipac.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNisar.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/mISDN_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/mISDN_dsp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/l1oip.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/isdn/hardware/mISDN/avmfritz.c      | 1 +
 drivers/isdn/hardware/mISDN/hfcmulti.c      | 1 +
 drivers/isdn/hardware/mISDN/hfcpci.c        | 1 +
 drivers/isdn/hardware/mISDN/hfcsusb.c       | 1 +
 drivers/isdn/hardware/mISDN/mISDNinfineon.c | 1 +
 drivers/isdn/hardware/mISDN/mISDNipac.c     | 1 +
 drivers/isdn/hardware/mISDN/mISDNisar.c     | 1 +
 drivers/isdn/hardware/mISDN/netjet.c        | 1 +
 drivers/isdn/hardware/mISDN/speedfax.c      | 1 +
 drivers/isdn/hardware/mISDN/w6692.c         | 1 +
 drivers/isdn/mISDN/core.c                   | 1 +
 drivers/isdn/mISDN/dsp_core.c               | 1 +
 drivers/isdn/mISDN/l1oip_core.c             | 1 +
 13 files changed, 13 insertions(+)

diff --git a/drivers/isdn/hardware/mISDN/avmfritz.c b/drivers/isdn/hardware/mISDN/avmfritz.c
index f68569bfef7a..509b362d6465 100644
--- a/drivers/isdn/hardware/mISDN/avmfritz.c
+++ b/drivers/isdn/hardware/mISDN/avmfritz.c
@@ -159,6 +159,7 @@ set_debug(const char *val, const struct kernel_param *kp)
 }
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for AVM FRITZ!CARD PCI ISDN cards");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(AVMFRITZ_REV);
 module_param_call(debug, set_debug, param_get_uint, &debug, S_IRUGO | S_IWUSR);
diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 2e5cb9dde3ec..0d2928d8aeae 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -221,6 +221,7 @@ static uint	hwid = HWID_NONE;
 static int	HFC_cnt, E1_cnt, bmask_cnt, Port_cnt, PCM_cnt = 99;
 
 MODULE_AUTHOR("Andreas Eversberg");
+MODULE_DESCRIPTION("mISDN driver for hfc-4s/hfc-8s/hfc-e1 based cards");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HFC_MULTI_VERSION);
 module_param(debug, uint, S_IRUGO | S_IWUSR);
diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index fe391de1aba3..ce7bccc9faa3 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -48,6 +48,7 @@ static struct timer_list hfc_tl;
 static unsigned long hfc_jiffies;
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for CCD's hfc-pci based cards");
 MODULE_LICENSE("GPL");
 module_param(debug, uint, S_IRUGO | S_IWUSR);
 module_param(poll, uint, S_IRUGO | S_IWUSR);
diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index b82b89888a5e..e54419a4e731 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -31,6 +31,7 @@ static DEFINE_RWLOCK(HFClock);
 
 
 MODULE_AUTHOR("Martin Bachem");
+MODULE_DESCRIPTION("mISDN driver for Colognechip HFC-S USB chip");
 MODULE_LICENSE("GPL");
 module_param(debug, uint, S_IRUGO | S_IWUSR);
 module_param(poll, int, 0);
diff --git a/drivers/isdn/hardware/mISDN/mISDNinfineon.c b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
index 88d592bafdb0..30876a012711 100644
--- a/drivers/isdn/hardware/mISDN/mISDNinfineon.c
+++ b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
@@ -245,6 +245,7 @@ set_debug(const char *val, const struct kernel_param *kp)
 }
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for cards based on Infineon ISDN chipsets");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(INFINEON_REV);
 module_param_call(debug, set_debug, param_get_uint, &debug, S_IRUGO | S_IWUSR);
diff --git a/drivers/isdn/hardware/mISDN/mISDNipac.c b/drivers/isdn/hardware/mISDN/mISDNipac.c
index 4f8d85bb3ce1..d0b7271fbda1 100644
--- a/drivers/isdn/hardware/mISDN/mISDNipac.c
+++ b/drivers/isdn/hardware/mISDN/mISDNipac.c
@@ -21,6 +21,7 @@
 
 MODULE_AUTHOR("Karsten Keil");
 MODULE_VERSION(ISAC_REV);
+MODULE_DESCRIPTION("mISDN driver for ISAC specific functions");
 MODULE_LICENSE("GPL v2");
 
 #define ReadISAC(is, o)		(is->read_reg(is->dch.hw, o + is->off))
diff --git a/drivers/isdn/hardware/mISDN/mISDNisar.c b/drivers/isdn/hardware/mISDN/mISDNisar.c
index 48b3d43e2502..b3e03c410544 100644
--- a/drivers/isdn/hardware/mISDN/mISDNisar.c
+++ b/drivers/isdn/hardware/mISDN/mISDNisar.c
@@ -22,6 +22,7 @@
 #define ISAR_REV	"2.1"
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for ISAR (Siemens PSB 7110) specific functions");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(ISAR_REV);
 
diff --git a/drivers/isdn/hardware/mISDN/netjet.c b/drivers/isdn/hardware/mISDN/netjet.c
index 566c790a9481..d163850c295e 100644
--- a/drivers/isdn/hardware/mISDN/netjet.c
+++ b/drivers/isdn/hardware/mISDN/netjet.c
@@ -114,6 +114,7 @@ set_debug(const char *val, const struct kernel_param *kp)
 }
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for NETJet cards");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(NETJET_REV);
 module_param_call(debug, set_debug, param_get_uint, &debug, S_IRUGO | S_IWUSR);
diff --git a/drivers/isdn/hardware/mISDN/speedfax.c b/drivers/isdn/hardware/mISDN/speedfax.c
index b530c78eca8e..0c405261d940 100644
--- a/drivers/isdn/hardware/mISDN/speedfax.c
+++ b/drivers/isdn/hardware/mISDN/speedfax.c
@@ -97,6 +97,7 @@ set_debug(const char *val, const struct kernel_param *kp)
 }
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for Sedlbauer Speedfax+ cards");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(SPEEDFAX_REV);
 MODULE_FIRMWARE("isdn/ISAR.BIN");
diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index f3b8db7b48fe..ee69212ac351 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -101,6 +101,7 @@ set_debug(const char *val, const struct kernel_param *kp)
 }
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("mISDN driver for Winbond w6692 based cards");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(W6692_REV);
 module_param_call(debug, set_debug, param_get_uint, &debug, S_IRUGO | S_IWUSR);
diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index ab8513a7acd5..e34a7a46754e 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -14,6 +14,7 @@
 static u_int debug;
 
 MODULE_AUTHOR("Karsten Keil");
+MODULE_DESCRIPTION("Modular ISDN core driver");
 MODULE_LICENSE("GPL");
 module_param(debug, uint, S_IRUGO | S_IWUSR);
 
diff --git a/drivers/isdn/mISDN/dsp_core.c b/drivers/isdn/mISDN/dsp_core.c
index fae95f166688..753232e9fc36 100644
--- a/drivers/isdn/mISDN/dsp_core.c
+++ b/drivers/isdn/mISDN/dsp_core.c
@@ -172,6 +172,7 @@ module_param(debug, uint, S_IRUGO | S_IWUSR);
 module_param(options, uint, S_IRUGO | S_IWUSR);
 module_param(poll, uint, S_IRUGO | S_IWUSR);
 module_param(dtmfthreshold, uint, S_IRUGO | S_IWUSR);
+MODULE_DESCRIPTION("mISDN driver for Digital Audio Processing of transparent data");
 MODULE_LICENSE("GPL");
 
 /*int spinnest = 0;*/
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index f010b35a0531..a5ad88a960d0 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -245,6 +245,7 @@ static int debug;
 static int ulaw;
 
 MODULE_AUTHOR("Andreas Eversberg");
+MODULE_DESCRIPTION("mISDN driver for tunneling layer 1 over IP");
 MODULE_LICENSE("GPL");
 module_param_array(type, uint, NULL, S_IRUGO | S_IWUSR);
 module_param_array(codec, uint, NULL, S_IRUGO | S_IWUSR);

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-isdn-962fb4bf23b5


