Return-Path: <netdev+bounces-303632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b0aMDigVRWq56goAu9opvQ
	(envelope-from <netdev+bounces-303632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2CE6EE108
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:24:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jC9wES2t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303632-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303632-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 155983352179
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F1481231;
	Wed,  1 Jul 2026 12:45:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C943FC5A7
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909930; cv=none; b=hugei2nT42sMjGezGkkxUD7ii557phUcrNTxadZUg3F0nt0p8u3UprPeJm+fm7POvQ7fCxFl1a0KFPeGzOfTH11PD2BGtbOVyTM6xroWonSqIngOPNEBrccbG6Zz9lcXsy4W3rbkHHPK8B43b6/UhO1aMObduScyTHbPQVzS9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909930; c=relaxed/simple;
	bh=Ee+lE+kqF+UW+CC3Y+iRpZ7NDEeaMFnrQysPBjCQjwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XX5LHbnlQsRhI7Kp8LhDt/TjZ205UE0wJ+KW8qI/wroGNcO2uWxD5e0ELjCMW4zE4LO+Xut6CVrGTpo7Ng0SmZ1avkDt+zAPrkDUyqkL6zOiLCC9TlPmPySaLAuH8/WBAza8bVHHTpZp4gjABPkynKLO1E7cIvXtcp94bqcDceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jC9wES2t; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909929; x=1814445929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ee+lE+kqF+UW+CC3Y+iRpZ7NDEeaMFnrQysPBjCQjwQ=;
  b=jC9wES2tZhYLxUskq5lcPf2oa61z8y08ojc7yNJiPE9ziqMMyvNzN9dL
   5pJl3Mm5N4bmf6WFbkYRWuQANbJVhBQJ5f7Xt4TAnD4wClh/yeWD08jeh
   908gpEmWBZZvSEUIcrHNA8Gemmlp2u8dC05n848Syir57m4dcvDedQ+VJ
   R1ZVwE+wZBtaH1NXJmlDf2QxPsUwaVvZGmIOLLGzaYYEMOUXSkWJXrcsi
   tRXWJqYmho2sHurod9ykx8mtvXtlP016cTDWYdEsBeyXRHHw/nzWX+J9N
   6xXvJFSnhGYzZMEPoFOrnNrs3XFmka8i3rfio+KJCU9k86GUkiAZ87FYK
   g==;
X-CSE-ConnectionGUID: BWxK/OxyTo2QawU+p2+z0g==
X-CSE-MsgGUID: gZqtdyneTDahe2j2l2QvnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839216"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839216"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:29 -0700
X-CSE-ConnectionGUID: udtkwoYZQwmoAK1bYme10Q==
X-CSE-MsgGUID: pdH1mJgdTPOMOiewBgjupQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864882"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:26 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 net 0/7] i40e: re-init and UAF fixes
Date: Wed,  1 Jul 2026 14:45:17 +0200
Message-Id: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303632-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B2CE6EE108

v5:
- include three new patches to address last Sashiko review
  *
- do not release the irq lump in rebuild path in patch 7
- clear dangling pointers from rx and xdp rings arrays
v4:
- add preceding patch that fixes a case when some of re-init allocations
  failed and we missed de-registering netdev at failure path
- pull out i40e_vsi_setup() changes onto separate patch
v3:
- address UAF when ring arrays were freed before q_vector's ring
  containers (Sashiko, Jacob)
- remove bool params from alloc/free array routines (Simon)
v2:
- NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)


Maciej Fijalkowski (7):
  i40e: unregister netdev before clearing VSI on reinit failure
  i40e: avoid null ptr dereference in i40e_ptp_stop()
  i40e: make ring pointers unreachable before freeing via rcu
  i40e: avoid deadlock when calling unregister_netdev()
  i40e: fix potential UAF in i40e_vsi_setup()'s error path
  i40e: do not expose netdev too early
  i40e: keep q_vectors array in sync with channel count changes

 drivers/net/ethernet/intel/i40e/i40e_main.c | 128 ++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  |   5 +-
 2 files changed, 82 insertions(+), 51 deletions(-)

-- 
2.43.0


