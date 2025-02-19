Return-Path: <netdev+bounces-167691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E06A3BCE5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F82A3B6914
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78601DF73B;
	Wed, 19 Feb 2025 11:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BE1DC98A
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964843; cv=none; b=rzDtmABx4ZepLK9C6peWDJrTJP6uHD37DGqhnfwjcuc5KWm+v1tTVSMu/6zlusQz0k36vP8j4KPasqtQ2mq2ba99PswOMvGyPxi4PdK0j+ElZosZ8w4djm79a1shwNehxctXd6sAgMnn3mC37VnkOt1Jr8erLDRvUjyw0mLGFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964843; c=relaxed/simple;
	bh=8SQqOmIz6yLxjALdK6ZeGHcScc8V9cnjko2Ldv2l0XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcUR4iEtlXGHs1wNqpRnc9+fJucMvMg5tUdLwrDOecmfT6H0AvRvwZsve7Ws8lc7DKukKvp4mAnDmz/6qeuNqyDwS0hJhC/0ZTh13ypIrLEfjbNJ+ntaRasszBGeHMGMMTNadXgWAKqqS47OfQPNZATUwFOXe00o8WbwfTsgxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL2-0001VB-Ch
	for netdev@vger.kernel.org; Wed, 19 Feb 2025 12:34:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL1-001kzZ-2F
	for netdev@vger.kernel.org;
	Wed, 19 Feb 2025 12:33:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 574873C690C
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 11:33:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 22DF83C68D8;
	Wed, 19 Feb 2025 11:33:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 71b130ba;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/12] can: c_can: Use of_property_present() to test existence of DT property
Date: Wed, 19 Feb 2025 12:21:08 +0100
Message-ID: <20250219113354.529611-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

of_property_read_bool() should be used only on boolean properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250212-syscon-phandle-args-can-v2-3-ac9a1253396b@linaro.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 96d1225c41d0..1acceb097c17 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -316,7 +316,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
-- 
2.47.2



