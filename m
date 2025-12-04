Return-Path: <netdev+bounces-243592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9ACA4580
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5A51300578B
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3452DF701;
	Thu,  4 Dec 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9CBe9C3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF12DBF76;
	Thu,  4 Dec 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863510; cv=none; b=CNuBF5oSUOmfgoNzQeOyT7xgsZNEulXytRdKEPKKaUqCJrHDwf02E35yxsVBlj+LHHkwtyoUYrrOUMBf0Z1PEFztjEeHlSZAKFp5DOTvwBZYgYyv2mUF8M2bktm1UY37hLOs5R0enV6w8q5TyBoQd/StcAoohKh6AFZnA6wGrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863510; c=relaxed/simple;
	bh=wntylzoSwqmqZ14w+vlx65T2d8TULoY/29mRPs1sjMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiACl9BURxH4lEjA5e7oCdLERFo+1plDfssjDjFvfygHHcS2tOVhj1tclnPLw+cvedAh09EHQ1IKJ6xYIFFTcy7ncN8JDeR2p4/bgHvKsX5eMNlGhbkvXuCCZtwhfLTeURzl4t+fnc/pNzwRIU05wPHBF0zbT2WvbIRySoqiQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9CBe9C3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764863508; x=1796399508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wntylzoSwqmqZ14w+vlx65T2d8TULoY/29mRPs1sjMw=;
  b=M9CBe9C36pocicQJZAIJLZd9ae21r2t/XgWzfnmYtcpwoJrqyPdjLFXN
   MpNatS9KwzpE51Yo44oQ4C2sCF9WQqD0ia11u4d+GpO/lK+blVDdm7mfv
   T8f283Y7+WYUqQNS7f6RsFGqPkQ1K6RbI+CjhTJVRiwsWGCgS2AyKFRBd
   8wpiDD3gPK+crv/nxKfJKwWBWkTXfKdlZNIn6EImrAwTzjHayUBmWXXs5
   8avpdM3gaqKp1PREbz1hAi0EzWwwq3So3D/dipyZyWCVdxtbNaraWFTuR
   Qw+xf2jlbpAGs4ZAcJGtCnjB+rivZetzh5blZJwNqhKiXDrD/4ePsKqdf
   Q==;
X-CSE-ConnectionGUID: pJE6gA+RTBKNEuiXza+Rfg==
X-CSE-MsgGUID: B5ZTuFyaTEymPIHOQW1Qfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="92365099"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="92365099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 07:51:47 -0800
X-CSE-ConnectionGUID: A7oCzQsbRBqTMzFfx1Tgnw==
X-CSE-MsgGUID: pZFFhipwRT2AvJY4bZ85ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194677256"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2025 07:51:44 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 0/5] ice: add support for devmem/io_uring Rx and Tx
Date: Thu,  4 Dec 2025 16:51:28 +0100
Message-ID: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Alexander Lobakin (5):
  libeth: pass Rx queue index to PP when creating a fill queue
  libeth: handle creating pools with unreadable buffers
  ice: migrate to netdev ops lock
  ice: implement Rx queue management ops
  ice: add support for transmitting unreadable frags

 drivers/net/ethernet/intel/ice/ice_lib.h    |  11 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h   |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |   2 +
 include/net/libeth/rx.h                     |   2 +
 include/net/libeth/tx.h                     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c   | 194 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_lib.c    |  56 +++++-
 drivers/net/ethernet/intel/ice/ice_main.c   |  50 ++---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c   |  43 +++--
 drivers/net/ethernet/intel/ice/ice_xsk.c    |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  13 ++
 drivers/net/ethernet/intel/libeth/rx.c      |  46 +++++
 14 files changed, 325 insertions(+), 103 deletions(-)

---
From v1[0]:
* rebase on top of the latest next-queue;
* fix a typo 'rxq_ixd' -> 'rxq_idx' (Tony).

Testing hints:
* regular Rx and Tx for regressions;
* <kernel root>/tools/testing/selftests/drivers/net/hw/ contains
  scripts for testing netmem Rx and Tx, namely devmem.py and
  iou-zcrx.py (read the documentation first).

[0] https://lore.kernel.org/intel-wired-lan/20251125173603.3834486-1-aleksander.lobakin@intel.com
-- 
2.52.0


