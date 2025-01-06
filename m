Return-Path: <netdev+bounces-155426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA90A024B0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28DF3A521B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C16E1DDC00;
	Mon,  6 Jan 2025 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FIwbPMic"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396F1DD88D
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164776; cv=none; b=Q2F6EZj7baDciq8Lym2M/WlRUMFE47fHQukUKhSyv3uW0i76G3t7Wnj55bxhTwSLrILLOMJrgDegy7qKBpWd58YEGgdm0CuyopknxOyvP5UHUFJv6pZB1OOrUXsZrg6Kyj2cVrmGcOmLc0it8ZSIU5kmNXn2mtM+/NKl4d74Wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164776; c=relaxed/simple;
	bh=g4wO0ET+Pj/s/0D3FB5Pk+69wU0pe+fJW6MPJgRWVac=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ONq6aM7Ncd1bLSWXN9LF3SXjBzeLxC3fOMgFfOtXUh4UUamjbm+e180GjIKmqFomHGWpZ4lVDFlXFHwhZGobIewy8MPlTeduuf5tpE9lcAX9owvVBfP7MevxAgUVIQH9LFGj4UtUZOEkKsLYKy5d3XmFUZrrESwD2nkv/Y4KJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FIwbPMic; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lKj1xCrTWB6oUM3KvvYnR1gjE7RxlWR8oUMhH1hQmqI=; b=FIwbPMicD2sdQ/Nce72hRfQI4w
	FW6SnK3gXfC27V6RD6NycwDFx//HFeNuQ5a30dp6Alj1MUiDFY13967p5jrQV3JrwKPNRCJUcglip
	EMytg+DN9CoutWzfWA138jF08Lnvh7A7fPOSQK+ccMMDFlsQr+MdjmK3TpISv78IdiuVUmfzyBwdT
	leOTB/C/fTWa/TZAhbQH8hUGvjN9pxfbnb0/Om/P+zLmVbvgHFtREZiUz63/ZQMrC5uMZ/lIyJAGO
	0Vdt27UZ0IEcn9xhckTA5tOLw7NF4qqc1lNyFNn/xt/pNI0YgjIxAxshi0V5nLDgSU+IyYZH5v+B5
	qeP/HCQw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38332 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUllS-0005m5-2e;
	Mon, 06 Jan 2025 11:59:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUllP-007UzF-Gk; Mon, 06 Jan 2025 11:59:19 +0000
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
Subject: [PATCH net-next 8/9] net: dsa: qca: remove qca8k_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUllP-007UzF-Gk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:59:19 +0000

qca8k_get_mac_eee() is no longer called by the core DSA code. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   | 1 -
 drivers/net/dsa/qca/qca8k-common.c | 7 -------
 drivers/net/dsa/qca/qca8k.h        | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 90e24bc00b99..2d56a8152420 100644
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
index 24962a395754..d046679265fa 100644
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


