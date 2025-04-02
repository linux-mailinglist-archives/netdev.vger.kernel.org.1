Return-Path: <netdev+bounces-178873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12254A793E9
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D661518951A9
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCFB1DD873;
	Wed,  2 Apr 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKaaISuC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805B1C7009
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615554; cv=none; b=o17AtvZOaTchApqSAGemQpKzWx8qrThqPu8a64T6OEiiSbfiA0/NAbTIMGrhACj9ZNZt0rbs5He3MdLL2zKdVonqVj6gEePFdD7cfbAeabJTIaCvqo+rfUkRkwHjkLDRcugIVcPPdylmnXYRfhe8tvWjZDj3mhYt8bpzi942xmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615554; c=relaxed/simple;
	bh=BmfUE+1cp7JX3F9zM99G8wo1T8RwGOgfIVzGZUCpb4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXTBjNWy0m8KcN5eTNxYPRTtdQCQQx9Z9cG5BZLmYqcIbhO49zYdALmiiLZzEhWc4+WtGU+0PBy90JdxWA31jKYZ6ViBkPcepxNCphcBD+SQ1zPFWZsokpuSH06BBMkavFxsApKf8ekoO8VW4mF6/bkbvg9XWdbMRbzsTumoo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKaaISuC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743615553; x=1775151553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BmfUE+1cp7JX3F9zM99G8wo1T8RwGOgfIVzGZUCpb4k=;
  b=WKaaISuCHsny7xk9/iXufoPcB4p9krnmjT1Nf1+mdON1U98WXlN43t9v
   WPVNICDoH85s4fBCTYXfQRj5lpZyTU8qNeJdGe1M+jE7qwlGXy+vo95n2
   NftZYtnX1BZHR11GhuqRZP21QeZq2rWaXxiqy580rYc6bd3Pu/Em2un/h
   r3nRvOO17LB7Uwv0FYv7sJ7gjR6xYW+49iKdGSpr3Pum9J463c44cxtrv
   64e8TIxe/KLMwGhdSM050wtcTICoeEeMLuK1qQrbeuyAEXchAx0/dyDxZ
   U/91gqfSB/ZKwLdTE82Eb4Ejgk+g2PuNiOx5bxgzGXPAOQKGl4e+gXQ+b
   g==;
X-CSE-ConnectionGUID: 6nOwMdkySxWWCaZ2sud4mA==
X-CSE-MsgGUID: uGekJOTJT5Gp/N64bTngiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44257286"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44257286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:39:12 -0700
X-CSE-ConnectionGUID: dMsgWtXvSge4ci8aF85puw==
X-CSE-MsgGUID: TICkSEUsQniF00QkkqK3Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149968798"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 10:39:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <horms@kernel.org>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net 4/5] ixgbe: fix media type detection for E610 device
Date: Wed,  2 Apr 2025 10:38:56 -0700
Message-ID: <20250402173900.1957261-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
References: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index cb07ecd8937d..00935747c8c5 100644
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
2.47.1


