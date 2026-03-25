Return-Path: <netdev+bounces-271408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EAYB46Bw2n9rAQAu9opvQ
	(envelope-from <netdev+bounces-271408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:32:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C41193202E7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F18F630862E5
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47892358388;
	Wed, 25 Mar 2026 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghDbE9TE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBD03537F1
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420347; cv=none; b=ivpy+u03qKyf/3YxROwBBag/s9D6RuBflu+37Lzqm/QzwPjMU3seCdmjDzIKD2vplpw6FtGAkjnWgMHAHB5iATZtm6TNyq7kvYUsHd3bqVWdFfarARRK91FTDxH14E3479jegDrz6eCRmVWcoGdrFxge1JThT/cJGqaI1SWPuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420347; c=relaxed/simple;
	bh=rr6l49RKEKgpQ2DNOXWch18uCBagDtqaiQoNtQSds+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZfkff499wcDqTnbXP2LnKY3k0Ti0h8PUAqC9WPkmuDLTXCkfux+JsHQ6vgN01zFFvqxoS9QQgPBjKYkzqtxk/s0CLSijyItR6a/dHmyCPwYZ5VFRmtC+IhqGXEczwwv+6yvnkfoSWxAn4Z6yVTDLpIfmrYHv5QtYIZdWiSRzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghDbE9TE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774420345; x=1805956345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rr6l49RKEKgpQ2DNOXWch18uCBagDtqaiQoNtQSds+k=;
  b=ghDbE9TExEI8WFMxu4mTwA/9PiB3JzNCjh97vJUzsBhSccZY23hJBqql
   SQDXSriYcYy1FIkB2wB0M+6DbipCYUzVBV1u3vqL1sWFWve2p0Fb3GsUZ
   nxwpwkQVC/6568YIyHxrbSct5G5buL7FzGSj8ILHkvC333Tjots6+cEv/
   XIysqG0QNz/IfiNl3rSi4yFLZepTzDDUXS+RrlA69n4y/O4zb3mEF0IqH
   zscDg6skB5XNWc21h5Db0kjSDrEgal802jDRNul36Smwvlz5U6SLfwAJY
   tVCj95ypyLcDybQ50C5NS0Ok/kOMrWq6H0Oj4mUgqL/w7YERpNx9hi64U
   A==;
X-CSE-ConnectionGUID: ahSk1woGRFifC97bdlVhhg==
X-CSE-MsgGUID: REuob8CxR7mrFaDz1gDF5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79308047"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79308047"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:32:01 -0700
X-CSE-ConnectionGUID: c4AZVoq4R++XfBqFDgcO0w==
X-CSE-MsgGUID: AkmZzNiURHaHCed3r6J5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221693624"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 24 Mar 2026 23:31:55 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.24])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A69C92FC5;
	Wed, 25 Mar 2026 06:31:53 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 0/2] devlink: shared devlink improvements
Date: Wed, 25 Mar 2026 07:26:51 +0100
Message-ID: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271408-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C41193202E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


First patch unifies access to priv data set by driver
(changelog in the patch).

Second patch improves support of devlink resources registered for shared
instance (new in v2 of the series).

Przemek Kitszel (2):
  devlink: unify devlink_shd_get_priv() into devlink_priv()
  devlink: unregister shared devlink resources on destroy

 net/devlink/devl_internal.h |  7 +++++++
 net/devlink/core.c          | 10 +++++++++-
 net/devlink/sh_dev.c        |  9 +++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.51.1


