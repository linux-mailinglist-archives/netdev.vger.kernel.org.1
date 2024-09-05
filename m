Return-Path: <netdev+bounces-125560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CE96DAFF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AAD1C241AA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504B2AE96;
	Thu,  5 Sep 2024 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ROiI2Cxb"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C9148302
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544818; cv=none; b=bGi50ZJ81VXLdsMX3f2Urnj4QkpD3EMIcDuxFKn8rmmk2z5O6bHtNrmZzA5Q19nCl9T4GqYLIZzcZOW6wqjiPT3OaGh3oibhxJ61NJFIyX6AWyy+BkKYxJN9ueRtBxPgB/rhf2+l3z3kk85e8ZOwjyEMb92qaONiW0mPTmUOzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544818; c=relaxed/simple;
	bh=NrlW8iA4xBrKOUhyIN1Ge878omOrMgjb6WtDqqUTexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+FEWw1dtPpC2rcjiUjmVw0gtSlL5Ssl3IY4+F4+F16kqKVxVto+wRAcYxVKl79qOoEriNQWJQ9VAliNc3rUNzJS5WGP5fb562JgnqUiio1P2E38rXNah6/jutsqkO+KqVzSWlDUxERqZ2vfNiMxx5xkbZfspIxQHjod8TnyQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ROiI2Cxb; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725544813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FILGQpyhm8HWAqeNA7dG33y1hK6mZ9dIbJZyH5zJC3k=;
	b=ROiI2CxbBEGKj4bYNi5o5umePKanItYu+NITHFXJKXcrYebvKLWnZaVs3AD5xDbmpyxHQW
	9+GNU44N8LTR3lZJmMp9/RHiCbnduwd11u7FgMpECM9sx5CNDiWrahlQVogLPYQoeX3WM9
	/5TFqnlRPv8PFcAHHYALB4ZVdKvQTks=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] ptp: ocp: Improve PCIe delay estimation
Date: Thu,  5 Sep 2024 14:00:28 +0000
Message-ID: <20240905140028.560454-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The PCIe bus can be pretty busy during boot and probe function can
see excessive delays. Let's find the minimal value out of several
tests and use it as estimated value.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:
- init delay with the highest possible value
- use monotonic raw clock to calculate delay
---
 drivers/ptp/ptp_ocp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index ee2ced88ab34..6ea44c86f2ec 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1552,22 +1552,24 @@ ptp_ocp_watchdog(struct timer_list *t)
 static void
 ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 {
-	ktime_t start, end;
-	ktime_t delay;
+	ktime_t start, end, delay = U64_MAX;
 	u32 ctrl;
+	int i;
 
-	ctrl = ioread32(&bp->reg->ctrl);
-	ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
+	for (i = 0; i < 3; i++) {
+		ctrl = ioread32(&bp->reg->ctrl);
+		ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
 
-	iowrite32(ctrl, &bp->reg->ctrl);
+		iowrite32(ctrl, &bp->reg->ctrl);
 
-	start = ktime_get_ns();
+		start = ktime_get_raw_ns();
 
-	ctrl = ioread32(&bp->reg->ctrl);
+		ctrl = ioread32(&bp->reg->ctrl);
 
-	end = ktime_get_ns();
+		end = ktime_get_raw_ns();
 
-	delay = end - start;
+		delay = min(delay, end - start);
+	}
 	bp->ts_window_adjust = (delay >> 5) * 3;
 }
 
-- 
2.43.0


