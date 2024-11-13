Return-Path: <netdev+bounces-144472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0F9C7939
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED59B2E733
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF8670833;
	Wed, 13 Nov 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+bekai5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA070808
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512896; cv=none; b=kh3MSjJCEyqtsy0lbGAOQbB880Q4ab4VM+XGpNGtGoy54o3Dn2KTmi2/Jvgd/AOajTuzk4oTJhvKPVqQQa9MvoK1yi8NIFWXCW1yL/B4KJDqCEEFE/hquejQuXWxqSZRVBiYcH2B7FtsLVX4McLO+8KJ8asvi1E791uWz4pH1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512896; c=relaxed/simple;
	bh=qHG84sX6f3ufA/50flHWraVatdJwVZN4tNgkvWeT4mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IoJRiqKGHQLNpVCcnDB3KEMS6WIOyuvxzF1R94FU0UCsLI2u5zQkJQ6629/4QnF25+UiJZU5RDb88651LAtDJBodkHmz3SBXRGGXNVLDUFpO2KkzIGwRdvgNOJn1NT11EYi/Padhb8wq1iEdVaozhNCZ0AlZ+Md46R1PY/522jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+bekai5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731512894; x=1763048894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qHG84sX6f3ufA/50flHWraVatdJwVZN4tNgkvWeT4mo=;
  b=i+bekai5i/Ii+3RIV//tlH+VX30h3J0dwByZ8iulFKaC1yWgVBYI6OaE
   p7atGkimMqp4NIyZynW9F9C50N9LLJwMWasPem2AWvgmD/opDy+Ot9y4A
   WlcVKmgxNJ0yqV3wG2GeHq12UWkwBWJiH+RUcrez+8IUtYVeqvCQQp99f
   +/56vhXYPNmbf6Q2AMBys0Zj2jrlZGm3jcri6HNZCs1cAHNCm7E6hUHR4
   vBTjlAsyMrjKwZv3GQRTqNXQVJRnEn2O2pKn+bYIdN8qWNCH0IhkKwzzX
   Ytyhmbr5HQgO5OChZDj75R3E1W+zj6ZXzI07hcwHadnQleNyHg6tETFXZ
   w==;
X-CSE-ConnectionGUID: Z6Mq0CUOTDqhMtaIsdRCVg==
X-CSE-MsgGUID: oYVyUf1VRlycGNw2t+3Xbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="48918964"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="48918964"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:48:13 -0800
X-CSE-ConnectionGUID: Xg9wFP+qSO27UZWkqjkqIA==
X-CSE-MsgGUID: 0+ovJoaTRQuBKy5FeAZQGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92869217"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2024 07:48:12 -0800
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net 00/10] initial PTP support
Date: Wed, 13 Nov 2024 16:46:07 +0100
Message-Id: <20241113154616.2493297-1-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Precision Time Protocol (PTP) to
Intel(R) Infrastructure Data Path Function (IDPF) driver. PTP feature is
supported when the PTP capability is negotiated with the Control
Plane (CP). IDPF creates a PTP clock and sets a set of supported
functions.

During the PTP initialization, IDPF requests a set of PTP capabilities
and receives a writeback from the CP with the set of supported options.
These options are:
- get time of the PTP clock
- get cross timestamp
- set the time of the PTP clock
- adjust the PTP clock
- Tx timestamping

Each feature is considered to have direct access, where the operations
on PCIe BAR registers are allowed, or the mailbox access, where the
virtchnl messages are used to perform any PTP action. Mailbox access
means that PTP requests are sent to the CP through dedicated secondary
mailbox and the CP reads/writes/modifies desired resource - PTP Clock
or Tx timestamp registers.

Tx timestamp capabilities are negotiated only for vports that have
UPLINK_VPORT flag set by the CP. Capabilities provide information about
the number of available Tx timestamp latches, their indexes and size of
the Tx timestamp value. IDPF requests Tx timestamp by setting the
TSYN bit and the requested timestamp index in the context descriptor for
the PTP packets. When the completion tag for that packet is received,
IDPF schedules a worker to read the Tx timestamp value.

Current implementation of the IDPF driver does not allow to get stable
Tx timestamping, when more than 1 request per 1 second is sent to the
driver. Debug is in progress, however PTP feature seems to be affected by
the IDPF transmit flow, as the Tx timestamping relies on the completion
tag.

Milena Olech (10):
  idpf: initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilies and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping
  idpf: change the method for mailbox workqueue allocation

 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   18 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |    3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   63 ++
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |    4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   40 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 1006 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  352 ++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  166 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   17 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  674 +++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  312 ++++-
 18 files changed, 2839 insertions(+), 99 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: 6d0dbb3dae5273e8efd6fd25deb00404ff5a8f38
-- 
2.31.1


