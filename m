Return-Path: <netdev+bounces-155935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD91A04618
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C1D165D7F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910061F867B;
	Tue,  7 Jan 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V1a1ZQCW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40C1F76D3;
	Tue,  7 Jan 2025 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267089; cv=none; b=p6tOtjEmSjtqN+Fz7Z4hTjkHjU6NrddOOrmEzTPBQmuciRxMnjl+k7NhV+YKW5oDllXxq80A7egqv4uL5cc+lDdNWsDNnNOjEc1R8VEXS+mdGvjhE4w4TvxMiLEiGgHkgb5ThUZN92VXxFVhZ+alg9brhBLUnaV3jGn61sK+p/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267089; c=relaxed/simple;
	bh=WG5W72U3UeMNQ/YBlKLibVSSSdOXtNPkWvTfTzEvk/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1fOPOREoNuAZBjAD6R4iteIt+kxMA6QoeZVCRRIXhGGk4zShEPNs7s0BFPdYR0u5EbY0P5F2458S6jPsEEOAo7W5ouyo3gDhYcgyySoeiA/ljPJSbMns9srqRZKjTZfH2YBLq/Mu2bpBr4JZ5FS2+wTwPhquaVcudvvHePLARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V1a1ZQCW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50785l5J018139;
	Tue, 7 Jan 2025 16:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WH+uKcwDLru4i84yV
	cDK6Dsm8M/CrAvcndmIvrw40gU=; b=V1a1ZQCWMRo5FgPprJPc61lBbJbUCD+cC
	DHR7v1tllcikn1r5T4hVaC+ccf86n3tMNtTAkvDtOc7MargTg7bLOHTdSRHkRSsl
	ZzWvdAz7XDxd8DZxadzG3Snid0+W4PrazAlC4fkU2eld3knmwu+AH9My9M5RxmPi
	tlsmd00teR1AljODwDft92uPTLFjGE4BsoHbDgb97rJIwO2y15Qukzg/NL3XNwlN
	DK7FOlBcnnmmaPz0dODYqe4JyKAPv5Ym/YyffuGum2w9QCuhdG6Zw6niJ/BYTiG4
	HYXwCN0Pm/0j4O0NBSEbFgfe7VQusyzdm3eCPc3hWGk0YQELTiMYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3a7f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507GJsWS006918;
	Tue, 7 Jan 2025 16:23:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f3a7f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507GH1El003572;
	Tue, 7 Jan 2025 16:23:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat3gy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 16:23:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507GNqj827984432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 16:23:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0EE58059;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A6B658057;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 16:23:52 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ninad@linux.ibm.com,
        ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] dt-bindings: net: faraday,ftgmac100: Add phys mode
Date: Tue,  7 Jan 2025 10:23:38 -0600
Message-ID: <20250107162350.1281165-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107162350.1281165-1-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g-ldmg8YlgFXWnKJv1w0nQKF-sOhvBJV
X-Proofpoint-ORIG-GUID: NmjbsbguvddWjCNGyhOjEcThy4N-U7HU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=893
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070133

Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
document them.

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


