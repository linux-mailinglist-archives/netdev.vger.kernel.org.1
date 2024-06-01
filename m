Return-Path: <netdev+bounces-99880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDA8D6D47
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AFA1F22463
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19DE4C8D;
	Sat,  1 Jun 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hu+KnvrU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659EA55;
	Sat,  1 Jun 2024 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717205752; cv=none; b=p1mEPLnqYo1ZxHE7Pci7FQs5QcktZHpcO+XFDMilPta136p702NBW+0j5q1mAqlAYOhTlblt9Nq1ec+oQFRTz3gu9huQtWVLsjUBk3kcl2qiLUztCuWXDUHZKbKSFYCjrVeaNS812AuPo4bdO7rHtYtFJonrjc4UgNpgZDe7Q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717205752; c=relaxed/simple;
	bh=JIE5jOBsrlzZ0lEBPCZS1yYi5SPKvHwIFS3deAbj+uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Y4AEzAGOa4mWhaQACdW6TkFa3XczwOIvqvu886PMnMvMZHONVpVFnPTwjAgV0zxWqpGcTHucj3HnkRuutASLWzEH7nhITQFRnfjtCWuqF+qPG0IVcgVwzH2P3GU7Jkm6+tulxh8pFNbSQL6c9JuySRCwP3fmMlOdhInqY0nCpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hu+KnvrU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VGXrxl003132;
	Sat, 1 Jun 2024 01:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2RJguZbdCcE6FZLVBkMIrT
	6V48VaPYg6v2ZfQzLv98o=; b=hu+KnvrUlNh2flrt/fnDI8dKU3VRd3I7y4jrJ9
	WJ/a9PhIh8NG623qZCEiyWMw6vppyzZMgQP4TzZd9cFsCV9dbEJm8lUVcwHKyNHM
	nWashyK2tvd0Yialz+H0NxbyJCNpulcq6ac5w6+z0mQY/d6fU5Rqy9QfOsNwbDvN
	1iOUBY+JCgNz0V09Blpno1EP6X5zBJrq4Iz8Fia1mJ8ObgTSMvcgVaSXGgncjycC
	xvCqKvTgSKoqGzzNq87Cear8CTxlxj6lwt9FfMN79H4fn8C9H8dCKQy3pWRuQhnN
	TYnkcoT5O+6ghHCHDH3S6MtJ8717WdS5lZsUMROoWJCIzp9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfa9bjj59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 01:35:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4511ZiN4018678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 01:35:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 18:35:43 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 18:35:43 -0700
Subject: [PATCH] lib/test_rhashtable: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_rhashtable-v1-1-cd6d4138f1b6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO56WmYC/x3M0QrCMAxA0V8ZeTbQznWIvyIi6RZtoKuSVBmM/
 bvVx/Nw7wbGKmxw7jZQ/ojJszT4QwdTovJglLkZetcPLhw9LjNmiVjZ6k0TWaoUM6MfgjuNcWQ
 fGFr8Ur7L+h9frs2RjDEqlSn9dlnKe8WFrLLCvn8BRb4hhocAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E6A4vEU4dtSJMEaBdutNQky12Qni-kE5
X-Proofpoint-GUID: E6A4vEU4dtSJMEaBdutNQky12Qni-kE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=895 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010010

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_rhashtable.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_rhashtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 42b585208249..c63db03ebb9d 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -811,4 +811,5 @@ static void __exit test_rht_exit(void)
 module_init(test_rht_init);
 module_exit(test_rht_exit);
 
+MODULE_DESCRIPTION("Resizable, Scalable, Concurrent Hash Table test module");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_rhashtable-145086b6e15e


