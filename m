Return-Path: <netdev+bounces-249303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DFD168A5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111923036B8D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34534B1A5;
	Tue, 13 Jan 2026 03:44:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE725F994;
	Tue, 13 Jan 2026 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275841; cv=none; b=KAHyU03h7wXK28FE0I8927oM8+C3wJlbWVkhQ5hs8YHmi9Xxg0oOYhNmBcxprkcewtlp26QvEpk8vIeoSdHVMIgGqoJc75asMB2ZtJfl2ACJmCe2YoPff2hnd+Plu05eebG5oKhydoPPgET0FJGDWW9ndOjbp2wfqfkWlrN5QW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275841; c=relaxed/simple;
	bh=CP9bp6czZh6sOVto5q/ving5ZPoeeJ736HnW9sSLo/M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IPin2sYRjMS2RVQykaZ+2WppEKZTJ03tjjSRqHEfYEXTcQLvpIXe/zQVksrd2yCGbwhNWYMa8sRMWZYv6G+jx/5QOmrDaykDc3LGuOCM3gjiv3QPCpqL1dKCHpF5RbzYq8/vI2V+U7eJ97S+u6xwol0QXshHDmgyQwyDVtzGp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfVJw-000000001Tz-1c02;
	Tue, 13 Jan 2026 03:43:52 +0000
Date: Tue, 13 Jan 2026 03:43:49 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Michael Klein <michael@fossekall.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] net: phy: realtek: simplify and reunify C22/C45
 drivers
Message-ID: <cover.1768275364.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The RTL8221B PHY variants (VB-CG and VM-CG) were previously split into
separate C22 and C45 driver instances to support copper SFP modules
using the RollBall MDIO-over-I2C protocol, which only supports Clause-45
access. However, this split created significant code duplication and
complexity.

Commit 8af2136e77989 ("net: phy: realtek: add helper
RTL822X_VND2_C22_REG") exposed that RealTek PHYs map all standard
Clause-22 registers into MDIO_MMD_VEND2 at offset 0xa400.

With commit 1850ec20d6e71 ("net: phy: realtek: use paged access for
MDIO_MMD_VEND2 in C22 mode") it is now possible to access all MMD
registers transparently, regardless of whether the PHY is accessed via
C22 or C45 MDIO.

Further improve the translation logic for this register mapping, so a
single unified driver works efficiently with both access methods,
reducing code duplication.

The series also includes cleanup to remove unnecessary paged operations
on registers that aren't actually affected by page selection.

Testing was done on RTL8211F and RTL8221B-VB-CG (the latter in both
C22 and C45 modes).

Changes since initial submission:
 - rebase on top of
   "net: phy: realtek: add dummy PHY driver for RTL8127ATF"
 - improve commit messages

Daniel Golle (5):
  net: phy: realtek: support interrupt also for C22 variants
  net: phy: realtek: simplify C22 reg access via MDIO_MMD_VEND2
  net: phy: realtek: reunify C22 and C45 drivers
  net: phy: realtek: demystify PHYSR register location
  net: phy: realtek: simplify bogus paged operations

 drivers/net/phy/realtek/realtek_main.c | 124 ++++++++++---------------
 1 file changed, 48 insertions(+), 76 deletions(-)

-- 
2.52.0

