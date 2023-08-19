Return-Path: <netdev+bounces-29099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A748F7819D5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617D4281AE6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61C6AB1;
	Sat, 19 Aug 2023 13:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920346B1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:52:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4926AFD
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692453132; x=1723989132;
  h=from:to:cc:subject:date:message-id;
  bh=LgBTQjLoGAIGJfx4euGq4bhsXXYEwJRUIPf9oNcVRj0=;
  b=kjfukgZaug8ZbIf6L17uA3OMZ7rrOsKevGpSRiPrGApwPUUnsIuEo1cK
   3QUogSiOZaXHxIu8V67Mgw3YcL4SCvx8l0Zwrnd/o3Gtf+Gch46kPXmhf
   Nu0tsONll1qgM/WntQk8/sUc1Nl1jA7ad+ybtBdBJ6j4DSKtzkOtMUhDe
   r9gKFKuyQ0voC6PiTCXEHyUKE1sy6OKczYmXVtVGOv4aHLqyDqoD+oFwT
   n/2kkinigRDl/VicGOrrvuDFj9JLh33SWln1I5KLd0TEOMb2EkM2bBnRJ
   pdVKUE9H8l60pEcfcY7pURCyiipk6drTWZ4JVzTWW4YKXDzAcDUeHoyBT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="363463616"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="363463616"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 06:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="805452173"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="805452173"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2023 06:52:08 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Cc: sasha.neftin@intel.com,
	bcreeley@amd.com,
	horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	muhammad.husaini.zulkifli@intel.com,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	naamax.meir@linux.intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net v4 0/2] Enhance the tx-usecs coalesce setting implementation
Date: Sat, 19 Aug 2023 21:50:49 +0800
Message-Id: <20230819135051.29390-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The current tx-usecs coalesce setting implementation in the driver code is
improved by this patch series. The implementation of the current driver
code may have previously been a copy of the legacy code i210.

Patch 1:
Allow the user to see the tx-usecs coalesce setting's current value when
using the ethtool command. The previous value was 0.

Patch 2:
Give the user the ability to modify the tx-usecs coalesce setting's value.
Previously, it was restricted to rx-usecs.

V3 -> V4:
- Implement the helper function, as recommended by Brett Creely.
- Fix typo in cover letter.

V2 -> V3:
- Refactor the code, as Simon suggested, to make it more readable.

V1 -> V2:
- Split the patch file into two, like Anthony suggested.

Muhammad Husaini Zulkifli (2):
  igc: Expose tx-usecs coalesce setting to user
  igc: Modify the tx-usecs coalesce setting

 drivers/net/ethernet/intel/igc/igc_ethtool.c | 58 +++++++++++++-------
 1 file changed, 37 insertions(+), 21 deletions(-)

--
2.17.1


