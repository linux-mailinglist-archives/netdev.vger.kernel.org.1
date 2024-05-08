Return-Path: <netdev+bounces-94571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEB8BFE8E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9348B288FB9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401F75803;
	Wed,  8 May 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TPTTvU3s"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2A73191
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174362; cv=none; b=jGy0QJEQyWfM90WaIwZBghKIZL9eTx0jRdTG1HzxhHIwz4fXW5tEarKbY1ewOLCk1Ff/fhTGnxjCw6iDzGZoGg1edNb8fRWoh7q9xRtQiV2BASg/7OJGg06wdWJDGPoPgANwJA18TaFmo46TsDcXIogQpYU/eJwZXJW/hYBlqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174362; c=relaxed/simple;
	bh=sFzPIT5Te1nb8NBbWpkxIkGDjBIjnZtkvfkI0vbFXfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJ+LEVTAGXn0KprFxa9KT8aqiX4meCJPmiaKUKrUxnhSo83JGb7PtdBhCeiNT/6BGurLVgJKvTweIuK1eHdz3p+d/aIQfa2X8IT0DJHNgkPGMfsgUlbzVCBrOQP5jsFUAYkkzCmGY3O7nl1tTjoOGNdtrSNZ1+FrAake6GG7QfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TPTTvU3s; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715174357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a7PN3JQ4K/DvJRnlFHoORql2tVkuV7mrhZmcPwMwWoY=;
	b=TPTTvU3s1SYWMOeKi3A9oFy4vPfN5w7108g2iPx1iuvN4rnC0ByATQqnIzsegeKk9zmJid
	p6RUCa7MFiTb81i/lnxM/9K6p1fqHH5DVuJVMsnIYumkN08q3Uo1nDw7VPRv6W/NEChTAq
	KqjK/oBuS2+YGOpnYDitf04YGQHfqxU=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org
Subject: [PATCH net] ptp: ocp: fix DPLL functions
Date: Wed,  8 May 2024 13:21:11 +0000
Message-ID: <20240508132111.11545-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In ptp_ocp driver pin actions assume sma_nr starts with 1, but for DPLL
subsystem callback 0-based index was used. Fix it providing proper index.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_ocp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 6506cfb89aa9..ee2ced88ab34 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4562,7 +4562,7 @@ static int ptp_ocp_dpll_direction_set(const struct dpll_pin *pin,
 		return -EOPNOTSUPP;
 	mode = direction == DPLL_PIN_DIRECTION_INPUT ?
 			    SMA_MODE_IN : SMA_MODE_OUT;
-	return ptp_ocp_sma_store_val(bp, 0, mode, sma_nr);
+	return ptp_ocp_sma_store_val(bp, 0, mode, sma_nr + 1);
 }
 
 static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
@@ -4583,7 +4583,7 @@ static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
 	tbl = bp->sma_op->tbl[sma->mode];
 	for (i = 0; tbl[i].name; i++)
 		if (tbl[i].frequency == frequency)
-			return ptp_ocp_sma_store_val(bp, i, sma->mode, sma_nr);
+			return ptp_ocp_sma_store_val(bp, i, sma->mode, sma_nr + 1);
 	return -EINVAL;
 }
 
@@ -4600,7 +4600,7 @@ static int ptp_ocp_dpll_frequency_get(const struct dpll_pin *pin,
 	u32 val;
 	int i;
 
-	val = bp->sma_op->get(bp, sma_nr);
+	val = bp->sma_op->get(bp, sma_nr + 1);
 	tbl = bp->sma_op->tbl[sma->mode];
 	for (i = 0; tbl[i].name; i++)
 		if (val == tbl[i].value) {
-- 
2.43.0


