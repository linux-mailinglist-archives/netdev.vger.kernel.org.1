Return-Path: <netdev+bounces-56450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E080EECC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9B31F211A6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2073196;
	Tue, 12 Dec 2023 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIsr77O5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4CF2;
	Tue, 12 Dec 2023 06:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702391388; x=1733927388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xv2qt7/sAoWAEZQgV2h0LqG0rMAj+aEH2dHkRRXSC5I=;
  b=oIsr77O5j0zkwxlUXfDleZ0ccRz9XLOqxGfnqREsWGHMMg4/LbmZVOIs
   fx284UHlddnwenHpMAdGh4xUFSoUZMWuDHM6G3hcoX4B/EDVrSv4xR84I
   S62VDRsyamvIddYj8EsbvNLJ5q6MTmv48AX3FFrG7JK/NHFm7g/8oWeXb
   kRwTW0UweVcZtVG4kCsHi1cUrYUyaPmtF/qbm1cxl5MJeLrfTOtvKqhiZ
   xoWFEXvfIcFsl4Wrw2f2QknZ0d6zqUA2fkeNy2qT/VNflQvEMvdexuLHm
   ABbipL2jpSqOwxYBsE/4ULVVrS/sfCpBAAAUjsol3hLqQNqNZAtumehEV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1887329"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1887329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1104923742"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1104923742"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 06:29:44 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Kubecek <mkubecek@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] idpf: add get/set for Ethtool's header split ringparam
Date: Tue, 12 Dec 2023 15:27:50 +0100
Message-ID: <20231212142752.935000-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the header split feature (putting headers in one smaller
buffer and then the data in a separate bigger one) is always enabled
in idpf when supported.
One may want to not have fragmented frames per each packet, for example,
to avoid XDP frags. To better optimize setups for particular workloads,
add ability to switch the header split state on and off via Ethtool's
ringparams, as well as to query the current status.
There's currently only GET in the Ethtool Netlink interface for now,
so add SET first. I suspect idpf is not the only one supporting this.

Alexander Lobakin (1):
  ethtool: add SET for TCP_DATA_SPLIT ringparam

Michal Kubiak (1):
  idpf: add get/set for Ethtool's header split ringparam

 drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 11 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 65 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 12 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  2 +
 include/linux/ethtool.h                       |  2 +
 net/ethtool/rings.c                           | 12 ++++
 7 files changed, 104 insertions(+), 7 deletions(-)

-- 
2.43.0


