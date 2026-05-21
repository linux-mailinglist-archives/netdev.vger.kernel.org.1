Return-Path: <netdev+bounces-290404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFvvAkQCD2pfEAYAu9opvQ
	(envelope-from <netdev+bounces-290404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:01:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 474835A5511
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4C5A309E36A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4E3806AA;
	Thu, 21 May 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDRF1Z1l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330193CCFBD
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367821; cv=none; b=PGXPNWP0PhURJ61j1eTEMSzdeIadZRMn07GJ5JAVImVzAX0/hMn1SxyZ95bbz0J15p4tkpYm6xRbKgBRJNQsKX88RYu5bqVqxBOvkcPzYz1HzyxfOKXCz62v33L3VZWjPQWRlQmyrBuSmUO3wYlxgw8BB0wmpoltVBsvQOQ4cYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367821; c=relaxed/simple;
	bh=lx1WvBKn0pMi/OHOQ28saLK4HRekU/jnGv6Qhpo1Trg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3fGus8uP+CAfj70cxIwN2MMJK9Qp9ynUoPwWNSpOhghg3w1k7jhUvHXzuoo6ZClAMf9kE7HQO4CdlIvr+g/C4y7kTOvLpTPiOnxVWNGb/N8m+bTZFbyHwPsBVwxbZEtU1D1ZZd/VB1SFhTNxbSFMXYmAjGWogXHWeUChG+TyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDRF1Z1l; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779367821; x=1810903821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lx1WvBKn0pMi/OHOQ28saLK4HRekU/jnGv6Qhpo1Trg=;
  b=KDRF1Z1lOjXfqbj8XRhloOOaXc5ZPkcGdxQSzNGeXhxPeNSB7Viqyz/M
   SQhS61gXUG7zqC+yJuMR65Snsim4LJRFX09wDk5gb3YsPCw/U8VdgydSe
   K2N3pJMpf2/uKfnomNOrmYciWkcU2tv5QvYFN1f9P/XSKKnrskeP1TMVN
   bydhxnrz1X+Hja+m0wXk4jZGs9/WadX4bixgdiEOcKJkJZQm0/zgfVWvL
   XeXkOGQWVLkFtBBCw0NADHwEIE2RptSUYw2ec0d0WsUwW0Fg0wpHmzIRh
   EI1L9cKu1WpHN0pZ0dGDv3qQQmEko3SEEuU+zojIVPNsrKHi9Dlcw6evh
   Q==;
X-CSE-ConnectionGUID: 8PI+SWDQQ1eBAjTrY1g2uw==
X-CSE-MsgGUID: o03FP8taTwS6gVcy4+MEsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80013481"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80013481"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:50:20 -0700
X-CSE-ConnectionGUID: nwvutBB2SFuey6Wo/wMcEQ==
X-CSE-MsgGUID: 9q6wDjMLSwqWue1JRiil6g==
X-ExtLoop1: 1
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 21 May 2026 05:50:18 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0705328779;
	Thu, 21 May 2026 13:50:16 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v4 00/10] Add ACL support
Date: Thu, 21 May 2026 13:49:50 +0200
Message-ID: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,linux.intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290404-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.intel.com:mid,intel.com:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: 474835A5511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v4:
* Fix a bug where filters with different flow types would use the same
  profile, leading to strange behaviour. See patch 4 for details
* Clean up confusing code using struct ice_fd_hw_prof for ACL. This
  struct has many members that are not relevant to ACL. Also remove some
  code that dealt with those extra members (it was redundant). See
  patches 3, 4, 7, 8
* Resend for sashiko. v3 failed to be applied and therefore was not
  analyzed
v3:
* Various minor fixes, mostly reported by sashiko [4] - check individual
  changelogs. Not all comments were addressed (some were irrelevant)
v2:
* Rebase. Notable conflicts were the removal of ice_status and the addition of
  libie (which affected AdminQ communication)
* Reduce the number of defensive NULL checks
* Use = {} instead of memset for definitions
* Use kzalloc_obj() instead of plain kzalloc()
* Move from devm_ to plain allocation for objects that don't require it
* Move iterator declaration to loop start
* Move some defines out of structs
* Fix kdoc (except untouched ice_ethtool_fdir.c functions)
* Adjust style (err for return variable, spacing, rewrite some comments,
* commit messages)
* Remove overly verbose comments
* Add patches 5, 6, 9 and 10
* More changes listed in patches (if applicable)

[1] https://lore.kernel.org/intel-wired-lan/20200914153720.48498-1-anthony.l.nguyen@intel.com
[2] https://lore.kernel.org/netdev/7192efe4d27c93148b3205e65f37203c89170316.camel@intel.com/#t
[3] https://lore.kernel.org/netdev/CAKgT0Ucxd5-gvEwWAdbL04ER2o++RX_oekUV3E0rYquEgFKj1w@mail.gmail.com
[4] https://sashiko.dev/#/patchset/20260409120003.2719-1-marcin.szycik%40linux.intel.com

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
 drivers/net/ethernet/intel/ice/ice_acl.h      |  170 +++
 drivers/net/ethernet/intel/ice/ice_acl_main.h |    9 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  393 +++++-
 drivers/net/ethernet/intel/ice/ice_arfs.h     |    2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   18 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |    2 +
 drivers/net/ethernet/intel/ice/ice_flow.h     |   39 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |    3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   10 +
 drivers/net/ethernet/intel/ice/ice_acl.c      |  486 +++++++
 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 1127 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_acl_main.c |  295 ++++
 drivers/net/ethernet/intel/ice/ice_arfs.c     |    8 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |    8 +-
 ...ce_ethtool_fdir.c => ice_ethtool_ntuple.c} |  678 ++++++---
 drivers/net/ethernet/intel/ice/ice_fdir.c     |   32 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   11 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     | 1234 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   94 +-
 drivers/net/ethernet/intel/ice/virt/fdir.c    |   32 +-
 23 files changed, 4433 insertions(+), 254 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c
 rename drivers/net/ethernet/intel/ice/{ice_ethtool_fdir.c => ice_ethtool_ntuple.c} (78%)

-- 
2.49.0


