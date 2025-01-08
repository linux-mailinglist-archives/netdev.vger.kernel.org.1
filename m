Return-Path: <netdev+bounces-156339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F41A06218
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2034B165CE4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205672010FD;
	Wed,  8 Jan 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N9ipDxlV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DC200BA1;
	Wed,  8 Jan 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354261; cv=none; b=X7SKeOC15m7dxUpeMi6S+jcQPtN1QSLgkFaBwS6d/+uZYjHPZfi6KI0ewsnIPhsktbXO5PmMWXhyuXuizYcYjONEP8xBEK7ZuuttaWNz1spJxSLG0cfjoKmG60sOcKqujpUIEiC9yMuvRXGCzln+PfsS0Nsp/8QEtJGSzzmreN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354261; c=relaxed/simple;
	bh=IUYSMlmyPbe553v17BzTA1gbJf7dnKPYiPQqrbwIvaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjUEyITXeuAbJbAcQ0/Jxyho661N5wnZQ7SnyrLqcLp0hQvTZrRlxDNpOcGC33s9dXD7PkbjmyASzczsBPosBZ4C0QgGp4Dfe0s28ayKsadZDUHmqryTpDrpYSnDWnD6Sb9jRcdYHMFwOYVzSj4cvtBiYXTCsiOOY2qUaVvvRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N9ipDxlV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508E7mnd007009;
	Wed, 8 Jan 2025 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A0j5sE9aOONKyfKSV
	WxxzNoKelh9NbjPLewnzBLoOgQ=; b=N9ipDxlVEnuS161mWYwjor8lOqoD0JLM3
	D/mSSC1r1eIsD340y9ypUZFbrca7C00tNUzyiH02q6zhtMCRSl3GvvCdw1CeD1bE
	e0N8EErIrr9ii2YPk3fl/kbtw52B6b0wiYYdOI7ymIqE+jcYXD8KFX9O7wppWKtl
	7Gr87l4txtMsE9hMBghTjEwp3aP6+kOhYOWOAVI/00PNhQbNVshSaUVcpiiIeLZm
	ltR+BSIzzzd6SPZSjW1jQheF3/nVmIyqjYI6uC80L20tM0WGehXOIZRV2YgrYbnr
	l1VHGgJRPpenVRkDg+5cmQ/p/6g+g9IEd+gPE3kxI/iSRT5pW3lBw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupuc9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508GarHW012572;
	Wed, 8 Jan 2025 16:36:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupuc9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508GD77V008851;
	Wed, 8 Jan 2025 16:36:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq00u7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:36:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508Gap3223593692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:36:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08E5C58059;
	Wed,  8 Jan 2025 16:36:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B0358058;
	Wed,  8 Jan 2025 16:36:49 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 16:36:49 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 06/10] ARM: dts: aspeed: system1: Reduce sgpio speed
Date: Wed,  8 Jan 2025 10:36:34 -0600
Message-ID: <20250108163640.1374680-7-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108163640.1374680-1-ninad@linux.ibm.com>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _b22zoSXZ-ZBv3kWBfifa9GmFGGV65H-
X-Proofpoint-GUID: 0BGLnzoTbwWDiBy8nrV4DDUUGhrBu0nP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=518
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080137

Reduce sgpio speed to improve stability with the current PCB layout.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 0f4658074709..a37dfd359836 100644
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


