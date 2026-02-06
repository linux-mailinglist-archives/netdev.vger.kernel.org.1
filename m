Return-Path: <netdev+bounces-257637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDQlJKMphmmuKAQAu9opvQ
	(envelope-from <netdev+bounces-257637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:49:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A70061016AE
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56E6D3006931
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4421C425CD7;
	Fri,  6 Feb 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKNOpIsM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9143423175
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400157; cv=none; b=ndj79rk+vgZZpiicPWgP0cNjY+KivdVlTKeUmYi+mvuQWagy26qjFOaKz6x4Advjl3hG2wuVGDVRTtFjF2jPMQpmNA+g7crfQQs3Xjg2h+wnTaNChtHa2eWUFv9Qys/tVGOfZ9J5lwXSStU1PnMhmeljzfwKZDP7f9a2KBKlpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400157; c=relaxed/simple;
	bh=7aJt80MDnSAEooV5fvKbY3JD+g8PQ/KRwWjukCxJHkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOIa35Blw0AhtOYJp+no2WbkbUkFXnqn+0bO0pmIjI83tY6WHJMsUlnO5BEk46X0Q6wtYyPBGp3SzvT9pH7eWMLo9kIJIp3CmlT10wuMDsi/yyqblqQJDhJ3PsnPB2hRWrnBsMMvThc8WNO6+s8xtoy1nW0+xfJ0A6xWgZa1QgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKNOpIsM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770400158; x=1801936158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7aJt80MDnSAEooV5fvKbY3JD+g8PQ/KRwWjukCxJHkQ=;
  b=nKNOpIsMDNZbh071hIJUKvn2x8j8PliRdye6lL0NdE5T9n4V4m/x6wsG
   SUh1CzA9kYS7bifwfEEZ4GqoewoRs2U61b3g2b6ap4yaq+JvwARvelHNn
   3dObKzcUp1kNsnbawcdrqPYjt/Jz1ocJxtRVvFQBEnxH+pqrCrkX9Ml95
   spXdsE4rlUMEGtrqBCQJaNonBpPRiAgR3VjGKVHZUgLEafgN1kAvwKtAS
   X2EwSokpjVa1sPwHKe0UzTic7S4Y1pK2nF/7HxmgYDLkKrKoOX0dToG2T
   s0aY4aYN7CMt3sH2Uez71PiPCJlCp3TZFlFm1bLq7z3n1l/NEB1gpybtn
   A==;
X-CSE-ConnectionGUID: O/28bNLQSUel7c0+41oelg==
X-CSE-MsgGUID: d9KyHzixR0ylvzKC03t6tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71793093"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71793093"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:49:17 -0800
X-CSE-ConnectionGUID: 80oexGaySaKcRJ5g4qhJLg==
X-CSE-MsgGUID: Y8jXKgrFQ8eMRZOMH9FAug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215495387"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2026 09:49:16 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates 2026-02-06 (libeth, ice, i40e, ixgbe)
Date: Fri,  6 Feb 2026 09:48:57 -0800
Message-ID: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257637-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A70061016AE
X-Rspamd-Action: no action

For libeth/ice:
Alexander adds support for devmem/io_uring Rx and Tx.

Quoting Alexander:
Now that ice uses libeth for managing Rx buffers and supports
configurable header split, it's ready to get support for sending
and receiving packets with unreadable (to the kernel) frags.

Extend libeth just a little bit to allow creating PPs with custom
memory providers and make sure ice works correctly with the netdev
ops locking. Then add the full set of queue_mgmt_ops and don't
unmap unreadable frags on Tx completion.
No perf regressions for the regular flows and no code duplication
implied.

Credits to the fbnic developers, which's code helped me understand
the memory providers and queue_mgmt_ops logics and served as
a reference.

For ice:
Simon Horman adds const modifier to read only member of a struct.

For i40e:
Yury Norov removes an unneeded check of bitmap_weight().

Andy Shevchenko adds a missing include.

For ixgbe:
Aleksandr changes declaration of a bitmap to utilize DECLARE_BITMAP()
macro.

The following are changes since commit 24cf78c738318f3d2b961a1ab4b3faf1eca860d7:
  net/mlx5e: SHAMPO, Switch to header memcpy
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Loktionov (1):
  ixgbe: refactor: use DECLARE_BITMAP for ring state field

Alexander Lobakin (5):
  libeth: pass Rx queue index to PP when creating a fill queue
  libeth: handle creating pools with unreadable buffers
  ice: migrate to netdev ops lock
  ice: implement Rx queue management ops
  ice: add support for transmitting unreadable frags

Andy Shevchenko (1):
  i40e: Add missing header

Simon Horman (1):
  ice: Make name member of struct ice_cgu_pin_desc const

Yury Norov (NVIDIA) (1):
  i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()

 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  21 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |   2 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c     | 259 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_base.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 150 ++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.h      |  12 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  55 ++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  43 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  13 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  27 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  56 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   2 +-
 drivers/net/ethernet/intel/libeth/rx.c        |  46 ++++
 include/net/libeth/rx.h                       |   2 +
 include/net/libeth/tx.h                       |   2 +-
 23 files changed, 527 insertions(+), 183 deletions(-)

-- 
2.47.1


