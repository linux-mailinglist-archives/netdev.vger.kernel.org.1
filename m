Return-Path: <netdev+bounces-124675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4796A6C6
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2431F20EF9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6682194089;
	Tue,  3 Sep 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AbGCJCJ5"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11787192D9F
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389028; cv=none; b=MUbfa9MctIHXlhbt133IEErHchi9IH/8lq/2WGMCLPaLl/yreD3ijHP10i4wHo6A3k7YPlOCvQsXd0fn1BTpmO3ZvnwmFdzpWH+mXPURjZT1vnqgJU8z+oIJr5KjYJFV01e+OU5KH58zxaGU6AVEOqaFr8UqLZ9NYe8Bwxwpl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389028; c=relaxed/simple;
	bh=MqvTS19SyIB4yU2UQI1s8+5I5c4iE8RUxXgILxCVx/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAkhlPR77oGEdf+z+PmDyUV+v3bLo+cJslKuwlR/dDJ8QUJsjAP/AWUfjencrNMQPxAjsc+orsr+lD8LuJ3bRQMmjyZpSqezhIBi6XVva6HRy9ytz2ecYV+NH7rse860nZS9P/uBSQJ5GE9gU12MTsTWvzYWnEDcbH4fWwnw3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AbGCJCJ5; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725389025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lO6Qw3fND5cpAM7rycrrrnZxNspjCnlupd/fVRDk9Z4=;
	b=AbGCJCJ508jUBRJ/mh9JRd8STPK8QfLfeMtrJJkPRmvRqVaB3yPQaRjpU6JCPlVk5piNGn
	+x0IxqW0VX6k/trXotrH09A4gejbumgjDHS9IGzQXVppm1S9t9iLpcSykRvANT7VeDLTSu
	SpfQTC04ToqwgDMR39W3uxS3JHsvTPw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum checks
Date: Tue,  3 Sep 2024 14:43:34 -0400
Message-Id: <20240903184334.4150843-4-sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-1-sean.anderson@linux.dev>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The partial rx checksum feature computes a checksum over the entire
packet, regardless of the L3 protocol. Remove the check for IPv4.
Additionally, packets under 64 bytes should have been dropped by the
MAC, so we can remove the length check as well.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 74fade5a95c2..99d08a775520 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1188,9 +1188,7 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 				    csumstatus == XAE_IP_UDP_CSUM_VALIDATED) {
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
-			} else if ((lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) != 0 &&
-				   skb->protocol == htons(ETH_P_IP) &&
-				   skb->len > 64) {
+			} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
 				skb->csum = be32_to_cpu(cur_p->app3 & 0xFFFF);
 				skb->ip_summed = CHECKSUM_COMPLETE;
 			}
-- 
2.35.1.1320.gc452695387.dirty


