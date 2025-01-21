Return-Path: <netdev+bounces-159929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FFA1769C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 05:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2B3188879A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5801922F2;
	Tue, 21 Jan 2025 04:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB3E3BBE5;
	Tue, 21 Jan 2025 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434505; cv=none; b=A/Hr6NjgBTjjhNTNGzuG1VF456naN7yVVK0bTRqz23DYyEHimpwki3K7suiLUv5KT1MxK23lqavNLqFBNoXEi7iPayrMGEGFnSJDM+dBOLUPdy9iWhWppM85Kl+EZlImDiKbdlRWaQ+k6eBKyyjPcqQaJ7uJ2sEGG95zXT3PrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434505; c=relaxed/simple;
	bh=oWIn5mUUl3yyelqGKhCWmmM5HQ5y3LT4vZV2ZPLIDcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbS15pA4JOoXqSSQWTGX8gEtDQLungwA7PB93qCD6q3MeGe0x+og11yHicTMss++gcapP0N99jxr4Wnw+H1YgFQNL90JGQK1NGAZc/VfMO0JM9uOUPjwkJzQJv89/8l7Zua2MvVodpkOYDdkMPbC4DdDm7p256cKBRU451NsdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Jan 2025 13:41:42 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 181002006FCC;
	Tue, 21 Jan 2025 13:41:42 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 21 Jan 2025 13:41:42 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 68555C3C1E;
	Tue, 21 Jan 2025 13:41:41 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Vince Bridgers <vbridger@opensource.altera.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net v2 0/3] Limit devicetree parameters to hardware capability
Date: Tue, 21 Jan 2025 13:41:35 +0900
Message-Id: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
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
values exceed the value contained in the hardware capabilities, limit to
the values from the capabilities.

And this sets hardware capability values if FIFO sizes are not specified
and removes redundant lines.

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

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

-- 
2.25.1


