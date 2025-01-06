Return-Path: <netdev+bounces-155427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA1A024B1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E8164B67
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE031DD529;
	Mon,  6 Jan 2025 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zYOeLJlr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B91DC9B4
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164779; cv=none; b=CFSt28Ti6A9uxKYoypCbQV7to5G1rkeKVsLSGVCjrs83reXTw9UYPg9QaIrr8VVS57KuCdyNXZC/Db9GvkFYzgS0++YV/l+PL0P9ZDE/EU28FyRtEOTsKWB+W4SkA479Wf3QXlgpUcSwEgh7E0v5Qk1z3iZ9Vga6BbJuA64HR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164779; c=relaxed/simple;
	bh=kSiA94ParQtd16g2J/Kqqgn323ohU2UmPfI21Z+U53g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mEq2WQnHm/xPkS3JNcqBFcrwt4AEANfA2Nx+zrq+WImvvAr5GiJLCcnuQJmblLGxTjguvn8/vOA6F/WXcOouw7c0zXTHitGwEXEi4v+vGpF8mQWptplRAPdeRyqAw6M0cN77rA7p98T5Jk7YyEGpfXR7Rvy8xNDDrncd611OLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zYOeLJlr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G8t1xaI1/GugJIK8OBprVbaU/A8jM/gJsPmAeiSAzxc=; b=zYOeLJlrCypxVI0s25kv4zllPI
	UeEo/xeRtIxj1me7kVajNX1CHd4wqQYhNS41F/ykYLWSyxQp9ltLhspZJ/GZxV1XM6Wd2IhA5JTaX
	RzmGRJ48OxrNDT8lSSoYkEfY7tMxyR9QUoSopjmhfOkYRhr4XkYeGaZl1IxDCmkvDCyQVy1RIOP7g
	w5nitlnwt6OGOhMRsxPgS4++bSCCh5k5AvPFMLWm23FYwt8jsfwMU4WqImyqL9aUxSkP8Aa/ILocH
	l7uOqAUNbXECAI0KVrj3ESjS2tc/TZjV0NaaH4v28bWPVTFuTw5CAcNlavOYIECus25A4ovrJHQZI
	bZ9U7Ysg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38348 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUllY-0005mS-0L;
	Mon, 06 Jan 2025 11:59:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUllU-007UzL-KV; Mon, 06 Jan 2025 11:59:24 +0000
In-Reply-To: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 9/9] net: dsa: remove get_mac_eee() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUllU-007UzL-KV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:59:24 +0000

The get_mac_eee() is no longer called by the core DSA code, nor are
there any implementations of this method. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4aeedb296d67..9640d5c67f56 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -991,8 +991,6 @@ struct dsa_switch_ops {
 	bool	(*support_eee)(struct dsa_switch *ds, int port);
 	int	(*set_mac_eee)(struct dsa_switch *ds, int port,
 			       struct ethtool_keee *e);
-	int	(*get_mac_eee)(struct dsa_switch *ds, int port,
-			       struct ethtool_keee *e);
 
 	/* EEPROM access */
 	int	(*get_eeprom_len)(struct dsa_switch *ds);
-- 
2.30.2


