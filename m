Return-Path: <netdev+bounces-118864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE9F9535C7
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2A282B7C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0921AD413;
	Thu, 15 Aug 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EmC5flcQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E11A3BB6
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732866; cv=none; b=XeT1tQS1ILHbZZOHj+SKm50jaWK+hCuUfCOi82qCgUc9H0Mazies6U0hl8hncu6EDbDjBlbZRzJquXmRcJ/ggdONAZA/1+rkKe8D+ssy/s45nA4NEnqmdSuLrOmYl20jM30exKKJJaGq7F0/++85dheRCHZG4mWvk/R9yBcKx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732866; c=relaxed/simple;
	bh=JdygWxtVQGaSX0wGIkezgI+jTc+mkFeq5LTBnl7pO+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFavPfFA+QpNT5JboIGaZWSGU0rte66pmYI6H5Gie3VHpsabHkVi+al4XoUe7AZTy30mhI/Nkv9Lxw8DNXhxqGhMBDWeBC5PmaTKbdSLelX0paIcmZ7rgfcTu4J1DVHwN4/fMu3Og4IesEgf5etN0ZrFyCeAys18EzFj84y753Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EmC5flcQ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723732860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTZgPced0EBacNzgZdl3oKXmRtpOubbN18kV7+HqIIA=;
	b=EmC5flcQCbtOmeMelFg1r5mutyQMJXhykfsSRtWvg6LR+cIZJf1IOlEvzTLqanyC7yxPW5
	6STa3AMbhfiHR/vUOKv2CyTvyEpCRS527OfkEn1hQoFDFJBYgShVf3kT5vphKlCWQrRbNV
	SDiI576PaxxXzbDjjKsGyArwatuaWog=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 1/2] net: xilinx: axienet: Report RxRject as rx_dropped
Date: Thu, 15 Aug 2024 10:40:30 -0400
Message-Id: <20240815144031.4079048-2-sean.anderson@linux.dev>
In-Reply-To: <20240815144031.4079048-1-sean.anderson@linux.dev>
References: <20240815144031.4079048-1-sean.anderson@linux.dev>
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


