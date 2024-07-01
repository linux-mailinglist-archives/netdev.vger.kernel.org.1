Return-Path: <netdev+bounces-108002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF391D842
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2411F223C2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61547F45;
	Mon,  1 Jul 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UIJMjsDj"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA844384;
	Mon,  1 Jul 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816654; cv=none; b=XJEYQvAjiCRCEI3vafJ2pXWssvlQzV+RlLnh9EwWjS3BWbLw7LRynYPtMS7fdpnu0qN2SxAsFlNk4PcdXAamU8ZvFFOmwbNoDG9Tuuky8pSHkaDgijJcKaMy1FHX2tXGk0bL4bah74vQHAoeKyEURN7HLAf8gE8C54wPzQNXfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816654; c=relaxed/simple;
	bh=AZi7uHA23J0AutKfzo4p0SPt3fNTDJpKBbFbPfCzMhk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uq4mDN3+FtNFRwd3fstEeK5FQCQ+BybDlV8fGahXuDP1e6cxSUD4oHUMBUQZktRjDi3H4Dp5YG/z0XlefpvYbbdU3xUsdMSEQbe4xqZAyQMeclDZWmef1ZG+m7CKebZ4nFi+0bzvHJx/O37vhJuFynbmiC37ZRDj9h5oyMFCnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UIJMjsDj; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ULXMP3007786;
	Mon, 1 Jul 2024 08:50:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=nIXaCbx5fzZINYW6u5h5gd
	T7P1fyQU9dEhX1xxpILlA=; b=UIJMjsDjLsSzjnw3Kq2GAg0Mx2v4FxLjfoAOHy
	x2Lfs4QH9enNIf8hAmHESqWTUpuOggGfv4gJsx4hw5fjaHB68Mj+EqixtD+AoecC
	BSh2ce970y/nq3qIDXAn3hE2gLOPSPO0wvhfNMcI1av1g031kow7TW/thKT9BAuU
	JiyyF2eEvY7tWwddshmSD6nOv6BAappoZz93A9A23UAkfIhPwJrBMoPkxzBNYn+P
	E1IHaIvZVSWszh3s75gLd6lsDlDjNhk6kNaKJEPL4jys6k5yJMSeV2J+2bMZNh4k
	pLZDMLmMp2Zp3EqTz7GM/pjLY+C5A/bkfntcmvtlmkJSZbsA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402w7hu3xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 08:50:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0BF4740048;
	Mon,  1 Jul 2024 08:50:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51E19214D04;
	Mon,  1 Jul 2024 08:48:45 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Jul
 2024 08:48:45 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next,PATCH v2 0/2] Fixes for stm32-dwmac driver fails to probe
Date: Mon, 1 Jul 2024 08:48:36 +0200
Message-ID: <20240701064838.425521-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_05,2024-06-28_01,2024-05-17_01

Mark Brown found issue during stm32-dwmac probe:

For the past few days networking has been broken on the Avenger 96, a
stm32mp157a based platform.  The stm32-dwmac driver fails to probe:

<6>[    1.894271] stm32-dwmac 5800a000.ethernet: IRQ eth_wake_irq not found
<6>[    1.899694] stm32-dwmac 5800a000.ethernet: IRQ eth_lpi not found
<6>[    1.905849] stm32-dwmac 5800a000.ethernet: IRQ sfty not found
<3>[    1.912304] stm32-dwmac 5800a000.ethernet: Unable to parse OF data
<3>[    1.918393] stm32-dwmac 5800a000.ethernet: probe with driver stm32-dwmac failed with error -75

which looks a bit odd given the commit contents but I didn't look at the
driver code at all.

Full boot log here:

   https://lava.sirena.org.uk/scheduler/job/467150

A working equivalent is here:

   https://lava.sirena.org.uk/scheduler/job/466518

I delivered 2 fixes to solve issue.

V2: - remark from Marek (commit msgs)

Christophe Roullier (2):
  net: stmmac: dwmac-stm32: Add test to verify if ETHCK is used before
    checking clk rate
  net: stmmac: dwmac-stm32: update err status in case different of
    stm32mp13

 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


base-commit: 30972a4ea092bacb9784fe251327571be6a99f9c
-- 
2.25.1


