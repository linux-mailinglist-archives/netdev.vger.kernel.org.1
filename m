Return-Path: <netdev+bounces-249981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE28D21E9B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B9D3008EA7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BDB1F4CBC;
	Thu, 15 Jan 2026 00:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415C1E5207;
	Thu, 15 Jan 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438609; cv=none; b=Cuzn37CXCXPFIEb70ZJmXAQZgf62B8BqV/XixENQqKsInFjE8zHN8GlKSK0OHD6ZKb5fnkurPJA7mnywPOGtXcBrSndujb8CW2Lry0H4hyF0wAWn7I+Fl6AVkbTSCCcAx/Wl4TZBBFcaN8FEBMLNzanTIEhQLjPrZuK3CdD+534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438609; c=relaxed/simple;
	bh=5/RmNfmYplLaqjdwe4eiX2/iXR279LEDAiakQptqqbg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oL+v/xF+jhguG9RFg/NSWKzUBMTyaFrfBHsASKrWUMAbnr8VsuVS0/mlPADIkvpcNi3Jm8R6n635cXPsq08IiY0JsM4xMie3nJ0Uyxy/yuTL2KcRmOAlGZIE7JCKto3VHTuGDgY25XIiBaujg0sUbQ6J5J4MfxAsy1qxtFeH6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgBf7-0000000021n-17gc;
	Thu, 15 Jan 2026 00:56:33 +0000
Date: Thu, 15 Jan 2026 00:56:29 +0000
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
Subject: [PATCH net-next v2 0/6] net: dsa: lantiq: add support for Intel
 GSW150
Message-ID: <cover.1768438019.git.daniel@makrotopia.org>
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
 drivers/net/dsa/lantiq/lantiq_gswip.c         |  42 ++++--
 drivers/net/dsa/lantiq/lantiq_gswip.h         |   6 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  27 +---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 139 ++++++++++++++----
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |   2 +
 6 files changed, 149 insertions(+), 73 deletions(-)

-- 
2.52.0

