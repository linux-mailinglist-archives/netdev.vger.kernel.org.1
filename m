Return-Path: <netdev+bounces-242679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBCC93982
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 09:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031923A7FE4
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793428032D;
	Sat, 29 Nov 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xyVZpWZ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68F27A461;
	Sat, 29 Nov 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764404582; cv=none; b=QUprCQAWmW4WyZOBXCgveUbWuVAyOJd445WG7Gg2i/gMFo7/lk9cuV0xYMweF3DD0rbh2jOAJBHnlBadwD3HAfqf0Ymlv5LT831cEi5hepaQ3ewdp0EoFm7Y/WjBveu4DXHmRmUHr9lwVV9nb4tG7/SOr+/NoOSrkhnb5Ic8BFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764404582; c=relaxed/simple;
	bh=AWU+PLSApT8kjesX7dOkFXgGY2hpp0B4x81yGGBbha0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvdRMIp4C40G2WKr8mpOZpPPM7AEfa0ffpp4+wIs3d/HcMHXJcgt7CqR7No50hKpwTnmEFyg35l4pXAH8UCjUQPDoY7UmDWnDbp3K2R+SfLfhrDjo9iOcv9h5wIStXMoNADXH0xYjU8R1EMGAvHwWbDNvfVgd6rKmO4uuuXU7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xyVZpWZ9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3AEB54E41969;
	Sat, 29 Nov 2025 08:22:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0FCEC60706;
	Sat, 29 Nov 2025 08:22:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CEBF119104CC;
	Sat, 29 Nov 2025 09:22:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764404577; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EguoN5UoBIxCjveRFklA6CdlXXdagmARsUp7EB8KNWQ=;
	b=xyVZpWZ9ED1u4fVW86YIeJw3nnaSf7Gg6JaqEOf+0aEKvDPN7jabCAYaD0WjznI1tzkabs
	D4qUxL85PtVjlf1d5UhPA6R4XjQO6LDeQ91mUfLONEM20NlSUMqmnWbRvMfHQL4jbc01hu
	8Am52qgyOoM8+QFcJaE14WMANV+UOPSsd/3V1EZeRMYXDzpqFYrEDctp6k5OyRgIr5UxAS
	SR5jijmxrvQl+lpbGV6OsGOXGQRFFkOnEM5PXjaFSLE753lWGaijMzLenbXgq6BBlf+Dst
	Ja92ZHLRcDT50pIzKwg2gVQIrOhIRw4hDEKN4LK+dsFY3ZStWdTLjSjbfeYzbw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v21 05/14] dt-bindings: net: dp83822: Deprecate ti,fiber-mode
Date: Sat, 29 Nov 2025 09:22:17 +0100
Message-ID: <20251129082228.454678-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251129082228.454678-1-maxime.chevallier@bootlin.com>
References: <20251129082228.454678-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The newly added ethernet-connector binding allows describing an Ethernet
connector with greater precision, and in a more generic manner, than
ti,fiber-mode. Deprecate this property.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 28a0bddb9af9..23c70d863c39 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -47,6 +47,9 @@ properties:
        is disabled.
        In fiber mode, auto-negotiation is disabled and the PHY can only work in
        100base-fx (full and half duplex) modes.
+       This property is deprecated, for details please refer to
+       Documentation/devicetree/bindings/net/ethernet-connector.yaml
+    deprecated: true
 
   rx-internal-delay-ps:
     description: |
@@ -141,7 +144,11 @@ examples:
         tx-internal-delay-ps = <1>;
         ti,gpio2-clk-out = "xi";
         mac-termination-ohms = <43>;
+        mdi {
+          connector-0 {
+            media = "BaseF";
+          };
+        };
       };
     };
-
 ...
-- 
2.49.0


