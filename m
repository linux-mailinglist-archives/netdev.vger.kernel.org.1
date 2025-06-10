Return-Path: <netdev+bounces-195942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41918AD2D96
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038F216FEC7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C225F967;
	Tue, 10 Jun 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBZ2pXA8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19622A7E9;
	Tue, 10 Jun 2025 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535175; cv=none; b=GHF5vjwPXFzdDPpuIFVTfySH0Xf/R1oM+s7Ko0yBaSWsPeWimX7XRy8tLBT3OYj3P2s5Hysm5Se8UTHlRpoHdPQHlQcYH3In+PgqJ1CYw8dyoZRsSvJ2nQ9la+N3G7rM9UFFVM9oz/oXIbkGWEm2+m6eOm+peTgqa0yj6IW5/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535175; c=relaxed/simple;
	bh=BYCNhUItMwlAi9JwxLtjlPoN9bZQoeg3M40zw0F2pLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEU6WM7aVdzSxy7CZ7gBIRgyI6LggnvYedd9t8hYpWjEUYKqnv6v76CP2vy39E2MSAINAS/AdumIweAYdyWQ4yYUQu71iFwQ8Ya5xXsF9p/Mi1pdL82A9/IgE45L8EDAcwMtRrr6YuL25lzebkPuukkFgHy2mFb11GlqqMKVJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBZ2pXA8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749535174; x=1781071174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BYCNhUItMwlAi9JwxLtjlPoN9bZQoeg3M40zw0F2pLs=;
  b=MBZ2pXA8qMiqwyHVXYajt8WVYaiy1I3UhRalAyBstEgBmM3oh7LDa8Pv
   2yYBkC0gTlDMzOd8IDd9fd1TZrkMrqz3nE9/70EFotltxYVROIVHmz/7Q
   EvP2WsGIOSYZJF1vuNaw3315tDfh9zVzsbxY6uV2GV/h6r4txQ6ZBToy+
   tzu0/zAcbG10kihP228UUZWZeEa7S+OLV+HuiYWXuy5hTpONG9rm+t3jU
   Zlry5AgnwXNb6hzazIwMIKvJbUobki97RupaFw+0u3iPPiDw6tE6XVfZi
   MEyu68SUzRnhAHh1bpcAy+XFNzY29hvNeKRDkroz0u03pkSh7gpu8CemD
   A==;
X-CSE-ConnectionGUID: CZ6t1xLJTVSxeGuStr5/RA==
X-CSE-MsgGUID: 0t6/kZb+RQebEVSfDpDdBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="54259734"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="54259734"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 22:59:33 -0700
X-CSE-ConnectionGUID: EyuGwZh2Sya+M30xd/4YVA==
X-CSE-MsgGUID: xERKnBY6RpyTmuPKsAAnNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147241727"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jun 2025 22:59:29 -0700
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
Subject: [PATCH net-next v5 0/3]  dpll: add all inputs phase offset monitor
Date: Tue, 10 Jun 2025 07:53:35 +0200
Message-Id: <20250610055338.1679463-1-arkadiusz.kubalewski@intel.com>
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
Once enabled the phase offset measurements for the input shall be returned
in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.

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

 Documentation/driver-api/dpll.rst             |  18 ++
 Documentation/netlink/specs/dpll.yaml         |  24 +++
 drivers/dpll/dpll_netlink.c                   |  69 ++++++-
 drivers/dpll/dpll_nl.c                        |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 194 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   8 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 include/linux/dpll.h                          |   8 +
 include/uapi/linux/dpll.h                     |  12 ++
 12 files changed, 385 insertions(+), 6 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.38.1


