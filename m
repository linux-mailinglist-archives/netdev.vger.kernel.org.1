Return-Path: <netdev+bounces-241254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6005C820A0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DA203420B7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CF2C0F91;
	Mon, 24 Nov 2025 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ti8e8joV"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D726561E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007950; cv=none; b=S4hRgNC9Gu5hM0rHsbobyWl4YqU9CQ4fojUnSiJ4WiustNYbXYKdBDwGCPY5eksKzvby/ZBxJkDveLMy5v4Tg1rkTs0GmHfrr78+tlddNfQKhwUrZ58d8LTir08kSsVkbyg5EE8Fal/5L52dx6c8uaqqToAm7LQYYZzfKvon66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007950; c=relaxed/simple;
	bh=gcCgB/fJyJ5VBZrnAlN0JNdCraxRGUTJjeEHzwKHx8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLNlLJ37xj3E5l4duUE1BV0dDdTgpIlVXl+7UV4eBKyBhShClqcQv4o/mJEY3aZscgHJAwnL6fVCA2nGxw2aoDKmKJpzCQnHICjN8fXeoRp9eT0NUEeGydZPzJitH5opXbYaA4QAZ/g2mLoZLacxdvBRJtTPIfKpCq+Ore5UaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ti8e8joV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764007945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rb31vAi4EVLRJ5VKFGevVRiYlTagSdQu+qtEQ21Nhjg=;
	b=Ti8e8joVcyN/JcExaeBW79Y59bIIU8xaJ8+zg5b0XbBoOTAHNklKRbC5ptnQs3+1/nylSM
	vvoQycLhUg/oYjkfZh25pHUTvT92yektB0x+W+Zn560mSVnx7aGcfh7ugzv3zCEQ3X94HN
	Ry66xAXahBNj7wnD5ByXnZFTetNDDAA=
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
Subject: [PATCH net-next v5 0/7] add hwtstamp_get callback to phy drivers
Date: Mon, 24 Nov 2025 18:11:44 +0000
Message-ID: <20251124181151.277256-1-vadim.fedorenko@linux.dev>
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

v4 -> v5:
* adjust comment about dev_get_hwtstamp_phylib() regarding new callback
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
 net/core/dev_ioctl.c                  |  9 ++++----
 12 files changed, 139 insertions(+), 51 deletions(-)

-- 
2.47.3


