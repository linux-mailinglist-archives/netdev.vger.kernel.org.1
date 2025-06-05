Return-Path: <netdev+bounces-195234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00761ACEEEB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DA03A44D8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D252144B4;
	Thu,  5 Jun 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pyodzuu3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5317B50F
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125207; cv=none; b=F1Zu7hhN2i0Q551iX3F7xcraDbpAsP7o6PDowGo0V1ibuc53Hof5/BjJDu/NVzy4k6wLhaMPlshNmF28PBn9X74dsK7edd01zDZAul2eiIcMgatij2YoF6hjZjByQ88S2pZD/0JIsHpcmKQJIuzXiO4kRRu6Ulb7KKM6HKqawYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125207; c=relaxed/simple;
	bh=lFPn7Ud/VzQmHXP7x/A1JIYn/0pRgMb+P4dnS1nwwaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDBlo3Ur34rkr4HSZ/6GUpYIP8FX4y+zlsmLWyL2NJEMgZgSnKefeRQpL6kkNVG0ubeFYtQ+bIOeJOLlTOUfkYOVbA5TmqYO3A+AzSsYHwxdVDpYctvQkhXmxqdHdcH7GpiN4A2d+6332XW6/1Y6I3cYpauS13C40drjc3SSYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pyodzuu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25BC4CEE7;
	Thu,  5 Jun 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pyodzuu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749125203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3QsemoZeZHr80OHBY5eTe/FSBvnL/BtDFJjW2SDLS4=;
	b=pyodzuu3KSUDLwGOK4gbEt9bbO+BV6L7fHDDa7wTSE74suixQvWW0QB/hU5FskdrKAaRqW
	ZdxOQh6OgWLeEaPLeWlt4yrUFJzV6v05XbY0NsifLfALIL75JGYRHEVVvh8kp+OL/EfTRr
	vvBvXkjoSADDqGQjWSxmeXrVU3JtMI4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7e466606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Jun 2025 12:06:40 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Mirco Barone <mirco.barone@polito.it>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next v2 1/1] wireguard: device: enable threaded NAPI
Date: Thu,  5 Jun 2025 14:06:16 +0200
Message-ID: <20250605120616.2808744-1-Jason@zx2c4.com>
In-Reply-To: <1d85ad0b-8f3f-4ab1-810f-0b5357f561ab@redhat.com>
References: <1d85ad0b-8f3f-4ab1-810f-0b5357f561ab@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mirco Barone <mirco.barone@polito.it>

Enable threaded NAPI by default for WireGuard devices in response to low
performance behavior that we observed when multiple tunnels (and thus
multiple wg devices) are deployed on a single host.  This affects any
kind of multi-tunnel deployment, regardless of whether the tunnels share
the same endpoints or not (i.e., a VPN concentrator type of gateway
would also be affected).

The problem is caused by the fact that, in case of a traffic surge that
involves multiple tunnels at the same time, the polling of the NAPI
instance of all these wg devices tends to converge onto the same core,
causing underutilization of the CPU and bottlenecking performance.

This happens because NAPI polling is hosted by default in softirq
context, but the WireGuard driver only raises this softirq after the rx
peer queue has been drained, which doesn't happen during high traffic.
In this case, the softirq already active on a core is reused instead of
raising a new one.

As a result, once two or more tunnel softirqs have been scheduled on
the same core, they remain pinned there until the surge ends.

In our experiments, this almost always leads to all tunnel NAPIs being
handled on a single core shortly after a surge begins, limiting
scalability to less than 3× the performance of a single tunnel, despite
plenty of unused CPU cores being available.

The proposed mitigation is to enable threaded NAPI for all WireGuard
devices. This moves the NAPI polling context to a dedicated per-device
kernel thread, allowing the scheduler to balance the load across all
available cores.

On our 32-core gateways, enabling threaded NAPI yields a ~4× performance
improvement with 16 tunnels, increasing throughput from ~13 Gbps to
~48 Gbps. Meanwhile, CPU usage on the receiver (which is the bottleneck)
jumps from 20% to 100%.

We have found no performance regressions in any scenario we tested.
Single-tunnel throughput remains unchanged.

More details are available in our Netdev paper.

Link: https://netdevconf.info/0x18/docs/netdev-0x18-paper23-talk-paper.pdf
Signed-off-by: Mirco Barone <mirco.barone@polito.it>
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Add Fixes tag.

 drivers/net/wireguard/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 3ffeeba5dccf..4a529f1f9bea 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -366,6 +366,7 @@ static int wg_newlink(struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
+	dev_set_threaded(dev, true);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
-- 
2.48.1


