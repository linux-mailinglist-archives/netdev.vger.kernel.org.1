Return-Path: <netdev+bounces-244562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E9CB9D53
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C93B3092428
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51EE3126B8;
	Fri, 12 Dec 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="IDU/Q0E9"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6092DC790
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572978; cv=none; b=kcRQgg4QgbzETp6Xjr7Nu3crXSkgX4hLANvpq7LGx5rJtA5gS4FzVuBW11SwVriOLz2/3vrYDgFtSY/2tQ5fu1YFxVcwibsmCfCmIOo19xpeKLTChnjyA01uM0uiQFFOwzDDOA1pqboKjp5GOt6wnKM0ZED6+CcxjMiVdiPsn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572978; c=relaxed/simple;
	bh=H8K26/3M9ZOwVkvbX01usgyg8WoOPuofe3ffL6kkLUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9xqgiuW8riQzqU9fj+2eUfWYwOjgksXVmTg9WgyOd+k9EQe3tUOhz1hZ3n5gVMiUG7uA3R30Sd3L9kMqIkgLjPubArM60EdMRBWC72h4vYeM3ObA4GcnofayTgiNPPtvNhMGUvt6TpUswWUbmYkyLBBiKQcUMIcEL6Qt6+N7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=IDU/Q0E9; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025121220460432281b1b420002077e
        for <netdev@vger.kernel.org>;
        Fri, 12 Dec 2025 21:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=V8z4AU6BTthS2cu8yRS3g3bsCaBUt556bM/8/FA+Esc=;
 b=IDU/Q0E9bRSOFsVWbJcjeo5OmFcEklwQTGuuWapCCBJsycjOw+t9R5SVSLPhiS9+xi3h46
 tFqX64bOg+DerKDtzaaznh6Flpi7z8ZRrtLE7cBYGDFXdDXXEiHVu0hIcyXJEfWNdNNLM166
 BPNqZmgjeDlBgUMX62LaD2iPX9sUI/ODxh+yOLcSHZdNWk7QxNunkgNTh+wlc1pxM71R6e/A
 GaWtnVnMfJagh9iEgCtQMCdVWjGJNUGj4Uo4NEsV9cpZdH8MD481tWBa8EIQ6alJtEy4KPtp
 ODZ1Mg1vCZTGawfPfUveuedRGZMWQ+bdkiaH2NN0EOGI6y6imPMtJYKQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
Date: Fri, 12 Dec 2025 21:45:52 +0100
Message-ID: <20251212204557.2082890-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20251212204557.2082890-1-alexander.sverdlin@siemens.com>
References: <20251212204557.2082890-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Add new maxlinear,mii-slew-rate-slow boolean property. This property is
only applicable for ports in R(G)MII mode and allows for slew rate
reduction in comparison to "normal" default configuration with the purpose
to reduce radiated emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..6cd5c6152c9e9 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -106,6 +106,11 @@ patternProperties:
         unevaluatedProperties: false
 
         properties:
+          maxlinear,mii-slew-rate-slow:
+            type: boolean
+            description:
+              Configure R(G)MII TXD/TXC pads' slew rate to "slow" instead
+              of "normal" to reduce radiated emissions.
           maxlinear,rmii-refclk-out:
             type: boolean
             description:
-- 
2.52.0


