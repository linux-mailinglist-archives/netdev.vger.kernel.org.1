Return-Path: <netdev+bounces-218444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2AEB3C76C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FA01BA16B5
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC1C2472A2;
	Sat, 30 Aug 2025 02:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528547F4A;
	Sat, 30 Aug 2025 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521150; cv=none; b=b8h9BGBn/VhvnkcHjY5upsN7bSS+n3asd7635CbmrrOF35bxzQ71+/XKK1OHDA5bvxQew/cLdxv4FPDwIrZBFnD/9+JhxtNxSA/pcS951KlVvsX3u+PoJ+N0mbjXomiqlhgwcXaBADXotTGVBCU+6HhrajsP5N4yFu7kIKIniZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521150; c=relaxed/simple;
	bh=is9IEKpIaITjTCAHFls/RTPC03IfKxoVzptUDCFAHtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u2mwZuHH7/UJsrAgwJHCq+2VoMGwH9bdy4S486YAnK2znu3Nc/Qiw7m/fiUkN+GgwsQQJEGC+V8p4xJL4A2eaD9oS5bgfRo/6yeNsZGQYExAWBcCzUEWKiSzH56l1y6zH+pOSpdaYHHxrKJT434CbsMiSqp+Wva5XorRajuPYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usBNy-000000005ug-2ZYU;
	Sat, 30 Aug 2025 02:32:10 +0000
Date: Sat, 30 Aug 2025 03:32:06 +0100
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
Subject: [PATCH net-next v4 0/6] net: dsa: lantiq_gswip: prepare for
 supporting MaxLinear GSW1xx
Message-ID: <cover.1756520811.git.daniel@makrotopia.org>
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

v4: fix newly introduced syntax error in struct initializer
v3: explicitly initialize mii_port_reg_offset to 0
v2: move lantiq_gswip driver to its own folder

Daniel Golle (6):
  net: dsa: lantiq_gswip: move to dedicated folder
  net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
  net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()
  net: dsa: lantiq_gswip: support offset of MII registers
  net: dsa: lantiq_gswip: support standard MDIO node name
  net: dsa: lantiq_gswip: move MDIO bus registration to .setup()

 MAINTAINERS                                 |  3 +-
 drivers/net/dsa/Kconfig                     |  8 +--
 drivers/net/dsa/Makefile                    |  2 +-
 drivers/net/dsa/lantiq/Kconfig              |  7 +++
 drivers/net/dsa/lantiq/Makefile             |  1 +
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.c | 54 ++++++++++++++++-----
 drivers/net/dsa/{ => lantiq}/lantiq_gswip.h |  4 ++
 drivers/net/dsa/{ => lantiq}/lantiq_pce.h   |  0
 8 files changed, 57 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq/Kconfig
 create mode 100644 drivers/net/dsa/lantiq/Makefile
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (98%)
 rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.h (98%)
 rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (100%)

-- 
2.51.0

