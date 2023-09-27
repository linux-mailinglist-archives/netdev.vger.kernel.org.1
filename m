Return-Path: <netdev+bounces-36490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C457AFFF4
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9C01A280E84
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027921101;
	Wed, 27 Sep 2023 09:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872B1C2BA
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 09:27:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B81AC;
	Wed, 27 Sep 2023 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695806843; x=1727342843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5YlCDla9H8pAw0C4B5gYO+TrDwc7pWqE1EPlo/uCT1A=;
  b=gP0tER58Na5ZdLi1biHycEYadU1VZhisfVeP3AsEwJbJOt0mz2yavi1M
   CgaBpG+fbCjFS8IVxskWAi1rpKdcX3k22UWF+qecUPFQZQDMBxuZdsWAz
   vp7lyy7vkf8kqNyCGWWmn/ouuWXzW3tBv3TxgekZwWSvkiFrVE3jdHeER
   YDMN/ksP/X5DlhXunLAB9QRgkkunHlw0jLgh/C8FAlHDhFgPESzaY0B1D
   9VXyu4VB1ay6kXXPJ2i0GorRf1v2Q8JXPVyOw3NEqom+bbst/PT3ELpP9
   I9oFAJ1bOrCAb5Od8dcNWQ6szLsCkfYvuVlAzJhLIqbbV3dQlKG+LyeUj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412692315"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412692315"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 02:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778479224"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778479224"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 02:27:10 -0700
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
Subject: [PATCH net-next 0/4] dpll: add phase-offset and phase-adjust
Date: Wed, 27 Sep 2023 11:24:31 +0200
Message-Id: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
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

Improve monitoring and control over dpll devices.
Allow user to receive measurement of phase difference between signals on
pin and dpll (phase-offset).
Allow user to receive and control adjustable value of pin's signal
phase (phase-adjust).

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


