Return-Path: <netdev+bounces-148697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B769E2E9C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9648B3680E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033820C47E;
	Tue,  3 Dec 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCtEzLAM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF520C00C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262935; cv=none; b=izcPsdHjZPeVvmDGBbxDtyWnai2LpwbMPokuXIHmWyMr+eub5JGXApuCHU1qQlvdEnQ9Fc9U+CJ1bf6msfvcyllhxhhooRQC1lXrUsn++cUxr5oxIBp4HcrToDxtAIpkM0h0zBO2srR2qXdJB5VG77f9eXbO5kfIPoKFPUjN2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262935; c=relaxed/simple;
	bh=dPHC9U2lY7m13ipDqNZOcYlAVURCmXYHvnQ/N2yAnG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtT5X1JeM0j16x0ck9Shqf4dLEcUm/8tZgLGXRxlK3bdO5kI1Tt3b6LjvY9y3Yg5CEtgUCoOszxezcLIqt4pvH/cRvDlU6F7cJVGOAXflgBKC8foBNGtKzFbErHsrIJOJj1BNdkbe0rDoHIXT0tuTJRxCthvLho8zJSrEzC1Ohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCtEzLAM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262934; x=1764798934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dPHC9U2lY7m13ipDqNZOcYlAVURCmXYHvnQ/N2yAnG0=;
  b=LCtEzLAMF+uNWWLTZ8Qk9qtppc8K30DaoLlbC4Thr9574qnfYraAYuJy
   odjmng+/wNjXxp7tsJO2TQrT+5qx+LX8gjJpeMJyEgN6McLVbuAsYXE9U
   Wa4QFadsF7MaJfHNwTxCBR+Vmircllz1qIhVzhymWRyjfDA8X4Pfa3oiK
   b1uWB0avN4xj4Qt3xyzJVdMxY8O/Ou24O6euuyQ7qljG61al4OB3GGtOa
   T/WQSOJZEAFAqWTx4gqO+EcZeJsmlKe97iExzLnQEGY8gwtotsb8VlDfu
   gaT+2bYhx87A0Wb2R70Bzn34N+xs0RzbbtHLsL8l7f950IN4yVTpSJosb
   A==;
X-CSE-ConnectionGUID: FIsujvIGROCVyDdd3qr72A==
X-CSE-MsgGUID: ltATwvhdTXehcG/2gIrCoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087139"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087139"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:29 -0800
X-CSE-ConnectionGUID: pymBQdPcTDuxX95Ynoj4sg==
X-CSE-MsgGUID: YUgLnjSsToyLJx9L1Lk8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578880"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Madhu chittim <madhu.chittim@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 5/9] idpf: set completion tag for "empty" bufs associated with a packet
Date: Tue,  3 Dec 2024 13:55:14 -0800
Message-ID: <20241203215521.1646668-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index da2a5becf62f..34f4118c7bc0 100644
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
2.42.0


