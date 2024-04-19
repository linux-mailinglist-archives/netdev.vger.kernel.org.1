Return-Path: <netdev+bounces-89549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FD8AA9FD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8555E1C21854
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA55F869;
	Fri, 19 Apr 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3g4zU36"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73152F6B
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514729; cv=none; b=LGpnYRF6RiXsCrEz10XmbCrObbiJ88ihrVwthxy3A1kgLW9yc56Wd4QwV7n/xnCCO5nb3dMncT1WQdCQ3wE3PNP0T0xk2Pzfsl2MQoO1QQ3Zr3+dqyItpolRCTGeoTyFR3sAZMn7gTzpcpP0aH97UYGquVmHtqDPSrqxo4Bx3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514729; c=relaxed/simple;
	bh=ayp3w+xzqn0hd9fHMdrwa/nbYUX3VcDmHtiOLt5hPWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdTaNQcjGaAw2y3UtDSy6nJB5CvZVxDaoNpLvb3BCSApdVz9EHP8RDdkppe0cIgckiV2fo4+BhTUvQ+7y+las5qAZup8tt309Uqkjf0AssIQNkqRugC5MBP6unhKWWi9FeF5fKYjcbYFgSb9Cmah0Jfy0qukX0G6bqwozGXaIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3g4zU36; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713514729; x=1745050729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayp3w+xzqn0hd9fHMdrwa/nbYUX3VcDmHtiOLt5hPWs=;
  b=T3g4zU36WwJiFBpefzlQ/8Jizg9ZhqniYY3aqrCW0dvdomXCFSjKO0zj
   N3xCw836ELlEQIaXiZujv+UDwij33WHkCI74Int3XIDfzIQrztbz99PVJ
   83lMluuJgxM9cjEhbSbeSvRZ5M2Q1fFxqeRe7jffEGZTEsumIBR7RaYjc
   /TFx9kH8p3Zm2nRzFpV7NpsVJFufEWUg2+u1Sy0jpAtCUmbZe9ILIwFq0
   7PE3jWCCcBVkP6JehZLzZFmQzJhP37NDALuUBrLoCSXEA+UIhT0DDCbAs
   Q3BAdaKz7JPOmnvTjhqJHJIP6od2+r6SAxSZSSNZoNaoSEe9RQ+S+3QaT
   g==;
X-CSE-ConnectionGUID: Bb/zzW2aQbGficop7u5/dg==
X-CSE-MsgGUID: +zNK+2QrRIWCkgm85Vw40g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9028097"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9028097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 01:18:48 -0700
X-CSE-ConnectionGUID: kiDmN4oGR3Cxh0sxlaQQjw==
X-CSE-MsgGUID: X/MTINj7S+uxe6fHWEyKEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23244473"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 19 Apr 2024 01:18:44 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8C5BB2819A;
	Fri, 19 Apr 2024 09:18:30 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	victor.raj@intel.com,
	michal.wilczynski@intel.com,
	lukasz.czapnik@intel.com,
	Jiri Pirko <jiri@nvidia.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH net-next v10 6/6] ice: Document tx_scheduling_layers parameter
Date: Fri, 19 Apr 2024 04:08:54 -0400
Message-Id: <20240419080854.10000-7-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240419080854.10000-1-mateusz.polchlopek@intel.com>
References: <20240419080854.10000-1-mateusz.polchlopek@intel.com>
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
2.38.1


