Return-Path: <netdev+bounces-157317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EBA09EC1
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CAC3A17C1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D04221DB2;
	Fri, 10 Jan 2025 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhiiZN3l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3720764C
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552299; cv=none; b=HZXtA1O0SLzc66oHPQlLVRLAazDfM0qypHqOxThZCh1MK+z+PPK7S2zHhey1o5n4m0zI71LnEIOvAKOAt2D/L0rwlt1DDRFMqGHR0hIU2CK6q6PYdpTBVHXta1saWDbDBilCEEYezD/mfX8/RyeHRyFjFX2z1vPsnUwiRv9D6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552299; c=relaxed/simple;
	bh=+vUQF0Ms6rApdjCEWLAUXJx8qXMAxLYASyTa7ZmSe9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkevhsNC9aySE2sY6N1BkiMqKmAPsPW5DqKhTzsvHrUEVByAg6m3hCfjAwssH9bbZnn3JFWFR1G0SShG7b/qKzFy5GxVCUtZFeHNGWKGcBhWlYVlTqq95sIxeNOlLHumRJf643kIF7JP7SEsxGZ8jNBN+Wui/OK4VTJpdAWZYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhiiZN3l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736552297; x=1768088297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+vUQF0Ms6rApdjCEWLAUXJx8qXMAxLYASyTa7ZmSe9o=;
  b=PhiiZN3ll0lnCs9KtZJcqd3Qwyaxn6oaahf+x44TT236lGYjANmu+jM+
   krLZzNFa11gpqar3zZnEGamsDPqPsiZW6GC4AIBDWyLPqYLWchaQF7v2x
   +sze60l1SsCj9QD0iYVzNyyLuai3ZaydjBsY/QswPG2aogYqEs2rjXxhC
   VxZEwQRdXETq1xUL0Cxt9MBJ+W4dejN+Z9wkc0M1csyUIztVryYY3z397
   qc6xH5QlUScxW2EBtPySMQfgOZ3Sc9aFDSAVqZFVRAZ0iGDkuBDEf7dHf
   o4n40lyMHkE2Kx+PZUn1eIE/4HYM3WJuBGJt6wUtoODtMA4YCXLd3XZCb
   Q==;
X-CSE-ConnectionGUID: +7PH7rDPQJmpGh/3xudJzQ==
X-CSE-MsgGUID: kDSxMgy9RR+Zd9d/ct+xKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40799735"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="40799735"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:38:17 -0800
X-CSE-ConnectionGUID: mkAyTctXQzm6oZG1RJ8RHA==
X-CSE-MsgGUID: 4zAoolm/Rj6H3HyaCGzd8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107916555"
Received: from jf3418-16b10-250812-p7.jf.intel.com ([10.166.80.88])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jan 2025 15:38:16 -0800
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-net] idpf: record rx queue in skb for RSC packets
Date: Fri, 10 Jan 2025 16:29:58 -0800
Message-ID: <20250111002957.167327-2-sridhar.samudrala@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the call to skb_record_rx_queue in idpf_rx_process_skb_fields()
so that RX queue is recorded for RSC packets too.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c9fcf8f4d736..9be6a6b59c4e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3070,6 +3070,7 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	idpf_rx_hash(rxq, skb, rx_desc, decoded);
 
 	skb->protocol = eth_type_trans(skb, rxq->netdev);
+	skb_record_rx_queue(skb, rxq->idx);
 
 	if (le16_get_bits(rx_desc->hdrlen_flags,
 			  VIRTCHNL2_RX_FLEX_DESC_ADV_RSC_M))
@@ -3078,8 +3079,6 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	csum_bits = idpf_rx_splitq_extract_csum_bits(rx_desc);
 	idpf_rx_csum(rxq, skb, csum_bits, decoded);
 
-	skb_record_rx_queue(skb, rxq->idx);
-
 	return 0;
 }
 
-- 
2.46.2


