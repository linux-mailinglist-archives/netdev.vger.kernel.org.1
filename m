Return-Path: <netdev+bounces-58598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17110817756
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6951C25013
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9A4239E;
	Mon, 18 Dec 2023 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eanC8c+7"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9893D57A
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAF2B1C000F;
	Mon, 18 Dec 2023 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702916597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zAEs7W5BJdH6/zjSmegRrvrb82LpsDg5zlUYcijXjOc=;
	b=eanC8c+7R5g0+7Ngr4tE6l+5Ch6wDBHCAs7+WP8jSaGfxj2bbKcsV7kAI0FIE49LK2jdA7
	E49bqvJs6EA/cSu85otAKm5zXWNFqRrv+PckBRFhLWRMPRKoVyFoxC2Lu5VhoaGbdp3nFL
	lzBhJbhxuOVta0HFgjmo8g8zHDWQ7ksZGqPpxdBd7Ynvxqp3ODo7oQklDvruUECRoXStLT
	QhoWbTPq0p79G6kKqG65eJer673lisH/fHxj7GntFd7TnMxrzNkgrpTlVGMG8TtHJbTixO
	77i7FJom1jahZQjmEyPO4ZrGLjC/ijPOJUoKB2xtaZvrN/FbNiMEbbmzNpEjcg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 0/1] Prevent DSA tags from breaking COE
Date: Mon, 18 Dec 2023 17:23:22 +0100
Message-ID: <20231218162326.173127-1-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is a bugfix for an issue that was recently brought up in two
reports:

https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/

The Checksum Offloading Engine of some stmmac cores (e.g. DWMAC1000)
computes an incorrect checksum when presented with DSA-tagged packets. This
causes all TCP/UDP transfers to break when the stmmac device is connected
to the CPU port of a DSA switch.

The main change introduced by this series is a new stmmac dma feature that
stmmac_mac_link_up() can check to detect cores that have DSA-incompatible
COEs. If the flag is set and the netdevice uses DSA, stmmac_xmit() will
complete checksumming in software instead of offloading it.

I've run some iperf3 tests and the TX hotpath performance doesn't seem
to be degraded by the field added to dma_features.

Best Regards,

Romain

Romain Gantois (1):
  net: stmmac: Prevent DSA tags from breaking COE

 drivers/net/ethernet/stmicro/stmmac/common.h     |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 +++++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0


