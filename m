Return-Path: <netdev+bounces-56359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CA80E983
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F09281B81
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7005CD03;
	Tue, 12 Dec 2023 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKqzf2Ma"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A7D2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702378538; x=1733914538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zquXneymmM8KJaGym7NIqSoKPGCAlAOK6zpSWTqyLd4=;
  b=mKqzf2MaLHaRnFFTKY3tPZont9K6pzVf42MMY0L6YuVjcSXFLCWgJ8sP
   kkG4obgIeb7HVV8ClNHsJkIsXU5OHGM/DvcEXLRFecTLnt8xv5Q5ku0vt
   f2jIzaVTzuzHFan6geDazyqwXPgzg7+HwN/oHQJrDIB1RF/eOLNNns2FX
   1TgJ+l02UQPjFdlnjXAx6bd53DeAx4eiGghaGcMX4O/rj+Mvll+0yGCsa
   84DaDL0tKmh2pqKfo5APhHHNxPZibasf9U/ImN499EVlbkvhl+HT63ddQ
   xioONGeWLrYCOcPygKbiRL+fU8kijifxng2ysppOoxOu6DDEq6TMAkDjS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8158899"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="8158899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="864161626"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="864161626"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 02:55:36 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 0/2] ixgbe: Refactor ixgbe internal status
Date: Tue, 12 Dec 2023 11:46:40 +0100
Message-Id: <20231212104642.316887-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small 2 patches series removing currently used internal status codes in
ixgbe driver and converting them to the regular ones.

1st patch deals specifically with overtemp error code, the 2nd one
refactors the rest of the error codes.

Jedrzej Jagielski (2):
  ixgbe: Refactor overtemp event handling
  ixgbe: Refactor returning internal error codes

 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  36 ++--
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  61 ++++---
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 145 ++++++++---------
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  45 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |  34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 110 +++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  43 +----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  44 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 154 ++++++++++--------
 13 files changed, 320 insertions(+), 359 deletions(-)

-- 
2.31.1


