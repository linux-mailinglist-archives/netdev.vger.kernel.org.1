Return-Path: <netdev+bounces-240499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D4C75CCE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEE2E354673
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9C128CF66;
	Thu, 20 Nov 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xlqyib/s"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E2287505
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660760; cv=none; b=EuPvEfZlhfqpwIqm2soDR/gYdo8qj5iurq+vFYap3d2HYfuy3yRXW/735eq9NryDf2/T+cIFW7rfboeI1WaFBhW3HvPRPPcQ3H4kQwxn95fwWneahC5g1yRRrUoRQDVaPG2vrK1fauMctlriZCQioiyGQWVQk5ttyDdIecn1EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660760; c=relaxed/simple;
	bh=rYwC5OvBjLf6G5qejXU99TVwtTDAneATWoKPZhZs1YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yq/ouUVnHHgpwogMP7CE2C53L1q9lkkd/pb7ARhvJZwDFHTv6a+uLKg7NNEPNlCyPttZVBqFTxAaaDJMMHKE2FHyDPVMb3iZFQKYNPiBXVc7Mf+XhUm8kUmx9Ymj37sA6AE21HD5Ncp7AEonzbJQzVk2BxrJl/ROW+V2Uq96xXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xlqyib/s; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763660755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y7Mm4Xn7n7DyGyFVr932Ke9Jgw4YsZd9ysXsIK13uVM=;
	b=xlqyib/sez67xxEp4cY4LWIC1O1lyANd6fG9QeIBAG4Nk8HRdrzNvKUofO/JC8tKBM69aC
	+PZkrJeNZOIUGq0LdX1HoxOsiETVJho+/BxjO890lwq+Eo0c3N9OqMqFzgj8FVTknlZx1m
	SMdxvFRW8puiowckV7qJJJ56TEO/x5c=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4 0/7] add hwtstamp_get callback to phy drivers
Date: Thu, 20 Nov 2025 17:45:33 +0000
Message-ID: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PHY drivers are able to configure HW time stamping and are not able to
report configuration back to user space. Add callback to report
configuration like it's done for net_device and add implementation to
the drivers.

v3 -> v4:
* drop patches 5 and 6 from previous version as these drivers need logic
  upgrade to report configuration correctly. I'll send these updates as
  separate patchset
v2 -> v3:
* remove SIOCGHWTSTAMP in phy_mii_ioctl() as we discourage usage of
  deprecated interface
v1 -> v2:
* split the first patch to rename part and add new callback part
* fix netcp driver calling mii_timestamper::hwtstamp

Vadim Fedorenko (7):
  phy: rename hwtstamp callback to hwtstamp_set
  phy: add hwtstamp_get callback to phy drivers
  net: phy: broadcom: add HW timestamp configuration reporting
  net: phy: dp83640: add HW timestamp configuration reporting
  phy: mscc: add HW timestamp configuration reporting
  net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
  ptp: ptp_ines: add HW timestamp configuration reporting

 drivers/net/ethernet/ti/netcp_ethss.c |  2 +-
 drivers/net/phy/bcm-phy-ptp.c         | 21 ++++++++++++++----
 drivers/net/phy/dp83640.c             | 29 ++++++++++++++++++-------
 drivers/net/phy/micrel.c              | 16 +++++++-------
 drivers/net/phy/microchip_rds_ptp.c   |  8 +++----
 drivers/net/phy/mscc/mscc_ptp.c       | 21 ++++++++++++++----
 drivers/net/phy/nxp-c45-tja11xx.c     | 22 +++++++++++++++----
 drivers/net/phy/phy.c                 | 14 ++++++++----
 drivers/ptp/ptp_ines.c                | 31 +++++++++++++++++++++++----
 include/linux/mii_timestamper.h       | 13 +++++++----
 include/linux/phy.h                   |  4 ++--
 11 files changed, 134 insertions(+), 47 deletions(-)

-- 
2.47.3


