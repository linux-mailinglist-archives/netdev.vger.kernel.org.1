Return-Path: <netdev+bounces-283877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIGIJTSx+Gk6zAIAu9opvQ
	(envelope-from <netdev+bounces-283877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6D24BFFB1
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12DBD3052D01
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461F3DF00A;
	Mon,  4 May 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTxx6nna"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E03DEAED
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904696; cv=none; b=QUoCdpf2mqvBEb9t3qeebgFpjGjnzGH1DpgrV9OWC25UZYDu525QRwRzLdbIfAVUZN3xq+CJ+fCwB+z7hl6LtnBoLpSoC3VINaaFelWiIgCkarfbdOJHWAc+hBNDrRyhiIbqlyq+u6P6gwpef1Vnvf87FLTTSmWLfzneTN5hWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904696; c=relaxed/simple;
	bh=u9QAqbxxkv4Jyk8sMgNMipr0e8IzMMKRqQwmVEF/39c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUmcXp/TtEp/OXY5oFI8eLj4PW2UTiURohRTAJkuU61qpE4i60W7hGbQLz/Ww+k55idBT8+yb1Hmy9c3D7zXWxOf7AkE/RgvcBxiULJIbGZYx5rttg6gzJ3vaki3nUmUEZSijrJGEixr8MiFpl1pK6rLyNuInr/wFJYX634lMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTxx6nna; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904695; x=1809440695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u9QAqbxxkv4Jyk8sMgNMipr0e8IzMMKRqQwmVEF/39c=;
  b=MTxx6nnauuEZuK01NPdvcga41j4/O3Tyc6nWj8SCl+UbwBv0haLEL/n2
   NqTc6UKozm7zruplnC8uJYC2ckUoRp2I9LT0aq9aQnxNxIhgARqc0vmXw
   Gt3MGngexx3eCUReKPztZ7MI+DZ35jtGQ9Aw0OvL3XJLCqT0g5a0mYY5/
   I9u0X1B+g9gGB+yNsE9QHkB/qCtFBaLEmx++QjaNysB2YAT6Gb8t35lhI
   VRfrFsJ/LmYB1ya/BCR3QvrKSjn70yP0X03VDYBz7y3Wzj8L/vlEg+KTp
   INlb7cTlI0pjwRPRhY6FXameciswshEU72D9ewvFvRsmPJySOA0Qm7Jnz
   g==;
X-CSE-ConnectionGUID: RBgjHAxzQqmcUuqSwyVIhQ==
X-CSE-MsgGUID: IB/IcDZhTGK6cu+HsmWKAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78691602"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78691602"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:24:55 -0700
X-CSE-ConnectionGUID: oNwi77ReRvqctkNN1Sebzg==
X-CSE-MsgGUID: b0dDRgZsRYmfnpDjojkztQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230935394"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 04 May 2026 07:24:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/5] ice: five small fixes and cleanups
Date: Mon,  4 May 2026 16:24:46 +0200
Message-ID: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB6D24BFFB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283877-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Three correctness fixes and two cleanups for the ice driver.

Patch 1 corrects a kernel-doc comment in ice_ptp_hw.h that described the
ETH56G MAC Rx offset field as unsigned when it is signed (trivial doc fix,
no functional change).

Patch 2 removes the PF_SB_REM_DEV_CTL sideband register write from
ice_ptp_init_phc_e82x().  PHY access is enabled by default on E82X and
the register write was a leftover from an earlier SWITCH_MODE workaround
that is no longer needed.

Patch 3 renames ICE_SMA2_UFL2_RX_DIS to ICE_SMA2_UFL2_RX_EN to match
the actual active-high hardware semantics and inverts the three use sites
in ice_dpll.c so that the logic remains correct.

Patch 4 replaces the static per-type frequency tables for CGU pins with a
single DPLL_PIN_FREQUENCY_RANGE(1, 25 MHz) entry.  The firmware defines
an any_freq capability for configurable CGU inputs, but the old tables
restricted users to 1 PPS or 10 MHz.  GNSS pins retain a 1 PPS-only
entry since they are physically constrained.

Patch 5 exports ice_dcb_need_recfg() and calls it in the four SW LLDP
netlink setters instead of memcmp() on a non-packed struct, which is
undefined behaviour due to uninitialised padding bytes.  The redundant
memcmp in ice_pf_dcb_cfg() is removed since callers now guard it.

Aleksandr Loktionov (2):
  ice: add correct handling of SMA/u.FL states
  ice: use element-by-element comparison for DCB config changes

Arkadiusz Kubalewski (1):
  ice: fix DPLL pin frequency range in CGU pin descriptors

Karol Kolacinski (2):
  ice: fix ETH56G Rx offset type description in kernel-doc comment
  ice: remove unnecessary PF_SB_REM_DEV_CTL write for E82X

v1 -> v2 updated mail subject with PATCH iwl-next


 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  13 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |   2 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  |  30 +++-
 drivers/net/ethernet/intel/ice/ice_dpll.c    |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 141 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   8 +-
 6 files changed, 113 insertions(+), 87 deletions(-)

-- 
2.52.0


