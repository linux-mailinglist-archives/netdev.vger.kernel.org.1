Return-Path: <netdev+bounces-235406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CDC300CD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81FF434DC54
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69E2BE053;
	Tue,  4 Nov 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OOS4rVqV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4619CCF5
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246245; cv=none; b=G0hPVpOeJK1txkyY57CgeFLrk7QFvwaWtT4MfYBH4GmBRThye5aCLa4oDNhM1bxEUTr6pDAEW8FfBwyKpM0uAy6SSw9Eg7dHNCLmXm2RebvFF75YDtZIicqJ+QwDOY/nDDAr9hT/65xAXgaROJOdv+EZd5S8SXOBylTEhGyH+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246245; c=relaxed/simple;
	bh=E208xbme32DUh0+PoOZrwxEIy592t9y4mdHdRG4v2t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFHSw7lh3tA4VxgvMyiGHZn7vAR6vM+ayO60qTfdRs4FjOUZ5PnjYP72Pq6UcJbQMjkXKrVCnIZzkC1XtrhNXdBD2Ow+yYqL6L88ErdSJEDFX/HdK3r6HqA0o62eteIJgr1Q6xN0Ptb7+dM1v9kKq+ivAQE0YNFp1Qv0BPkrUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OOS4rVqV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CFDFC4E414F0;
	Tue,  4 Nov 2025 08:50:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4370606EF;
	Tue,  4 Nov 2025 08:50:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17E8810B50980;
	Tue,  4 Nov 2025 09:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vZJk2plEMwbN456OJuHCM5PxtFTtjXp8HXRTqODruAo=;
	b=OOS4rVqV00ZWDaTbCpBYP79zPURpOmqne9BaVOssiNWQ6DoZ0Fuwwdd0cKxxaSUiADsRfj
	ByYINzJC4nD/83q6uTWoNxv5fCRO/CWH1E5fPFfXUDEJ6bg2ioJfvAVbXRdD5yes9zZL8l
	oa8cEKmdOVXqeKp0QuKlmaCeEb6wgM4usr/UMTZozGSgr6VRQrOLVUC5vTU7nNqA3t6voE
	jDF0lUFi/+DN3OAFhnqNfYSiys9umOeFT/6MMxuRPevT3nQ2PDQfHEZUJgU1qmFW4klmYM
	8jH4rm3W53o4lcAWL8/Hl9HuqsyxiWI0xS3PFNKoEwNx2GQ/udHlrxB7XRIYPw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 04 Nov 2025 09:50:34 +0100
Subject: [PATCH net-next 1/3] net: phy: dp83869: Restart PHY when
 configuring mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-sfp-1000basex-v1-1-f461f170c74e@bootlin.com>
References: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
In-Reply-To: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The DP83869 PHY requires a software restart when the OP_MODE is changed.

Add this restart in dp83869_configure_mode().

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 1f381d7b13ff..fecacaa83b04 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -797,6 +797,10 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 		return -EINVAL;
 	}
 
+	ret = phy_write(phydev, DP83869_CTRL, DP83869_SW_RESTART);
+
+	usleep_range(10, 20);
+
 	return ret;
 }
 

-- 
2.51.2


