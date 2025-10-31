Return-Path: <netdev+bounces-234715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F9C2655A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2006189D350
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FCF30596A;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPNWb7uO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABCF2F3C34;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931636; cv=none; b=MzxqpKPoxTflSOEDyEYm3B+h9IZ6VepK2bcLzs9pV5yhntEb+J/upkkrWXkBgYjHxQwyfHceojpTK4ZIk0aC8ywdtinr6m+ZCefmsv1zBUSJ1vAXGmTWnxDyQfRi4HixKz7WHKp8APV6XesLVq0qKNLOUe5av8Z7wFkgVpsK1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931636; c=relaxed/simple;
	bh=RohrhTza2xAFrs7CezlnV5dAmx3p2a4uuSdG6YJAqwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPDjVBo8v5AIY8iMr2TAnEWtvnZ5Btjsv5H6fiMavIwNlzALnhGLydKWxmeOjpceStUKj3vbdTwriF31XQvpR2mEOsK0mu4WJlU6/0Y42rCz+58mwGWkjsNDSsci2jeLBrcj33xQTaVFpMU0sQ7J5iOTi9OjU7KV1nAQGwO7vvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPNWb7uO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A0CBC116B1;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761931636;
	bh=RohrhTza2xAFrs7CezlnV5dAmx3p2a4uuSdG6YJAqwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iPNWb7uOYK0sALyAQtVjPwJ9HIZ5dFMoTNwxtSNLb29zOQjrDsGmMRkSIhNvEMxAs
	 arowbfFq5CvvszJo21oTnP6fH820QucS3uoLS67GGrOTupOMMrT8ebih4IT+UhyAPK
	 Af349P5DHeOyOCQ3rCpDYr2i/XX2cghA7b/P8kTmuxB54l0yfhM84VwJLb7Hf7oZLL
	 VkGIGH6yHfPdrdiF9ELnKcsdAj7jTkulQzM3o6fqkrmC4ET9rth/tXlA3lZf5Yy0DR
	 GLXh2FUaCKXBY4qZioXW1rk42WqRPBiZW/ODh1CAU5Fcy+gg8J1sQXRoPogsB5yFdd
	 g+FundlZBu4fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BBECCFA05;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Sat, 01 Nov 2025 01:27:09 +0800
Subject: [PATCH net-next v2 3/4] net: stmmac: socfpga: Enable TSO for
 Agilex5 platform
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-agilex5_ext-v2-3-a6b51b4dca4d@altera.com>
References: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
In-Reply-To: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761931634; l=898;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=7La402FNfWCHW7j+XKQ6FKNGivUWIK2yY2YFq0PbKn8=;
 b=qyEa1i+Sp+Z+47IiaDkmTF96tqOrqVij/aA0ZAXBlDqEpiqC+S+bZIll82jlrFrbONdseYOmz
 Z6FCoaHOYBWAWe9ddUIaPglfUtbijCuJA8aDZ08S+aAri2TSvsmQwlt
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Agilex5 supports TCP Segmentation Offload(TSO). This commit enables
TSO for Agilex5 socfpga platforms.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 4f256f0ae05c15d28e4836d676e2f2c052540184..1837346ca2d438018ae161a233f415fe0181c78d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -458,6 +458,9 @@ static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
 
 	plat_dat->core_type = DWMAC_CORE_XGMAC;
 
+	/* Enable TSO */
+	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
+
 	/* Enable TBS */
 	switch (plat_dat->tx_queues_to_use) {
 	case 8:

-- 
2.43.7



