Return-Path: <netdev+bounces-112933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6B93BF36
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DE281854
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A4197A9B;
	Thu, 25 Jul 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZoMZvHo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AC16DED1
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900396; cv=none; b=ln/vyTB09GMrf84pOR1Do+VwpgVUwpua8Q+ZjsohWMdY9Ho/+TJxhaZRm0PMReAFNn37KCOGKivMjD2ykIO1wdt9BPOj+AYZ8wixb6wiQvgPoPLYgU5YlCE5XhCpnlznnYhDxj4iDCtzzQCWDrgwdtDOBfABQsysKDZZC2lUPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900396; c=relaxed/simple;
	bh=KapfvudN6qowP+CmN1qoLY2G78wBaetCRp+8Y2atz6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEgJlpj6BXlVaClxM17Nb+7DUz9NBEtLwsjyh4z8VnRj2Uy2UBAjDS5LhSM6S+VsxtbuJ/QhKPs0UzcSczj5Ab0sdk721pXq1Lb8YlpnP5q9ClfP6d9iZPPoAzG9lxKoJV1CTQsxFwBiv8d1h1nUhDD1eZPKfNL5ucoUyQI8rDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZoMZvHo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721900394; x=1753436394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KapfvudN6qowP+CmN1qoLY2G78wBaetCRp+8Y2atz6M=;
  b=PZoMZvHon5MS3JBvk6vuJCQueLC6kzKK1kreQShQUzS7z65FuldIYY9Q
   JXVzMQyIN6lJjcPJT24DPqdFIyCi/64EAh1fMSvuE/9Fb2EYdOPhFuOhR
   LY4I1uTWNSVUJbji54if4W6DEepRrYuWR3y0+V3/dsUf9m2b4cQba0v13
   cODdYdbtotj4S9Qu/mxELkaFuwqdAfC+JbkB0eIEUaWD+qOgH2FRweVeh
   UI2w2ZKeG3X57OwYb1HThv5nxTsTjKAvIjaHW2iNw062HgybjGl8ZwBuC
   Ew5mZXZ/4iPqc9lO7ZQptESHmIXEKqDawVQ5YBfYd8BsQfvMAcHaYnOCY
   A==;
X-CSE-ConnectionGUID: ia3f1yJ3QN++DzsU+GZ9cg==
X-CSE-MsgGUID: ZOz3+DHqTMKVyiWTLSxLzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="12707089"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="12707089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 02:39:53 -0700
X-CSE-ConnectionGUID: R9eXoyA9Q7CTKXbDutv56Q==
X-CSE-MsgGUID: Oe1qJPIkTOyAYJk4Gs5pWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="57170843"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jul 2024 02:39:48 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 0/4] ice: Implement PTP support for E830 devices
Date: Thu, 25 Jul 2024 11:34:47 +0200
Message-ID: <20240725093932.54856-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add specific functions and definitions for E830 devices to enable
PTP support.
Refactor processing of timestamping interrupt and cross timestamp
to avoid code redundancy.

Jacob Keller (1):
  ice: combine cross timestamp functions for E82x and E830

Karol Kolacinski (2):
  ice: Process TSYN IRQ in a separate function
  ice: Add timestamp ready bitmap for E830 products

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  13 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 356 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 199 +++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 11 files changed, 497 insertions(+), 157 deletions(-)

V2 -> V3: Rebased and fixed kdoc in "ice: Implement PTP support for
          E830 devices"
V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
          E830 devices"

base-commit: 0942d0846f6305b3ac645a7294470df8fe6c3dd0
-- 
2.45.2


