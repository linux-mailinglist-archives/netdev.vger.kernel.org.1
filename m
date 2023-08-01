Return-Path: <netdev+bounces-23007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF176A620
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8093C1C20DCC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2A627;
	Tue,  1 Aug 2023 01:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2367E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:16:46 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C56170A
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690852604; x=1722388604;
  h=from:to:cc:subject:date:message-id;
  bh=hqTEmQmQZivnh9yOJRa23OoxT8qHeWUmBfKq7QvbqQY=;
  b=A4OE1txXmMMyvU7NOv7fNeLa4ybGWCvjkR8XQqQF9FLUkSx//+iIXrx9
   OC8nGnPf46A4t5i/pqKiop2WaCEG3NiUgpsK38GETRSGZ/+9kxvruyH+l
   l+Mj2W4jjsV2qLpPlR7IUAOivpD5cYqjnfWz0U/UaRwYNPOe3fqbEs11M
   g8Gd2kozhkKgaCiIVCvUpZE9AB/LvVE2v3X2NqPU+LxPxe6GR1CrrMiFn
   jOyva/LNGw5eGCHZRIFxL6D6qRQW+GR7OTUaaPhmjdOZxT6lxJR2vu2w5
   ItoVEPUUaGdHX4GfHKXW547/SR5f69dDezLjuG0EngL5uKDa/pPpBnKGi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372792713"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372792713"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798458541"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798458541"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 18:16:39 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	muhammad.husaini.zulkifli@intel.com,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	naamax.meir@linux.intel.com,
	anthony.l.nguyen@intel.com
Subject: [PATCH iwl-net v3 0/2] Enhance the tx-usecs coalesce setting implementation
Date: Tue,  1 Aug 2023 09:15:16 +0800
Message-Id: <20230801011518.25370-1-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
Allow the user to see the tx-usecs colease setting's current value when
using the ethtool command. The previous value was 0.

Patch 2:
Give the user the ability to modify the tx-usecs colease setting's value.
Previously, it was restricted to rx-usecs.

V2 -> V3:
- Refactor the code, as Simon suggested, to make it more readable.

V1 -> V2:
- Split the patch file into two, like Anthony suggested.

Muhammad Husaini Zulkifli (2):
  igc: Expose tx-usecs coalesce setting to user
  igc: Modify the tx-usecs coalesce setting

 drivers/net/ethernet/intel/igc/igc_ethtool.c | 46 +++++++++++++++-----
 1 file changed, 34 insertions(+), 12 deletions(-)

--
2.17.1


