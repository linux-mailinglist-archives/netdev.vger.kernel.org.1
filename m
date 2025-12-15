Return-Path: <netdev+bounces-244853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1497CBFF8B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 22:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9C9305F7CB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6C3321C6;
	Mon, 15 Dec 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8yAJZps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD73321A5;
	Mon, 15 Dec 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834045; cv=none; b=mweiQWNARTROJQfaqvHSa/QaOF9V4KSgI3LisWlmQCWNeAQSQOrnKapODAYtnamIwYVt11USQVE2FszC0x4MwTMdnj1fs7Nw86ZTDpkHy10lSAQhJz55FHdEbqo3gItT5YYV82EwKy9v7m0c5epLph3SYfmUQ5Qfn1lt4+FDV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834045; c=relaxed/simple;
	bh=IzqKoMi5RgZrH2DZaAzHWJ685mdEDrK+K9zMn3iogdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDhUaEf+yLt9dL374OLKUfP/oQAeLmCVimVe+N13Ie50PjpKFZ1RK5/ALluQHyuD/JyM/Q08LqUgdLFSMAKTpsiVXr4jxVix5lej63BpGNeFc68PVx3qQaA2vQszQ4Aka0xHcFNrnrlQu4vPMnteMs+jf77WFLNj5Mk+hRIgzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8yAJZps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D5DC4CEF5;
	Mon, 15 Dec 2025 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834045;
	bh=IzqKoMi5RgZrH2DZaAzHWJ685mdEDrK+K9zMn3iogdI=;
	h=From:To:Cc:Subject:Date:From;
	b=o8yAJZps4MWyd1uugAb70aN7FA53Edg/dgjRHkxz0Y1fxL7uGwqe9bD84vhRkC/Ey
	 oue47A+54Z1GGjQsWlQTK9sf7jSuvlYYmRW7GREhDWLAYAmLPGFtX3Bbhji5m18l29
	 p5vW0fz4DLxLcY/GnuA9gD9OpfFdokBo4X0mqrk3Gphl0r3eXHJMzNxx19Oln0GqFE
	 dJSuakbhcrEP17LLoUkTk8Add9D6dCFhRCwC7ushqp1FuvkyK6+lSY2mceN1tZSfPF
	 bHEoH4/Sgd+CCuhVQf8iqmF1ti/PjTc7TxISZV8Qvm6cyUuxzIQTDwMIwtpkNURR0q
	 VuH4BZE4YYvfg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: brcm,amac: Allow "dma-coherent" property
Date: Mon, 15 Dec 2025 15:27:08 -0600
Message-ID: <20251215212709.3320889-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom AMAC controller is DMA coherent on some platforms, so allow
the dma-coherent property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/brcm,amac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,amac.yaml b/Documentation/devicetree/bindings/net/brcm,amac.yaml
index 210fb29c4e7b..be1bf07985e4 100644
--- a/Documentation/devicetree/bindings/net/brcm,amac.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,amac.yaml
@@ -73,6 +73,8 @@ properties:
       - const: idm_base
       - const: nicpm_base
 
+  dma-coherent: true
+
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0


