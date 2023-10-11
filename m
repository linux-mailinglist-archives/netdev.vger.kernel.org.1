Return-Path: <netdev+bounces-40017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B170B7C5643
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA13B1C21218
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC8200C8;
	Wed, 11 Oct 2023 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv1HVdZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D920321;
	Wed, 11 Oct 2023 14:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17310C433CC;
	Wed, 11 Oct 2023 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697033004;
	bh=zrhlLGL/7VohDIuN/EnFdfDCdV/hjo/fxSU8flcn0tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fv1HVdZCtl1nJlrYvL4pbAyBWkP5ONV8qajJUP3MxqjnmH7ue9v7qW5IY/d5p+JX0
	 XzuLDOSvYdqyJqrMue4njz27bUrf3is+UQkG+0Q30EQsfZtTHlO3p+vWGTF9182BkG
	 UUZPGRKBvYwBTr5nY88nGPXcup+2wbUzlxEAQvEMiapopqvV58MnfdZ/sW10zJPlYl
	 E70dw4/UxSSM1nf7fdjyNjc8LI/n6v2crN/Rbnix/VMb6o8TlrAZtLo1t6rNB+Yq83
	 wlti2jF0kEbgmTnPqjaS6F5CjSxANi7pncq0av/3EA5s/UOfO5+eMuDlCeAIB06ZzP
	 aRvesvlAVww2Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Rodolfo Zitellini <rwz@xhero.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 10/10] net: remove ndo_do_ioctl handler
Date: Wed, 11 Oct 2023 16:02:25 +0200
Message-Id: <20231011140225.253106-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All of the references to the callback pointer are gone, so remove the
pointer itself before we grow new references to it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/networking/netdevices.rst | 8 --------
 include/linux/netdevice.h               | 7 -------
 2 files changed, 15 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 9e4cccb90b870..6f9b71c5d37b8 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -218,14 +218,6 @@ ndo_stop:
 	Context: process
 	Note: netif_running() is guaranteed false
 
-ndo_do_ioctl:
-	Synchronization: rtnl_lock() semaphore.
-	Context: process
-
-        This is only called by network subsystems internally,
-        not by user space calling ioctl as it was in before
-        linux-5.14.
-
 ndo_siocbond:
         Synchronization: rtnl_lock() semaphore.
         Context: process
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fbaf..8d1cc8f195cb6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1121,11 +1121,6 @@ struct netdev_net_notifier {
  * int (*ndo_validate_addr)(struct net_device *dev);
  *	Test if Media Access Control address is valid for the device.
  *
- * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
- *	Old-style ioctl entry point. This is used internally by the
- *	appletalk and ieee802154 subsystems but is no longer called by
- *	the device ioctl handler.
- *
  * int (*ndo_siocbond)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Used by the bonding driver for its device specific ioctls:
  *	SIOCBONDENSLAVE, SIOCBONDRELEASE, SIOCBONDSETHWADDR, SIOCBONDCHANGEACTIVE,
@@ -1429,8 +1424,6 @@ struct net_device_ops {
 	int			(*ndo_set_mac_address)(struct net_device *dev,
 						       void *addr);
 	int			(*ndo_validate_addr)(struct net_device *dev);
-	int			(*ndo_do_ioctl)(struct net_device *dev,
-					        struct ifreq *ifr, int cmd);
 	int			(*ndo_eth_ioctl)(struct net_device *dev,
 						 struct ifreq *ifr, int cmd);
 	int			(*ndo_siocbond)(struct net_device *dev,
-- 
2.39.2


