Return-Path: <netdev+bounces-164795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B250A2F1AA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0433618871CB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D823ED65;
	Mon, 10 Feb 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="n57dDZoY"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3723E252;
	Mon, 10 Feb 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201119; cv=none; b=J6/FG1a1NkubQa66OuNTZFb1y+NHBgqs9bRfQN+bn8/P7UxOuj63eyo1rgVEN97iNtAYymnP05PKhzRHV0bp6COSIV7uAohq/1I6+OYCnAutgvv9XLr/DuUQepWVvRf1A0mf7VHp/oMnqCqx7lsMqsvGy1NJFoisaqbn4cGwdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201119; c=relaxed/simple;
	bh=Q6CvkVjjHzVacxeIqy75tcalhzv6w8xiJcEiyHM0WlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Gd3nNxplHRo8Zq58r8R6WWtAgih4BfujJirp4fODE0KgC6bgxCr061BVqYueSdmp5A/8DsHFbXAk+dpDf5ZpsKuGSenZA1gyp3QAlrAYT6Xso0hcWSiUFFZVTydvO3sdQu9kzBxHf0KCCqH1m7m8saENH7iRYvpKUA3P1rNOK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=n57dDZoY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AF0ovo004875;
	Mon, 10 Feb 2025 16:25:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	sAVFmGuzKMIVO4kP/TyOTUlo13poToQcbmat3haYAjg=; b=n57dDZoYOnNChQdS
	jd7aQsrCfPCd/AavL5uKSz/xXiqwrAApJshhKeXD9fYqy9cZyb7SaOhOYtpzfM/8
	5mgakO8TCfQ0uxWEGIvIValHrwqOeAJAzG166HGRpt1UaiSEYtViqEUdGOv0nI+Z
	pQsPomB/ps1dGD0Af1s064iz7PLAQUXiibW/WwdATCs54zT5xECXKbd7jdPQ2sCT
	24eg6u1pkXH4aiEGahzkT7wAe05rGzSMfzl04Vnm22fUur81/RaveesJc3J6fHVc
	KJW+f6Wdo3LL8CyG6yN7DJHMM8Esq1wXX/6ZuQP3SRrGDWxcCcmwmv5wsEwapQCo
	EeS18Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0qry063-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 16:25:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0A30A40050;
	Mon, 10 Feb 2025 16:23:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6FC7F29522A;
	Mon, 10 Feb 2025 16:21:40 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 16:21:40 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 10 Feb 2025 16:20:59 +0100
Subject: [PATCH 05/10] dt-bindings: stm32: document stm32mp235f-dk board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250210-b4-stm32mp2_new_dts-v1-5-e8ef1e666c5e@foss.st.com>
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

Add new entry for stm32mp235-dk board.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 7cf9c6be0388365e6bce5e34a00ccf0a0eaa89cf..9ffcba51c9207b5a1386c025f850bc594c915c8c 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -184,6 +184,12 @@ properties:
               - st,stm32mp257f-ev1
           - const: st,stm32mp257
 
+      - description: ST STM32MP235 based Boards
+        items:
+          - enum:
+              - st,stm32mp235f-dk
+          - const: st,stm32mp235
+
 additionalProperties: true
 
 ...

-- 
2.25.1


