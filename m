Return-Path: <netdev+bounces-142270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81E9BE196
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C41281EC5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2F1D63EF;
	Wed,  6 Nov 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ldkTn1Wo"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2741D223C;
	Wed,  6 Nov 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883819; cv=none; b=ApQigFJ8Zsb//yGvTtluFifSb5cA6jiCtqMoLgCr6RIeYauTq+hjLDRe0JhVdZLxgQiI30pywdsjiPuOLmaBBQVMxgQXeGDV9XPTM0/tDfsV5pNM7nnJx4jbytvLUOI5xamCc5fF28ahNFhepupIT1owqJ7FKmzQJ9e0lsyyHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883819; c=relaxed/simple;
	bh=dmQfccvppQsU9x9MtMI9asFu7FLuTFvIa1TI+NFg3PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckyjGODdKDH4WZUZP7yxrBSl1DoyZ21mmoBY4sD3M1wRiPtLA4J3GxbPdzugSfHuBifk105dz7HTm1RLVAVdjfTmwpSNktbEedL29Om70IxRipGWo+MPxTrf0m+KgAwuOcTVdPUQNxd6cApqMPMNEmmR8DQLU8jZnEMxP/fGYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ldkTn1Wo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79A17C000A;
	Wed,  6 Nov 2024 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=weAShtrkUjDQdfMxGlmfAtR3B6mS0OXtPZsSWC+b/z4=;
	b=ldkTn1WoOO9SvTFEUWcjuPQCtXxvyw7jTELOwmzgwIdIz66jwYiqHFVPL2tex2nHynBJUk
	nufYR2gX8SJ5mL0WfDURhYbIRWUCCW0u28jEUZ7pwoJ0G3Rb7E63oS8k0uxz3H3vqiNEgE
	uxzE9lkzJ1LvoiZNlqqTmBtD99o6T/5TtXKBeS+Y2fe9hc+CAbkJccXVkKxQl+QO6ecdn5
	lW6wEUVnxZyvC98yDVn9/WuwHn/puJxD23ikNPCN99dlfmGWuDxK/mLcpmAa3Y07Szl09v
	idOND9U472puCw6guVr0XxQcvbu6zloJqyxqTTujTlvv3ECNw8eXY6QEzt4lQg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/9] Support external snapshots on dwmac1000
Date: Wed,  6 Nov 2024 10:03:21 +0100
Message-ID: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

This V3 is just a rebase a V2 on top of net-next to address some minor
conflicts. No changes were made.

This series is another take on the pervious work [1] done by
Alexis Lothoré, that fixes the support for external snapshots
timestamping in GMAC3-based devices.

Details on why this is needed are mentionned on the cover [2] from V1.

This V2 addresses multiple issues found in V1 :

 - The PTP_TCR register is configured from multiple places, as reported
   by Alexis, so we need to make sure that the extts configuration
   doesn't interfere with the hwtstamp configuration.

 - The interrupt management in V1 was incomplete, as the interrupt
   wasn't correctly acked.

 - This series also makes so that we only enable the extts interrupt
   when necessary.

[1]: https://lore.kernel.org/netdev/20230616100409.164583-1-alexis.lothore@bootlin.com/
[2]: https://lore.kernel.org/netdev/20241029115419.1160201-1-maxime.chevallier@bootlin.com/

Thanks Alexis for laying the groundwork for this,

Best regards,

Maxime

Link to V1: https://lore.kernel.org/netdev/20241029115419.1160201-1-maxime.chevallier@bootlin.com/
Link to V2: https://lore.kernel.org/netdev/20241104170251.2202270-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (9):
  net: stmmac: Don't modify the global ptp ops directly
  net: stmmac: Use per-hw ptp clock ops
  net: stmmac: Only update the auto-discovered PTP clock features
  net: stmmac: Introduce dwmac1000 ptp_clock_info and operations
  net: stmmac: Introduce dwmac1000 timestamping operations
  net: stmmac: Enable timestamping interrupt on dwmac1000
  net: stmmac: Don't include dwmac4 definitions in stmmac_ptp
  net: stmmac: Configure only the relevant bits for timestamping setup
  net: stmmac: dwmac_socfpga: This platform has GMAC

 drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |  12 +++
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 101 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  15 ++-
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  26 ++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  38 +++++--
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  10 ++
 8 files changed, 196 insertions(+), 11 deletions(-)

-- 
2.47.0


