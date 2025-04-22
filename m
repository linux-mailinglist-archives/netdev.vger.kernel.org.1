Return-Path: <netdev+bounces-184770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C88A971EF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C19D7A477C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A028E608;
	Tue, 22 Apr 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBlAHGFx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32655179BD
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338061; cv=none; b=NcchvWZr+zhTEMYGqs2GN8M4SGiTjALV0/QRuaZW9jjwpTXhSooozvdKMWT95YAdfRVEDO3fCxbyjPH0JSofrIZM7ne9fEFNy6S3T3T1NfTDiZLTZTqzEPC0XhIeUar05O1qsPvpf6eFTRM98nGl8nFTP4LSFFdNdvSaECpdC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338061; c=relaxed/simple;
	bh=OotV9A4plTUiuTA8hgl+oKxod/ytATJED4aRe2n1lyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTVYx8opX+wd8YDrnEan/biIsQDHaw7HZ8tfT/r9Urw+UpZTVlpynhFviYQ/zIdN9lWN+heiIJAln41f4TSriuDoqDYxAVWNDS0ETMis54EFZMBXsh6ofstBpNb9l2n2twFi/wvp0TRTlQ2B3eGKztgFUhrLi6Q3fEVbfkt9bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBlAHGFx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745338061; x=1776874061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OotV9A4plTUiuTA8hgl+oKxod/ytATJED4aRe2n1lyU=;
  b=hBlAHGFx+pOzaQzHHDA/rXRlpHzEv+KwuPvdEkqII2rMR92SWug1lucC
   gfDz1qAINz9Jo9IS7n1lqKTCJ3isvHV2zCcwI8YieLQnPQqsbeyZFIrU3
   L2RFTw0zrcWqQD6IBbOB/1A1gbqH1+fkG7IPalAqf0GL7tG1/ssCm1DHn
   J0FfZSAFXWrjv1lRxaYUKxyvnU28rGUMPVFITIqJPakBFYwSiuFeooPl9
   EzLbjV7iholy/L1V8664aHMBI93Aqh/JHhzGMqvKQdqUVu9nHtXfFasWW
   Qv2QsEE8sgb5ECcoXTpICc5k4QDPqe5i1tJtYZRbEgvngIZ1yYvkISWiA
   Q==;
X-CSE-ConnectionGUID: akpf0iWVR0W8jTiYRryIag==
X-CSE-MsgGUID: gQKORipkSIS4iOMTXl4pew==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50709019"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="50709019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:07:40 -0700
X-CSE-ConnectionGUID: Z61mPEJGSYy+jPKYNkE3Tw==
X-CSE-MsgGUID: 4lF+pHrqT/aMWATg1Pe27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132592449"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa007.jf.intel.com with ESMTP; 22 Apr 2025 09:07:39 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v5 0/3] ice: decouple control of SMA/U.FL/SDP pins
Date: Tue, 22 Apr 2025 18:01:46 +0200
Message-Id: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously control of the dpll SMA/U.FL pins was partially done through
ptp API, decouple pins control from both interfaces (dpll and ptp).
Allow the SMA/U.FL pins control over a dpll subsystem, and leave ptp
related SDP pins control over a ptp subsystem.

Arkadiusz Kubalewski (1):
  ice: redesign dpll sma/u.fl pins control

Karol Kolacinski (2):
  ice: change SMA pins to SDP in PTP API
  ice: add ice driver PTP pin documentation

 .../device_drivers/ethernet/intel/ice.rst     |  13 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 927 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 254 +----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 6 files changed, 988 insertions(+), 233 deletions(-)


base-commit: f1b79f06407e20f12be7b5cd4aed493b2ec1b6ad
-- 
2.38.1


