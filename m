Return-Path: <netdev+bounces-29806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA01784CCD
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76194281167
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47534CF0;
	Tue, 22 Aug 2023 22:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B120183
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 22:23:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968DFCD7
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692743009; x=1724279009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U8B5mZiWkIj+G3SIlnC8kcSBulTyy17YoiEkPxhTPbE=;
  b=dZ94rOYvNjcnWb6ZeuC7meiBffk2NTubnNvhi5wAg2DcPixUBbQn5Sv2
   4xkgQQh9lxBR32e1WJjLhEBe5of+lU+0oKZzV6MQ9xEBcy4IcGRfZGdZe
   BPZi/Syj+HR79Dfq7g6c+PFGERWUSAuxr4wsON//QbGNjIZP9E+1ZKU1Z
   rWnVdDJOyM3BrGRlhDV4c5hDd1D3q05e85uo7FM9hiy0Rnxhm3HO+d32u
   DwNY3V7tsegzA8rdfRM63V1itIdmFG2ZO8165vWS5rVTFX4NnFmX9YMFN
   83alQ+6VlBvGz4TAOFx1m9uV+cstC4mXd/Be8vvKQ+H3B5JWc944cSIi4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364192293"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364192293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 15:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="729976444"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="729976444"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2023 15:23:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	sasha.neftin@intel.com,
	horms@kernel.org,
	bcreeley@amd.com,
	muhammad.husaini.zulkifli@intel.com
Subject: [PATCH net v3 0/2][pull request] igc: Enhance the tx-usecs coalesce setting implementation
Date: Tue, 22 Aug 2023 15:16:18 -0700
Message-Id: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
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

Muhammad Husaini Zulkifli says:

The current tx-usecs coalesce setting implementation in the driver code is
improved by this patch series. The implementation of the current driver
code may have previously been a copy of the legacy code i210.

Patch 1:
Allow the user to see the tx-usecs coalesce setting's current value when
using the ethtool command. The previous value was 0.

Patch 2:
Give the user the ability to modify the tx-usecs coalesce setting's value.
Previously, it was restricted to rx-usecs.
---
v3:
- Implement the helper function, as recommended by Brett Creeley.
- Fix typo in cover letter.

v2: https://lore.kernel.org/netdev/20230801172742.3625719-1-anthony.l.nguyen@intel.com/
- Refactor the code, as Simon suggested, to make it more readable.

v1: https://lore.kernel.org/netdev/20230728170954.2445592-1-anthony.l.nguyen@intel.com/

The following are changes since commit 99b415fe8986803ba0eaf6b8897b16edc8fe7ec2:
  tg3: Use slab_build_skb() when needed
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Muhammad Husaini Zulkifli (2):
  igc: Expose tx-usecs coalesce setting to user
  igc: Modify the tx-usecs coalesce setting

 drivers/net/ethernet/intel/igc/igc_ethtool.c | 58 +++++++++++++-------
 1 file changed, 37 insertions(+), 21 deletions(-)

-- 
2.38.1


