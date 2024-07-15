Return-Path: <netdev+bounces-111461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE0931297
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758041C21424
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F3188CB8;
	Mon, 15 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQGPryqC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D671188CB3
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040618; cv=none; b=mJ/O4FAWd4L9Pl4ygF7kvHM73m/HSylx3f7Fp2sOPfNZSW30Hle9cs0zI7/MG3BAbVN/270XfsH5Jd1iirDJGjM8BXyrUFpYB6Hry5+Fa6NzUJk3jd2gI0ymEtXsTMYf6DjwM5xdwPKBjvz1Qpb1nit5ZTKv+l+3P7LDfInIddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040618; c=relaxed/simple;
	bh=xEuylVJbMZlQtdVSzPl1C/uAWlhBXQX9XqnLI+Z9gZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuFBYIbWS8gjY5XAkpddlzVF5o7hJXtZXC1xA+MWgvT6V+bJqbjjqMfm0iZPqvN/xQiPfqh9PlCpNtpa7Do3ethZU4jdCr3mx+cjZUkRuZuX0p8IlnWh+CMhHJNcKFZpWXavrZSNIc6ibmDutZvPqbJVwX7SHeb3gpahLAYI/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQGPryqC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721040617; x=1752576617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xEuylVJbMZlQtdVSzPl1C/uAWlhBXQX9XqnLI+Z9gZc=;
  b=SQGPryqCyyjfzOrdCkpwJEqRDQWatPcdPMV2sQMaOXBEE+Wx2jlaPPyW
   Lvsl6rIg4GfJ1uAjzcUZC1Q4QwQKuKCTVvCaWB9MdmLTQyp68/oaUz4AM
   p9zf92palfcXW62mqDZGiPmU4LrSW+6E0miHTIGFPNXX4Nz0rbgEKY4IC
   4EZZH2ngSsWVa+zVE5xJMAqyPhRVtYqiOtG7lXl/ppwhBoqeU7e1uKBda
   91pI9/uq+Feo7aAe6wnhyTWcnnjgTlGhaiDaI0G8eSHPn6iZorPaTAudj
   a2cuwFp308klBYsX/BKxqUZwOwHyfFgjCXJVswR+hzEnhYglc5hq0WKfX
   A==;
X-CSE-ConnectionGUID: 3ZHWuVXUQTuX1Fcyu80CfQ==
X-CSE-MsgGUID: zbefNOt6SkqLYCCo5wpWnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18608973"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18608973"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:50:16 -0700
X-CSE-ConnectionGUID: 2ISnqq1US+yIqeEcq0LNlA==
X-CSE-MsgGUID: XiOKpQE1S5Gr6gfGlQQkyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49545131"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 03:50:15 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-net v1 0/2] ice: Reset procedure fixes
Date: Mon, 15 Jul 2024 12:48:43 +0200
Message-ID: <20240715104845.51419-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes preventing possible races between resets (CORER etc)
and OICR ISR invocation / PTP hardware access


Grzegorz Nitka (2):
  ice: Fix reset handler
  ice: Skip PTP HW writes during PTP reset procedure

 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.43.0


