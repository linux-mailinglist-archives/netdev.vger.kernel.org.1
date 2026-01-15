Return-Path: <netdev+bounces-250153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66BD24566
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DFEE3036B84
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82329394474;
	Thu, 15 Jan 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg7sNVcY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8972394472
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478218; cv=none; b=YeHq5D2u2Ayg9ItMKKPHWDwW+d7e7sJ4h5r7tmfpchbAyaGBI4zG+yXXhPNPafT+Of/7YJgO9wGninmUs6WaCnrcDsAq4IsnolF1YWRIL8jiRnKCXxZCy2J4GWEbri1GAnvNHzKR1uccQj3SQWKdmKPHhNpsPGCaebA9pusjJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478218; c=relaxed/simple;
	bh=gbRnHJRY+Fv/hkwkWLkbgMI7yC29lz4bXWa/2WD6XNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg2kxgjHLqeJJCGk9Is07e3smsYynr3XDPiFTgtQV5iCpDaYi0NbVrWfgQatw8Elh5B4QPiHsyXW3YpcclVAwP/PY4Ua4QWvI1ZI++I0yzjTnVvIjHB+lEOqrXWIXjEDBnHaG8H3zqUVORINPLUuh0JZ3XF3d0lkP66/d0WysqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg7sNVcY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768478216; x=1800014216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbRnHJRY+Fv/hkwkWLkbgMI7yC29lz4bXWa/2WD6XNE=;
  b=Vg7sNVcYazMtMZ5pibVtgr+SOHi65DCTP1tiB8nXkWIJ8xVwlv7hGOUB
   OYeUjvL+0GY7h/nWRwSVjo1TKl8PYvdxFNtfPJ1J0TtNYe1BWD8CL23Iq
   Bm534QT8crA7Iy4BF84mzD/qo9QdlHIjuSHGNBRR6YUvxs/qIVnm4Rs9p
   VSvNtV9kdEy5zXJ10eTdZcDyvunsCe9yPTC3BDN3Fu4qkjozZhvE0Rd7L
   bIk8Usag2ge6+dsAVNbkzRJxGRPxJ3ImyhgoNqwcJEJRAI14kKHA/bDlE
   F5O4oY3tkShYp4FPH5jDkiojQnKm1+q8GlMQ6IklfGWbnfEMw7KaZsW5L
   g==;
X-CSE-ConnectionGUID: IFKjnmSNQc+nymfbT/Jhdg==
X-CSE-MsgGUID: 4Xvz5FdRTLuLI/7vaiy8NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="95258933"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="95258933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 03:56:51 -0800
X-CSE-ConnectionGUID: eruWy+KgTsO5abfc3D+LaQ==
X-CSE-MsgGUID: cGt9N415SaO3XM0IFEM5Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209413880"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2026 03:56:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 034129D; Thu, 15 Jan 2026 12:56:47 +0100 (CET)
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
Subject: [PATCH net-next v3 3/4] bonding: 3ad: Add support for SPEED_80000
Date: Thu, 15 Jan 2026 12:56:45 +0100
Message-ID: <20260115115646.328898-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
References: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ethtool SPEED_80000. This is needed to allow
Thunderbolt/USB4 networking driver to be used with the bonding driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/bonding/bond_3ad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1a8de2bf8655..be10d31abe0c 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -72,6 +72,7 @@ enum ad_link_speed_type {
 	AD_LINK_SPEED_40000MBPS,
 	AD_LINK_SPEED_50000MBPS,
 	AD_LINK_SPEED_56000MBPS,
+	AD_LINK_SPEED_80000MBPS,
 	AD_LINK_SPEED_100000MBPS,
 	AD_LINK_SPEED_200000MBPS,
 	AD_LINK_SPEED_400000MBPS,
@@ -297,6 +298,7 @@ static inline int __check_agg_selection_timer(struct port *port)
  *     %AD_LINK_SPEED_40000MBPS
  *     %AD_LINK_SPEED_50000MBPS
  *     %AD_LINK_SPEED_56000MBPS
+ *     %AD_LINK_SPEED_80000MBPS
  *     %AD_LINK_SPEED_100000MBPS
  *     %AD_LINK_SPEED_200000MBPS
  *     %AD_LINK_SPEED_400000MBPS
@@ -365,6 +367,10 @@ static u16 __get_link_speed(struct port *port)
 			speed = AD_LINK_SPEED_56000MBPS;
 			break;
 
+		case SPEED_80000:
+			speed = AD_LINK_SPEED_80000MBPS;
+			break;
+
 		case SPEED_100000:
 			speed = AD_LINK_SPEED_100000MBPS;
 			break;
@@ -816,6 +822,9 @@ static u32 __get_agg_bandwidth(struct aggregator *aggregator)
 		case AD_LINK_SPEED_56000MBPS:
 			bandwidth = nports * 56000;
 			break;
+		case AD_LINK_SPEED_80000MBPS:
+			bandwidth = nports * 80000;
+			break;
 		case AD_LINK_SPEED_100000MBPS:
 			bandwidth = nports * 100000;
 			break;
-- 
2.50.1


