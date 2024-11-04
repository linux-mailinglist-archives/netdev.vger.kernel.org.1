Return-Path: <netdev+bounces-141597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1789BBAF9
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5781C21A24
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1211C32EC;
	Mon,  4 Nov 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L1WCxFcA"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0419DF8B;
	Mon,  4 Nov 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739779; cv=none; b=sPzhISy9lwBHjMZ1Ogx2POETJ8QpdFhxrvtdYH2XRaSTPkTwblurSdSCvT1wBtrD9YtPwLtY37+HDQtd/Awna7lrSyrWWOwjn3LCxJ9rGpoa/TnklK+Z98Iy4/BuvtlrtKJ6WsZUY+B3L0pUEKbnUN12epRRiLrErGEggGVPwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739779; c=relaxed/simple;
	bh=Wkd9xXMOcBoBgVklyUcoGvu9VG7On+8GRcrLnyYucc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rieA94ZJOp0yIHR2/IP+gIwXrYaYiTAlkwG363tVlJKvhwNHyUJi9MXbb4kUkkyAEs8YVO/rjJbIlDZQKlcHZ6ehx8WWkGWUhE6S3VckIAgmsjl6E8JuhuUbTlyanIHe6DtEely2bznFYWM4Ewwhx1j2N011NXz8kjEcCmeCuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L1WCxFcA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F00EE60005;
	Mon,  4 Nov 2024 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oI5s8asFDWE8LgW78P2vcd6xNJ1YtBMsqU066l+ZeeQ=;
	b=L1WCxFcACUgATE0tjjEcTfaN33vuYwaz+WIrUnD5/83xyUJMVJiiyB7T/3nRmy9hOVxJ9B
	hVo1p8HAmVCdN6DRXx/EDJ1s9G+aTazR3Us24cKKrUsndash/oD28BRxLPslTIBglFL78p
	pk/Pr4sBRU07vYMX8orosVcWpBCfowNfyeLVrN88s6Mk39d2ka/lDkNQDWvYnodP2JlTIu
	IN4c+TMmuAH0Lr/tUzdrCwKdJVA0zFfnTojebSCnxGYi01DT/k0+TyRBtzokMkRZW0WZjt
	u+138GZMj6GP4WFGAdN3NqkdSZPDzgkUYErLjFsa8TWfu33HC8w8T/fGbP6KIA==
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
Subject: [PATCH net-next v2 0/9] Support external snapshots on dwmac1000
Date: Mon,  4 Nov 2024 18:02:40 +0100
Message-ID: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
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


