Return-Path: <netdev+bounces-144621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C19C7F16
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7206CB25C58
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBC4A03;
	Thu, 14 Nov 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHovBmWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A31FC3
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542481; cv=none; b=iJVw+vD2bq98JqNzasPp92OTvXKgI5s35kYRYVPlelpseEpGcfKx5DQ/S4yqJ1Fu5LXMUf2p4mQQhnzYud6kIC5uo3FcyeWCBQ3Bpxj4nYVQHiYDV4/MMparFWRoOoDme6BePsxCqRJhuaMGNSEOPOxQPg9NVKropeyinZ76+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542481; c=relaxed/simple;
	bh=HKamdRiWqWCrVoRSRelcMfN7MdgNyDW0mo0UCMcnhYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+So9LrW4wnNRvXv4EbcbyV1qPUUJjJsVSeYGIizJY6lITmRwmlbnFCCwEzqIEL5OM7aB56HP62DcJgOirgI20bxNOQ55O/Z4964w0/47wM7XKEcpdJe5kItVgbtvzbxjEyg+6X+HqhNDIBjAfABpnM5XJDd488qlbCOYuXuy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHovBmWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354B1C4CEC3;
	Thu, 14 Nov 2024 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731542481;
	bh=HKamdRiWqWCrVoRSRelcMfN7MdgNyDW0mo0UCMcnhYc=;
	h=From:To:Cc:Subject:Date:From;
	b=KHovBmWiBERwvVU8bpPi+o9nLADpZwYM3uNpyMuZQezNPoO+vw/PRqMSQ85SWxDOQ
	 i5iQEsNvVhgSfnkFHNpFmftQg8juxMniRcN2a8anx9cztuqF7/itrVPjOO24OsqMsx
	 WkMPdQf43CjjsAjjrlpzZnIsnLuTW0zPjM8toBlXPdjcK1IAlCW873YG6F8D1sOzss
	 IMK8FbTvPf9eDdHK9V/Jjj451UZZ51e0mUgJA0+W3WgeBayBnxxKGhcYTvZ7DwKJdc
	 NGcL6UcXZYBQdEMdkQQz4nBRW2zKtD5WY2AZOF4E8GZA7WNsORVHYuufKx6i7lXC4X
	 +BSmnIfmpRKpw==
From: jbrandeb@kernel.org
To: netdev@vger.kernel.org
Cc: jbrandeburg@cloudflare.com,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v1] ice: do not reserve resources for RDMA when disabled
Date: Wed, 13 Nov 2024 16:00:56 -0800
Message-Id: <20241114000105.703740-1-jbrandeb@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jbrandeb@kernel.org>

If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
built-in, then don't let the driver reserve resources for RDMA.

Do this by avoiding enabling the capability when scanning hardware
capabilities.

Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
CC: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Jesse Brandeburg <jbrandeb@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 009716a12a26..70be07ad2c10 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2174,7 +2174,8 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 			  caps->nvm_unified_update);
 		break;
 	case ICE_AQC_CAPS_RDMA:
-		caps->rdma = (number == 1);
+		if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
+			caps->rdma = (number == 1);
 		ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix, caps->rdma);
 		break;
 	case ICE_AQC_CAPS_MAX_MTU:

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.39.5


