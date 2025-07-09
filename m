Return-Path: <netdev+bounces-205425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29AAFEA48
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6174F3A5321
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A212DCF5B;
	Wed,  9 Jul 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="WJgaDXMY"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6128A1C6;
	Wed,  9 Jul 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067953; cv=none; b=YROG9iqSlEdk3NSbUddVixfLmqekiG++CzuAsQ+fjsFDjPofCzoanaI7YcY8XFaLHQ96ZaHPkKmTquF+tDlu6vcbXu5Dxn5792LDLfZIq//MRCs61GaRwl09clXEO6X6k/Ncx7JzwtGJLWvR2YZHysEmxrZU88fXoz8pm75mYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067953; c=relaxed/simple;
	bh=zVhc0zsnke3qJv818So+I9Sh2xStVwtQltXwS6FbNqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkRG4BtaKCMSGixgHLjhA23XILAPO2zhgLDOziGTOmkQ4MYlsiXXZ652eWmyvkdPIuSwEY6ULo+uSmFqSwrB9jUJ2Ni2+vU93sBIEIBjJ+CExCjnlWk4q62Asr3CsMhw/5KsT5yJtyNAGKxEVHU/2ZD7Q+18Z/C7pf/xN9LhF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=WJgaDXMY; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 50DA5A055C;
	Wed,  9 Jul 2025 15:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Ss5jOBvOQM8AFGqBm1x/
	NC9Iw7pGPxkamTpW9hfvWwU=; b=WJgaDXMYGFefDNLMOmELMWB61BbXyl3QGz3v
	zv84t0u7uUkSqFHtb9Vxxzc2oFzat5WeoSpWFSczp70B/JHSq9DNrCt6tWydC+mD
	mcpuXqMkDTqFBsHECnGgxSqcZ/oLfLiXH2RPuxbAEyQNp7vHs73tIpbiXdTFZOf4
	jSM2yBHz7tg2Q6QE6/LrL4sjIHm4nzfuXOL+FWFhORur+QIyRZkeLNTsqXSuutbq
	7dj2mVmB9OcdLe35c9z5FHAQRQ9HRE/fqPq0eNTJiLDuCfEdl3hIt27R52v7c12E
	BPkx1Y+xn5ACuAlti5YgPl+4HlNK8ypkHBk68fFz6cisRJIQ9CkOGGsiGAZxV+1h
	aD4Hx2FG52cHek96kRwfD8bZTAhItyOT8/cd9IORcKpIMPUQ799yvtSefaFZBbJW
	q5PoF9yaf2kmvPjUQYTtXsdMSsy+FMRuf7zhsOtEKsQ0qoBJkRH3VujRZr69Myh2
	ustjr0C8VA15rlGZYlnv1gLx4ojFCk+5dl/pZCGH+b00Y5PE5MRUf1dqeO5xmorY
	3/PoSqh1b/vt1lgl4W/dcS8hSV0DFYPlIVKa31Mr1PiahGjmMsffS7bOf4rmtsz5
	Wzt6hIAt2OGnXSFQzv40VMv+t0zLmVpRb6tMIJpxgIZJ0wfN/+UBsHhav/I7f+jA
	3Wn39bE=
From: Buday Csaba <buday.csaba@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/3] net: phy: smsc: add proper reset flags for LAN8710A
Date: Wed, 9 Jul 2025 15:32:20 +0200
Message-ID: <20250709133222.48802-2-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709133222.48802-1-buday.csaba@prolan.hu>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752067947;VERSION=7994;MC=1431488400;ID=104607;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657164

According to the LAN8710A datasheet (Rev. B, section 3.8.5.1), a hardware
reset is required after power-on, and the reference clock (REF_CLK) must be
established before asserting reset.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
Cc: Csókás Bence <csokas.bence@prolan.hu>
---
 drivers/net/phy/smsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 150aea7c9c367..357e16aa4a736 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -737,6 +737,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* PHY_BASIC_FEATURES */
 
+	.flags		= PHY_RST_AFTER_CLK_EN,
 	.probe		= smsc_phy_probe,
 
 	/* basic functions */
-- 
2.39.5



