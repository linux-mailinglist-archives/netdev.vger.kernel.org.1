Return-Path: <netdev+bounces-210559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842FB13EE9
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143B17AE3DE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB14270EA8;
	Mon, 28 Jul 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tQZYj3yJ"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691C18A6AB;
	Mon, 28 Jul 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717116; cv=none; b=pm0BtK6u9mC6D0eF8ox1S+ozmx+XmAtbp3CEiilgSJ2wLaTItS+QFrUqc4+eWTRD/RL/93UyTSHDU5mhgcYIEE5wrveq6wf4D2VGBZckzkKOqaDIswPnwXwCr7kwJvwq174xbPdGpqbqaal8XLseuxGlhXRc8xJnwJhHCpLUYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717116; c=relaxed/simple;
	bh=hIf20LhUK1tUQLzGj8ydW/4r2tbZmoAN+UJUY1w+mX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJ+3/CNGMW+2wvWWuhX2B0PI31R/IyXSeFPC9j1oarIsiaPml9XKrsCsLMH9Nrb7BWhxqaJwoAY0nQLct+l81H7aqMPGrT/eNOowiR23RsWPHZITpuQ+XADXqW2DKmzwr6glpajzdWFCYlKPpc3CpzxVyl+gv3EtcnPdWb7m6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tQZYj3yJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3A60EA036C;
	Mon, 28 Jul 2025 17:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=abci0am6LSqs1O5WrmEN62h6sTg5U/wf/gniUsN48as=; b=
	tQZYj3yJYmJJpzFbkfaY5r3+049jvj3BoWvr/7cdYPPEF0KefVodqmQoiSSy4UtL
	/SFb8XviXiVgVgDUFsb/XB0IAP8hF7G5rdkYnwXqYsKUOTbgpMSZ7Jrk2UyJe3nT
	LD0NChh+2jFvjjj2bMgJStyiipVKuSGX+pU5DREJB+eo2b+VUXY4WRbmEMndmvPg
	NwMPkGHSseolAMglCsOES4210i6Uk4Z9j5t5kW3wLJSo4j26lgdOQRlrDvFrVchx
	1r+w/tKgQeEpCvHYGVOmvkls2p7quNqW0ap8HJtbd+lzjdsNSIRxbnTEaic6jWRR
	5i6bj48cE4xHOjYeg8qEfqP3rzsKgsBsNZ4iAAr3sniZ8L/jTmgdR+UsgZSk58Wv
	A6v4FNbaGM1MmlEMRonUewylkGx5kgkbENUQeyUy1v8FqGU6nzijC6LyNM/6gjcm
	9Zr9wAwOvhpcwGKdWgtu9lOeOdLTOG2NdlqSvc9b3jHwCFTmTsyWMZ8aD6Jgl0IX
	R5olLS++l9k5ulAo6dqrdNhWbSZvTg46fotTSOVb0TDVBLSrFzgH5RmzAwaWPpMs
	061q3EH6KPS6g4aLdP3YMJftlm4xRQ55dMk8z48DYkL3ROcbOvc7llVZEfTDswAS
	rbhh13HSm3bJRGmW9fFLXnmfN3Cftm9Se2LihZwV7Gc=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net resubmit] net: phy: smsc: add proper reset flags for LAN8710A
Date: Mon, 28 Jul 2025 17:29:16 +0200
Message-ID: <20250728152916.46249-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1753716650;VERSION=7994;MC=255693352;ID=388555;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E677063

From: Buday Csaba <buday.csaba@prolan.hu>

According to the LAN8710A datasheet (Rev. B, section 3.8.5.1), a hardware
reset is required after power-on, and the reference clock (REF_CLK) must be
established before asserting reset.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
Cc: Csókás Bence <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/smsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index b6489da5cfcd..48487149c225 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -785,6 +785,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* PHY_BASIC_FEATURES */
 
+	.flags		= PHY_RST_AFTER_CLK_EN,
 	.probe		= smsc_phy_probe,
 
 	/* basic functions */

base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
-- 
2.43.0



