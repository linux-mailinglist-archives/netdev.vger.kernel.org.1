Return-Path: <netdev+bounces-131457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB698E868
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD14284705
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046D171AA;
	Thu,  3 Oct 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCBuU0eQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD1BA49;
	Thu,  3 Oct 2024 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922335; cv=none; b=R1XWB2WiavQBRDzw8xA7GRIuTjboS1TtktV8sMvWJcpWmT5eqPV6ITWcEutjjM9RZ+rjSbhy4tUn8zCXT2yOAotwt4ChRQE40tGS9iovRyB9AXTCUC6HBIy+ElxYcU/YVAuNzi4iDJOBJLabBOLX6tu6qM9F4UkN4+3z9SB4kXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922335; c=relaxed/simple;
	bh=LguPtBolw9t6KVom51ouY3IqR+yTaUGRdCGlMJuaWu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KLNV0KToxS3L2hHEYz2w4dMtdPNSl6K/svX661bkBRZEDHEw8pve5SIS8vrEfBe0vR5FWgaInlhMxHaEOC/jUnG//9Kdv4W8IHKlnWsgqSYslIDjIwgiMryNFmbjTOuKhiFHFgFhbj44k3fxLEVnqvzR++xwvXPwcGEGZacholE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCBuU0eQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e18856feb4so412351a91.3;
        Wed, 02 Oct 2024 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727922333; x=1728527133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBaz6lB0sicuAwTrZuei38DywHgcqip0M0hQ3nBEA64=;
        b=HCBuU0eQ8okK4OHDFlYJkpT6jbg5grMDL6b8H7o6PJWbrVIgZpiJVKaNz+6n6VDfuv
         rLfIDzbPQNxkyJQYcTPIisJ0YxOgSbZtow1xm6xPFU5Yyt5mqPusBM9YspHs0XrA8rvy
         RWngj7qx9Y2+fhtfEmcdiAmevTJSbj5XTpE6bBDdj9f+0M/HrxYLGPJG4yu0UzDc2Zh2
         zTe3i8obwhrYQURlQFQEmwTjjut+DgMZIDrOPKhoYBwo6FMrxsM+dZ5yZe1qB/Y0DTlC
         6U2qWHb5RbJDQlir3bBGrZwIv7nkgACf+D7yqekrAIN4Ccs+3pAVUePbZ0xYZZsXobZN
         yAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727922333; x=1728527133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBaz6lB0sicuAwTrZuei38DywHgcqip0M0hQ3nBEA64=;
        b=fAzAc6AyObMWCqMmSZeg9HU24FDZ8/PHyAU/W9ewsbO4tgUTuBqf2RlMjJoYE+cBLn
         GpB7cplraVI/5iCmulRj5nGxxrK4X1DPg5tpywNozTm72+OzOLpbQwTjEKeujbfCUkxm
         JYoFyc/1mUojopLZzGHxMWv/k6oZ1KFamqxWheZQG3QVuBe2g9AKj+9Ak0j/Nr6paBM7
         aRQbkLnzOVnFiT7ehT5J4j+V+Mo/W7yHmU2fNkMnUOfqMGJKfYWVDMSJ2MBUgRjdJ8ai
         hxbrSqiQsk6FeBd8YUmIggnRBiCFVtIcQvPt3QYdi0chlAP6b67KsZjc9XgVIXz1AJJ4
         Fq8w==
X-Forwarded-Encrypted: i=1; AJvYcCUVJOmWuU+sb/Ygf+xHeYPv8wi4U9t38m4W2Y0+EERyrTvBKAEBNMajFOajF/SSP7JK5guJ5VpF@vger.kernel.org, AJvYcCVDGb69iA4wKrXsEzHBCCUnhIBxyABMCzSe+UmFKZEvJuC4hlYsQKm/9KcP+fREZWp9gxaOhy5Z4HbtqVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEvWwkcR5JU07/kJksk4ZZO/ul9pos/qMl2VLYcYGCc6q6t2l
	C7YgGbrahJ5vzNagQzMhiPTyqjzozZfv+8KZAEc8LcdiEnGauudj
X-Google-Smtp-Source: AGHT+IH4ICFmxW01C9JuQFxYLiqHP5FBDN6LyNRKYqapyPFSePx76Ckc1AikPcDX84W3DmqoMNPB9Q==
X-Received: by 2002:a17:90b:4aca:b0:2dd:6969:208e with SMTP id 98e67ed59e1d1-2e184511367mr6582573a91.3.1727922333229;
        Wed, 02 Oct 2024 19:25:33 -0700 (PDT)
Received: from harry-home.bne.opengear.com (122-151-100-51.dyn.ip.vocus.au. [122.151.100.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca242csm51305ad.112.2024.10.02.19.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:25:32 -0700 (PDT)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To: 
Cc: qingtao.cao.au@gmail.com,
	Qingtao Cao <qingtao.cao@digi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link when autoneg is bypassed
Date: Thu,  3 Oct 2024 12:25:12 +1000
Message-Id: <20241003022512.370600-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
activated, the device assumes a link-up status with existing configuration
in BMCR, avoid bringing down the fibre link in this case

Test case:
1. Two 88E151x connected with SFP, both enable autoneg, link is up with speed
   1000M
2. Disable autoneg on one device and explicitly set its speed to 1000M
3. The fibre link can still up with this change, otherwise not.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/net/phy/marvell.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 9964bf3dea2f..535c6e679ff7 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -195,6 +195,10 @@
 
 #define MII_88E1510_MSCR_2		0x15
 
+#define MII_88E1510_FSCR2		0x1a
+#define MII_88E1510_FSCR2_BYPASS_ENABLE	(1<<6)
+#define MII_88E1510_FSCR2_BYPASS_STATUS	(1<<5)
+
 #define MII_VCT5_TX_RX_MDI0_COUPLING	0x10
 #define MII_VCT5_TX_RX_MDI1_COUPLING	0x11
 #define MII_VCT5_TX_RX_MDI2_COUPLING	0x12
@@ -1625,9 +1629,26 @@ static int marvell_read_status_page_an(struct phy_device *phydev,
 {
 	int lpa;
 	int err;
+	int fscr2;
 
 	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
-		phydev->link = 0;
+		if (!fiber) {
+			phydev->link = 0;
+		} else {
+			fscr2 = phy_read(phydev, MII_88E1510_FSCR2);
+			if (fscr2 > 0) {
+				if ((fscr2 & MII_88E1510_FSCR2_BYPASS_ENABLE) &&
+				    (fscr2 & MII_88E1510_FSCR2_BYPASS_STATUS)) {
+					if (genphy_read_status_fixed(phydev) < 0)
+						phydev->link = 0;
+				} else {
+					phydev->link = 0;
+				}
+			} else {
+				phydev->link = 0;
+			}
+		}
+
 		return 0;
 	}
 
-- 
2.34.1


