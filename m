Return-Path: <netdev+bounces-107290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2291A7AB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F2A2830FE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38718E772;
	Thu, 27 Jun 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJVppQjj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF6187356
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494324; cv=none; b=iEyMJKDXsU79CEIDdYvQl2r9Wv1wR52y0zfk3umgasleGVXyM6BMN8QBerfzgDo2z4Pm5/2WLvjiOtYTfFMJiYHuXZLAjOQ7YONncYUFVzwV3KKiJkImHUbNHpKiizewUFdFhd06MZYRMkr4H8m1FJU8+YSuZcG6RF+8x1g+G7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494324; c=relaxed/simple;
	bh=CuGXgtBKOL2G2NvU1k0XYyLxojsLJ6yNufSIEaUfRZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NEUheN02ldYYoBUWwyn0fFvEEKY3DFuahM2JxxFKm+qt/BDRzgFaZVkIrYK9/iayy2wmPP4g0t9QMg1dkZ6ykHz9VrXOkngDCZ2JhmPANbJC+mW2DFC72ndPWgS4zsMgG59Ji3Tb3ytunWQZpk26BV2mQJ/xwb1c/MNiRZKywsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJVppQjj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494323; x=1751030323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CuGXgtBKOL2G2NvU1k0XYyLxojsLJ6yNufSIEaUfRZ0=;
  b=dJVppQjjSLdNPjrZ3XuZIW0WV1RXNn9UvS/p9gmmkxtzSDaSoXu+htlD
   /1bXYjHeBnXKnwRA7Ot1KOzuotIUB1K0+UGwqFuo+9t4R99xhjuhBx/VK
   NepRNKAx0XAHRg9cFmI01BJ0A7FV5caRyzkZp0M3COfkJ+/riwnzRHkMI
   RAU36xTCfinyE1vHQNYzZrToDJJbAOK+9zjt5P1mmFuEx8NQPr4+WjeeX
   rzloOU9GIjDKbzMViB1vMndjNffeteF++jbJyvcnMsBtzt7SWqnPwCZsw
   RAXBn10gOltp0lGdZkJnUntnl8ZcAn2mRBe8XzxZ+4gmlVBUZgz17i0MO
   w==;
X-CSE-ConnectionGUID: IgOMVUbzSx+vh9vZhqTa9w==
X-CSE-MsgGUID: sUwtqeMvTFWcgIB0yAbizw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452327"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:18:42 -0700
X-CSE-ConnectionGUID: gS+2ox90Tp2qH/kRzOX02w==
X-CSE-MsgGUID: ue7M6aKrSF6M5fFXf4t3LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315363"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:18:40 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 iwl-net 0/8] ice: fix AF_XDP ZC timeout and concurrency issues
Date: Thu, 27 Jun 2024 15:17:49 +0200
Message-Id: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

changes included in this patchset address an issue that customer has
been facing when AF_XDP ZC Tx sockets were used in combination with flow
control and regular Tx traffic.

After executing:
ethtool --set-priv-flags $dev link-down-on-close on
ethtool -A $dev rx on tx on

launching multiple ZC Tx sockets on $dev + pinging remote interface (so
that regular Tx traffic is present) and then going through down/up of
$dev, Tx timeout occured and then most of the time ice driver was unable
to recover from that state.

These patches combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.

Olek,
we decided not to check IFF_UP as you initially suggested. Reason is
that when link goes down netif_running() has broader scope than IFF_UP
being set as the former (the __LINK_STATE_START bit) is cleared earlier
in the core.

Thanks,
Maciej

v3-v4:
- turn carrier on in ice_qp_ena() only when physical link is up [Michal]

v2->v3:
- drop redundant braces in patch 3 [Shannon]
- fix naming of ice_xsk_pool() in patch 6 [Shannon]
- add review and test tags

v1->v2:
- fix kdoc issues in patch 6 and 8
- drop Larysa's patches for now


Maciej Fijalkowski (7):
  ice: don't busy wait for Rx queue disable in ice_qp_dis()
  ice: replace synchronize_rcu with synchronize_net
  ice: modify error handling when setting XSK pool in ndo_bpf
  ice: toggle netif_carrier when setting up XSK pool
  ice: improve updating ice_{t,r}x_ring::xsk_pool
  ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
  ice: xsk: fix txq interrupt mapping

Michal Kubiak (1):
  ice: respect netif readiness in AF_XDP ZC related ndo's

 drivers/net/ethernet/intel/ice/ice.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 159 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 6 files changed, 109 insertions(+), 77 deletions(-)

-- 
2.34.1


