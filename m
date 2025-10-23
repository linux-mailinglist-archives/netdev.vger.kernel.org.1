Return-Path: <netdev+bounces-232158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F873C01E55
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CA1A63FAA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175132F770;
	Thu, 23 Oct 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJOUNYYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F7314D1E
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231033; cv=none; b=p9VpJRm0w539T8b503VWjR6/Sb9hqhT0Qfs4UAbyXBRh2ugstuH0Mn+mPNlxp3gZ4Jx31hY7miWA3u9Pxi2YNBeL8450kyos9fNDqfNL8mnaE4noGj04VQPEDziZrlM9z3b87gGFmYmuY0nNXnlVqRxaq0I/Y3kKwktywLIKK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231033; c=relaxed/simple;
	bh=waBTP7RtsmhC1WI2NmWFK1HTs2arG4JeVs+IEMQ0HQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH6UAp5SU6e0PKjMScgi41hmf8GZtQ8XpY3i3DWiVGzGxkTAfe7IX5y46N1zSf81UC10nAyogxpfnyNPtFDX0lwhuVh3IfdPD7qU944whG7RweO7OfEdrJKPwTLPMh5N69fPTqN4NxHNVGj47Nq6Om1Bhl0Cb26h8WGnbqlWvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJOUNYYW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475c696ab23so5486275e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231030; x=1761835830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FassfAN01QkxVDyy+Sa+b0ImlRDr/lRNphkFcyroU20=;
        b=MJOUNYYWLMw7HcqSw6agbDQdkiAGR+T8i/4u+wu5uRk8mrBejYpLzAvM1XkfyIZNG2
         o3LuQ86oHQgHRBDwFlxX3KVyFPy7gHKSw9+Q/RuvaNlI5OqiIcuOnad+dnUB7KQDx5rP
         N408xobqk5EbAgZHR1xK1shlotJOt1Mxe2+oWx3dEVziSIySyxpMUfboWWRAIIoroOdr
         IB4zXM2VMSWhXyLmAKgXDZfKmZvymHYXQvODPIVHbNzsBEcjL5j8q1LnLKaTrtgCg24B
         Qqbk5xsYBvXFOYaOPXkeEpsL0rMS+0oqsvqztAPiIYIj8pJttI4M1UVM0YFiThTScpIW
         VP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231030; x=1761835830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FassfAN01QkxVDyy+Sa+b0ImlRDr/lRNphkFcyroU20=;
        b=nFLKcdUVzMsM4qtbwMYP0wnYC/cYqFtE+wYoG0dfeF2sPcR00gVMicZ/wRLQvpmk08
         vFbgoUsQP/e+e9irVYs/rlfZJQ7ZfGYGDIGDsediVyekKZ8OnZl6gZQN/VMP2oRAyXUx
         ej4GKnS39ODcTsZijR7EUG1p9mji2bfpHy3/2sjTFhrUAHSCKTlOObFhu4wIRyY30TZI
         CyPnb5lzPMGrFuQU5+ch2RwjiZO0tYYtsc33TkO+Rw881entmoBvpoQYKQBS+GJprwpU
         87mTdeLgfhFCEaZUeujCaeqq9LSO5RZCV2MZ2rF1kfTY64L55guAZMdkzJBUlZEWO63/
         yN/w==
X-Forwarded-Encrypted: i=1; AJvYcCXYe2uR5BdEpGSrPuEcKLRoLgJBITtE9vukrx6uwpj//iiHWqyLnkboiTi6/R2NDcu5Kmr/Bzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbs8VAJ8Bgf/rZLHDu2I7E84kWQbmbyZKT8cgmbr+ghPejo5GM
	iwXjsUtC4DETfok0wzQ+Ht6+CDxKN8IPZ3WCTTskPGwAIn3HqmYFtzia
X-Gm-Gg: ASbGncssD4fA7pLvPrcRJAC6iyC6lYJI2SmLmz2xuJWGoTkWV1FSweBZadOurLkD9vM
	y6T14DZLAdEdyK81Xneaszd6i0NBZu8tpTnnhncBC4sUpju+7d+fek0AIhoB/V9qBSroBHrCDY8
	YCR49pEKV4tUjR3CBrSKQxIjegO681amGTxolm4SWruNZ/7waniPxZjEO+l8CyCnQqyw5qWk4s5
	zFNvXD2lDQYPVye49JvPWySFDfhEa4pz8tfFMsavPuk6RwnuRuNYqlbNcxHi7N78zXAPTX4Zxom
	fA9U1Ru7W9FQVaTqQQ/t8NqS5C3X/MvHqgcoq/U2FHDVi9aFr8NQvimRpl+N38z7ezIhOVl5bnt
	Sqbzf/XEzuo4oO2Tn0ROh0nGBxbT8bFMiiMFeBnRSst2Y3aFy+9taA9tOraMF2/b0MaXo/KiQjk
	ypEoFPCeJXr3ou3W4Oepzso12/TY3QjQFicDgDA/rx9x0=
X-Google-Smtp-Source: AGHT+IEs+GoltQcKBTrzCzP/DJpfopqS9pIvzCpIjkp1sHlc6JzXCwJNHAdY8xhjwduT8SXTQCUp/w==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-47117874978mr181531815e9.3.1761231030000;
        Thu, 23 Oct 2025 07:50:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:f374:5673:9521:bde3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm102312175e9.8.2025.10.23.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:50:29 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] net: phy: dp83867: Disable EEE support as not implemented
Date: Thu, 23 Oct 2025 16:48:53 +0200
Message-ID: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

While the DP83867 PHYs report EEE capability through their feature
registers, the actual hardware does not support EEE (see Links).
When the connected MAC enables EEE, it causes link instability and
communication failures.

The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
Since the introduction of phylink-managed EEE support in the stmmac driver,
EEE is now enabled by default, leading to issues on systems using the
DP83867 PHY.

Call phy_disable_eee during phy initialization to prevent EEE from being
enabled on DP83867 PHYs.

Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1445244/dp83867ir-dp83867-disable-eee-lpi
Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet
Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/net/phy/dp83867.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index deeefb962566..36a0c1b7f59c 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -738,6 +738,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phy_disable_eee(phydev);
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-- 
2.43.0


