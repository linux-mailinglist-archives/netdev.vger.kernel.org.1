Return-Path: <netdev+bounces-241274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FBDC8224C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 430E33498EC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C0233722;
	Mon, 24 Nov 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG4p0Wgq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395C256D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010084; cv=none; b=nkuk9OpD9qxLb3DZoU7qPRjdQrNCXAf9nHStlUkDJjDgidoyZ4p6B81Dd+KE2g/+iNesrL9fjWNmu2u7UZunElviCvyzkFdQW7R8/ACKYA3gxWknRJ7fwqB1Hnb/IZgRFolAxKUNH3NHxnp3XkUS1/VvrJyrYc1dHLKoodJoW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010084; c=relaxed/simple;
	bh=aEPNYQS/8ZzRiAi3CKQ0v1nHusy/tQqZM30T591yHfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7iAGkyLpduVldDT/u5DidEs3q03CtZWmsEmLacpSkbIpei+FIdCLtVRvyNjN6mh0WT6d6OFMoh9mZdnxo1IenTE2IiOasXgT9RWJqskJKU+gpyMUPN/V8VtA5XsR+MCE/mIf9Kbd1u0yJ0ViYT1M+adTIpybkd5kbg9wD2JKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG4p0Wgq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764010083; x=1795546083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aEPNYQS/8ZzRiAi3CKQ0v1nHusy/tQqZM30T591yHfw=;
  b=LG4p0Wgq5Hl0QA6dj+aIz3P+tDktId2kQ6iTjkK6/oBzdwp0VAizq0/s
   +lvuPaXT1ODd5FHR+qrFPaaKsbpGoellGvJHkKOirV82Ci+ynomgB3oCB
   uzAbohfjW5cHdfOnzET1YRs3uOg0+jnNrxLg1hKN8FSkh+SThAdSJ+qR1
   39Fc/pybyqM8UYpq49JJkUPdpHmiEPfNdAGwednSkPkntV65Udkfwn0Ff
   SMj7P96cnQNLhpdVDRu/B/viNCkH1BDiPesNHfi+CQGBMIgjHWg1Mji6S
   ECMYl9uVhJiyirCyZXGY3S1+TDyt6fUvyhU5aNdlyMsj9JvAJNOeocNhx
   Q==;
X-CSE-ConnectionGUID: P3GpQqEOTTOuXmti6aAfSQ==
X-CSE-MsgGUID: KGTo4k61TQCB1+3EBVIZPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76341770"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="76341770"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 10:48:00 -0800
X-CSE-ConnectionGUID: byfvj10NTFmfVm7VXBGIpw==
X-CSE-MsgGUID: 2uHI4RNfTamgyFrnFwEEJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="196574867"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa003.jf.intel.com with ESMTP; 24 Nov 2025 10:48:00 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: [PATCH iwl-net v2 0/3] idpf: Fix issues in rxhash and rss lut logic
Date: Mon, 24 Nov 2025 12:47:47 -0600
Message-Id: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool -K rxhash on/off and ethtool -x/-X related to setting up RSS LUT
indirection table have dependencies. There were some issues in the logic
that were resulting in NULL pointer issues and configuration constraints.
This series fixes these issues.

Changes in v2:
 - Fixed some issues in patch-1 with goto statements
 - Formatting issues in patch-2 fixed
 - updated the logic during soft-reset (patch-3)
	(Reviewer: anthony.l.nguyen@intel.com)

Sreedevi Joshi (3):
  idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
  idpf: Fix RSS LUT configuration on down interfaces
  idpf: Fix RSS LUT NULL ptr issue after soft reset

 drivers/net/ethernet/intel/idpf/idpf.h        |  2 -
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 17 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 80 +++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 36 +++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  5 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  9 ++-
 6 files changed, 64 insertions(+), 85 deletions(-)

-- 
2.43.0


