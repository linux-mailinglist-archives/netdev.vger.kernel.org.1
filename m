Return-Path: <netdev+bounces-279186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IuMIdCE4WkiuQAAu9opvQ
	(envelope-from <netdev+bounces-279186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6D415DE9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20A9C30164B8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6D22CBE6;
	Fri, 17 Apr 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHKXWbq3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA461F7916
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387272; cv=none; b=Nb/OaOrToDNt9PI/wwkOYXbrAPJcioJ3eAtSTy39aQ581Uy6WBLmRoUlOwE6unK9FMlvqF+kyJ1X6VT/b68Xt7wYK5r8uqU+LCR1/EH4Dixqp8q3b9qpuqBKxWXDDiDjfR1R5O1QUjfrwA2wchSvHr4IngGLylsUl426RU5kp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387272; c=relaxed/simple;
	bh=pRXRLVKkxNP9ty4GHnvPN4qdvPEfo/F+aomA0wjq8J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z85po5waCa7R5ShgJIr3SxUKFCDxvjQNeFdYMeeMD0t9ZcthARJFhN4C/k9+kehg22NbwJD7C666LzHb2CuXb0/oSa4DmYWZPnjYlpKjN++9t4qvq8hvoSw66qFAwnxwFYZlpaFDYGULP0BdJCdImRSwsvL7PXSAUZftf0rLZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHKXWbq3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387272; x=1807923272;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pRXRLVKkxNP9ty4GHnvPN4qdvPEfo/F+aomA0wjq8J8=;
  b=WHKXWbq3ZFbByQPwvTlUnELmxqKQbj4xIm7Sql3koxS5RQTDtMHRRSwW
   vattJY1L7U67vVHczc4DZkOIsCDVpB77FVIyUWeNBxUz292YOuO6EJism
   OEJNDBm6FYQZss33w3mn/Pd6fqkLUbY0NOMinktDVLMSTBm2spTEq+j5+
   /UkkTxvVh23RPQnCK1KT+3EO/haaqfKB6fh4Lh2SBES3RJbVsUZpFNjK0
   iQoDIG0gsaeNmTaqf0exetuSzdMYkZalI+jMPZE67fIp2O0vXH0qDFaSk
   oZ4irzTTLjGdO2wUkfvw0GV8E7RIfi41kqCiuG21smh+pIQuReL/shj+9
   A==;
X-CSE-ConnectionGUID: Q4V/Mrz0S6uW8acGrIO4fg==
X-CSE-MsgGUID: qbHVHQE9Q6OqrTnQq8jjuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000517"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000517"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:29 -0700
X-CSE-ConnectionGUID: 9OnvuBmlS/qjQHQ0O63ziw==
X-CSE-MsgGUID: v9mNcFgGSZ2DRGnpdeH94g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539857"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:28 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Apr 2026 17:53:25 -0700
Subject: [PATCH net v2 01/12] ice: fix 'adjust' timer programming for E830
 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-1-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=H3P8fzVxrJmGeQKF2xsi1ttFur3posTYqD0A8Ls/M6Q=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLQesZt2+d16pcSnzHPbsI6sfpWV7L7zfvbD3hcDZ5
 4fPPZi2s6OUhUGMi0FWTJFFwSFk5XXjCWFab5zlYOawMoEMYeDiFICJSM9m+CvttHeHlvf6uX7/
 o3rYnvvblIqwWTnEPNpl8q+67cBuj48M/1Q2TLvT/YxbYwMny0HT314/Eje21Wj4aXJd2ftk44a
 JzcwA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279186-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,intel.com:dkim,intel.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23E6D415DE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Fix incorrect 'adjust the timer' programming sequence for E830 devices
series. Only shadow registers GLTSYN_SHADJ were programmed in the
current implementation. According to the specification [1], write to
command GLTSYN_CMD register is also required with CMD field set to
"Adjust the Time" value, for the timer adjustment to take the effect.

The flow was broken for the adjustment less than S32_MAX/MIN range
(around +/- 2 seconds). For bigger adjustment, non-atomic programming
flow is used, involving set timer programming. Non-atomic flow is
implemented correctly.

Testing hints:
Run command:
	phc_ctl /dev/ptpX get adj 2 get
Expected result:
	Returned timestamps differ at least by 2 seconds

[1] Intel® Ethernet Controller E830 Datasheet rev 1.3, chapter 9.7.5.4
https://cdrdv2.intel.com/v1/dl/getContent/787353?explicitVersion=true

Fixes: f00307522786 ("ice: Implement PTP support for E830 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 61c0a0d93ea8..5a5c511ccbb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5381,8 +5381,8 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval)
  */
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 {
+	int err = 0;
 	u8 tmr_idx;
-	int err;
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -5399,8 +5399,8 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
 	case ICE_MAC_E830:
-		/* E830 sync PHYs automatically after setting GLTSYN_SHADJ */
-		return 0;
+		/* E830 sync PHYs automatically after setting cmd register */
+		break;
 	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_adj_e82x(hw, adj);
 		break;

-- 
2.54.0.rc2.531.gaf818d63126a


