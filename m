Return-Path: <netdev+bounces-275774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EAdKQ1A1GmRsQcAu9opvQ
	(envelope-from <netdev+bounces-275774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:21:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272813A816C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54BA83012848
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC6393DEB;
	Mon,  6 Apr 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDhsHEAm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD93301702
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517707; cv=none; b=LxwqxoFjhi7r0w/HPi9cWivjqpwpGwg85qzUDwyL0P8ILynrEwkvkp+Yu31vNti72xsJTLP1JkdY7eKAuKn46XgDK4dEhf0ODkg+YRNxkVZdsncL0yHfD32QgUQ0p5UWhcs0I9Ul10DuqK6QCOKmEDEd2HnkHBfLsweiRo9375o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517707; c=relaxed/simple;
	bh=7xmwcJYJm6E1fVmwZFpjH2ZcK/4kqQYQeVx6z126pwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LP13HNlIMCALy1XljSSTsbp/y7PwN9gq411Bns8YVclTIz5Tws1NrnYF3AybPSCp0qa1YSDxu02qmDjv1aQkSVmcHjGoHbMUthlKjMtCo+UzRlel0GHPAjFHJrwwwvK7mmriBi88DUdP0nlk2N+m55XX+1PXiQU/IGd1maxBbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDhsHEAm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775517705; x=1807053705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7xmwcJYJm6E1fVmwZFpjH2ZcK/4kqQYQeVx6z126pwk=;
  b=MDhsHEAmPw313U0BhZJMwaz2qB0qbDG/DAlxj5iFJnUXmqwxpRpdNHmA
   CQXHD1izrrEYU8Df0L9bkugn4iy3JJcc9S5KgqnUGWOLmslgZXjH7r1Gq
   r4+onlEchD8tHAIm6RFY6rQ9c+FlOynEM6luiPU17OL9DMiwjvx1lRDsr
   vSF8X0Q/8IOMNb1XwxHNLmZqXP2UI7VE1TpsLF48mGWwREydFIrO1Gx0+
   GzrjgoIkVoNTyRfytXLOTWl4/1wGsL/ktBea62V/XYkBfdb3k0inMZuOx
   yZ9SAEo1TtKvAEcixW5CbTNYGu45pvkvHvm9UlhHxODm1lF/rMcOXbAKs
   w==;
X-CSE-ConnectionGUID: gA8b3x1gQVy9mTAxLGaqvw==
X-CSE-MsgGUID: V4324ke9TBePkhTbM5orbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76368981"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76368981"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 16:21:45 -0700
X-CSE-ConnectionGUID: HGI4C95KR1Kb0yjomD8imA==
X-CSE-MsgGUID: 70QloSe0SbiPEaPQaNavfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232050498"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 16:21:45 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-net 0/2] idpf: queue based scheduling fixes
Date: Mon,  6 Apr 2026 16:32:34 -0700
Message-Id: <20260406233236.3585504-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275774-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 272813A816C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes some TxQ scheduling mode issues exposed by recent FW
changes. 

Patch 1 prevents XDP from being enabled if queue based scheduling is not
supported by the firmware.

Patch 2 fixes a NULL ptr dereference in the Tx path when queue based
scheduling is enabled, and also adds support to process both 4 and 8
byte completion descriptors to avoid timeouts in queue based scheduling
mode.

Joshua Hay (2):
  idpf: do not enable XDP if queue based scheduling is not supported
  idpf: fix skb datapath queue based scheduling crashes and timeouts

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 49 +++++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++-
 drivers/net/ethernet/intel/idpf/xdp.c       |  7 +++
 3 files changed, 43 insertions(+), 19 deletions(-)

-- 
2.39.2


