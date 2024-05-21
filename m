Return-Path: <netdev+bounces-97399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1758CB454
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C4328228E
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5511494B9;
	Tue, 21 May 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjtL5iGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9214884F
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320401; cv=none; b=P9/8KcrOKd8tcgkV5s8aT6k62csxBXx0zpvoRhC1mr+odr8JqlxjIGRA8UFeWTL6GIyaQtCGl7GKmUxzRfEVgvdmarjL6nA4Va9YDVsqzT8ZdMFGjFNQu0CWfj7UQlpnhBOD0RvBAcfN5NpCf5h/lpHczQIRD3kCLQVBhKYS+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320401; c=relaxed/simple;
	bh=/awOTccWQ0TJJdl01vhIbrzasMGO9q1zGJQkyvByLNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtjLfdpWgeTYF7NuuQf2CAdClOO38cMQpGQEtV64BKB0/yZLPT5B2dCqI799GfAjLgOnA6ajYXu4/gUHGbRb/8NgyHjzLVQ2Ii2vgrlZeA8ok9Vs2WJpamyvFA4RN2Gz5v9LeG8Hlp5rD4e13TzEBwZ0wNUULnZo+mPzXJqEEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjtL5iGQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716320399; x=1747856399;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/awOTccWQ0TJJdl01vhIbrzasMGO9q1zGJQkyvByLNQ=;
  b=LjtL5iGQ/Bx3jNuE9w506FMKJENqDAmHvs27hL0PXAHscc6XEsUw7/5d
   8FYW1fV4q2B6p6U8m8kR6TWayOBG9Ip9Eg9YFtxy8ZSOBlFyluJXVmUf/
   BqZjH4IPefvn1hgvWeIy6DnEl+1wsye5qXOyOlw/6+xJPd2U6rBp2UvUx
   87GTV3Pz/KFXmBFNEq0Q0L83Q1WyeWekwDb7q3FU8v675rISNlcLJZsdK
   dFDNLEdpY8P5Yg5Vh5Dh73wrPAKaAsahcH1qE14mIlkteojvL/j0+eulU
   yy/+FYeicfYuN7ynLaVgl6BIfvO5hANrYqMKO74qALMP6tqB23/cyafuY
   g==;
X-CSE-ConnectionGUID: SvMOb981RJedUIw75nO6uw==
X-CSE-MsgGUID: BeAK8h4MRCa5KJDraP3uJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="35049760"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="35049760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:39:56 -0700
X-CSE-ConnectionGUID: TaEzahDvTBi3GWxBuTzIFA==
X-CSE-MsgGUID: VZ8mlbYlTQa05ucsbnDnng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33462480"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:39:57 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 21 May 2024 12:39:54 -0700
Subject: [PATCH net v2 2/2] idpf: Interpret .set_channels() input
 differently
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-2-7aa39e2e99f1@intel.com>
References: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
In-Reply-To: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
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
index 6972d728431c..1885ba618981 100644
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


