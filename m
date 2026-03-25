Return-Path: <netdev+bounces-271716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHnCCYBAxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:07:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035832B95C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C45D300CE67
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297A369208;
	Wed, 25 Mar 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRFYfnqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190F36309F;
	Wed, 25 Mar 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469216; cv=none; b=kYcJ5wI3BmYRIUV6UCYfq7HBFqztrljTCz4a02r0YJOTs0tl9/HWccNWWJA9nz/llTzAfyt2wA0gyWXLDvU1ZZWUML/LnyX9MklmK6WseSoAqErVqlIeHU4oLavStHo52I3iTPm/Qm4RR+/jLy6XvEriWF0+GSYY8wzEzMKxrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469216; c=relaxed/simple;
	bh=m4KftLjD6j7F3+87DgxNzCo21emsznADBjMYlcuos6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2s2/4kWVNr1reuqJN6cnCI1gJmYIV0eq7DIjkMSN7q9k45/IAJb/qh8tSSFONh0teJ9atPJRHY0Rlaz0yKPytFO2vns7uTOwxu/o0A4F6uG0YFxSZzs/9jyoempkLDuWMQ37l2n8yxTnf7IPlSyNjk7eBQuqBMy0I4wq3B2Ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRFYfnqJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774469215; x=1806005215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4KftLjD6j7F3+87DgxNzCo21emsznADBjMYlcuos6o=;
  b=mRFYfnqJgAviruni/8cIOzTh7pjx9hd72co3vZP2euc4NF7dE34HDOwr
   ItNgqybtPeMyvZRc/k02HEVGnw+DP292x/iIl+uoXujB7yQmJiYvRicEk
   D3fUGxg9mlhgUdyknKLDdlwpFOo6Yc7fkBvdBSjrdTHF6E2i6lG+Ep53j
   VcwvWaDIjUROX1GvlnxUVxhK5hcqWOLVW8YIjSmmsruZijFG9wtnohyJ8
   thFumqm3L349W6yzqf39Y2JnBQe+0FxgzsK7qoqOmaPjvEavxC5b3dl/+
   +5gC9hFRWurymLDe5SNXpLslgKGWaYiVaUdr630/YZ/lgtPZV4i6fRiE7
   A==;
X-CSE-ConnectionGUID: S/aN9/S6QrW8+OkjK6sbrw==
X-CSE-MsgGUID: Cm6JucpBSmuAa5eOYAR27w==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93096532"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="93096532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:06:54 -0700
X-CSE-ConnectionGUID: n6pKjDPATVSRhDSDgzHR/g==
X-CSE-MsgGUID: PFSRTTwaTCCAy26XkL0tSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229243680"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 25 Mar 2026 13:06:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 0/5][pull request] ice: add support for devmem/io_uring Rx and Tx
Date: Wed, 25 Mar 2026 13:06:38 -0700
Message-ID: <20260325200644.2528726-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271716-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9035832B95C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alexander Lobakin says:

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
---
v2:
Patch 3:
 - More locking fixes
 - Fix for safe mode from Kohei

v1: https://lore.kernel.org/netdev/20260310220624.537917-1-anthony.l.nguyen@intel.com/

Originally from:
https://lore.kernel.org/netdev/20260206174910.4066255-1-anthony.l.nguyen@intel.com/

Changes since:
Rebased
Patch 3:
 - fix [hopefully] all inconsistent locking
 - fix kdoc

The following are changes since commit d1e59a46973719e458bec78d00dd767d7a7ba71f:
  tcp: add cwnd_event_tx_start to tcp_congestion_ops
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Alexander Lobakin (5):
  libeth: pass Rx queue index to PP when creating a fill queue
  libeth: handle creating pools with unreadable buffers
  ice: migrate to netdev ops lock
  ice: implement Rx queue management ops
  ice: add support for transmitting unreadable frags

 drivers/net/ethernet/intel/iavf/iavf_txrx.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c    | 247 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_base.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  15 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     | 225 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  75 +++---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  43 +++-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_xsk.c     |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  13 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   2 +
 drivers/net/ethernet/intel/libeth/rx.c       |  43 ++++
 include/net/libeth/rx.h                      |   2 +
 include/net/libeth/tx.h                      |   2 +-
 16 files changed, 542 insertions(+), 156 deletions(-)

-- 
2.47.1


