Return-Path: <netdev+bounces-263484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ORiKUt4p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:09:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EA1F8BB4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C04330A6DC7
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24084481B1;
	Wed,  4 Mar 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrQkGIAL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5921A95D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582890; cv=none; b=I49WYq+jry9econ1j/k/o9VTM0B0vH1XjeDPJEAcNFyaijFDZFoDAOVBAUt4KTf/gsylUPyYGBFHnZtWSV0+8Z/yRunumeo1ZsoPUebHsC+7nZFiaIFyi1mVrD8Y1qcaJL2TMF1fB7Vd4gV+Kdv4yoGU2ZSLfdLVBjPzAL6/l+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582890; c=relaxed/simple;
	bh=kxq6+3JYOHFtvxsXqsdbl04Ewrehj6mI0JF7hFELQgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuJxYe8Wmb+83HuBIV5T3fYzjNWz/LzOhLLgxeUFO9Q1LhpdSsm4u/NPY/uK5AG/HMtFS+7Amk2viF01iQsYpB9aSnVb6hP8v+x85wCDejM+DQpO2ZDUyfWSgHrUSJpp/Hf4aVvjZo7ZlWLZ3816gFkco3yTSyjjYNZTz/rsxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrQkGIAL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772582888; x=1804118888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kxq6+3JYOHFtvxsXqsdbl04Ewrehj6mI0JF7hFELQgg=;
  b=HrQkGIALedgNRGQ6+Bccxth3oQvPseBcc9wDRlDHiuN8lXurtWJCFUyz
   R9zVf1BGXs3J6DsQcnnP9cjLh+BfkHYqvEla3xoGEJKiaY4rv6RM7XPG2
   HWIB0OVDOWDaJrN8I5+bYEvVWf4xR94gfcMJTowQ7l3gXldNHTqxa2BhA
   CtQMiyYIBjEApJbGKKbvxILyMLNOKAiMQw8BWaK5UCzlMqlzypzPscvIA
   Ilp8cgQwY9J80qPAk5IBE4Q7ezqjgJp0m4ImifCk6sI5BLIDTa9xqP7Sd
   ZR9GZuMkArCIHQZ0yGOvsxJ4jV3TXnkd3QEzVX5mkuykE1fRMBfWvyUSg
   w==;
X-CSE-ConnectionGUID: nYRqA31sRkGrmp3gXspL1w==
X-CSE-MsgGUID: CIYDQl6eQY+yfzCSu7PleQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77243017"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77243017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 16:08:07 -0800
X-CSE-ConnectionGUID: hQT6uqk7RPSUpHs+x0VMcA==
X-CSE-MsgGUID: QnVHD0idRWuasrJRZrVT/A==
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver Updates 2026-03-02 (ice, i40e, ixgbe)
Date: Tue,  3 Mar 2026 16:07:52 -0800
Message-ID: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 217EA1F8BB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263484-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

For ice:
Simon Horman adds const modifier to read only member of a struct.

For i40e:
Yury Norov removes an unneeded check of bitmap_weight().

Andy Shevchenko adds a missing include.

For ixgbe:
Aleksandr changes declaration of a bitmap to utilize DECLARE_BITMAP()
macro.
---
v2:
- Updated patch 3 to newer version; elaborated the header in the Subject,
  added tag

v1: https://lore.kernel.org/netdev/20260302234105.2658400-1-anthony.l.nguyen@intel.com/

These originally come from this series; ice devmem/io_uring patches are
excluded while they are being updated.
https://lore.kernel.org/netdev/20260206174910.4066255-1-anthony.l.nguyen@intel.com/

The following are changes since commit ed0abfe93fd135dac223e87a3c945017b1fa8bfc:
  Merge branch 'net-phy-improve-stats-handling-in-mdio_bus-c'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Loktionov (1):
  ixgbe: refactor: use DECLARE_BITMAP for ring state field

Andy Shevchenko (1):
  i40e: Add missing wordpart.h header

Simon Horman (1):
  ice: Make name member of struct ice_cgu_pin_desc const

Yury Norov (NVIDIA) (1):
  i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()

 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 21 +++----
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 27 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 +++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 7 files changed, 56 insertions(+), 58 deletions(-)

-- 
2.47.1


