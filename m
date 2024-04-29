Return-Path: <netdev+bounces-92213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C14D8B5FB9
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FE1C219F9
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436508664D;
	Mon, 29 Apr 2024 17:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A58626A
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410679; cv=none; b=hmVbJ0IFQMkhTrbxxTU87KExhIv1dVSRUbgoQNUNTggoLTnMQddijGZj/6WT3faWRXrfPqT01XU8hD3JbFCr3TEsYHv/jMwrX+UGeOCKtOkpP+Ku0HWUpR7APbe5aweGqVj0zgxTccs3rN1MhMaun5MMY6m57xRMqKOnJVtH9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410679; c=relaxed/simple;
	bh=/bsCMEHgE0FH4Q37n2sNEuI196GZhVW+bZsnmdYiJDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eGSKJWK0XNjNzXbPN7awKtTo2aRgqfo7kArnM17wtmfOtzpRFBwkxRhtQnBY2KGV1pAKYyrxmNd/SiFOfi24N9A8aDJTLjU9iYNFLpz1MIyCBD5lA30chRuOGKzbnxyKPNVHyz1a40IplefBpKmX5FFWPtTOKLWyNP8fQHlnoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UX4-00016e-NN
	for netdev@vger.kernel.org; Mon, 29 Apr 2024 19:11:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UX4-00F1Hr-3m
	for netdev@vger.kernel.org; Mon, 29 Apr 2024 19:11:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C3D742C22F3
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:11:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0E42B2C22D8;
	Mon, 29 Apr 2024 17:11:12 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ea361e50;
	Mon, 29 Apr 2024 17:11:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/3] can: mcp251xfd: move device init into runtime_pm
Date: Mon, 29 Apr 2024 19:10:56 +0200
Message-Id: <20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDUL2YC/x3MTQqAIBBA4avIrBP8KciuEhGVY81CE60IorsnL
 b/Few9kTIQZOvZAwosy7aFAVgyWbQorcrLFoISqRa0M90tUjbyd5ekMB3kco+dGztpo10qhHZQ
 0JnR0/9t+eN8PZKRoZWYAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/bsCMEHgE0FH4Q37n2sNEuI196GZhVW+bZsnmdYiJDY=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmL9Shz2UKFrqeeS3Vr5ZWp3CGikwggTNuinR9d
 kXUw2alM7+JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZi/UoQAKCRAoOKI+ei28
 b2xoB/0aIreRhaGtTvvlWi8eKhyuTIKcAcN0v2jk1hpvofHVsVt40EUo7lP7WKBGeSBBhRSpqOl
 eNCMVMdC/PeesMMAk+7xlu3Vc0JOX0yjE4/TuOlK/NB3FPAQnXNb9muDUZDXkmbpD5ns8o1EXC2
 HcKFCupRnszmVaVfC61ZS9+ai5XxFejEV3bQtbOuTdgMbZmR43TsiCQmm4uoiqKeTBVO+G6uD6y
 m4pQxlQqSzs3LVg5Hk8QD7yzI8FTEOOvX2lASenJP7eX4Xh97Eh+YCzOCvWr3OMuG1H0Ub1DDGq
 uuWO/jLH5yWFHROw7qp4J7qqITS2F8TkFpWoFwN6RZ6G4T1f
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

In order to support GPIO support, the soft reset and basic
configuration must be moved into runtime_pm.

This series first cleans up some code style and then moves the
starting and stopping of the timestamp worker to ensure that the chip
remains powered down. The last patch moves the soft reset and the
basic configuration to runtime_pm.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (3):
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
      can: mcp251xfd: move chip sleep mode into runtime pm

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 137 ++++++++++++---------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |   2 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |   7 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c       |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   1 +
 7 files changed, 91 insertions(+), 62 deletions(-)
---
base-commit: d63394abc923093423c141d4049b72aa403fff07
change-id: 20240429-mcp251xfd-runtime_pm-91b393f8103f

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



