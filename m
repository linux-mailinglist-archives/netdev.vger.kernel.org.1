Return-Path: <netdev+bounces-71988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C13856166
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6391EB273F3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B312D74D;
	Thu, 15 Feb 2024 10:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B912C55B
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993891; cv=none; b=BMOM687MFcjpsO2kBE8uzOSy6Q4mGHmkSidALOrPYbtFmv3ivamPtSlFhgYUh3D/FbEPEUV488yNYoABE8cLXLU3y4qnvgvg+8H1L88YROoefZLkJ2TZ709fq7CP8Ec/KJv9NMTRgMvWrYuzDwKH+OxIbmRkzo7JOnTgcHh3jvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993891; c=relaxed/simple;
	bh=8/wN0UCU9b4QoDCfFWY9uQTPHgMz7cNz6DKSZGXpEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUnTv8r16uuLdq2IJT9Be2yq7Eyk5OgwLbZUDuBEjTtp8v2AxQhBFdMt5FZq+C/L+JXuGOuo4o7R7wNZAZBVlZTzKi/Hqb1IzUeAY/5xjZtiDt+F4dlNbDttZw6RXrcdzAQEFr0vLoU7erVDPsdRaeARl9JJncKhknnq3mcmp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1raZES-0000nu-6H
	for netdev@vger.kernel.org; Thu, 15 Feb 2024 11:44:44 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1raZER-000rl9-OB
	for netdev@vger.kernel.org; Thu, 15 Feb 2024 11:44:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0F0B528E574
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 14:03:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4D0F428E542;
	Wed, 14 Feb 2024 14:03:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 49d7ae4e;
	Wed, 14 Feb 2024 14:03:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Maxime Jayat <maxime.jayat@mobile-devices.fr>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/3] can: netlink: Fix TDCO calculation using the old data bittiming
Date: Wed, 14 Feb 2024 14:59:07 +0100
Message-ID: <20240214140348.2412776-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214140348.2412776-1-mkl@pengutronix.de>
References: <20240214140348.2412776-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Maxime Jayat <maxime.jayat@mobile-devices.fr>

The TDCO calculation was done using the currently applied data bittiming,
instead of the newly computed data bittiming, which means that the TDCO
had an invalid value unless setting the same data bittiming twice.

Fixes: d99755f71a80 ("can: netlink: add interface for CAN-FD Transmitter Delay Compensation (TDC)")
Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 036d85ef07f5..dfdc039d92a6 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -346,7 +346,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-			can_calc_tdco(&priv->tdc, priv->tdc_const, &priv->data_bittiming,
+			can_calc_tdco(&priv->tdc, priv->tdc_const, &dbt,
 				      &priv->ctrlmode, priv->ctrlmode_supported);
 		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
 		   * turned off. TDC is disabled: do nothing
-- 
2.43.0



