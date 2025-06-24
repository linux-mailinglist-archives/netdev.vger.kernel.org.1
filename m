Return-Path: <netdev+bounces-200688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC3AE68CD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2101C21685
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69827FB31;
	Tue, 24 Jun 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cchfnIz4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136E13AA20
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775253; cv=none; b=IH5GUJ25nGzvtrxFFiPJuChQiYhPQ3ohx1QNzMJDAxdPu9PUepqzc6k8+auA2KnmItXr+9fE/Z/AJiHJ4zdvo9c4oKIyyJxW7jQD2sGaeS3QjkorBkQvTzB0o5oLTI2hiC9vWQNsVOj2VEBW3J5BYkPtEqbkc/X7X161fZYa0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775253; c=relaxed/simple;
	bh=UN6drHPpNfDnzyi8urlE+B6aTww0NvsBDxJi71GKjGM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZWCGBGig3FY9cQrfE5JivRZwO71TEykmsE7nKkid/Q7Tv6aTnSAjxZ0+nIpgPzNsegpWPLcDU+rnTRm4teV978Od190g9ZPU195AqiD5PPEFlvECqXm3CZx9nBIdNqj9MsR1UZeO2Y9Dvqc/UKVf3ZG5lrFw77+0pcYuvHb7or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cchfnIz4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750775252; x=1782311252;
  h=from:to:cc:subject:date:message-id;
  bh=UN6drHPpNfDnzyi8urlE+B6aTww0NvsBDxJi71GKjGM=;
  b=cchfnIz4+S/4x50rv7siSXkHvhOorK7X3nVZQgGQEVjwI+6e/UcSAoe6
   ORmNlti9bk/sSSjzPE9Va94+2jRRgEl3lmxk9K2Fom9nXaq83E+IhUZ4t
   nATibAbs8qOerUQZxhV2Kk3Yem051xtDpWhTvFmZmxc4UBqYX+ahqdlC5
   pL12SpaubQKJhXF6YDYQfB9kfQvb46rOrCr2nPPpaky1HORsXMTyyhFBL
   KgUY/093zTjR0jYalJXoAkPib5wIYpmG8v/C9COonOcDOX2+qTxi32r/T
   avR+6xXUcycvaoBW9k3sg1MrM3NzoWpWnlc096eVDlOAsX0jyudF9ib1W
   w==;
X-CSE-ConnectionGUID: xyiUeF5uT8qiEWYf94SFZQ==
X-CSE-MsgGUID: 5WRbCHmkQ3Gxdd9+niu1eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70441028"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="70441028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:27:31 -0700
X-CSE-ConnectionGUID: 5YQPK2EwTRCvcU+EE35vIA==
X-CSE-MsgGUID: QwjWxWECSnSr30T5B7CUcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="155965564"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2025 07:27:31 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	david.m.ertman@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-net 0/2] ice: Fix NULL pointer dereference and leak in IDC
Date: Tue, 24 Jun 2025 07:26:39 -0700
Message-Id: <20250624142641.7010-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Resolve NULL pointer dereference on driver load when RDMA is not supported.
During reset the driver attempts to remove an auxiliary device that does
not exist. In addition, fix a memory leak in ice_plug_aux_dev() error path.

Emil Tantilov (2):
  ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
  ice: fix possible leak in ice_plug_aux_dev() error path

 drivers/net/ethernet/intel/ice/ice.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c | 29 ++++++++++++++----------
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.37.3


