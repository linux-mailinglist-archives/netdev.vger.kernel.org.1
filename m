Return-Path: <netdev+bounces-81814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72488B2CF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746993243B9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9756D1B3;
	Mon, 25 Mar 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wr8uLjYo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB57316D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402205; cv=none; b=Bg6sTYfA7uPNyV3VrqpafRks+ymEEgbgpKiDt6OITusyNf+vMtspw8o34aHzJl1QnzHhQ1Uatwmkps88596xZVISfV01ejvm+SqQfdzBptHrIz1p+mwneAQhGfasTDGjbVStXsI5SLmQ2yT1zX33699S/VHbKVyadZaWg71qrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402205; c=relaxed/simple;
	bh=/Bd6vxdtyq3zft5yO+WJmpzkDTTeKM+H/KmaCrAq7rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHdpjS1ACEKTdsrkGYqoh/dx286GpeVLtRO7QYNaIpTLXD24RhPnPRtgEv5xG3kCCbIBhrN4+9ag2jiVlSlAuvAvTVtBaQmj+tUyDcvNNMtjInruUuyo7VrlC7TNE6G/HtxMvDQrMoPRkWBBTmnKdGctlB2LbmOlEy/PVpDKvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wr8uLjYo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711402204; x=1742938204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Bd6vxdtyq3zft5yO+WJmpzkDTTeKM+H/KmaCrAq7rU=;
  b=Wr8uLjYoRLTX4Bp5C0V3ued/z/L04JexDbs88eD0UsmURXi2RS0E7wFv
   U6jRRypcZmA2JUBnGD/EefaaFim0/DhzmhgQef5DLdOcM64CB8/x4ZZNw
   wzHNrrnnqpLPHov+2ADkPbGcOAQRrqYTSsyg9tjMfS+XWE26NBJuiIP7/
   phVCwmFMEzM08+D5BmgDtRgbwa3jOK9FA3soScvcApG6C54wwSivai8M/
   E6Lyp91Ov0u3GGwerUAtiPSPpHspQtQsJxlXvs9y8sg6BmsCl1uFn3ks5
   JmVrS/7KFUsI57gzaxAmzNn4NZ4BLLmbi56ITfXKNqCKekoHUMaAYcGaI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17064527"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17064527"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 14:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15713486"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 25 Mar 2024 14:30:01 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 0/3] ice: devlink cleanup
Date: Mon, 25 Mar 2024 22:34:30 +0100
Message-ID: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a prework for subfunction patchset. As Jiri suggested I moved
only devlink related changes to the new patchset. The whole previous
patchset is here [1]

There is one patch that is changing how devlink lock is taken during
driver init/cleanup.

[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (2):
  ice: move ice_devlink.[ch] to devlink folder
  ice: hold devlink lock for whole init/cleanup

Piotr Raczynski (1):
  ice: move devlink port code to a separate file

 drivers/net/ethernet/intel/ice/Makefile       |   4 +-
 .../ice/{ice_devlink.c => devlink/devlink.c}  | 457 +-----------------
 .../ice/{ice_devlink.h => devlink/devlink.h}  |   0
 .../ethernet/intel/ice/devlink/devlink_port.c | 430 ++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  12 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |   3 +-
 10 files changed, 471 insertions(+), 450 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c} (78%)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.h

-- 
2.42.0


