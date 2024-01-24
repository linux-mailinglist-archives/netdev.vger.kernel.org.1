Return-Path: <netdev+bounces-65640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9C83B3F9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02861C22DA2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1171353E7;
	Wed, 24 Jan 2024 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5A63mPP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE501350DC
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132040; cv=none; b=HzhDM17o+QSie1JKnn0XU5tQbK7H1zRxJEnjqWxZ1F+hzvrH/HRar6HNoR4yKbVGO4WwE3olua9NWQWiXodWuhapFewguYmO7jHnSqjcLCTp7y32XT8RK5rryIBaGXa9wjO7L6JmZrAFDR8qMF+15wjw3RNhc3y+FlyhTTxELtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132040; c=relaxed/simple;
	bh=T8WFi+eefvdlThLpuTaze6aHfWAP2ZG/E8hfjmZUbmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YCbDTmCdE4tTU57i0EpR/erKjXxs/QHO1tFxjQryWZAQ3Iuk0z70PKym/gufiMWvku9W8CBZIvsDnTFX/xDLlZf4BSHjL5UizR4o8JbRWNEdgXdxBFb9qfacysXqC6lkNQEwNR0LkrNvrffPzeIl8GkTz3v928BDfZQYXOT0QUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5A63mPP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706132039; x=1737668039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T8WFi+eefvdlThLpuTaze6aHfWAP2ZG/E8hfjmZUbmg=;
  b=A5A63mPPwhBZJ8rexepeFCb0pKVVkr6mP4mL0Jr7/Tt7ZHjtnBfsgNnt
   yUuwgIRmwaqa08Q9a6xU35Q/qPHjBQbk6lUuw5YYtOB07anBI3KePc/2U
   7dLU7fQXAXZuzQaS5Re7uyp48diU877sJE5heIvxQZlqo0+JC/qzGOGhD
   jMWqLX5T1OFkfyWishAsXdbnM3e9dQre0YrUWoPSTt999TWgJEZwljoCx
   1Z6VUUm4uHJi6f+8FH/0WjnsXHukvxU9bZ0HpaaQvbldNYtBdaiAIeiDe
   QAuYnbT7iwzb+ao9EjaNb4luHRGSEqaUHrFnQK/GaUDVVv3Xc55EEhIat
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8745625"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8745625"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909788261"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909788261"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2024 13:33:55 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.246.2.62])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8CECE9A4A7;
	Wed, 24 Jan 2024 15:21:44 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	horms@kernel.org,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v4 0/2] ice: Support flow director ether type filters
Date: Wed, 24 Jan 2024 16:21:39 +0100
Message-Id: <20240124152141.15077-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v4: added warning explaining that masks other than broadcast and unicast
    are not supported, added check for empty filters
v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits
Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 140 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 217 insertions(+), 47 deletions(-)

-- 
2.34.1


