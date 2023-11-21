Return-Path: <netdev+bounces-49726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776F7F33BC
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70AD283056
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8F56762;
	Tue, 21 Nov 2023 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="l3e+XLIt"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE15191;
	Tue, 21 Nov 2023 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1700584229; x=1701189029; i=wahrenst@gmx.net;
	bh=6XwkQvqwtcVy28fKXdFyyWyhmGSZ18nQMs5LnwizKy4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=l3e+XLItZJ0ct7Amnq0EGnKj4t+muboZX8GnWlUPolo6RRnjAeN2hi9bl6VHuAqg
	 x7jm6cSZz3gAnH2uMypbh1P+uh5/RhXvQHWJH4O7lXALWhQpMIqpZHnvtfy7mb3SC
	 STjSvYDvSAf1oFI5EniP/LbTyIWtgptCL9ouE8PUq9vEP6VP3yB3RQZWcEIJ1CwHr
	 zIgTlt2tCbhUjAaRfGg7JFuj2+D+nWLKcgVae4MHYIOq/o6kcHdC++oD8imhV+TRm
	 eojjvaY6ucxXhUcTfRiZb9ufGGxdrTT8j4IUMTEjagZYLk5bUnqGoR2AKWGaOW4/s
	 +5vvQN4pr13bYB9pRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1qmQIA0CGx-00Kir0; Tue, 21
 Nov 2023 17:30:29 +0100
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
Subject: [PATCH 3/4 net] qca_spi: Fix ethtool -G iface tx behavior
Date: Tue, 21 Nov 2023 17:30:03 +0100
Message-Id: <20231121163004.21232-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121163004.21232-1-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WKlRcSkBLRRiKS9ZuJyqRBCwJ2sZ/WAUwE0tXUKbMppH1MFeGgN
 N4B0/OfKV+wEG1ZVx+x3qhALHSFoCBSgCC1tEYtD4Y0c12YJLJdvxI778yxRZlXdhj3y211
 3Bzmk7FSTiiCUvayP1y5sM7hZ4ujbe9Whlib+ybnHJ/Xm7g7pAVYXMPxlN5edLfvacTSfS0
 YHWuJyxJR0cMAw6rEeBMg==
UI-OutboundReport: notjunk:1;M01:P0:bJMrRyWKH2I=;PrQAAqPOW3nRV6QkuaX8q6PbZV7
 sPGSMIlxPcK2aSE7IEYBP+P+7vcAcZVIu9pJPC2fN7vxRvFNO4/Q6wluw7yosMhurtVWXhxeH
 BnAL+GDbAmr2Ww9RvoATZhq7CafcnOYFdFB2JbwfE8tAlbkZFsLJulumwJL6yWV19PZI65qrO
 YVeIyZv2h4EYI21UhnihDhUb4voPl0p4bp51joYnCqznvuVRsUUYR0NwV4oUfo2b9/XW8+TNJ
 IPQL3ZW8l2/ZTVFjgN00DyBDxFcdcxz3bB77mqNdY7ScKlynb2vpuR8OZSX1ly0KwKjGpP82r
 ZSLORRughHyI1PurXEWfiS+eQM7HLkEShw9CVnBq1WLXOLBqWCiuyW4X0sDLw4dRWjoLLE8Yn
 d/NUYQUGZzDNhLWrZSNobeKwZ35CpH8tiJ7IWPEHNrZtXfB6WSadI5/mIEHZy06b36nSLddXs
 Z9wqudgBg8lBGVklkBDxR9rr1x3nVk/MPN17o1HJZotviIxBiz8tUhCXcyqnXvgR2QJDBbpe1
 3wo7H1BFEVK92cFe/Uh2rNPmcVkB7phWQGP2nRltJwkLuKJxhBRCplfvbR/HdcdLwQ0scuJDw
 v1XRe8vYjJqEHGozxudQjQ3V7ep1v5xqpFRsbzUnr7fLbiP8dglq1+V90AWSLstrFkZ1qWfZh
 bTY1P4eyN+gz2RRyKuMBE2RqRMSfvR/F55ohKLewPHRAqzlA8djzYtA50Zz1/XIwd6PCPKGDD
 PUZiKTQFjp81/NEGFIaqVjQw5tAoRbGT+iaaqbyEeuoFnOwdu1M6hXGgDV7JSxC+ilDlzj5iB
 wSuTUa++WguAB6iLPL/6eaT+W8Tgy6xJEu0eKNlN3SKcb04UjYpIihT5bJi8L2YtjY6ApvSj8
 1TCKSt+DgCCGCZ6MELJjhDOjHVBqInQYyP7bWnSVTi+toZD36RUlrIj0DJJ2w5PYZUhipuncV
 bdcx/A==

After calling ethtool -g it was not possible to adjust the TX ring size
again. The reason for this is that the readonly setting rx_pending get
initialized and after that the range check in qcaspi_set_ringparam()
fails regardless of the provided parameter. Since there is no adjustable
RX ring at all, drop it from qcaspi_get_ringparam().

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 6f2fa2a42770..613eb688cba2 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -252,9 +252,7 @@ qcaspi_get_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

-	ring->rx_max_pending =3D 4;
 	ring->tx_max_pending =3D TX_RING_MAX_LEN;
-	ring->rx_pending =3D 4;
 	ring->tx_pending =3D qca->txr.count;
 }

=2D-
2.34.1


