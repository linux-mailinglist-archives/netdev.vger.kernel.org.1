Return-Path: <netdev+bounces-184227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD2A93F11
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EDF463323
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95C22FE11;
	Fri, 18 Apr 2025 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FURvRqI5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06F22FE06
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009378; cv=none; b=bAOoMjaDrkdLyr76I+0a4pG40Z/5HQDcVuA2kofQg5y4kJKEJb+FnhfBQENN/MNATJeVQX4DOIrSAhlPAM7fqWCIw3uCPovlB/qTO5CMqrQp+Aec+39v54nyaWiOGs+NhAphrNXw4Xp0/tmg5igZqfaAUWFa7xCbpJU49WgbupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009378; c=relaxed/simple;
	bh=IDzzMkCRqeGxwdtmvnl5UHZ+UZVLH8I/hbqwbN+PgD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdSj/4QkpIzBkWUpZWsAn6pfDWazXSlVBObkUKtoZt6SSHsMYUFPBx/ISzypmjp+FMZ6uVNoBTt2hIrvzjcNlQUj0IUuZfv5gcMS0XZwuehygmZ6DPtIlK3T3m4DZsXZiYluAvbgMKuaU+DnSp6Bl7wH+GzbEzd/Uv3lAxHyujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FURvRqI5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745009377; x=1776545377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IDzzMkCRqeGxwdtmvnl5UHZ+UZVLH8I/hbqwbN+PgD4=;
  b=FURvRqI5wuNk+2X4B56RKFE9d1DI6EN4Y6guZSTd3czzqaf0NnhcqGG3
   /rDhCsUC6bq/QDDBULYLWcH9UoArDtpIgPTLVgdCCLepbUWGAc1pNeNUs
   A1kozWi6+3dn6NesvmJW3Tx5EX2u9jl48jPhn8IRres6QKrewEtp+Sea0
   sfjDH6PKHWm/wKPP4BGQFkiJABCWPbs9B7p8lJT6hGrcTFQQlzKjSQciL
   muNwk+b4WQHqkWXWvixFPtzkPn45Tb2bn4vIrFHMQIu8JcOAdVwFxww0K
   /aFU+1Axt4QpQnzX/0uInytcACeq2RMsR6srz/62dEG2OokQQlmP2plon
   Q==;
X-CSE-ConnectionGUID: /rARSEBMTOi/TU9m7JVdhQ==
X-CSE-MsgGUID: 2M18sMl6TfS1iQJJRlwKlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46814308"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46814308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 13:49:36 -0700
X-CSE-ConnectionGUID: zfit/8QUSgOVlaGzgzduIw==
X-CSE-MsgGUID: SLDRv+XiSZyKBCo0lFNPJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="168406301"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by orviesa001.jf.intel.com with ESMTP; 18 Apr 2025 13:49:36 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v2 0/9] refactor IDPF resource access
Date: Fri, 18 Apr 2025 13:49:10 -0700
Message-ID: <20250418204919.5875-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue and vector resources for a given vport, are stored in the
idpf_vport structure. At the time of configuration, these
resources are accessed using vport pointer. Meaning, all the
config path functions are tied to the default queue and vector
resources of the vport.

There are use cases which can make use of config path functions
to configure queue and vector resources that are not tied to any
vport. One such use case is PTP secondary mailbox creation
(it would be in a followup series). To configure queue and interrupt
resources for such cases, we can make use of the existing config
infrastructure by passing the necessary queue and vector resources info.

To achieve this, group the existing queue and vector resources into
default resource group and refactor the code to pass the resource
pointer to the config path functions.

This series also includes patches which generalizes the send virtchnl
message APIs and mailbox API that are necessary for the implementation
of PTP secondary mailbox.

---
v2:
* rebase on top of PTP patch series

Pavan Kumar Linga (9):
  idpf: introduce local idpf structure to store virtchnl queue chunks
  idpf: use existing queue chunk info instead of preparing it
  idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
  idpf: move queue resources to idpf_q_vec_rsrc structure
  idpf: reshuffle idpf_vport struct members to avoid holes
  idpf: add rss_data field to RSS function parameters
  idpf: generalize send virtchnl message API
  idpf: avoid calling get_rx_ptypes for each vport
  idpf: generalize mailbox API

 drivers/net/ethernet/intel/idpf/idpf.h        |  152 ++-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   12 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   87 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  233 ++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  639 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   36 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   15 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1130 ++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   77 +-
 10 files changed, 1250 insertions(+), 1148 deletions(-)

-- 
2.43.0


