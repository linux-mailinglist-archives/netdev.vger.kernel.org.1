Return-Path: <netdev+bounces-191814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C1ABD65B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68777B2E1D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8E27CCEE;
	Tue, 20 May 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJan+FdM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EF2857C0
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739316; cv=none; b=LtF/crzO7nQcVFZKFy4c89IoNtgvKus4EH0jllltol32adWY5p7lPceyDHpVj+PKZwoS8v+OyKmSsDltQ6Q9tjbTk4KnhWhVA4IPnGqiJXo2itAZ6H8ocWGEhicxI+mUS2oGIJvwKL9ywVbhuq94Y4s1nSzgpYUoO7rRC2GFeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739316; c=relaxed/simple;
	bh=9VqCyJhQQwff319kyxXfCBphCq6+lUfEFzq7CPaGFcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoWeaN8wdqGQHizCwmc8aFvvmYMnxeL1wJKMqC4Rcig30L94cMzHJRx0k1KrBwdLXamQPp7xJx04fhJcKivnBK16AhJdltGvPnG6jfI93BXzK+mnUdoIxBZifBVYngTErcvz26PCUipcktqAp58Bye8ynMJtge03T8gl/pcEJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJan+FdM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747739315; x=1779275315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9VqCyJhQQwff319kyxXfCBphCq6+lUfEFzq7CPaGFcI=;
  b=HJan+FdMraSLsieVhHCk5bv9/AXxeuFBfCrmUhlpmVe62TBYmHYWebh2
   z378CeJSDxJ97y4mQSIxy+YahFlFHNAHfIY/dqtG7oYqxspPyC+uow0Q5
   Pc2kknnZFHiRZJZ64kZxFURY8Bq4n6XMiYfdo2B279tEFuF17udCHO4Z5
   GTM2AjeoqhMIu4OAugyrvqupYGHlm//MyVEJM5LZpGr5oqMubULtnk5Eh
   W5+HMFuv18NfRjrhA0rJX5W1ZSd1FtUQw68uI5xkRZvHIDeRnpW3O82No
   NMQ7+PZ+cin4QPTjBM6V/ZF4BYntjlhL5xuYVHQuT91v7KMD4Q8E2izi+
   A==;
X-CSE-ConnectionGUID: cCRJSaWsQuCeFBfg34rWCA==
X-CSE-MsgGUID: ZZSBPPqoRGGn6ntfd6FL5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="75069253"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75069253"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:08:34 -0700
X-CSE-ConnectionGUID: WVHCpj7ASOa8fet55TEsNg==
X-CSE-MsgGUID: dm57KL7lQtGc4IcJ8P+Jhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140172934"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by orviesa007.jf.intel.com with ESMTP; 20 May 2025 04:08:32 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 0/4] ice: Read Tx timestamps in the IRQ top half
Date: Tue, 20 May 2025 13:06:25 +0200
Message-ID: <20250520110823.1937981-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all E82X products (E822, E823 and E825), Tx timestamps are read using
sideband queue.
This is a very robust HW queue and it's used only for accessing PHYs and
CGU, which means it can use spin_locks and delays instead of mutexes and
sleeps like slow admin queue handled by the FW.

This allows reading the sideband queue in the top half of the interrupt
and allows to avoid bottom half scheduling delays, which speeds up Tx
timestamping process significantly.

Introduce new structure ice_sq_ops, which allows to assign lock/unlock
operations based on the queue type on queue init.

Karol Kolacinski (4):
  ice: skip completion for sideband queue writes
  ice: refactor ice_sq_send_cmd and ice_shutdown_sq
  ice: use spin_lock for sideband queue send queue
  ice: read Tx timestamps in the IRQ top half

 drivers/net/ethernet/intel/ice/ice_common.c   |  21 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c | 252 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_controlq.h |  20 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  46 ++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  62 +++--
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 7 files changed, 251 insertions(+), 158 deletions(-)


base-commit: 82bb0098b73f72a026b4bb49206a8c1d90974edc
-- 
2.49.0


