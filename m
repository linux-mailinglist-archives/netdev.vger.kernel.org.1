Return-Path: <netdev+bounces-49725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DB7F33BA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E6B282F70
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E9D54F9F;
	Tue, 21 Nov 2023 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Ukx3ySE6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C4CB;
	Tue, 21 Nov 2023 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1700584228; x=1701189028; i=wahrenst@gmx.net;
	bh=S02d0LpoaxYbVXdkNYddTYpdeZjfrmY2E0FoJic6qbc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Ukx3ySE62hk+lkblYSRiHbPWiGZJCYu/T5X6Ydk4FM2MPCPdXejMVj5y2LHI4T1L
	 gdBaBR3VqSjBsqZhBSjDuuqIxtNMOFZWqll0gbSWewBqVRJJsJ0CWXZAYUG3OjD8Z
	 fPrp7IhWqpcLlEgVfvFZZJtsX+vVbsH2lSfbIrfjV1T1z6M9/VxvKtRQhlNg/jSpE
	 fZTKRlLd61ke9uojRpwFbsvKqPyYdrdLnJM6u65dnbHow1Db88H740KH5DPS4v+kM
	 oOZrS+9YKisAduIGPa/GWrmlZ9siFk064npDmnbnP2BqX5Zl74FVoBE4PsYkWrUld
	 luBb0cc5gs8JrVNH5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1quR2340Ii-00Sjav; Tue, 21
 Nov 2023 17:30:28 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/4 net] qca_spi: collection of major fixes
Date: Tue, 21 Nov 2023 17:30:00 +0100
Message-Id: <20231121163004.21232-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VNnea3i9p0ZZHidLTaFt5yhjJh/22PQZCf8ShbJNrQQjLKHx6Cl
 4HXaUDrUJnQSnhxxMU4ZbCJRW2XPczMPPdinOUukKUlR5luSWYUWX+tYt3jhZTPXT4EgeVw
 tSVt7NU8W7rjsBTrxCSQw8Ge9m+5rdHqG7WuuUhxuSjiHweB3hg5R8xI1S3X0BUdl1OTr0F
 ecbWuiL8zcb1fZmBa0NDQ==
UI-OutboundReport: notjunk:1;M01:P0:RVDoPulWi8Q=;hl3THpf2XvUDj8ESzV+8Ksu/u6C
 Iy4V75TmNss/sqZ7/q9aj5NgbjTyITnXntwJ6D28pEJhAXaVsqDPyMXcOYVC5Kr7jpJ/sa0cA
 2ZR6D/Da72T8IbTo3xYcIb+ACAYYkdxdDV6kLSpAqKy+OYVVSQKKi1AyjOOupm4yVHoNQIY5a
 OPZykMt2vKaGBBQmYywfFCK8xm8pSp2g7rSLkPYlwAuYyGQd6oMH5uf+7gg8mW2pFHAaliVWg
 xb22s1uFXSBkm9335iCt8Q1mMuHVYZzyI8FyLPgNQYbm55GjeoJve+U5/CdiZV91W7MepLmin
 ct57ZP9OYQ5EPDgxja6NXBkxatyNN5o8sfw7TvXYR/Wg2moT4pU6E6wH9fN1DnzfsO1YWHCre
 ZNLCDuw2VwzNsFtYVtZzD0nwRZhcJKmMiEEqsbKMsmub/RrwQaAnRCLw1iYxJVqwomdPXUhXL
 oB5Mf/JT4DhFsIUEhkIPqHLtUTJiIfw+N6r75Q+w/vv1ysHcAbzALkf5OCufJ23qcH/aLTRMb
 kG8ZiogHH8/SLJCOx4NFV8dAYkXb3tqWb7NicF7U+LK4sVJwdDfm0DmiGFuDOZY73GD6U3SZs
 pFBaPoTnaXxafHdX2ueRevXvknm80xUYPoIb6LtP5HW6cnvmGNkwXIkvAO9F1wpi6SuoGYS78
 FTwN01GNiBA7qovwBo9+hcPDfNX2HnLTWeQlJXgoH63pyWxEzIx4QxPQ/F5DNFxzFmMLzi4FT
 qsAWx5T7d/mhrdjloWjEWugxNl3AbrGkh0XmAx0eLb4WszBdcRaqZ4ie23Ct8GhTAfOEupOy+
 v9cRJD359mKyRPP62RGQ/NUwHodAJYto0UjCDzkr+K2uHHes4jedMlYlYN2XkHH76IMHW+5NX
 VL2acSmE+O5HFmOTurY/TWbw2t8cMgPtBxeIqkEvZkwY83puLlMpNaNzVF9NuVI54JW8XRXoW
 nMiHwg==

This series contains a collection of major fixes for the qca_spi driver,
which has been recently discovered.

Stefan Wahren (4):
  qca_spi: Fix SPI thread creation
  qca_spi: Fix SPI IRQ handling
  qca_spi: Fix ethtool -G iface tx behavior
  qca_spi: Fix reset behavior

 drivers/net/ethernet/qualcomm/qca_debug.c |  2 -
 drivers/net/ethernet/qualcomm/qca_spi.c   | 63 +++++++++++++++--------
 2 files changed, 41 insertions(+), 24 deletions(-)

=2D-
2.34.1


