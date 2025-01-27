Return-Path: <netdev+bounces-161039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632AA1CF75
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 02:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA943A5964
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 01:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B75227;
	Mon, 27 Jan 2025 01:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8C3FC7;
	Mon, 27 Jan 2025 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941906; cv=none; b=kBrs8U1dQAi50IYlRpi+zu5YTmnYMKpLX9m2uwoXmp9Qe/Pf8413NZ47UM/rySJFopTCs0DzlyhV9ncByZGGRZow8GMzi9RC1s5S5efmrmNcfyh7ZVA65tKq7SbR40OISHuDzviOrajG+jk3ToOypEMawtnzZBBETgOOpcqHPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941906; c=relaxed/simple;
	bh=Jxo3JU36CAN5weaZSMLm0rndQH+ZZjC2l1/CTfGetsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNkeTX2lUN6Z8EGMtVxLd2tHWOJ6sBkjRqcENJb6oiLzrqPWK5HfQK6zwzFBV3Sd3c03wIqMEj9Ww+jMRxBnuspGe35uCzWMweK6k8wtLsFBklE4K2v70ZTGouv0DhYGi+6WROzAL5zMPFnjA4gx94cHC4UCCE40/8AM2/8aTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jan 2025 10:38:23 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 233D1200B5D4;
	Mon, 27 Jan 2025 10:38:23 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 10:38:23 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id ADC25C3C1E;
	Mon, 27 Jan 2025 10:38:22 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>,
	Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net v4 0/3] Limit devicetree parameters to hardware capability
Date: Mon, 27 Jan 2025 10:38:17 +0900
Message-Id: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes patches that checks the devicetree properties,
the number of MTL queues and FIFO size values, and if these specified
values exceed the value contained in hardware capabilities, limit to
the values from the capabilities. Do nothing if the capabilities don't
have any specified values.

And this sets hardware capability values if FIFO sizes are not specified
and removes redundant lines.

Changes since v3:
- Match the order of conditions to warning messages

Changes since v2:
- Check if there are hardware capability values
- Add an error message when FIFO size can't be specified
- Change each position of specified values in error messages 

Changes since v1:
- Move the check for FIFO size and MTL queues to initializing phase
- Move zero check lines to initializing phase
- Use hardware capabilities instead of defined values
- Add warning messages if the values exceeds
- Add Fixes: lines

Kunihiko Hayashi (3):
  net: stmmac: Limit the number of MTL queues to hardware capability
  net: stmmac: Limit FIFO size by hardware capability
  net: stmmac: Specify hardware capability value when FIFO size isn't
    specified

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 57 ++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

-- 
2.25.1


