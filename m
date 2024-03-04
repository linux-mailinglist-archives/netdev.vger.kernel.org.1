Return-Path: <netdev+bounces-77019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA87B86FD19
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EB31C21F29
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472621340;
	Mon,  4 Mar 2024 09:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE51BC44
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544068; cv=none; b=IipHVlJSHme7AGqjffNZjSX7Wm8VukPpQjr2OFSEqxRG/TMkYK2aYN1UKNUOeAeaHxVvhWmUjry09+N6usYJ0BuELY57rU4Bw/1ZK2lGOt4ZGylXVtbzF+pUH1ZY4shl99kRbAvZ0E7E3nXxF8fvSWyPkE25Y/JC5IW8cr5u1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544068; c=relaxed/simple;
	bh=8wXcd+Z5EO9cdXIhilLaPZnCH0QIUEILpu9Jj2dmG58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjd1k3rVoAZ/podpz/+5gE4ftr6aH9q5iT9PvaIdyZjA6qI4+Hs+1JC+c6KQ7L2bhq/yiLQpYBZkRr3rF8D6u/2qE6CvA+s3MpsLblKwc6zCbKv5xG+XipLkDHIg1vqlIZPq/wqiDGk2ZYrfi6cVi9iUeqLu2VW4hZ08TLOrRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VM-000555-KK
	for netdev@vger.kernel.org; Mon, 04 Mar 2024 10:21:04 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VL-004K4A-Tn
	for netdev@vger.kernel.org; Mon, 04 Mar 2024 10:21:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 94FC929CB49
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:21:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 23BA029CB2E;
	Mon,  4 Mar 2024 09:21:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 19d253dd;
	Mon, 4 Mar 2024 09:21:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/4] can: mcp251xfd: __mcp251xfd_get_berr_counter(): use CAN_BUS_OFF_THRESHOLD instead of open coding it
Date: Mon,  4 Mar 2024 10:13:58 +0100
Message-ID: <20240304092051.3631481-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304092051.3631481-1-mkl@pengutronix.de>
References: <20240304092051.3631481-1-mkl@pengutronix.de>
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

Since 3f9c26210cf8 ("can: error: add definitions for the different CAN
error thresholds") we have proper defines for the various CAN error
thresholds. So make use of it and replace 256 by
CAN_BUS_OFF_THRESHOLD.

Link: https://lore.kernel.org/all/20240304074503.3584662-1-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index eebf967f4711..1d9057dc44f2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -837,7 +837,7 @@ static int __mcp251xfd_get_berr_counter(const struct net_device *ndev,
 		return err;
 
 	if (trec & MCP251XFD_REG_TREC_TXBO)
-		bec->txerr = 256;
+		bec->txerr = CAN_BUS_OFF_THRESHOLD;
 	else
 		bec->txerr = FIELD_GET(MCP251XFD_REG_TREC_TEC_MASK, trec);
 	bec->rxerr = FIELD_GET(MCP251XFD_REG_TREC_REC_MASK, trec);
-- 
2.43.0



