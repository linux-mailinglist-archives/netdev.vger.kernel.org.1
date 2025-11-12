Return-Path: <netdev+bounces-237765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C254AC501A7
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707491897130
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C76B635;
	Wed, 12 Nov 2025 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUTRhoTV"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF749460
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905799; cv=none; b=Woiszk2sDIbyRLNa+iSrOxTIKZ9vSMtO5vZTJ4GIF1d7ZqNBDdUr0jcYIPImKFvfrsTQv1wfgoQKAvaCbQDeC6L8aLD2CxVPVF3yZhqu887D31732CMZVjGVzkdI2Y9Bu4b6q01ikRjaRtdp4udbg8QpmI1Qc8bBANtVZMMKVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905799; c=relaxed/simple;
	bh=5tRwX1ZyBbGLGS0218yZVh6e9ryaGCci+L/zAEZYdmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qdx2mKegGXQSxgWdUBg+TA8gEvwpYHZx4vggRdIQ6k1HnuZsbY+dNF9djuXCV+Q7DGRZElf334qeV2Qx6Psl8csloIWbZTCbONFKaHpy/+Whp8qnLvl+4fUIQKrKaQhNc29zjoEXmav19TcSzs9oitc0jDgTNNqi2MFjUkAKpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUTRhoTV; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762905792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KhkEFcSQrxxs6n0r4G3H04NTx7kGDHcOSt41o3NSJ7w=;
	b=gUTRhoTVvqSL5D+ejvGN/LaTI1/bODZCts6QdGrygi+tCA6SiK0WohLikVQwaW+MGeAeLf
	O1uhSDDiiz0tiJq8c6gukGo4N+PXWY5HusK983tN1T1uOZJ69ZkLjEyerE9ikHMItmc7dw
	05I1ZBkbnjhIikw4OTKl9FWg+DIghF4=
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
Subject: [PATCH net-next 0/8] add hwtstamp_get callback to phy drivers
Date: Wed, 12 Nov 2025 00:02:49 +0000
Message-ID: <20251112000257.1079049-1-vadim.fedorenko@linux.dev>
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

Vadim Fedorenko (8):
  phy: add hwtstamp_get callback to retrieve config
  net: phy: broadcom: add HW timestamp configuration reporting
  net: phy: dp83640: add HW timestamp configuration reporting
  net: phy: micrel: add HW timestamp configuration reporting
  net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
  phy: mscc: add HW timestamp configuration reporting
  net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
  ptp: ptp_ines: add HW timestamp configuration reporting

 drivers/net/phy/bcm-phy-ptp.c       | 21 +++++++++++---
 drivers/net/phy/dp83640.c           | 29 +++++++++++++------
 drivers/net/phy/micrel.c            | 43 +++++++++++++++++++++++------
 drivers/net/phy/microchip_rds_ptp.c | 21 +++++++++++---
 drivers/net/phy/mscc/mscc_ptp.c     | 21 +++++++++++---
 drivers/net/phy/nxp-c45-tja11xx.c   | 22 ++++++++++++---
 drivers/net/phy/phy.c               | 30 ++++++++++++++++----
 drivers/ptp/ptp_ines.c              | 31 ++++++++++++++++++---
 include/linux/mii_timestamper.h     | 13 ++++++---
 include/linux/phy.h                 |  4 +--
 10 files changed, 188 insertions(+), 47 deletions(-)

-- 
2.47.3


