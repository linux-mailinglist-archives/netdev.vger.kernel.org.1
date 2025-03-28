Return-Path: <netdev+bounces-178107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D50F6A74B9C
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4F41B646AF
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C802206BC;
	Fri, 28 Mar 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="D2iBLSLy"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1117D355;
	Fri, 28 Mar 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168979; cv=none; b=u8Azbn3coV6nkcBqWYqXTYqY/ECsULil+OWJ6B+BxVI4GjN5WbcurqEvTdAhpWuBBN0WlmV/lmBWKWiRAqeLswe1C8e6Xw0X9DTzdXxLbmoptlAzDkij0qXneCjMS97ts6SUoCCOPLD1tCpUuwdThbBacwZJ3KkFAEHCN1gNdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168979; c=relaxed/simple;
	bh=+YstgiJxFBWDDqoeztamX7ppMuXME6uI5KsoevKc+I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPJ5JAiEBVnuBASf5vf3b/f0RkDginB67tEfadQaAKzfTijoE6zHjtpHWy8Pe+1uKtjWSWbKa8RfIstxb6CNfBxOsHaU1bM3cX3JoLBbuxZntLWpG45iwEALQwWthTP3+5cFHJYmIuYhuveeDSjFPSIUtDEqn62gtfrijhiG2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=D2iBLSLy; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2C38101DC311;
	Fri, 28 Mar 2025 14:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743168974; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1CHUT7A8svC7k0JjC+awC5nlDgALOXd9WqES3LP0q38=;
	b=D2iBLSLyr2iCrhoabMd1l+A1wK3dUONF0pLxs2Dpurcz7pjmk8nDlspiyUHTNAKPAGujzp
	Qb1QORs08SkYrTjilzbD6KjepIGVZp2AFoBmEiIICtvFe8+FRFjM3MF/vwaUWtqL2wEwxN
	I7hoCY5vUAuMMbt1vwtNkmnmf8THnMzF6JA0Y8RVgqpfX9GENDnuQzo6sShRLXlZ1VjJek
	1COBmjobWILmJbJXHIaQ0rwTQ4BPc4GIV2z2hoB7/JPR7xwOJqWmFOmJjPBWk3upV8e6Sb
	hj/ILcN9+8JN0rGuIIMLaM+hoAc8i57gPh6mFzIRhLXCRk/pOFQm0S+jkZ+CLA==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/4] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
Date: Fri, 28 Mar 2025 14:35:42 +0100
Message-Id: <20250328133544.4149716-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250328133544.4149716-1-lukma@denx.de>
References: <20250328133544.4149716-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current range of 'reg' property is too small to allow full control
of the L2 switch on imx287.

As this IP block also uses ENET-MAC blocks for its operation, the address
range for it must be included as well.

Moreover, some SoC common properties (like compatible, clocks, interrupts
numbers) have been moved to this node.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- adding extra properties (like compatible, clocks, interupts)
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index bbea8b77386f..4117a5003b36 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -1321,8 +1321,12 @@ mac1: ethernet@800f4000 {
 			status = "disabled";
 		};
 
-		eth_switch: switch@800f8000 {
-			reg = <0x800f8000 0x8000>;
+		eth_switch: switch@800f0000 {
+			compatible = "nxp,imx287-mtip-switch";
+			reg = <0x800f0000 0x20000>;
+			interrupts = <100>, <101>, <102>;
+			clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+			clock-names = "ipg", "ahb", "enet_out", "ptp";
 			status = "disabled";
 		};
 	};
-- 
2.39.5


