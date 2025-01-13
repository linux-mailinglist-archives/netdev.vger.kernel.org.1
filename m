Return-Path: <netdev+bounces-157872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204EA0C1F0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9FC16B891
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC11D4339;
	Mon, 13 Jan 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c8LIjZdH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A11CEACB;
	Mon, 13 Jan 2025 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797755; cv=none; b=M+AegMqS1AWtT9JNcRsSHbKu5xsDmbDEBus91rsbDBLQS7rWNvh2cg42/dlkz7+tseheqKGNjUR10SJT9/J9OHQvctUgFN+OAFVYy0KmuQk1IUnto/q/sd2nuJd5G29STUVJGvn3uBpUqkykIahMn/Y0z6VvhXbrfWVl0UQldog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797755; c=relaxed/simple;
	bh=ay/xlLnF2UIkqMJHUCgw4xMC7ig0hdNfW+uwg24oVzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVmAduH16ZZOpKLMRR2M+dR5z9JG5NYLsWv/lRmMUzQLAtkHFYDIAUT3ueqboMwybw63J5y8N07+lFbQ6WDKtcGyGTumX02tfYon6RCB2nQWPxMjnLtZRiV5DwxDe/PXos1+I8A0YQ5xHc5Rmg5BlFHzrIXB9nA0UPCWn/8ycUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c8LIjZdH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIbP3F032714;
	Mon, 13 Jan 2025 19:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zcXYfq7y3Ykx9nkv3
	r9zTbWUpugtYvbNec4z//sgjIQ=; b=c8LIjZdHl6Cd5dc+1h6a7G3fjiTLf6zlP
	LpdvaAGWUouTPpcZwcLTEKIq3ZP+TBveXP8zy5Kz4PScPnnZjCeIzJGHgG4Q2+09
	Y6XLTk2asSfad9IiityzpIMhATcFyfo+oeZ7/UPo9zDywjsSWo7pZdtasDEuYKWE
	bT6q0G1eYN619JkXHdfrvRPyGBZzEVc9Hq8GzUudh0l7Ga3AeZv3ee5Kob3yseV7
	k/S6nJPyeRwG7JIswWbcmLlJpwBMWGmGDwdFxvTVIkThRdd/YPy/BCLfjFphF6bR
	2jpGc91D2/qACkDilfMT+CAeN7XAFxbQjpB+8aGVP27jr74B87h4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12k1mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJj5E3012606;
	Mon, 13 Jan 2025 19:48:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444y12k1mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGU2D4007385;
	Mon, 13 Jan 2025 19:48:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ymytu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:48:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJmQfe56099298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:48:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A845805C;
	Mon, 13 Jan 2025 19:48:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EA5C58059;
	Mon, 13 Jan 2025 19:48:25 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:48:25 +0000 (GMT)
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
Subject: [PATCH v4 1/9] dt-bindings: net: faraday,ftgmac100: Add phys mode
Date: Mon, 13 Jan 2025 13:48:11 -0600
Message-ID: <20250113194822.571884-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113194822.571884-1-ninad@linux.ibm.com>
References: <20250113194822.571884-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oBRstM-pFhSHUWiJLP9YehXUO1lwOtpe
X-Proofpoint-GUID: i3vzuHI3zn6mMqmw_sifEBhk9oDMLmqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=953 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
document them.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 9bcbacb6640d..55d6a8379025 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -44,6 +44,9 @@ properties:
   phy-mode:
     enum:
       - rgmii
+      - rgmii-id
+      - rgmii-rxid
+      - rgmii-txid
       - rmii
 
   phy-handle: true
-- 
2.43.0


