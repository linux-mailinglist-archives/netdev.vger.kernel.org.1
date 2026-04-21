Return-Path: <netdev+bounces-279962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I00Ml/K5ml40wEAu9opvQ
	(envelope-from <netdev+bounces-279962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEF4352CC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4732C301C110
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A921D5B0;
	Tue, 21 Apr 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YG9rl+c0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EE1E834E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732731; cv=none; b=g5P11GYGed+S/mw7efDRzuEq1pN+uIjQKNWHTCulcwIqqBSM7/5M1EZqmNHGSM+MTtlOYr+LzLNAzt5xINVrkE/XNwl0PoMdW3C5TIFwQHOuIPoNJ5PSYrSx2dqorCBc4ZFpppkSpv0adu9EsoIkiOhGRG9ngM+yrnMfkWY7MXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732731; c=relaxed/simple;
	bh=2HDDykfOVz5+JUDBOpj24iWID3LD3kudKCJdb9kn70A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgODc8DWX3QjiGWhPzIA/7csD9kCMby/vQAPCxP5MEO5lTp5c+XLCn4jGu5IOqR4JQzsgrlFwyaJh1yNtEK/BMh9e9V73rsQQHXyraxP4GIZTvBotsPfoYAKPgupGC33k36taN6P2QEDPRu5vYzycpuHAdUe55Uj/TWFqZZV+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YG9rl+c0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776732729; x=1808268729;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2HDDykfOVz5+JUDBOpj24iWID3LD3kudKCJdb9kn70A=;
  b=YG9rl+c0znsbl/TCQgWxla+OXiTkKmbh6IOWXUhkBfdAhNhmTQb7h5Il
   CkhjAW7x+ZzYFdq4PI+BPvrey+3U//m2Auz4GKKV1feRSW0C9j6+aXOIN
   BEm4s/IMHwR+PXtubiCFKdtdw+g7MVMntT7WTXONFeYN/hMDBjXRk/oyz
   ijeJxjrZLiF3is+7QExtNZnVI4FXUK10c/P5fwTp8MwKAv4ivDa7ehHa7
   oTnFOkP97T9WgTgiG70AAZ6Uj2PT9zQF7aNJfXqF6Z8kRCfRJ0LeAV8WW
   S1ecPhKvjKOqu7gbT7j55BwTJxmsKqGk9g/cHwLBnOg7rdtqGIGGGZvfV
   A==;
X-CSE-ConnectionGUID: 20QEMLHiSV6yGaFF5DGMPQ==
X-CSE-MsgGUID: ecVrgq0ZQ7OzVc5t04ikWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77530414"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77530414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
X-CSE-ConnectionGUID: dqVVIsp7QyCPAUoZpBoehQ==
X-CSE-MsgGUID: EpuYr1lpQdmhiUZ7S+QDBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235886671"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:52:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 20 Apr 2026 17:51:28 -0700
Subject: [PATCH net 4/4] ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-4-bc2240f42251@intel.com>
References: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
In-Reply-To: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Petr Oros <poros@redhat.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=2HDDykfOVz5+JUDBOpj24iWID3LD3kudKCJdb9kn70A=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxnp0zW7eiQLJrr99qnqeTq3NUXflhE/n01Y/8BtfV3r
 Qp36s582lHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBE1FkY/hdf2yX44JvXew37
 Nwn1D2+d/pJ58uIb2c+nf9pxi4r2WDUyMpzr36B5cIOZsqbXiS/qB9We6MVtfrD1tPQvwVjHBFu
 /NFYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-279962-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34EEF4352CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ice_ptp_read_tx_hwtstamp_status_eth56g function calls
ice_read_phy_eth56g with a PHY index. However the function actually expects
a port index. This causes the function to read the wrong PHY_PTP_INT_STATUS
registers, and effectively makes the status wrong for the second set of
ports from 4 to 7.

The ice_read_phy_eth56g function uses the provided port index to determine
which PHY device to read. We could refactor the entire chain to take a PHY
index, but this would impact many code sites. Instead, multiply the PHY
index by the number of ports, so that we read from the first port of each
PHY.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 4795af06b983..24fb7a3e14d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2219,13 +2219,19 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
 	*ts_status = 0;
 
 	for (phy = 0; phy < params->num_phys; phy++) {
+		u8 port;
 		int err;
 
-		err = ice_read_phy_eth56g(hw, phy, PHY_PTP_INT_STATUS, &status);
+		/* ice_read_phy_eth56g expects a port index, so use the first
+		 * port of the PHY
+		 */
+		port = phy * hw->ptp.ports_per_phy;
+
+		err = ice_read_phy_eth56g(hw, port, PHY_PTP_INT_STATUS, &status);
 		if (err)
 			return err;
 
-		*ts_status |= (status & mask) << (phy * hw->ptp.ports_per_phy);
+		*ts_status |= (status & mask) << port;
 	}
 
 	ice_debug(hw, ICE_DBG_PTP, "PHY interrupt err: %x\n", *ts_status);

-- 
2.54.0.rc2.531.gaf818d63126a


