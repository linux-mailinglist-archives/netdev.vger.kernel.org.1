Return-Path: <netdev+bounces-217080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41B4B3752C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B931B683FE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3E26A0C5;
	Tue, 26 Aug 2025 23:05:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B92F548C;
	Tue, 26 Aug 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249530; cv=none; b=LbNosShot2kIhsaKx/Nr0jRdCTL/Cgs1Uza/+btm9nVIF+f8THubt/HD8lgB/H0tBEVlm9Gh7CDPGJDXnjmwnSH88Gv2rTyzFH8MmGytlAeeTT5OcOU2fRscw7W15KmDoBWfiYPBX341QqIEci/C42ScnLt8TCzltGoSzJHvT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249530; c=relaxed/simple;
	bh=IHJkd22G57+IJb+h1jiPe7v3H6YGX/QkK3NxgEespt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uaf+1kJ66zAnQdGoLVvX1OGxD/P9t5wp0ScU4PAk6KQvpk1Xa6MpvcMldUOg3jHl3qyHpv0csynXFred8zUtdky3hyU9rc1DZxHZhpDeuFBPbuk/qErF+LWFoB3zEZWgNjOgBzNuMvPWdHjkoey70IwwbeIeSfhNjjDTWVEm3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ur2j8-000000001sD-1qrG;
	Tue, 26 Aug 2025 23:05:18 +0000
Date: Wed, 27 Aug 2025 00:05:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
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
Subject: [PATCH net-next v2 0/6] net: dsa: lantiq_gswip: prepare for
 supporting MaxLinear GSW1xx
Message-ID: <cover.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Continue to prepare for supporting the newer standalone MaxLinear GSW1xx
switch family by extending the existing lantiq_gswip driver to allow it
to support MII interfaces and MDIO bus of the GSW1xx.

This series has been preceded by an RFC series which covers everything
needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
had suggested to split it into a couple of smaller series and start
with the changes which don't yet make actual functional changes or
support new features.

Everything has been compile and runtime tested on AVM Fritz!Box 7490
(GSWIP version 2.1, VR9 v1.2)

Link: https://lore.kernel.org/netdev/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/

v2: move lantiq_gswip driver to its own folder

Daniel Golle (6):
  net: dsa: lantiq_gswip: move to dedicated folder
  net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
  net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()
  net: dsa: lantiq_gswip: support offset of MII registers
  net: dsa: lantiq_gswip: support standard MDIO node name
  net: dsa: lantiq_gswip: move MDIO bus registration to .setup()

 MAINTAINERS                                 |  3 +-
 drivers/net/dsa/Kconfig                     |  8 +---
 drivers/net/dsa/Makefile                    |  2 +-
 drivers/net/dsa/lantiq/Kconfig              |  7 +++
 drivers/net/dsa/lantiq/Makefile             |  1 +
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.c | 52 ++++++++++++++++-----
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.h |  4 ++
 drivers/net/dsa/{ => lantiq}/lantiq_pce.h   |  0
 8 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq/Kconfig
 create mode 100644 drivers/net/dsa/lantiq/Makefile
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (98%)
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.h (98%)
 rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (100%)

-- 
2.51.0

