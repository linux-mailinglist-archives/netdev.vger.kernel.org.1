Return-Path: <netdev+bounces-68069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB20C845BE1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497CB1F23360
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD0159584;
	Thu,  1 Feb 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqH96o2C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEF626A3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802147; cv=none; b=FjqUQlMAdKhB8/1Tus5dqIecj/ivbuvHNm9MHXUpNw3oLzbZYVXwLXdD9de3mPo2S7Picd7UepWm0a02VX+CYl1r7HFS9FZwF9SGwx9b8IrRT3WT8VmRYB7KgqIqGR01FvSm7MCw9kTi0LXYaDyrF82E7QkWQuc4+V2ZwpazScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802147; c=relaxed/simple;
	bh=swRC6Qpw9COjx9ww7MlyDqVkOihziKADyrjB65UCFoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZBEeLZJaZ5GAtslF1cggwFMPeENh5Uh+wPGNIUwygxnXqH9hirXIUCKY63EEtf/1Z9WtQsLcWZd9alhOUfllNjbrOnKi7Ej5qhfeDDpqP16akJzaivn3FgOguy/IDeMpUSLXetU6v/HkRIA7nzHhg4+Ug0KQnWxYgm3TX8sAemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqH96o2C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706802146; x=1738338146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=swRC6Qpw9COjx9ww7MlyDqVkOihziKADyrjB65UCFoc=;
  b=OqH96o2CKtD8HZva8Kb5PjJUV9fQdV/0wMKR15wmg7lp1MgIoeAwTnQa
   BVDrx/yWo5Dr98TVeUTfbXnI/zTv13X0/3QlB4VvwwPe03+T5SkDAroGN
   FYrYxAc//kkV+iFV4KgDRh+XBxnCiGPmx61ag1uRpDzjhNaPPgXhnPfv+
   z8GhLWmOB2FBGaZAan+VQ9OUnaDjqlRWmBZ3SFp0JcajlT/T+ZaqZToV0
   Hu8s4VU1vlYqK77nwY2xHW1I1p9FsZ6x0fhRRAYWQq4MdcIRbrNH2rMkf
   w2dNM8p6SkVx9Kwm73bde6cVnHZHU2WTR2tUbVSwHCF/3pC4F8rvKAKg+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10551402"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10551402"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4418153"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 01 Feb 2024 07:42:24 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 0/2] i40e: disable XDP Tx queues on ifdown
Date: Thu,  1 Feb 2024 16:42:17 +0100
Message-Id: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seth reported in [0] that he couldn't get traffic flowing again after a
round of down/up of interface that i40e driver manages.

While looking into fixing Tx disable timeout issue I also noticed that
there is a doubled function call on Rx side which is fixed in patch 1.

Thanks,
Maciej

[0]: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/

Maciej Fijalkowski (2):
  i40e: avoid double calling i40e_pf_rxq_wait()
  i40e: take into account XDP Tx queues when stopping rings

 drivers/net/ethernet/intel/i40e/i40e_main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.34.1


