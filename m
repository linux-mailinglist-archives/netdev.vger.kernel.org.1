Return-Path: <netdev+bounces-148692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6B9E2E80
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DC728116F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8DE20B7FB;
	Tue,  3 Dec 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0yt0Ioc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180920B211
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262932; cv=none; b=m/nd6K0gDYpS+B9lZ2M/IqYhfbd88DbPSFEPwisK7CqGXTqAbc/G6YAx8aOuW0F+C6vd84sz1X/XVTYruBn3oJUDdzhnA7sTztFKuSJJOhaXvz1WG0Gi/H6h7AwbE1mnhS+tJevNM+/ZkQfDzRMuK70X+wyXwBJgvtdgQ9EG7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262932; c=relaxed/simple;
	bh=eYoEW8HEP1NUQ3Eg0xTvyVDj8p4/fSaltBZ3lgRxMdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj9AQdHuPMvmoPB0XEs+HJ4R1eYbgxxYUCL2Lz0PRlJOcULS0LbXvQhSX3BKtQj0bm5pGUAKu7hTGgTJTeGH56nc6B/wP9KBgWmc9KFG+bHvpQzYUo6trTYT81QwJFWeR4f7TehKqubqP+F/kVDC1R8azkFlU5zV419uSEncWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0yt0Ioc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262929; x=1764798929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eYoEW8HEP1NUQ3Eg0xTvyVDj8p4/fSaltBZ3lgRxMdM=;
  b=d0yt0IocBOEddpf2AWxmc8T/1rqFEZslGwomQgXrM4DMAzPCDK/LDzRL
   SHzCfAlXl2pqrYZUWoRpTtFGxvR36mrxF2yjd43VbkNzQxIOf+gF/3Xnc
   Newo3v31xjQxVwMjGApcNl2QBghsggo7Zl/UVcTetDAG2BsxdCafJCED2
   jJcd0tSc9P/ugM808lZ/egIJgZx/AL8tQZqj40deSCOho0i5f2D2fIwdQ
   tm0aWiVrYjoHdoIGkWE9gPLUKGUGOvgAQEcxa6wPchGdAhzVK1Tbwfsue
   bTeqJfHqqF2QL2KybobpiEP3ynfI7pkRZrcqZtCAhdYy5C1PO95txgtjZ
   w==;
X-CSE-ConnectionGUID: hAZFKOdZRIa1flgFl0oyEw==
X-CSE-MsgGUID: NGj9EG8eRteUBTu1utUBiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087106"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087106"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:29 -0800
X-CSE-ConnectionGUID: I0T3wVAVSK2V1jNxKYL5+g==
X-CSE-MsgGUID: 9L5s/xRZRgaNn18Z2RFgDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578864"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates 2024-12-03 (ice, idpf, ixgbe, ixgbevf, igb)
Date: Tue,  3 Dec 2024 13:55:09 -0800
Message-ID: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice, idpf, ixgbe, ixgbevf, and igb
drivers.

For ice:
Arkadiusz corrects search for determining whether PHY clock recovery is
supported on the device.

Przemyslaw corrects mask used for PHY timestamps on ETH56G devices.

Wojciech adds missing virtchnl ops which caused NULL pointer
dereference.

Marcin fixes VLAN filter settings for uplink VSI in switchdev mode.

For idpf:
Josh restores setting of completion tag for empty buffers.

For ixgbevf:
Jake removes incorrect initialization/support of IPSEC for mailbox
version 1.5.

For ixgbe:
Jake rewords and downgrades misleading message when negotiation
of VF mailbox version is not supported.

Tore Amundsen corrects value for BASE-BX10 capability.

For igb:
Yuan Can adds proper teardown on failed pci_register_driver() call.

The following are changes since commit af8edaeddbc52e53207d859c912b017fd9a77629:
  net: hsr: must allocate more bytes for RedBox support
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arkadiusz Kubalewski (1):
  ice: fix PHY Clock Recovery availability check

Jacob Keller (2):
  ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
  ixgbe: downgrade logging of unsupported VF API version to debug

Joshua Hay (1):
  idpf: set completion tag for "empty" bufs associated with a packet

Marcin Szycik (1):
  ice: Fix VLAN pruning in switchdev mode

Przemyslaw Korba (1):
  ice: fix PHY timestamp extraction for ETH56G

Tore Amundsen (1):
  ixgbe: Correct BASE-BX10 compliance code

Wojciech Drewek (1):
  ice: Fix NULL pointer dereference in switchdev

Yuan Can (1):
  igb: Fix potential invalid memory access in igb_init_module()

 drivers/net/ethernet/intel/ice/ice_common.c   | 25 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 +++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  3 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  5 ++--
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  6 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c     |  4 +++
 .../net/ethernet/intel/ixgbe/ixgbe_common.h   |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  1 -
 11 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.42.0


