Return-Path: <netdev+bounces-233870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC0C19BC9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 800F9509283
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515953385BE;
	Wed, 29 Oct 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hpvQrGwa"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F82336EDB;
	Wed, 29 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733438; cv=none; b=qC0e9qm2sC0KcJheAQgUnZqfU3QF6mWJPfzEgP1X4mggPG2EdFbo8cSV6naOHJgFt4Ngn4TdLArD1tTxHaKr3G+uyQisVpi+Who5Le3QIV6D6wJcT7aAX2hc3bAU5Lx6bHuatehWGyHnKzCuhwCd70BzKQwlW0aaO1Vl0/1LOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733438; c=relaxed/simple;
	bh=oUKGnYgilFynlf9RWW9QBJA89qHTYZqr78X8jl0gFLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYZ+xIgz6X8vofwM2H+G/SxmTgXlBeRoUGHlSlrdEbL2vc+6ZJv1q/Off69kiah4POL/6wgay0Xkv5P3lcrp2VljbR1nnzHqx+b+1I7KsUL2HS8G0Wa39N76/E7YWi1xNG614AhGRt+VbdWpCjeFq8OvL2w2TTl3OEnpqxiDrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hpvQrGwa; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9BD3BA09F6;
	Wed, 29 Oct 2025 11:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=hNi+oxh7uhqsLj8vmj9s
	Wtx8Z68XKdLsNBP74idH4aE=; b=hpvQrGwaBrr/YcsYMuEZb0xxCx479u+mxJUE
	9eTMnDiEiZiLPQgRNlDmHBQ866l7KpdxbV9PvzhCG0nu+0+DlWOQ5co6mlpodwsg
	DJ1J+geuShI1VSBLggBLPpMqTjb3ggl1uC/JCHFxF91R3tjMplQi6xx2/wtqoWxk
	qUWFId2/KgnqLm7icI9416B/OammxIb9X8rtAlIyh5mKjTaUaf0ft/EaBxX4tEy4
	8ChikJWmRDM4FzeYDIlchrxhMXaociiP63tqDpQV+9TgW3vb8lodzXuvx5qL1/PD
	DT9t2KtnVVSyiLbWmJGoJ+o3vKIPBGcD00kyjYXWmXt3gFWZRnDcAS2LwsS3K5Fp
	Wxxw8FwGykk0gOaOPYDfSV0CBm0obNZYsRVcO5VfYX0K2HuAtUaAZYSuhOmlAd3W
	3r5FGOMjj4drLXzp+j5uZEbzGYaGYviXkvVRHVlOSuC2MHIBITwou8FYKL+DO1rg
	blV/pIO9kWimcmLvtQ0njgVGC4+xO212jC15CvBlHp8Wm+xswWmeJdY2RM5AJB0g
	iB6o8Koh+C/ADpkd6sgTEukv5y2AlZXVl9etkscZc1qXhTR1XyoF6K2daTGieMFa
	/tJ+YY6rJeh1bcR/SCWl5ikpjuj6vuI4ZF1bOHfBjK4GigYN2DFBYQhwapsb/2cR
	U9H03KA=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v5 2/4] net: mdio: change property read from fwnode_property_read_u32() to device_property_read_u32()
Date: Wed, 29 Oct 2025 11:23:42 +0100
Message-ID: <2609ecfcd2987e9d41b1e1c7c13c1b438b37e297.1761732347.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761732347.git.buday.csaba@prolan.hu>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761733432;VERSION=8000;MC=2670981356;ID=148163;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677066

Change fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V4 -> V5: tweaked commit message
V3 -> V4: unmodified
V2 -> V3: unmodified
V1 -> V2: added new patch based on maintainer request
---
 drivers/net/phy/mdio_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index b56a75ee3..e24bce474 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -86,9 +86,9 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 	struct reset_control *reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	/* reset-gpio, bring up deasserted */
-- 
2.39.5



