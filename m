Return-Path: <netdev+bounces-197216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE6AD7CE3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74263A925A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468C2D4B5E;
	Thu, 12 Jun 2025 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="biRjZe1V"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223362139B0;
	Thu, 12 Jun 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762367; cv=none; b=K3Yqt0YFAth4e0V66kqxwIo+Tt2lGeZ5Izoi4K1OKlVEsyoiDP7AkNgRsW3VMfdzVKZUP8akbbK/YxOgvYWtfkhyqf5FN3bjvjX2MWlQY6vSo0ASxkYQ4Ddf1a52nPtyLCZvCrtXUI9x5oSsvAbxWUWAkpwcLHBth8Cn4zEZC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762367; c=relaxed/simple;
	bh=DUeW/s8ZB8gyB4uOGnA0S+BXyM3/0SswhgBjBqdH/fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7grk3t2Wuhp+Li+31glGaXmGs4QgO+PW+TWx463DnzyiIAH1Mhy1z9KM4tYzOPb6Acw47WZSp2/d8KFRUmwjhugmbQMtE9iWKxauKZTS6mcYkZm6vbmoazoEaZncfwrMTMI9KeT3FEEzqIg0fhMYv0KHF0RQYqLK6oifJfhPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=biRjZe1V; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 24776C005FBF;
	Thu, 12 Jun 2025 14:06:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 24776C005FBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749762364;
	bh=DUeW/s8ZB8gyB4uOGnA0S+BXyM3/0SswhgBjBqdH/fw=;
	h=From:To:Cc:Subject:Date:From;
	b=biRjZe1V5B6CjFa3t+UtGzHQ1ogCj1mFNRYvRJz8LRob6PetFc64EXR6fP9MIYoVI
	 t+u2fN7qg72WL/7Yyvl+o7OlQovgKkbRotwFb+MOnnH4VB+WeD69A0Ip3dzyTkNU3N
	 IncS0C5RbQa9iO3K+IaCSEvYRZMy8QT1e+rt+emE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id EEB1918000A52;
	Thu, 12 Jun 2025 14:06:03 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Doug Berger <opemdmb@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bcmgenet: update PHY power down
Date: Thu, 12 Jun 2025 14:04:49 -0700
Message-ID: <20250612210449.3686273-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doug Berger <opemdmb@gmail.com>

The disable sequence in bcmgenet_phy_power_set() is updated to
match the inverse sequence and timing (and spacing) of the
enable sequence. This ensures that LEDs driven by the GENET IP
are disabled when the GPHY is powered down.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index b6437ba7a2eb..573e8b279e52 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -169,10 +169,15 @@ void bcmgenet_phy_power_set(struct net_device *dev, bool enable)
 
 			reg &= ~EXT_GPHY_RESET;
 		} else {
+			reg |= EXT_GPHY_RESET;
+			bcmgenet_ext_writel(priv, reg, EXT_GPHY_CTRL);
+			mdelay(1);
+
 			reg |= EXT_CFG_IDDQ_BIAS | EXT_CFG_PWR_DOWN |
-			       EXT_GPHY_RESET | EXT_CFG_IDDQ_GLOBAL_PWR;
+			       EXT_CFG_IDDQ_GLOBAL_PWR;
 			bcmgenet_ext_writel(priv, reg, EXT_GPHY_CTRL);
 			mdelay(1);
+
 			reg |= EXT_CK25_DIS;
 		}
 		bcmgenet_ext_writel(priv, reg, EXT_GPHY_CTRL);
-- 
2.43.0


