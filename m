Return-Path: <netdev+bounces-263485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLoxAE54p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:09:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB21F8BBB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F1030A8191
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6061A76DE;
	Wed,  4 Mar 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujlq7AQu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD0137923
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582890; cv=none; b=le4NoN1TkAAfC+oxTiDQwRamw5BTPtth6LR7Sk6Ooa937v/4/Op7DtVbtddLbZWsCZvuqopC4JNob/SzpNpc0lKyikBggstbRzeKKbcLfhsXhIy5v8B9Ek2ztDHsDTJebog+oIKWVbJDd3egn0KoQepu9hpOa9+L1ObflLSt4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582890; c=relaxed/simple;
	bh=3EqNLmGYdK07Nvb4QPCRHEHBdf176duRygvrckSCedQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqF9slQ1YwN4RfZLiWNn2Tbc/WtPLifA0pT8L0sDNyQEjWjNp8wSbqAzZbAPjPfEvMKeXZ7SS2czfXDanoQEKzZHQxpuEMQ0x6lOKUyt7Ky+CoPUlmvcBvceeZAHB5mGaDj8SDzAH5hzYAG1FC5h6mUhXUCyqLlKNxWjoK5s+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujlq7AQu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772582889; x=1804118889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EqNLmGYdK07Nvb4QPCRHEHBdf176duRygvrckSCedQ=;
  b=Ujlq7AQuadSg9bJxZXDuJCbicftX0oyA/BzkDzl9ETROITQXVJnRK9mg
   8R/DH2za1o0ES0IGxMlSJAYkkagkzmfsltIefQUiu1MKLJK0QOeJz9PAu
   f6bgHLPzGhg7ayFmHRlsVTjQJkjXGM2lbzRLRDuGTVb2AqsdHNcuIlJTb
   tfvWlMW/dgYTcI9p3g5lO4Xt+aveztQNPoQ9N7QjpPjmNrTXexfUHIV38
   ANcSZx3rQmGPLEsgkD4ha4kDVTiteb1fuU/1c2kLtKRquUEtyit06XFEu
   j4NCIEk5avAamc2xT2jaQuHunasn/zNpWoSWk2OwCr3O1pynaxLgA4TGa
   A==;
X-CSE-ConnectionGUID: pazMXOkORN6U4tudGETmgQ==
X-CSE-MsgGUID: MOhnhY1lR22TTAfpqOQxDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77243023"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77243023"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 16:08:07 -0800
X-CSE-ConnectionGUID: BtlpwJeMSs2B/Kg8BSEUBA==
X-CSE-MsgGUID: 1tPZeTDOTyyx3gKugmRVrg==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 03 Mar 2026 16:08:06 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 1/4] ice: Make name member of struct ice_cgu_pin_desc const
Date: Tue,  3 Mar 2026 16:07:53 -0800
Message-ID: <20260304000800.3536872-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
References: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77FB21F8BBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com,molgen.mpg.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263485-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mpg.de:email]
X-Rspamd-Action: no action

From: Simon Horman <horms@kernel.org>

The name member of struct ice_cgu_pin_desc never modified.
Make it const.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5896b346e579..9bfd3e79c580 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
 };
 
 struct ice_cgu_pin_desc {
-	char *name;
+	const char *name;
 	u8 index;
 	enum dpll_pin_type type;
 	u32 freq_supp_num;
-- 
2.47.1


