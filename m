Return-Path: <netdev+bounces-234191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB7C1DA97
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE918998B6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4323128D5;
	Wed, 29 Oct 2025 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3lmr3uJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3B309EF8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779634; cv=none; b=EXmFGG6yhZOaXifubXK9P3UC4x0GvBfcPUoxLV8PCt0cYhAMZNDLe5i5623NBfdpyEMPHDngNuzOhZI+ysffvn6f9ev9zBpCyBfoIuo+Fo0fckOJViIufLcKH8iDfrfveg7GrgIiNX6kQxt1nk+U+AITzjHYD/KkN0rqrucAlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779634; c=relaxed/simple;
	bh=SeVDkZlIraS8XA6+quM/yQEwl7cpbqk7o7HvCLpKn9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdB5MgO3POd5ub4tDFtxVQnAGMNtQN1zfUkgzH7PlfokGQr7kOQq3+UsnA5SBfcuD0dsVJt+dKaHgDUfuVUT/tcYuCDxrSou+pY3S8SLOhAi7ZhoqUNvggDxq8mmrS0n5C3M4qZddvy4qFf3EIKeBgvbw2D8GhIH4nW8oULZEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3lmr3uJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779633; x=1793315633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SeVDkZlIraS8XA6+quM/yQEwl7cpbqk7o7HvCLpKn9s=;
  b=i3lmr3uJ55Z3W7iOQ23H4UnKTUDyV1zrg0Knti0ERaDdsZ2iilYYNmUA
   I57sBL9mMrtKSUabtJND8+bh0q5paC2briI4WCnz8KWV5j/5fJOytZpoc
   mWMR9yl8/jPGv/vCeHLd+5sOhgE5iR2dnbuzm/XGjiCtCUM+na7WE0V11
   Q90FlBVOunqszMDOvQL82fclviV/J79f/jBbQ8h5/Fcl6oZqsxeIcA110
   s7/N9QrQ68xiM8t8MM1h5S3LIGLvATBWF+IQ7VnqspaOvGQ8FCUYrHMJq
   bOReRpm+TswS6hsxlym8N447npxiUi5UbVhc7m35PWVUP+ZorkedMk7yf
   w==;
X-CSE-ConnectionGUID: brr1H6CYT4Oa1Nvjn8R54A==
X-CSE-MsgGUID: 4MZSwKStS8y7goLV7TyW9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817612"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817612"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:47 -0700
X-CSE-ConnectionGUID: FZzGHJnlQz6ti9ZBCiRebQ==
X-CSE-MsgGUID: QZESgXiOR+Geia0Z2r39Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729710"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: [PATCH net-next 9/9] igbvf: fix misplaced newline in VLAN add warning message
Date: Wed, 29 Oct 2025 16:12:16 -0700
Message-ID: <20251029231218.1277233-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

Corrected the dev_warn format string:
- "Vlan id %d\n is not added" -> "Vlan id %d is not added\n"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 61dfcd8cb370..ac57212ab02b 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1235,7 +1235,7 @@ static int igbvf_vlan_rx_add_vid(struct net_device *netdev,
 	spin_lock_bh(&hw->mbx_lock);
 
 	if (hw->mac.ops.set_vfta(hw, vid, true)) {
-		dev_warn(&adapter->pdev->dev, "Vlan id %d\n is not added", vid);
+		dev_warn(&adapter->pdev->dev, "Vlan id %d is not added\n", vid);
 		spin_unlock_bh(&hw->mbx_lock);
 		return -EINVAL;
 	}
-- 
2.47.1


