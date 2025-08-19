Return-Path: <netdev+bounces-214818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62FDB2B624
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CF3621D2E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF931F4190;
	Tue, 19 Aug 2025 01:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF835213E85;
	Tue, 19 Aug 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567092; cv=none; b=HV/2eI6URgg1Hs+rXakgRSCv+/3XP5e2LnK6OLJN40CQK4gEVrBQKaDkaiyt81vOmpmVtLgfWovnZzZ91UN9wCk8tRD9F34z+okaFF/ITNQeiO+dDIXOuO3fOjlUFj4iGYC/AXF1HmY1QtGB8nIzQtd8kEkpn3tWgEFNwzjdoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567092; c=relaxed/simple;
	bh=o4vVBnukfyQdKysS36WwAXAvcOj28+WEuxmSX8j7w98=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OPyrJN86f9NX5embMZOuBqia+sthsgYXD3GbbEP6UBAC5bpi1jm1CiS+S4u7rm6TLwrH0zdh0papTJSyU7Z2qHb25ZNeX9DoZoK2kQwzfaZw3ZjLeevLTRi4emfdTNz91vS6927w9z0YwgljvAsFzaGAL6W7AcIMKX7qf5Z7tgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoBC5-0000000007q-0UUV;
	Tue, 19 Aug 2025 01:31:21 +0000
Date: Tue, 19 Aug 2025 02:31:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 0/8] net: dsa: lantiq_gswip: prepare for
 supporting new features
Message-ID: <cover.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for supporting the newer standalone MaxLinear GSW1xx switch
family by refactoring the existing lantiq_gswip driver.
This is the first of a total of 3 series and doesn't yet introduce
any functional changes, but rather just makes the driver more
flexible, so new hardware and features can be supported in future.

This series has been preceded by an RFC series which covers everything
needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
had suggested to start with the 8 patches now submitted as they prepare
but don't yet introduce any functional changes.

Everything has been compile and runtime tested on AVM Fritz!Box 7490
(GSWIP version 2.1, VR9 v1.2)

Link: https://lore.kernel.org/netdev/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/

Daniel Golle (8):
  net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
  net: dsa: lantiq_gswip: prepare for more CPU port options
  net: dsa: lantiq_gswip: move definitions to header
  net: dsa: lantiq_gswip: introduce bitmaps for port types
  net: dsa: lantiq_gswip: load model-specific microcode
  net: dsa: lantiq_gswip: make DSA tag protocol model-specific
  net: dsa: lantiq_gswip: store switch API version in priv
  net: dsa: lantiq_gswip: add support for SWAPI version 2.3

 drivers/net/dsa/lantiq_gswip.c | 404 ++++++++-------------------------
 drivers/net/dsa/lantiq_gswip.h | 268 ++++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h   |   9 +-
 3 files changed, 363 insertions(+), 318 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq_gswip.h

-- 
2.50.1

