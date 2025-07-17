Return-Path: <netdev+bounces-207897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2460BB08F72
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79B9586200
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3572F85C5;
	Thu, 17 Jul 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crnc1beT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8552F7CF3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762543; cv=none; b=SLf9XLhvPkKSTnSVKWWJFv3CZp5kEzVY2pOxx2TpVUoW+iKra7jMLKR6Xz/Ll4i6pfTnNu/G2Aj4lSRc0egZZIY0Ul2/ivwaYHzGQ27yTTcxChJuvlD1//dNWkWIe+FK5Sqcom23gISlDitFT/Ap6Se25zsrR2r4Q+M0oaLWJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762543; c=relaxed/simple;
	bh=OZrbCw4JKifkcZHybBIYwGcHjI3XAO5d4AY32WvodMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfVHdpcbhcZNHBI5uo6C9KZRaMAbUG05wDH6tpt8SNCZR4qQALzgpyY3joXoCKRDPBjczof+bQ5TxxEVCtJy3/XZZ7PiExxJbupGerYIuqc8k6VAdcI7m0jdmEm003znYtFZcKsLu8WwlHYaONiopXlckmUsS6CJ9Kn3d6TTwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crnc1beT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752762541; x=1784298541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OZrbCw4JKifkcZHybBIYwGcHjI3XAO5d4AY32WvodMs=;
  b=crnc1beTkx+jywv7ziIqgWUbyTsPZMVskXaDSbPQHuRThOgqd25fhpqg
   wQiPX4SS4GUrK1YU5ENmPTOWkwcq7phf46cfEXrXXefdG1OTt6ZuDsZgs
   +CM16hoBurWlSjgjr4aFsJhrAdJQPf2LbfbIk9j0w+Wg2hR9rex3AGt39
   eN8NFN+PIteLugZFwyHaMvnNwHj1Wg/+zFRcDLB57u0cjto4sn9AC0lhq
   5d527duU9mXfixjBXXKPXPht0ZZLdsftqLVVo7VY1vYl4l8yqHwHcTH5F
   EluvYZqQrxq56kT2JHV7lNH12QvVKvOSbeLzouo3IIacQQiAx0r9xXkNS
   Q==;
X-CSE-ConnectionGUID: 22Ma+JjBQvGpfsRDf/cpvA==
X-CSE-MsgGUID: oNgHlGhhROuMrktRcdcR+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66488603"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="66488603"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:29:01 -0700
X-CSE-ConnectionGUID: QXFWvb6CS8SPGac8f4EZVA==
X-CSE-MsgGUID: 0I06mQCURju15jc0O4nzHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157880613"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 17 Jul 2025 07:29:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: aleksandr.loktionov@intel.com,
	netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-next v1 00/17] iavf and ice: GTP RSS support and flow enhancements
Date: Thu, 17 Jul 2025 14:28:42 +0000
Message-ID: <20250717142859.3346899-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Receive Side Scaling (RSS)
configuration of GTP (GPRS Tunneling Protocol) flows via the ethtool
interface on virtual function (VF) interfaces in the iavf driver.

The implementation enables fine-grained traffic distribution for
GTP-based mobile workloads, including GTPC and GTPU encapsulations, by
extending the advanced RSS infrastructure. This is particularly beneficial
for virtualized network functions (VNFs) and user plane functions (UPFs)
in 5G and LTE deployments.

Key features:
- Adds new RSS flow segment headers and hash field definitions for GTP
  protocols.
- Enhances ethtool parsing logic to support GTP-specific flow types.
- Updates the virtchnl interface to propagate GTP RSS configuration to PF.
- Extends the ICE driver to support GTP RSS configuration for VFs.

Patch breakdown:
  01: Add GTP RSS support in iavf driver
  02..17: Extend ICE driver and protocol definitions to support GTP RSS for VFs

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

