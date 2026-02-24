Return-Path: <netdev+bounces-260613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBUcNZ/knWnpSQQAu9opvQ
	(envelope-from <netdev+bounces-260613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:49:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91218AB7E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF73303FFD9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5973A1E65;
	Tue, 24 Feb 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mz26+JYk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6739E6D2;
	Tue, 24 Feb 2026 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955354; cv=none; b=cpKgfpEWdhS0GR1XPIcp/bmHC3bp3Rw4m6PVInsITnxDc9dUW7ivK5LEXR+s3IzNLeebhO8Bh8JnBIFdzxMlcVgQXHiBGV3S1bfc1PSByQSgW0ppoiBrfmIiPGu9efGiylUMUHi08sJ/7wJYk4P30D3FhSZLZsHtPuwyIieJmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955354; c=relaxed/simple;
	bh=u4IRNFH9va3OeQ5nrZg8gWMVIxl5+G7rTkHNbJnhzAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWaO4wJbucZPmEmZnVOrk93dOTbajclE9FWgu95i42OvPGNN9VI5l3GX44hP41j3lGnrjMD4o6p9rPe2Q13QiCPbMTdVOHbmWU/italvWfP+fgjby/GhjqZwEdcZQAQAkz/J6FK7qCm1rT/zDIBJQ9BQoHZb0k/6st5Fa7Ea0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mz26+JYk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771955353; x=1803491353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u4IRNFH9va3OeQ5nrZg8gWMVIxl5+G7rTkHNbJnhzAA=;
  b=Mz26+JYk99dsFBNrNZq5mzFmf2TA6i7Z9CA7GmlGONIk/1ZfodeawWqR
   oz4fCguP2sxr05EbRmPPcnZjG0XiDRcyQr1lfT6aYSJ97fQZcI/nkcT1r
   hIdTYPDmCN8V75u3KFPc0bCHPh1Fm7ZtSZBJC5j0oFOyuBTRy4XX/U/vA
   xVWDoV8KRSu6jnV2dd5roMJ1WKdE6dBT6fjnDL4VsL305ux+0vyoPr8YA
   YOYtKZ5Vsk6U8mk83pxu2eIGcYlYyB8CeQ51Ll9gH0biUgMwyqj2ja9b3
   k9lebrZXV7TjoRsAaCdXE6Qo1wWgwT1xSJj5kGboi1n5w+2ehE0oqWxEq
   w==;
X-CSE-ConnectionGUID: VjMj9AdIRwGmwGepiwkwYQ==
X-CSE-MsgGUID: yfwb7h0+Rs6JRkRyCVzllQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="98444492"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="98444492"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:49:06 -0800
X-CSE-ConnectionGUID: cgKAUa66Tuy3HwMMfh0Yuw==
X-CSE-MsgGUID: x8yiX51ISMWPVFsT1j4Llw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220088494"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 24 Feb 2026 09:49:02 -0800
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
Subject: [PATCH iwl-next v3 0/5] ice: add support for devmem/io_uring Rx and Tx
Date: Tue, 24 Feb 2026 18:46:13 +0100
Message-ID: <20260224174618.2780516-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260613-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devmem.py:url,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 3B91218AB7E
X-Rspamd-Action: no action

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

 drivers/net/ethernet/intel/ice/ice_base.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.h     |  15 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   2 +
 include/net/libeth/rx.h                      |   2 +
 include/net/libeth/tx.h                      |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c    | 259 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  15 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c     | 183 ++++++++++---
 drivers/net/ethernet/intel/ice/ice_main.c    |  70 ++---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  43 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c     |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  13 +
 drivers/net/ethernet/intel/libeth/rx.c       |  43 +++
 17 files changed, 509 insertions(+), 152 deletions(-)

---
From v2[0]:
* rebase on top of net-next-7.0;
* 3/5: fix [hopefully] all inconsistent locking (Jakub, Tony);
* 4/5: pick a hotfix from Kohei.

From v1[1]:
* rebase on top of the latest next-queue;
* fix a typo 'rxq_ixd' -> 'rxq_idx' (Tony).

Testing hints:
* regular Rx and Tx for regressions;
* <kernel root>/tools/testing/selftests/drivers/net/hw/ contains
  scripts for testing netmem Rx and Tx, namely devmem.py and
  iou-zcrx.py (read the documentation first).

[0] https://lore.kernel.org/intel-wired-lan/20251204155133.2437621-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/intel-wired-lan/20251125173603.3834486-1-aleksander.lobakin@intel.com
-- 
2.53.0


