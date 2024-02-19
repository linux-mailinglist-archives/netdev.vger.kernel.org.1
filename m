Return-Path: <netdev+bounces-72891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDD85A0B9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210541F21AF2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA025616;
	Mon, 19 Feb 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQll/n/o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC12560F
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337709; cv=none; b=XiAiZ7ALvWEpWpH7wQbzTuPfsqEHrlZzebzz+bLXQlu16l/iHPYAsI/LSA8qlzXP7UHKvodYcW6MLNa+KnA5XX4Fn8B2nUJ9N+SJV3SIj1Zf53nAyB2mXqjnJHxQiMC4BfUrrRmOLIjz8MMKXkBtDUJaMqaUEBqi+L+7prRUxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337709; c=relaxed/simple;
	bh=DT+HJ/MRBgBoch9D0gcN3G58vRVjIVWEk0CwB5FZWGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHUdRuBOkgu94zo8+NDIQe7oJrSsSzAWpOjcbRPQGE4Bxn0y2feUb/deKxAynO9XZGsToQ542SWoxrualsJKgmTYBTuu2ZKowTklYjrXrBv/PiGG5RRV4el1I5Mt/K1yNsJNpQi4+HqtZ0abFZOQYAQLwdsPMqjJhjo+8T007Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQll/n/o; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708337708; x=1739873708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DT+HJ/MRBgBoch9D0gcN3G58vRVjIVWEk0CwB5FZWGk=;
  b=bQll/n/osvRqyTwZIDkoDwItSh2xUF+t6+yBJ0a1QZciFNKSOyTEqwqt
   FuYTfiKTZIyKAN6g5i/mXCbfw2i5TGGH56PmfG7JEHx0+XPY0jDITWTwp
   5NYZl9PY88+/uWTC+Re4/VK4EhlZ0CT+xgVNLK3cKkCp5/TboC8EyNLDb
   q66g5+00jchl0Lzw0Mmgcvqc+c0hyK0O6Fyf0kvDYFXKP8JSZUc56Uw1Z
   1Xg7aixXwWnSYaiL5mWL5Y+6dVXnT+Oaw4PZCcDC0ecIA2nevWYgBZThQ
   6CTlhspJZScNbzUrsolUFb5CrxUrdEn6ofJzKtRdOHlgtyGixBzlOsel/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2514760"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2514760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="826984903"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="826984903"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2024 02:15:05 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 84A2E135F0;
	Mon, 19 Feb 2024 10:15:04 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: Document tx_scheduling_layers parameter
Date: Mon, 19 Feb 2024 05:05:59 -0500
Message-Id: <20240219100555.7220-6-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
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
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 Documentation/networking/devlink/ice.rst | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index efc6be109dc3..1ae46dee0fd5 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -36,6 +36,47 @@ Parameters
        The latter allows for bandwidth higher than external port speed
        when looping back traffic between VFs. Works with 8x10G and 4x25G
        cards.
+   * - ``tx_scheduling_layers``
+     - permanent
+     - The ice hardware uses hierarchical scheduling for Tx with a fixed
+       number of layers in the scheduling tree. Root node is representing a
+       port, while all the leaves represents the queues. This way of
+       configuring Tx scheduler allows features like DCB or devlink-rate
+       (documented below) for fine-grained configuration how much BW is given
+       to any given queue or group of queues, as scheduling parameters can be
+       configured at any given layer of the tree. By default 9-layer tree
+       topology was deemed best for most workloads, as it gives optimal
+       performance to configurability ratio. However for some specific cases,
+       this might not be the case. A great example would be sending traffic to
+       queues that is not a multiple of 8. Since in 9-layer topology maximum
+       number of children is limited to 8, the 9th queue has a different parent
+       than the rest, and it's given more BW credits. This causes a problem
+       when the system is sending traffic to 9 queues:
+
+       | tx_queue_0_packets: 24163396
+       | tx_queue_1_packets: 24164623
+       | tx_queue_2_packets: 24163188
+       | tx_queue_3_packets: 24163701
+       | tx_queue_4_packets: 24163683
+       | tx_queue_5_packets: 24164668
+       | tx_queue_6_packets: 23327200
+       | tx_queue_7_packets: 24163853
+       | tx_queue_8_packets: 91101417 < Too much traffic is sent to 9th
+
+       Sometimes this might be a big concern, so the idea is to empower the
+       user to switch to 5-layer topology, enabling performance gains but
+       sacrificing configurability for features like DCB and devlink-rate.
+
+       This parameter gives user flexibility to choose the 5-layer transmit
+       scheduler topology. After switching parameter reboot is required for
+       the feature to start working.
+
+       User could choose 9 (the default) or 5 as a value of parameter, e.g.:
+       $ devlink dev param set pci/0000:16:00.0 name tx_scheduling_layers
+       value 5 cmode permanent
+
+       And verify that value has been set:
+       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
 
 Info versions
 =============
-- 
2.38.1


