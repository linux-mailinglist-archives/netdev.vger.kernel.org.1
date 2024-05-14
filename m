Return-Path: <netdev+bounces-96422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948F8C5B62
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9427B21562
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93B181300;
	Tue, 14 May 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4zn1G+p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FB180A88
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712696; cv=none; b=Pkf1f654XJKdEVhs5Kw2BgNzztyawDtFJODGg8BMbeU9B5k5RNvVN8Nck4YhquYxLdrzK9VCMYUteoy/EIh+xwLn9hV6xEmU2tVJ1impszJZvDWKmqyRDCrNdjvlBYD2IHxD4cq4nC16S+nhH4JGtmNEjuobNS4nYy9mbuYCwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712696; c=relaxed/simple;
	bh=cxSGeqBEj3jGq8L7IdRvbdtaeISt+kkASP3vN+kaCSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+uoF//lt5ngJm7yPE6qXTQiDB3+Fj5qgWpyAanIryUUnh/YWPqpSRWbPvgjnFpFYJ0NUM84qdz5HiSm78p5nRqGTgfs+D22L9qBzh8NIMYjXJDGZfyfw5+VinbVQDpPIdBI+xAljSo2KpqYf/d6OaPkxfOjDKs0u4dZNdQP2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4zn1G+p; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715712695; x=1747248695;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cxSGeqBEj3jGq8L7IdRvbdtaeISt+kkASP3vN+kaCSI=;
  b=b4zn1G+pUPFLJUh7dPOKUNZwSNAg9mpg3L863ogRZU5Or89dWIBDYFf/
   NpU6yfnpKOCpewsvmVIYVjSoGqoVRH8iD4i6/6QwPErn38xPYWDgSeIGr
   TgedWybyoCC9VdKdDYkJWYPIXdDiU1Gqkzyet8T8aAIjhaYKnuXwLHXL8
   7XZgb0RqiIInvrQGcQp9cvbCGHI8Id1uxcLbqzqhgYtfbrBxKfOlwhPG6
   4+bt65SndMqiXHuzj7BKMeQGkgjp02gU+R70OmR6tFBWhVrX6PGknG/T8
   w1mIOVkdrJOhjNpgyToHkDL40pE2XnH2cwEO4CX1YOT7fX2DhEsuVsLR1
   w==;
X-CSE-ConnectionGUID: jPDK+EpXTBu8zRAIYvJfUw==
X-CSE-MsgGUID: RO1MfV8aS7u4CT1S6jRqWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29240329"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29240329"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:51:31 -0700
X-CSE-ConnectionGUID: x7UBrBoXQyqFKkhpn+soTQ==
X-CSE-MsgGUID: x3+cSWNVRPWL8U+mXgnNLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30789940"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:51:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 May 2024 11:51:13 -0700
Subject: [PATCH net 2/2] idpf: Interpret .set_channels() input differently
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-2-eb18d88e30c3@intel.com>
References: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
In-Reply-To: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
To: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, 
 Krishneil Singh <krishneil.k.singh@intel.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

From: Larysa Zaremba <larysa.zaremba@intel.com>

Unlike ice, idpf does not check, if user has requested at least 1 combined
channel. Instead, it relies on a check in the core code. Unfortunately, the
check does not trigger for us because of the hacky .set_channels()
interpretation logic that is not consistent with the core code.

This naturally leads to user being able to trigger a crash with an invalid
input. This is how:

1. ethtool -l <IFNAME> -> combined: 40
2. ethtool -L <IFNAME> rx 0 tx 0
   combined number is not specified, so command becomes {rx_count = 0,
   tx_count = 0, combined_count = 40}.
3. ethnl_set_channels checks, if there is at least 1 RX and 1 TX channel,
   comparing (combined_count + rx_count) and (combined_count + tx_count)
   to zero. Obviously, (40 + 0) is greater than zero, so the core code
   deems the input OK.
4. idpf interprets `rx 0 tx 0` as 0 channels and tries to proceed with such
   configuration.

The issue has to be solved fundamentally, as current logic is also known to
cause AF_XDP problems in ice [0].

Interpret the command in a way that is more consistent with ethtool
manual [1] (--show-channels and --set-channels) and new ice logic.

Considering that in the idpf driver only the difference between RX and TX
queues forms dedicated channels, change the correct way to set number of
channels to:

ethtool -L <IFNAME> combined 10 /* For symmetric queues */
ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */

[0] https://lore.kernel.org/netdev/20240418095857.2827-1-larysa.zaremba@intel.com/
[1] https://man7.org/linux/man-pages/man8/ethtool.8.html

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 986d429d1175..1cf3067a9c31 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -222,14 +222,19 @@ static int idpf_set_channels(struct net_device *netdev,
 			     struct ethtool_channels *ch)
 {
 	struct idpf_vport_config *vport_config;
-	u16 combined, num_txq, num_rxq;
 	unsigned int num_req_tx_q;
 	unsigned int num_req_rx_q;
 	struct idpf_vport *vport;
+	u16 num_txq, num_rxq;
 	struct device *dev;
 	int err = 0;
 	u16 idx;
 
+	if (ch->rx_count && ch->tx_count) {
+		netdev_err(netdev, "Dedicated RX or TX channels cannot be used simultaneously\n");
+		return -EINVAL;
+	}
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
@@ -239,20 +244,6 @@ static int idpf_set_channels(struct net_device *netdev,
 	num_txq = vport_config->user_config.num_req_tx_qs;
 	num_rxq = vport_config->user_config.num_req_rx_qs;
 
-	combined = min(num_txq, num_rxq);
-
-	/* these checks are for cases where user didn't specify a particular
-	 * value on cmd line but we get non-zero value anyway via
-	 * get_channels(); look at ethtool.c in ethtool repository (the user
-	 * space part), particularly, do_schannels() routine
-	 */
-	if (ch->combined_count == combined)
-		ch->combined_count = 0;
-	if (ch->combined_count && ch->rx_count == num_rxq - combined)
-		ch->rx_count = 0;
-	if (ch->combined_count && ch->tx_count == num_txq - combined)
-		ch->tx_count = 0;
-
 	num_req_tx_q = ch->combined_count + ch->tx_count;
 	num_req_rx_q = ch->combined_count + ch->rx_count;
 

-- 
2.44.0.53.g0f9d4d28b7e6


