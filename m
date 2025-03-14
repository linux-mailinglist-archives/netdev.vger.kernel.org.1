Return-Path: <netdev+bounces-174894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F87A61286
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F410D1B63490
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E61FFC7D;
	Fri, 14 Mar 2025 13:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055D1FFC41
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958615; cv=none; b=oL9vk6J7Fy7wttP3vfXTswrqm6wvzOhZZdWBJMh4k9Zoi6tryEqnoTM5857ss5uDDgtJ6R8yxzEHhCeyKLSi+ZS6talqGBLcShJ23az2sH7fRddNao/2Y2q8elkaCgzsNhr7Pg7b5c7+9LZpKvqgw+kRMCgZuK3czSEKVKZp20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958615; c=relaxed/simple;
	bh=uyPE7Ir1ESMjme3nm+DeQ6Yt9SK9hzanr6oAlGLKIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpPH88MFa8q0NihlKXJBjE4j4zbBQe5aESO3UOwXI9XfkU0uD0qGKFUnUmqRCv3z8Do76y79GeNgMFEvN+233se4AgPBjfnEUTx524KcfY+pIeM/E+5aik8d4iXy/ukoolI2v+JKzo6wn6jI51Jkrv3IONrlxsnSU+upKZg1x6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-0001iy-WD
	for netdev@vger.kernel.org; Fri, 14 Mar 2025 14:23:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-005i5p-1X
	for netdev@vger.kernel.org;
	Fri, 14 Mar 2025 14:23:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 255213DBC0B
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:23:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 42F943DBBE7;
	Fri, 14 Mar 2025 13:23:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8b61dede;
	Fri, 14 Mar 2025 13:23:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/4] dt-bindings: can: fsl,flexcan: add transceiver capabilities
Date: Fri, 14 Mar 2025 14:19:15 +0100
Message-ID: <20250314132327.2905693-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314132327.2905693-1-mkl@pengutronix.de>
References: <20250314132327.2905693-1-mkl@pengutronix.de>
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

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Currently the flexcan driver does only support adding PHYs by using the
"old" regulator bindings. Add support for CAN transceivers as a PHY.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Link: https://patch.msgid.link/20250312-flexcan-add-transceiver-caps-v4-1-29e89ae0225a@liebherr.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/fsl,flexcan.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 73252fe56fe6..37e3e4f48762 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -77,6 +77,9 @@ properties:
   xceiver-supply:
     description: Regulator that powers the CAN transceiver.
 
+  phys:
+    maxItems: 1
+
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
@@ -171,6 +174,12 @@ allOf:
         interrupts:
           maxItems: 1
         interrupt-names: false
+  - if:
+      required:
+        - xceiver-supply
+    then:
+      properties:
+        phys: false
 
 additionalProperties: false
 

base-commit: 941defcea7e11ad7ff8f0d4856716dd637d757dd
-- 
2.47.2



