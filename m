Return-Path: <netdev+bounces-209735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C7B10A45
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563D517FC26
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46D2D23A8;
	Thu, 24 Jul 2025 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ud4Axkwu"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54C2D12EE;
	Thu, 24 Jul 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360442; cv=none; b=TJ/Fj+P+HS+ivyaf+7dIy7VEhf5KLOvqmhZitZRLIs0OOZdpi73QG6/S6yAsQ+k69c+H0Xe4DvQj8HU9AoEgFdEObxqsdYAbFmh25cekRiL6vRCrHjCSWH/L888a/ep3HFMx9aWK9adhoS+AfJ+6nIlCgeDWUEZVOisOnrwie8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360442; c=relaxed/simple;
	bh=tQuDVkAEuMKTMvmQ05pcXKXtdKrmxV6LqTedtmsA1wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D0Ix0/DlzkCguAlCNqHbRVXreMF077Pr3YoCsWBdcXVzH5M+++Yp43yJOQ+UdO4+18sMo0m9Ow/0k8wFPJ2g6zGWoUrT2qYSPpkI8vEwj67CXwbhe8N9WM0sVS4LiEp7uuRQLZwhnS94SNV1Vtoh9QPiViEeDJG4F6TByCTu91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ud4Axkwu; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OCPeVY008693;
	Thu, 24 Jul 2025 14:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	nyU692W3Jvmdf95k36VC5FdgflhzS2ZTohkfeWvfhbM=; b=Ud4Axkwu+0YWcOgi
	Eh4nl/nesUnrIypOY5G9wZN8EP9LDhwLIIY9TnWKKLLQ/vcEVkws7lhJWQIUyLwa
	7GKfylwrcls+sXWa8C4jr9h7Zpcs+OGvs+CSofJ2rCOqYCk572r8GE7789/s0frV
	IcexsHP5kJqUrTH2qTOUTZEktTjThPSMaiUcK4sJidWI9P0STy9awL3WBZ5m8tdU
	JQgjUfNTJG4crTX2aRcJXTDiDl/2EHCR5QqsSv7h4n858rLnC1epmlNsxxR4bqBk
	LfodQKN5mnf8KCHj5fzjzN0/Ae4OOy48b0KkfLjzQfToTZEIyVrKAkC0t/VU9EUK
	PrBpwg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800sma0q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 14:33:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E44B40045;
	Thu, 24 Jul 2025 14:32:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA13E6CAE48;
	Thu, 24 Jul 2025 14:31:39 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 14:31:39 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 24 Jul 2025 14:31:18 +0200
Subject: [PATCH net-next 1/2] drivers: net: stmmac: add
 STMMAC_RELATIVE_FLEX_PPS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250724-relative_flex_pps-v1-1-37ca65773369@foss.st.com>
References: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
In-Reply-To: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314;
 i=gatien.chevallier@foss.st.com; h=from:subject:message-id;
 bh=tQuDVkAEuMKTMvmQ05pcXKXtdKrmxV6LqTedtmsA1wY=;
 b=owEB7QES/pANAwAKAar3Rq6G8cMoAcsmYgBogiepOJj+6zBgJKGR1QWpMHgCj/2KXISS9wYho
 SJvBiIKq8KJAbMEAAEKAB0WIQRuDsu+jpEBc9gaoV2q90auhvHDKAUCaIInqQAKCRCq90auhvHD
 KLaiC/9On+Ebw9p4ibBEYz07w/Jk1lDM7Mn//IQk4k38nWOC9u7CY1Hqa1omnHb3zbYTvmoA0ji
 ddEr4Nobe0F96RX0dMpibENzbvLZaGeTwkCbi220H64/5tgtKPXPrKBR0p4ls1mrUCde/TGNLJ5
 HXtxRZ8CFvMKY2TfCPHHOWGYpCJziiwrxJ/UkFouI6Ml9xI/Ymn7y27V1CPTDa39keLTUnN8SZZ
 2np9QIYV0xRdry439Ag4h1MZwmFx85ySclx+7zLdezw/Lr4FA+KMBfL3YB96EzNq7X4XZGmaOIi
 OtJBZJhsvLTGNt/zZEY9UHOuf+YcDQOzOwrKtoPwT9yLgRB8NEOxZ3unNDIpLEvc6RvA9xgZu1m
 TVmFisUQlK6A6rcnPX0M/z5Ua6nfymh9TJKWWxwoWKtS2aJFfZXp78yW99tmo/jq3MmviBmK0ZU
 Ep5/4h3JtjcqFt+WIN4iu0SBmx0icv2rNlDeHx2pAzhHUtYxAMLrED2YZt8Jj8ncZ876I=
X-Developer-Key: i=gatien.chevallier@foss.st.com; a=openpgp;
 fpr=6E0ECBBE8E910173D81AA15DAAF746AE86F1C328
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01

Add the STMMAC_RELATIVE_FLEX_PPS config switch so that the MAC system
time is added to the requested start time when configuring the flexible
PPS signal start time.

This eases the configuration of the generation of flexible PPS signals.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig      |  9 +++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 67fa879b1e521ef6d7bd2a8db30d812301eb4cf7..949c744d30f19f5ff480dca4811e678d2b93c450 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -357,3 +357,12 @@ config STMMAC_PCI
 
 	  If unsure, say N.
 endif
+
+config STMMAC_RELATIVE_FLEX_PPS
+	bool "Support for STMMAC system time relative flexible PPS generation"
+	default n
+	help
+	  Say Y to add the MAC system time to the arguments passed to the
+	  PTP driver when requesting a flexible PPS generation. This avoids
+	  the tedious task of passing an absolute time value when using sysfs
+	  entry.
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3767ba495e78d210b0529ee1754e5331f2dd0a47..cc898eab4df6a3e2530a8b03dfdaa9016d1bb0b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -180,6 +180,19 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		cfg->start.tv_sec = rq->perout.start.sec;
 		cfg->start.tv_nsec = rq->perout.start.nsec;
+		if (IS_ENABLED(CONFIG_STMMAC_RELATIVE_FLEX_PPS)) {
+			struct timespec64 curr_time;
+			u64 ns = 0;
+
+			/* Be aware that an offset too low may not trigger flexible PPS generation
+			 * if time spent in this configuration makes this relative time already
+			 * outdated.
+			 */
+			stmmac_get_systime(priv, priv->ptpaddr, &ns);
+			curr_time = ns_to_timespec64(ns);
+			cfg->start.tv_sec += curr_time.tv_sec;
+			cfg->start.tv_nsec += curr_time.tv_nsec;
+		}
 		cfg->period.tv_sec = rq->perout.period.sec;
 		cfg->period.tv_nsec = rq->perout.period.nsec;
 

-- 
2.25.1


