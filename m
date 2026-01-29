Return-Path: <netdev+bounces-254876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJaDDwWae2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:33:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD6B2F2B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23C3030039A0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6934D385;
	Thu, 29 Jan 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZdCRG/G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7E35294A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708035; cv=none; b=JCEpaQdItJj+u+YEg0oAvwc9VrJE9UGoOtdAYlsA1ixxmOSnras6VrHygE79F8p8iqYqqL/ZxbIpJIjvTLpLfnkjhwD3Z/GAECdphbZsmKUGDdd6bXBlT0kl0x8AmkuHKILF8jqDRgvk5gMWNjZeTJndy1SQf+c5bW67/pS9dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708035; c=relaxed/simple;
	bh=wvvhLxpUEzjH/aPyrEvcmEFhPUBwZcBiCHVY0w9yFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooVhGf4kPW2UH9ja+j7DCFHLUtD7hQ8dcdzQSld7pmjd/BJX9k80r8ZSSzmhxQIfYmsV305urTmrVx3s2i5XASexiJGKXY8dtQjx8dQ8Gaflte0jFCRMvWbXtu08apmz5PNbLl2QH8HUTbX6nhwYj6t7PwdB5K2kT57k1MKGyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZdCRG/G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769708034; x=1801244034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wvvhLxpUEzjH/aPyrEvcmEFhPUBwZcBiCHVY0w9yFpE=;
  b=FZdCRG/Gwx14Pd84GDbv8mLeSHsoO8yuMXlBASbV8b8BNsOxLkeFNY+q
   NzdqQa1gBMXGa7RaMs6+kI2HR+XlkhyCgo14S0ymVmOl/1SbxAVnDWCMk
   Bw5wNzfaP3zw24wy+rQl3JmXucTziMqLBuq+6Y/00UXw9dyu61Wp80OoK
   mL2LiwnNq7fPgm0pc8CVfijpXCzTRzvnUBaSY8dB3X+QKi6G9D/8NOW2y
   GerPONdZVhaUm2Svxw3kV6thNGI3qinjh5FbX/j3gd0nOHbD2kFRuYMuL
   msWqCTBdljUw8qy9Glc2g9r4K8xrAMwiU9i/8AquxRSXNWXM1NOu6ftQ6
   A==;
X-CSE-ConnectionGUID: iOrbVDjCTzGXkR/xeOckKA==
X-CSE-MsgGUID: qrxDrJdQSByps0ZPEacu5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70669871"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70669871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 09:33:53 -0800
X-CSE-ConnectionGUID: 4X0A2IIfTjq0eptgPZDixw==
X-CSE-MsgGUID: TehO8w2/S227xSzpkeJksQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="212714930"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by orviesa003.jf.intel.com with ESMTP; 29 Jan 2026 09:33:52 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next] ixgbe: e610: remove redundant assignment
Date: Thu, 29 Jan 2026 18:54:55 +0100
Message-ID: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254876-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C1FD6B2F2B
X-Rspamd-Action: no action

Remove unnecessary code. No functional impact.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c2f8189..6f380fc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -142,20 +142,14 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 			  IXGBE_PF_HICR);
 
 	/* Read sync Admin Command response */
-	if ((hicr & IXGBE_PF_HICR_SV)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+	if ((hicr & IXGBE_PF_HICR_SV))
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
-		}
-	}
 
 	/* Read async Admin Command response */
-	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
-		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
+	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
+		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
-		}
-	}
 
 	/* Handle timeout and invalid state of HICR register */
 	if (hicr & IXGBE_PF_HICR_C)
-- 
2.47.1


