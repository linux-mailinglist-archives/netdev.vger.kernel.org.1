Return-Path: <netdev+bounces-128146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0F978492
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2201C22515
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FCF75804;
	Fri, 13 Sep 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mND7YPrs"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657B6F2E0
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240206; cv=none; b=ufav3uF1b6l5zWNXVg8GEGQvtYewmFMfPixrHtZ/YEBD0S0JUt02DZGiVHYwra2fSqJ0DNcwS+0CoGAr7L5EzjhxF4dAKfIvd9Z6lbIUgQP/1VgUAQqwbSC8xnLcrNtSn78wnFBhOh9+y90SgWZio5rosxGDXMcIX9ZMkGPqUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240206; c=relaxed/simple;
	bh=8iHqyf28YKFRsnV2YBnaI3Uiw/x74M7EtHF5mD34DBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uRox/lFBH1J+7ATQ/99hBGtUSeSpzAl+xmQ6mO8MKiViQrjg844uHIRZ1D19KGt6HnaNBb8jgllsYei04uBLaHZrM1VK4g709q0PTnB4BBX9lDaFYs0hPJzN2YEFyqDNA6tZ+gcJWJYZJemSLSeWCN8+Woq1V5sGRxA9A/bTJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mND7YPrs; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726240201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sP2tPqwjPSBxzNzPyIXJccpmcKHD8PFBIGiTube1DWc=;
	b=mND7YPrssgt49zQASZVtiP7e1ihrGquX1VtNMc3E6JF6v4wIhaXIUr+K+FbtQN8XB24VJQ
	4abZ+Vdmab484yOyA0mQqYGrUoXnbg86iL2HQ2M87pS9O98dnkh8w5OJ0ehW5epLNGezVe
	IKJJunf+SXSJzaUIFPcPRy2pyp8cRh8=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
Date: Fri, 13 Sep 2024 11:09:54 -0400
Message-Id: <20240913150954.2287196-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The threadirqs kernel parameter can be used to force threaded IRQs even
on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
skip disabling local interrupts. This defaults to false on regular
kernels, and is always true on PREEMPT_RT kernels.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1e740faf9e78..112e871bc2b0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
  */
 void __napi_schedule_irqoff(struct napi_struct *n)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (!force_irqthreads())
 		____napi_schedule(this_cpu_ptr(&softnet_data), n);
 	else
 		__napi_schedule(n);
-- 
2.35.1.1320.gc452695387.dirty


