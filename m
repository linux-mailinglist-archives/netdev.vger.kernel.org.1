Return-Path: <netdev+bounces-126585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6F971EB6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1207C1C23872
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51461386DF;
	Mon,  9 Sep 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M3H1KR8h"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C212B143
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897987; cv=none; b=Syg2/21N/3zbSR+WEaLdYUVUkbpMssxQFpoYrVq1Cp7K1iAC6xQW9tdrsKquNNKlztjHfmmEK6LrAT1n6qURKn81jXbOrMQ0QZp6TcET+D+Hej31qvqOKrkw4aN6Fgv0nDR99ffCyKAGOcF87ANNu9WCqeheoSj22iCuh6WqwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897987; c=relaxed/simple;
	bh=fK7ND1SRwuJf9pb3UJOBltIVp1SguX2VqghRHgzAAeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fcaP4Clg54JWGEw1C4UNCpDBIQRPu1UbolqTagJj6MTdOQgf9h3E/fkb+xKzoZVeo5V0MDNlrgA9Uyv4OBVyReF2lMtaEIE1HKA7ukek2lx7odRbuNTZc7z6YhRvBdQag5Dsz73j4AkXqTzgD+TrW00pF5hzFwjgJlwvmX7sNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M3H1KR8h; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725897979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7Y4M8clgRuoEwRJyb9EKzYZ2niP8miNEcJZu+o3olc=;
	b=M3H1KR8hkqRbarUWY1ytmOtJcPhaWbVL7Ktmo0PcVvVlcWTdPyweTxx9+cPams/gD3u7YS
	2JuXtAaXCfsOJnfCGgQyick/5dhvrcbvMeShTlYq4JPND3x3wStcyig80svTfO7LCi49ku
	zS73+k5g9geQo87jFjqOW/sIG2LLzGo=
From: Sean Anderson <sean.anderson@linux.dev>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
Date: Mon,  9 Sep 2024 12:06:04 -0400
Message-Id: <20240909160604.1148178-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When sending packets under 60 bytes, up to three bytes of the buffer following
the data may be leaked. Avoid this by extending all packets to ETH_ZLEN,
ensuring nothing is leaked in the padding. This bug can be reproduced by
running

	$ ping -s 11 destination

Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cfe6b57b1da0..e4e8ee8b7356 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2322,6 +2322,12 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	}
 #endif
 
+	/* Packet data is always read as 32-bit words, so zero out any part of
+	 * the skb which might be sent if we have to pad the packet
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN, false))
+		goto enomem;
+
 	if (nonlinear) {
 		/* Just create a S/G fd based on the skb */
 		err = skb_to_sg_fd(priv, skb, &fd);
-- 
2.35.1.1320.gc452695387.dirty


