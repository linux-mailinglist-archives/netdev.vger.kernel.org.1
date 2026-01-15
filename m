Return-Path: <netdev+bounces-250154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B609D24563
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B743F3018364
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD25394478;
	Thu, 15 Jan 2026 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IafE6CjI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BD393DD4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478219; cv=none; b=lEd6ST6oYvkFcNPuxxHUhiQjLSk2YS0tDRTQtq/7kK+MQphntME7aV49Z64GEK94urEBwP2JMs4HPmzsFtlKAmDlmRJ8OxoN13QrXByb1/jmY3zowUPHF7OmpDY9AP8S0Fno/pobbudyYj9mO0NCtOgPc/YCdAIHgaVPxgHItIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478219; c=relaxed/simple;
	bh=9Ram+zm+a/I03dQdDMtdGiHtetxs4RlEtSjVj+5A1gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSj3zwKisMiGsaIzO1u3nc5zsjH9XWxoOUvb0LS0W2GrMeQDCAYj0MQNzL1YNxHaUTWVEmlr6jz6CD9z5z0jLlgfZxht31IZgoF/m22x8RfXpVEgJ/3R2Z4FPysaaJkJ5cqeMMKst9zGAuyqysnGpRXIoah1w12VC4kRBVGoetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IafE6CjI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768478217; x=1800014217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Ram+zm+a/I03dQdDMtdGiHtetxs4RlEtSjVj+5A1gE=;
  b=IafE6CjIiLvjQrdhK41htjs6VJT/4GNTnz0mHro0yMNFPR3jSnLKWIP5
   boyJiVlsiK1uy/qJpWtUeJ37rInnZaQr/xkW0B12g+CQNVKH6kON8Wwm7
   ELZU2TI0kwba+bxw40TgtOt9LTU5NDPyQcDvzHWwBVfoT30GljWFOz9QA
   AOdub59qVLCEkbgeK+raGAJas6lKXIHsrodKBU5CqYFBn3xb2j6QVjsSp
   IAuDCrqeH7u4BhZf8rvJfhkrA1CFrDg5/Vo7QXSW99mrwOjkp/296SDD0
   MwQRnCL7z/0zqUhPvNLRnWGFd955gaSFsKAPYnm95p5M10NYP1RHEFreb
   w==;
X-CSE-ConnectionGUID: BnxA2VoPSZe5c0xE701M9g==
X-CSE-MsgGUID: W3GeB00hQ+utU/eXdsKFWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80503310"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="80503310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:56:52 -0800
X-CSE-ConnectionGUID: Aczuku30QweCUDg76X7DZg==
X-CSE-MsgGUID: u17iqXRlS8GlGq8xMBK5pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204078624"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2026 03:56:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id EE3AB98; Thu, 15 Jan 2026 12:56:46 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Ian MacDonald <ian@netstatz.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next v3 0/4] net: thunderbolt: Various improvements
Date: Thu, 15 Jan 2026 12:56:42 +0100
Message-ID: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series improves the Thunderbolt networking driver so that it should
work with the bonding driver.

The discussion that started this patch series can be read below:

  https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/

The previous version of the series can be seen here:

  v2: https://lore.kernel.org/netdev/20260109122606.3586895-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/netdev/20251127131521.2580237-1-mika.westerberg@linux.intel.com/

Changes from v2:
  - Drop the patch that allows changing MTU. It is not necessary as we fill
    in the min/max_mtu already.
  - Updated code under drivers/net/phy/ to deal with the new SPEED_80000.
  - Updated bond_3ad.c::__get_agg_bandwidth() with the new speed as well.
  - Added review tags from Andrew.

Changes from v1:
  - Add SPEED_80000
  - Add support for SPEED_80000 for ethtool and 3ad bonding driver
  - Use SPEED_80000 with the USB4 v2 symmetric link
  - Fill blank for supported and advertising.

Ian MacDonald (1):
  net: thunderbolt: Allow reading link settings

Mika Westerberg (3):
  net: thunderbolt: Allow changing MAC address of the device
  net: ethtool: Add support for 80Gbps speed
  bonding: 3ad: Add support for SPEED_80000

 drivers/net/bonding/bond_3ad.c |  9 ++++++
 drivers/net/phy/phy-caps.h     |  1 +
 drivers/net/phy/phy-core.c     |  2 ++
 drivers/net/phy/phy_caps.c     |  2 ++
 drivers/net/phy/phylink.c      |  1 +
 drivers/net/thunderbolt/main.c | 53 ++++++++++++++++++++++++++++++++++
 include/linux/phylink.h        |  7 +++--
 include/uapi/linux/ethtool.h   |  1 +
 8 files changed, 73 insertions(+), 3 deletions(-)

-- 
2.50.1


