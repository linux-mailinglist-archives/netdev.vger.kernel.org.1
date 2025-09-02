Return-Path: <netdev+bounces-219057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF2B3F978
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AA42C21F4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF2A2E9733;
	Tue,  2 Sep 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dypgPSQj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324A4409
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803686; cv=none; b=ob0gNtZP+v7eS0xiyAzOXYZ3jiGpzQ2yY+ZGlvCKyIIfxWw1ZPBjXLKNpEXv6jNWTlWgP9BqlzH2uhjzhk009Icao01eVydYF/7u7j999ghpGAn5DceEYQ2oaekwXzz1oH9j7dpn9tSFg4Xbhp3AAh6r+HIWTNSn1nfowNCHCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803686; c=relaxed/simple;
	bh=2TpnP1AXNCPV0dg1xc5N/Ez8GtG6w45MaCkHZBvSIg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqIxmgbZymVMZa4HwPa3u3X22X9w8FraAs4cl8/KnG9mcA/W4soGohbcmaUHImuYDLyRNDjIjG8be3uTyYoA43Viyg6mpPzqpRqtwe1WQmOeLcfS80vKZaRFrwKrpQo0cHenXtIdY6xrw+/O1jTxMIX3jvhvIxlDMkaSehBVuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dypgPSQj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756803684; x=1788339684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2TpnP1AXNCPV0dg1xc5N/Ez8GtG6w45MaCkHZBvSIg4=;
  b=dypgPSQjdFyw+Q9MI3qPy3umJuJ6e+mZhL1Dbmn01MIa/P225/qkg47Q
   i7KyhCSaJWqopc/UNgBTmwkfagbLk90oCIc+FuNJvrnT1xmJ4cjj9YSk1
   Nc2p0A79QcLuh6oLB3xaWpfL1SVtgYVQ1Hycv3Bk+3YO2mRoroMe3/XfU
   zs6QdDVLlhDJoi4O6UBHZ/xhe9Ckl7dnwy9hd09+mo6hGuTObPPFeiV/h
   l3qGqpX8o0ZiVwFbN4JOjtcPpWC4oA/z0amK3PzjonUfEqCLxNH1PHH8b
   ehIPpNn7Ucx2fhh/X/8GMN6m24uB0N0CofGg+6j4JhZcHChC4vW8uQWHT
   w==;
X-CSE-ConnectionGUID: PldiitJMTLiKYA1pY3FomQ==
X-CSE-MsgGUID: rtdo37+rSQeieNL2gvn61A==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76666690"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="76666690"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 02:01:20 -0700
X-CSE-ConnectionGUID: NMHMv1t8Tquknduml+jNZA==
X-CSE-MsgGUID: LEAmQg/iTN2U6OzvcLu+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176494110"
Received: from host59.igk.intel.com ([10.123.220.59])
  by fmviesa004.fm.intel.com with ESMTP; 02 Sep 2025 02:01:18 -0700
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next 0/2] idpf: add direct access for PHC control
Date: Tue,  2 Sep 2025 06:50:22 -0400
Message-ID: <20250902105321.5750-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IDPF allows to access the clock through virtchnl messages, or directly,
through PCI BAR registers. Registers offsets are negotiated with the
Control Plane during driver initialization process.
This series add support for direct operations to modify the clock as 
well as to read TX timestamp

Milena Olech (2):
  idpf: add direct access to discipline the main timer
  idpf: add direct method for disciplining Tx timestamping

 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 295 +++++++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 103 ++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  85 +++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   4 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   3 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 139 ++++-----
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |   6 +-
 8 files changed, 451 insertions(+), 188 deletions(-)


base-commit: 1235d14de922bc4367c24553bc6b278d56dc3433
-- 
2.42.0


