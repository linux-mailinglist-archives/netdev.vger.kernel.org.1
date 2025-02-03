Return-Path: <netdev+bounces-162132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B5A25DBB
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41EE3AE8FD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5D21128B;
	Mon,  3 Feb 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ij8cHDMl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87AD20B1E4;
	Mon,  3 Feb 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593915; cv=none; b=UQZBfxYnUNpTZCaIQEByIy4z+N00U1pyz9Sy8LYAFqxG8CxRV4lNySyllwLXbMoC14N7fJkCo3lHl4cckxOu4jZdkeSSsP7cbtKqtR0qczxuOg7I4ZZT8AnSiXiNLje7CPdm4Xgnt3wi6Xnc2VzBVEJu/VcJgsfSJBhye9f5adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593915; c=relaxed/simple;
	bh=yJB2Hfilr7DNORiuWue2liungMUA6Ftaxr2PrBcFoJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSa7jVVgx9sPfUsmXxEdOoYWZC67SxQVoaLi2by71W7Hc7ItJ8O2vCxzQZ9mEVZcJVPg2yS6pBQw4s0KJ3bY6OpS/Erf9sXMi+H4VUr93dnuMd/M6B6O47VCa6CpWk2NaCatP/NQfEe1ZQYA0dfvWxg0Duf9cBjQZ9WIWojJnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ij8cHDMl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513Cn9Ht028850;
	Mon, 3 Feb 2025 14:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QMbi0p6QzsDqbBe7Z
	uf2uC7AQIslfGBnquGb7Q0ssVQ=; b=Ij8cHDMlVvGKdzZg/f2CNYe9335dQgUbD
	2AyYXJBaNGN/qDpwDWlSNk+LYjAF7moex8hm1PP6pHw1iHbBHuQbAF1JyFB9FOhG
	n7T4U3mJzVYFbcptCwdOMxaAb4wReQoJz38aMCaB933Tid5CYwofGS7+jQIpg41d
	oVRHh0mN4TxVdhVVH0XZRwm3Xfe2eTwbelvjYWarFNr2SediL4vLTTyQh8/tajEK
	EJo6Yxmk34P/s9tMb9WVqY7LkNMCXqHsTY38jC8z2o7OGD0Ae/4bR8y7vm5sUMAm
	sbNdo6gVJs5AW/HoCCHAEb5nHW9OM702fPYwe4ZpTxFM4u5n+TouQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jayyd20b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 513Eevex025869;
	Mon, 3 Feb 2025 14:44:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jayyd208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Echff016315;
	Mon, 3 Feb 2025 14:44:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxs709m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:44:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513EiVqK24314604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 14:44:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915AD58059;
	Mon,  3 Feb 2025 14:44:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9189558053;
	Mon,  3 Feb 2025 14:44:30 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 14:44:30 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v7 5/9] ARM: dts: aspeed: system1: Reduce sgpio speed
Date: Mon,  3 Feb 2025 08:44:15 -0600
Message-ID: <20250203144422.269948-6-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203144422.269948-1-ninad@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g0jUcbiAnKLkpnywPyS-x7Lk9t418cQl
X-Proofpoint-ORIG-GUID: KC7nZD8i79-H2m7o0qi-m981TkoK3efa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=497 adultscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030106

Reduce sgpio speed to improve stability with the current PCB layout.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 973169679c8d..ca55a4fb6dff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -401,7 +401,7 @@ &emmc {
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
-	bus-frequency = <1000000>;
+	bus-frequency = <500000>;
 };
 
 &ibt {
-- 
2.43.0


