Return-Path: <netdev+bounces-301204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7vIfLcawOWp9wQcAu9opvQ
	(envelope-from <netdev+bounces-301204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:01:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84F6B28D3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:01:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Kx+4k8ir;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301204-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4F13014BD3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07DF356758;
	Mon, 22 Jun 2026 22:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376C3546C6
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165669; cv=none; b=JMzJfqz5NkSuZqhgjcGn75OhQaUL8UxaLxc6mmlmG9DiQ8cMN5PEMZWlGmJKRcJ+4mX8yhozoD83p3oNMN/UxDyfFp2g6rY2+AQKC9hF+wSygYcdTTvsBTW0CSHKHXvhoiEQ6T4EvyCbDVkzjYrwjopdHXokh5OnFGpU4Pr+520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165669; c=relaxed/simple;
	bh=qjwq+kuLESHeDCaW90GEDF9NrPBCat5Y6evPIqyu1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CySgLtjY/C0deeMjZ25EHIudkFHacND8cYOHWejQOM2In1toMArVV7iKMccTr6W1uIcB+LPXcqE8kbfbEMvAgcSfgNcSjlNm7BN9eGsE8/ia81z7eHAQsaty2h1Zi6iGof1HplPEmEKXSG0uw7GWmYi6UL0lI48hRV91RtBd5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kx+4k8ir; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165668; x=1813701668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qjwq+kuLESHeDCaW90GEDF9NrPBCat5Y6evPIqyu1Uo=;
  b=Kx+4k8iryOkFoHXPqwPGAoSnXuX8cTcLeml1wyMB41xQmFluxEbYriaU
   8KCfBrfTQUOVDfS3S0yxS25TwnJrVpGqgms1JOxMeJcmIqGaeNMMeBgHy
   OmkzGYQsSSyoHnGcdxXodnD+ahqyZrAM8hH8Ll3wPYHrV3pg2DD1AuFM1
   LDOEJ89ajrzs0Hdn99GeFKUgqIQs5mgCFJJ2Wet3v2Kj87nOIyoZOZkxt
   QlQ2RpKeHVlKmTBGKLrgf3YO2z1fDZfly/6DM4ApLTWvnhyJTEFqaeAYx
   61WJncrGCRK2IYmfGE1vx1EFsBVfamtSd8yxD6xJJy1MuWO+PtIXSSaIS
   w==;
X-CSE-ConnectionGUID: U1Ccb3yxTTm3pA3n5IRkNg==
X-CSE-MsgGUID: Eqcc0IGaSFWmGw5kRrw7Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675548"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675548"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:04 -0700
X-CSE-ConnectionGUID: RDPI6FosSaOLjTtTDRNnZg==
X-CSE-MsgGUID: BtvD72mBR26+zKzXOHMbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205702"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2026-06-22 (ice, i40e, e1000e)
Date: Mon, 22 Jun 2026 15:00:47 -0700
Message-ID: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301204-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C84F6B28D3

For ice:
Dawid changes call to release control VSI during reset to prevent
leaking it.

Lukasz fixes flow control error check to check value rather than treat
is as bitmap values.

Paul makes link related errors non-fatal to probe to allow for recovery
in certain NVM update situations.

Marcin moves netif_keep_dst() to only be called once when entering
switchdev mode.

ZhaoJinming adds a cleanup path for ice_dpll_init_info() to prevent
memory leaks on error path.

For i40e:
Mohamed Khalfella corrects argument passed in macro to match the
one provided to the macro.

For e1000e:
Dima resolves power state issues by adjusting value of PLL clock gate
and re-enabling K1; a quirk table is added to keep it off for known bad
systems.

The following are changes since commit 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0:
  Merge tag 'nf-26-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Dawid Osuchowski (1):
  ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()

Dima Ruinskiy (1):
  e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor
    Lake

Lukasz Czapnik (1):
  ice: fix AQ error code comparison in ice_set_pauseparam()

Marcin Szycik (1):
  ice: call netif_keep_dst() once when entering switchdev mode

Mohamed Khalfella (1):
  i40e: Fix i40e_debug() to use struct i40e_hw argument

Paul Greenwalt (1):
  ice: fix ice_init_link() error return preventing probe

ZhaoJinming (2):
  ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
  ice: dpll: fix memory leak in ice_dpll_init_info error paths

 drivers/net/ethernet/intel/e1000e/ich8lan.c  |  3 +++
 drivers/net/ethernet/intel/e1000e/netdev.c   | 15 ++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_debug.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_common.c  |  1 -
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 20 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ++++++++----
 drivers/net/ethernet/intel/ice/ice_main.c    | 16 +++++-----------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
 9 files changed, 48 insertions(+), 27 deletions(-)

-- 
2.47.1


