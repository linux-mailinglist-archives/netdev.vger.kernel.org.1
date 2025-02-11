Return-Path: <netdev+bounces-165293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21989A3180B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF661643DF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21326770F;
	Tue, 11 Feb 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8xCUMHU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954A2676CF
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310233; cv=none; b=E0hecXX+W5LQGsLOvNmTYHE5zQuBAs8cHSpIAqaG5lwIkh1HwiDk/2CVdUdrDNqJlAWarces5DSYqCqDeGHxWKF7h6AMHI7e971Q2uWsxfdI1JWzEgsvVlCFoc+gsE4G0FBwC9biy/ct58qB63PacXtmMS9GNCANb5cpxmGcnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310233; c=relaxed/simple;
	bh=Rqa9O0ziKvlfMkm/ts/fxnbn3U4A8kR7qqz/Z4OI2u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgyqh8o9Lxpgp341lihsZqafwPlwff2FqrfZCUrAUrUKGiGGQefRx1ALRMCxkVC+tg3zuO38UzFZgHypgCDJvDr7KFKC+zseYnxtM08lYJv0o1CIK0p3zmKTM985fs/U3yLXHAgNS4yTS3n+DY6rcqimFuIw6rD0TkwApl2dpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8xCUMHU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310232; x=1770846232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rqa9O0ziKvlfMkm/ts/fxnbn3U4A8kR7qqz/Z4OI2u8=;
  b=L8xCUMHUsWfc+PdnehNSx3UPkCGAPNpXraLea61/FlUYEFGKYLKTWo55
   QntZvQGs5Lq+nlFZPRGZ8NOc6Co7TfNJaNUpH1+/OxFh/0orBrqmCT1Fw
   OiGNgtbiCb/S8PopE6fMC5jaJXtR9a+KbDU7YuXRbSW9XbiG6dNopmBJ9
   IRpwVYmVMnwxwHWGg2f9+wf5wghYtxEqKL/uHmYEdC1VS8OiscQp1xK/a
   ueFGT3BwzwZxBQ4LUSLZ0DRVUzXEQYBY4DN3VvWnnV4Xb0p24aK26Zn72
   ovqMyPE/jJjYxY/dppCz5CAORDiGQpYXbnFBXq81f3bIWzlzwjN7FCEw5
   Q==;
X-CSE-ConnectionGUID: td3LbpsrSOSMUVeaFkqdZQ==
X-CSE-MsgGUID: b2Mj3bpiRVGOeALa+vkD8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185231"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185231"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:48 -0800
X-CSE-ConnectionGUID: DHIwCSS5SEaITMBpmWMY7w==
X-CSE-MsgGUID: EjwKKtH/Tfi21Jjn71MHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478671"
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
	Madhu Chittim <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 2/6] idpf: record rx queue in skb for RSC packets
Date: Tue, 11 Feb 2025 13:43:33 -0800
Message-ID: <20250211214343.4092496-3-anthony.l.nguyen@intel.com>
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

Move the call to skb_record_rx_queue in idpf_rx_process_skb_fields()
so that RX queue is recorded for RSC packets too.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


