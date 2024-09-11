Return-Path: <netdev+bounces-127330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D8E9750CE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CB91C2290A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D918593A;
	Wed, 11 Sep 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jbsky.fr header.i=@jbsky.fr header.b="CRgDCGeO"
X-Original-To: netdev@vger.kernel.org
Received: from pmg.home.arpa (i19-les02-ix2-176-181-14-251.dsl.dyn.abo.bbox.fr [176.181.14.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BFD7DA81;
	Wed, 11 Sep 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.181.14.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054144; cv=none; b=bMY1bYp3wAPsBgZvDt5vp33p3jeWvIUvoy2VBLD9EiYK6hQM47J3guvn8BTJxWrF6OTjwAQOa2XheVV3/b9zcgDremnMiaLmnGNI7uyxhcImWcZpY4kTF1/UV6T+1HXG9gHo44n7L0vgff7uNmMWUKUokD3KEI1wZ9wHICPWyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054144; c=relaxed/simple;
	bh=k9GOcmhJC466QzkABqserR0HiILCJ/LRGBvVCwgtSLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufs8ljB5k0g2ch2gbdOJGzYu4TWGooGtyRl79YP2rBHfK13W6cXssLyAaQA7JOY7+mfOhtMZYzl56OwIGMOn3EopXjh4mjSahg/9x8WJq9l9vYVyonVIqNJvvsvordo7BnNGrHgX99CTQ9ayE97FHHjeRp3vZi2EcgVcG3m5CA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jbsky.fr; spf=pass smtp.mailfrom=jbsky.fr; dkim=pass (2048-bit key) header.d=jbsky.fr header.i=@jbsky.fr header.b=CRgDCGeO; arc=none smtp.client-ip=176.181.14.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jbsky.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jbsky.fr
Received: from pmg.home.arpa (localhost [127.0.0.1])
	by pmg.home.arpa (Proxmox) with ESMTP id 4C639223CD;
	Wed, 11 Sep 2024 13:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jbsky.fr; h=cc
	:cc:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=pmg1; bh=pWQdPBZ
	U4iT8+rX31aSpkJm70LrFePUPmnw9lMgoydo=; b=CRgDCGeOrYoIFqKm2CAqkCd
	pdPbH0Qf40YihhPOSOPBqb0KSomingIqXcYz41SuLQ7wgv8fyGyLpW5wiGpzb2V0
	sSkecQEV7DcyGg9fXtA7qNWkJB8oIcSRhwjBvDBT81xHtHiPj+kCkw8MLzSVn3dU
	Fm/T79Wl3syRn7ikowO3TUhNF1zmxuOGPC466EeEfj9Jmp9HS8mLkxqHZyZ2rZxE
	VlZvabD5EOKMS7kDpGAhu5YT3TpKUXmG90HAzweDaRwKKeWLfjxLEGZ9OCnds3wS
	VoOHRS2o+7qPed3AkvLaSguhm0ahSR06M3DnoJYzgcPG9zlETwVYbkjMNs9fmZw=
	=
From: Julien Blais <webmaster@jbsky.fr>
To: thomas.petazzoni@bootlin.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Julien Blais <webmaster@jbsky.fr>
Subject: [PATCH v2] mvneta: fix "napi poll" infinite loop
Date: Wed, 11 Sep 2024 13:28:46 +0200
Message-Id: <20240911112846.285033-1-webmaster@jbsky.fr>
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
 drivers/net/ethernet/marvell/mvneta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 3f124268b..b6e89b888 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3186,7 +3186,10 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
 
 	if (rx_done < budget) {
 		cause_rx_tx = 0;
-		napi_complete_done(napi, rx_done);
+		if (rx_done)
+			napi_complete_done(napi, rx_done);
+		else
+			napi_complete(napi);
 
 		if (pp->neta_armada3700) {
 			unsigned long flags;
-- 
2.39.2



--
This e-mail and any attached files are confidential and may be legally privileged. If you are not the addressee, any disclosure, reproduction, copying, distribution, or other dissemination or use of this communication is strictly prohibited. If you have received this transmission in error please notify the sender immediately and then delete this mail.
E-mail transmission cannot be guaranteed to be secure or error free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete, or contain viruses. The sender therefore does not accept liability for any errors or omissions in the contents of this message which arise as a result of e-mail transmission or changes to transmitted date not specifically approved by the sender.
If this e-mail or attached files contain information which do not relate to our professional activity we do not accept liability for such information.


