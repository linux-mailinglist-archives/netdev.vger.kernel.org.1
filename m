Return-Path: <netdev+bounces-137032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849EB9A40ED
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149C5B20A01
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14949131E2D;
	Fri, 18 Oct 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfZQU1cB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8620E30F
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261113; cv=none; b=qszv9xZHdvuSg9RIdogwwzCCMUilyZHWcxjYkRnFZwC68Wb2FDshLCAr4DmWTYsHHIu7SPGHyW54PSlBilrq0NFxltwqHwRQcrcUgCk9AgJ+f9q58NQQzRhZkoPSMtbu8YQpaJ+Wde2EqjrbfaJazFaUq9WQxvoZE+W5BQMCtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261113; c=relaxed/simple;
	bh=BMORuUBAGhC1VOexeLNj8xomPTU9KfvMfMcUnAu/XDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/bGiJX2vCgD9kNKgXAQ3Uy7McIWDJe6jQ8Ecjr8BIsJB0gfexV6AY0RzCWCyINZ1IjzkU/tnJwsYhYK3u2vpP2Uxu7MMbDK1uXn/1LSkwljoz5X6U+4hyJtLJe3rKi0ChorXv1kuysbougRQeyySCtpvf/STDm0K8Ef+f8or6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfZQU1cB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729261111; x=1760797111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMORuUBAGhC1VOexeLNj8xomPTU9KfvMfMcUnAu/XDU=;
  b=ZfZQU1cBWM7muqvidGFiGmqTlZXEhK5xyAWAx5npCGfYzZOu3umLqbz5
   4OYUWcpqtCNSiw0X/mmFIGsRRxKNgL1JUlC4CUvM2sorJcGY+9YeQWkmL
   uQH9jVChEJ1Z8O24rW3XgY19ByN8+cO/fgbRE8tPdTabsC1oMMrx5hagD
   GSf3pO++bI64zWOEktn6wEvr6993CseMOFylEnDJWRJ2Gyhp+Fj/29KPh
   vk7CBg10aoF5L0m6znXI65IGVaR/wfDjr76XToY+Uz3EZmfBTUA+p+668
   PmjBvtSxi79K8tUDo2XL7zc7s2SAPyMQygHhfhfXhGc1+zDXkBsxfrQ+i
   Q==;
X-CSE-ConnectionGUID: TKb3mJaATDui12teNNDPMQ==
X-CSE-MsgGUID: bffWrsvzRAq2yrIXUN0/+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46293158"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="46293158"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:18:30 -0700
X-CSE-ConnectionGUID: TY9o3tiUSomtCcdBTwRWkg==
X-CSE-MsgGUID: a95atw9TSeOq3Cmv+9kL7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78929736"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 18 Oct 2024 07:18:29 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 819072FC64;
	Fri, 18 Oct 2024 15:18:27 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 0/2] Refactor sending DDP + E830 support
Date: Fri, 18 Oct 2024 16:17:35 +0200
Message-ID: <20241018141823.178918-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors sending DDP segments in accordance to computing
"last" bit of AQ request (1st patch), then adds support for extended
format ("valid" + "last" bits in a new "flags" field) of DDP that was
changed to support Multi-Segment DDP packages needed by E830.

v3: (Simon)
added ice_ddp_send_ctx_set_err() to avoid "user" code setting
of the ctx->err directly, fix kdoc warnings, removed redundant;
rebased.

v2:
adjusted authorship, rebase, minor kdoc fix
https://lore.kernel.org/netdev/20241017100659.GD1697@kernel.org/T/

v1:
https://lore.kernel.org/intel-wired-lan/20240911110926.25384-4-przemyslaw.kitszel@intel.com

Przemek Kitszel (2):
  ice: refactor "last" segment of DDP pkg
  ice: support optional flags in signature segment header

 drivers/net/ethernet/intel/ice/ice_ddp.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c | 301 ++++++++++++-----------
 2 files changed, 166 insertions(+), 140 deletions(-)


base-commit: f87a17ed3b51fba4dfdd8f8b643b5423a85fc551
-- 
2.46.0

