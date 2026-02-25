Return-Path: <netdev+bounces-260818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFL+JFS/nmn1XAQAu9opvQ
	(envelope-from <netdev+bounces-260818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:22:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF7194D9B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54184300C27A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146636EAB6;
	Wed, 25 Feb 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ll7KPv3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D61F30A9
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010938; cv=none; b=heUrCNMFgR2LNohpRkM0HBYr6EnqbmuEgjw8g1d28zY3YlsTOIZiEW3NB7ev9dsP4nTQMfnM4R1ca00THVSK06AarBMbjCoesBmtumtGaVaEko5uoTVmnuz4b00eHvx185bvO8LS0kZZ/ExXmtBugkVhL//EZWOww7g4CMFwQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010938; c=relaxed/simple;
	bh=DKAG1wPJpFmlhcmR96WVsVojidnrTLm5pSaQ3dE9lmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2JrW9YAEw5rAgzAI/5OTCXE+c9PdCVHcwzhWJf694U+mTu9k82GBEIWGDSBcQj6eDkCGofINcv3RfNq2hhftl6/puvlsRd+uDqulF+/TIpkylAu7OKf4A5FGPHFAinNG5Q1UkfPdmIuMZDZsRlHcZamibOYyyNH2laVBo/R2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ll7KPv3Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772010937; x=1803546937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DKAG1wPJpFmlhcmR96WVsVojidnrTLm5pSaQ3dE9lmc=;
  b=ll7KPv3ZiuKCbVmRqe3H1NF0EsQ2RvP8TjaPceWLApGt5umkS+/GPkCC
   WeniPTjzRQ5cJmlsb+ROi7kWrJL5rrQS88tXWq4ooULX2HHZrBXODzduP
   xd5na2dzK1XOeNHb5/syyQ3t/91j5FeBKbmji9ljVdFzo6xd/3L/IALiq
   tlj5BJ62vjgyi3vNY3+kaalYbVSLjb2ryuP7i7ePYGWSqgNl98xUF8xcE
   tynjGdhph4AypRRaDZNCXWbVyr2PCkvhjBA6rvj6aQvSThIRSc6p9+H3E
   301UM0OAmQjxBH33wmGslje6dbxnG8xxR8xkX5JIe+jMFbSY36BjSbx1l
   g==;
X-CSE-ConnectionGUID: fk3jAySZTH60wBeRZ9If7A==
X-CSE-MsgGUID: KcyyJGY1QQS1In4REye5qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72081448"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72081448"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:15:36 -0800
X-CSE-ConnectionGUID: zozFFWJDSU6sxOWJBMEAcg==
X-CSE-MsgGUID: cZhlqmQSQdKOi91W/j+4qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220774531"
Received: from korred.igk.intel.com ([10.237.113.2])
  by fmviesa005.fm.intel.com with ESMTP; 25 Feb 2026 01:15:34 -0800
From: Natalia Wochtman <natalia.wochtman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	grzegorz.nitka@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	Natalia Wochtman <natalia.wochtman@intel.com>
Subject: [PATCH iwl-next v1] ice: remove redundant checks from PTP init
Date: Wed, 25 Feb 2026 10:02:36 +0100
Message-ID: <20260225090236.187255-1-natalia.wochtman@intel.com>
X-Mailer: git-send-email 2.49.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260818-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[natalia.wochtman@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECEF7194D9B
X-Rspamd-Action: no action

Remove unnecessary condition checks in
ice_ptp_setup_adapter() and ice_ptp_init().
They are duplicated in ice_pf_src_tmr_owned().

Change ice_ptp_setup_adapter() to return void.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Natalia Wochtman <natalia.wochtman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d8fd01fa617b..2b26024de888 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3065,14 +3065,9 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
-static int ice_ptp_setup_adapter(struct ice_pf *pf)
+static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
-	if (!ice_pf_src_tmr_owned(pf) || !ice_is_primary(&pf->hw))
-		return -EPERM;
-
 	pf->adapter->ctrl_pf = pf;
-
-	return 0;
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
@@ -3315,10 +3310,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
-	if (ice_pf_src_tmr_owned(pf) && ice_is_primary(hw)) {
-		err = ice_ptp_setup_adapter(pf);
-		if (err)
-			goto err_exit;
+	if (ice_pf_src_tmr_owned(pf)) {
+		ice_ptp_setup_adapter(pf);
+
 		err = ice_ptp_init_owner(pf);
 		if (err)
 			goto err_exit;
-- 
2.49.0


