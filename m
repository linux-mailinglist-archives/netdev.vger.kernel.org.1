Return-Path: <netdev+bounces-168543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF6A3F47D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCE63AE987
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AA209F4E;
	Fri, 21 Feb 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwNQPBxS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712D205518
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141303; cv=none; b=VZ5hBws9TnMWa8SuRKheCmthXASISDvGxbdk8b5olv6QFIDJ5W8S5ibVF8qBr+BsrKy4tJJEBJh2ebrTTfm9yhAjftp3BAVuxGWvMiBEaeiKwsko5FP7W7fyI8KuPsOXItAR7Mtf6QuisNUoSv6gnizfk4G+RslcmXp304uTVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141303; c=relaxed/simple;
	bh=R/+7sPe6uNOKfySZ6Knz9K0A5nD2QRvniqLznl4Lung=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sa6PgpXbH/fREuAJryY5Aq7XeFucYY+czZAL4MM9gNeHRWrsGG29HwcNRessEJW4guXgOqjUJxA48IsywymhzwAAh9q0KAcOwGCTD38t0gOA37Glcfv75nSSgd3rqhftF8F/ePl1oispWCxDZ4oF4u98J2TqM26kVvEFUNLTwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwNQPBxS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740141302; x=1771677302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R/+7sPe6uNOKfySZ6Knz9K0A5nD2QRvniqLznl4Lung=;
  b=dwNQPBxSxCGH8DqMr/osneSFD5ZIgFf/GqKz6JMM0P8AWK01AMztA7tB
   fGJrFxz24mzBayCaH/aAdDrrmBiGgOMqGiL8LGFTDx4n+E1RvEz9S+UYz
   l9E0OEN+qKjwmaegnG0MyBoQjNkwirjfo1Pg2MLZNIqQGQ/2HJG+XSo7E
   VTgzigZXBTB+e2/ASVxIFdYSW5w7FNT5uYIubGgqcTnayklFie2qZJQxC
   YUt02Wvs0OW7a4jUwJReG9P6AKZG/vU2R2iFJezRYH1IDkKhgXprcC4QM
   LP43aH0Cwmy9xc1iZKK/xcBmFgrCG641ttcIS2LZkGwYQh9MRuZuqdtuI
   w==;
X-CSE-ConnectionGUID: HTdviUYjSaKGMqcLNkmTWg==
X-CSE-MsgGUID: 1d06hyf2Ru6AoQlMI9dI+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66321387"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="66321387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:35:01 -0800
X-CSE-ConnectionGUID: jqfNv3xsQJeaJpeZMGLFAw==
X-CSE-MsgGUID: 0gmIV+uIRGeDaDns+h3u5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115862544"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 04:35:01 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 0/3] E825C timesync dual NAC support
Date: Fri, 21 Feb 2025 13:31:20 +0100
Message-Id: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds full support for timesync operations for E8225C
devices which are configured in so called 2xNAC mode (Network
Acceleration Complex). 2xNAC mode is the mode in which IO die
is housing two complexes and each of them has its own PHY connected
to it. The complex which controls time transmitter is referred as
primary complex.

The series solves known configuration issues in dual config mode:
- side-band queue (SBQ) addressing when configuring the ports on the PHY
  on secondary NAC
- access to timesync config from the second NAC as only one PF in
  primary NAC controls time transmitter clock
Karol Kolacinski (3):
  ice: remove SW side band access workaround for E825
  ice: refactor ice_sbq_msg_dev enum
  ice: enable timesync operation on 2xNAC E825 devices

 drivers/net/ethernet/intel/ice/ice.h         | 60 +++++++++++++-
 drivers/net/ethernet/intel/ice/ice_common.c  |  8 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 49 +++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 82 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |  5 --
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 +--
 drivers/net/ethernet/intel/ice/ice_type.h    |  1 +
 7 files changed, 149 insertions(+), 67 deletions(-)


base-commit: 692375ca2a4e6916ddc2ef0d73faa37c7a93cd1a
-- 
2.39.3


