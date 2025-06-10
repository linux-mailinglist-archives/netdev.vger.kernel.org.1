Return-Path: <netdev+bounces-196295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DB4AD4133
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07A9189C892
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EF247283;
	Tue, 10 Jun 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VJZS9jIq"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6D24679D;
	Tue, 10 Jun 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577477; cv=none; b=aXp7lGObuP3oEdeq4kXV8hR8bAwzfmYTBiMd6zhEfmfOSBnldfqiQ4aajN25NrfUAze/d3dgmnrcDqMRYmA9wZTxver2xwf/w0RM2Y38qkHFyovLsj56FzRz3zskd70LjBD2EY33eAd1Sm7YAsNPFTNOMkpwZ2sKxkglm1K85TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577477; c=relaxed/simple;
	bh=YbCvLOcsoVuM7wQBIQFhmXnQCAd5HKQqO0I7GoSLl+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmWpqBVin87ztchGgZciEUBqoyVJ5h8WhOT1XWIEE1RWupa/XRFoPSCQdAmfkvIBVZXyGK2vcRo/nC4ifgrTlxytHvNSdK1jX6+XtmNe4s3HO3xgOdkw71QZe0pjf61gPnmGHUkAC8YNIKUorRCnoDCJ3cxZoqNtDR/rAYJi7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VJZS9jIq; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 164E8C000C69;
	Tue, 10 Jun 2025 10:38:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 164E8C000C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749577120;
	bh=YbCvLOcsoVuM7wQBIQFhmXnQCAd5HKQqO0I7GoSLl+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJZS9jIqAYDzc8TAbBe2V8hAWZY2fTt70CSqI+umVTEOVb0yQj1U8JLSWW2StZygs
	 cOKv6kBlur778aJi2UpnsG4yas1NnX7zhH271jemChQexwx6SePyGTWSoR4ozBXmVF
	 AwVejwm+dbeVVQ1uk16+PzwfQM6zhlqzIAb6xs7A=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B2CFF18000847;
	Tue, 10 Jun 2025 10:38:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: bcmasp: Utilize napi_complete_done() return value
Date: Tue, 10 Jun 2025 10:38:34 -0700
Message-Id: <20250610173835.2244404-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
References: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the return value from napi_complete_done(). This allows
users to use the gro_flush_timeout and napi_defer_hard_irqs sysfs
attributes for configuring software interrupt coalescing.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 0d61b8580d72..7dc28166d337 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -605,10 +605,8 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 
 	bcmasp_intf_rx_desc_write(intf, intf->rx_edpkt_dma_read);
 
-	if (processed < budget) {
-		napi_complete_done(&intf->rx_napi, processed);
+	if (processed < budget && napi_complete_done(&intf->rx_napi, processed))
 		bcmasp_enable_rx_irq(intf, 1);
-	}
 
 	return processed;
 }
-- 
2.34.1


