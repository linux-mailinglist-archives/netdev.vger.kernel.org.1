Return-Path: <netdev+bounces-120290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEBC958DA2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DC1C21B74
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94981C4630;
	Tue, 20 Aug 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OTzhgWHG"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69751BDAB6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176448; cv=none; b=kBNfcIEajMWwv46ktF3Kv688mSbpX6Jv4cie4nfjjn1y7OyhoRXEmGqJiVzwcSRm8huRCHmctUMzz0Jvqe/AKuwx6TWTaoWdcneg6pcN8nFxGXPBECqtdnRPkkYdSVOo+5uEKOwa/cQeARhD69lJCNBlXGm/75QDWwWj0CSPZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176448; c=relaxed/simple;
	bh=JdygWxtVQGaSX0wGIkezgI+jTc+mkFeq5LTBnl7pO+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geyPDdflphobGEEaIhAgI/j72vlKJTZvHJTC/3q7LM9zCZB24Zfx/d3jGMOSlZPK3uJwJfk+S2l0jOEbKy/NGOFn0uFMwO3hVM6QcJAqUbz4hglIvLETL8CdZrxSGbO+dPYyjUn1aqktdV6acUJmsR5MTLQeyipcYYv0/c2Pbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OTzhgWHG; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724176444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTZgPced0EBacNzgZdl3oKXmRtpOubbN18kV7+HqIIA=;
	b=OTzhgWHGCq9yhk3BBxLgXO8KySqTGJWIvleEsZNneLkuCaEqmL7AE5W0f3uyHIjQxLvYRl
	8Z47m7JECNBiIrkg+xVxaxPUhI1ALmog3Ue8Vc3aeCQFD00T/pa7kYU0oxWktmnFR1/fxP
	I5kDhZBKmsujt5ecE7lDKPJZ3a5WaQU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 1/2] net: xilinx: axienet: Report RxRject as rx_dropped
Date: Tue, 20 Aug 2024 13:53:41 -0400
Message-Id: <20240820175343.760389-2-sean.anderson@linux.dev>
In-Reply-To: <20240820175343.760389-1-sean.anderson@linux.dev>
References: <20240820175343.760389-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Receive Frame Rejected interrupt is asserted whenever there was a
receive error (bad FCS, bad length, etc.) or whenever the frame was
dropped due to a mismatched address. So this is really a combination of
rx_otherhost_dropped, rx_length_errors, rx_frame_errors, and
rx_crc_errors. Mismatched addresses are common and aren't really errors
at all (much like how fragments are normal on half-duplex links). To
avoid confusion, report these events as rx_dropped. This better
reflects what's going on: the packet was received by the MAC but dropped
before being processed.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ca04c298daa2..b2d7c396e2e3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1296,7 +1296,7 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 		ndev->stats.rx_missed_errors++;
 
 	if (pending & XAE_INT_RXRJECT_MASK)
-		ndev->stats.rx_frame_errors++;
+		ndev->stats.rx_dropped++;
 
 	axienet_iow(lp, XAE_IS_OFFSET, pending);
 	return IRQ_HANDLED;
-- 
2.35.1.1320.gc452695387.dirty


