Return-Path: <netdev+bounces-281954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNoPE+XU8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:40:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB8488151
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8A7A307374B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34439769A;
	Tue, 28 Apr 2026 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjhVI0Dl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59C37F01E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390665; cv=none; b=qe1jlHuV6Tg7ThNmE5CrI7cm5g5g4FgE8TwENWG7G1lBKlOoDEM6o9NAxwRtjj1hs6Ffi8DqbzQ2efEnCm8RQ1UgW3BkM4bbiFpr6SuCoeiidJK3vdrgHITk38os59f8H4fLwk0AhYNSg/nhY00sQOolQGnD+HbnRzL6VFxCBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390665; c=relaxed/simple;
	bh=lZysSydj+EKtcOyV7KppuvUFFO62gMAX1S0NABtoLt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WeG/XiMWGwZbVwMNCaYXjHG1K+SNx7HTbbde3bA4Gx4dPsVmy2bdw5cPjRDg85xA1hRrPq+FBb2z2gNaEacWXrRvOMcWmrOstsnOZaaox+6wxKS9FKCxFWHAl6WTUMNiDAUNU+5SKQUR0a4OZee9Q7CbhdzSQ8b+vFPhA+b0eFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjhVI0Dl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777390663; x=1808926663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lZysSydj+EKtcOyV7KppuvUFFO62gMAX1S0NABtoLt8=;
  b=OjhVI0DljP6BDWWpqZNbVDeXDJSAwif0LAfmZ/vh4YI4oW3ZwhQKaC7L
   IbDwaVehvuiN8igHkqrLKEnBdotZPv2GqoXrBtI6kf23HBc1CyrMC8uJT
   vS8Q+nW6yKzVpGlBolxWnqIye70nAXOLY7IkJNwB0KmTuMtwWsT7Qwdud
   boUmJQ61ZFj5Gu7nwPULdVG0Ak6z4IWz+MvafJL9G0IqtnKKS6QXq8GPJ
   Vo1ezSalGFxv3ecCwlWn9yucqr27pvdQf0JlFPXeZJ2xJsHlndQ8yOIMm
   +K1tNB1r6IugfAEJEb5g7pytdMWUNCHxnbDhfmeXnBUBAnX+WwIul0iFb
   g==;
X-CSE-ConnectionGUID: 1jliAQsdRFG6v7UCId0RrA==
X-CSE-MsgGUID: 6lZuNPKoTGaBdU8kvIKPdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78415115"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78415115"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:37:42 -0700
X-CSE-ConnectionGUID: z2rmiHdXQIqHuvh2/bfVnA==
X-CSE-MsgGUID: iHevdCFEQVGaHrl2C0o30g==
X-ExtLoop1: 1
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2026 08:37:41 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AEBDE312C0;
	Tue, 28 Apr 2026 16:37:39 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	paul.greenwalt@intel.com,
	jacob.e.keller@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 0/3] virtchnl: add extended VF capability flags
Date: Tue, 28 Apr 2026 16:37:13 +0200
Message-ID: <20260428143716.9653-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3DB8488151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281954-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

VF capability flags in struct virtchnl_vf_resource::vf_cap_flags have
all been used up, preventing new flags from being added. Unfortunately,
flags size cannot be easily increased, as virtchnl message size and structure
must remain unchanged to not break ABI. Instead, add a new virtchnl
message to handle passing extended caps. Make it flexible size, so new
flags can be freely added in the future, without changing virtchnl
interface.

Overview:
1: Clean up unused defines that are in the way
2: Do most of the mechanical changes required to store flags in bitmaps
3: Add the new virtchnl message

Marcin Szycik (3):
  virtchnl: remove unused defines
  virtchnl, iavf, ice, i40e: store VIRTCHNL_VF_* flags in bitmaps
  virtchnl, iavf, ice, i40e: add extended generic VF capability flags

 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   4 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  68 +++---
 .../net/ethernet/intel/iavf/iavf_prototype.h  |   3 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   5 +-
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   2 +
 include/linux/intel/virtchnl.h                | 120 ++++++++---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 160 ++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_common.c |   7 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  96 +++++++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 185 ++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |  11 +-
 drivers/net/ethernet/intel/ice/virt/fdir.c    |   2 +-
 drivers/net/ethernet/intel/ice/virt/queues.c  |  13 +-
 drivers/net/ethernet/intel/ice/virt/rss.c     |   4 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    | 195 +++++++++++++-----
 17 files changed, 667 insertions(+), 214 deletions(-)

-- 
2.49.0


