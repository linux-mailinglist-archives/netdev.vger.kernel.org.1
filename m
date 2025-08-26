Return-Path: <netdev+bounces-216723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7CB35007
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 472C14E3777
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184C136E37;
	Tue, 26 Aug 2025 00:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB01E480;
	Tue, 26 Aug 2025 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167143; cv=none; b=kJXC4spLFrlL2COvkTXUfwrFegcruaVtmJDc/tRedj9+IUStUxvq8GHB3kFH7QdSi6v30cB6ve6PfdO20/nbeLt151OqyB52osmNXtGiGgCQ3TRR0lhJoZVkVYT94PtJWC5T0IZGe9158I7hTvNdtsbMjJSDfVSzwC2MmGKQbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167143; c=relaxed/simple;
	bh=Pv6q1KzMShRhCU4DX7d28/60wW9q12ne1Vz4QXG+un0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S7MHDhl59oZ3bQjHbv7yeZ2tAVJfOx/vHBjFsihs3Kr2WzuQ1dfRVSET/P5xU3cGKWlMhOfnNCXK3Z+WhVdXv5/qW6nRkfIrWGxkTvDSDF1v72ogyH3ZCn2X9jwa44fret0EDjhplarAF66T6+PgOyiGZDF2iL7XoeztOCeCiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhI9-000000005jB-1Oak;
	Tue, 26 Aug 2025 00:12:01 +0000
Date: Tue, 26 Aug 2025 01:11:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next 0/6] net: dsa: lantiq_gswip: prepare for supporting
 MaxLinear GSW1xx
Message-ID: <cover.1756163848.git.daniel@makrotopia.org>
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


Daniel Golle (6):
  MAINTAINERS: lantiq_gswip: broaden file pattern
  net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
  net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()
  net: dsa: lantiq_gswip: support offset of MII registers
  net: dsa: lantiq_gswip: support standard MDIO node name
  net: dsa: lantiq_gswip: move MDIO bus registration to .setup()

 MAINTAINERS                    |  2 +-
 drivers/net/dsa/lantiq_gswip.c | 54 ++++++++++++++++++++++++++--------
 drivers/net/dsa/lantiq_gswip.h |  4 +++
 3 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.50.1

