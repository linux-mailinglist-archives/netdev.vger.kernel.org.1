Return-Path: <netdev+bounces-168610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E1A3F978
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1448316626C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CC1DB958;
	Fri, 21 Feb 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddtQf4ko"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DF1DB366
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152965; cv=none; b=ayDN4X3+kw67qUTkWxGEsbXgtiowzZSuPSfrebaZjQ6XYqNfA3DAc2ZfO6wEVlheNTjIWEJNWyNuZFNKSlMgD0IvRs7Bh4bIhsVATlu8RNKEC/F6Mv6y8feH0wC5+OWNj1vify8Yu2h+SaZ5FtIO/dF2OhzeIxRHdlqeeuQue1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152965; c=relaxed/simple;
	bh=Safi/ZaRImAt4ByykRE6KlGbcE2+yBZJn6XUR51YY70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EoVo24Sbwy9IzpZGbAGiW3RUqlSf8JfRr5pDYCgW/gYtxPoqkVAwmLF4QRQjyYCeSgZfcEHVi3oK6okMtE6mdCC0P8jcYntIqfWkXO1W7T4COOOdblrEp94Hiyg8xpWKYfn488SZNI+vwPuRqBG/afrVT+VOkP+w4ScBJydj0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddtQf4ko; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740152964; x=1771688964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Safi/ZaRImAt4ByykRE6KlGbcE2+yBZJn6XUR51YY70=;
  b=ddtQf4koXIUIOtSZldkDJBWVbG+grJQvsU8lA6t+BrI/+21YRAs1DaDG
   vWzcW7SPCwEzCxY2R3hRx+jwWyGRkU/MJsFTvhkFWTdwim+aGJ7tt/NHX
   vt80PyJogroA35p9gvUrxUK6PVI4VTQbT47P19LbEqtLg6L3YxjiyORB5
   1r1aINMiqa/pDgNyOuJUqYB92iI+FMBhmWLtTsbtIbGISbivS7gYQQVCb
   P8R15ULMYtAukZWW9kC013T5l0vI+YJ8ssu7zADsA8w6FOS3xKraawF/4
   U0JnSgBe3Zfpj81m9jffFcaeAsaVIFcwxM88bph2g9EVd/HiRiCosLPhA
   A==;
X-CSE-ConnectionGUID: QrfjYbDJRhOnP51Y3MpzhA==
X-CSE-MsgGUID: mmiCS+W1TImHGCCX5StQaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="28568988"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="28568988"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 07:49:23 -0800
X-CSE-ConnectionGUID: HYrdzkobSkC8CkxPmeC3sg==
X-CSE-MsgGUID: Z9anu8g5TTOG9gVQOHA3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120503049"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.119.85])
  by fmviesa004.fm.intel.com with ESMTP; 21 Feb 2025 07:49:21 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	andrew@lunn.ch,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3] ixgbe: fix media type detection for E610 device
Date: Fri, 21 Feb 2025 16:49:17 +0100
Message-ID: <20250221154917.3710-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
device") introduced incorrect media type detection for E610 device. It
reproduces when advertised speed is modified after driver reload. Clear
the previous outdated PHY type high value.

Reproduction steps:
modprobe ixgbe
ethtool -s eth0 advertise 0x1000000000000
modprobe -r ixgbe
modprobe ixgbe
ethtool -s eth0 advertise 0x1000000000000
Result before the fix:
netlink error: link settings update failed
netlink error: Invalid argument
Result after the fix:
No output error

Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
v1 -> v2
  More commit message details and reproduction steps added
v2 -> v3
  More details in reproduction steps added
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668..0dfefd2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1453,9 +1453,11 @@ enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
 			hw->link.link_info.phy_type_low = 0;
 		} else {
 			highest_bit = fls64(le64_to_cpu(pcaps.phy_type_low));
-			if (highest_bit)
+			if (highest_bit) {
 				hw->link.link_info.phy_type_low =
 					BIT_ULL(highest_bit - 1);
+				hw->link.link_info.phy_type_high = 0;
+			}
 		}
 	}
 
-- 
2.43.0


