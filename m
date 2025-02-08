Return-Path: <netdev+bounces-164320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC7A2D5DD
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3246B3A513D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55052246335;
	Sat,  8 Feb 2025 11:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5481AF0C0
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015492; cv=none; b=LHavl882nSsxZaf3mAVDUFUnu9HpCvMW9/vWm0kAYHgDtulaN5TsV5Iqcrrh17qfYc21Fi1W2iQAJvSpcuJPoCToURyScfWoqNKhWRH8plCVgazstTlI7My0cuGHuKG13UjpikSFL7h5TlgCD41edknl+uELbkM+A2ByzjHYhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015492; c=relaxed/simple;
	bh=5t4DSBoOfzDPQtBpPBz5NqjlhY6Wn2pcw3wnr5yCXjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhsYYt+PpErfF2jSYs6Z0KnsCZQKX95K4p6AMfvRaA0D1rwYU2p9nxWbWssd43OPbHoT0k/AGD5FsHvsXGDaN2r+CBlsIIl7ccglo+wvHqyCw4qSqfAQU51hYZJTE3cDHE/YTDpHlKIj74Vnr52q1UI+7XMJOObzZF+cRI5oh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMu-0006fS-EG
	for netdev@vger.kernel.org; Sat, 08 Feb 2025 12:51:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMu-0048Kz-0g
	for netdev@vger.kernel.org;
	Sat, 08 Feb 2025 12:51:28 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CF5CB3BCCBC
	for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 11:51:27 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B35193BCCAC;
	Sat, 08 Feb 2025 11:51:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e9a33575;
	Sat, 8 Feb 2025 11:51:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Reyders Morales <reyders1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/6] Documentation/networking: fix basic node example document ISO 15765-2
Date: Sat,  8 Feb 2025 12:45:14 +0100
Message-ID: <20250208115120.237274-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208115120.237274-1-mkl@pengutronix.de>
References: <20250208115120.237274-1-mkl@pengutronix.de>
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

From: Reyders Morales <reyders1@gmail.com>

In the current struct sockaddr_can tp is member of can_addr. tp is not
member of struct sockaddr_can.

Signed-off-by: Reyders Morales <reyders1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20250203224720.42530-1-reyders1@gmail.com
Fixes: 67711e04254c ("Documentation: networking: document ISO 15765-2")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/iso15765-2.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
index 0e9d96074178..37ebb2c417cb 100644
--- a/Documentation/networking/iso15765-2.rst
+++ b/Documentation/networking/iso15765-2.rst
@@ -369,8 +369,8 @@ to their default.
 
   addr.can_family = AF_CAN;
   addr.can_ifindex = if_nametoindex("can0");
-  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
-  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
+  addr.can_addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
+  addr.can_addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
 
   ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
   if (ret < 0)

base-commit: 1438f5d07b9a7afb15e1d0e26df04a6fd4e56a3c
-- 
2.47.2



