Return-Path: <netdev+bounces-105254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09832910440
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756A7B22631
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AA1AD3E7;
	Thu, 20 Jun 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7GTITrW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F51ACE64
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886720; cv=none; b=llzRDDDnFicVkUboh7YgpUD6U9Cmd1Oz+fnZr9cAM3GDym7+uqmPNVxbwT61i1FAXpnkpWpnl7epEkslTj+rXZtrvtao6e1kZTMICEJf9PEbwvVAjhHqXwS9Geg30bnVY5CyyxlcsfCEqmpj5DG5Wv3bpD/AAAy1UJWn7APm50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886720; c=relaxed/simple;
	bh=CjX02a42qzAYbrtxKmG4UYbxovrRtFRFcsvg/03UgSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1+q1lS+YYHpI5gSPY0xpjAK1/rHntHYjCYZkL8ltQ3itE0cxYWKjaLlyElG1JxyRqIo5wsX6q8CDsJpfYZlzjM1IqR/EEopmqXf9jToo1SmJsl/lqexiCTqWbx5e5WXcdk23BSmI/hJ22rj+uEVWD+5NlMSQy8U2uttkYPrOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7GTITrW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718886718; x=1750422718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CjX02a42qzAYbrtxKmG4UYbxovrRtFRFcsvg/03UgSo=;
  b=E7GTITrWB+9KhVOGa3DVfZndKn7mRmb9JQryCJqADeZh0cze0yFwMvkX
   zR5SrFtixBR6/bUr5wwWIXhj1WFJEYBhP9yuP5zzJ8T3E1jhdv4xeQDYd
   Q6hxunuWY6uqL1HYCGGiKHy3pRtlBtfdGAQm+zXkjR86NdzYlAN+o6miA
   lQ11JhyvMWB3nlNfNK6kekuZ5T8S552USpkrNuYmfi1W3gajik4ffweB2
   spjdcqwtew8b1XvnYjGYGbAw/5D1rzeMFy9RW/i6Ho1MQiax7pBVkHRa+
   Al1ypS/kOSQl1VyQrKZJ/JrxkYiJYLL3XGSPjJOl+uzZadBVjYbjwWvOQ
   w==;
X-CSE-ConnectionGUID: rJbStYMsT+6QSavM0gFwHw==
X-CSE-MsgGUID: qB0e/obCQeOMjTnlmFN9hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41262880"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="41262880"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 05:31:57 -0700
X-CSE-ConnectionGUID: OjPo6sKYTqq6EcAx9D03iQ==
X-CSE-MsgGUID: u8QhCwbjS+GUWpaGLsl/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="79712939"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 20 Jun 2024 05:31:56 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-net 0/3] ice: Fix incorrect input/output pin behavior
Date: Thu, 20 Jun 2024 14:27:07 +0200
Message-ID: <20240620123141.1582255-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes incorrect external timestamps handling, which
may result in kernel crashes or not requested extts/perout behavior.

Jacob Keller (2):
  ice: Don't process extts if PTP is disabled
  ice: Reject pin requests with unsupported flags

Milena Olech (1):
  ice: Fix improper extts handling

 drivers/net/ethernet/intel/ice/ice_ptp.c | 132 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h |   9 ++
 2 files changed, 111 insertions(+), 30 deletions(-)

V1 -> V2: Fixed typos and other formatting issues in all patches

base-commit: 0a8975e20f25bb2f5edb28d883dc715802231e71
-- 
2.43.0


