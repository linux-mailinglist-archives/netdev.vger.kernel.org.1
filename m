Return-Path: <netdev+bounces-102516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8EE9036E2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487D428B519
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33322174EE7;
	Tue, 11 Jun 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uZL7jnuH"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4F16F8F4;
	Tue, 11 Jun 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095448; cv=none; b=i7TmAL/HqibYO5b9gpfMSNOOpMPyDs3d2QkJZHtFrfitSSOyTvxoXfGrtHkRao+lJEPF0ajIFiJgHc+SzLsneZW5WlEkwRzvc2dyFa9fxzJbU2VmGv7fWtk2jNUD5ERYrbjNxYOvSIKpgt6qS+sK68iri6swHCUjVFhgkLgFOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095448; c=relaxed/simple;
	bh=NYMOrKfkc6kW2vS30fgFJOOm/ryamootxstP6BHo0GI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XeGXJnxkG95ehp0ONLNQkPLfuwpzWcin0MYB2wmZqNNAbyL/g5BjloHsHOv/wtUs4s4Rsw6TUGl6/PFwrbfxvBNukv4b0AiWvQLOCkk3cyS/h/kclw4MSV9uGIZm7W4w3CKROKkLOaz85OhhJVlyeh9kFi3TOmrB1sb8odT0kSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uZL7jnuH; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7WQw0028321;
	Tue, 11 Jun 2024 10:43:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=ZmwzfQtKqV4UgafJAGdvxA
	y0aBYL2v5t9WgaVchw/LI=; b=uZL7jnuHTMxE0ovCheKDBmAff1AWPl9gpTpIIs
	SPccTUtAaC12vE+YMbyfBKOePP0Mt5wUwCR5KiVj6GmsOizve2b7+5+8oO2B6r7N
	+sqhXbXJNOlkxxxpEE4lQfsRQ1TzhI2uMMjuu8sDnnxItV9PRJYFN96XZoJ6t2ga
	0tOa7GeuFxhdu870fCsS4Xw7u4nIfJ2nBoUWnesAM+gnWqHZqLl1zrrkfylG641B
	6aUXgzQZa6/3UDppAi+be6uHwaohPG7k3m7/QkwR/ekuJTztpV1aKelo7WSvNfeF
	+pXz7LBZNcFiEbf7sbOGUp75WR5wc4cWrbHbAabTlsgGuZ6w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp41t9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 10:43:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1382840045;
	Tue, 11 Jun 2024 10:43:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 61B302115EB;
	Tue, 11 Jun 2024 10:42:22 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 11 Jun
 2024 10:42:22 +0200
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
Subject: [PATCH v2 0/1] Add MCP23S08 pinctrl support
Date: Tue, 11 Jun 2024 10:42:05 +0200
Message-ID: <20240611084206.734367-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01

Enable MCP23S08 pinctrl support

V2: - Remark from Krzysztof (Change built-in to module)

Christophe Roullier (1):
  ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)


base-commit: bb678f01804ccaa861b012b2b9426d69673d8a84
-- 
2.25.1


