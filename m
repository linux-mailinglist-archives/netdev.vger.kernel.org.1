Return-Path: <netdev+bounces-98562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF658D1C77
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6351C2256C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FD16FF5F;
	Tue, 28 May 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrjuBCMj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F716F0EA
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902130; cv=none; b=P94OHzhCbRMMZeTp/Q9EOVbIhQfdvWu2UKQXAu7tVr12jHvDuc/XQAQiobUd8gk32c61TOi73Yee3eLoe8/8mWM4hPBV4gFZk7wy8ZMjocGNveUtK4x+QGt51DJx8z+KXBxJLBj3RYZS7FDfo5ug8gPTkKmoNkbTPGiC9Yvbuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902130; c=relaxed/simple;
	bh=6biWVuxMhZ/tEyLZWM2lpwUSsb0yPNVnUuWvv4Y3Hoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqPWaRqwhbNHpV2h1Nuc0SJ2+anhhSsI7rfpDNo/VFgeHlZD3NJaAIHZYLfKKNMNfF623nvZ05OGySh6rADGw0voY+M0WPBQYAOXN87zAcVvmfhDtarBV6LWilHSV2nNnVCoTU5uzZjRGmw7xB2kxNeoeWoZ6E1DMHrzyDrjLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrjuBCMj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902129; x=1748438129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6biWVuxMhZ/tEyLZWM2lpwUSsb0yPNVnUuWvv4Y3Hoo=;
  b=nrjuBCMjFwkxeE+H2f6zwdr1XyTn/x+5t8fchnQXmOC7hc7ChS/gS9MG
   QHXvgzvdNROOTENYIHcIZYp5MnZ19a8zxuWD7ejsB0Tgp0Y+So3/cXy+J
   mRr+TkH6O4b/nnrRIcMITM56gz74aA1O59bLImzj580Bc7kABxswTFQIz
   QNDCiGzUew7upQPsUT+MqsW9wH8BnwWVaoKtT42HToXaKJSev461qbz47
   viXh+yJWgYnvMmR5R+BNwe3QcndQkGBW6y+3W+J3GGVnSeuzAn2yJP87p
   tuLNWOLri2XtthD36mew8vsDP5vrBu3wyNLp8W6weFIt8KZkxJVP7RqzQ
   A==;
X-CSE-ConnectionGUID: yi8Upy1LQj2cWX/FnSyDAA==
X-CSE-MsgGUID: q2cLLRggQbCqau/3qriL4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193523"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193523"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:29 -0700
X-CSE-ConnectionGUID: jB5T4MqqRAOO4jlBHV4a/A==
X-CSE-MsgGUID: BN4OeRSTQ8G4vBpYNbBWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891097"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:27 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 00/11] ice: fix AF_XDP ZC timeout and concurrency issues
Date: Tue, 28 May 2024 15:14:18 +0200
Message-Id: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
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

Patches 1-8 combined together solve the described above issue on
customer side. Main focus here is to forbid producing Tx descriptors
when either carrier is not yet initialized or process of bringing
interface down has already started.

On top of that, Larysa goes further with fixing XSK pool setup issues
and race condition when Tx timeout strikes at the same time as
ndo_bpf().

Thanks,
Maciej


Larysa Zaremba (3):
  ice: move locking outside of ice_qp_ena and ice_qp_dis
  ice: lock with PF state instead of VSI state in ice_xsk_pool_setup()
  ice: protect ring configuration with a mutex

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

 drivers/net/ethernet/intel/ice/ice.h      |   8 +-
 drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  |  23 +++-
 drivers/net/ethernet/intel/ice/ice_main.c |  41 +++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 154 ++++++++++++----------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   4 +-
 7 files changed, 151 insertions(+), 89 deletions(-)

-- 
2.34.1


