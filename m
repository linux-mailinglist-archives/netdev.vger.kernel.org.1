Return-Path: <netdev+bounces-179542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D2A7D942
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C113B88C8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3B22FE08;
	Mon,  7 Apr 2025 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ee9J8TND"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACA230997
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017305; cv=none; b=RFy2GlmmnCmL9/iywsHefyBXLiNjFlkOCnWZqV87JYyjTqgS4Q8PUx3+wfGyamIhroVcWjI6hIcdTDJjKe9uS+NCO06SO5vq4Gt4jj3kvFYEjbMbSy+OWUmUhNU5u6f0lNZdtSAjZL6zoJhWkRsfOvsfIRZrzuOdjTsIon0pTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017305; c=relaxed/simple;
	bh=GKM7YNmweXGKd/5T213LHt2OW6BWq3I/9APzmR+Ttlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ+sbdCcQjibCiu1TrwedzGVkqHe3KyC3X6WNKSPfLRUUU0dlDWJ+IZ5cvuT2J8shQL1iGI1BvTinmls5fmbPkiiVGzrPSjuCsdl8AQlp0rmhGKyOlkwl7GGcfF3eJKhQMgeWzR5yhQjrubKwgi/qwOMdZxOJILESl15gKJmIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ee9J8TND; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744017291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oDx2UQT+oddyJAOWw3fQnxWBa8r2gSho+ZEVDQ9jJsE=;
	b=Ee9J8TNDQLDfej0tyWHFJ8VlW8uYwZsThCVzj0/wT/Gf0axvNd6mhBq/9E2bwb0XD6ntTQ
	/wwWlD6rKb9Vm2RI/CocxEiynM7KWq80OmGE/S7JVeP3iV9VMT3jDwVWfpX8GvelOglqTz
	V4tfJ//xSS2wZ6Rfenq2s8iATLCwjik=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rocker: Simplify if condition in ofdpa_port_fdb()
Date: Mon,  7 Apr 2025 11:14:42 +0200
Message-ID: <20250407091442.743478-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the double negation and simplify the if condition.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 826990459fa4..8832bfdd8833 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -1933,7 +1933,7 @@ static int ofdpa_port_fdb(struct ofdpa_port *ofdpa_port,
 	spin_unlock_irqrestore(&ofdpa->fdb_tbl_lock, lock_flags);
 
 	/* Check if adding and already exists, or removing and can't find */
-	if (!found != !removing) {
+	if (!found == removing) {
 		kfree(fdb);
 		if (!found && removing)
 			return 0;

