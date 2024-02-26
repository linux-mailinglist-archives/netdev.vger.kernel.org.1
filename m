Return-Path: <netdev+bounces-74889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF758672A6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6559C28BA5E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA71CD36;
	Mon, 26 Feb 2024 11:08:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E91EB27
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945713; cv=none; b=PXSj36PdI1wExzMTjv4vp6kRTYHAmeblTsmgchKSnhsii5lJ/8dmmfD6EL+KBNTbNPJoXJJx9L/nTpYahOTOIbU1xCSgOBsGSorTFXZn0BO4Z63oeZNJafDAeRsOUuHShxqmgVId9RypKcGDrF1OJuPwnF6t3cRznBwwvFGzEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945713; c=relaxed/simple;
	bh=qr8hL1g7sAkBTasKdRNUXXfQV4F3/3ixv1b1xAVXtwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRsHU5bmDfRyhqBOMfWtrYjOSqMkcev3KyVE37tF+bzgVvGsJGVZUpKYiTrHpT4tQJ6vZuD7b60jTQs43kTa0n8kWbX48MY8D0Wf52zS3KfJhf3mwXEcQsGPlAJQw/1Bg0j3CSvndwk4iscyJMOWuEPQaQXlJ2zZHgevOSgRbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1reYqM-00077Z-Uo; Mon, 26 Feb 2024 12:08:22 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1reYqL-002yub-BQ; Mon, 26 Feb 2024 12:08:21 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1reYqL-008rqN-0w;
	Mon, 26 Feb 2024 12:08:21 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 1/1] net: lan78xx: fix "softirq work is pending" error
Date: Mon, 26 Feb 2024 12:08:20 +0100
Message-Id: <20240226110820.2113584-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Disable BH around the call to napi_schedule() to avoid following
error:
NOHZ tick-stop error: local softirq work is pending, handler #08!!!

Fixes: ec4c7e12396b ("lan78xx: Introduce NAPI polling support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 7d7e185d7fae..3ff430198512 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1501,7 +1501,9 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 
 		lan78xx_rx_urb_submit_all(dev);
 
+		local_bh_disable();
 		napi_schedule(&dev->napi);
+		local_bh_enable();
 	}
 
 	return 0;
-- 
2.39.2


