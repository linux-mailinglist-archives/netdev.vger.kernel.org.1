Return-Path: <netdev+bounces-127326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9197507A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E473B23B71
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C9185952;
	Wed, 11 Sep 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkMZGP1k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3C48CDD
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052992; cv=none; b=cOEtSb0RqfNlCVVRp5RQnY09uyd/a+zmjR2kKlGSdw6sccwlU/VRHDP8m7FMRpaEE613iw/md9aPoyJoJfB/vGv18au7j48bsuZVSerdyUh96/0cVajKitMj5q3/o6gAWd/jgFpTAzAQnwmFxebY4AypFVbuNSSQOsF73goiDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052992; c=relaxed/simple;
	bh=Nuj5SVtR8ZG4rAKfYptA07GXt7y+ssMEQhjvs1pTMZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoG2QhdwikuvhFpgY9YGGYdGCWOXKLD+jBtQZyS4hIRCdx7CmmuYoXUGsoosWM5wEqhWALfWO8oBSa/GlV6hspY2vCoQt+3LvcFZR/rHg9trNlbdUTC4n79PUr1VvGaWX9UdleTJJxSWOhBE8VZroa1P30qtSKZOvj5EsVD+5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkMZGP1k; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726052991; x=1757588991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nuj5SVtR8ZG4rAKfYptA07GXt7y+ssMEQhjvs1pTMZs=;
  b=TkMZGP1kH0egl0zTeD3KBmj29oGhDhcWuOYXVtauZTyCdz/3V5D26I5H
   +EI5gO9t0D/654TxgA2eZfkvyOMZt06hJKvoRwn60zxpq06vIdXe3wCGN
   qHpGGrd6GnhUnJQJV8mRNiJqiej0SA0I5EkM17GsvcHXSEjXFLaGMewzH
   JaJLO3haesDlg2xBHU3AIltUnmwYUC1T+y7tFed2sETWRbeK1Q+JPGITf
   QV3xIRQ5YmkEPJx+3ozW4KKVAswOyx45feB8WvAHyiQ3S+/RcTgu1rWqw
   NG2EStjZapEFkGu48RwEvFmG6ghs7kyEnE7sdt3olXnlfHdYdV8fJZnz6
   A==;
X-CSE-ConnectionGUID: 6zHi1UkHTPKve6DXwrs0Ig==
X-CSE-MsgGUID: XDAA14AMQHySaeYaM1WuQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35437562"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35437562"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:09:50 -0700
X-CSE-ConnectionGUID: 3Tar9uHoSt2jcFC8404p/w==
X-CSE-MsgGUID: M4VeTL/0Q8arXgjEoGN5EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67352977"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 11 Sep 2024 04:09:49 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.145])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F389327BAD;
	Wed, 11 Sep 2024 12:09:47 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 0/2] Refactor sending DDP + E830 support
Date: Wed, 11 Sep 2024 13:07:31 +0200
Message-ID: <20240911110926.25384-4-przemyslaw.kitszel@intel.com>
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

Paul Greenwalt (1):
  ice: support optional flags in signature segment header

Przemek Kitszel (1):
  ice: refactor "last" segment of DDP pkg

 drivers/net/ethernet/intel/ice/ice_ddp.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c | 292 ++++++++++++-----------
 2 files changed, 160 insertions(+), 137 deletions(-)


base-commit: bfba7bc8b7c2c100b76edb3a646fdce256392129
-- 
2.46.0


