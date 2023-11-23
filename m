Return-Path: <netdev+bounces-50437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C057F5CF0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59F41C20D2C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C821352;
	Thu, 23 Nov 2023 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu9NeIXS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140AD53;
	Thu, 23 Nov 2023 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700736811; x=1732272811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZZsOwYqz6d9+TBHIReXwuABzFgsRERIxDxueQpDcL3I=;
  b=Lu9NeIXS2dRUnt0lk443PA/K+L4GeZB7Asow12LEaMOJsPsXN8T3eJ7l
   VWyoLtcnCxd3dBkcxi793TkqMdATGCgguKFOrjZhFid/1Js8378i6xikL
   9d+AECtVTSbLLmea8aa3UlMUY4NTJbNyTz6LTjR/f2UIUXU16bN6GJoW5
   sBxFvFhQo6rcfXLyNmsDV2M+Rizpg4we5GRDxIrtfDwmVUXjRR1fKU6Bg
   0NzbjLZwycg68Dvx18d9zc0GVBt11K3e4hu/2+BnN0+3nvjF/KSQzzM5j
   lD1La9/n0F1maPiBWLs4pDzSZLcUcmroxCyU+zug678PBcyiYw8juesua
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458741813"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="458741813"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837764632"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="837764632"
Received: from mmichali-devpc.igk.intel.com (HELO localhost.localdomain) ([10.211.235.239])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2023 02:52:59 -0800
From: Michal Michalik <michal.michalik@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com,
	pabeni@redhat.com,
	poros@redhat.com,
	milena.olech@intel.com,
	mschmidt@redhat.com,
	linux-clk@vger.kernel.org,
	bvanassche@acm.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH RFC net-next v4 0/2] selftests/dpll: DPLL subsystem integration tests
Date: Thu, 23 Nov 2023 05:52:41 -0500
Message-Id: <20231123105243.7992-1-michal.michalik@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recently merged common DPLL interface discussed on a mailing list[1]
is introducing new, complex subsystem which requires proper integration
testing - this patchset adds such a framework, as well as the initial
test cases. Framework does not require neither any special hardware nor
any special system architecture.

To properly test the DPLL subsystem this patch adds fake DPLL devices
and its pins to netdevsim. Two DPLL devices are added: EEC and PPS.
There are also common pins for each device: PPS and GNSS. Additionally
each netdevsim port register RCLK (recovered clock) pin for itself. That
allow us to check mutliple scenarios which might be problematic in real
implementations (like different ordering etc.)

Patch adds few helper scripts, which are:
1) tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
    Script is checking for all dependencies, creates temporary
    environment, installs required libraries and run all tests - can be
    used standalone
2)
tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py˙
    Library for easier ynl use in the pytest framework - can be used
    standalone

[1] https://lore.kernel.org/netdev/169494842736.21621.10730860855645661664.git-patchwork-notify@kernel.org/

Changelog:
v3 -> v4:
- return from nsim_dpll_init_owner directly (removed goto)
- fix too long line (was over 80 chars)
- fix uninitialized function returns after goto
- move kfree(name) in nsim_rclk_init to end to avoid double free
- removed unused devid left after refactoring
- rebased on top of main

v2 -> v3:
- updated the cover letter
- moved framework from selftests/dpll to
  selftests/drivers/net/netdevsim/dpll/
- added `nsim_` prefixes to functions and structs
- dropped unecessary casts
- added necessary debugfs entries
- added random clock id
- improved error patchs on init
- removed separate dpll.h header
- removed unnecesary UAPI dpll header import
- changed struct names
- changed private data structs to be embedded
- moved common pin init to device init
- added netdev_dpll_pin_set/clear()

v1 -> v2:
- moved from separate module to implementation in netdevsim

Michal Michalik (2):
  netdevsim: implement DPLL for subsystem selftests
  selftests/dpll: add DPLL system integration selftests

 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/Makefile                |   2 +-
 drivers/net/netdevsim/dev.c                   |  21 +-
 drivers/net/netdevsim/dpll.c                  | 489 ++++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  10 +
 drivers/net/netdevsim/netdevsim.h             |  44 ++
 tools/testing/selftests/Makefile              |   1 +
 .../drivers/net/netdevsim/dpll/Makefile       |   8 +
 .../drivers/net/netdevsim/dpll/__init__.py    |   0
 .../drivers/net/netdevsim/dpll/config         |   2 +
 .../drivers/net/netdevsim/dpll/consts.py      |  40 ++
 .../drivers/net/netdevsim/dpll/dpll_utils.py  |  94 ++++
 .../net/netdevsim/dpll/requirements.txt       |   3 +
 .../net/netdevsim/dpll/run_dpll_tests.sh      |  75 +++
 .../drivers/net/netdevsim/dpll/test_dpll.py   | 376 ++++++++++++++
 .../net/netdevsim/dpll/ynlfamilyhandler.py    |  49 ++
 16 files changed, 1213 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/netdevsim/dpll.c
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/config
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/consts.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/dpll_utils.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/requirements.txt
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/test_dpll.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py


base-commit: 750011e239a50873251c16207b0fe78eabf8577e
-- 
2.39.3


