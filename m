Return-Path: <netdev+bounces-249278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F6D16791
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07613005E9A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C82E1EE7;
	Tue, 13 Jan 2026 03:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0F1D5CD9;
	Tue, 13 Jan 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274682; cv=none; b=G72BfsC/7M/pp6PRBQziIvzRrwwdwlRpz65f3G8eyQHuztoL6iGULrRnaFRpoe9ICv7oDlEPOWe+CwNl/9hl+gzaAGTfEA8iwaGLUCvraHHT38Tyj+/t5VhvfbzMVLk3G7EtqY6cokabE53IHz76iPRbrV+PzlhuUAbjcI9j1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274682; c=relaxed/simple;
	bh=XCi4Lr3j9ieeUWtn7Zo2RiHu2b7Si+qTebMbc+X0mgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQ1LGtMwaDWaMwY7/Vvgr75qbMLotOjCF2hqYHVPJCo+69UqU7VnFihgLL4FZaA38QE1jj1vGYA9h3Wj6kNNNG/Fb5F35an2lNPjlYfazQKJ/B/pxmiDHvQE220Jf8TDebWQmp/lnPAEOexWETCEHeWTEdQZzCjZT16FaOX5MSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfV1C-000000001LI-49cJ;
	Tue, 13 Jan 2026 03:24:31 +0000
Date: Tue, 13 Jan 2026 03:24:27 +0000
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
Subject: [PATCH net-next 0/3] net: dsa: lantiq: add support for Intel GSW150
Message-ID: <cover.1768273936.git.daniel@makrotopia.org>
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

Daniel Golle (3):
  dt-bindings: net: dsa: lantiq,gswip: add Intel GSW150
  net: dsa: lantiq: allow arbitrary MII registers
  net: dsa: mxl-gsw1xx: add support for Intel GSW150

 .../bindings/net/dsa/lantiq,gswip.yaml        |  2 +
 drivers/net/dsa/lantiq/lantiq_gswip.c         | 26 +++++-
 drivers/net/dsa/lantiq/lantiq_gswip.h         |  4 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  | 27 +-----
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 93 ++++++++++++++++---
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  2 +
 6 files changed, 114 insertions(+), 40 deletions(-)

-- 
2.52.0

