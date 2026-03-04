Return-Path: <netdev+bounces-263926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPxoEVpkqGl3uQAAu9opvQ
	(envelope-from <netdev+bounces-263926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C514204B57
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E9743112985
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663F36D9E6;
	Wed,  4 Mar 2026 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ducmDr+A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A733F597;
	Wed,  4 Mar 2026 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642154; cv=none; b=PJK98Ono/KyUflx73/GLob0ILhIr9CQzBdcREmKWnGKjozb0i+OYVck42xyyFCYnrHbFcuCe39Mnch5OAqkWDlnaKfca4P75hc0d5maRsLavKA9CCRGBotXYPVC8n8XgMteGKGdlz7zFirzK5cPg4UHrjQ4MdmTumf13elCHdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642154; c=relaxed/simple;
	bh=Tz/EW6VqSDuNT9o95iMXFSH++Mx/kFvK7wixh1Rq9Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQhlGt3nK7s369ck7HLtMyqhQKreVGkjdxNVaG+xUJZ5x/2dMcqJUfkIy1UbMYaG66sgWm6xZoJOejIYiq1adi3E59tABfUp9O3Hw+1s8o8IzVDlt0mOk5Bs3e6TjsVzqEztHiRvUb3lMYoeMT6bJYsuw8PmHtIcKBf9uGArfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ducmDr+A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772642153; x=1804178153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tz/EW6VqSDuNT9o95iMXFSH++Mx/kFvK7wixh1Rq9Lo=;
  b=ducmDr+A7OX3cB0RtCmAuM45K0hxldfJWKTiqmVo0bung52YKGWce33W
   JEcnPYDpV/KkpmTPL0k2CbrKexYR4kla8rKJ7mzpEv1NWhRQcuTBMK1l5
   7xQ/pG0K/qW9TPa+JW4M312n/u/Hteiqgi/t6/mpKRWpi3qA1hQIRQKRg
   c3vOrZPynx0Ovii//epchBtefPfjRZnLYInKh6hzAEBKTxhC3RWSkgXr6
   a/gaDDd+inaQ6s2HLmjLj5eJoXH0TId+qd8X8ZR+u7DlNeQLb9hPT4sTK
   nQ0UEhWccn8S1NlYHf//Kq4hBs14wlGHR56QoUt63bSW6hlaMq/TNn4P1
   Q==;
X-CSE-ConnectionGUID: 3dOa2prUTv6N9Pdh+I4UDg==
X-CSE-MsgGUID: VXbUUm6DQfegZYFBMyFcfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77580005"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="77580005"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:35:52 -0800
X-CSE-ConnectionGUID: 28qXX9IKTM+4NtRU4IyMMw==
X-CSE-MsgGUID: pjZ06Zf0QEGnm8h6YaITQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222895522"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2026 08:35:47 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0F4B5312C7;
	Wed,  4 Mar 2026 16:35:45 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 00/10] libeth and full XDP for ixgbevf
Date: Wed,  4 Mar 2026 17:03:32 +0100
Message-ID: <20260304160345.1340940-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C514204B57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263926-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

Update ixgbevf with standard XDP features by utilizing libeth library.

First, in patches 1-4 refactor existing general and XDP Rx code
to use libeth fill queues. Then in patches 5-7, add support for
XDP multi-buffer and XDP_REDIRECT (target and source). Patch 8 addresses
particularities of one HW type by using a software header split.
Patches 9-10 address page pool not being reconfigured on MTU change.

v2->v3:
* remove IXGBEVF_MAX_FRAME_BUILD_SKB one patch earlier
* remove __IXGBEVF_RX_3K_BUFFER (not used anymore)
* correct stats for mbuf packets when XDP verdict is other than XDP_PASS
* improve commit message in the cleanup patch
* improve error handling when page pool creation fails
* free data buffer when the corresponding header buffer allocation fails
* when some Rx buffers cannot be allocated, break instead of returning,
  so allocated buffers are not lost

v1->v2:
* fix wrong return value when allocating descriptor memory fails
* tag xdp_prog in ring structure as RCU

Larysa Zaremba (9):
  ixgbevf: remove legacy Rx
  ixgbevf: do not share pages between packets
  ixgbevf: use libeth in Rx processing
  ixgbevf: branch prediction and cleanup
  ixgbevf: support XDP multi-buffer on Rx path
  ixgbevf: XDP_TX in multi-buffer through libeth
  ixgbevf: support XDP_REDIRECT and .ndo_xdp_xmit
  ixgbevf: reconfigure page pool when reallocating buffers
  ixgbevf: allow changing MTU when XDP program is attached

Natalia Wochtman (1):
  ixgbevf: add pseudo header split

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/ixgbevf/defines.h  |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   48 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   99 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1117 +++++++----------
 include/net/libeth/xdp.h                      |    2 +-
 6 files changed, 499 insertions(+), 770 deletions(-)

-- 
2.52.0


