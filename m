Return-Path: <netdev+bounces-178625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B6A77E4B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612B33AFF8D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860F205AAE;
	Tue,  1 Apr 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGQrgUnL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B0205AAD
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519231; cv=none; b=gZRHlLRfR+Yk5bnX0SIqmRG48XnlLc/k44/UoWQHPNk0f2g93Sebgv+vZJ8GD7vtNbm1pRBJo/BLPbvcY2LjUtzfJeRJx9hgnfZgkBla69WeoyY3Nwz1IFPAXMkBjjgBty2XtOqLIQKxU6BGj577QodKEehgsn7Ho2gd3nru9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519231; c=relaxed/simple;
	bh=A3upgMdd3p3F0mJjZSeVytonLMMt0jGHCZ5/TYwCOq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eV7RTb0KRgz82ONOLj+sbanXfkYUuI9EKxSSd3Pa5hPDojVMbWsdqkctbdNazG086jmvDBYbXZBoL2EUqp+URB7nRMEItsLQ13KkWTEugCpAtOZofO8MMaDMgc0AkqkqB2Aqlu0jVfK1YlMmXUhit2y3+G9Z2elHY/WPLNIyUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGQrgUnL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318LDgx008453
	for <netdev@vger.kernel.org>; Tue, 1 Apr 2025 14:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lMALD0Hve+i/GClWHdNV7zBXMss56VupDcZ
	53K5XeAk=; b=DGQrgUnLUASHQWVX2vyb2HmtnK1W/la8pY9fVmoLcevPN7QIAla
	+Voef6Cmc8DkslepifBEbqJ/pUmLzwVIh79fGZrTq47JwIF8LhAI4syxFisEZ+VK
	4ZI0G/pCFusbDbttIRX3VAyt5ANM4D0FmVusRu0mfh+pxXoGEpTZvv8J2vyrm0bL
	12+jkYjQvAqudJDRn+xJ6vm2bP7jq6prWapPLFV4a2Q/UBfIGNsMDd7fSE5jxfh9
	OlfMRfHH1ZR/rTQQyZAKeGy6ulRvMj6YxcDdTjQFhYPkYc1tFjD/HCeN5UBWG74G
	ZVAW2avXiNRB05ZN4kVPqF6aw96wARkTGJQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xnjtf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 14:53:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5bb68b386so23374785a.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 07:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519228; x=1744124028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMALD0Hve+i/GClWHdNV7zBXMss56VupDcZ53K5XeAk=;
        b=HbffHL+gck+fdd46Ud2KDPjeU8WJCrj9408yurXevnsS3H7ox4Ia9sdb8JAOGJIWFC
         /9NOjQtPd5/6whf+dmHxTd3c3x7x2jdcp2pU33hkcWzvoV1qBSDVb0L4fWkNEvFiS7GJ
         4iAxQuhi1XYaE7r0zuKI5MQ/Ly8ae8A4PgSpkbcIUQ43jhWuEdSEeL3+4wV2xfCBMMUx
         YqgPt7aVj1gAHvs/HAzutdXO1R/1kncGNqpgwWv6ZgpBZfUO++jiHxkY2UPFqfxyWjUN
         X8PYJKzOTGnZD15IMc1XjB493cJ9KM4Ont4YqYUArhEN/ifZp4q0afY+qQjDH3VD/3cm
         mq4w==
X-Gm-Message-State: AOJu0YyF53W7d4D2dzKXw5kdot30Iz6EiJ8EEjpKxQiYw5ELqLBZU/L0
	CDJiMLsITFEPlFdaddKmL6UxHa4Sea8RNL/JYG2+JQrHWfF7Q00b3eWhAfDuWITIvsU+LU6PkeD
	obvF/5ZTAZUzPD/gWMeBeKdZM/RVnKI1XNZmxrpy6m66NugQ6dNCgkgc=
X-Gm-Gg: ASbGncvpnwiZmdkZzEv2riCxaqFg9q/1jkTTdpsFWzqHRPu9aOWBx+R4uikTCKT6/a0
	ESNV32tqJ8c08mPYIZCv+KWJJBMTId/GRWg9OBJ8AcvAOsQE6vu3Ury749tDd3cJ2zeB71QChks
	tLlk3kqAK5F+2Bxhyx2JRBpw1b9jD7p65gF4yDd3mBDHa/b79C0spyZwXCvoWUYDUz2+lWgJ62S
	El+c+76BbqvUsGCx7X/Ixm8FUjd2fTA37bHcfvTQhDJWSeUhYVaM1WUuOf4Pu+rjo7FlvpvVIY3
	6QR7exVKKOx0OzRb1JB5wBg/vnYbCRPmtizFAGc4Fg==
X-Received: by 2002:a05:620a:4256:b0:7c5:994a:7f62 with SMTP id af79cd13be357-7c690880c37mr2454975485a.41.1743519228060;
        Tue, 01 Apr 2025 07:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG60zel+2OdntgSpBBCqRCzNiOzmmbqkzSTgiviMqr+3HXihB+Xj3rkGJqUxzTJJWfUi1eLkg==
X-Received: by 2002:a05:620a:4256:b0:7c5:994a:7f62 with SMTP id af79cd13be357-7c690880c37mr2454972485a.41.1743519227726;
        Tue, 01 Apr 2025 07:53:47 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:6ed9:ef2b:3b90:78bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658ac5sm14027430f8f.1.2025.04.01.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:53:47 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH net] MAINTAINERS: Update Loic Poulain's email address
Date: Tue,  1 Apr 2025 16:53:44 +0200
Message-Id: <20250401145344.10669-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NkE3hnNvgTcvqI9rR7LluMGjhMPS2Jo0
X-Proofpoint-ORIG-GUID: NkE3hnNvgTcvqI9rR7LluMGjhMPS2Jo0
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67ebfdfc cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=QcRrIoSkKhIA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=stkexhm8AAAA:8 a=_yfGIwS9ScqeBdm4lDcA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=647 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010092

Update Loic Poulain's email address to @oss.qualcomm.com.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16f51eb6ebe8..87e7c9ffe528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19545,7 +19545,7 @@ F:	Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 
 QUALCOMM I2C CCI DRIVER
-M:	Loic Poulain <loic.poulain@linaro.org>
+M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 M:	Robert Foss <rfoss@kernel.org>
 L:	linux-i2c@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
@@ -19668,7 +19668,7 @@ F:	Documentation/devicetree/bindings/media/*venus*
 F:	drivers/media/platform/qcom/venus/
 
 QUALCOMM WCN36XX WIRELESS DRIVER
-M:	Loic Poulain <loic.poulain@linaro.org>
+M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 L:	wcn36xx@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
@@ -25655,7 +25655,7 @@ F:	kernel/workqueue.c
 F:	kernel/workqueue_internal.h
 
 WWAN DRIVERS
-M:	Loic Poulain <loic.poulain@linaro.org>
+M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 M:	Sergey Ryazanov <ryazanov.s.a@gmail.com>
 R:	Johannes Berg <johannes@sipsolutions.net>
 L:	netdev@vger.kernel.org
-- 
2.34.1


