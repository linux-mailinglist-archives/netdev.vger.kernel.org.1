Return-Path: <netdev+bounces-124679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD096A6E3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8EBB22A82
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED71917D0;
	Tue,  3 Sep 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n3zVjc0I"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80628BA53
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389362; cv=none; b=e+jVELtUqurrAqEfgFscqfC5u3PkFXt8o1yvUNf2FjGVnVfUDpQRhq9iT/oKRQkhcm2vrTJfS+7ZNUuji8Gx5pa8t1e59p1A3IHwuPV+ZBqPsNJ5pWqAvrJ2Rkl5ti6qcIuqYSrc3LxIZ8CJ/q220e9IWEBPT+tqOODC4Flvz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389362; c=relaxed/simple;
	bh=IS8npD5+q6KAERfggykP+N3kUHf0xk1btbezOI3EQLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zzxz8DS/7C1lgJnA19qbrML9EEPGjvzy8SKxT+uP4pSEOzXv6sb46vr8QNUL8UXcEHuDw4/TugK8oxtYlBxs9W6G8gcW84wjjdg4M5xhZUdWOM3CaRbpV4dgPK882PvsNaV8kdxwkys/p1fFDm8k1LyekuOKySmKiqXtJsR83W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n3zVjc0I; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725389358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MIb0qyTQudG0fpbEz1UuMVklvKc5AdRSngdIS0lJCgE=;
	b=n3zVjc0IhfgRIHR3uqmQcJsNEatTA3DxBaun95AH8RjS1MsCp5sxeVPUgfASGZvV8Dvpk/
	0y8RvoK4Q3mXYbjaJ+VAWplI4049Wo41o8NfYMMwJCSDWBrV++drgiCHmoNo1e7WkW1EwP
	3kSKlXvEUy8AKR9TSvv5A0onMshvKGs=
From: Sean Anderson <sean.anderson@linux.dev>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] net: cadence: macb: Enable software IRQ coalescing by default
Date: Tue,  3 Sep 2024 14:49:12 -0400
Message-Id: <20240903184912.4151926-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This NIC doesn't have hardware IRQ coalescing. Under high load,
interrupts can adversely affect performance. To mitigate this, enable
software IRQ coalescing by default. On my system this increases receive
throughput with iperf3 from 853 MBit/sec to 934 MBit/s, decreases
interrupts from 69489/sec to 2016/sec, and decreases CPU utilization
from 27% (4x Cortex-A53) to 14%. Latency is not affected (as far as I
can tell).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 127bb3208034..8e1e4b2b2386 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4184,6 +4184,8 @@ static int macb_init(struct platform_device *pdev)
 		dev->ethtool_ops = &macb_ethtool_ops;
 	}
 
+	netdev_sw_irq_coalesce_default_on(dev);
+
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	/* Set features */
-- 
2.35.1.1320.gc452695387.dirty


