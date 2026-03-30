Return-Path: <netdev+bounces-273375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIqzI80By2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C43623F3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7E4D30786FB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C43B7B8B;
	Mon, 30 Mar 2026 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSMygijK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E773E557C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911782; cv=none; b=BvgxXt8JI5u0XZ3WXZR7hgcj4L1WgHLFoPYrfVYxnEVlGtYtvR7jIDWCvcxBdTsDWO158dA3rjz/zTSKwpwI8+Gqyindhm7Prfn59cC6fCUZdNd0ac2MXsektFpC24IrkfsTALBRShIDH1aZQelN58qAhOmvuBGIqs8WAMGJnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911782; c=relaxed/simple;
	bh=vq+z8ImethqaZptbUjYXswqoBYsbAhgZEkNr+xaCQ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMc0peOD/WhOz5nhrL2SAp2pM0OWfJSK4LsmriJuFIh8owMrUgXYLMk/1XFz2X/qoDBZVzh5uycHx6gD32sOuEz8rCR97sMcqGyeIfnxX27FiNfX9QJfVdCxjFrgrzsyITlIq9KbQD/E5OoYbl3NCXIR6asl7lXWWmvmGFNiYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSMygijK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911782; x=1806447782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vq+z8ImethqaZptbUjYXswqoBYsbAhgZEkNr+xaCQ50=;
  b=WSMygijK1sAaB2ihNyaYD9mZUHf0cz5CCXZT0J7fAqnqnLQ7KBKGMgEH
   0rtZlKMJxKkHdIfLIMXGF6BlAx9dtAmklsRn9vJkKkghji6uivnISrDBp
   GbVVn9dilMkWePYXtDIsXpkuEAu4oNXzoTP1vIZ8Y2A6zRrS+764HHaJQ
   DAlEgt0cHfw2Io+idHCvN+prdVe+aidPkJeiWHV/w4d+Z1Z2HpVde/mYA
   uKyzyMbrYeNBTK9mJwsHckLsTGFsQgDxT4jBMjmL++GqXvzpd9FVRmnst
   xR007Ck/+q89D6Ekh0om/N3eVr3T3hgNXZevoFo4uXZeFNIyq+yG9nZGY
   w==;
X-CSE-ConnectionGUID: aC5feQEWQQWoSFZgkcswwQ==
X-CSE-MsgGUID: 1VPVi64NTKSfICqdjMDjrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297658"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297658"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:54 -0700
X-CSE-ConnectionGUID: JNCkhAZNSFiCULbm1A8trA==
X-CSE-MsgGUID: Y1TBDN6xRwO6baWBNANQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687750"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 14/15] ice: mention fw_activate action along with devlink reload
Date: Mon, 30 Mar 2026 16:02:43 -0700
Message-ID: <20260330230248.646900-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273375-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D2C43623F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Keller <jacob.e.keller@intel.com>

The ice driver reports a helpful status message when updating firmware
indicating what action is necessary to enable the new firmware. This is
done because some updates require power cycling or rebooting the machine
but some can be activated via devlink.

The ice driver only supports activating firmware with the specific action
of "fw_activate" a bare "devlink dev reload" will *not* update the
firmware, and will only perform driver reinitialization.

Update the status message to explicitly reflect that the reload must use
the fw_activate action.

I considered modifying the text to spell out the full command, but felt
that was both overkill and something that would belong better as part of
the user space program and not hard coded into the kernel driver output.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index c143e546dd8c..36314610927b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -726,7 +726,7 @@ static int ice_finalize_update(struct pldmfw *context)
 	switch (priv->reset_level) {
 	case ICE_AQC_NVM_EMPR_FLAG:
 		devlink_flash_update_status_notify(devlink,
-						   "Activate new firmware by devlink reload",
+						   "Activate new firmware by devlink reload action fw_activate",
 						   NULL, 0, 0);
 		break;
 	case ICE_AQC_NVM_PERST_FLAG:
-- 
2.47.1


