Return-Path: <netdev+bounces-138237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6169ACAD3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E1AB20A7A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E523D1ADFF6;
	Wed, 23 Oct 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpunFXgn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32381ABEB0;
	Wed, 23 Oct 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689206; cv=none; b=XCeeIymKGaYKwz7Oi4Sr0DPrSDE0oAs++Ir5ATal2wdNERYY4OzUJ7UpuFYAHavB4+Lv1GGiVh6JHLSuaNMEv4tzQkK4bZbg1VLVGUu+4Icdc9Q/CgDgDjnNcOFp3TX4FWnxQTpm4UI6toGl8DyjMpjFVh6aSJhM2/pHaf53Y4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689206; c=relaxed/simple;
	bh=rgw4bnOuycpMuLpTQw5v7vf9g0e7asXY29qw14OLXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3rjliW2DKsMyf7oYMPrk5HUXtF+kv66bRBEguLrwjegp2YeLqKBIuSspnYPGBeeazZ3anOC2PfZdYG7FKg6JJuristmdUXQyO9Wd6vlzp4YHOOpjaUcGUEuV/bvSKoXozXaKjw1WY5pxzbQqk729x+q4F16HC9np180CDvxItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpunFXgn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689205; x=1761225205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rgw4bnOuycpMuLpTQw5v7vf9g0e7asXY29qw14OLXhw=;
  b=SpunFXgngO1v45wgnal+w4ZwVYUQzxTSV1QaLuTcfjh/4rVUlRFINslY
   YuR3y2/AfhTeEjDQoh/OffOwV1GKN5IWuVR2/ulXvTHZr9xGFYLwbIjcD
   Oj88p52XWjZV4pNhCgem36SrUWXDjbCKDGOKlDMIKVTLNyUm9Y/6ye/P4
   8vkYWbGlWq/GyKgA+QuK6nDGOgQ4TSJmWAeGHOtRoR0FOErWWDe7KZWFc
   zBeV3YUsLrSyM6Z+Po73GEyGCAZldv6Y0NxW3CUydK4gSm6llAEs+xWI/
   ydbMUSxV+yvmAHtlhzT2CAX6PjuYQbJlZ7seFl123ZB8UJTZYKhOF9+Mt
   g==;
X-CSE-ConnectionGUID: eZ4liXSbQw6Ic9Q2d08Wfg==
X-CSE-MsgGUID: lFYX9DjgQM+p/Ci8gYEihA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758539"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758539"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:24 -0700
X-CSE-ConnectionGUID: rQLWd/UzSlOIA1dSGZx3LQ==
X-CSE-MsgGUID: DOvm3ALjQ8eF7J17sH1gcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820101"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:21 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BB4E32877A;
	Wed, 23 Oct 2024 14:13:18 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 0/7] devlink: minor cleanup
Date: Wed, 23 Oct 2024 15:09:00 +0200
Message-ID: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Patch 1, 2) Add one helper shortcut to put u64 values into skb.
(Patch 3, 4) Minor cleanup for error codes.
(Patch 5, 6, 7) Remove some devlink_resource_*() usage and functions
		itself via replacing devlink_* variants by devl_* ones.

v2: fix metadata (cc list, target tree) - Jiri; rebase; tags collected

v1:
https://lore.kernel.org/netdev/20241018102009.10124-1-przemyslaw.kitszel@intel.com/

Przemek Kitszel (7):
  devlink: introduce devlink_nl_put_u64()
  devlink: use devlink_nl_put_u64() helper
  devlink: devl_resource_register(): differentiate error codes
  devlink: region: snapshot IDs: consolidate error values
  net: dsa: replace devlink resource registration calls by devl_
    variants
  devlink: remove unused devlink_resource_occ_get_register() and
    _unregister()
  devlink: remove unused devlink_resource_register()

 include/net/devlink.h       |  13 -----
 net/devlink/devl_internal.h |   5 ++
 net/devlink/dev.c           |  12 ++---
 net/devlink/dpipe.c         |  18 +++----
 net/devlink/health.c        |  25 ++++-----
 net/devlink/rate.c          |   8 +--
 net/devlink/region.c        |  15 +++---
 net/devlink/resource.c      | 101 +++++-------------------------------
 net/devlink/trap.c          |  34 +++++-------
 net/dsa/devlink.c           |  23 +++++---
 10 files changed, 83 insertions(+), 171 deletions(-)


base-commit: d811ac148f0afd2f3f7e1cd7f54de8da973ec5e3
-- 
2.46.0


