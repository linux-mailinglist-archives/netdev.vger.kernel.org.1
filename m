Return-Path: <netdev+bounces-276683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK/JOYCo1ml9GwgAu9opvQ
	(envelope-from <netdev+bounces-276683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE2E3C28D1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626D23211178
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0DA3624B2;
	Wed,  8 Apr 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTTXaxbN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AB3B19A3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674052; cv=none; b=idOAM3eiIviRTaj0+3WQjwdGid+dbkM08xjJ5VNvXcKCtfnnbRu02v4cp4E6kzS+FB9WRj+jY5kCSnv0aMD7k/k8HU/wl0UnksvG0cZyP6MF0XU28CXsjh1YKo7MhXHOh6lD61UC4zJ8Wk/JbO1Kj3rQJFSq6v/Nu0eNoTnJttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674052; c=relaxed/simple;
	bh=R6AxwX9GU8IMz9cc9hHesk4hswO49vClh2NXD0wCyaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgXoO71ng8DFiBjy8KpbED4L8U71RBSq71cWJoQoee8Uk1WCHkFfaSuSSZC3AXqzGe02t93yC7OktiQbWWpjwuRFG5VceY0JXt0i4Cxx0SVFobdKiGWDHQvVXQwAD/sMp0D7AThz1OyKfTAop4YLzlvtf8me8xCPCiyelUOWzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTTXaxbN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775674050; x=1807210050;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R6AxwX9GU8IMz9cc9hHesk4hswO49vClh2NXD0wCyaU=;
  b=cTTXaxbNC8AzQUu2bUTcTDupHG3Q5nUZM4wckBo0gj/nB1Xt1IbDoEs6
   G+0RBsfO9melaM85kgNQE/3Z7HrJw+efaposUY8jKj+cfTHhVsL3rb1Qu
   Om/kNxdKaEIKEkQiBiNlCddyNe5dF7prWwcq9ITB3abAeY8gJtYWBh0Cf
   noq8ry2sUthCA9GTg6xdpM6QL9W7xaD/fMonOLFv6CdVaNc71riEwW7lz
   RyUNBUatPeZHrzq8YWD/JbWtFR4kG/vRk8MUyY9ATwwWs0/mI6FGCn1hS
   yEnfuZBbPFxVpA8m90kzoxMlJ2maex2ZBvPfD+HJlWzsxTY+9MlhNwsrJ
   Q==;
X-CSE-ConnectionGUID: mkggA0o2QHyM/KogPZbfGg==
X-CSE-MsgGUID: xiULt5UITGiSHiMBvJMLCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75841381"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75841381"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:28 -0700
X-CSE-ConnectionGUID: 8hAv3SWVTB6eEHvfPYVAnA==
X-CSE-MsgGUID: clAReoAlSWaVf9ZvYM4epA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230217570"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:27 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 08 Apr 2026 11:46:34 -0700
Subject: [PATCH iwl-net 4/4] ice: fix
 ice_ptp_read_tx_hwtstamp_status_eth56g
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-jk-even-more-e825c-fixes-v1-4-b959da91a81f@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-306a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=R6AxwX9GU8IMz9cc9hHesk4hswO49vClh2NXD0wCyaU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxri/Y+bSrduCnDdYNNGJPPVBP12JaMpDUuKV9mhBSf5
 lS/e6Gmo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIncn87wiyl3veh+2e1PH3JP
 NFr6wmrN072BHdc+fVv19YBH3oOvmr8YGd6s//mjPfNjgKXMGqG9XYfnMcSslPmd8VlFflkDC3N
 EECcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276683-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 4CE2E3C28D1
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
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 64ad5ed5c688..672218e5d1f9 100644
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
2.53.0.1066.g1eceb487f285


