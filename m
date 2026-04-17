Return-Path: <netdev+bounces-279187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO0PGCeF4WkiuQAAu9opvQ
	(envelope-from <netdev+bounces-279187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B6415E15
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80DB4307D97A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B583623BD02;
	Fri, 17 Apr 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnjZB6is"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2E21ADC7
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387273; cv=none; b=V394mPAoTQp357OGfmXnAqAbEWa0Cn8Dj23uOde26UAwsG+b7NWT2DQw1IgOgS9JO6tWCt6KxmCR940PR6V5R98GsWuRGPYuG1TbQHz370oihFj6GLZ3Fz+THs3QJ7FP33WW8yUAh+iz8Xxua+xQDqA/QfX2bYcKE1i78h5kJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387273; c=relaxed/simple;
	bh=mcP/ZQeXVtuGn5N1mPaRZgXnpPs1geabyy2iPu4OIXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvRyoJqDusWTzYXvduJGHN7ZqBshOcO011oUyMPhPA+vxG1rmCfRqgcLouCMH5CxgWBSf9qvIQg0z4uZzJ4HF/xJFIR01t9auGRdpzfYAbhN6gDf1/1IlTI5WS4bih5do0wYu6sDwRFnTpj/fvN+P9JvYlLLrGNx17VkwdctzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnjZB6is; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387272; x=1807923272;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mcP/ZQeXVtuGn5N1mPaRZgXnpPs1geabyy2iPu4OIXU=;
  b=OnjZB6isks1uYGMg/aE+ts5WP/ZLdcFU7Mh5yceCbzuV/6iq+znKCEys
   psquhKvdqqvWpapZxkxxqd93M34aSsx5liZH1JW3JCgY44EfECengX6c2
   PcdMximVa5FQ4wV/A9sgloJeKlvEIeFvy4kQaf2RjFEZXn8TP6ctALGUX
   YfWZIBBoFnZ9XHFb67S3rOdMpueCu7Vx4mzOzQVUS3lDK19hBvpAvzDxK
   kuPjOF1lGHZPXn2BcbGt5a930m2FYZO9EgawYKbHu0aB+NPOAesbt9oFg
   SXDeV9yNB3eLFsPBjhH88cr0V2FWGGndlmbzEIgDMUs0Pbv0yaEN2Po1u
   g==;
X-CSE-ConnectionGUID: +Pk7VM4MRtipmRYQ98OIjQ==
X-CSE-MsgGUID: aL4HoGlgRUOXdEfQVhWsMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000522"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000522"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:29 -0700
X-CSE-ConnectionGUID: iPYv7qjHSROYmBWq9BEbKA==
X-CSE-MsgGUID: iUaCh6bgRsKEHllTAOjegg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539860"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:28 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Apr 2026 17:53:26 -0700
Subject: [PATCH net v2 02/12] ice: update PCS latency settings for E825
 10G/25Gb modes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-2-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Zoltan Fodor <zoltan.fodor@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2954;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=DLl5X7zWpRqrVfTq759wmyBr3GgTeUl65y7FfpM3dcc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLQeZbQJyDMzlov7v49m7StP3S8fDkArpc8dOBkewv
 nm3v/tQRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABOZbsbwP+UnD5/9jxYNEcGU
 77Msdyx2Srwp8Dk44Ij1X5lPk761r2Rk+Dn7kHhCjkihp+3+G7Lhh7/u3KjgIXPmSI8kJ9e+8rk
 OrAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279187-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D26B6415E15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Update MAC Rx/Tx offset registers settings (PHY_MAC_[RX|TX]_OFFSET
registers) with the data obtained with the latest research. It applies
to PCS latency settings for the following speeds/modes:
* 10Gb NO-FEC
        - TX latency changed from 71.25 ns to 73 ns
        - RX latency changed from -25.6 ns to -28 ns
* 25Gb NO-FEC
	- TX latency changed from 28.17 ns to 33 ns
        - RX latency changed from -12.45 ns to -12 ns
* 25Gb RS-FEC
        - TX latency changed from 64.5 ns to 69 ns
        - RX latency changed from -3.6 ns to -3 ns

The original data came from simulation and pre-production hardware.
The new data measures the actual delays and as such is more accurate.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Co-developed-by: Zoltan Fodor <zoltan.fodor@intel.com>
Signed-off-by: Zoltan Fodor <zoltan.fodor@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 19dddd9b53dd..4d298c27bfb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -78,14 +78,14 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.blktime = 0x666, /* 3.2 */
 		.tx_offset = {
 			.serdes = 0x234c, /* 17.6484848 */
-			.no_fec = 0x8e80, /* 71.25 */
+			.no_fec = 0x93d9, /* 73 */
 			.fc = 0xb4a4, /* 90.32 */
 			.sfd = 0x4a4, /* 2.32 */
 			.onestep = 0x4ccd /* 38.4 */
 		},
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
-			.no_fec = 0xffffcccd, /* -25.6 */
+			.no_fec = 0xffffc7b6, /* -28 */
 			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
@@ -118,17 +118,17 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.mktime = 0x147b, /* 10.24, only if RS-FEC enabled */
 		.tx_offset = {
 			.serdes = 0xe1e, /* 7.0593939 */
-			.no_fec = 0x3857, /* 28.17 */
+			.no_fec = 0x4266, /* 33 */
 			.fc = 0x48c3, /* 36.38 */
-			.rs = 0x8100, /* 64.5 */
+			.rs = 0x8a00, /* 69 */
 			.sfd = 0x1dc, /* 0.93 */
 			.onestep = 0x1eb8 /* 15.36 */
 		},
 		.rx_offset = {
 			.serdes = 0xfffff7a9, /* -4.1697 */
-			.no_fec = 0xffffe71a, /* -12.45 */
+			.no_fec = 0xffffe700, /* -12 */
 			.fc = 0xfffe894d, /* -187.35 */
-			.rs = 0xfffff8cd, /* -3.6 */
+			.rs = 0xfffff8cc, /* -3 */
 			.sfd = 0x1dc, /* 0.93 */
 			.bs_ds = 0x14 /* 0.0387879, RS-FEC 0 */
 		}

-- 
2.54.0.rc2.531.gaf818d63126a


