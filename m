Return-Path: <netdev+bounces-217250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A595BB3808E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BC746113F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55135082E;
	Wed, 27 Aug 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Kbrkm7UJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B27134F470;
	Wed, 27 Aug 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292868; cv=none; b=ECvubTjhrtzaOLrNeA+bSDq7hDkfyrSaLUoVtZClDvlMwAEpVvxVNLeS2Rs2kpu5ZMdJUooeWYAWmPqLsBXBpe1Z55lqKFb8vnr6JZdzekpcFulwOq2gKF55HdHtYPGewKsfoZRWfpiM0qGgIM1zsqyLdwG6EAVfU4YF6dgyWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292868; c=relaxed/simple;
	bh=dfWLmLM4fcHqWs+0qeq5y6Yu8wDw+LRFZYdnieqW+4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gnYEB9fcfPwVAfhrcXEfoSCamnVCeR+SC1huAaDxV1+y1Yu4QOQ2v2eofLA0yW83wZ/4ziiM2E8KHg/5emqFkVxbxp+uc+Fl6+OWxQxqIz5lH9Ork3FhZqxaBALRNNFSq2kkTryKlvvETsjaADdRQa2yhkbUK6axkE5ju8C42P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Kbrkm7UJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RAW8D1002006;
	Wed, 27 Aug 2025 13:07:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	UUbE5+HXPgCXyM2pbrbnV4w0pucLE/SmALUlu6olXkU=; b=Kbrkm7UJwR0Smznz
	hOCHdc6XJcLnofjInOG2sFYAEfABucR3GsQ2GZzD42nE0Bag6Hhzy9TeyOuwqPJ9
	2To+wl9T1MW5JeQj21XHJQmHC3Qa+2w2hC8jPbgH4IYreyAly/+6u2rzCUdyWu9q
	bKQBVKOGYivCMvDajg421Bw4sASi5NN1RsGYhSYcH2Zt99XUUqxb/wApH8KANMPh
	PhAS3kkCh7TqOwvEd8bGYGgKAQXC660SpyQJPRerhAP0hgQrwKHVVPna9qRp/wcv
	VEXXooz+X3Bl/b1ZDx/r25xTvAJVFjpacvZaeEuYY/tR3ivu2jnw1BODPQ4eldgM
	kOhPhA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5v07xpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:07:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 45C0C40048;
	Wed, 27 Aug 2025 13:05:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D37BB5E46B7;
	Wed, 27 Aug 2025 13:05:03 +0200 (CEST)
Received: from localhost (10.252.21.245) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 27 Aug
 2025 13:05:03 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 27 Aug 2025 13:04:58 +0200
Subject: [PATCH net-next v3 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>
References: <20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com>
In-Reply-To: <20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com>
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
        Conor Dooley <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01

In case the time arguments used for flexible PPS signal generation are in
the past, consider the arguments to be a time offset relative to the MAC
system time.

This way, past time use case is handled and it avoids the tedious work
of passing an absolute time value for the flexible PPS signal generation
while not breaking existing scripts that may rely on this behavior.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 35 +++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3767ba495e78d210b0529ee1754e5331f2dd0a47..0de10a309e1e945fddfcda39a6c388f3dfff7c92 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -10,6 +10,8 @@
 #include "stmmac.h"
 #include "stmmac_ptp.h"
 
+#define PTP_SAFE_TIME_OFFSET_NS	500000
+
 /**
  * stmmac_adjust_freq
  *
@@ -171,7 +173,11 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 	u32 acr_value;
 
 	switch (rq->type) {
-	case PTP_CLK_REQ_PEROUT:
+	case PTP_CLK_REQ_PEROUT: {
+		struct timespec64 curr_time;
+		u64 target_ns = 0;
+		u64 ns = 0;
+
 		/* Reject requests with unsupported flags */
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
@@ -180,6 +186,31 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		cfg->start.tv_sec = rq->perout.start.sec;
 		cfg->start.tv_nsec = rq->perout.start.nsec;
+
+		/* A time set in the past won't trigger the start of the flexible PPS generation for
+		 * the GMAC5. For some reason it does for the GMAC4 but setting a time in the past
+		 * should be addressed anyway. Therefore, any value set it the past is considered as
+		 * an offset compared to the current MAC system time.
+		 * Be aware that an offset too low may not trigger flexible PPS generation
+		 * if time spent in this configuration makes the targeted time already outdated.
+		 * To address this, add a safe time offset.
+		 */
+		if (!cfg->start.tv_sec && cfg->start.tv_nsec < PTP_SAFE_TIME_OFFSET_NS)
+			cfg->start.tv_nsec += PTP_SAFE_TIME_OFFSET_NS;
+
+		target_ns = cfg->start.tv_nsec + ((u64)cfg->start.tv_sec * NSEC_PER_SEC);
+
+		stmmac_get_systime(priv, priv->ptpaddr, &ns);
+		if (ns > TIME64_MAX - PTP_SAFE_TIME_OFFSET_NS)
+			return -EINVAL;
+
+		curr_time = ns_to_timespec64(ns);
+		if (target_ns < ns + PTP_SAFE_TIME_OFFSET_NS) {
+			cfg->start = timespec64_add_safe(cfg->start, curr_time);
+			if (cfg->start.tv_sec == TIME64_MAX)
+				return -EINVAL;
+		}
+
 		cfg->period.tv_sec = rq->perout.period.sec;
 		cfg->period.tv_nsec = rq->perout.period.nsec;
 
@@ -190,6 +221,8 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					     priv->systime_flags);
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
+	}
+
 	case PTP_CLK_REQ_EXTTS: {
 		u8 channel;
 

-- 
2.25.1


