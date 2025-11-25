Return-Path: <netdev+bounces-241590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C6C863AE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C6CF352CD6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51033325728;
	Tue, 25 Nov 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJtVK91m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA3207A0B;
	Tue, 25 Nov 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092204; cv=none; b=mvlXGzoT4VUHPwvjdv3rBwOrcpedGHup9RQc+bp+ZGc7Asw1teAXf6Au2x1USsOT2fyZ/VhpH5bh+azjOlxu115ngEeRCUg+WO2534q64Qs3O0F6/d4+whiVkXC1eb8tHOotGrNc+ygUIjXB8RLWYUs85KUC6kija+COatmvs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092204; c=relaxed/simple;
	bh=L4ZZnBUfnNasEjDRyNYykpzYJ1ucWv9kcc26REtqwT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4rgqnngzAdd3QIl4mruUNfkiDJdA//pFX5uB9Uj2Mn1C5Taa9q5UMP5wVUTgYOMwBu3KQuXRRZA2/NBBmNTm8ZR9JEKxrSRnznfvn9UDXsLnHJxElrVfp2QrDe4iHgQoBOoBTrcTGtJOqMLrr/V6+l30VNGBQ7Vjy1fAT9mSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJtVK91m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764092203; x=1795628203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4ZZnBUfnNasEjDRyNYykpzYJ1ucWv9kcc26REtqwT4=;
  b=dJtVK91mv1sp50RFv1sMu8IJ/JndKoXV0OPcGqAYjflCziu3t7XVYfeu
   r7dK6Wc9M7V6fzRD/cyA33LsseczIWkj6k5sInruXNjrScTnvmuN5ITsE
   7l8bCj+h4ovlp92M93AJbDqQTZR0EixD7xaiOUCntwqUUqv2cUqb1Ukfm
   xPIctAQwkHuuRwrJur7/l++RZaGLGdRiWgj25L8+Q5rVsw42u6YDKf0Hl
   t2JauTW25EVQW/RpTx6y6xm4tVTYjDkHFYikJajra5YvNk/m5/j1EBbx0
   qreFBb8byoR8dCKwYVLgnIRyd4OsDdbHg4cpP7Npyl3EI2XH7Icjej2F+
   Q==;
X-CSE-ConnectionGUID: Zdr7BCrDQyCs9wY1UiZUUg==
X-CSE-MsgGUID: kmecwgswSouOk3STOrbANA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69979862"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69979862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 09:36:36 -0800
X-CSE-ConnectionGUID: bRI8blVfQseTCql2nZm1wg==
X-CSE-MsgGUID: yf6AW/GnTLqefgeEQhZ0SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="216040307"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2025 09:36:31 -0800
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
Subject: [PATCH iwl-next 0/5] ice: add support for devmem/io_uring Rx and Tx
Date: Tue, 25 Nov 2025 18:35:58 +0100
Message-ID: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.1
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
 drivers/net/ethernet/intel/libeth/rx.c      |  43 +++++
 14 files changed, 322 insertions(+), 103 deletions(-)

---
Testing hints:
* regular Rx and Tx for regressions;
* <kernel root>/tools/testing/selftests/drivers/net/hw/ contains
  scripts for testing netmem Rx and Tx, namely devmem.py and
  iou-zcrx.py (read the documentation first).
-- 
2.51.1


