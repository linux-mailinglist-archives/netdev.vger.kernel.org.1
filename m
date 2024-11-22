Return-Path: <netdev+bounces-146785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1B9D5D31
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB01FB227AD
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACF1DE89A;
	Fri, 22 Nov 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VC0tdSkB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57361DE4C1;
	Fri, 22 Nov 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270933; cv=none; b=sTiYaEw1+2ZL8VOmT97qa4lZBYqPu0Hh7OhTA/6ApLx21AC7JOQ41afLSff9ydTMzzonKMbjoO2PyeNg8hKrfDnbvoZu3URzxmziMOn1EUv5v2pEXE5J6dAf424NJteuRRtbfeAmxqb9m7f0mf2brsyuvGROBBZDgmwll73rzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270933; c=relaxed/simple;
	bh=CyeTFj1g3T0xPfR/J0c3mHFqU1zGR5ygVtUePXnJxRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOotkeL1rRU4O1EiITywUnfuys2LZ6Tr/+7QoDXP4k3LdQCVHD1+/URhDfAsUNBVya4VwB7fV6tC8TF1nn7QsjHCoGBTw8pG/PREa564ZquAxa7/DxXBlXrUTqiRatZkJi6PTdESbYS5D8PxmEQ3fpE2+ovPBqTjzK0K1B5xT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VC0tdSkB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732270931; x=1763806931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyeTFj1g3T0xPfR/J0c3mHFqU1zGR5ygVtUePXnJxRs=;
  b=VC0tdSkBdkL40Ccwb93qOX5riAijCPpbHDuz7Cg3ehlZphyggUD9wZ+C
   NDrQCyH/9CPej6c554F3Hlyd0GbXth2h85uo2wdd6tLtAPlntJpeNw3Zq
   kBTWeQ+U5qrH/5D/fjNSj59q2WXaxoqeSj5nmx0iMEHYZB/+PxB3dd0LD
   MjPx0jcggDbuDmoTdo6wJ116ZAC0jxx2u5M7zVSaN5cq9XqC5XDpSNzT7
   XIRaa0Zw8Vho9z9zEy3D/Yo+NKtzuun3wyJBZADG5i/B2gY5K3AeY0qDj
   sDX5uu9tRgm1f8Y1EqgIR6oQZZbILtpkBod/isGldsxnoOUe1011SmfQs
   g==;
X-CSE-ConnectionGUID: MRSRvnTqSAqJLUuhxew2Xw==
X-CSE-MsgGUID: MObpRG1kT7q7iMDEww71dw==
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="38251710"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2024 03:22:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Nov 2024 03:21:46 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 22 Nov 2024 03:21:43 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v2 1/2] net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
Date: Fri, 22 Nov 2024 15:51:34 +0530
Message-ID: <20241122102135.428272-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

SPI thread wakes up to perform SPI transfer whenever there is an TX skb
from n/w stack or interrupt from MAC-PHY. Ethernet frame from TX skb is
transferred based on the availability tx credits in the MAC-PHY which is
reported from the previous SPI transfer. Sometimes there is a possibility
that TX skb is available to transmit but there is no tx credits from
MAC-PHY. In this case, there will not be any SPI transfer but the thread
will be running in an endless loop until tx credits available again.

So checking the availability of tx credits along with TX skb will prevent
the above infinite loop. When the tx credits available again that will be
notified through interrupt which will trigger the SPI transfer to get the
available tx credits.

Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f9c0dcd965c2..4c8b0ca922b7 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1111,8 +1111,9 @@ static int oa_tc6_spi_thread_handler(void *data)
 		/* This kthread will be waken up if there is a tx skb or mac-phy
 		 * interrupt to perform spi transfer with tx chunks.
 		 */
-		wait_event_interruptible(tc6->spi_wq, tc6->waiting_tx_skb ||
-					 tc6->int_flag ||
+		wait_event_interruptible(tc6->spi_wq, tc6->int_flag ||
+					 (tc6->waiting_tx_skb &&
+					 tc6->tx_credits) ||
 					 kthread_should_stop());
 
 		if (kthread_should_stop())
-- 
2.34.1


