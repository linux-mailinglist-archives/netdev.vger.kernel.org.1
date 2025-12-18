Return-Path: <netdev+bounces-245408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B0CCCFDE
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D27B23008562
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D43126BE;
	Thu, 18 Dec 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OrC7zml7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wz/zTnmx"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2A31282E;
	Thu, 18 Dec 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079471; cv=none; b=DCFWEBu8lLMHPZeGsWEow8ceMXX+/NBlWoZHO8yzZxsmVd9Nw/St0BF64rtN7Gi57Y6kZebr0b2/6r/4waGTM7bg5iv7MxB48BIeWxuaKo7lOR8aW2X7pJLWFRgllEef233Ajarh/7/K9/VYHVqQpEQJyJ1lBo5Ovtr4YKxmMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079471; c=relaxed/simple;
	bh=1Eb6/Qiz+DilGZitP0VpE6/NKIW1hMoZiKzmUWUWzow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2z2/tsvl/H+ATynMqwu9FVEeNKHY0vkfjHW4/JrL5Jb2B0UyFFpqO9Gbc+bGG6keQzkV+/xcbkd8V88jy3H5jMPvJ8zXxHJVsh8aE+JWe8lnXtwLACY4MSzS0U9p12y0F8MfTiN25a8S6jU2Cyx9DkRZyr5jxjlHF9DuUDjQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OrC7zml7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Wz/zTnmx; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dXHtg3hBJz9ss3;
	Thu, 18 Dec 2025 18:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3rR1xrhGxRltRK4YyFW/wylve91wMwFu1PFVpulu48=;
	b=OrC7zml7iPoSQlFj2bHPPo2yBFR8vLflGhVeNVsjRzAQVZI4FIvGHS66YTg06VmUV5GGLy
	S1HFwmCeZnjXHSeSCgefuhcaB6+i2lukM6F2ADVrixqZY/PC+89jDOqtzohEoNuKt14s3O
	95i8N/rtBAU+gL8k9of0A9cTDaNJiLaPw4EoSwgQyJJdXrywplFTiZPRYtbIkfJpb0+aj/
	yABu20jo+nvDwZFiOy9qOxUcFwMuNqdg5j+k8EZvwb/NdWpIdyxflZsE+Ukb0qiI7GJzvY
	DFn3sdQG6UBjoI1h2JeTbr54w0wQrfwY3S/k1emZwSq9qFvQeZsgU6+MWUYk2w==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3rR1xrhGxRltRK4YyFW/wylve91wMwFu1PFVpulu48=;
	b=Wz/zTnmxpewZE6MScAkCSY0crECXl7KRbbkGYZsYgRSQLp25dphhHZa15UltSWNIOPD7x4
	Fe95MNQobZqyzJxwwYVmsVJ9ToniLkHe8/ALc97xnJSJqAJqUNOwWoR5nNEDGZzHUnjbVx
	CWin9KkkGFnfN9Is3mJRYVhXyyvGl9cIrdDJs7Q6Md8X+2+CENrd6wG5fG8z84wq6xHHx+
	+/UN8jMGGgdliFBS2YTILRCYa8RN1qw8gwEh9zBrEaeS7gq275wHgOLL9w2Ke1skSYTuDa
	CHYR7GnU7PjeQfHFeZQFHuA4IJfApdajdalyuVvpLlCp1V7bNoWY4LyX04Ijow==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v3 2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property
Date: Thu, 18 Dec 2025 18:36:13 +0100
Message-ID: <20251218173718.12878-2-marek.vasut@mailbox.org>
In-Reply-To: <20251218173718.12878-1-marek.vasut@mailbox.org>
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 04fac4b9fc6dda07fd9
X-MBO-RS-META: nc6dxpk4t616b74uj64hwr6rrhydcj8k

Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce DT properties
'realtek,clkout-ssc-enable', 'realtek,rxc-ssc-enable' and
'realtek,sysclk-ssc-enable' which control CLKOUT, RXC and SYSCLK
SSC spread spectrum clocking enablement on these signals. These
clock are not exposed via the clock API, therefore assigned-clock-sscs
property does not apply.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
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
V2: Split SSC clock control for each CLKOUT, RXC, SYSCLK signal
V3: - Add RB from krzk
    - Update commit subject, use realtek,*-ssc-enable to be accurate
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index eafcc2f3e3d66..45033c31a2d51 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -50,6 +50,21 @@ properties:
     description:
       Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
+  realtek,clkout-ssc-enable:
+    type: boolean
+    description:
+      Enable CLKOUT SSC mode, CLKOUT SSC mode default is disabled after hardware reset.
+
+  realtek,rxc-ssc-enable:
+    type: boolean
+    description:
+      Enable RXC SSC mode, RXC SSC mode default is disabled after hardware reset.
+
+  realtek,sysclk-ssc-enable:
+    type: boolean
+    description:
+      Enable SYSCLK SSC mode, SYSCLK SSC mode default is disabled after hardware reset.
+
   wakeup-source:
     type: boolean
     description:
-- 
2.51.0


