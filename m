Return-Path: <netdev+bounces-132848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C497993810
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232371F2202D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4A21DACB1;
	Mon,  7 Oct 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhmcOEen"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D881727
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332253; cv=none; b=FnplOx+9Sr2Nbw6eIVE/KnKqqUSwPF2GhHeaRPRA5PrKzKIah704pRY30gLefppTwNXLfP4rKzNX9Qkh1vBmqNd1SpEpTtitL89UKk2dKo7YDzBZg7o/KU76i8fDcHfCBIP2hfX5a8ax2nMUhLvEB11JmxjPzp9Vs8gDaPiOSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332253; c=relaxed/simple;
	bh=t8eRMXgHM65A8SAT5uZ6vgW3918+43f43JG1igKF8M8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5FjPN82e8mMQwwu+uDI/+7P1BwcgK2jDk0yDrpYYsiAhdhB0++wm4bbfOLQzhCN9VGCwgxvRTwxGP1xTzW91od9mdhB95YWVgzJ1dA6kcYd2p7CD6God0MNS4sALitrbXzDEBa+akdbeodVvWNhP9u6Prc2a96vOj/CxuCFxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhmcOEen; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728332252; x=1759868252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8eRMXgHM65A8SAT5uZ6vgW3918+43f43JG1igKF8M8=;
  b=YhmcOEenrS85tbfJoA1eeGpjRazrCBEUkJBLhRzQLLNBj6Pf5uG7roTg
   ad0RFRL/IzuIlXBewtjr4mUX+ymjNqPGT34YFvUuSD/zEQJeEqzGnDikR
   f0RHyDgG4jrOitYMwRP69QW/IxCEURyI5ZVxdG0f+lXAEY0sLL6Wc5TAd
   c94HM7GPiAgxfACW8p1E30GLjxGVA0oLjaCnFnUWfgS8VBZvsr40dmUA9
   Ey/V9nkhzHzUJaCLOyMFhoNDL6o74AUKCPprsIVvEpxt6dKksq9H5Cphe
   34WxCTfq4VvdJ5Ch+eFVZNFfLyeueeb8ErNg1JxxLmbEoMtqeeNfS16Da
   w==;
X-CSE-ConnectionGUID: 3v142GhMTvKnaNFJp0Qf9w==
X-CSE-MsgGUID: OZUgXtL8QhamzyCj7Zu4bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38066444"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38066444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 13:17:31 -0700
X-CSE-ConnectionGUID: h+KGnEy/QVydIlyV5f6wiw==
X-CSE-MsgGUID: MrRYPvxqQ+i+0IqF8kEnsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="76023755"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by orviesa007.jf.intel.com with ESMTP; 07 Oct 2024 13:17:31 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: aleksander.lobakin@intel.com,
	madhu.chittim@intel.com,
	netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: set completion tag for "empty" bufs associated with a packet
Date: Mon,  7 Oct 2024 13:24:35 -0700
Message-Id: <20241007202435.664345-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
inadvertently removed code that was necessary for the tx buffer cleaning
routine to iterate over all buffers associated with a packet.

When a frag is too large for a single data descriptor, it will be split
across multiple data descriptors. This means the frag will span multiple
buffers in the buffer ring in order to keep the descriptor and buffer
ring indexes aligned. The buffer entries in the ring are technically
empty and no cleaning actions need to be performed. These empty buffers
can precede other frags associated with the same packet. I.e. a single
packet on the buffer ring can look like:

	buf[0]=skb0.frag0
	buf[1]=skb0.frag1
	buf[2]=empty
	buf[3]=skb0.frag2

The cleaning routine iterates through these buffers based on a matching
completion tag. If the completion tag is not set for buf2, the loop will
end prematurely. Frag2 will be left uncleaned and next_to_clean will be
left pointing to the end of packet, which will break the cleaning logic
for subsequent cleans. This consequently leads to tx timeouts.

Assign the empty bufs the same completion tag for the packet to ensure
the cleaning routine iterates over all of the buffers associated with
the packet.

Fixes: d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Madhu chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index d4e6f0e10487..60d15b3e6e2f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2448,6 +2448,7 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 			 * rest of the packet.
 			 */
 			tx_buf->type = LIBETH_SQE_EMPTY;
+			idpf_tx_buf_compl_tag(tx_buf) = params->compl_tag;
 
 			/* Adjust the DMA offset and the remaining size of the
 			 * fragment.  On the first iteration of this loop,
-- 
2.39.2


