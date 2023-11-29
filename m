Return-Path: <netdev+bounces-52070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C02C7FD345
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9241282F37
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E418E1D;
	Wed, 29 Nov 2023 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JtnLqLey"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B106B5;
	Wed, 29 Nov 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1701251578; x=1701856378; i=wahrenst@gmx.net;
	bh=SNH6xHQWrsdVQ+VdgPcOUcLoGDMghtrBq+lLBnwzxno=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=JtnLqLey3Y1QUJj36oEx2Fbtx/X+L8xM9gR99mXtkTRYe50rLcOmKYYHtoZMeBeF
	 /3OOA/sriD/+miFU7IAjv56l4rVVmchB4FIrmQnuTHBM7DLJGLGlNn2Cala6htFDd
	 UsemVG7pq9ugDV8hnBD1D8eLuPIHyIMsmivO/iSlZIW0XO2NWLgzsSJC6Zz6VsRn4
	 LqpIVuWOsYNq3O7EkFptPoqXcEpHVys9ftjQNrZXmk2z5WWTAt5ZR8jZqbcBXyB0A
	 dyc762VHtU7ejcK0oCiLmXXq1NnuspoDxc/fpYztCscy8L0kmPWipq2tS16f1feQG
	 9x8o4yb+14ISl5nmkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1r0saH1QWB-00BvA1; Wed, 29
 Nov 2023 10:52:58 +0100
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
Subject: [PATCH V2 0/3] qca_spi: collection of major fixes
Date: Wed, 29 Nov 2023 10:52:38 +0100
Message-Id: <20231129095241.31302-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/0ezHVdpzgHEk3B+U7fLc9/ksehu50e9rREgkJDGyq8eXmZze7q
 ez3NioMUcEwd0HXspVyn37F9C5Sq/xZHf1t7Jrc7K/DrbTfqYqBYBfKdwh8W+TyWWyaB1jh
 hZFoTpxqzuiuzh/zhR+s5iudJ2HIomzvpGiDRIyw+RgkI7cbeK04w/rYVYh1Kd/rit37V0P
 hYzslzRK7nfTZMiGHYFRA==
UI-OutboundReport: notjunk:1;M01:P0:YOZIfcCJ440=;s5H+E5PGRbxGBfB9RYdE1gDs984
 dp2bRAFQzjUpzXVwzxjukyHP1+uq8BRHk99uYV4JBxipxU4fR8Pm4J7Tbv+EWZhopFbbdKo01
 NDk4AB//7aeAGK6owTrkg8AZUYTFQwgBGR9I7c9eyhheyw7NYwOfLYMMZin6fPweEpEy0x48H
 rKK8A0s3JIhpmcCU5CaD/MtvzoB8DSlBDxVrONhW7IUXojpBehVxyXVdkE20pPdkDsCbBUZl3
 pxYkFmkSGc7cg/rWBPxDDhB3RFh66kLSl5gwKz+ISdV8Y2YTNHi5SPxHG2qd1+L1Odi//U0uq
 RBkvOlq4C+CpdeC56Xw31rsGAaGMwhXfAIHZRx07A1wZILW4/u8fft8RvrgLsJyfaW55qvjWh
 QRhILuFjmwY1o8ORGSPgThObz8jKWuXqktVbTQdMIVCjysUwLLgUVcQxfBDxZo6veWnSFsedM
 SsMWdVOnlpd6vMX89ch7zqReg9+ksNFtmK52iWbz9+UDP8ynXIiRRA/ENHcwS2h4JRvwJXU7i
 ldWRZsJUS838C4aIprJ7ikNugUxRoHuemex84dBudC1TM1HOz5YQU8QuWCY0HsZOXBpUILw4w
 JGorK1M5xOZcIyRFuiwrWJyEdeSFtbxa1ThIf/FliBL7MHc42Tnskx8WE05lzNZczPoQkeagi
 T2CIxziPY7vEql9lUBgX8gqENKmaW26QUS01TRCegr6oAX+aIfbILSIiPX85pyBMRYL+/uyPl
 nTyLTjXZFZ4Wz48LPPBg/Vy6htEnJvhFfXdDSYgEG2STrX6hw/a5ZPL1ME13pBVJF4PX/yM5S
 IuVcxaw/+nWMo+w+Lpm+ZIiTxLX5J9ouTCP9EYHv027XcRMkC8xlpR93QzSLF8BEBVCIPOIaB
 lEEJr7jP+pZJX+8zHaA+EzOWFIUmMXd7mE7wXlmbFWad9/G2nHf/UbV0NDp9DkVRBsbIydi7R
 JgTUmg==

This series contains a collection of major fixes for the qca_spi driver,
which has been recently discovered.

Changes in V2:
- Address the crashes caused by TX ring changes in a single patch
  instead of two separate ones ( resource allocation rework will
  be send in a separate series ). As suggested by Paolo the kthread
  is parked during ring parameter changes instead changing the device
  state
- As suggested by Paolo keep the ethtool get_ringparam behavior
  and just fix set_ringparam
- improve commit message in patch #2

Stefan Wahren (3):
  qca_debug: Prevent crash on TX ring changes
  qca_debug: Fix ethtool -G iface tx behavior
  qca_spi: Fix reset behavior

 drivers/net/ethernet/qualcomm/qca_debug.c | 25 +++++++++++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.c   | 15 ++++++++++++--
 drivers/net/ethernet/qualcomm/qca_spi.h   |  2 ++
 3 files changed, 32 insertions(+), 10 deletions(-)

=2D-
2.34.1


