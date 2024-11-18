Return-Path: <netdev+bounces-145703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC19D074D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 01:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4424281AB9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 00:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738281C27;
	Mon, 18 Nov 2024 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJsnzDH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A5360;
	Mon, 18 Nov 2024 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890726; cv=none; b=Ed9E0vIKG5WX4z7srtmFKqoYScIQ6ucDgkXbit5+h6w71ONIpEOHJ27FvZB0f7NwYtzMg0s30KfakfT59l5JuoTPuRDjDum8g+VQkYscf9pAfUP9HfiWdJuUho7baMKJdEBDe5vQESX9MqmbcJ9VgZqCUmzu9i+zdDdd60mRsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890726; c=relaxed/simple;
	bh=kA1ByiXY5K+rLi2sj3wYU2ocSKz5rgoe8y46HvzPwAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jGJqXh0bz2k/hFBTSYQpHm0d5d2/ynnJfhnND5Ch+VyCRedmR2ZTLFhZbfcBATnam15ar7CGEZPCowd1aLptBo5ccEZqiGp5j4uQWBET2lZT9pJ76sr1jtA+X84KBxIHyQrBRTGP/3JgL2ovR222VxYS2kFAu8B6e2E1nzOp0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJsnzDH4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c693b68f5so23713035ad.1;
        Sun, 17 Nov 2024 16:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731890724; x=1732495524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRX0VvHiJZKtt9cfwQ9mhCnJ4ZqP3u+/oVwNiKN8Xgs=;
        b=LJsnzDH48Cu6SYZomkNFE1Fm7rwyptvnjIL4+Sct24ayN78ktFwV9v+VRHVZg84uVM
         rrBNY1m1lgipH4omKwBNQgsxsVxuz5vD25m4f2CC6UrEr5DXFKtoHAHSCmeKQ5h3bCO6
         2oemaA3XxUSP+xZyYqcDWIJoQ/h1qE39PahW5ra0oZebpkcqCl5hzDWSfgMB3f94264g
         VKbdubmBNy4B2cQNYWc1Wol3aTCr6s4l4OIk4ljWhR3BIvcIkB/AZ4nX2Xdnr7pMUyHL
         QJJAy7C5tBo/71iw9a+xM1ZgxyzjpabDgEmC0DfhG8OG8oy5iDqgSIdvhbsjDBO42gIb
         cLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731890724; x=1732495524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRX0VvHiJZKtt9cfwQ9mhCnJ4ZqP3u+/oVwNiKN8Xgs=;
        b=CWdqviBW4W2sS0z10NC0YyAqO3BCIad2mXR20eWU7ZYycjdbTbq0JppiOt+8t9E6xx
         2bd6vPKhEEtnPAE6p94hePN5hJw4axaAlIBZ0+qEATCtY7k4n/X6wLGObs2Ogmy64XFq
         YkVX7o7MyloHQSNTZRhY5TvKaEUvkgFIyADq6etutJrRmlncOjIjEY2qC8xL0gPrrETs
         NHLK/80BM/u2RBv56Hfl2u1RqzYvYCKRbLPDqjccslinKXD3/Z82TKuN6ucCIrRnUKzt
         4jZyjyMRbxX6/SF+8IYccWU/8CzW6/7sZ9UrvKcBInOjzTq3HchoVdInA1NkjN+NzTC6
         6wHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGt7zOHiprE/yYbvUQ54U7R81DQl3ozqldhJYYVdyBp/cZoeJBHcDNxPwZHE3u49UKDRpltLPa@vger.kernel.org, AJvYcCWenQTLdekv9uzcwTyAM4s88KlNT+2vbvrk8JvsqQLanvspfSLCjApmtMhRhlsZBXyyDFZP0gIcjcWkM1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIWz227/RkT1gOsJ+vig7RbTsjL8t9ceKuvD5eCUomScfeFR4
	O2eQwBPNETJefQyNfzOEHF24Kp+OTWag+NnpDVJBPlQueg/5P7+z
X-Google-Smtp-Source: AGHT+IGOU+A5Ft/ye7AqGZPzV4VIl7z1rxYSR/mHQnn0ZjHcrJGHWCkjJQMp6jVGLMA3rHxeySMqTA==
X-Received: by 2002:a17:902:e750:b0:20b:8ef3:67a with SMTP id d9443c01a7336-211d0d6ee87mr124722665ad.7.1731890724176;
        Sun, 17 Nov 2024 16:45:24 -0800 (PST)
Received: from harry-home.bne.opengear.com (122-151-100-51.dyn.ip.vocus.au. [122.151.100.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc31basm46031655ad.8.2024.11.17.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 16:45:23 -0800 (PST)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To: 
Cc: Qingtao Cao <qingtao.cao@digi.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 1/1] net: mv643xx_eth: disable IP tx checksum with jumbo frames for Armada 310
Date: Mon, 18 Nov 2024 10:45:09 +1000
Message-Id: <20241118004509.200828-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ethernet controller found in Armada 310 doesn't support TCP/IP checksum
with frame sizes larger than its TX checksum offload limit

When the path MTU is larger than this limit, the skb_warn_bad_offload will
throw out a warning oops

Disable the TX checksum offload (NETIF_F_IP_CSUM) when the MTU is set to a
value larger than this limit, the NETIF_F_TSO will automatically be disabled
as a result and the IP stack will calculate jumbo frames' checksum instead.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 9e80899546d9..808877dd3549 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2558,6 +2558,23 @@ static int mv643xx_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	return ret;
 }
 
+static netdev_features_t mv643xx_eth_fix_features(struct net_device *dev,
+						  netdev_features_t features)
+{
+	struct mv643xx_eth_private *mp = netdev_priv(dev);
+
+	if (mp->shared->tx_csum_limit &&
+	    dev->mtu > mp->shared->tx_csum_limit) {
+		/* Kernel disables TSO when there is no TX checksum offload */
+		features &= ~NETIF_F_IP_CSUM;
+		netdev_info(dev,
+			    "Disable IP TX checksum and TSO offload for MTU > %dB\n",
+			    mp->shared->tx_csum_limit);
+	}
+
+	return features;
+}
+
 static int mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct mv643xx_eth_private *mp = netdev_priv(dev);
@@ -2566,8 +2583,10 @@ static int mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 	mv643xx_eth_recalc_skb_size(mp);
 	tx_set_rate(mp, 1000000000, 16777216);
 
-	if (!netif_running(dev))
+	if (!netif_running(dev)) {
+		netdev_update_features(dev);
 		return 0;
+	}
 
 	/*
 	 * Stop and then re-open the interface. This will allocate RX
@@ -2581,6 +2600,7 @@ static int mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 			   "fatal error on re-opening device after MTU change\n");
 	}
 
+	netdev_update_features(dev);
 	return 0;
 }
 
@@ -3079,6 +3099,7 @@ static const struct net_device_ops mv643xx_eth_netdev_ops = {
 	.ndo_set_mac_address	= mv643xx_eth_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= mv643xx_eth_ioctl,
+	.ndo_fix_features       = mv643xx_eth_fix_features,
 	.ndo_change_mtu		= mv643xx_eth_change_mtu,
 	.ndo_set_features	= mv643xx_eth_set_features,
 	.ndo_tx_timeout		= mv643xx_eth_tx_timeout,
-- 
2.34.1


