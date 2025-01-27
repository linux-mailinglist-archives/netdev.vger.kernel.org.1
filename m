Return-Path: <netdev+bounces-161074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D76A1D341
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E4F3A29A4
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B481FCFEC;
	Mon, 27 Jan 2025 09:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DB533C9;
	Mon, 27 Jan 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969902; cv=none; b=DE0LwB4r7XAedsjfv2CL+NARLaaA5aFg3cWYm5Io/UK4DvctN7ssfzvnf7Nf6QyKTbaJfSjLUz1sgJAWeeEZp8WU5YMRqRb5HfqaNudFxAbgu+OsTbmcq9vAC85t0qay83we3Ot8hxIELL6wj8MOWqPuguiSQoPU97RTfI46sJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969902; c=relaxed/simple;
	bh=fyL8icdBx3mggZ+bZeDSijJ8NyngZc2J0DFZ097ziF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifJgwfm4iiylXtTVQsPZTL8EnDzaCHlHpuYMs5eQeYihF7sar29ZHIpwLkznmYCc4jT7pTP+ivcYY65JuYz5dtBLhpNCrB4j9xHnRQrUdS60EDii74LejKmYONue1fBn6qbiuV4e2s5/TLavOUG5jrpTSRVbOOccBy+nzsRDS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Jan 2025 18:24:58 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 498662006FCC;
	Mon, 27 Jan 2025 18:24:58 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 18:24:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id C1C52C3C1E;
	Mon, 27 Jan 2025 18:24:57 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number macros
Date: Mon, 27 Jan 2025 18:24:47 +0900
Message-Id: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maximum number of Rx and Tx queues is defined by MTL_MAX_RX_QUEUES and
MTL_MAX_TX_QUEUES respectively.

There are some places where Rx and Tx are used in reverse. Currently these
two values as the same and there is no impact, but need to fix the usage
to keep consistency.

Kunihiko Hayashi (3):
  net: stmmac: Fix use of queue max macros for Rx interrupt name
  net: stmmac: Fix use of queue max macros for Rx coalesce
  net: stmmac: Fix use of queue max macros for irq statistics

 drivers/net/ethernet/stmicro/stmmac/common.h | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1


