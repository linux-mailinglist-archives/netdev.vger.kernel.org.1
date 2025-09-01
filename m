Return-Path: <netdev+bounces-218669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F77B3DDF1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAA2179164
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A97630DEC4;
	Mon,  1 Sep 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EtZkLnMT"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B953009FD;
	Mon,  1 Sep 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718376; cv=none; b=Hgvhy3Kt8sqUmMT/LYZ8QWNZNLLHTCt8wHYu7ghREd9feP3KaUXFahYzEifUORti0UdGFGdQN17YzAzfShLVc1X3zsQ6G8ecCLeVteCEEus7OyomZX/zhkdSwVFf0ow0pQ4SiOGVUKy5dVbn6DoYfHmVvG0GzFJEa2YKpxN0PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718376; c=relaxed/simple;
	bh=x9+qStFH3vhT6vgaL7AtTnwgZk8Tdmt87ijVQfufUtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rheALd4IEO56pk1qharP4tOI9hLxMCLcOztAj5gGvY2pr5NkJ3mU1WXwCn5DdHt2Nnl3z14SydWal6UE2ZM62Xb9Y7VUG8mVhLEIbVIGC14cf59FwlN2pjxFCtX1zMc8k9JQfNso2uifMpePXtf+U2TNDTF7ycWVO02fHbmv/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EtZkLnMT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5818RZ5O025349;
	Mon, 1 Sep 2025 11:18:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZOIIyAi/+GlYEL6Pahn/kWUROmPQ14HPEuftxMS5fFg=; b=EtZkLnMTGcZVaH/F
	7lMVN1cMkh4fc3S0pg0tlGW5h42V8oK+o3GJGFGzYbMGNyX+G1NdqD70kbIWkYVR
	8qHunwkZDuwtBXdXJ5XxRP2g45dET0liMaq0iuWeH9ZbSVf7a6t/Abdp+o/IhbP+
	TSe9/kqh65CZkMLJMUxSPzl01CL1LM2HbNOPyRdnFhEJAZibOdD+gC6yrcEwECw5
	9teqcU3aa0mI6zLqc4mHFV8oKIwJumDxnRFtYG5pZiN69ODC8Wl194sp43kGkE4v
	BmxziaJkv0L2D8oL0Gh+oF/eP7aQCW6hcnwHqDC4vsvrw2z3O70y22BOivJnvIUG
	va5qrA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqk6jtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 11:18:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EB4EC4004F;
	Mon,  1 Sep 2025 11:17:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 43BAB765CFA;
	Mon,  1 Sep 2025 11:16:37 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 1 Sep
 2025 11:16:36 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Mon, 1 Sep 2025 11:16:27 +0200
Subject: [PATCH net-next v4 1/3] time: export timespec64_add_safe() symbol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250901-relative_flex_pps-v4-1-b874971dfe85@foss.st.com>
References: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
In-Reply-To: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01

Export the timespec64_add_safe() symbol so that this function can be used
in modules where computation of time related is done.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 kernel/time/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 1b69caa87480e7615d44ef409b96c081f2d15395..0ba8e3c50d62570d7248dd02a80395cb0c51c42e 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -858,6 +858,7 @@ struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(timespec64_add_safe);
 
 /**
  * get_timespec64 - get user's time value into kernel space

-- 
2.25.1


