Return-Path: <netdev+bounces-163034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A41A29407
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C6516BA44
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA318C039;
	Wed,  5 Feb 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OyMho7WH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAD18B47D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768291; cv=none; b=mCqFo3FdDZmFPf5BRBqWaINV7FtQIefQwm0yNgNgPiB3eswbbcXwvJKLjugp9+XwWSZrn99stszAee12lvUKNOy6osqOAs6XVLEcdh1Rrjs3gHI7Yq/NLAA6vIuBXZsKNpY5iWPEKBW/Nh3/Y0vFsVnuH4ct9A9XbGXOvlz4bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768291; c=relaxed/simple;
	bh=spnZzjqIUv4JUysSdH/tVP6Wb605he0LEd5+qiJrcOo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=keLRTvqHTBvxODm95EjFNsJ3HRRKy4qvvJyHLVBoEFswJ89x+g85qsCY0tuPtJIRHtP8cj5+wpnSIyVMKz83ztvVw7dqDLfcGbMn8xyASJk2JgNp2pPtt92AE+11iSEAQ8PHRzyBy9Z0z6fMtDebzvCC0XVHG8LET2qyZDUOvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OyMho7WH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=an4Bf9RgJBmZ5nR+GtJJGxEy/QAJGcPX467lHgjHOaQ=; b=OyMho7WHGFZuuANCtdiViZltw4
	Vz6ET93WyCtj5gjH0kUJ5/9WmsxWRQABEnePeiCrL2mHezK+Wd7UjAr63lP7jdkO5QRdMem5IeVC+
	H8CKHGk4xUkcAf5vvug0PGF0nmS7armpUoZt1QDvpWNsaVsqUj3mA0DO5kg1LViAGCIcWyNNymsGp
	xDvI5taMBrOU5rHHFBqGjv7RL01R7lOuYsbkAMEYbLhb0kHYItV8Cu/NJME+/gV94ofrMmCL6YVvd
	NsoTDliEp9Y1ZLQ1bAbKVKKILzt8sMH8bRE+iZmQ44JKA5U5yrqQWQS+3FqzfNcApvO4WHdxTE4pp
	Qnci41OA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38612 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tfh3f-0007Su-1Z;
	Wed, 05 Feb 2025 15:11:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tfh3L-003aRM-VU; Wed, 05 Feb 2025 15:11:00 +0000
In-Reply-To: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
References: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 2/3] net: dsa: allow use of phylink managed EEE
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tfh3L-003aRM-VU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 15:10:59 +0000

In order to allow DSA drivers to use phylink managed EEE, changes are
necessary to the DSA .set_eee() and .get_eee() methods. Where drivers
make use of phylink managed EEE, these should just pass the method on
to their phylink implementation without calling the DSA specific
operations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 291ab1b4acc4..2e0a51c1b750 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1243,16 +1243,21 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
 		return -EOPNOTSUPP;
 
-	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev)
-		return -ENODEV;
+	/* If the port is using phylink managed EEE, then get_mac_eee is
+	 * unnecessary.
+	 */
+	if (!phylink_mac_implements_lpi(ds->phylink_mac_ops)) {
+		/* Port's PHY and MAC both need to be EEE capable */
+		if (!dev->phydev)
+			return -ENODEV;
 
-	if (!ds->ops->set_mac_eee)
-		return -EOPNOTSUPP;
+		if (!ds->ops->set_mac_eee)
+			return -EOPNOTSUPP;
 
-	ret = ds->ops->set_mac_eee(ds, dp->index, e);
-	if (ret)
-		return ret;
+		ret = ds->ops->set_mac_eee(ds, dp->index, e);
+		if (ret)
+			return ret;
+	}
 
 	return phylink_ethtool_set_eee(dp->pl, e);
 }
-- 
2.30.2


