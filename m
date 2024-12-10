Return-Path: <netdev+bounces-150697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927539EB300
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D92B1667F9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741881B85C2;
	Tue, 10 Dec 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F+Pf5dI5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7E1B0F12
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840347; cv=none; b=NgpffC8eri1vZ3UaOJJ/QM+/JqbnSRJkMUJA1YMTBuADgbJkoMY+TIbGdYC3AXnd9Tt4+Wqa71sN3qqKiKHl+Cdln5fI8hFgHNCNrUxvUpLbs2B9dW9gv35fXUI04TG6fq71F9D6hybzPyKYM5eliPoUzM4KgYlbzw2ps+vCmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840347; c=relaxed/simple;
	bh=7DtGpytu/ERNtvB8n9ObuDWaCUBo41tD/FJwgFJDOFo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KRL+DEPNCOKudhoNvDlUC/G3o/zH6o/BQbbzEmQxfceK2hQsNQUBEyLfMHbkRsUfaiUqfS3XmZWYy0Gf5J/QZxeq0BUWbbqxy2irTnOAayT+DRVF6QT4vgnl/HZvAHLMVzqg85jDVYWja/0aV1unshzqGPbtD0Sk0BO8tWQ7+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F+Pf5dI5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KlYmLFN/8CAJKF2m4Ukp5uw+PCBqObvzNJY6qsnkWK8=; b=F+Pf5dI51Ctrw55VBld9EEk+dn
	uYLqPJohRuJUK+ymYvnxdIf80s9g9Bj08uB7WAH2hHXUhXZHQdyqRTTbllxx5MN4EZmn49rhRsLq8
	38IwM72V3I8y538wVPhUSy9kpvdbVl55DgKCThdHO+woh5oZg+eoQugjppoTuxYgg5ESYhR7WJcF0
	xA4aqQF2KcRGIjOkxjx36pssFxR+sTckaCSstoGRiju79IoafOrwQyRvQFc9IAu67qsFfQW4UTRuv
	SbsK7pUpMmRQjc3DXtGbp1LnKQU9NRrrX+luZanJ3jMFU+CxEMNUqs2HWwdcwt+7GQUoeemjFjnYb
	3SgGTBAA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34148 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL14g-0002VH-2a;
	Tue, 10 Dec 2024 14:18:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL14e-006cZy-AT; Tue, 10 Dec 2024 14:18:52 +0000
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 9/9] net: dsa: require .support_eee() method to be
 implemented
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL14e-006cZy-AT@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:52 +0000

Now that we have updated all drivers, switch DSA to require an
implementation of the .support_eee() method for EEE to be usable,
rather than defaulting to being permissive when not implemented.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index b54f61605a57..4239083c18bf 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1229,7 +1229,7 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	int ret;
 
 	/* Check whether the switch supports EEE */
-	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
 		return -EOPNOTSUPP;
 
 	/* Port's PHY and MAC both need to be EEE capable */
@@ -1253,7 +1253,7 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	int ret;
 
 	/* Check whether the switch supports EEE */
-	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
 		return -EOPNOTSUPP;
 
 	/* Port's PHY and MAC both need to be EEE capable */
-- 
2.30.2


