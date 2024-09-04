Return-Path: <netdev+bounces-124991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A2A96B89B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AABA1C248C7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC81CF5F2;
	Wed,  4 Sep 2024 10:31:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE31CC897;
	Wed,  4 Sep 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445888; cv=none; b=U/1/6Wtt1fXS2XcrLc4FWcFVxk2VHPmU89AzwQC/3bpUAtjau2o+MChw//ajy+ZQKlqKv6iaUHOcouKQMMmh+O7JyGcFXZdz1NlCVEVmz9En3EuRlAKHlX0r/V4mzN+7a4S4TZ2l5f/EgbNMO2rvoYx5MoTkTjubYU1472AH7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445888; c=relaxed/simple;
	bh=AW1x/byXYHkVLUtUSK2TTP/WfOwnMLDu56foWZFkXyQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C5g2m6rvTnqaH38wuynOsoUJ+J9AoYX9JNALFwqRiQs/8DoYEgfPa9sgk+aBpA3J1JEzYUH7QhPEKx5cyePZCBZpTOob7cHeHXYCPMhDzVn74aVnKf5kq7icl6lkVU+2NzovzcOUwrdWfU8ol6nlN8agnAGAhcqCBOC0DLByUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 4 Sep
 2024 18:31:16 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 4 Sep 2024 18:31:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ftgmac100: Enable TX interrupt to avoid TX timeout
Date: Wed, 4 Sep 2024 18:31:16 +0800
Message-ID: <20240904103116.4022152-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the driver only enables RX interrupt to handle RX
packets and TX resources. Sometimes there is not RX traffic,
so the TX resource needs to wait for RX interrupt to free.
This situation will toggle the TX timeout watchdog when the MAC
TX ring has no more resources to transmit packets.
Therefore, enable TX interrupt to release TX resources at any time.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 63b3e02fab16..4968f6f0bdbc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -84,7 +84,7 @@
 			    FTGMAC100_INT_RPKT_BUF)
 
 /* All the interrupts we care about */
-#define FTGMAC100_INT_ALL (FTGMAC100_INT_RPKT_BUF  |  \
+#define FTGMAC100_INT_ALL (FTGMAC100_INT_RXTX  |  \
 			   FTGMAC100_INT_BAD)
 
 /*
-- 
2.25.1


