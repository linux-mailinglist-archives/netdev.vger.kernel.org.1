Return-Path: <netdev+bounces-210088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE003B1218E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115BDAC59CC
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69682EF9CB;
	Fri, 25 Jul 2025 16:13:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13702EF2B2
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460020; cv=none; b=lL+/1LOzsb45+Balsow/m/s3Br72XSpq8oTtEuSy/o37k8iJC/HBDX745KRwGMWUPn9HhX3STJfAgHZyVFjO8LTWN2ctSFG66UuV80AaWD7bs1yuNrIMH2FB0P1sfk40BlI7ligY8mXkMeIOyuCx/3r8ajZT5929ZeEKHJXivL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460020; c=relaxed/simple;
	bh=di/y1ujHcckq1+9t7FFelcdoI8xdT4ldZBty9k1c+D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBO9Cg5mh3i/tYncOAZIK/xgqKGs1rCl3wSdGOAiy6g/Wg0JwjFvCjqeYhabqQ1hIzmxtA8aPvFT+lgz7Cquakq1vy3LTRPIARm2sA+eH6SuhiC/ceOm0QzRgxlrpnHUk4nu2AElZkXXfeQZM7ApNR30S2KjbaNK3wxJKqiAkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-0006cl-Ik
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL37-00AFXV-1p
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D055844986F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F412444980C;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 649cccf0;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Randy Dunlap <rdunlap@infradead.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/27] can: tscan1: CAN_TSCAN1 can depend on PC104
Date: Fri, 25 Jul 2025 18:05:15 +0200
Message-ID: <20250725161327.4165174-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Randy Dunlap <rdunlap@infradead.org>

Add a dependency on PC104 to limit (restrict) this driver kconfig
prompt to kernel configs that have PC104 set.

Add COMPILE_TEST as a possibility for more complete build coverage.
I tested this build config on x86_64 5 times without problems.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250721002823.3548945-1-rdunlap@infradead.org
[mkl: fix conflict, remove Fixes: tag]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index ba16d7bc09ef..e061e35769bf 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
-	depends on ISA || (COMPILE_TEST && HAS_IOPORT)
+	depends on (ISA && PC104) || (COMPILE_TEST && HAS_IOPORT)
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
 	  https://www.embeddedts.com/products/TS-CAN1
-- 
2.47.2



