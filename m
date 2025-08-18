Return-Path: <netdev+bounces-214480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A6B29D0D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA8E4E549B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5030DEAD;
	Mon, 18 Aug 2025 09:02:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E030C34E
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507760; cv=none; b=QThDFrBkvwbyq9Nx1+lcImmSHKCAoTXhHdja5P4b/DZvmA/Q01cEJ57khrO84Md1vn7F/1KsqhkolXRy6SStYDIQPgHdoW2QY23RlPJ1OM415B7ygN+/cETHeObR/kwh9ABE/ioO7JMgisIlciG0MFB9B2rX8qZ+rEbZpSnzCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507760; c=relaxed/simple;
	bh=vwWq2gQjuhdr2jRIjEhG3Jn96WIa3/SjAzzadW8kWnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=doO9ninBR19UDI63WTsWqMJomGUfkLaNDdoqJl1CzfFsVA7qXilCFewtpagZ7sZeaXOitWqBCD+sXvy8kC4nSlJ2RiyHaB2GgS9NrDa8Hx6nudyVyKjhO15pb6w7Dfda+yZdHbRGBlMImpiJH6ceLpweambD48gRBV6ypu1/mys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1unvky-0003N2-Rd; Mon, 18 Aug 2025 11:02:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-000sBB-2F;
	Mon, 18 Aug 2025 11:02:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-00Bhgg-1y;
	Mon, 18 Aug 2025 11:02:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 0/3] stmmac: stop silently dropping bad checksum packets
Date: Mon, 18 Aug 2025 11:02:14 +0200
Message-Id: <20250818090217.2789521-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi all,

this series reworks how stmmac handles receive checksum offload
(CoE) errors on dwmac4.

At present, when CoE is enabled, the hardware silently discards any
frame that fails checksum validation. These packets never reach the
driver and are not accounted in the generic drop statistics. They are
only visible in the stmmac-specific counters as "payload error" or
"header error" packets, which makes it harder to debug or monitor
network issues.

Following discussion [1], the driver is reworked to propagate checksum
error information up to the stack. With these changes, CoE stays
enabled, but frames that fail hardware validation are no longer dropped
in hardware. Instead, the driver marks them with CHECKSUM_NONE so the
network stack can validate, drop, and properly account them in the
standard drop statistics.

[1] https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/

Oleksij Rempel (3):
  net: stmmac: Correctly handle Rx checksum offload errors
  net: stmmac: dwmac4: report Rx checksum errors in status
  net: stmmac: dwmac4: stop hardware from dropping checksum-error
    packets

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 8 ++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

--
2.39.5


