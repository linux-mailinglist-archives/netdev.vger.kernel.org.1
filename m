Return-Path: <netdev+bounces-127331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35CC9750D3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C91F22C9F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3781865F3;
	Wed, 11 Sep 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jbsky.fr header.i=@jbsky.fr header.b="OekTVH/9"
X-Original-To: netdev@vger.kernel.org
Received: from pmg.home.arpa (i19-les02-ix2-176-181-14-251.sfr.lns.abo.bbox.fr [176.181.14.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07870185954;
	Wed, 11 Sep 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.181.14.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054237; cv=none; b=DincsF8L1bxxhs4hoqQKWA86HY8mw/Pt1KSiMV+qlSufvzL0S3Bc49x+ruFMu/KrNVypS1sknUp0NkymwHXJjokIt11VXZmj6qDQFLTb6vYgreYMgfuUVopRK5DU5NGGBmlQi1AQDUM5Q9XZA8AUbLh5h4Q6eRvpIA7yse4dLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054237; c=relaxed/simple;
	bh=WCK5FI+80mUthsABAMMem19ibajtBlPK6xI5q5jaaT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFm6lYNGT5xWZLVzJ5Bi1bpX+XBwDBS7EPIuqr+4k+q9G9K4Rpi8paMZiipr4WMWIJHRqiQhlbM5DyWwDEWanzs4H+qx39JwuED0rIXHGUdE2q8U2McxEIiGD9MI6s7XxGFwuVALabSLf2Kv9qzt41Avl1+opod0wUGKXk6TeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jbsky.fr; spf=pass smtp.mailfrom=jbsky.fr; dkim=pass (2048-bit key) header.d=jbsky.fr header.i=@jbsky.fr header.b=OekTVH/9; arc=none smtp.client-ip=176.181.14.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jbsky.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jbsky.fr
Received: from pmg.home.arpa (localhost [127.0.0.1])
	by pmg.home.arpa (Proxmox) with ESMTP id 34025223CA;
	Wed, 11 Sep 2024 13:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jbsky.fr; h=cc
	:cc:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=pmg1; bh=TNpLvTy
	A+susO36tSI+Z3LxDrONyGqbbgC4owiC0rDs=; b=OekTVH/94JsVN208BZ2/K4w
	Q2Yi6viRnBlQiVp9k/2r+zpdk1o/SzWrrvhfIscmnD85Hh8mDgSuk7jxeC9A4Hl9
	w2OIErK0tR77RCOc7gCVQCY1A6cYu5sitixSttfJiS1iSWSYH6R2FkVRtHTGDVRl
	rYEnqSpW9GnGDJPcJNNuU4IkxkAW7HPQYdA4yE1JqZ8U8rorsOKx2EsPowPFBWAc
	ZoPr0Nv+zg19p/o4lqy+U6f92Y8a3fkYWvEU9V9tmT6qf64f8ATk/5DJejtP0Tpl
	FuRMSacx3+jS8e72dDA3iN2zvf2rIz/WF1Pnv+ML8Neh9WjghhhZwVypRr8r6wQ=
	=
From: Julien Blais <webmaster@jbsky.fr>
To: thomas.petazzoni@bootlin.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Julien Blais <webmaster@jbsky.fr>
Subject: [PATCH] mvneta: fix "napi poll" infinite loop
Date: Wed, 11 Sep 2024 13:22:45 +0200
Message-Id: <20240911112245.283832-1-webmaster@jbsky.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In percpu mode, when there's a network load, one of the cpus can be
solicited without having anything to process.
If 0 is returned to napi poll, napi will ignore the next requests,
causing an infinite loop with ISR handling.

Without this change, patches hang around fixing the queue at 0 and
the interrupt remains stuck on the 1st CPU.
The percpu conf is useless in this case, so we might as well remove it.

Signed-off-by: Julien Blais <webmaster@jbsky.fr>
---
 drivers/net/ethernet/marvell/mvneta.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 3f124268b..8084b573e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3185,8 +3185,10 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (rx_done < budget) {
-		cause_rx_tx = 0;
-		napi_complete_done(napi, rx_done);
+		if (rx_done)
+			napi_complete_done(napi, rx_done);
+		else
+			napi_complete(napi);
 
 		if (pp->neta_armada3700) {
 			unsigned long flags;
-- 
2.30.2



--
This e-mail and any attached files are confidential and may be legally privileged. If you are not the addressee, any disclosure, reproduction, copying, distribution, or other dissemination or use of this communication is strictly prohibited. If you have received this transmission in error please notify the sender immediately and then delete this mail.
E-mail transmission cannot be guaranteed to be secure or error free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message which arise as a result of e-mail transmission or changes to transmitted date not specifically approved by the sender.
If this e-mail or attached files contain information which do not relate to our professional activity we do not accept liability for such information.


