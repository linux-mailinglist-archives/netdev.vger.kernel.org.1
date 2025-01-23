Return-Path: <netdev+bounces-160565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E95AA1A3C0
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 13:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EF916756A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B320E034;
	Thu, 23 Jan 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kegCNugX"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368B20F062;
	Thu, 23 Jan 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633861; cv=none; b=qIs75R4QEegkTF+breIKCOFnEeoC1uY7XvBDDffXihSmKnUbmfCbDkpE4xrUFBWqkyRyn0YxTSN2Dpk/TyijyWB1vNw1SyNnyC+DlzwhPMq2UQQDBptVKqvgsYX3hvXFcoLqZA86t705MRWoVlHLXI1L0yXrvviIjofou65TXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633861; c=relaxed/simple;
	bh=NTPOldMuqyXUnxtJbP7eUVw8oOHPoHde3DgwWgwLcZQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=KV/jt+RHDh71ZOJruYZvtNDvp5OGJrCk6iAIxQ2OUWypCiPxbq/NDbjg1h5j6qTw/siH82vDadQxgyArm43FGathmkCbD0hOWZXMpb42yAlX48hhhr3VPq8rCxoIOJuP30Kj3eZXipY+jSOWAExoF1JO5yI/4FMuJOYTe7/pSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kegCNugX; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737633849; bh=Uh7xIdqQsQIcK7y7ooekeMw7LYJ8yCqavXyUacDqRdE=;
	h=From:To:Cc:Subject:Date;
	b=kegCNugXHonasKFmJfJLqm8Ga28p7eqUHinHk4YqMTXOH+EdYfwzZWQXsp+um3BnJ
	 e/PPEmS7ifQ5y9k+u2Uc4HnAN7B/VT5nIjEQiJjN20bdtbR9GwWnpSKdGRhJTUjYuG
	 WTorbygRoe3nfbmW12e3gCLCriROxdYcsKFFbuTU=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id E6405CF0; Thu, 23 Jan 2025 19:57:36 +0800
X-QQ-mid: xmsmtpt1737633456t4x44j9hm
Message-ID: <tencent_4AC6ED413FEA8116B4253D3ED6947FDBCF08@qq.com>
X-QQ-XMAILINFO: MyIG+pWbYkor8XYhabMZkTEYuJLHB1eskSTK63u1zW4qwf7E1aKaZavqTTsfLw
	 GWPrjdcjFNb8xYXODV0YfGB1gS2dz3IUD2Ga6cJggL9j6SAJsbQxLincfb1ca9dhfmmMZASq4aGZ
	 0i7/+/bO0Bo2/03SYbr2vLXC8ng6Cl2+coyjGgyy/u7MeSUs+z1e75vCFtwlNnh5zFGUe6BuaH8T
	 BCHDDcLzZFYHX/ipQ8cRaKrf74Qgv1LhzR3HYya86MS+DxhnAfIG495hM4U7Txlqp7V31s3SfCJ4
	 JHRz64lWsBCm13iXkehhEabG1A5fabIqpg7YaI6icmBmlcItyBksrPNYPlEkCerIVjnsc5h3t2kT
	 s985yJl393AM1CRhluS4a2/YfD/74N1mvgMgPER3poPT6xwLkVel4naL5x7MZwl3L1BEjVkwgHaR
	 gCMyN8JWg95T9vrkBzSVO1szFwvYLLy1umuKUy0RqBVYtp5TK0fCtwKVHPgq4OGXCvBbbPh4w8r9
	 kQ8iXfTuEKW+g4E4yth/Om+uQxuZGGQeqb7R0kTCdgG/rA8xFsCFU48BZ8Ek1TI8alcBNdAY/cqa
	 7rOuZdi5sCgOPIIjZVKXnZtvuxa0zjN0L0mE8EvGPaP8uyfn1r+FUEbhEoDgkUh1j1XBTJRMwixk
	 zNd10jT3cG4RtvM083s5B8wvLuBNbfAw/dmscdgg4wEzFIvoD/dy4YPPzz0+kmuiGT/shRDAycCR
	 wbC3yY8nZMXyAYSn8Y8D3bQIQwhc0BawfwC9dlkI4FAFM4MxDEcdp/mB+ZRFVPGvcC/1xS6okC3r
	 E0zQJSIxZLf4aZSwArPO4dz9XShYTwUQomaI9y5Nk50DWfYPy5PB2DLi0HWmKMLbf6dwuG/YU9Qk
	 KKF+wsqallfz8rtHfHRz8VbIKCdE1mv6Li78b9G7sq9+JTCa5sJit33suyBTIbuCS3pptmi2cako
	 wel9w95aW+0QnS75uIwMK294oLbnglxq4URExN8mv1AW2Wu0yNpx9Ozn6HuQR8SLvfFFKTDloAWQ
	 ZipnaNGQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: the appletalk subsystem no longer uses ndo_do_ioctl
Date: Thu, 23 Jan 2025 11:57:03 +0000
X-OQ-MSGID: <20250123115703.400396-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

ndo_do_ioctl is no longer used by the appletalk subsystem after commit
45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()").

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
V2 -> V3: Drop Fixes tag and add Reviewed-by tag
V1 -> V2: Add Fixes tag

 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8da4c61f97b9..2a59034a5fa2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1085,8 +1085,8 @@ struct netdev_net_notifier {
  *
  * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Old-style ioctl entry point. This is used internally by the
- *	appletalk and ieee802154 subsystems but is no longer called by
- *	the device ioctl handler.
+ *	ieee802154 subsystem but is no longer called by the device
+ *	ioctl handler.
  *
  * int (*ndo_siocbond)(struct net_device *dev, struct ifreq *ifr, int cmd);
  *	Used by the bonding driver for its device specific ioctls:
-- 
2.43.0


