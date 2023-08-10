Return-Path: <netdev+bounces-26316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC409777838
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D16528209B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765A1FB34;
	Thu, 10 Aug 2023 12:25:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E052442C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B0C433C8;
	Thu, 10 Aug 2023 12:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691670334;
	bh=1f1uo4HhIlgH6LQc+YKtqnOOYeuciSTPT0zrCjcnXio=;
	h=From:To:Cc:Subject:Date:From;
	b=AerNdbBBddvE2On+cYp4dMdrRdmJXjHtrNolxFfAV6vrZ2QzZ1qT0twkSqjmM23yC
	 K5fy8gieyWVpD5iQoxXB0jSUKvbzzKe9BORAnv0WHXgirr0mUJKYdAeEkBbkEw2WhR
	 27HVE3jF6a/HaNxFGrLK5dR6KsuhFT/ecpVn2QgZTW9fCLPO7DCRTggzjdq9fBTR48
	 BzvpjUAJ5KcEs5Gmgyc1Z9Kn3Yy05orERx1bhHepK0A18Jo3rXnoMVktfxTLjNCFjr
	 ZhSdNpD3GJBtyvtMtgL2G5/ffwXQso5G+mFSH92Rcw5LObLD7JEvwFrfHQPjzR8WNO
	 3h4ggjR0pZfaQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Geoff Levand <geoff@infradead.org>,
	Petr Machata <petrm@nvidia.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Liang He <windhl@126.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ethernet: ldmvsw: mark ldmvsw_open() static
Date: Thu, 10 Aug 2023 14:25:15 +0200
Message-Id: <20230810122528.1220434-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The function is exported for no reason and should just be static:

drivers/net/ethernet/sun/ldmvsw.c:127:5: error: no previous prototype for 'ldmvsw_open' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sun/ldmvsw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index 734a817d3c945..a9a6670b5ff1f 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -124,7 +124,7 @@ static void vsw_set_rx_mode(struct net_device *dev)
 	return sunvnet_set_rx_mode_common(dev, port->vp);
 }
 
-int ldmvsw_open(struct net_device *dev)
+static int ldmvsw_open(struct net_device *dev)
 {
 	struct vnet_port *port = netdev_priv(dev);
 	struct vio_driver_state *vio = &port->vio;
@@ -136,7 +136,6 @@ int ldmvsw_open(struct net_device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ldmvsw_open);
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void vsw_poll_controller(struct net_device *dev)
-- 
2.39.2


