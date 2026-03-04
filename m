Return-Path: <netdev+bounces-263933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGlIAuZjqGmduAAAu9opvQ
	(envelope-from <netdev+bounces-263933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:55:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B0204AE2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AF7231B1AF9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400EA36CE09;
	Wed,  4 Mar 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzhKXBuz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89336C0D3;
	Wed,  4 Mar 2026 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642176; cv=none; b=Xpw5zY+jPQGuDTzsQLy3aFjUYAWIvWj8P7rNEegmD8dfAN9mnsXBa9VFRw/haj2sOUqobVv/z6Xz3TyS/LyJ/j5XHkU+ytQJ85x9X44wUd/RqZF9em9blzJWGTL8rfz4JCH/Z3QEznWQOhZbcV7zr+Ftq4zpXmy1qKuW/fLPNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642176; c=relaxed/simple;
	bh=oCACM2F8kkfEfXBuuh5iayPiq9mwGCDlUS6bp5gDtSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3sd2qpZPuCK+3gXYFJZlXPzLXYpLbIxGszK2puOnbjO5H9UskZSavBjiOYhvPPEHOGjD/fPFNKPDL8vsQiiMVvYtEroeMgb7OL8SqRce9O9sb3goPoT2H8EqlgHjFMYoPZIt0JxNNC44qpIht2sXlWzXuDdF4R/NrFFfoLzVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzhKXBuz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772642172; x=1804178172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCACM2F8kkfEfXBuuh5iayPiq9mwGCDlUS6bp5gDtSo=;
  b=jzhKXBuz5TfA00gR862+ifltM1FgErHva/U8e0W1eacrMcqZ6STC9/x2
   q10Wo5JEylpiw/DLVsC45qbMkvpZewWC8SDdP6+8Xpz7+VluML1zG9eXa
   VgtNH4LaK8UPPCYT4+U23DQ40VfYMTgYwinYaR80qR40dhuY9pbTdFhve
   oJqt2FNP7+JK/Be9AmTy2RGNj0HEZITrIH10e7FYKJsS1Lu9UWrrq+YNC
   gcFv8oSiZCwvNU502VaHUGlJXtcOq4mlfHhmzKgh/g3J9rtqZfPfUsz2L
   fnK17PWNWPszyYBLS08vUCsrw6NNEBu7LgVrOTRs/1TGvcsDTbgA9/hU8
   g==;
X-CSE-ConnectionGUID: VknUUimaQZCMfOYFmV1FNw==
X-CSE-MsgGUID: y3VzXhdvQ2Gq8Xw7rkbNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77580039"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="77580039"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:36:04 -0800
X-CSE-ConnectionGUID: CXspW5VzSoe+MV4hhdt45g==
X-CSE-MsgGUID: F+Spye3VRzyYF4xcsZtV8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222895571"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2026 08:35:59 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BD90E312CB;
	Wed,  4 Mar 2026 16:35:57 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 04/10] ixgbevf: branch prediction and cleanup
Date: Wed,  4 Mar 2026 17:03:36 +0100
Message-ID: <20260304160345.1340940-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304160345.1340940-1-larysa.zaremba@intel.com>
References: <20260304160345.1340940-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D2B0204AE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263933-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Add likely/unlikely markers for better branch prediction. While touching
some functions, cleanup the code a little bit.

This patch is not supposed to make any logic changes aside from making
total_rx_bytes and total_rx_packets more correlated.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 5a270dd2c7aa..4619f2bea1ab 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -570,7 +570,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 	u16 ntu = rx_ring->next_to_use;
 
 	/* nothing to do or no valid netdev defined */
-	if (!cleaned_count || !rx_ring->netdev)
+	if (unlikely(!cleaned_count || !rx_ring->netdev))
 		return;
 
 	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
@@ -586,7 +586,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 
 		rx_desc++;
 		ntu++;
-		if (unlikely(ntu == rx_ring->count)) {
+		if (unlikely(ntu == fq.count)) {
 			rx_desc = IXGBEVF_RX_DESC(rx_ring, 0);
 			ntu = 0;
 		}
@@ -823,7 +823,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 
 		rx_desc = IXGBEVF_RX_DESC(rx_ring, rx_ring->next_to_clean);
 		size = le16_to_cpu(rx_desc->wb.upper.length);
-		if (!size)
+		if (unlikely(!size))
 			break;
 
 		/* This memory barrier is needed to keep us from reading
@@ -855,7 +855,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!xdp_res && !skb) {
+		if (unlikely(!xdp_res && !skb)) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			break;
 		}
@@ -867,21 +867,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res ||
+		    unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
 			skb = NULL;
 			continue;
 		}
 
-		/* probably a little skewed due to removing CRC */
-		total_rx_bytes += skb->len;
-
 		/* Workaround hardware that can't do proper VEPA multicast
 		 * source pruning.
 		 */
-		if ((skb->pkt_type == PACKET_BROADCAST ||
-		     skb->pkt_type == PACKET_MULTICAST) &&
-		    ether_addr_equal(rx_ring->netdev->dev_addr,
-				     eth_hdr(skb)->h_source)) {
+		if (unlikely((skb->pkt_type == PACKET_BROADCAST ||
+			      skb->pkt_type == PACKET_MULTICAST) &&
+			     ether_addr_equal(rx_ring->netdev->dev_addr,
+					      eth_hdr(skb)->h_source))) {
 			dev_kfree_skb_irq(skb);
 			continue;
 		}
@@ -889,13 +887,14 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		/* populate checksum, VLAN, and protocol */
 		ixgbevf_process_skb_fields(rx_ring, rx_desc, skb);
 
+		/* probably a little skewed due to removing CRC */
+		total_rx_bytes += skb->len;
+		total_rx_packets++;
+
 		ixgbevf_rx_skb(q_vector, skb);
 
 		/* reset skb pointer */
 		skb = NULL;
-
-		/* update budget accounting */
-		total_rx_packets++;
 	}
 
 	/* place incomplete frames back on ring for completion */
-- 
2.52.0


