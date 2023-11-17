Return-Path: <netdev+bounces-48777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4C7EF7A7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC88B209BC
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98322374CB;
	Fri, 17 Nov 2023 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJerZlsF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CA90;
	Fri, 17 Nov 2023 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700247916; x=1731783916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ojXatZcyWVDBNEjZqyuSgcR+G6zuPa0I4GRc4/in0jA=;
  b=iJerZlsFwkO3i8JUcR8MbYCGBDiPd8FDzfMhnYbfyyAnmsYDcgcBJxZ3
   TdfB+DNIN7xuniR0IJt+oQjddEoQrCCFGwWqMkuywIcxUYYxk7EA1+9n5
   BkUFaVBEYcn7FneaSSPk9Bhd1+rHwzYFmlTBI+mye5UA8JReCbVWCzLma
   Ay6tX91q/SL/u6UdKLX66p7CJ0lHW9RdmQ+oDGDaQL22xv+iEjHitNmWo
   azcB2m5qGnAhdTIxwYBhk2MsQfOpKUQmYPVD3rPzK1WpVjSqSuheo1Bcx
   y3+5ykpnJnzKdqu7owi1NHT/auWPfrWRasy1eITJffVVv5vVqVKJ87J/u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="381742112"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381742112"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 11:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="800577773"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="800577773"
Received: from mmichali-devpc.igk.intel.com ([10.211.235.239])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2023 11:05:12 -0800
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
Subject: [PATCH RFC net-next v3 0/2] selftests/dpll: DPLL subsystem integration tests
Date: Fri, 17 Nov 2023 20:05:03 +0100
Message-Id: <20231117190505.7819-1-michal.michalik@intel.com>
X-Mailer: git-send-email 2.9.5
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
2) tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py˙
    Library for easier ynl use in the pytest framework - can be used
    standalone

[1] https://lore.kernel.org/netdev/169494842736.21621.10730860855645661664.git-patchwork-notify@kernel.org/

Changelog:
v2 -> v3:
- updated the cover letter
- moved framework from selftests/dpll to selftests/drivers/net/netdevsim/dpll/
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

 drivers/net/Kconfig                                |   1 +
 drivers/net/netdevsim/Makefile                     |   2 +-
 drivers/net/netdevsim/dev.c                        |  23 +-
 drivers/net/netdevsim/dpll.c                       | 490 +++++++++++++++++++++
 drivers/net/netdevsim/netdev.c                     |  10 +
 drivers/net/netdevsim/netdevsim.h                  |  44 ++
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/drivers/net/netdevsim/dpll/Makefile  |   8 +
 .../drivers/net/netdevsim/dpll/__init__.py         |   0
 .../selftests/drivers/net/netdevsim/dpll/config    |   2 +
 .../selftests/drivers/net/netdevsim/dpll/consts.py |  40 ++
 .../drivers/net/netdevsim/dpll/dpll_utils.py       |  94 ++++
 .../drivers/net/netdevsim/dpll/requirements.txt    |   3 +
 .../drivers/net/netdevsim/dpll/run_dpll_tests.sh   |  75 ++++
 .../drivers/net/netdevsim/dpll/test_dpll.py        | 376 ++++++++++++++++
 .../drivers/net/netdevsim/dpll/ynlfamilyhandler.py |  49 +++
 16 files changed, 1216 insertions(+), 2 deletions(-)
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

-- 
2.9.5

base-commit: 18de1e517ed37ebaf33e771e46faf052e966e163

