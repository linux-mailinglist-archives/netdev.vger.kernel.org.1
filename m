Return-Path: <netdev+bounces-272404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CnvL7MyxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 495EB340760
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D42D31A9C3C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DA3CAE7D;
	Fri, 27 Mar 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dciktQLz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA93C944A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596229; cv=none; b=C5Q3NBqAFqKJfLirKUl8QmqUzg01pCfpz8D3368STIMRzzee0TgGtk79e/U9ToZ+SCRGKZVknoIwStuJdpBCmrqoFrLXPi43irvPynn84dXSduyKoQGlQWgqNovztPY9CAsh70T31L92vRzWVG63OqFPAPQ7IgTHETBWzfsvwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596229; c=relaxed/simple;
	bh=2UNQ4rhnM15geXDEabeCEnD3chRO9ol4IHoKs85OO5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBnMVy+zoHRZbPM7PialwDropewcD8v7mV+CSK72SY4UHInwbtS6iGS7PDocGX76ghRyl/oZVlNFiKdfoED/LQb34+1tonONHy7mn+d5f0drdBY4VADBBPTnCvaZkSQCFsrbSfSkqfMr2tRTyH53xguGVQ7h0WIMVeB+SgxXG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dciktQLz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596226; x=1806132226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2UNQ4rhnM15geXDEabeCEnD3chRO9ol4IHoKs85OO5o=;
  b=dciktQLzbxEZRzZw4iK85keyS6iTMO6U2/tjLqjSMpMoPFvquHAPGm1Z
   6JmEjnO0VDJ8OJACqotnkpFyqYLUUoRvg90fijnDe+/dCtiLqHET6YIJ3
   mFjl6jEX4cGMvmcJ+CBP7m4/X9FpAYL4PgimJOZQ52gModBKnM2n1h7za
   t6VFS+iej/8oReMMesYiCQg+Zbl1g6FL3L3+ycMpZXtvlAEH1WcCinqDF
   5oSJkGqff9nyDT4A1+XUDd2ySPe9BcmLD+TDHBjsq47gn5IvEbtJYVeM+
   fO8ZkbxvRAjoaQ3iXNWU0ERqlq8vdKb47cJZbMwjxzxOJVwWitj5h5U9y
   w==;
X-CSE-ConnectionGUID: 3kv9o0F4RhalT3hrfa4k9A==
X-CSE-MsgGUID: Tvq4OTL8QeOrcBlWLAqorg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733975"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733975"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:43 -0700
X-CSE-ConnectionGUID: yXJSkaxCRrmA3SbECyKMvg==
X-CSE-MsgGUID: /kEvgtCPTr6pxTrnnaVeIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739106"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:41 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH net] ice: fix ice_init_link() error return preventing probe
Date: Fri, 27 Mar 2026 08:23:29 +0100
Message-ID: <20260327072332.130320-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272404-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 495EB340760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

ice_init_link() can return an error status from ice_update_link_info()
or ice_init_phy_user_cfg(), causing probe to fail.

An incorrect NVM update procedure can result in link/PHY errors, and
the recommended resolution is to update the NVM using the correct
procedure. If the driver fails probe due to link errors, the user
cannot update the NVM to recover. The link/PHY errors logged are
non-fatal: they are already annotated as 'not a fatal error if this
fails'.

Since none of the errors inside ice_init_link() should prevent probe
from completing, convert it to void and remove the error check in the
caller. All failures are already logged; callers have no meaningful
recovery path for link init errors.

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cf116bb..a6b0c09 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4856,16 +4856,14 @@ static void ice_init_wakeup(struct ice_pf *pf)
 	device_set_wakeup_enable(ice_pf_to_dev(pf), false);
 }
 
-static int ice_init_link(struct ice_pf *pf)
+static void ice_init_link(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
 	err = ice_init_link_events(pf->hw.port_info);
-	if (err) {
+	if (err)
 		dev_err(dev, "ice_init_link_events failed: %d\n", err);
-		return err;
-	}
 
 	/* not a fatal error if this fails */
 	err = ice_init_nvm_phy_type(pf->hw.port_info);
@@ -4899,8 +4897,6 @@ static int ice_init_link(struct ice_pf *pf)
 	} else {
 		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
 	}
-
-	return err;
 }
 
 static int ice_init_pf_sw(struct ice_pf *pf)
@@ -5043,9 +5039,7 @@ static int ice_init(struct ice_pf *pf)
 
 	ice_init_wakeup(pf);
 
-	err = ice_init_link(pf);
-	if (err)
-		goto err_init_link;
+	ice_init_link(pf);
 
 	err = ice_send_version(pf);
 	if (err)
-- 
2.52.0


