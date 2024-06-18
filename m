Return-Path: <netdev+bounces-104457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F990C9B3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79F51C22C0E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A44153837;
	Tue, 18 Jun 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V31wlQ+B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF0153815
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707406; cv=none; b=OHsJXHK0MbcJyP3RA5tOFM1oYpTwin7Q+Vw3hc/3UETWjyHVQmkWjIWKqz7nLqrkT/FHIFG4hpqhR8Kb9qlHfD5u2KvjQ+6JyKBhiboGbXL3eKIop/7w6dCtdDYYd6rdTSlD157oX76dfDGyUTguRZxzJauedGI19owa7B8AC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707406; c=relaxed/simple;
	bh=N4IE9SOABOtfUY69/FLYKUX58ZwzA7fp3iH1LuVUuJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fB2zxlbjPF2hAtu8RsLy4v4D85pZufljTS2KLSNhauZJ4GCPm557ynaJMw58A6wSeDb2GZYnloEgzZB7cwmbge/U9hImGFc+syVjTN3rdhgyBQ5ILZquh6ZgjzhFh+PrnDmlZLIkJvwLPXXvTZ2zSCYsYPp4GcHHuMgvxQ9DeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V31wlQ+B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718707405; x=1750243405;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N4IE9SOABOtfUY69/FLYKUX58ZwzA7fp3iH1LuVUuJ4=;
  b=V31wlQ+Bv3O8dYl7ojGFfvy5SnjM+3RsdRbbAhy1vkogcjoYvtPbG5yd
   EC9vMSBrFm/rxgAMCoESaadgDDlftLmKX6byDfdw8jqp7/+10UxlCHh2w
   uzUwUOrAcYIugE2r3X/5/hl7Q5a52/DpC1L4HyaB1w8YjIyMhKMdpEQQD
   PT0vbFeBZRIWZpPdb5o3XSo+mMMKQ7ngVPyxNGwND5LcaESd0rf51EjZE
   xcZ40/huU6mYdBKxtyvH4bPNoog99yhZqeXRHSDpKOAOf0DAKjgNTv0g5
   5thQER5rhEughlMNw9AtGstWqkmfpKrzeiL6GSAqChb6/wbNBhlcYdIlI
   A==;
X-CSE-ConnectionGUID: /ZvG5kFcTD+CtJbK/xGQhA==
X-CSE-MsgGUID: JkGWH4r5Qa2ri8Tg2iRICQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15719448"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15719448"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:43:24 -0700
X-CSE-ConnectionGUID: IIO7MdTHSwmyxJPnsO9T6w==
X-CSE-MsgGUID: FDi8uy0VQd+Ogs7+sNEyvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42227736"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2024 03:43:23 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-net 0/3] ice: Fix incorrect input/output pin behavior
Date: Tue, 18 Jun 2024 12:41:35 +0200
Message-ID: <20240618104310.1429515-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes incorrect external timestamps handling, which
may result in kernel crashes or not requested extts/perout behavior.

Jacob Keller (2):
  ice: Don't process extts if PTP is disabled
  ice: Reject pin requests with unsupported flags

Milena Olech (1):
  ice: Fix improper extts handling

 drivers/net/ethernet/intel/ice/ice_ptp.c | 137 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h |   9 ++
 2 files changed, 113 insertions(+), 33 deletions(-)


base-commit: dea9bffd24e4d556bb05511d60ae78c302e66b4f
-- 
2.43.0


