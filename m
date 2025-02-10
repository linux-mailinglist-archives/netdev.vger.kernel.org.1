Return-Path: <netdev+bounces-164785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AFDA2F18A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273D916776F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257362343BD;
	Mon, 10 Feb 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="p9vF3wz5"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576412528E7;
	Mon, 10 Feb 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201085; cv=none; b=eIlU4hqHzbebJRPBox//66CwVwhexhZ0aVxRbfmiQqj2zT5EJpQ3GVp6+XUG6xq1pp80Fcg516tTRS55pum23a94q741A4tceeQYayENWNVx6hz671J916Z10/G6ynFe1a/sb85tx5HrsKqSXFFLCquP/MOnpjEODSlkPFuguKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201085; c=relaxed/simple;
	bh=RrrddgdXo772lyuy2X/JajBQ2JiCmVZxtBpkXIyV/lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gwEXFK+fK86j7QoJb7A4FKfs+MwV333B/ObXoMVuTCVOjLp7c46Vq9UCC5V9JddRKwWugVfUteoID6EJKegXa/WXGLos0EbOZhGyljDm5QYlJfKoqgpBqYoPwrpoyEVmFTadB+ZTW+klB2GCV9a9UbNbgogwtVYWerQNZBKHsMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=p9vF3wz5; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AF0k9D002292;
	Mon, 10 Feb 2025 16:24:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	XVA5ICq5nAYIo8gZGmJ4+8mx0W8LPY7vXxJIxOTznJ0=; b=p9vF3wz566Ej0xxx
	NLCFfj426citN9x4LK+LoWGJB6uOekdh9aSQ5uiLUL2BEEbkZRmD5RbOBEySnuyD
	n9UWm8JguI88gPdEQ5dp1dyHKJHApi1dVuerIY3PsNedRbjjYnTIZFQhKelxmLyq
	vrf3QgySVpchDinVgHXX7eMuThd/XRUiEbEcobRGaQs9tU+7MaIzZC2z4qBHF1jw
	kr5BFBJM44vyWltGw8YsI2hU9eyzGMhZynqOOmTK0ilsXcczEmPw17poETUpHltm
	kPN9scgsh7SaQD/gIW47JGZq6xshrP4CfocwxMttLBPxqdhgCdRVRI2vBeeayFiu
	46LGTA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0pyq6hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 16:24:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 526F640049;
	Mon, 10 Feb 2025 16:23:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98AE1294F43;
	Mon, 10 Feb 2025 16:21:37 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 16:21:37 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 10 Feb 2025 16:20:55 +0100
Subject: [PATCH 01/10] dt-bindings: stm32: document stm32mp257f-dk board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250210-b4-stm32mp2_new_dts-v1-1-e8ef1e666c5e@foss.st.com>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
In-Reply-To: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01

Add new entry for stm32mp257f-dk board.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 6825d965da3daf2b508fbd88e8c9d40e20ba1f59..7cf9c6be0388365e6bce5e34a00ccf0a0eaa89cf 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -180,6 +180,7 @@ properties:
       - description: ST STM32MP257 based Boards
         items:
           - enum:
+              - st,stm32mp257f-dk
               - st,stm32mp257f-ev1
           - const: st,stm32mp257
 

-- 
2.25.1


