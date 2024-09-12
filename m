Return-Path: <netdev+bounces-127727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E729763F5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B883C1C208B5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494C1925A8;
	Thu, 12 Sep 2024 08:06:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2E190665
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128379; cv=none; b=pHP3PeahXBTJ8CowL5/iFrXfnP/FFrxZaFiBk33qWGsU127Uqd75g3C42QnTMMdI5KpjFtVDwfkd+OeV2d8AKGwhlEoRRW41p2FxOIqe13k53WV85SYYwUsSdnGC3YwFmX8Wt/FlGkhFyefOeU5X97bqsB87gBWP6mrQoEvECKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128379; c=relaxed/simple;
	bh=8MZSrcJZ4j6ERG43xGYW02k1WDzKj2clsxG6RrsaDlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzLxJM9GK6i8bUotEKzjXgQY/8REoXFZAQMHKzcznJH8g+tBCUEHGdza7h0VGWGtDzKd1LpmzdExLxBQYeGGOExtbXfdi+k3ZEB6f3gOdGeqzBSbawZpBfpgn2OuiQfZTsAnhRdkfCssnVrEsz/mLCCOp5BfiIJHp+wCdBfnzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeqA-0004AC-2Z
	for netdev@vger.kernel.org; Thu, 12 Sep 2024 10:06:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-007Khn-IK
	for netdev@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A3664338EF2
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:04:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F13D6338EA4;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1b460190;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next 5/5] can: rockchip_canfd: rkcanfd_handle_error_int_reg_ec(): fix decoding of error code register
Date: Thu, 12 Sep 2024 09:59:02 +0200
Message-ID: <20240912080438.2826895-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912080438.2826895-1-mkl@pengutronix.de>
References: <20240912080438.2826895-1-mkl@pengutronix.de>
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

Probably due to a copy/paste error rkcanfd_handle_error_int_reg_ec()
checks twice if the RKCANFD_REG_ERROR_CODE_TX_ACK_EOF bit is set in
reg_ec.

Keep the correct check for RKCANFD_REG_ERROR_CODE_TX_ACK_EOF and
remove the superfluous one.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://patch.msgid.link/9a46d10d-e4e3-40a5-8fb6-f4637959f124@stanley.mountain
Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Link: https://patch.msgid.link/20240911-can-rockchip_canfd-fixes-v1-2-5ce385b5ab10@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 6883153e8fc1..df18c85fc078 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -491,11 +491,9 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_CRC)
 			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
-			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK)
 			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
-		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
-			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
 		/* RKCANFD_REG_ERROR_CODE_TX_ERROR */
 		else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_OVERLOAD)
 			cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
-- 
2.45.2



