Return-Path: <netdev+bounces-54456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2828071EE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073AF2811EC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000933DB9A;
	Wed,  6 Dec 2023 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ueUtZbRT"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F3D5E;
	Wed,  6 Dec 2023 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1701871976; x=1702476776; i=wahrenst@gmx.net;
	bh=Sv4pS1rNOX5ZBKBZZYkcyVrATcEHgLY8W6Mp4iHYDog=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=ueUtZbRT1JzGt5iQHDXEM/Rcyj9CHnCfm/vMjOW7mYCERJddKiNkJSZfrwr1VIDz
	 rzSiN4wfbpUXRCWqBz0b3cgGAXbn9QoxSIcdZGN5VV8gVPQYQEWm12mjIkRi8GUqQ
	 GEMmQyZidnxKYz1vb8OsJMyEG2qYiDhKuUeJny0Dlgf9w320cAmgr93Z3hwHb0SBb
	 IEEHS1Ofzb8TQXS9xoGXfrYGIbADUbREDzFXFFoXYtsVlT4Wimc6O6ib5aDOfGLJU
	 +78nDvs/QTy1XgRG5u+nX+Ulx4HYL44FSg1vqt5xfVHXyjETzjhnMkrIkMrElc1M8
	 E/TJaE+K2leksiRcng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1qspfC199K-00PuoZ; Wed, 06
 Dec 2023 15:12:56 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 0/3] qca_spi: collection of major fixes
Date: Wed,  6 Dec 2023 15:12:19 +0100
Message-Id: <20231206141222.52029-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lOxH9FnuHKmvu0ntSKxlTb7ePlsSkKbQfzxuMBsrVRsK18Pka58
 TCyzRIlxJgDyV3rZPUMTXOCi7t6jg3UxtyFBQ9UQVzfd/FgTpdWJfrs3rxy+/ZHWEnLY9Jh
 ICmQZP67FS6bIlUOsWjdb7ufbrKqE5z+kdcUQw1I0I2SG/eCk+XycAWwELLFmF4VecTq9Nl
 z1eENnV2RCp5iMsQYYBPg==
UI-OutboundReport: notjunk:1;M01:P0:99gP8A4e4hA=;6rxRPoARibxYbvYELXrceontBAW
 gaQtJ/fI4xNOM3dcl6ts4tshaydk4mSPRSpLBg4ZJQktDLU0H8lQm5FCTX8lBHCdGXuER9bsO
 gkuvo4doTRezbSXRHiP0PV6qH5wY7f8CyHhcQ5t0qbzZaR6TdgWWLtUCpciMfHABOqNx+MyC1
 SeIvKtt8OdlGeYI2NntDGLFfqEyIbu2CCX8tUM/mygN09UkdvWSJvK3xmrOZg5H28E7Yxhog5
 PQgH42tUsqx5cniFyKQ7YScFVt+LzxFwYvi2gXphLUcOkSLqNjiSH6B7rA5RCS+2eiEGiNDJG
 3bn3s2+yd0G+SSTRjE+lQfDJ9GdGR7srAU3z2FHU3lfHy4B/KudasFfROpKs0kx7YZ42VHmJ6
 /1N4ZW2HRpT49ZzYhD1fvai0M2Uh9s02zQkueSv2w5COYVZe9lfj4XMUzoz4dmWycUZp7eZ3y
 726AeaGybKKi9dmhO0qfHCD3OmvPlbit21qcuPTN6e9OLMBUtt/YoXC5ShjcGmaV6P6qlURLO
 1AdwyVS5Iudcec7tUnfrChHI+mt2UzuuQbnDTSCUQjGwQrhSNd32p3p48RL+DEY8Ox1manci+
 dCzprTFPpbdYW5codKojwDCIwmty8bC8Gb+SzbleT/BCrZAuiKj82mFcXGti3eW6ERW/AAjev
 +9i+O9fh5+yfOBZw/jTYYReV9jQtVOzqBnVnHy/zdj/haLDKl8B1tSHRrosBTDnecAaiX7+VI
 iEJsg6LCXzmlHUCM+oICXzFRdaSdR8CAk8YCSF1a1vrfVr732doNf0YYFVMDrRH7fJkIbBO0/
 aDyGwjRfpGamDiBnRMJP4lDG/+d7e8r1yNCxwSSbetti1Pls+DOIe5CEoOi6Dd3VFBa1nj23A
 TdswlKnV9ZNvN8Txp3oDp9trlEffvJFzuNMDJP6nrcTFyzq1XTDgzXgZzVEim/5+bd6CWmvdm
 0tJTHcmDFERSXevqRGsO32Lqkjo=

This series contains a collection of major fixes for the qca_spi driver,
which has been recently discovered.

Changes in V3:
- Avoid race condition in qcaspi_set_ringparam() as reported by Jakub and
  move all traffic handling within qcaspi_spi_thread
- use netif_tx_disable instead of netif_stop_queue

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

 drivers/net/ethernet/qualcomm/qca_debug.c | 17 +++++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.c   | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 9 deletions(-)

=2D-
2.34.1


