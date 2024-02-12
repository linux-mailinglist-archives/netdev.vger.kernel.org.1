Return-Path: <netdev+bounces-71001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12281851859
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1508C1C219EE
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA63CF68;
	Mon, 12 Feb 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="gS7lHoVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D743CF5A
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752641; cv=none; b=FPwFzMdx19P1AYJKti1gMcXcMjITClW41ZkuiYZ0OaDI1BIobw44Av0hVkXuj9QqvW6xBirhHqOUdNSRKbZLeQs5NL5xQArPLjUp8rRD3tiqzbDYs5tY2MZUcgBsPSxgBU2Xy8iXxuPfQH79Gjb7Li4HcOVSthbqF3GYizOruZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752641; c=relaxed/simple;
	bh=cvVTOC2X+05hH/d+YZ7aGeqiZdF4zt9gjMio55/9LC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLb515JMm2XthWOL7BK1euHQzEej4ZQVSuRzNUCJb1x/H3NA4TgJu5G0SS0O5ARpy+fFxuHdHax7lz+DWXwTbS1y/tZfnM+Q60FXLvmZne9X4sBvtXS4nc7URiI5wGRmcrKltG0Z6QKX4bsOhKdNaxU/VuL3TuKl3Fm9+kiuTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=gS7lHoVJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0339524002A
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:43:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1707752635; bh=cvVTOC2X+05hH/d+YZ7aGeqiZdF4zt9gjMio55/9LC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=gS7lHoVJUa0+Vm69TgFx8bQbHOMKrApMNLk50nRR5YKcltNl9p2WPpkRzIZBLSmgy
	 TcPH++Wrv2nXZ05XQJGb/1mLvdTFTp3jXsPHtXtvmYYFirOILan5cOIjBNF7iRHWNY
	 NdK4aCwNusOr+zjBR1X/x4IHHgJ9MISW84+OyT+mwB+u2o83lqbf4A+h5WWRhlRgI3
	 sFW/NFlD13d7e7TEmnBpclZI/oVOcHvnUkvptcRsr0iILO8U4eVQUmeP04l3r6XFQ/
	 VXtO+Psw3XN3H31Sp3IvNLmThZY/FiQoIu4/lkfJAHnuh3AkIzrZhfiTRZ3NZof0Ng
	 55go2bntVoIqg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TYTJl4Z3Dz6txm;
	Mon, 12 Feb 2024 16:43:51 +0100 (CET)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] net: stmmac: xgmac: fix initializer element is not constant error
Date: Mon, 12 Feb 2024 15:43:19 +0000
Message-Id: <20240212154319.907447-1-shiftee@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC prior to 8.x gives an "initializer element is not constant"
error for the uses of dpp_tx_err in dwxgmac3_dma_dpp_errors.
Newer compilers accept either version.

More info here:
https://lore.kernel.org/all/20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 323c57f03c93..c02c035b81c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -830,8 +830,8 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
-static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
-static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
+#define dpp_rx_err "Read Rx Descriptor Parity checker Error"
+#define dpp_tx_err "Read Tx Descriptor Parity checker Error"
 static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
 	{ true, "TDPES0", dpp_tx_err },
 	{ true, "TDPES1", dpp_tx_err },

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.39.2


