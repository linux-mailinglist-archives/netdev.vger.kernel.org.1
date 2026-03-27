Return-Path: <netdev+bounces-272395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MWEDEwwxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC94C3404E9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE4C300EA99
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D13C4567;
	Fri, 27 Mar 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCX2vKYz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62E3BD220
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596164; cv=none; b=Dd9+UfJ0ghWOQoFWQHjjlOCy9CEArUW5MC+qsG67xYWGfhoWtC6cNG2Em0noybaiemTWcP2TcAekKBAppjRd/hzjvTTbxwV0TCQy0eyom/5fd3d45LmkBnQN6g0cU0w+nunbajYslN5HhJVwkCZj8rO/V3AkVCd/mkH7DNb4gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596164; c=relaxed/simple;
	bh=mq7XlXpgn0/xs417kIPdnPDkQnQ6eNBrcIwr3oNCFVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZ6Qmfpj1qsSFE/RoJ7s2UFarGTFmy6h/+Ttpzcn7L3ixpV5yZ2PBC0Nl6gTvjLN7fc5iFKtwB5WcwQ2KVI4KoduWkNTTPAh9eYKpYnEHVghJA71Rv93or2l6WngMufvaSpxSOsLwDlznvaiw5nmjjVgpnz/f1Sc+2YNG21d548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCX2vKYz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596160; x=1806132160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mq7XlXpgn0/xs417kIPdnPDkQnQ6eNBrcIwr3oNCFVw=;
  b=WCX2vKYzBbemp9IbpIAZD2h10k6xaB0fdoW21+2Hfhmc6ovAU2NuZQu6
   7sKU4FlbVbfj6Zs5OhnLezb4HXoN+YABVbgFhAE81eMNGAg/6R6nwNKgE
   SzjNpUiT5RakGjDqaRXuqOScRHGVLYF07lOh7L+FVPSbTUmJsNoj136/f
   YX9wVaqV89EzAqUMteRgrWZ+6zuj0nzPQpB3dEn9S4yTsNEAolQwOnHlY
   Auq9W7mv5/EBlBmqaEMC+Ahk6ZxiNHHvhyG6OKq4i5inkG4Kynowspewo
   L7l1ElV1AK+JS2JcGCNWEIW83g4jQlJA/BbiH1AElx445i+wN2jLwzawA
   Q==;
X-CSE-ConnectionGUID: irSZRHRhR1a7OhAph87PfA==
X-CSE-MsgGUID: r66fFf4ySku7LALZQ+xZfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848615"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="74848615"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:22:39 -0700
X-CSE-ConnectionGUID: SEKdx1RUQSC7x7iceut/Zw==
X-CSE-MsgGUID: YuYi9x8JS9CJl5OgN8heOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="222359409"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 00:22:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ice: do not reset MDD counters on VF reset
Date: Fri, 27 Mar 2026 08:22:33 +0100
Message-ID: <20260327072236.129802-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272395-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC94C3404E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Rustad <mark.d.rustad@intel.com>

Do not clear MDD event counters on VF reset, to be consistent with
how VF statistics are not reset either. This allows accumulation of
MDD events across resets so that persistent misbehavior can be
tracked and reported more accurately.

Fixes: 12bb018c538c ("ice: Refactor VF reset")
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 7d33f09..9bcc739 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -227,8 +227,6 @@ static void ice_vf_clear_counters(struct ice_vf *vf)
 
 	vf->num_mac = 0;
 	vf->num_mac_lldp = 0;
-	memset(&vf->mdd_tx_events, 0, sizeof(vf->mdd_tx_events));
-	memset(&vf->mdd_rx_events, 0, sizeof(vf->mdd_rx_events));
 }
 
 /**
-- 
2.52.0


