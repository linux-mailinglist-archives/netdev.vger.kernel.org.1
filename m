Return-Path: <netdev+bounces-239970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E7C6EA2C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0D38884E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E82BF3E2;
	Wed, 19 Nov 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L0xLdSFU"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C531ED78
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556492; cv=none; b=YLEBgHIUE+7zHGfSVGK17W4fxRWE/lFESreb9gj2A17yMIsnFRRUmDAOOqRXxAduvQqXxpK4zZQhvDoq2h6F4FGp78TSzEFI2MgxtZ+N1iPWiiWb47HMzcrpHXXc436mcavFqjKyDWWQTSBDUVoNoU3W8D6waE7ZTetEUmGmXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556492; c=relaxed/simple;
	bh=SaHvPNcTSqRlwSFO64ipo74Xg+KQyJSp2hdcjnRFfmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrYgLCFpojuDy+dWnpnNHOp1OYxyc4EbxrxEefIwdmr8uAHcrr1b+D4zbVbc5f1AnThoNlj5GK4u4GovFnFY0D3LYf8DCFsknd8dKxwhzJ8QMHGVsojOfQ5FeI+UGkq8mOmx67lSa8Hw7cYfgJXuguJ1GOZkZe77d8arru/5XDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L0xLdSFU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763556486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JbiEK4XL6AMNu47lhOaINIvpXEjUh1VXid9e++a8ask=;
	b=L0xLdSFUny9Hp7gFMmvEiQm2iznISwQcAe2PvyrCsju+wJ/6WX1tzqKOGUZwDwPtaHsJSj
	5wKED9+5gMjnaE9gKDhhaXLrZwM8R0x5lOpaj9K7gV/6/2iWE7sxrGnrDDRXGx3jjDxk5h
	cl3wC9Q3TYKzIUo1drI/i73L9cZiRKs=
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
Subject: [PATCH net-next v3 0/9] add hwtstamp_get callback to phy drivers
Date: Wed, 19 Nov 2025 12:47:16 +0000
Message-ID: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
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

v2 -> v3:
* remove SIOCGHWTSTAMP in phy_mii_ioctl() as we discourage usage of
  deprecated interface
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
 drivers/net/phy/phy.c                 | 14 ++++++---
 drivers/ptp/ptp_ines.c                | 31 ++++++++++++++++---
 include/linux/mii_timestamper.h       | 13 +++++---
 include/linux/phy.h                   |  4 +--
 11 files changed, 174 insertions(+), 47 deletions(-)

-- 
2.47.3


