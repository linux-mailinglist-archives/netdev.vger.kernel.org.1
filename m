Return-Path: <netdev+bounces-294931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sg/gMuylIGob6QAAu9opvQ
	(envelope-from <netdev+bounces-294931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:08:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C679363B80B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:08:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Ss3peF2N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294931-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294931-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2CC4300F24C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955B4219E2;
	Wed,  3 Jun 2026 22:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC140910D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524519; cv=none; b=tPEd6WWUyVvoqdDoV9bQ6krN9SjtK+O3fmZReoAXC4NK3U2nYJTxMHX2DV9737dBG1wa32AGy1DN8SI+Ziy2j+o4n9QJtoQA9yrfBXY4FepyRN2L1/Ryh6teHM6v9Ctzl7Rvc/1FFoznKZrzppgdGOP/tAM1kYfxmLiniedATbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524519; c=relaxed/simple;
	bh=BBHI5s2Xe/C24vgO1oQowIs3t0amk8d8eNZZQG1T1n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLmhKNChFr1P65J7blLH02JwII32KnED9ZZmJ44em2+Bi8OQncCVIFj1BipRa1tQhyIt0BngLIft47FzE1Hkul+j7uGd4LJv+bcex2kTpS7xtWEVbd2o2oK5MFY2Fn3cupPAuwt7Y/zj71zmHx3qpuf6QWIBpzzs262lDoNjG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss3peF2N; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524517; x=1812060517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BBHI5s2Xe/C24vgO1oQowIs3t0amk8d8eNZZQG1T1n0=;
  b=Ss3peF2Nm7jqIojmCZagMo62l9dDyTB+pl3CIRW4U1H2TmIbdqvC6KRs
   X3A4xLfJlPcpsozL80ZaJhVP5laa5e3x6rEnzCDuOj5EnEveFH1WFX8Ho
   iz88U5iHL2Uf8GRNzmaMxJxyJWBQpjDMBXTMaM26Ibq3uneKLIl7m6wWB
   UF08Hgg16SqaaBLb+M7FlGIfr9l1355MFj2Tyfkb83sjDDDElFl+lKA+h
   TiTxbPop6zujfvl0HTjkEXaSOAwsDh1Mt1SRyS+ZfGHB/0WXkhVhHZh8e
   sLb1mhyXou1WRvrQtMWyFLT/fs/hKkqEJpK4BXP9iKeTgYXkZ7UV6kwar
   Q==;
X-CSE-ConnectionGUID: FE9zeCmuRde758gCGaWdEQ==
X-CSE-MsgGUID: Vyn3/OIKQ3Wsm9pfp4Q84g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98920882"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98920882"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:35 -0700
X-CSE-ConnectionGUID: il0nMZXoT2egP3HHSdpHZQ==
X-CSE-MsgGUID: /jqlbxxsQLGzvANMxo5IVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282458874"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 15:08:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	marcin.szycik@linux.intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com
Subject: [PATCH net-next 00/10][pull request] ice: Add ACL support
Date: Wed,  3 Jun 2026 15:08:16 -0700
Message-ID: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294931-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:marcin.szycik@linux.intel.com,m:aleksandr.loktionov@intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:from_mime,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C679363B80B

Marcin Szycik says:

E8xx hardware provides a Ternary Classifier block for implementing
functions such as ACL (Access Control List). In this series it's simply
referred to as "ACL".

Implement ACL filtering. This expands support of network flow classification
rules for the ethtool ntuple command. ACL filtering allows for an ip or port
field's optional mask to be specified.

Example filters:
  ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10
  ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -1

This is a resurrection of an old series from 2020 [1] with several
improvements, but the fundamental logic unchanged. v1 was almost pulled
in, but ultimately it was decided to drop it [2] because of unresolved
issues. One issue was too many defensive NULL checks. Second issue is
about inconsistency when using multiple input sets. Both are addressed
in this patchset.

More about the second issue:

From [3]:
>I would argue that you need to have some sort of logic that basically
>checks to see if you are going to hit the input set issue and falls
>back and applies the ACL rules. Otherwise you are significantly
>hampering the usefulness of this filter type. It doesn't make sense
>that dropping a field will cause a rule to fail to be added, but
>masking a single bit in some field will make it valid. It would make
>it a nightmare to use from the user point of view as the rules come
>across as arbitrary.

Flow Director (FD) has a hardware limitation where all filters for the same
packet type must use identical input sets. Previously, attempting to add the
second filter would fail.

Patch 10 adds automatic fallback to ACL block when FD cannot accommodate a
filter due to input set conflicts, which resolves this inconsistency.

[1] https://lore.kernel.org/intel-wired-lan/20200914153720.48498-1-anthony.l.nguyen@intel.com
[2] https://lore.kernel.org/netdev/7192efe4d27c93148b3205e65f37203c89170316.camel@intel.com/#t
[3] https://lore.kernel.org/netdev/CAKgT0Ucxd5-gvEwWAdbL04ER2o++RX_oekUV3E0rYquEgFKj1w@mail.gmail.com
---
IWL: https://lore.kernel.org/intel-wired-lan/20260521115000.4637-1-marcin.szycik@linux.intel.com/

The following are changes since commit dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6:
  selftests/net: bind_bhash: fix memory leak in bind_socket
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Lukasz Czapnik (1):
  ice: use ACL for ntuple rules that conflict with FDir

Marcin Szycik (3):
  Revert "ice: remove unused ice_flow_entry fields"
  ice: use plain alloc/dealloc for ice_ntuple_fltr
  ice: re-introduce ice_dealloc_flow_entry() helper

Real Valiquette (5):
  ice: initialize ACL table
  ice: initialize ACL scenario
  ice: create flow profile
  ice: create ACL entry
  ice: program ACL entry

Tony Nguyen (1):
  ice: rename shared Flow Director functions and structs

 drivers/net/ethernet/intel/ice/Makefile       |    5 +-
 drivers/net/ethernet/intel/ice/ice.h          |   21 +-
 drivers/net/ethernet/intel/ice/ice_acl.c      |  486 +++++++
 drivers/net/ethernet/intel/ice/ice_acl.h      |  170 +++
 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 1127 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_acl_main.c |  295 ++++
 drivers/net/ethernet/intel/ice/ice_acl_main.h |    9 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  393 +++++-
 drivers/net/ethernet/intel/ice/ice_arfs.c     |    8 +-
 drivers/net/ethernet/intel/ice/ice_arfs.h     |    2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |    8 +-
 ...ce_ethtool_fdir.c => ice_ethtool_ntuple.c} |  678 ++++++---
 drivers/net/ethernet/intel/ice/ice_fdir.c     |   32 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   18 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   11 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |    2 +
 drivers/net/ethernet/intel/ice/ice_flow.c     | 1234 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   39 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |    3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   94 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   10 +
 drivers/net/ethernet/intel/ice/virt/fdir.c    |   32 +-
 23 files changed, 4433 insertions(+), 254 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.h
 rename drivers/net/ethernet/intel/ice/{ice_ethtool_fdir.c => ice_ethtool_ntuple.c} (78%)

-- 
2.47.1


