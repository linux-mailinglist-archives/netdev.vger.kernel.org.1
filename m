Return-Path: <netdev+bounces-165292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E26A3180A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16091883753
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1930267703;
	Tue, 11 Feb 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVXBmWYH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F2267705
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310231; cv=none; b=oZ+aKMCLoDF/oKHxGTOsVySRA9PUBMdj/iUh9bLfsBEwxIu19aJutCPpwkhIzBQXtiHYbZgedEhBA85HS5Zpapmj/Zg9MrcJhClACIEn/tciXOcGNLNbPN3UjJ1g/bE08BIyx8i6Ac1EnrNKLAfsAXWS0V/+4uuqNTxbgD5Vrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310231; c=relaxed/simple;
	bh=/Yjv78vpFgTBFjx27sm8wPgmoHwg6vcE3jDcIZDRgV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5ouSfFLG9vqoDisb5uQn7Y2Xh53jQ+yFCUYWB25FJXQp41zJkZIo6I0CYVljhA/kNiQhZGKufuNsaw4mBxO9NQWp3KknyJnXQmMwbM/abzG4tdU3U3IV0kxqt4TySHFBKqJDR05R0kYFsbG4NNs9+6nX5ZGYKeyTCduM8dq/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVXBmWYH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310230; x=1770846230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Yjv78vpFgTBFjx27sm8wPgmoHwg6vcE3jDcIZDRgV0=;
  b=SVXBmWYHH1ZeZ8g1zxi0UGPQOo7UUSPJNghpx/P7sTkgAe1zBMICXNGe
   YSRgD+2eHArFki1uC3zGJk7K5jUFmb7+0hDxK9Hm9F41L4BG67ZXtSlcA
   FlZSFKTTJtslwE/R+1kHXIyGAlTovmV2opbJbBpnQG0az2lp2UXBsJKIl
   5Lc2JWcOkXCx5CgYN/IKhGeTFFySNtoEYfYy57gFDOKYaDAfj4n27L5wV
   GuMUx67lkoBo+Q/YSHWXmPrwSbgTNDphWgPn/kUS86UmcDhEN3/gciXgi
   Ml6A1w0XZoSZd/7U8TNOviKAMjQfQuW6hncHnPjXYwL4Sgnj20g2ohmgr
   w==;
X-CSE-ConnectionGUID: FhetdRjVRqqcXi1wEcSd3A==
X-CSE-MsgGUID: MyznHP/VTXCDf1TBUJwH7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185225"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185225"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:48 -0800
X-CSE-ConnectionGUID: BWIp6exQS5OE9cn8YiTeEw==
X-CSE-MsgGUID: SH5QtbybRzauyTAmKa/ToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478668"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 13:43:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/6] idpf: fix handling rsc packet with a single segment
Date: Tue, 11 Feb 2025 13:43:32 -0800
Message-ID: <20250211214343.4092496-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
References: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

Handle rsc packet with a single segment same as a multi
segment rsc packet so that CHECKSUM_PARTIAL is set in the
skb->ip_summed field. The current code is passing CHECKSUM_NONE
resulting in TCP GRO layer doing checksum in SW and hiding the
issue. This will fail when using dmabufs as payload buffers as
skb frag would be unreadable.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2fa9c36e33c9..c9fcf8f4d736 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3008,8 +3008,6 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 		return -EINVAL;
 
 	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
-	if (unlikely(rsc_segments == 1))
-		return 0;
 
 	NAPI_GRO_CB(skb)->count = rsc_segments;
 	skb_shinfo(skb)->gso_size = rsc_seg_len;
-- 
2.47.1


