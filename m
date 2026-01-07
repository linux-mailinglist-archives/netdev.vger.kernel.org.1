Return-Path: <netdev+bounces-247643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB14CFCB5B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3626430550FA
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC42F60A7;
	Wed,  7 Jan 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="AGBV2z37"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2D2F4A14
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776480; cv=none; b=K9KPCQOdXZyN/GARzhrG0quxqbWAMSLAmv3ganvqzhpd/ZZFofq6DTDze0HubVR2oHXdPmuvEs6extz5PWrTG9Jikjc1oG3XN6NdBkIvJ+WBn6HibeccbAvbMMaQlrl0cMSugWtcX2RxtX5qUdwkC1urG+QOvGDykmqSeeHrKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776480; c=relaxed/simple;
	bh=h6ApTiTwg8L2Zs+CiXLe7baU1ubSbYWGTo+W6va/b2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ka5g91TAaGohlktoWrY32eSkTdzXGyv4zgAQaBQ8VrtjFe+lODPx7xMmCoETDGPSAC0FjuISE0PfWNGaCf1652VxFR9c0zL3r0Xn6wq0lvlPmyCnc16AGn50c70lmZDfFpQuARW+I0aNdxug8HOnxAd9wtfBBDxlFnorPO2nfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=AGBV2z37; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202601070900212fa5d14699000207c9
        for <netdev@vger.kernel.org>;
        Wed, 07 Jan 2026 10:01:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YsJcn0UDZbMXRVIrX9SQ3/eX+cIo25sjoGMxd4LNHzM=;
 b=AGBV2z37dDzOpdAzk4G2E1vSXTT/OhKbMnEm3UWJnSsEIU15zVFOZ3AhyBL7C5WAMwWt6l
 hAZ/WO4ORbNXOVxRH6iQhMw27ls7q0Chovg4S6Sq5oMYTKF2ufNJjgrxjafp5N8QcFlaDxY9
 Y4qExsBLv2bTPOjFBBmkhZjWE4FruOXPgH3febX30gQ5wfqwww9L8gMzRDk6O5647vs7h2xw
 HiG7uR2p2ifeahQYt+kh8pFGjVURbDTBJMOpCC0DEQAy6yTcuqZSnyh48FjyApP6KHfmT9FS
 3uIiW/j+fI4kjVy3uuL9KOb51yCajnadk93h3NKfGVfMXG5PuE3iXRAg==;
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
Subject: [PATCH net-next v4 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Wed,  7 Jan 2026 10:00:15 +0100
Message-ID: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
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

Maxlinear GSW1xx switches offer slew rate configuration bits for R(G)MII
interface. The default state of the configuration bits is "normal", while
"slow" can be used to reduce the radiated emissions. Add the support for
the latter option into the driver as well as the new DT bindings.

Changelog:
v4:
- separate properties for TXD and TXC pads
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
- better sorted struct gswip_hw_info initialisers as suggested by Daniel
- https://lore.kernel.org/all/20260105175320.2141753-1-alexander.sverdlin@siemens.com/
v2:
- do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
  introduce struct gswip_hw_info::port_setup callback
- actively configure "normal" slew rate (if the new DT property is missing)
- properly use regmap_set_bits() (v1 had reg and value mixed up)
- https://lore.kernel.org/all/20251216121705.65156-1-alexander.sverdlin@siemens.com/
v1:
- https://lore.kernel.org/all/20251212204557.2082890-1-alexander.sverdlin@siemens.com/

Alexander Sverdlin (2):
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
  net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration

 .../bindings/net/dsa/lantiq,gswip.yaml        | 14 +++++++
 drivers/net/dsa/lantiq/lantiq_gswip.h         |  1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  6 +++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 40 +++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  2 +
 5 files changed, 63 insertions(+)

-- 
2.52.0


