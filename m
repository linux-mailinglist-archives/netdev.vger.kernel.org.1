Return-Path: <netdev+bounces-193076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D116AC26BE
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1483A7CEB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBFC293B67;
	Fri, 23 May 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvkjHFJC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF821B9F5;
	Fri, 23 May 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015325; cv=none; b=LQgkX4AdDqhotOzMkz61OOmOkcyNqxOs8mOkHNYeqwEehGqS8FridTW9bi5/rpNNnQwfaj0HR8HtkLBo9o3E55k5HI+Vklx9VPYcrseE4Og++F96hFP+mMHJ+73YtFymeEZ3VgQbg0m/0JIuHC/aTUjGcO5ZsWVHWYOtOh+jVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015325; c=relaxed/simple;
	bh=I/8nEbZdDKb5iEP+4krl9s5DuMYHU9jALA6PtV9CAmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g30LtU+3pqsjuGoeORbpr+oSmjeEMdIJSIjKNFZOqQfwdmn/IFaeKuCvSGfUt4MiM19nS1JDWOIkZGDV8A2l16TTlf6I0C9huFpRmgST3R6KoLpJ6DxcTMIfhKqeRZEg5UltYq/jDP2CJX/MpmUpt67KO3ByV6+97DAUBhDboOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvkjHFJC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748015323; x=1779551323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I/8nEbZdDKb5iEP+4krl9s5DuMYHU9jALA6PtV9CAmA=;
  b=XvkjHFJC0NcNdx2oyZLVBVpxfMa35XYaeuFaZ/oyS/WbMGzQxa+lvgkc
   UG/hh3ICl/8qIrPtfYQ/hKUFqHoOhBWL0KyixSJ1/xs9FksQ/1XKjXd71
   gt8oTcaReNonB55WeGPTN0/p70zcmRo/N97oRsorI3Q9YgZF58loTzCrz
   12puYsNeV7CgAGe3buuBen4PbhIhQEYp0cpVnzVOvD0hen2NO1lJUsJQr
   x7LD7FoaiQ+pBahABQt0tCFwJplfL7dIa/fsxwz5MzOUaKuUbVYDyVztP
   KbWo6bzSxbXvVLAbzpwxOTNIcQd029e5hE83sYL9sWlgz7hvGGt9f681s
   g==;
X-CSE-ConnectionGUID: 63ehHIr6T9CpN4fSkT0X9Q==
X-CSE-MsgGUID: mb8qG4bsRdqD4PCwr8ThhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49958818"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49958818"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 08:48:42 -0700
X-CSE-ConnectionGUID: xzXPFbmHTNCkrBbRevoqjA==
X-CSE-MsgGUID: mZisGr7mQe6xVU9d+kMRVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141036206"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa009.jf.intel.com with ESMTP; 23 May 2025 08:48:38 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 0/3]  dpll: add all inputs phase offset monitor
Date: Fri, 23 May 2025 17:42:21 +0200
Message-Id: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpll device level feature: phase offset monitor.

Phase offset measurement is typically performed against the current active
source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
the capability to monitor phase offsets across all available inputs.
The attribute and current feature state shall be included in the response
message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
In such cases, users can also control the feature using the
``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
values for the attribute.

Implement feature support in ice driver for dpll-enabled devices.

Verify capability:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[{'clock-id': 4658613174691613800,
  'id': 0,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'type': 'eec'},
 {'clock-id': 4658613174691613800,
  'id': 1,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'phase-offset-monitor': 'disable',
  'type': 'pps'}]

Enable the feature:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do device-set --json '{"id":1, "phase-offset-monitor":"enable"}'

Verify feature is enabled:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[
 [...]
 {'capabilities': {'all-inputs-phase-offset-monitor'},
  'clock-id': 4658613174691613800,
  'id': 1,
 [...]
  'phase-offset-monitor': 'enable',
 [...]]


Arkadiusz Kubalewski (3):
  dpll: add phase-offset-monitor feature to netlink spec
  dpll: add phase_offset_monitor_get/set callback ops
  ice: add phase offset monitor for all PPS dpll inputs

 Documentation/driver-api/dpll.rst             |  16 ++
 Documentation/netlink/specs/dpll.yaml         |  24 +++
 drivers/dpll/dpll_netlink.c                   |  69 ++++++-
 drivers/dpll/dpll_nl.c                        |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 191 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 include/linux/dpll.h                          |   8 +
 include/uapi/linux/dpll.h                     |  12 ++
 12 files changed, 379 insertions(+), 5 deletions(-)


base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.38.1


