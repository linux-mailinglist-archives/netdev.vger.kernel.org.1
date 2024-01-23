Return-Path: <netdev+bounces-65269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C7839D45
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 00:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571B51C24C22
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5653E19;
	Tue, 23 Jan 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSaQ1/D4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D23B78E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052724; cv=none; b=nnGEsgM8u3iChjjTtWCLCqoYa21rDc9o1vugr6LRGBKYswoUWhjuM+NUvNQpzHx6t6ZyVxsNgSezmFUSEandG1NjZEakFmksYPRGVGxCYYnySYdpKQHLcc6VFa+RnpyS5CiPQrUGb4mdSsNIMOT5DS1PdnSo5tDGQUNWaK6JsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052724; c=relaxed/simple;
	bh=0XmyUjs6d6Sl0NxYVW+fP7dKeguSeFwbe/GEHUyyyd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0D4xXog6VW0qTZ3v7SGELqiFBuoYNmPIOBeQWgb+iq3JsnPfgupcrF7WiGpoYiDv7NDwIossQbo9QwgGAe39W2PAYXHZKcO7ncutXP7A++9g/FZIdIfrzKrsurHOIanmUoDm+MVdkwxYmv8gqSDVSjdWGYAeB66BEN1ulx2DEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSaQ1/D4; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706052722; x=1737588722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0XmyUjs6d6Sl0NxYVW+fP7dKeguSeFwbe/GEHUyyyd0=;
  b=aSaQ1/D4yEAzUM1+QvPdXywcw3rqXBQB99zsq5Q6mtGVuNextVBNjueU
   pnsJoNjnrRgvfPzCVZu7Y9qAxbhiKwb1I+5X/FFDVIBeyHgQL/U0xRxW7
   sVPsswsIfdC5/lN4qOIJ5eOMYKsm7EUmKaxpksulroJh0LzSNXlNlvHWd
   P3H0tBmRUlhHr5iG3RcYlM4QMURPBzWw45d+9zMGTr+UrhjDNMt7bgkd4
   /4kXfPUbXow4EMKW6m+b9wFW+KNvxTTnmZrv68wG6+Qhs6XSYBsNbfm7u
   mx6W769suncCLKAI/xVn7xh/oQw7Rl5MYFuuvy+w57M96yPxZtmXfbTnG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400552149"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400552149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 15:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909469407"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="909469407"
Received: from gkon-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.41.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 15:31:57 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-net 0/2] Fixes for iavf reset path
Date: Tue, 23 Jan 2024 16:31:38 -0700
Message-Id: <20240123233140.309522-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixes for iavf's reset issues that can happen in the early
states (before configuring IRQs, queues, ..etc).

Ahmed Zaki (2):
  iavf: fix reset in early states
  iavf: allow an early reset event to be processed

 drivers/net/ethernet/intel/iavf/iavf_main.c    | 11 +++++++++++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c    | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.34.1


