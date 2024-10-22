Return-Path: <netdev+bounces-137978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272F9AB539
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE251F245F7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33A1BDAB8;
	Tue, 22 Oct 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n06TVL6l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87341BDA8B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618657; cv=none; b=F52QRQmhDIbOcGVpJ9Iv6QB7GXZN8vfU0zN3pXnl3lpgOTFxfMEB6d91PfEvTczy44SGkgWnS9XL2tYHFqf3Am9pa0zWv7my4CNRT/EIya4mRUmYAFfH+VgXXzYw+E7Gl1ExhhfWwwWRjZtRp+nHY638Mx5Es4rSrAkbNSl+ZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618657; c=relaxed/simple;
	bh=fG792TU8ikDhDDaKB7aPcrZ4hTCvyyR233chf+BttXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3bCerut597C08OhUnhlr+VDR1LuuLAJILPxn6WI9CpVnBdQ51AyjeqN4A5a7dNy3Fu/EqeJUpOpeE2SCTg5vG3TL1KT+6MXXECbKt/I7Ma97BEJYLzNHV9tXpellI2m3b4NrGu6Anj8eRiRuU1CmaoH0C3obzvcenVImsc4E3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n06TVL6l; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729618656; x=1761154656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fG792TU8ikDhDDaKB7aPcrZ4hTCvyyR233chf+BttXE=;
  b=n06TVL6l0RizJwaNq0RmuSUQtlejhZmBPbZJzpt/KIxNZ5MKxijJrX7O
   3gAw1hR+LaurjrUHdTbGYZahA9i2ds0MvfYT4UPZoc4Tz155vF5HJfBuV
   40vfZOVpQJ/zgrj1y88kiRZ7//q2pKo0Qv1WPWcF1MGeKry2AqrChLHGw
   W0dK4gniG6bi64WpTtOAQa5J8GqI6Wbt5b4q/Npg6khuTQIWDqQhag+mD
   mK3G4TPFQjJo6Mw8ojRCyFLozlbBQXQfXcS628uygK2vRjlzoxeYZdvUa
   W14t/GYgxEyEcwHSFnFu7g72vB+ilp2G6oD2wHvlNkQBtgVxHMeXj+PEu
   g==;
X-CSE-ConnectionGUID: KeRaydq6TOmzFKtd+rx6ug==
X-CSE-MsgGUID: fRy53OGkQvGHmpVl91MwzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39721919"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39721919"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 10:37:27 -0700
X-CSE-ConnectionGUID: zb2j2B31Reqqft+hnQL9/A==
X-CSE-MsgGUID: H/ZfjSAFQBmLav2F2Ey/YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79862534"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 10:37:27 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-net 0/2] fix reset issues
Date: Tue, 22 Oct 2024 10:35:25 -0700
Message-ID: <20241022173527.87972-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes reset related issues, especially the case
where the idpf is running on the host and the platform running
the device control plane is rebooted. The first patch fixes the
link_ksettings and the second patch fixes the error path in
idpf_vc_core_init function.

Pavan Kumar Linga (2):
  idpf: avoid vport access in idpf_get_link_ksettings
  idpf: fix idpf_vc_core_init error path

 drivers/net/ethernet/intel/idpf/idpf.h          |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c  | 11 +++--------
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  9 +--------
 4 files changed, 9 insertions(+), 20 deletions(-)

-- 
2.43.0


