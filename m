Return-Path: <netdev+bounces-116266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC9949B30
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A2028782C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E8165F08;
	Tue,  6 Aug 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViTWOjtP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14916CD11
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982539; cv=none; b=hUUHJ+8dnVXZlowloVptbPicnqCpYbBDJpSnw/YiKyvs/YbPP1wQm4MQcJpagUv7MxKil4geGHLHgjwQNcq0lPG+YmStnBhWiJ0bi1SBrHDjOeelIZ8Yg1WgOq2aVr0oYdZ8OLdtUuofvOrwrHbLJOLYlbCgBzWMY2jAkQjBdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982539; c=relaxed/simple;
	bh=aV3BSuKOTWWkdvopEoYu0CH0QrWnERbC1OgY09FZIAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZHHqBuQwNSnsPe0DX0ayFLHWkK9OvlkZAOp4ZLZ+RDJKjxi0jW4+BGyuCN3h0OvTiN8jRF/JF6uVgGtavgSlhAZgfG04riiwvpWfM2fT1wZmqVS/K8O14TtDpe97S2JOG+yvhmnh+/XSPJBqz2qvglCB8mYuTcp/sv11Joqas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViTWOjtP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982536; x=1754518536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aV3BSuKOTWWkdvopEoYu0CH0QrWnERbC1OgY09FZIAM=;
  b=ViTWOjtP11MKCObexwPmykKGqQFMht2KcxWuKGmpzC5QrNABd1/Tn3QC
   Q1cbsGFq7oipRUHTrfX5ccygF5p9c/bNf1lyIkGxjDJ2OENuPxKLm1jgK
   LQ7vwxYHq7rYm8pqayiscD4Y7KelXhGnXNAC0ZTi0x6XMz4yVYlU2zw3U
   CMYkdQ5n03aVig56b7oydEEDUnyM4GF+1kL38398aNBMbpRIIowk3Yc+o
   jr9IhopOghFaYvTlNtoGbsddGeh+Ztg37RbSJapuK8HcibS/fYOcKdqrG
   ORNYj3gfbthWPHAuwjN+2C8ZfyZbayhBF5bXLwgPOdoKzcUN1BEYO9sA7
   w==;
X-CSE-ConnectionGUID: 9BFE20WJTfWBT97y+iv8HQ==
X-CSE-MsgGUID: YDiBvLE8RSKektt1i6A+sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21176178"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21176178"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:15:35 -0700
X-CSE-ConnectionGUID: uOXZ/8cMSxW6LfO2gSHN/w==
X-CSE-MsgGUID: BIDTlLCjSsechIJ7flzm9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56623851"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 15:15:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	Jan Tluka <jtluka@redhat.com>,
	Jirka Hladky <jhladky@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Corinna Vinschen <vinschen@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] igb: cope with large MAX_SKB_FRAGS.
Date: Tue,  6 Aug 2024 15:15:31 -0700
Message-ID: <20240806221533.3360049-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Sabrina reports that the igb driver does not cope well with large
MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
corruption on TX.

An easy reproducer is to run ssh to connect to the machine.  With
MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.

The root cause of the issue is that the driver does not take into
account properly the (possibly large) shared info size when selecting
the ring layout, and will try to fit two packets inside the same 4K
page even when the 1st fraglist will trump over the 2nd head.

Address the issue forcing the driver to fit a single packet per page,
leaving there enough room to store the (currently) largest possible
skb_shared_info.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Reported-by: Jan Tluka <jtluka@redhat.com>
Reported-by: Jirka Hladky <jhladky@redhat.com>
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Sabrina Dubroca <sd@queasysnail.net>
Tested-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
iwl-net: https://lore.kernel.org/intel-wired-lan/20240718085633.1285322-1-vinschen@redhat.com/

 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 11be39f435f3..232d6cb836a9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4808,6 +4808,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
 	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
 		set_ring_uses_large_buffer(rx_ring);
 #endif
-- 
2.42.0


