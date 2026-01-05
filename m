Return-Path: <netdev+bounces-247155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12DCF5193
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C59CA300B010
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0C133F39C;
	Mon,  5 Jan 2026 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="GlrNtB6Q"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192533A9FB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635659; cv=none; b=RlntI8bxY1TrS9OVFRegtT71qrqYDqMU7YWd3mw6Q6yZM/YlYBuEJbsNnUW/Oi6KDQmFJgS0QmT3vvrMI6Zxj1IZyTLDIpPv2bu9oYe65JWSRmPU5zyKhY3NyYz9LnI5cwlo9WtxvI4vAagplbxvlW+4S/Xlx3c/OPAp62HhaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635659; c=relaxed/simple;
	bh=id0P+PlRLOCJXARQw+fVfjaF5tscQKCQjiVv5D/ZYJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urhL0KCKihsC4exQYE+ke69gbiuHC+nwprQmA5sY+zJtucqMygX0Fc8ULWJ69HnaChn/pofttl1laOgVGiEkao1rVvnWFHa0qEFiabVVox7I2J0G9dTWIv+iE/nOYQ8+knmt20msBrN0LxrUtpTjpglZoywlwlPmoxYeO+euiSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=GlrNtB6Q; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026010517541449ced631bd00020729
        for <netdev@vger.kernel.org>;
        Mon, 05 Jan 2026 18:54:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+VF9qf0lyx5JO6iRDcWE+HGKRWPB1+Q6ipi8K3G/DCc=;
 b=GlrNtB6QMDKgmshwJ+ARV1sTpJNk3940gWCoN2klrwq3sAFlTNtqsOEPmMCM1RtTcXlHQg
 GDQu6AUke4INrIRsnSKNwdjArqsZrPDxX+bbB0ISd1Ri3LueNn19C9DF9PlPETLuOY/MscSi
 ADnx8sNQvUnPKTyBxGaa1Ll27fxA0QjwJl5M0WJ+npzgUE6k83jL3nDSe+ZQM3hi/GAta5In
 DLoxFkdVfFz0BwY325LuwHMkvoy+vjIfUWc6GMZ6CXMe70qxuTGAzM6VXAY8lcOYYie8s4xF
 El4SqJudmcaRVpd1SisVMzDitLqAasmnx3ZFB8kWwTvMyKYHBVT1rWNA==;
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
Subject: [PATCH v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
Date: Mon,  5 Jan 2026 18:53:10 +0100
Message-ID: <20260105175320.2141753-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
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

Add new slew-rate uint32 property. This property is only applicable for
ports in R(G)MII mode and allows for slew rate reduction in comparison to
"normal" default configuration with the purpose to reduce radiated
emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
v2:
- unchanged

 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 205b683849a53..277b121b159d5 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -111,6 +111,13 @@ patternProperties:
             description:
               Configure the RMII reference clock to be a clock output
               rather than an input. Only applicable for RMII mode.
+          slew-rate:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1]
+            description: |
+              Configure R(G)MII TXD/TXC pads' slew rate:
+              0: "normal"
+              1: "slow"
           tx-internal-delay-ps:
             enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
             description:
-- 
2.52.0


