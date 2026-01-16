Return-Path: <netdev+bounces-250357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F622D295DF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D45FA300A501
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E117BA6;
	Fri, 16 Jan 2026 00:07:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7712AEF5;
	Fri, 16 Jan 2026 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522023; cv=none; b=lbCJw7oc1FC6OepSUBI+Y9H+pGzk6uxENCe+MQwLMRO2ixajW8LkdLUdoMalrSFpwtRGeZzN/tRQZhbd86uzS59Wa6Z7IfhzhMoacvpu6o0cVc9E8fJkuKFZR+V3VraW0rM2FmGDugLuhYBQP9LplVGHIilDhetMkiXTVTYp7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522023; c=relaxed/simple;
	bh=ZWG9lOM2O3p9oipJ7/sTnYvspCAzyjnu3Rc+qj0Q0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ktOgJMjYxoIKVlXftBIJZIGDlxWffK9Ru1hjkU0jFQZBqqqRJ8zZ/OMQWessoPY61yrB3ZmxYMaGXrJqlvAfQ8KCO6eUqQcqt76XoxWo6iBDcOTEsshyKfw/SAamUN2wxniT3ulVsntx/XYPWgUkg3RT4iUtU6omriMva2C3GTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgXMZ-000000007Xs-49Fb;
	Fri, 16 Jan 2026 00:06:52 +0000
Date: Fri, 16 Jan 2026 00:06:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v3 0/6] net: dsa: lantiq: add support for Intel
 GSW150
Message-ID: <cover.1768519376.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The Intel GSW150 Ethernet Switch (aka. Lantiq PEB7084) is the predecessor of
MaxLinear's GSW1xx series of switches. It shares most features, but has a
slightly different port layout and different MII interfaces.
Adding support for this switch to the mxl-gsw1xx driver is quite trivial.
---
Changes since v2:
 * enclose the gswip_hw_info initializers in compiler diag exception
   to prevent triggering -Woverride-init

Changes since initial submission:
 * add patch fixing node naming convention for dt-bindings
 * introduce GSWIP_MAX_PORTS macro
 * don't assert SGMII PCS reset in case chip doesn't have SGMII
 * use case ranges in phylink_get_caps


Daniel Golle (6):
  dt-bindings: net: dsa: lantiq,gswip: use correct node name
  dt-bindings: net: dsa: lantiq,gswip: add Intel GSW150
  net: dsa: lantiq: allow arbitrary MII registers
  net: dsa: lantiq: clean up phylink_get_caps switch statement
  net: dsa: mxl-gsw1xx: only setup SerDes PCS if it exists
  net: dsa: mxl-gsw1xx: add support for Intel GSW150

 .../bindings/net/dsa/lantiq,gswip.yaml        |   6 +-
 drivers/net/dsa/lantiq/lantiq_gswip.c         |  49 ++++--
 drivers/net/dsa/lantiq/lantiq_gswip.h         |   6 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  27 +---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 146 ++++++++++++++----
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |   2 +
 6 files changed, 163 insertions(+), 73 deletions(-)

-- 
2.52.0

