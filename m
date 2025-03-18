Return-Path: <netdev+bounces-175825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF570A67908
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92793A89D3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BD211297;
	Tue, 18 Mar 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1PIDqEn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D12101B7;
	Tue, 18 Mar 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314634; cv=none; b=ZkX+VEcClOHpSgeIlzv5eHqsALWdRYJt9v6D9UTkauPDLweWNaQrtS+8Kh2i5rC8XbzRwmV9foq5u0E10N+Q73YMmGqzr/QpeNEIDpYYfBbvLauYCtClJqUOVnOo7ohsmvykmQ2l0ZW+3SwlerBAUNPb0SLhwThJUlHxy3ujunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314634; c=relaxed/simple;
	bh=hdS9NAAZxadi41eXgAHCNMGLgjlbyYDSiWT7uvu0xNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YumCwSx/Nf8db5YWdXXPel6jS87/1bmO9zHVEF+c3ZT0hnYQ+njLJNRFrO7oqHWq6PTEDgNEDYcJCFHwOvkcgVSFISPNNPPaZP2YO0RxCmbOdHjNXw+JUXaAbyWvt/OLPEyOGAyQwdDvIx9Dh2OELJ10MVotVqVy1/2K4LipZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1PIDqEn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742314629; x=1773850629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hdS9NAAZxadi41eXgAHCNMGLgjlbyYDSiWT7uvu0xNU=;
  b=c1PIDqEn60vTP871jPxSLnA6SP7f+HUXsq4ubBEFxSLVLBGMa19Jf8Fo
   cZbRNtvcUGA6IhZPY1Ql8rGYlRdDSLy0iEvobTOBFlX8arTwmG78zXhtQ
   4c3SH1QE5a3l+jrFBMLxguiZ/O3yqdE26SXi1mX3ww5ArRU1VVSMuQPJA
   0z6Hmn7YHYcyvMs98l8k1QA4MLh+MDroSW5s4EOK2jczkGTB5hIlvSdir
   jMygfk3P1s4V/GzrkpHiALuSACLRyBIPyxZ/+RHEwVfhhnWUkuOZpGNI5
   5HmIolOKhKzwsPSQija9Ckx5bA+4z2Qmts72WdxzXgM+AIIrSGKr1UCha
   w==;
X-CSE-ConnectionGUID: GQhMJRx0QmGi+YBAtKH61g==
X-CSE-MsgGUID: d5guFJNMTAmCr2q9ryAvqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="65928729"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="65928729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:17:07 -0700
X-CSE-ConnectionGUID: XtqxnmIQQM2xfDleGLPMzg==
X-CSE-MsgGUID: sVLGjTkBQN2qHYajXEea1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="159465466"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 18 Mar 2025 09:17:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C063D1D7; Tue, 18 Mar 2025 18:17:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v1 1/1] net: usb: asix: ax88772: Increase phy_name size
Date: Tue, 18 Mar 2025 18:17:02 +0200
Message-ID: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC compiler (Debian 14.2.0-17) is not happy about printing
into a short buffer (when build with `make W=1`):

 drivers/net/usb/ax88172a.c: In function ‘ax88172a_reset’:
 include/linux/phy.h:312:20: error: ‘%s’ directive output may be truncated writing up to 60 bytes into a region of size 20 [-Werror=format-truncation=]

Indeed, the buffer size is chosen based on some assumptions, while
in general the assigned name might not fit. Increase the buffer to
cover maximum length of the parameters. With that, change snprintf()
to use sizeof() instead of hard coded number.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/usb/ax88172a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index e47bb125048d..7844eb02a4c7 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -18,7 +18,7 @@
 struct ax88172a_private {
 	struct mii_bus *mdio;
 	struct phy_device *phydev;
-	char phy_name[20];
+	char phy_name[MII_BUS_ID_SIZE + 5];
 	u16 phy_addr;
 	u16 oldmode;
 	int use_embdphy;
@@ -308,7 +308,7 @@ static int ax88172a_reset(struct usbnet *dev)
 		   rx_ctl);
 
 	/* Connect to PHY */
-	snprintf(priv->phy_name, 20, PHY_ID_FMT,
+	snprintf(priv->phy_name, sizeof(priv->phy_name), PHY_ID_FMT,
 		 priv->mdio->id, priv->phy_addr);
 
 	priv->phydev = phy_connect(dev->net, priv->phy_name,
-- 
2.47.2


