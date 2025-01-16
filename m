Return-Path: <netdev+bounces-159042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50AEA1436B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CA7188C499
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78E243860;
	Thu, 16 Jan 2025 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j/JW9jqg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1224384C;
	Thu, 16 Jan 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059784; cv=none; b=n/qedJ1mbeHrjj6xPanrGk36A99bV3fxhxtcpo6ECXQbqNSMvoRCPFm7x9W2iaUumy86DlB+tPo+K4gTVW2ZnsYmR9x1wUJwteqvQPp+Bg9dui3uebwHrx3fnCcbmnTyCLI7bKi67hBD5fKvGm/h1V5UtvQStcShTzozEQ5CJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059784; c=relaxed/simple;
	bh=JNgOBky8YTdkzf8sCSOrfEUveyu9Mgt1/G9YQ/r+ZSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hONQo2Xy1kkF4brNiUxCHz/4Sm1A93NAS/ZGVUNPD/CfGqmG5+H2bRse9x++vCnsncfT9abjB4OlsS6IhL7vvsePyZZ/4ErMp0+zGMWS6o8zF2cNt3gz1dKN7e8HZPFYnPuStxenLUGqXqqzzEGHI/FX//62+ecCdaiE7OElIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j/JW9jqg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEDwGc005796;
	Thu, 16 Jan 2025 20:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OZL4iPau+sdhd2rI4
	14iLrHV8/fKRY51pCEXjhW/D7E=; b=j/JW9jqgJ7mdxOGWxmxnRKGM++9YiTENr
	lLhsadqhZlYEuD3ZUqHX+rPzqSlxD9iho+1y/2jsmQ2uebonBp23znZI/zfTTjcn
	RSRhvQEHCmdUytUhE22v0LFiKA5fUSc7k84fsIUDQT+3DDRZmc89QB7ewEyaHKLy
	onLjWOccoX2w09e28p0zswS7u/+YgOlWJTN/TNVflK7ePdtAlHGv+oFt0GrzIyjm
	Fyg3AMuxP8Skem7OcoQwstvwozdjC24xQ9hYF7CgkKeAzb/ytKGCHoYLoyTCWUHl
	wz/MSLu5tTkzaHy+lfwEhk+M3Y2pICKSoN/vAs5um+ZXudvkJYnag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcmnvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKTcmc004469;
	Thu, 16 Jan 2025 20:35:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcmnvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GKUGFb004543;
	Thu, 16 Jan 2025 20:35:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442ysyt5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:35:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKZZ6P23396986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:35:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28725805D;
	Thu, 16 Jan 2025 20:35:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04D558058;
	Thu, 16 Jan 2025 20:35:34 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:35:34 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v6 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
Date: Thu, 16 Jan 2025 14:35:18 -0600
Message-ID: <20250116203527.2102742-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116203527.2102742-1-ninad@linux.ibm.com>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gYjtnMl_HE0nYvod0MqUM4Sfq-oyim9x
X-Proofpoint-GUID: YY6ihM2NP9ImwK6Fb_ttY3wmC-nb7q8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=967 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160151

Allow parsing GPIO controller children nodes with GPIO hogs.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
index b9afd07a9d24..0497d19a60e9 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -46,6 +46,12 @@ properties:
     minimum: 12
     maximum: 232
 
+patternProperties:
+  "^(.+-hog(-[0-9]+)?)$":
+    type: object
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - reg
-- 
2.43.0


