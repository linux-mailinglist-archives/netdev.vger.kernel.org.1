Return-Path: <netdev+bounces-150695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234959EB301
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3676A188C708
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220EC1ADFE4;
	Tue, 10 Dec 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WitDPj1u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2E1AB533
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840337; cv=none; b=mFRXZWjEDLB1vZCXBiqLnVnTjj9MLTOOIVdAdn0Sk1VZDrMF3wGGrtmImTEvjYDFADwIzEx2c7VyYXfhf31vBh8dEDVXnrqr1X8oQz09rDos4tT2eb99C9O6PpYZ7Soaw/p8WtbACqAsNSJAtAINwRafcTZshgAaLh0AeF0xXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840337; c=relaxed/simple;
	bh=Gz5SaoZ6XR4jSsKNMpY+IcyX+xmf9XNXCqHd0pU19e4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kE1YFqcAa0FZFQV/wtAFL7zmPx59krhmiMXZkbSqD5dSeR/ud8RFtAaBx8WSLdARrGsMdlVAqR0w4Ef12ZkBB6d3vs9GHh82BU3D4QDu+vIdKMWDw9/ruD3dWLllnoor8ypkrvW379oqOQ/7A8yRpoT1l7hlB1MbB9FPbmTn1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WitDPj1u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QBw3kdsWfeaYZY+i94PpsY0B716chNrcMQ64CIsLjkM=; b=WitDPj1uZ6qfMyG2e/kmTBIFSF
	z3PCrbIaELDiXrxUlqOzbsYB7iij6/iWzIDUHQ7QWehO9qPLxRi9BNzz9xRC4bBVu7o8AdfIZdYtk
	ppN0idufkyDYuLTnCQ8kvNi5i5CyGP1j/6JRS9fIMMkcb3Hfedl4b8AVW+ByTeJIVBQsPbGOuuGs9
	WZnBTom1ErgdEoEn5eNAfphyKHlTP0KGg1ZRJR5ehZrnZ113beNaHGXGmTI+8XII+fCcF2pxGGE6f
	PRIFmZfuKCEsf2ltdGIWl9r7j0Iw7pE3Tis1W3e7yk300+4MN35vZuo25V1T77fIsgG6hGs0iwStJ
	fh7hSEsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40608 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL14W-0002UU-0R;
	Tue, 10 Dec 2024 14:18:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL14U-006cZm-2K; Tue, 10 Dec 2024 14:18:42 +0000
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
Subject: [PATCH net-next 7/9] net: dsa: mv88e6xxx: implement .support_eee()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL14U-006cZm-2K@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:42 +0000

Implement the .support_eee() method by using the generic helper as all
user ports support EEE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3a792f79270d..1d78974ea2a3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7074,6 +7074,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_sset_count		= mv88e6xxx_get_sset_count,
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
+	.support_eee		= dsa_supports_eee,
 	.get_mac_eee		= mv88e6xxx_get_mac_eee,
 	.set_mac_eee		= mv88e6xxx_set_mac_eee,
 	.get_eeprom_len		= mv88e6xxx_get_eeprom_len,
-- 
2.30.2


