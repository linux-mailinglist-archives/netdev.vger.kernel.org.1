Return-Path: <netdev+bounces-162662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B594A278FF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2E41886D3A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32676215F74;
	Tue,  4 Feb 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3h9Tiez"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D421638B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691576; cv=none; b=THGbLekABDr52s5BPp8A/lw9EWxpUBGBiJZhhyJhGdPnIXE9cpYZzBrey8+y56lJvzpAGltO+df8qpzojgShcSZK+kn8rN9OcI2H6SdKdKjeOvCMJj7vGPpuHXhUFZbhhlKBwK8WY+BVdB4/984QOSr/zUE2XQhAYu92ZIUXmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691576; c=relaxed/simple;
	bh=DjRRCNPcLPWjuJq1XFZ/jGqru4FOEvkn8qDPdjG7ZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kistiFfZ7XG9XAQ+Kt5mbjcphDUBqSW7En+lrTf2gKVajxD6CwPVOkT+YEzgO4N2AtggiGKRDPyrJtM8dDZjPwFXq6lPNO7RnlSHukBPLy/xY0BOcRq82/muzH+sCeT7ChR5SBFQ0kqay/+1UrBSQiYYG0QS6YRw5HxxwOaFSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3h9Tiez; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691575; x=1770227575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DjRRCNPcLPWjuJq1XFZ/jGqru4FOEvkn8qDPdjG7ZKE=;
  b=e3h9TiezhLCXAS6Bl3K1stMFQjUHilOnd4vu1T2Vc0MVFRd1wYoOPKVU
   fUq3A+jzHmZGw3Xxhtg9+UAe8uJlmEghgNLIXemfBLAwW+UBw3uD9KwS+
   gszXKO57Ww4Y0Hwjzsvv/LxmaqbPkcACsFyrP0h0Y9cMe9vAnTcg5RSVY
   9lJ/LOJ5e1CLDVv7jGhddFBdorbxyL7acDYg3Nb9oDFniRsRyy+/gkADm
   vRX+mVWBxmxDrqAGqytYgQeo+CSxkuI+7x9n+hAh7EleAN9SqrAxEFZzz
   ga+53NeT7zLaYfBvZvtrc0OVXdHCezCpK2/CKl+b/pJ+I6o1erkbAfMRa
   g==;
X-CSE-ConnectionGUID: Bb9ZqvNMQN6dXi+pnvB+mg==
X-CSE-MsgGUID: OAiR3utOQc+HcDkhtm4HOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371875"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371875"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:54 -0800
X-CSE-ConnectionGUID: 7mdMjiabSVS+VCPErw1DRw==
X-CSE-MsgGUID: +MHDgjemSuqPDMEu8JTX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652387"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2025 09:52:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	anthony.l.nguyen@intel.com,
	rostedt@goodmis.org,
	clrkwllms@kernel.org,
	bigeasy@linutronix.de,
	jgarzik@redhat.com,
	yuma@redhat.com,
	linux-rt-devel@lists.linux.dev,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/4] igb: narrow scope of vfs_lock in SR-IOV cleanup
Date: Tue,  4 Feb 2025 09:52:37 -0800
Message-ID: <20250204175243.810189-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wander Lairson Costa <wander@redhat.com>

The adapter->vfs_lock currently protects critical sections shared between
igb_disable_sriov() and igb_msg_task(). Since igb_msg_task() - which is
invoked solely by the igb_msix_other() ISR-only proceeds when
adapter->vfs_allocated_count > 0, we can reduce the lock scope further.

By moving the assignment adapter->vfs_allocated_count = 0 to the start of the
cleanup code in igb_disable_sriov(), we can restrict the spinlock protection
solely to this assignment. This change removes kfree() calls from within the
locked section, simplifying lock management.

Once kfree() is outside the vfs_lock scope, it becomes possible to safely
convert vfs_lock to a raw_spin_lock.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d368b753a467..77571f6fdbfd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3708,12 +3708,12 @@ static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
 			msleep(500);
 		}
 		spin_lock_irqsave(&adapter->vfs_lock, flags);
+		adapter->vfs_allocated_count = 0;
+		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
 		kfree(adapter->vf_data);
 		adapter->vf_data = NULL;
-		adapter->vfs_allocated_count = 0;
-		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		wr32(E1000_IOVCTL, E1000_IOVCTL_REUSE_VFQ);
 		wrfl();
 		msleep(100);
-- 
2.47.1


