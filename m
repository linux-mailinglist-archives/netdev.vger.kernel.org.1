Return-Path: <netdev+bounces-144165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118D29C5E6F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D622824D5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D08207A14;
	Tue, 12 Nov 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KF6aRyBn"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE592076AB;
	Tue, 12 Nov 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431226; cv=none; b=AxTcIyfEkCScgzIux1X0e5wWeihVtEOu2gGT88cgncjbToMFQEi44J3kTIEKZgOvwdelH0KuEQkXRf2B7IIaI90pKG5FMfHJeEfSFMkDvKUPpSvjREduz7rb30oOaLg9AAn2jlKnWhFa8qqRNvzg+mqrOHqxJoPXBFiWpXVTp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431226; c=relaxed/simple;
	bh=yfOv/eMBAl8i55aF51GafdzPzmAf+rbqJvtUJEDJb5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JsnT+T0e1+YojpDgLIivfXG17SBFdqCv6x5AIML7ECoE2kwB+aGIrhyVwKj3X+vwQXWR79FtlOMPmj+XePcfKm1jLoLPWjONnDrwzt1ALkljKtFO5/pj8p3BXdOYcqI35/0JsLhSHcaP/rHtCP6sUyqPSQ1IuSzxDf9AGhieE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KF6aRyBn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54B79E0002;
	Tue, 12 Nov 2024 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731431222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MNtCugG59nS9OABDLmKZagjpJ188CbPhZJNQ0/shOKY=;
	b=KF6aRyBn5/7nNXSS5Mad6+l+b+BbubgLGJZfM7VgpqTBqmHpPWlNRVneQ/d90gcj71UWiN
	vQcSemki6Sg14AxdjC6nY7uZpZWp4VcbfJSdHPfxJHViK4AcI22w/xTuXP3hzBPUIeD0ao
	ROh47wIUy58MA/IYBsb0gpI1GW5WjRBMwuKHrSKQsvikmu2vDMAEMsj8+vkHOK2IMk+1WS
	V/coLl2a4ohAaV3xmvzLYT0KbnbwQOUJ9d3Fx1nw2oai5BsAdrKmzc/OsDrLy2uU56QAVl
	gyPT5qDS9aEjQfoG92F6DTJ2A4mNIJn4eOxk3euoa5MdvohILAkFdhPrDWk+Pg==
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
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/9] Support external snapshots on dwmac1000
Date: Tue, 12 Nov 2024 18:06:48 +0100
Message-ID: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
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

This is v4 on the series to support external snapshots on dwmac1000.

The main change since v3 is the move of the fifo flush wait in the
ptp_clock_info enable() function within the mutex that protects the ptp
registers. Thanks Jakub and Paolo for spotting this.

This series also aggregates Daniel's reviews, except for the patch 4
which was modified since then.

This series is another take on the previous work [1] done by
Alexis Lothoré, that fixes the support for external snapshots
timestamping in GMAC3-based devices.

Details on why this is needed are mentionned on the cover [2] from V1.

[1]: https://lore.kernel.org/netdev/20230616100409.164583-1-alexis.lothore@bootlin.com/
[2]: https://lore.kernel.org/netdev/20241029115419.1160201-1-maxime.chevallier@bootlin.com/

Thanks Alexis for laying the groundwork for this,

Best regards,

Maxime

Link to V1: https://lore.kernel.org/netdev/20241029115419.1160201-1-maxime.chevallier@bootlin.com/
Link to V2: https://lore.kernel.org/netdev/20241104170251.2202270-1-maxime.chevallier@bootlin.com/
Link to V3: https://lore.kernel.org/netdev/20241106090331.56519-1-maxime.chevallier@bootlin.com/

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


