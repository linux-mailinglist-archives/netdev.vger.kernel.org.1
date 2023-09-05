Return-Path: <netdev+bounces-32163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7D79328B
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 01:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639922811F4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 23:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D953101EA;
	Tue,  5 Sep 2023 23:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF20DDC2
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:28:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DE39E;
	Tue,  5 Sep 2023 16:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693956531; x=1725492531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0wpZ4uEiyvX8GLZIB6P9f6saFvhcvQ+D5/9/Acf/xw4=;
  b=Cg0zXQqBfsHkub+HcCoJ7GPREZyB0V0udhlIct9NxaFSp/REwtOi8yk7
   vvg2jP2smuTdcUzdFBZlGdco2/6iRjJyIXzGzp2R6KW7/F//so/2OCZVN
   sMEM91qaKOWWsNyv2t5oSU78HZHFyRY4hs/TzZdWPDnX+GJroXeAWAmu3
   vyh9DUXiubzMFKByA/7zGP8Rnk/hmQInW8nr1khfUhGWHUUJUZXXLgL6O
   hLXJHyaJ78wVpBJSDE7hdReI0Cuk+Eu6Eo7etOvK/WMLmLJwDDLT535Yp
   0nEtmxVJ0kI3CfTqHGtI27++1/VTn9JJovGXt5xo5Ud/x3IElFGjl8uHp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379643885"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="379643885"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 16:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="744448396"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="744448396"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2023 16:28:47 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: kuba@kernel.org,
	jiri@resnulli.us,
	jonathan.lemon@gmail.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	poros@redhat.com,
	mschmidt@redhat.com,
	netdev@vger.kernel.org,
	linux-clk@vger.kernel.org,
	bvanassche@acm.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next 0/4] dpll: add phase offset and phase adjust
Date: Wed,  6 Sep 2023 01:26:06 +0200
Message-Id: <20230905232610.1403647-1-arkadiusz.kubalewski@intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This RFC is to start discussion over extending dpll interface
with possibility to:
- read a phase offset between signals on pin and dpll,
- adjust a phase of pin's signal.

The RFC is based on latest version of dpll interface submitted for
net-next [1].

[1] https://lore.kernel.org/netdev/20230824213132.827338-1-vadim.fedorenko@linux.dev/

Arkadiusz Kubalewski (4):
  dpll: docs: add support for pin signal phase offset/adjust
  dpll: spec: add support for pin-dpll signal phase offset/adjust
  dpll: netlink/core: add support for pin-dpll signal phase
    offset/adjust
  ice: dpll: implement phase related callbacks

 Documentation/driver-api/dpll.rst         |  53 ++++-
 Documentation/netlink/specs/dpll.yaml     |  33 +++-
 drivers/dpll/dpll_netlink.c               |  99 +++++++++-
 drivers/dpll/dpll_nl.c                    |   8 +-
 drivers/dpll/dpll_nl.h                    |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c | 224 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
 include/linux/dpll.h                      |  18 ++
 include/uapi/linux/dpll.h                 |   8 +-
 9 files changed, 443 insertions(+), 12 deletions(-)

-- 
2.38.1


