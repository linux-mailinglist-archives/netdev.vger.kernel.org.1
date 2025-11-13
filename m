Return-Path: <netdev+bounces-238309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E8C5737E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C66CC3487DE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3742E54A8;
	Thu, 13 Nov 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y3q0HRWA"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CE2ECEA5
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033554; cv=none; b=Wx/PN3PnOAvsD874vWQLPqbuVxlQwLYcepzdFqb7SfUPjngWZNEG4cGmshDJHnToEU8F+lfidXJc/o1P5J+2wQGDMiZY044dPAKYMrXAN871WR0zTHJN0IYDWWqx0PKZZD9Lodx4hWSmX2XTESVhy5kyHl2CvMt6yIXfpnbu4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033554; c=relaxed/simple;
	bh=JMes4RrBKdm4zWfzmg6Nnde2pKOC0FwHeIADX9/kpvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtYYQToLh7Gxhu1+YSIpkuhzQdz3Jk9H9D1AjAgoW6imQlA0RgAtvSL4DNBF2+sq1tj8j3crcq6rjF8QnrB22OsTOjofSUk5ZmyhEPQ9++kshvYR4Z0Gw/a4nGkCSP2/+bKYOY9V7gRX5ywe+/igBNKqFQKU/nfxtCr3tW0AZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y3q0HRWA; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763033549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=La9Yz3kDvB+tRnb0Bii3AbDAY8ZVSejqP62xWZgIuxI=;
	b=Y3q0HRWAxbrrOAAXPxOv6gSDPAUe1pBDZh4CeJFFkumLt2+LFu+zKAYPVuQzEpVBSj2J5/
	D5zqa+Sh+MBXCzBcAx56fynTZE6Wca42FsRz1reEi85fwMlubOwI8y7BU2+tkLFzYDvZip
	ACIBihZtdzoxRbjBblkWKdFizsl/vXc=
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
Subject: [PATCH net-next v2 0/9] add hwtstamp_get callback to phy drivers
Date: Thu, 13 Nov 2025 11:31:58 +0000
Message-ID: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
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

v1 -> v2:
* split the first patch to rename part and add new callback part
* fix netcp driver calling mii_timestamper::hwtstamp

Vadim Fedorenko (9):
  phy: rename hwtstamp callback to hwtstamp_set
  phy: add hwtstamp_get callback to phy drivers
  net: phy: broadcom: add HW timestamp configuration reporting
  net: phy: dp83640: add HW timestamp configuration reporting
  net: phy: micrel: add HW timestamp configuration reporting
  net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
  phy: mscc: add HW timestamp configuration reporting
  net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
  ptp: ptp_ines: add HW timestamp configuration reporting

 drivers/net/ethernet/ti/netcp_ethss.c |  2 +-
 drivers/net/phy/bcm-phy-ptp.c         | 21 ++++++++++---
 drivers/net/phy/dp83640.c             | 29 +++++++++++++-----
 drivers/net/phy/micrel.c              | 43 ++++++++++++++++++++++-----
 drivers/net/phy/microchip_rds_ptp.c   | 21 ++++++++++---
 drivers/net/phy/mscc/mscc_ptp.c       | 21 ++++++++++---
 drivers/net/phy/nxp-c45-tja11xx.c     | 22 +++++++++++---
 drivers/net/phy/phy.c                 | 31 +++++++++++++++----
 drivers/ptp/ptp_ines.c                | 31 ++++++++++++++++---
 include/linux/mii_timestamper.h       | 13 +++++---
 include/linux/phy.h                   |  4 +--
 11 files changed, 190 insertions(+), 48 deletions(-)

-- 
2.47.3


