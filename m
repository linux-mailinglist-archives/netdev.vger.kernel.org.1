Return-Path: <netdev+bounces-78066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C15873FB1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149671C22215
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA341428F1;
	Wed,  6 Mar 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBSz6OvO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F5153BCF
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749590; cv=none; b=a/poyWLUq6CtgY8wcH9QPMLqAGSAI1VM7+7CLjjuLNpFFhbV5wL2pKiaiIxzZvqF+trAdq9ssqA6yVRzzp5st1Y9RWx7JvLjYGEJCb18w2DTwludHrgqEzZw+O3jCkj7GctzBwI6lNYp6gsDp7yPD7SUCN5UEKrTmAsavxfc+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749590; c=relaxed/simple;
	bh=swoU079xjZQ86tZYyfvKDivFWD5rbGTMthj8hdtK1Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2ST/2ZbYmNED0daGKgdxHNoBu6LRDBNuDkaAw03edQJJhbm7jvBH7NXdmhOJGDENCxTRIF3u2qS3/zkqv6XFhkB4JEcd6Tx/wOAbDuQcWojRJBVwXa5TmoL3faB1XUlJr0TGO7yDDM2J+IJ4fnMwP/1QpcJ8bOSOxni51SLV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBSz6OvO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709749588; x=1741285588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=swoU079xjZQ86tZYyfvKDivFWD5rbGTMthj8hdtK1Jw=;
  b=RBSz6OvOqOvvYX8cUEfWp+1qH+kFktMJew8wnI7X4rpRyPrLX9IHTgSM
   +eQ0ZNsQ/qa7mirNbnvBv9M6tLHLaw0EfTzEUZFn9uoYCTFFA+iY5Q83M
   omO38rZuWzsokvZg7uuu8wiH1qcOfjHG7pC0ZUCA2sz80ZfxQqiZeqaF8
   3Sdj0A6WaAtRPqYAp29UPEUoKuRrNF7A8LIlS2j0S0jG76fXFrL/fA3Ug
   mkDUiAiZbmHE0Vo/n+uZGbaT57aHLSrfcDTnX0i58WzMZC1MiTDWcFn+D
   th3s9Srw2g/h32Qxf/2WNn0/+8ll3N0W7StpQNxCIe41+aF9GYVhtQJJ4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14957998"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14957998"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 10:26:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9926492"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 10:26:24 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>,
	Christian Rohmann <christian.rohmann@inovex.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/3] ice: fix stats being updated by way too large values
Date: Wed,  6 Mar 2024 10:26:14 -0800
Message-ID: <20240306182617.625932-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306182617.625932-1-anthony.l.nguyen@intel.com>
References: <20240306182617.625932-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Simplify stats accumulation logic to fix the case where we don't take
previous stat value into account, we should always respect it.

Main netdev stats of our PF (Tx/Rx packets/bytes) were reported orders of
magnitude too big during OpenStack reconfiguration events, possibly other
reconfiguration cases too.

The regression was reported to be between 6.1 and 6.2, so I was almost
certain that on of the two "preserve stats over reset" commits were the
culprit. While reading the code, it was found that in some cases we will
increase the stats by arbitrarily large number (thanks to ignoring "-prev"
part of condition, after zeroing it).

Note that this fixes also the case where we were around limits of u64, but
that was not the regression reported.

Full disclosure: I remember suggesting this particular piece of code to
Ben a few years ago, so blame on me.

Fixes: 2fd5e433cd26 ("ice: Accumulate HW and Netdev statistics over reset")
Reported-by: Nebojsa Stevanovic <nebojsa.stevanovic@gcore.com>
Link: https://lore.kernel.org/intel-wired-lan/VI1PR02MB439744DEDAA7B59B9A2833FE912EA@VI1PR02MB4397.eurprd02.prod.outlook.com
Reported-by: Christian Rohmann <christian.rohmann@inovex.de>
Link: https://lore.kernel.org/intel-wired-lan/f38a6ca4-af05-48b1-a3e6-17ef2054e525@inovex.de
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index df6a68ab747e..6d256dbcb77d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6737,6 +6737,7 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 {
 	struct rtnl_link_stats64 *net_stats, *stats_prev;
 	struct rtnl_link_stats64 *vsi_stats;
+	struct ice_pf *pf = vsi->back;
 	u64 pkts, bytes;
 	int i;
 
@@ -6782,21 +6783,18 @@ static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
 	net_stats = &vsi->net_stats;
 	stats_prev = &vsi->net_stats_prev;
 
-	/* clear prev counters after reset */
-	if (vsi_stats->tx_packets < stats_prev->tx_packets ||
-	    vsi_stats->rx_packets < stats_prev->rx_packets) {
-		stats_prev->tx_packets = 0;
-		stats_prev->tx_bytes = 0;
-		stats_prev->rx_packets = 0;
-		stats_prev->rx_bytes = 0;
+	/* Update netdev counters, but keep in mind that values could start at
+	 * random value after PF reset. And as we increase the reported stat by
+	 * diff of Prev-Cur, we need to be sure that Prev is valid. If it's not,
+	 * let's skip this round.
+	 */
+	if (likely(pf->stat_prev_loaded)) {
+		net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
+		net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
+		net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
+		net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
 	}
 
-	/* update netdev counters */
-	net_stats->tx_packets += vsi_stats->tx_packets - stats_prev->tx_packets;
-	net_stats->tx_bytes += vsi_stats->tx_bytes - stats_prev->tx_bytes;
-	net_stats->rx_packets += vsi_stats->rx_packets - stats_prev->rx_packets;
-	net_stats->rx_bytes += vsi_stats->rx_bytes - stats_prev->rx_bytes;
-
 	stats_prev->tx_packets = vsi_stats->tx_packets;
 	stats_prev->tx_bytes = vsi_stats->tx_bytes;
 	stats_prev->rx_packets = vsi_stats->rx_packets;
-- 
2.41.0


