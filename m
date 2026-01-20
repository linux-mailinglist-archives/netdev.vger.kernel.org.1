Return-Path: <netdev+bounces-251632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE13IqwJcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:03:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E67334D6FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B871AAF104
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43513D7D9B;
	Tue, 20 Jan 2026 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9GP4ldQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB823D7D97
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949085; cv=none; b=aWVYDhQD3HjhTlHSpqVznR62qYujPNk8I0dYkh6PiZk/4n0ih2C57nvjvnWIE5wM/O5wvVFtAnOf6pRPg2jFCVMe1n9zZVlFm/j8EEceRU2E0YEURxmqqnnw4zfBU5ojre8Gcp3DXztCGAfX5CeCn66ae0MMA882pMnbBUmgWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949085; c=relaxed/simple;
	bh=V8gfC+7GRKPJd7UObaV5Flt/PGnNX8x+7EXOpG3gCk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToaJDat5DohyHCAMXh7/upvKNAedgeNcrmXh0jtauQPD9sly/KIDqxWyd2jZuh+yAWHRpFrGcTYyC1qNvY+ZeiMVjjHkjAeqyq5y5qlhl/tJ/2XXu5gzaFiQAm8dG2JA8EfYFzlANkdJQqgYPyrRNiAGxGLwV+Dr5Mel5udNHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9GP4ldQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768949080; x=1800485080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V8gfC+7GRKPJd7UObaV5Flt/PGnNX8x+7EXOpG3gCk8=;
  b=c9GP4ldQMXTrJ67dvsJg8rLh96D1ZZew4SsBwZyyr7fpkkWwX49nLQNR
   ESSpzWbHYblOZSqiDyeHZ+gUujlQvXCDOVnK1LWwzIiRTYp09Ky5P79XX
   ZFm6A2TzlpEg6bWjOq+2brTf979WAXaLy46IoM71+4SQun0Lm/8idHt2q
   VnwbLeQKaSsHe51MytCLjAXdgf7PH37tqYvEgt81dc8eJxJOlZ1R0I2Wl
   k5JJj9gYQhK+7IFOnGi+/MsPHX/ub6JWUqkMopGxNBwjthvyOGbgTAVVr
   3WoQYNUDaOTcnP2CLczBjyAv6rCf6CQLm0AsiWp2n0JoQ3pX1eVV70cx/
   Q==;
X-CSE-ConnectionGUID: Z46HXrffR427mnL5fIqLzQ==
X-CSE-MsgGUID: 7JJhz8YxRfS/d3zeAoKkMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81548783"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81548783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:44:37 -0800
X-CSE-ConnectionGUID: p1ozcTFGRtuY3Vnc2NKQ0w==
X-CSE-MsgGUID: W6rJ5G5UT3eP8HapRv3PWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236920150"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 14:44:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2026-01-20 (ice, idpf)
Date: Tue, 20 Jan 2026 14:44:24 -0800
Message-ID: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251632-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	URIBL_MULTI_FAIL(0.00)[dfw.mirrors.kernel.org:server fail,intel.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: E67334D6FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ice:
Cody Haas breaks dependency of needing both RSS key and LUT for
ice_get_rxfh() as ethtool ioctls do not always supply both.

Paul fixes issues related to devlink reload; adding missing deinit HW
call and moving hwmon exit function to the proper call chain.

For idpf:
Mina Almasry moves a register read call into the time sandwich to ensure
the register is properly flushed.

The following are changes since commit b97d5eedf4976cc94321243be83b39efe81a0e15:
  netdevsim: fix a race issue related to the operation on bpf_bound_progs list
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Cody Haas (1):
  ice: Fix persistent failure in ice_get_rxfh

Mina Almasry (1):
  idpf: read lower clock bits inside the time sandwich

Paul Greenwalt (2):
  ice: add missing ice_deinit_hw() in devlink reinit path
  ice: fix devlink reload call trace

 .../net/ethernet/intel/ice/devlink/devlink.c  |  1 +
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  6 +---
 drivers/net/ethernet/intel/ice/ice_main.c     | 31 +++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |  2 +-
 5 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.47.1


