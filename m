Return-Path: <netdev+bounces-284472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HVXJikN+mntIgMAu9opvQ
	(envelope-from <netdev+bounces-284472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897AF4D037C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C85E1301020F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D88481AA4;
	Tue,  5 May 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fw5Zm5p6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0483AA4EF;
	Tue,  5 May 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995038; cv=none; b=PnXb368dVAx77xpe9M4vk6X53fKlR/07URJ2nXE35UBxBHXzyHMXW7l4xhbqWwWFD9RbkrUMfN3g48ppbDBvCphzxmkjW4YX1pH1t4MefxcXaxUKh2t+UV5inmjqdfUhJrH/yZu6WUnRBs0mx9AXBu1lh++s+p27ZRd2gHvjAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995038; c=relaxed/simple;
	bh=Ok+4ECv3s+pYujUHLo68Z1g1L6HzzFD6IgmwTokVWG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ef6I5/A80LO/0JwaSa16OBOl2bycOl+mUMhnWQgbOrc6RdrwZuLX/znNj0nLSt5LvVthKO287eMqNr0r5kOiv1IgC67CQRywdRyI8V5ZMi1nXx5iSUxdJbzWzIO9eJev5Qp90twXXbsubFd1KgfdHWB7808mwaLLJBPwnglXc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fw5Zm5p6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777995037; x=1809531037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ok+4ECv3s+pYujUHLo68Z1g1L6HzzFD6IgmwTokVWG0=;
  b=fw5Zm5p6F7P6VRdPkTcpI2d9OrMSx3RcU6TmW4BT22y8/qhqVXnCG2kx
   Sb1vuJSm1SR8Je3nO4+AhmEwzKrGKfSCrs3xJNdnnhLaWwtBeMyfcDUq1
   +iUFPzFom/m7UU0Ywym4HJvHKn+L2zhiDyjV/HJ5g+UtbFFM6BBEgJthI
   S1yd4qYjbTTx5VhRAHoJpfQwTSykQFZVzIaTlgouoo3qq30MRkvr7hCZZ
   VuXu48EUCcYDnoKSclfiHj6ZHkoU2BME+qalXmUcIoZug7myANY0dPx28
   y91ENYp5Fx2KaG4zkgiRI7X6G4XVhVGKMxxZ3U/Cxm6Z3b5mOwnTi2uOP
   A==;
X-CSE-ConnectionGUID: VU57b7lnQFO44pWszhKGVg==
X-CSE-MsgGUID: g1QCqkP2RHyi7axWcfmI5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="104316976"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="104316976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:30:36 -0700
X-CSE-ConnectionGUID: DgEFnLZkSteLllHdnnS9Yg==
X-CSE-MsgGUID: QztnzmU6Smi7nhtc0Z+reQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="234971504"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa010.jf.intel.com with ESMTP; 05 May 2026 08:30:33 -0700
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
	Kohei Enju <kohei@enjuk.jp>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v5 0/5] ice: add support for devmem/io_uring Rx and Tx
Date: Tue,  5 May 2026 17:29:18 +0200
Message-ID: <20260505152923.1040589-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 897AF4D037C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284472-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iou-zcrx.py:url]

Now that ice uses libeth for managing Rx buffers and supports
configurable header split, it's ready to get support for sending
and receiving packets with unreadable (to the kernel) frags.

Extend libeth just a little bit to allow creating PPs with custom
memory providers and make sure ice works correctly with the netdev
ops locking. Then add the full set of queue_mgmt_ops and don't
unmap unreadable frags on Tx completion.
No perf regressions for the regular flows and no code duplication
implied.

Credits to the fbnic developers, whose code helped me understand
the memory providers and queue_mgmt_ops logics and served as
a reference.

Alexander Lobakin (5):
  libeth: pass Rx queue index to PP when creating a fill queue
  libeth: handle creating pools with unreadable buffers
  ice: migrate to netdev ops lock
  ice: implement Rx queue management ops
  ice: add support for transmitting unreadable frags

 drivers/net/ethernet/intel/ice/ice_base.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   2 +
 include/net/libeth/rx.h                      |   2 +
 include/net/libeth/tx.h                      |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c    | 247 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  15 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  26 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     | 227 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_main.c    |  79 +++---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  43 +++-
 drivers/net/ethernet/intel/ice/ice_xsk.c     |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  13 +
 drivers/net/ethernet/intel/libeth/rx.c       |  43 ++++
 17 files changed, 566 insertions(+), 164 deletions(-)

---
Note: apply to net-next, not Tony's next-queue (ready to be sent as
a PR).

From v4[0]:
* rebase on top of the latest net-next;
* 3/5: fix the last [hopefully] missing netdev lock (E-Switch code,
       Simon), rechecked with our internal Intel's Sashiko setup;
* 3/5: pick fixes for .ndo_bpf() and safe mode from Kohei.

From v3[1]:
* rebase on top of recent Larysa's changes;
* 3/5: fix the last locking inconsistencies (Jakub);
* 3/5: pick a kdoc fix from Tony.

From v2[2]:
* rebase on top of net-next-7.0;
* 3/5: fix [hopefully] all inconsistent locking (Jakub, Tony);
* 4/5: pick a hotfix from Kohei.

From v1[3]:
* rebase on top of the latest next-queue;
* fix a typo 'rxq_ixd' -> 'rxq_idx' (Tony).

Testing hints:
* regular Rx and Tx for regressions;
* <kernel root>/tools/testing/selftests/drivers/net/hw/ contains
  scripts for testing netmem Rx and Tx, namely devmem.py and
  iou-zcrx.py (read the documentation first).

[0] https://lore.kernel.org/intel-wired-lan/20260318163505.31765-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/intel-wired-lan/20260224174618.2780516-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/intel-wired-lan/20251204155133.2437621-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/intel-wired-lan/20251125173603.3834486-1-aleksander.lobakin@intel.com
-- 
2.54.0


