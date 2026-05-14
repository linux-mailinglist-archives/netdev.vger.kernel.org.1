Return-Path: <netdev+bounces-288080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lb5CHYxBmrhfwIAu9opvQ
	(envelope-from <netdev+bounces-288080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356C546C08
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D30D3005D25
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055EC3976A4;
	Thu, 14 May 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbQD1hZX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E0390CBD
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790742; cv=none; b=Pa3tmGugNbCa/kfqj5GgUKKmxWaOJKEfUX//yNrkT4l1e9ULnJkUEKwtJjjC8xPm1O3FClHZqQe3Iek93XKqC30cn3aS+pn8tzSVkSkOg2VofE6hsANvhIkMMye6ouINCcJEnK+IufnW/I3iWhOhtVqdALsyoaTkeCss2VgJcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790742; c=relaxed/simple;
	bh=Dtbv8kTIaQE/7oeeDXs5F4ySLRxkpS5kih0oNzCyfXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDE+km8vbR5uMCAItTch1iYOqj/lo89YR1ZJ9IMwZWKXrVkJxYcnFOWDBBBY3ByYiSIAnhlF/GOuoTdTJ6KLZjZQka6x71YK9VtXfOHp/xmxujFp4MOsj6IEGThKkIu3gBvMXL7VkvxQUJUL4WQeoxIMq2FtwvVogXh0Yqg4c0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbQD1hZX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778790741; x=1810326741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dtbv8kTIaQE/7oeeDXs5F4ySLRxkpS5kih0oNzCyfXI=;
  b=VbQD1hZXE5GFgteybdw+bVM/gj41STS3cgpJqnEMOyc9Q9TqYYer9iCY
   zfwtA6Pb+47ZK+XpSI2OT28tkMmdd3hwFhDFtnSvkuRrJV6pKUPeaIl1v
   G70vdjWsCyrshrVjdOB3FYH9LjXXCJ+dDPA6hVfOMBBSBnAusnDtvYltE
   /EvJK2pi7McqAD7RM6aE6uYkUzfsk2VZlrJ2Ir6XH97FdrUlRdQaNNoxc
   6BZYOHC3PyBmv64tFyobRMafZM1pd0LMETZpcug6z6EkNhrNhHVisPcot
   EwCfB0xrB23gYFygbYf5xo2IKOob5YwDe2bjhv8w+TwFjP5Quzk5Q9sq4
   A==;
X-CSE-ConnectionGUID: havaAR1HT2KUwsVFtngVlQ==
X-CSE-MsgGUID: esvGrjT4RxGb8W9NBw8+7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880174"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="78880174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 13:32:21 -0700
X-CSE-ConnectionGUID: vTWMtmJRTtSGqHwCf/74Og==
X-CSE-MsgGUID: 5WhPTdKFTMiTpiGxBIebOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238361183"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:18 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	maarten@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/3] DRM RAS Fixes
Date: Fri, 15 May 2026 01:58:15 +0530
Message-ID: <20260514202839.1888688-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9356C546C08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288080-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Detailed description in commit message.

Raag Jadav (3):
  drm/ras: Cancel and free message on get counter failure
  drm/xe/drm_ras: Make counter allocation drm managed
  drm/xe/drm_ras: Add per node cleanup action

 drivers/gpu/drm/drm_ras.c       |  5 +++-
 drivers/gpu/drm/xe/xe_drm_ras.c | 47 +++++++++++++--------------------
 2 files changed, 22 insertions(+), 30 deletions(-)

-- 
2.43.0


