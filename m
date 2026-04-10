Return-Path: <netdev+bounces-277293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O/WBEWs2GkmgwgAu9opvQ
	(envelope-from <netdev+bounces-277293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EEE3D39AD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCAEE30479D7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A448C3A4F5A;
	Fri, 10 Apr 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5H6lYza"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D139E184
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807377; cv=none; b=PlhM1awYi2rKt0KgrkPfiBSxFYo8tyyh2v78eThn98E9n/7plyfDcrYoYpcY/KYO1BRIKqpZ3bDxDnp8UQtjw3nZP+jQ3Yu34oG6aeZOebf+/BsaaK9TJFS8HDBHn8vK61fbGdgQCG2hDdScyGMkIPuConlALzUSQcaSGhl4qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807377; c=relaxed/simple;
	bh=Vjt6TgEkz+Hi+x04cDH8D9yoeXuxBwErUs8ZL7dPxqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbQ1Yr6mT1W8+dvDW7LcTh31q8x1tPk8BVwBR1SiRYugEhuNpiP1pmAE2v0TWc1fnh5qDZ9PZ3ruCf+wCuQrF0DUwsEq5gUhZZDpG3vurxps5rH1OJ/EKLEbwuOQNWseYofgYTEQ2MnO1Yfa/NHnIXg9P1KWp6guCzDNK8+sdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5H6lYza; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807375; x=1807343375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vjt6TgEkz+Hi+x04cDH8D9yoeXuxBwErUs8ZL7dPxqw=;
  b=Q5H6lYzaDV588DvFIxHSk8l9AOXejXqA/ItVTlciDRPiWiC/taU0kChU
   vzWLSKRH/4FBDN50DeWZj0ujBNo7sIuCq8fG954tNF+MQ0P1Rq67L1G+/
   hwGG8WlaLlhPMEbXEts8aEohndDcAObd4dWnsn7TEn+Rn++nQ0fhMlg31
   fL0YRK4aU/HZibkOZeSjTHMNcITtwg7cKCuoGDXRx8hmae/n5XZ+42XoF
   RshxDpTt9XRk2FdmDm0WaTsEqrKH0upzVf9RD4Zt0MT5f4ZGUMNZsChgg
   0C1cfa9pK+9KfVEAKDAPkwtiFPOT2nkGRI6Gsdl9DjKuwIABGQ8W3yJsu
   A==;
X-CSE-ConnectionGUID: QPVuU7vvQgyhqGQsSpV17g==
X-CSE-MsgGUID: kWvwgw9fSciTlcMg+N5wbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007938"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007938"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:35 -0700
X-CSE-ConnectionGUID: wN2AYV0USvmh+28PDRlpPw==
X-CSE-MsgGUID: Ps2ZrExOSwiMhINq58Hfag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941894"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:34 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Karen Ostrowska <karen.ostrowska@intel.com>
Subject: [PATCH iwl-next 7/10] ice: emit user-visible info message for non-contiguous ETS TC config
Date: Fri, 10 Apr 2026 09:49:18 +0200
Message-ID: <20260410074921.1254213-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277293-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68EEE3D39AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the remote LLDP peer advertises a non-contiguous TC
mapping the driver silently falls back to a default single-TC
configuration. This leaves the user without any indication of
why their DCB configuration was not honoured.

Print an informational message at the entry of
ice_dcb_noncontig_cfg() so the user knows ETS with
non-contiguous TCs is not supported and that the driver
has fallen back to defaults.

Suggested-by: Karen Ostrowska <karen.ostrowska@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..1c53b09 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -712,6 +712,8 @@ static int ice_dcb_noncontig_cfg(struct ice_pf *pf)
 	struct device *dev = ice_pf_to_dev(pf);
 	int ret;
 
+	dev_info(dev, "Non-contiguous ETS TC config not supported, falling back to default single TC\n");
+
 	/* Configure SW DCB default with ETS non-willing */
 	ret = ice_dcb_sw_dflt_cfg(pf, false, true);
 	if (ret) {
-- 
2.52.0


