Return-Path: <netdev+bounces-287032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHS3OMT0AmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:37:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA951DDBE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A76DB30B0480
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD694B8DE0;
	Tue, 12 May 2026 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByjMOJlw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90F4ADDA0
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578277; cv=none; b=PMtOKHLN/9Fq1gRE5AZDP7UdOoVeK9Z2E95Cw5DdH3A3PG5ks3OkuH+tvPHoTfHg4IsEuvSqYxwVS81f14IUFkf584MDxOjgD/Rw87Q2s97MBBgIbOeN19/GLAxLZWQA56MS9lKltdsodhRD4sadIIRriCWJkvbG8Szn4Kr6XQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578277; c=relaxed/simple;
	bh=n5ioBkaZUOJfCvdOjoBw0lwuVb9kUUxbFn9DAO17+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzsVn5YRwywMe9nIFXB5hDOykw2pch8THo0V653W+1gJQbFG6WMCDlJXY4mzXK433ktRoU0nVSG9sCdYhQircyIs5UZvNNIvZDwnz3qQXmfy11wfiq4zZCGcUFrkHPexGYmJHgu45yWRoGonZl4GIW3jw/8EPBMGoYb6lULp/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByjMOJlw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578277; x=1810114277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n5ioBkaZUOJfCvdOjoBw0lwuVb9kUUxbFn9DAO17+8Q=;
  b=ByjMOJlwrQCVlWfP6x4pb767yEXqIBMjptaenDaQQi2jDH/cVHliJywJ
   vp4c02x6oARjM69cTFzEzzpjC1Uz/0zYk5vPTgHL90yWWuB/dIqBLlFbb
   xeznjXwVxtqJ3PSgtTnVMWkpEyI9XAxuebBN/YZRlflrSiMmu7WzFZ2kN
   c3Y6gszUlOBMHb7oK1Q7eqYCNWhjGJrVAcQnQ+teZYuBnRj3SO8G0PEl/
   sd/w5CFF/AvWKaipHIIIAVhYIMDJv1A7NjKfCEID0CeqTAySoDGPRa9Mv
   mQuJb2o5MnXIxXZp8VNgKhc0rnMx1WGdgm+j1c6fns+iUmvkBhj7AgekQ
   w==;
X-CSE-ConnectionGUID: 2vY/K6NXSUeozog4/9155w==
X-CSE-MsgGUID: DHT1HHG9Sl2JK7mykmUgWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79663246"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79663246"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:31:15 -0700
X-CSE-ConnectionGUID: 1X6lkBxBR5GOL9AcsgorzA==
X-CSE-MsgGUID: wMcPcmSmTkqZ0N1FI79ubA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231323220"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2026 02:31:14 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 2/4] i40e: pass the return value of skb_checksum_help()
Date: Tue, 12 May 2026 10:47:27 +0200
Message-ID: <20260512084729.1338557-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
References: <20260512084729.1338557-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60BA951DDBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287032-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Action: no action

skb_checksum_help() can fail. Pass its return value back to the caller.

Commonize this software path in goto.

Try calculating in software instead of returning error.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index cfaf724ee7ff..6e336696276f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3306,7 +3306,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
 					       &l4_proto, &frag_off);
 			if (ret < 0)
-				return -1;
+				goto checksum_sw_fb;
 		}
 
 		/* define outer transport */
@@ -3325,11 +3325,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
-			if (*tx_flags & I40E_TX_FLAGS_TSO)
-				return -1;
-
-			skb_checksum_help(skb);
-			return 0;
+			goto checksum_sw_fb;
 		}
 
 		/* compute outer L3 header size */
@@ -3406,16 +3402,18 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 			  I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
 		break;
 	default:
-		if (*tx_flags & I40E_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto checksum_sw_fb;
 	}
 
 	*td_cmd |= cmd;
 	*td_offset |= offset;
 
 	return 1;
+
+checksum_sw_fb:
+	if (*tx_flags & I40E_TX_FLAGS_TSO)
+		return -1;
+	return skb_checksum_help(skb);
 }
 
 /**
-- 
2.49.0


