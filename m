Return-Path: <netdev+bounces-90269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0EF8AD5F8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FFD282C31
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185F1CD1B;
	Mon, 22 Apr 2024 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODIYbp0m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD631C683;
	Mon, 22 Apr 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818372; cv=none; b=pazPh8bKGcy1YkPqqAGu9hq89HMuRDruB68eaUtgaoSO/WqwOSnWHfc4kKUBqUpfAc5leK83e7421NJv0rEVslnyXaW2dcNlLhBlHCkCvADPGoI0VzmsPIOzHAdWaJ1evrnUA8B2+KoZb3tBk+EYaCVTQX/ypuv1TxCGkjZbNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818372; c=relaxed/simple;
	bh=TaovGTUBp/IQ66X5p46Kr97g2RuX5MLDalWV8R13x78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOP9Gbt0FAwlFeWkJg5lLW0Zjm47ZlooeCDD4qo0iHlL0QNPJZ6setZSl7aDDHFmcDRX7d+R3X/RITeQQU2yyExh87rHL/dywZGh6i1RL9YL8Si2QwtqqosA5Fn307pBMzPZuE0RSEQmVf6jNFpS9dzvBaQcRjuMLOjT6Gm9ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODIYbp0m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818370; x=1745354370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TaovGTUBp/IQ66X5p46Kr97g2RuX5MLDalWV8R13x78=;
  b=ODIYbp0mWfwN/raXkIQSLXvxy918cR7Do5AvwLi+UEiD4HKa3/HQZz09
   oR8v5SogboUEf8uZysw10iUBmK0vdG3K0rfWUwZTBbt8RyR1iqTUR9S1Q
   Pu24AEHCXkUAUrF5lOeGEwA22CYFmT8swbh2XwKvfLVhtBX0Vwuv6uH7p
   XKtXjQfcVRrVh+0CfDOdnr3diz9YlInjX2YDv6S1md7yVxOEKO9VB7Kk8
   e48+18wGfM+qzYb1a5KVanxPRlyrF9SOUKICp59zA/TlR0y+91IAi6HMw
   JWvFLg27brB27kH+z/6nfZXtK8Q9H/AKxHiM/htog9sSwt+UgYW0wQ/Au
   w==;
X-CSE-ConnectionGUID: spdUeNcnRTC3SbfjVTnKAA==
X-CSE-MsgGUID: WpwNSL03SYydndK9Ne8MBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9244821"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9244821"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:39:22 -0700
X-CSE-ConnectionGUID: dEVupEV8Qk6xdEuxyo4jLw==
X-CSE-MsgGUID: IQRvz52HSIGroqQqc6PlZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28945621"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 22 Apr 2024 13:39:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Wilczynski <michal.wilczynski@intel.com>,
	anthony.l.nguyen@intel.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH net-next 6/6] ice: Document tx_scheduling_layers parameter
Date: Mon, 22 Apr 2024 13:39:11 -0700
Message-ID: <20240422203913.225151-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Wilczynski <michal.wilczynski@intel.com>

New driver specific parameter 'tx_scheduling_layers' was introduced.
Describe parameter in the documentation.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/ice.rst | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 7f30ebd5debb..830c04354222 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -21,6 +21,53 @@ Parameters
    * - ``enable_iwarp``
      - runtime
      - mutually exclusive with ``enable_roce``
+   * - ``tx_scheduling_layers``
+     - permanent
+     - The ice hardware uses hierarchical scheduling for Tx with a fixed
+       number of layers in the scheduling tree. Each of them are decision
+       points. Root node represents a port, while all the leaves represent
+       the queues. This way of configuring the Tx scheduler allows features
+       like DCB or devlink-rate (documented below) to configure how much
+       bandwidth is given to any given queue or group of queues, enabling
+       fine-grained control because scheduling parameters can be configured
+       at any given layer of the tree.
+
+       The default 9-layer tree topology was deemed best for most workloads,
+       as it gives an optimal ratio of performance to configurability. However,
+       for some specific cases, this 9-layer topology might not be desired.
+       One example would be sending traffic to queues that are not a multiple
+       of 8. Because the maximum radix is limited to 8 in 9-layer topology,
+       the 9th queue has a different parent than the rest, and it's given
+       more bandwidth credits. This causes a problem when the system is
+       sending traffic to 9 queues:
+
+       | tx_queue_0_packets: 24163396
+       | tx_queue_1_packets: 24164623
+       | tx_queue_2_packets: 24163188
+       | tx_queue_3_packets: 24163701
+       | tx_queue_4_packets: 24163683
+       | tx_queue_5_packets: 24164668
+       | tx_queue_6_packets: 23327200
+       | tx_queue_7_packets: 24163853
+       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
+
+       To address this need, you can switch to a 5-layer topology, which
+       changes the maximum topology radix to 512. With this enhancement,
+       the performance characteristic is equal as all queues can be assigned
+       to the same parent in the tree. The obvious drawback of this solution
+       is a lower configuration depth of the tree.
+
+       Use the ``tx_scheduling_layer`` parameter with the devlink command
+       to change the transmit scheduler topology. To use 5-layer topology,
+       use a value of 5. For example:
+       $ devlink dev param set pci/0000:16:00.0 name tx_scheduling_layers
+       value 5 cmode permanent
+       Use a value of 9 to set it back to the default value.
+
+       You must do PCI slot powercycle for the selected topology to take effect.
+
+       To verify that value has been set:
+       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
 
 Info versions
 =============
-- 
2.41.0


