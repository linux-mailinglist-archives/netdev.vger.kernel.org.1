Return-Path: <netdev+bounces-150705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96369EB336
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74E518861FD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB81B85DF;
	Tue, 10 Dec 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dQZwhsiy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302871AA1FD
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840807; cv=none; b=g6u3inE4fo34zIW/nhGPrYbDshamC4HoImWefKwyyonTIUzU9EnB5VxDakQ+K4KBAizBRMvMim9+BmIWzYhY4h1vQ3zCrOHtcsswkPXfuwsXjWssHRge9jZdZyjgj0meOD6NLt4ZudPlS2yyi0CQPRKApi1lOw/Lx+G5LstMYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840807; c=relaxed/simple;
	bh=VJ5hq5cH14c6P+fcjHbFrh1FneZgUgeM0T3XRlKzlh8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=enuPBsueC3V8OpWcZVoIacer461eyJ9HLmeDGQ0RGOfmrcNY6X671wIqKbUitrKZsmFAul/5GcETi2/Ury/6TxGxa/ZadVzNva0zW6PO9oJrjeuTgQZNCozfDXHm16aeegtrZzoPGNnYg1wH1FwTXtLBLdiRYgY7uNZ9J5X+4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dQZwhsiy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LpgMeDj97We01J44ueWyghgSoa7S5VUOV3d2kaBDb/M=; b=dQZwhsiyZW9gxtERc3p3B2dUS3
	fEBUpDEgZ+VLXaiclhKgtjfnn51Wm8+bugxYV3JC3POW9BHJoLrZDu/3ILUa1cFJ0g9qry9PsHyDn
	ZaWyqcRHIHo9HamAu0MuHutqaMzKJC4IDPJYNX0TsTSzRFhvgmhZjkTszp1DrGFyAoLERJCSJwukk
	RkOpROI9uyrY2s7o2U3CApLaVdaXXat86E7khmaKm6wSgPtC0QuWHBENsxJ63u0IlQ/jQVRi7N0bI
	rTgVEhkijDwzpul5jhcfdhgdmxhWIDKLo6cQoQV3tHHFj3/Vsb2kD6Ih3xpN9sall/WHCPlA3v1ek
	tom34HRQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57154 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1CD-0002Yv-23;
	Tue, 10 Dec 2024 14:26:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1CC-006cnY-39; Tue, 10 Dec 2024 14:26:40 +0000
In-Reply-To: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 6/7] net: dsa: qca: remove qca8k_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1CC-006cnY-39@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:40 +0000

qca8k_get_mac_eee() is no longer called by the core DSA code. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   | 1 -
 drivers/net/dsa/qca/qca8k-common.c | 7 -------
 drivers/net/dsa/qca/qca8k.h        | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec74e3c2b0e9..4c68524ad8af 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2017,7 +2017,6 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_sset_count		= qca8k_get_sset_count,
 	.set_ageing_time	= qca8k_set_ageing_time,
 	.support_eee		= dsa_supports_eee,
-	.get_mac_eee		= qca8k_get_mac_eee,
 	.set_mac_eee		= qca8k_set_mac_eee,
 	.port_enable		= qca8k_port_enable,
 	.port_disable		= qca8k_port_disable,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 560c74c4ac3d..13005f10edb7 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -557,13 +557,6 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port,
 	return ret;
 }
 
-int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
-		      struct ethtool_keee *e)
-{
-	/* Nothing to do on the port's MAC */
-	return 0;
-}
-
 static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
 					 bool learning)
 {
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 3664a2e2f1f6..961d14f0336d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -520,7 +520,6 @@ int qca8k_get_sset_count(struct dsa_switch *ds, int port, int sset);
 
 /* Common eee function */
 int qca8k_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *eee);
-int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e);
 
 /* Common bridge function */
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
-- 
2.30.2


