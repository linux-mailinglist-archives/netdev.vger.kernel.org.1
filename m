Return-Path: <netdev+bounces-104558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E3190D525
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA801F224FE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785577F2D;
	Tue, 18 Jun 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFeoMkA/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642113CFA5
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719809; cv=none; b=tkQrSbiTVQIA6d6VFxC1BGvNyK23KuMOpPezqHmovUO3HCp5hY6GG8WwoNhUqpJMgf1sLBIn0PHP91g/nplm9KiIyRhrgYGmHecJsWuouTjDj0DEZ1Wmj+axV7JD+KjhlHSNcadMcOgBushHj9e4GM4xG7/enoZJuEQjTqBSFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719809; c=relaxed/simple;
	bh=jLZJ2E9FwdOd97vcEvkFHZd14MghabEtObOBy/yz4nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+It1aN72t989DPtH8pHyQJiL5BqVZNkbiMDykEQ9F3sZGLwXs5Og09lEfJeMXe4uwURE1j07d134UW0Ew8tMTMW0y0ZTzCmfk6+bGreNNZioXjdcsMDaGF1M+5hvuD9yLp7g/dcHNiXNu9YPXnXK+m0Jj3IpKEijqaEmfNNvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFeoMkA/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718719807; x=1750255807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jLZJ2E9FwdOd97vcEvkFHZd14MghabEtObOBy/yz4nQ=;
  b=RFeoMkA/Md4jjit1hKLK5ghzjE6vz8Z9Lzb+RwY3oC0PgOw+WqJkCuDb
   8t8AVLsCu1e9RRp2zWcmr9yZV9SQS+/RL1ZWGW2W4jCYrMQtyJ8/t2WMS
   7Icn3vmH4Zch4yIuyPqMfp4V59V5EvK9h1hKXIClX9rjdKaKic/me0Abp
   mAZKEuSlW66TlNf9H1D4Kvar1wFDAk0D//O7jUttXnyYmnRHd8ESeDutk
   9Vbmxl2aPqta+HzooQ9wj5/UECd+7OjLxZ4oayR3tLUT7GJyO1JGZcR+Q
   MS1u9YSAdZr1X80nj2eLGSptyFF2nXMo+gi5nQ5/ERiKk+i//TIfKhf3D
   A==;
X-CSE-ConnectionGUID: Fh6jCDuESdqtEYokY+9CVg==
X-CSE-MsgGUID: aXqCdjQLTQGpLtjKRfDWNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33137751"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33137751"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:10:05 -0700
X-CSE-ConnectionGUID: UDnd+3IzTE2sWQnLZBi3IQ==
X-CSE-MsgGUID: 1bdIKR+9TyqBc0TtWrxkmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46109775"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 07:10:04 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 360EC34300;
	Tue, 18 Jun 2024 15:10:02 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 0/6] Switch API optimizations
Date: Tue, 18 Jun 2024 16:11:51 +0200
Message-ID: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the process of creating a recipe in the switch block by removing
duplicate switch ID words and changing how result indexes are fitted into
recipes. In many cases this can decrease the number of recipes required to
add a certain set of rules, potentially allowing a more varied set of rules
to be created. Total rule count will also increase, since less words will
be left unused/wasted. There are only 64 rules available in total, so every
one counts.

After this modification, many fields and some structs became unused or were
simplified, resulting in overall simpler implementation.

Marcin Szycik (3):
  ice: Remove unused struct ice_prot_lkup_ext members
  ice: Optimize switch recipe creation
  ice: Remove unused members from switch API

Michal Swiatkowski (3):
  ice: Remove reading all recipes before adding a new one
  ice: Simplify bitmap setting in adding recipe
  ice: remove unused recipe bookkeeping data

 drivers/net/ethernet/intel/ice/ice_common.c   |   8 -
 .../ethernet/intel/ice/ice_protocol_type.h    |  43 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 652 ++++++------------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  20 +-
 4 files changed, 229 insertions(+), 494 deletions(-)

-- 
2.45.0


