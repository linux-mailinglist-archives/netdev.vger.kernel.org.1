Return-Path: <netdev+bounces-242756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6DC949DD
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 01:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B94E2504
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 00:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE9C20B7ED;
	Sun, 30 Nov 2025 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rurryUB3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JnwSs4eI"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956A207A32;
	Sun, 30 Nov 2025 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764464344; cv=none; b=nI1vatWqzs9D/0gg8/klOZNZLkwfnIiEO2KOlSw3eB4Djl0UgPOl2X6GbE21ViUh6MQxKDby8GWU3eYvwYgxPrJM0JCrpvtKHgI6wznDiBCnhpQk1MXsdYS/chMJOlHUOhI4L6i7IZYDAWJguo4rjplI6L8kFOS0Ee6unY4jF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764464344; c=relaxed/simple;
	bh=2w/j0owgffyl5IiU504JyhmHR7ZlwhxbIodvBA8YpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu9W9YOSVD2FmwDGKSRl6xYIFeqOL/9XUswqre0xC8W3NwHjvwRdosMznwEyGg6+O1A+YbU/q6e8ZeZbD9VXSbpQDUO41pGBviOt552MoGUwG/WhyVL84SbRBNj+BHzLNjxfCT+/csbYGC7l6JWDgzkA4wg8iXmwDQ5LgFeyoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rurryUB3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JnwSs4eI; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dJpZR2RpSz9t0f;
	Sun, 30 Nov 2025 01:58:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764464335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFZ3o/JoWJ14SmvxLRLFjppEN8DismhujgSwWfAowBg=;
	b=rurryUB3E0PXNwNAorPHzt3YxyHKvW/n9nbaABtIxfF46zsIWQ3hAkDU9/wluTnD+YLMb8
	jNi+8Pb8cnP6WEZXnA+3TOHFd5qqVnUhAKi9z+Mpd/8f4xRyZLr99qfJw6MLFru/S4AzMY
	83H4Uqph91axwRGPAH8dwa2ZYxxK/Q2yaevv7izXY3WGQhJrtWRuGCBdSVWwYhNRGKmKd5
	pmZl+0NN00WiAM75gUEGO90zhYS/soQRYfNq6SEsqUNCarm/zF70ND0Dum4J4ENUrBCQiu
	ge4SlH4T0iZr/v0g31aDuuO8sQweaFnc8NVFwUrfWOm7/DdYa59fQjZ9I7cxpQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JnwSs4eI;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764464333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFZ3o/JoWJ14SmvxLRLFjppEN8DismhujgSwWfAowBg=;
	b=JnwSs4eI3IkQIQ9LjIbqADmukxyISAPNDbvO6ZpoTd/hevTXjKcfO15LcSa2DsnNe87geQ
	XDAkESyc7y822VGhpF5GN5q+h+WU+5XA90g99UnaGz7sLvZFw65FTT38UPZ4oKd+53vYQQ
	ligRqASNwNSMumf/ICXBmil8wcZ6nuQnLKkQ+rK1octB3bg/ixrqOoA9DWq6AIOT/xsU01
	ass3Jjje4ve9F1Gx45twuhUpRQ+B5KhM68CvODZcPCJJcN1G+iMqyRtYnUzqQOkrWEhaBE
	4uG/+ipWOC8yd0jQ33/oHnKbeUDdH7A852gR/GYFz1yjBAFf0UF5tuQ4a1WnQw==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,ssc-enable property
Date: Sun, 30 Nov 2025 01:58:33 +0100
Message-ID: <20251130005843.234656-2-marek.vasut@mailbox.org>
In-Reply-To: <20251130005843.234656-1-marek.vasut@mailbox.org>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d1f9b1239dad232f899
X-MBO-RS-META: fkbytoo6wszf1onj39bao41qpa4rwjbc
X-Rspamd-Queue-Id: 4dJpZR2RpSz9t0f

Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce new DT property
'realtek,ssc-enable' to enable SSC mode for both RXC and SYSCLK clock
signals.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index eafcc2f3e3d66..f1bd0095026be 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -50,6 +50,11 @@ properties:
     description:
       Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
+  realtek,ssc-enable:
+    type: boolean
+    description:
+      Enable SSC mode, SSC mode default is disabled after hardware reset.
+
   wakeup-source:
     type: boolean
     description:
-- 
2.51.0


