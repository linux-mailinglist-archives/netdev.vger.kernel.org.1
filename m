Return-Path: <netdev+bounces-201231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFDAE8919
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEF3A275B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5F264A8E;
	Wed, 25 Jun 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtvXiaKM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E81CEAD6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867470; cv=none; b=jc1IN2uIK1FFjPEaeDjJH3ATQXLrfjIe36rfoGC59owlRttqQym0gKa9DAQhQSkzPnkhnwqx9oJzVpm/wu/PJfW5zFHXSLOQTvC/M3/ATXlrfJuonWNtwT9QT8mJbXs9Ot8qg2GRtOk3YxH7+OLcRJBW7QTfQgz54Eb0aEPPyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867470; c=relaxed/simple;
	bh=weY6dY/NG/633bPgu7A3CLaWALB9w4mT2VRQGHXp5lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mDsJGrMCatLL+U3bv0SwL7ZhKHstAt7L5QyOMX/kAjxyefj0xXy2TZDQ5H89VUylAP1Wpcsn9EPW34rOqPKeCP+JmqfDraghNsn4caK16Ae16O6X2suFZgzYSl3UynXDOE27Q9sh7frw45AKxoiRMr2zrq0wfU9KiUfxww4X/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtvXiaKM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750867469; x=1782403469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=weY6dY/NG/633bPgu7A3CLaWALB9w4mT2VRQGHXp5lE=;
  b=LtvXiaKM38wfmTc41XmGQTfqwO4FSbCo/hCHJaNLY3eK5XYoFJieO1/y
   SMGRjax+XnkQvuQbp4nE+vQ1PtNL9GSKNXt7NSxbH4UU3S2XJmNL+waP6
   +b6UeGqhiM8sIDTBCB4JIK3rbPzQ2u3WoMaxuzPzDsT+Zw1Qi45tb3Xuq
   e0Cm0bwKFPboyM23bquzsgBApXGCMcr+NweeyGMERRD1/DMfC3umdO3I4
   eZUvgoxkIfxgw6PCA21t3yZJQMtR4zK6C6G6f4srVMYkpodRcDvrllSqw
   dRWH3rpsI7c5bwOpuC8wHzu54ZrSu2/925htcVHr08fWsJairTV3EFczl
   w==;
X-CSE-ConnectionGUID: 9FvxeMlFSjiXeOWZE9zAgw==
X-CSE-MsgGUID: nQ1ffMudROGFbabc+9QXKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70714932"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70714932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 09:04:28 -0700
X-CSE-ConnectionGUID: VLIuM2LrSU+hHl/6++y4Rw==
X-CSE-MsgGUID: yTZz/bU5QoOCfxv0IDPSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="157752569"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 09:04:28 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>
Subject: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow scheduling buffer ring with buffer pool
Date: Wed, 25 Jun 2025 09:11:51 -0700
Message-Id: <20250625161156.338777-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a stability issue in the flow scheduling Tx send/clean
path that results in a Tx timeout.                                       
                                                                         
The existing guardrails in the Tx path were not sufficient to prevent
the driver from reusing completion tags that were still in flight (held
by the HW).  This collision would cause the driver to erroneously clean
the wrong packet thus leaving the descriptor ring in a bad state.        

The main point of this refactor is replace the flow scheduling buffer
ring with a large pool/array of buffers.  The completion tag then simply
is the index into this array.  The driver tracks the free tags and pulls
the next free one from a refillq.  The cleaning routines simply use the
completion tag from the completion descriptor to index into the array to
quickly find the buffers to clean.                                       

All of the code to support the refactor is added first to ensure traffic
still passes with each patch.  The final patch then removes all of the
obsolete stashing code.

Joshua Hay (5):
  idpf: add support for Tx refillqs in flow scheduling mode
  idpf: improve when to set RE bit logic
  idpf: replace flow scheduling buffer ring with buffer pool
  idpf: stop Tx if there are insufficient buffer resources
  idpf: remove obsolete stashing code

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 626 ++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  76 +--
 3 files changed, 239 insertions(+), 469 deletions(-)

-- 
2.39.2


