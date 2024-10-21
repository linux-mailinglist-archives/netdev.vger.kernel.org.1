Return-Path: <netdev+bounces-137527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1109A6C71
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DD81C21894
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC61F9AAF;
	Mon, 21 Oct 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBpZQzlk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DB01F7092
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521765; cv=none; b=VOne4oLvSvp/LOZgRDcaMBka746dh+340jt5GZf2qHLwcVO37OCKolJB5ZvxxK57+rf0NC54btNRxKC8r11VjYWJnMcJT7PTI6iTQNw/eMTzy1Sj5LQIibivW5HJwstBYCvVFuNFnSjufgoFucWUiyF/ylIU/PydceFstdbWLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521765; c=relaxed/simple;
	bh=0jMj2R4y40mpfGAjo7u60beUyCLYy3jUUb5fV/e/Fzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPkxy8dk6ISHnTVPKLtkMGyoRJuIA80i7j/CdLgMxQC0PO/CMxg1hy5K/TUj5F9b7lQmYxIlLcx8a28DGrDxfwxM27vZsga8e8tjYiVFyQsBkfbfQ71qE+51zlx4JqBnS0yN9ttUYZsBnUPIqrabGY87WvhBB+VQrl4rBiKXaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBpZQzlk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729521764; x=1761057764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0jMj2R4y40mpfGAjo7u60beUyCLYy3jUUb5fV/e/Fzk=;
  b=PBpZQzlkFamdcFK0jN/cQSX4xr+mrWslthsCB542urcIAdPiP3JAxeTP
   jdqdHshfnovTrkp6iSOhRgnnGWpaRjQKR5gk69V8HSH7Acv6SWRx+JSwC
   MouTlw7JSoCDBWm8Ns/1fePWdDajc+G5ukw2pzc8Bqoux2zHK2k7wWdqS
   Ue6GfQtVO40p42nH+Do5WWzdxMjBZCnt5qtMkpvHErAwVub9gJimBuz1O
   78yK3y1c/3tCDAjrn4Jptr/gHvfBCJ3FDzA4oxGYun1/vSwyTa1bV4+u7
   5KNDD43DYfTxgd6LDQucg2eHQ5g15AZjaYyE/kNls7vCeUJ1wzkNINo8H
   g==;
X-CSE-ConnectionGUID: fzzsJkHURk622E/of4p0Qg==
X-CSE-MsgGUID: pNX83EKKQBm1TUqdKCkflw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28783934"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28783934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:42:43 -0700
X-CSE-ConnectionGUID: AvKQVR9DQl+Im2hIxrmhUA==
X-CSE-MsgGUID: JjScTn6gS5W6+X80IAoysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79183353"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by fmviesa007.fm.intel.com with ESMTP; 21 Oct 2024 07:42:42 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v2 0/2] ixgbevf: Add support for Intel(R) E610 device
Date: Mon, 21 Oct 2024 16:40:27 +0200
Message-ID: <20241021144027.5369-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel(R) E610 Series of network devices. The E610 is
based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

Piotr Kwapulinski (2):
  PCI: Add PCI_VDEVICE_SUB helper macro
  ixgbevf: Add support for Intel(R) E610 device

 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 include/linux/pci.h                               | 14 ++++++++++++++
 6 files changed, 47 insertions(+), 6 deletions(-)

-- 
v1 -> v2
  allow specifying the subvendor ("Subsystem Vendor ID" in the spec) in
  the PCI_VDEVICE_SUB macro

2.43.0


