Return-Path: <netdev+bounces-160852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F5A1BDE0
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD3E188E782
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965971DC991;
	Fri, 24 Jan 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzY8eI5A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54321D8E18
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754340; cv=none; b=e0KHfz+gya4pGAV0YM4sMly0s51NdPSdxbkW+lBLGQLZMqxRbHMmdNcE88NLpcdA+MQy6dyoXQbWNmUlCSw71525iS9sZPbLpe2TPT0DOxZO10ofxtT8rUAaC4zJa0jKou2TRzWvd6OUu74ZLg9xuFKTcnYvrRYTtHID5P1RMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754340; c=relaxed/simple;
	bh=q2WLPddkIW8mplX8Y6BMNf9ZSFOEagNutqDg07mYe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dd0q6IhlLaaMy36A3XRfae5bww6o3rR39qRbI7c6miyzrkMD+XzhvSW7dLO0+wloJcuMrCyIjU62fdoSUETfco5x8UjfUi9CBrjbcCkc6OFzbwvY+1h9kDWSlD4jgXigwWtJ3R+TeBio/4y8+3A46qrTHcqEp7LUD+ozcFld1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzY8eI5A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754339; x=1769290339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q2WLPddkIW8mplX8Y6BMNf9ZSFOEagNutqDg07mYe0Q=;
  b=lzY8eI5A80rN600hioRErjsqzczoteR936yl87zWBD87uLjlWI60tXr+
   ZHjwRAW1lC5+mcj5D4QVguiNwE7emLnrDOgA1I1FtyJUUZt59Cyjt2O5H
   s8kWtu9Edda0XeDpTPzlx4FFMB0Y9QGPPCgcBfSpaFSFrdQl1DIMxovJu
   dbqr8RnfN+FmsaGytCzO6TTvI+dD3eZlOKdsprnPj/dN1SG2JlE4HdkvC
   +kWbHgtfcIKbXHu+BTo8B4QAnpjjsrYPKCAG28BfZiTVorgidpUym0uQD
   9ISsX0m2yZYdFJMWyUfK5/BbstJntPmZQv7hk1IM+f0szy70M6YYbW0zU
   w==;
X-CSE-ConnectionGUID: o1Ln+o3RQTyJbI8ztH8NQg==
X-CSE-MsgGUID: U2ZN8tsnShGSIjIvXkcSRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140376"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140376"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:17 -0800
X-CSE-ConnectionGUID: 8si73MqZRlyeeCBlOz/ErQ==
X-CSE-MsgGUID: Qw604W7rTdCt34TjsTUn+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861072"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:16 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2025-01-24 (idpf, ice, iavf)
Date: Fri, 24 Jan 2025 13:32:02 -0800
Message-ID: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:

Emil adds memory barrier when accessing control queue descriptors and
restores call to idpf_vc_xn_shutdown() when resetting.

Manoj Vishwanathan expands transaction lock to properly protect xn->salt
value and adds additional debugging information.

Marco Leogrande converts workqueues to be unbound.

For ice:

Przemek fixes incorrect size use for array.

Mateusz removes reporting of invalid parameter and value.

For iavf:

Michal adjusts some VLAN changes to occur without a PF call to avoid
timing issues with the calls.

The following are changes since commit 15a901361ec3fb1c393f91880e1cbf24ec0a88bd:
  ipmr: do not call mr_mfc_uses_dev() for unres entries
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Emil Tantilov (2):
  idpf: add read memory barrier when checking descriptor done bit
  idpf: fix transaction timeouts on reset

Manoj Vishwanathan (2):
  idpf: Acquire the lock before accessing the xn->salt
  idpf: add more info during virtchnl transaction timeout/salt mismatch

Marco Leogrande (1):
  idpf: convert workqueues to unbound

Mateusz Polchlopek (1):
  ice: remove invalid parameter of equalizer

Michal Swiatkowski (1):
  iavf: allow changing VLAN state without calling PF

Przemek Kitszel (1):
  ice: fix ice_parser_rt::bst_key array size

 drivers/net/ethernet/intel/iavf/iavf_main.c   | 19 ++++++++++++--
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  1 -
 drivers/net/ethernet/intel/ice/ice_parser.h   |  6 ++---
 .../net/ethernet/intel/ice/ice_parser_rt.c    | 12 ++++-----
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  6 +++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 15 +++++++----
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 25 ++++++++++++++-----
 9 files changed, 59 insertions(+), 27 deletions(-)

-- 
2.47.1


