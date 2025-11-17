Return-Path: <netdev+bounces-239120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19112C644F4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 407F44EFA07
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A54330B3B;
	Mon, 17 Nov 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HRZuz9nk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0D32F75F;
	Mon, 17 Nov 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384772; cv=none; b=e+FGw8AuSunZD9tqTHSWVVaAcUR2t14Qm81x1wn33BikzJkoqVeFLrOb2PeSLqUyREVIB5Vk78adDuJrngdaV7WNEMePU78zTLGPyDxsc3POp9A/g+zslU5vYYzDYlz7Iks5XUCZgJ2mtvTcWov/6wQNQtsqd2yObaloq0+8B0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384772; c=relaxed/simple;
	bh=u54h61ZvJrTztE7sbN5g3tlZG3G0RPTsAXhQ2w682FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzh6fWmNFkuc02ryrxwx6p9JHZce4QIY34u4tK9CxWE+vOXbzQBhlt3eC2vmSDPN5urBGE6MrQ5J5TNUncWG6va/eugftwQi8ngU3ciD7+qkb/OZ/F8zPNqQuRAGqVd1DJ5Q9Utl9r9lIXXU3JoyUAd4qGn9useFKHwPZZm3bOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HRZuz9nk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D038A4E4173F;
	Mon, 17 Nov 2025 13:06:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5418606B9;
	Mon, 17 Nov 2025 13:06:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EB291037160D;
	Mon, 17 Nov 2025 14:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763384767; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yrH8+DZYQiftysCPablq1ZjCFXzIN4d8ug9Dmz4QpHo=;
	b=HRZuz9nkWXGwMam2grpnYWcrekez2QSXioIY5vWVBFSJJYrAA6lDz+TLXerPpLDU3rFXjE
	8Gqg+AL+n3Ij2ucvSCJnA9WCu4Xoju/CeolkcMZEBks0YVHelKCwTw0teXEdIXHg6LkT+H
	cHaAaG5NZip0ND6dcHkqdyKA+4v/DDneGJlgayf92anZQYI093pId1pZwP460mJ/HAzA7F
	oa6pXD13Mobkiq3F56izAi9VeSjZ2Yj+95847QDbQ7RkLkxgRehYuZ+71AXmM6XXEHSrop
	33oYKTjj3eFcwYS+amMtICXwjfR9GQyTGHNhitpwxRunWywW8MtZZoJ5qFO2ag==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Nov 2025 14:05:45 +0100
Subject: [PATCH net v4 4/5] net: dsa: microchip: Free previously
 initialized ports on init failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-ksz-fix-v4-4-13e1da58a492@bootlin.com>
References: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
In-Reply-To: <20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

If ksz_pirq_setup() fails after at least one successful port
initialization, the goto jumps directly to the global irq freeing,
leaking the resources of the previously initialized ports.

Fix the goto jump to release all the potentially initialized ports.
Remove the no-longer used out_girq label.

Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a622416d966330187ee062b2f44051ddf4ce2a78..2b6f7abea00776fafff0c1774cab297a7ef261da 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3035,7 +3035,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		dsa_switch_for_each_user_port(dp, dev->ds) {
 			ret = ksz_pirq_setup(dev, dp->index);
 			if (ret)
-				goto out_girq;
+				goto out_pirq;
 
 			if (dev->info->ptp_capable) {
 				ret = ksz_ptp_irq_setup(ds, dp->index);
@@ -3083,10 +3083,8 @@ static int ksz_setup(struct dsa_switch *ds)
 			if (dev->ports[dp->index].pirq.domain)
 				ksz_irq_free(&dev->ports[dp->index].pirq);
 		}
-	}
-out_girq:
-	if (dev->irq > 0)
 		ksz_irq_free(&dev->girq);
+	}
 
 	return ret;
 }

-- 
2.51.1


