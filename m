Return-Path: <netdev+bounces-39949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8E7C4FCC
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A539E1C20C1C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E51DA42;
	Wed, 11 Oct 2023 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwzMe0NX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B31CFBE;
	Wed, 11 Oct 2023 10:15:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB359D;
	Wed, 11 Oct 2023 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697019322; x=1728555322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pNva1qBYGCKL7fsDb7y9EZtGrJ70CECWmkZU6WgokUw=;
  b=dwzMe0NXr+YI1C+RxmlT8EOFX3G6xgQPX1VkEZ+Ucb7wDeJAmA3WxAlq
   aFmA8OuXJOJjCWhDYqjwGFKbcAVKyVErWdrKFte8BLE3Ug/e5qx1ym3mP
   h0B5ALSl8ZvcILF3Fp+QI3wBsoyYJx9MZAt7a/xlud8T5m5oYlBE38jvd
   8UpgYlZUJPVv0tY1h4C9bppeR7N/NBfGBkro2Y65hykoI1bMxXbjQNln8
   N5poIOP4+Zghs6K8La47+AK6KUaC5ZiMVaZmIpfHrASOT5nIUIK7kUnHu
   Z4Xjkt5eLyXxXS7t/nGFx17XtVhNg3RxyxovBXTCEfjUZFHO5oB7VsqqG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415672135"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415672135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897575858"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897575858"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2023 03:13:32 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v5 0/5] dpll: add phase-offset and phase-adjust
Date: Wed, 11 Oct 2023 12:12:31 +0200
Message-Id: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve monitoring and control over dpll devices.
Allow user to receive measurement of phase difference between signals
on pin and dpll (phase-offset).
Allow user to receive and control adjustable value of pin's signal
phase (phase-adjust).

v4->v5:
- rebase series on top of net-next/main, fix conflict - remove redundant
  attribute type definition in subset definition

v3->v4:
- do not increase do version of uAPI header as it is not needed (v3 did
  not have this change)
- fix spelling around commit messages, argument descriptions and docs
- add missing extack errors on failure set callbacks for pin phase
  adjust and frequency
- remove ice check if value is already set, now redundant as checked in
  the dpll subsystem

v2->v3:
- do not increase do version of uAPI header as it is not needed

v1->v2:
- improve handling for error case of requesting the phase adjust set
- align handling for error case of frequency set request with the
approach introduced for phase adjust


Arkadiusz Kubalewski (5):
  dpll: docs: add support for pin signal phase offset/adjust
  dpll: spec: add support for pin-dpll signal phase offset/adjust
  dpll: netlink/core: add support for pin-dpll signal phase
    offset/adjust
  ice: dpll: implement phase related callbacks
  dpll: netlink/core: change pin frequency set behavior

 Documentation/driver-api/dpll.rst         |  53 +++++-
 Documentation/netlink/specs/dpll.yaml     |  30 +++
 drivers/dpll/dpll_netlink.c               | 188 +++++++++++++++++-
 drivers/dpll/dpll_nl.c                    |   8 +-
 drivers/dpll/dpll_nl.h                    |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c | 220 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
 include/linux/dpll.h                      |  18 ++
 include/uapi/linux/dpll.h                 |   6 +
 9 files changed, 517 insertions(+), 18 deletions(-)

-- 
2.38.1


