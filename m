Return-Path: <netdev+bounces-28243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CA877EB7D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE7C281CBD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97ED19887;
	Wed, 16 Aug 2023 21:14:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C3D50F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:14:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4D128
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692220437; x=1723756437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ETi709ZU8uOkILvy1KTc7FZD079ma/yVICfd+9BpC24=;
  b=WQWXzWCLRTSY1HP4ag+wEaglvlZI5lyWCulfieBqfPaSF+wE2+ujGqNi
   0jFitZmEv9m7+9bdpe8lgrj7ZXHA6bbCzx9o5RTlZpzBkW+000PrCfIgM
   57ZMHzHwBtasr8dYj6Zgppli1ZhceOF4Oc4V56JX1jv+ZBIN61DWvYpQ0
   P4/u8mrNOAvrAnGhsIxhozHitdQIpONX9B93JzxtsxfhrVupBpUSgC8OL
   9bIbtg0vSGrti1u16Pxjkt+Hkh4gs6BO1OroCytNY8cdCFPcfYs3nGb6x
   hyd4MJb1SSyzVdx6ULI05IN7tj9FdLabkMy1EtkNkaLbGE/G5rC1irwcu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352223484"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="352223484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 14:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763765532"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="763765532"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 14:13:56 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com,
	larysa.zaremba@intel.com,
	keescook@chromium.org,
	gustavoars@kernel.org
Subject: [PATCH net-next 0/3][pull request] virtchnl: fix fake 1-elem arrays
Date: Wed, 16 Aug 2023 14:06:54 -0700
Message-Id: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexander Lobakin says:

6.5-rc1 started spitting warning splats when composing virtchnl
messages, precisely on virtchnl_rss_key and virtchnl_lut:

[   84.167709] memcpy: detected field-spanning write (size 52) of single
field "vrk->key" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1095
(size 1)
[   84.169915] WARNING: CPU: 3 PID: 11 at drivers/net/ethernet/intel/
iavf/iavf_virtchnl.c:1095 iavf_set_rss_key+0x123/0x140 [iavf]
...
[   84.191982] Call Trace:
[   84.192439]  <TASK>
[   84.192900]  ? __warn+0xc9/0x1a0
[   84.193353]  ? iavf_set_rss_key+0x123/0x140 [iavf]
[   84.193818]  ? report_bug+0x12c/0x1b0
[   84.194266]  ? handle_bug+0x42/0x70
[   84.194714]  ? exc_invalid_op+0x1a/0x50
[   84.195149]  ? asm_exc_invalid_op+0x1a/0x20
[   84.195592]  ? iavf_set_rss_key+0x123/0x140 [iavf]
[   84.196033]  iavf_watchdog_task+0xb0c/0xe00 [iavf]
...
[   84.225476] memcpy: detected field-spanning write (size 64) of single
field "vrl->lut" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1127
(size 1)
[   84.227190] WARNING: CPU: 27 PID: 1044 at drivers/net/ethernet/intel/
iavf/iavf_virtchnl.c:1127 iavf_set_rss_lut+0x123/0x140 [iavf]
...
[   84.246601] Call Trace:
[   84.247228]  <TASK>
[   84.247840]  ? __warn+0xc9/0x1a0
[   84.248263]  ? iavf_set_rss_lut+0x123/0x140 [iavf]
[   84.248698]  ? report_bug+0x12c/0x1b0
[   84.249122]  ? handle_bug+0x42/0x70
[   84.249549]  ? exc_invalid_op+0x1a/0x50
[   84.249970]  ? asm_exc_invalid_op+0x1a/0x20
[   84.250390]  ? iavf_set_rss_lut+0x123/0x140 [iavf]
[   84.250820]  iavf_watchdog_task+0xb16/0xe00 [iavf]

Gustavo already tried to fix those back in 2021[0][1]. Unfortunately,
a VM can run a different kernel than the host, meaning that those
structures are sorta ABI.
However, it is possible to have proper flex arrays + struct_size()
calculations and still send the very same messages with the same sizes.
The common rule is:

elem[1] -> elem[]
size = struct_size() + <difference between the old and the new msg size>

The "old" size in the current code is calculated 3 different ways for
10 virtchnl structures total. Each commit addresses one of the ways
cumulatively instead of per-structure.

I was planning to send it to -net initially, but given that virtchnl was
renamed from i40evf and got some fat style cleanup commits in the past,
it's not very straightforward to even pick appropriate SHAs, not
speaking of automatic portability. I may send manual backports for
a couple of the latest supported kernels later on if anyone needs it
at all.

[0] https://lore.kernel.org/all/20210525230912.GA175802@embeddedor
[1] https://lore.kernel.org/all/20210525231851.GA176647@embeddedor

The following are changes since commit 950fe35831af0c1f9d87d4105843c3b7f1fbf09b:
  Merge branch 'ipv6-expired-routes'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Alexander Lobakin (3):
  virtchnl: fix fake 1-elem arrays in structs allocated as `nents + 1` -
    1
  virtchnl: fix fake 1-elem arrays in structures allocated as `nents +
    1`
  virtchnl: fix fake 1-elem arrays for structures allocated as `nents`

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   9 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_client.c |   4 +-
 drivers/net/ethernet/intel/iavf/iavf_client.h |   2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  75 +++++------
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
 include/linux/avf/virtchnl.h                  | 127 +++++++++++-------
 7 files changed, 124 insertions(+), 101 deletions(-)

-- 
2.38.1


