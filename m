Return-Path: <netdev+bounces-230514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840FBE98A7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C951AA840B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12BE336EF1;
	Fri, 17 Oct 2025 15:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AB335092
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713723; cv=none; b=OMBoRVOWGdFlBOZ0QGa/Cr2QC2pMsdV2WJnmxGKKL9mxGDcJUm7bknCM2MEsRH72kFslaufxrbLdOL+ym0068sQNaoZyE4KgZw0H1baWVQwhao54mN4/iZf5zwhb9TUoNi2xItyVZOSVxFLsB4P8PWARQS1ZIXaZE92Fn88XIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713723; c=relaxed/simple;
	bh=mIlcMzbCuAOQ5KEVjGBkKYZt8IkWEg/v4qvBGayHWQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdaX92gSSrHcW2i31I6icWFZSwDjvUbGP3mvpAALXIWhSs+rorhdF4MV8y88vGx1S1Ko5db7Hue2O1kvBOI68u8XTMI6uIE7J+CYp6COX5YtkHljMlx98gw0q1X23qPiszFhn7iJsUYHdR7qdSDgFspWGg05sjCwnebB+mf1220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003OA-Ja; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-00450w-0F;
	Fri, 17 Oct 2025 17:08:30 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8E1B4892BC;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/13] can: m_can: m_can_class_register(): remove error message in case devm_kzalloc() fails
Date: Fri, 17 Oct 2025 17:04:19 +0200
Message-ID: <20251017150819.1415685-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017150819.1415685-1-mkl@pengutronix.de>
References: <20251017150819.1415685-1-mkl@pengutronix.de>
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

If devm_kzalloc() fails, it already outputs an error message. Remove the
error message from m_can_class_register() accordingly.

Link: https://patch.msgid.link/20251008-m_can-cleanups-v1-5-1784a18eaa84@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 98e7ab612bba..8013e8835027 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2517,10 +2517,8 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			devm_kzalloc(cdev->dev,
 				     cdev->tx_fifo_size * sizeof(*cdev->tx_ops),
 				     GFP_KERNEL);
-		if (!cdev->tx_ops) {
-			dev_err(cdev->dev, "Failed to allocate tx_ops for workqueue\n");
+		if (!cdev->tx_ops)
 			return -ENOMEM;
-		}
 	}
 
 	cdev->rst = devm_reset_control_get_optional_shared(cdev->dev, NULL);
-- 
2.51.0


