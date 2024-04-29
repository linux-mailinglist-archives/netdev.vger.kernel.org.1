Return-Path: <netdev+bounces-92205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829C8B5F26
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D0B21F96
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8185933;
	Mon, 29 Apr 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhL5vx+7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C71DA23
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408595; cv=none; b=btUxaM+TLulncY/Mi8E+uX4zePNvzNZTFkgtBqCxrGf+fXxdUTsfit5bqQr1KR1oftSImOQPI8k5PtqnKNpsLtfLw2+rIi2Sld6rsVveAH2ttstsAh3axTS0TZ/jfGaiscROF7VrsePV+HouQj/6acR9x04sBRsO9Wbquwx6aGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408595; c=relaxed/simple;
	bh=WYvfWnsRpu0RLSxmTgg+qqm5H1A6I0HfRFjKBasBoFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdryU8iaK/+88Yg/v6pGWuK4a73AYG0+ZMJGhHSecNf3HZ/vDeO1fDzV1nDiBBJldPvK7s6sbcSOt/5r2neFd4BZYaMBdrWK8sLR9A4rjiXhK5SpxHZB7xd4w3pis/tUexoQdAcQvUmLFha2kmKLCKgd7qYxUQWSqWn75CUiIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhL5vx+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00E4C113CD;
	Mon, 29 Apr 2024 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408595;
	bh=WYvfWnsRpu0RLSxmTgg+qqm5H1A6I0HfRFjKBasBoFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhL5vx+7+iFM8jtr2hzWosvjiPdS79Y4VRbMlvAx57bK8Ez9KLT5NxtJv2oBBzjoX
	 9UvNupF2K1DA38KkPuwIxuWTC2gPD0TNZAKyZPA6ogMj+v8hJFyGIzNxqNkoWdcTRH
	 AxywmiZTi9RHliu4fbJmbB7/xjlyGvuwGsilvvaQ2bgdlMTVCfezSDPXLa6FeqCdXO
	 d3oi7GoOnPNlO7sNweB85/0Ac/MyCmBuqqvejoXVHW63OTQ2gFYD//L0TSbFsZCDrN
	 1BGyFyaBqqqbSRVXBm2yG3OamJLQ6+PxQc7/ciyX50F6DyjPCSgjxIrCkgvJQFv4SD
	 3K7Ihb+Gvd75w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 2/2] net: dsa: update the unicast MAC address when changing conduit
Date: Mon, 29 Apr 2024 18:36:27 +0200
Message-ID: <20240429163627.16031-3-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240429163627.16031-1-kabel@kernel.org>
References: <20240429163627.16031-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DSA exhibits different behavior regarding the primary unicast MAC
address stored in port standalone FDB and the conduit device UC
database while the interface is down vs up.

If we put a switch port down while changing the conduit with
  ip link set sw0p0 down
  ip link set sw0p0 type dsa conduit conduit1
  ip link set sw0p0 up
we delete the address in dsa_user_close() and install the (possibly
different) address dsa_user_open().

But when changing the conduit on the fly, the old address is not
deleted and the new one is not installed.

Since we explicitly want to support live-changing the conduit, uninstall
the old address before the dsa_port_change_conduit() call and install
the (possibly different) new one afterwards.

Because the dsa_user_change_conduit() call tries to smoothly restore the
old conduit if anything fails while setting new one (except the MTU
change), this leaves us with the question about what to do if the
installation of the new address fails. Since we have already deleted the
old address, we can expect that restoring the old address would also fail,
and thus we can't revert the conduit change correctly. I have therefore
decided to treat it as a fatal error printed into the kernel log.

Fixes: 95f510d0b792 ("net: dsa: allow the DSA master to be seen and changed through rtnetlink")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 net/dsa/user.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index b1d8d1827f91..70d7be1b6a79 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2767,9 +2767,37 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 	if (err)
 		goto out_revert_old_conduit_unlink;
 
+	/* If live-changing, we also need to uninstall the user device address
+	 * from the port FDB and the conduit interface. This has to be done
+	 * before the conduit is changed.
+	 */
+	if (dev->flags & IFF_UP)
+		dsa_user_host_uc_uninstall(dev);
+
 	err = dsa_port_change_conduit(dp, conduit, extack);
 	if (err)
-		goto out_revert_conduit_link;
+		goto out_revert_host_address;
+
+	/* If the port doesn't have its own MAC address and relies on the DSA
+	 * conduit's one, inherit it again from the new DSA conduit.
+	 */
+	if (is_zero_ether_addr(dp->mac))
+		eth_hw_addr_inherit(dev, conduit);
+
+	/* If live-changing, we need to install the user device address to the
+	 * port FDB and the conduit interface. Since the device address needs to
+	 * be installed towards the new conduit in the port FDB, this needs to
+	 * be done after the conduit is changed.
+	 */
+	if (dev->flags & IFF_UP) {
+		err = dsa_user_host_uc_install(dev, dev->dev_addr);
+		if (err) {
+			netdev_err(dev,
+				   "fatal error installing new host address: %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+	}
 
 	/* Update the MTU of the new CPU port through cross-chip notifiers */
 	err = dsa_user_change_mtu(dev, dev->mtu);
@@ -2779,15 +2807,16 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 			    ERR_PTR(err));
 	}
 
-	/* If the port doesn't have its own MAC address and relies on the DSA
-	 * conduit's one, inherit it again from the new DSA conduit.
-	 */
-	if (is_zero_ether_addr(dp->mac))
-		eth_hw_addr_inherit(dev, conduit);
-
 	return 0;
 
-out_revert_conduit_link:
+out_revert_host_address:
+	if (dev->flags & IFF_UP) {
+		err = dsa_user_host_uc_install(dev, dev->dev_addr);
+		if (err)
+			netdev_err(dev,
+				   "fatal error restoring old host address: %pe\n",
+				   ERR_PTR(err));
+	}
 	netdev_upper_dev_unlink(conduit, dev);
 out_revert_old_conduit_unlink:
 	netdev_upper_dev_link(old_conduit, dev, NULL);
-- 
2.43.2


